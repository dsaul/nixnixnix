# Building a Static Website Package from a Private GitHub Repo with Nix

Here's how to create a Nix package for a static website from a private GitHub repository using ```fetchgitPrivate``` and npm:

## 1. Set Up SSH Authentication

First, configure SSH access for your Nix builds:

```bash
# Create SSH directory for Nix builds
sudo mkdir -p /etc/nix/ssh
sudo chmod 755 /etc/nix/ssh

# Copy your GitHub SSH key
sudo cp ~/.ssh/id_ed25519 /etc/nix/ssh/github_key
sudo chmod 400 /etc/nix/ssh/github_key

# Create SSH config
sudo tee /etc/nix/ssh/config > /dev/null << EOF
Host github.com
  User git
  IdentityFile /etc/nix/ssh/github_key
  IdentitiesOnly yes
  StrictHostKeyChecking no
EOF

# Make sure nixbld users can access these files
sudo chown -R root:nixbld /etc/nix/ssh
```

## 2. Create a Nix Package Definition

Create a file named ```static-website.nix```:

```nix
{ pkgs ? import <nixpkgs> {} }:

let
  # Import the private git fetcher
  fetchgitPrivate = import "${pkgs.path}/pkgs/build-support/fetchgit/private.nix" {
    inherit (pkgs) fetchgit runCommand makeWrapper openssh;
  };
  
  # Fetch the private repository
  src = fetchgitPrivate {
    url = "git@github.com:your-org/your-private-repo.git";
    rev = "abcdef123456789"; # Replace with your commit hash
    sha256 = "sha256-xxxx"; # Replace with the correct hash or use lib.fakeSha256 initially
  };
  
in pkgs.stdenv.mkDerivation {
  pname = "my-static-website";
  version = "1.0.0";
  
  inherit src;
  
  buildInputs = with pkgs; [
    nodejs
    nodePackages.npm
  ];
  
  buildPhase = ''
    # Ensure npm can write to home directory
    export HOME=$TMPDIR
    
    # Install dependencies and build
    npm ci
    npm run build
  '';
  
  installPhase = ''
    # Copy the built website to the output
    mkdir -p $out/share/static-website
    cp -r build/* $out/share/static-website/
    
    # Optionally create a wrapper script to serve the site
    mkdir -p $out/bin
    echo '#!/bin/sh' > $out/bin/serve-static-website
    echo "${pkgs.nodePackages.http-server}/bin/http-server $out/share/static-website" >> $out/bin/serve-static-website
    chmod +x $out/bin/serve-static-website
  '';
  
  meta = with pkgs.lib; {
    description = "Static website built from private GitHub repository";
    license = licenses.mit; # Adjust as needed
  };
}
```

## 3. Build the Package

```bash
# Export SSH environment variables for Nix
export NIX_PATH="ssh-auth-sock=$SSH_AUTH_SOCK:ssh-config-file=/etc/nix/ssh/config:$NIX_PATH"

# Build the package
nix-build static-website.nix
```

## 4. Getting the Correct SHA256

If you don't know the SHA256 hash initially, use:

```nix
sha256 = pkgs.lib.fakeSha256;
```

Nix will fail and show you the correct hash to use.

## 5. Serving the Website

After building, you can serve the website with:

```bash
./result/bin/serve-static-website
```

## Additional Tips

1. **For CI/CD environments**: Store SSH keys securely as secrets
2. **For npm private packages**: Create a ```.npmrc``` file in your repo with appropriate authentication
3. **For reproducible builds**: Consider using ```npm-lock.yaml``` and pinning all Nix dependencies
4. **For deployment**: Add outputs to serve with nginx or create a Docker container 

This approach combines Nix's reproducible builds with secure access to private repositories while maintaining the standard npm build workflow for static websites.

