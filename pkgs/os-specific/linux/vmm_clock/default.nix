{
  stdenv,
  lib,
  fetchFromGitHub,
  kernel,
  kernelModuleMakeFlags,
}:

stdenv.mkDerivation rec {
  pname = "vmm_clock";
  version = "0.2.1";

  src = fetchFromGitHub {
    owner = "voutilad";
    repo = "vmm_clock";
    tag = version;
    hash = "sha256-XYRxrVixvImxr2j3qxBcv1df1LvPRKqKKgegW3HqUcQ=";
  };

  hardeningDisable = [
    "pic"
    "format"
  ];
  nativeBuildInputs = kernel.moduleBuildDependencies;

  extraConfig = ''
    CONFIG_RTC_HCTOSYS yes
  '';

  makeFlags = kernelModuleMakeFlags ++ [
    "DEPMOD=echo"
    "INSTALL_MOD_PATH=$(out)"
    "KERNELRELEASE=${kernel.modDirVersion}"
    "KERNELDIR=${kernel.dev}/lib/modules/${kernel.modDirVersion}/build"
  ];

  meta = with lib; {
    description = "Experimental implementation of a kvmclock-derived clocksource for Linux guests under OpenBSD's hypervisor";
    homepage = "https://github.com/voutilad/vmm_clock";
    license = licenses.gpl2Plus;
    maintainers = with maintainers; [ qbit ];
    platforms = [
      "i686-linux"
      "x86_64-linux"
    ];
  };

  enableParallelBuilding = true;
}
