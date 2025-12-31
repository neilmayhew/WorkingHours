{ mkDerivation, base, cgi, exceptions, lib, optparse-applicative
, terminal-size, time
}:
mkDerivation {
  pname = "WorkingHours";
  version = "1.0";
  src = lib.cleanSource ./.;
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [
    base cgi exceptions optparse-applicative terminal-size time
  ];
  homepage = "https://github.com/neilmayhew/WorkingHours";
  description = "Compute the number of working hours in a given period";
  license = lib.licenses.mit;
  maintainers = with lib.maintainers; [ neilmayhew ];
}
