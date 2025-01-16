let
	pkgs = import <nixpkgs> {};
in 
pkgs.mkShell {
	packages = [
		(pkgs.python312Full.withPackages (python-pkgs: with python-pkgs; [
			# select Python packages here
			pandas
			requests
			pytest
			pylint
			black
			flake8
		]))
	];
}
