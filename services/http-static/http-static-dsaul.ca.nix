# don't use this
# https://discourse.nixos.org/t/serve-sites-from-nginx-with-additional-build-step/31183

# Add this to your configuration.nix
{ config, pkgs, ... }:

{
  # Enable the Nginx web server
  services.nginx = {
    enable = true;

    # Configure a virtual host
    virtualHosts."your-domain.com" = {
      # Path to your static files
      root = "/var/www/your-site";

      # Optional: Configure SSL
      # enableACME = true;
      # forceSSL = true;
    };
  };

  # Create a dedicated user for website updates
  users.users.website-updater = {
    isSystemUser = true;
    createHome = true;
    home = "/var/lib/website-updater";
    group = "nginx";
    shell = pkgs.bash;
    description = "User for updating website from GitHub";
  };

  # Create a service to pull from GitHub and update the site
  systemd.services.update-website = {
    description = "Update website from GitHub";
    serviceConfig = {
      Type = "oneshot";
      User = "website-updater";
      Group = "nginx";
      WorkingDirectory = "/var/www";
      # Ensure SSH directory exists with proper permissions
      ExecStartPre = "${pkgs.bash}/bin/bash -c 'mkdir -p /var/lib/website-updater/.ssh && chmod 700 /var/lib/website-updater/.ssh'";
    };
    path = with pkgs; [ git openssh ];
    script = ''
      # Set up SSH for GitHub
      if [ ! -f /var/lib/website-updater/.ssh/id_ed25519 ]; then
        echo "SSH key not found. Please manually add your SSH key to /var/lib/website-updater/.ssh/"
        exit 1
      fi

      # Ensure GitHub is a known host
      if ! grep -q "github.com" /var/lib/website-updater/.ssh/known_hosts 2>/dev/null; then
        ssh-keyscan github.com >> /var/lib/website-updater/.ssh/known_hosts
      fi

      # Clone or update the repository
      if [ -d /var/www/your-site ]; then
        cd /var/www/your-site
        git pull
      else
        git clone git@github.com:username/your-repo.git /var/www/your-site
      fi

      # Ensure proper permissions
      chown -R website-updater:nginx /var/www/your-site
      chmod -R 755 /var/www/your-site
    '';
  };

  # Set up a timer to periodically update the site
  systemd.timers.update-website = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnBootSec = "5min";
      OnUnitActiveSec = "1h";
    };
  };

  # Open firewall ports
  networking.firewall.allowedTCPPorts = [ 80 443 ];
}
