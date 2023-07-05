import "dart:io";

enum _Lib {
  MKL(
    name: "mkl-2023.1.0",
    winUrl:
        "https://files.pythonhosted.org/packages/d9/a1/b7cfb6f3e7259f035a2c947cf26bff42cda6772933cdb95c829e91ce995f/mkl-2023.1.0-py2.py3-none-win_amd64.whl",
    macUrl:
        "https://files.pythonhosted.org/packages/31/7f/e865657b372f8f0aa4664ea2d07a5f80a4aeb337760d571cc690011dc2ce/mkl-2023.1.0-py2.py3-none-macosx_10_15_x86_64.macosx_11_0_x86_64.whl",
    linuxUrl:
        "https://files.pythonhosted.org/packages/85/66/815fb18860ad600695008f1a5acfc14a3e3b09fd77f006e332ce61af1f40/mkl-2023.1.0-py2.py3-none-manylinux1_x86_64.whl",
  ),

  OPENMP(
      name: "intel_openmp-2023.1.0",
      winUrl:
          "https://files.pythonhosted.org/packages/c7/a1/7407ebfb7131c2d8507bec5daf0684d76a9c6c38faaa6ae16b296e3335ce/intel_openmp-2023.1.0-py2.py3-none-win_amd64.whl",
      macUrl:
          "https://files.pythonhosted.org/packages/3f/71/72f38f9340420e3a1456834ddd88442be97476174e4a24a1cc30d834659b/intel_openmp-2023.1.0-py2.py3-none-macosx_10_15_x86_64.macosx_11_0_x86_64.whl",
      linuxUrl:
          "https://files.pythonhosted.org/packages/a3/6d/08040c4cfab1997f3a104238d850ab0ac345356762e34be7b415c7544162/intel_openmp-2023.1.0-py2.py3-none-manylinux1_x86_64.whl"),

  TBB(
      name: "tbb-2021.9.0",
      winUrl:
          "https://files.pythonhosted.org/packages/64/6a/20f2e84e31bd82b7ddecf616be0338b7fa5dc37285a73e810101f9c2b195/tbb-2021.9.0-py3-none-win_amd64.whl",
      macUrl:
          "https://files.pythonhosted.org/packages/b4/44/de6ad155a9b4c916cf72d3ad34de3c7802c51425b93e4727d1a372f9fb77/tbb-2021.9.0-py2.py3-none-macosx_10_15_x86_64.macosx_11_0_x86_64.whl",
      linuxUrl:
          "https://files.pythonhosted.org/packages/96/5f/aaae879605e95e147b7269e54a5b49654a44d6fee7fed54ece8f77d77ded/tbb-2021.9.0-py2.py3-none-manylinux1_i686.whl");

  final String name;
  final String winUrl;
  final String linuxUrl;
  final String macUrl;

  const _Lib(
      {required this.name,
      required this.winUrl,
      required this.linuxUrl,
      required this.macUrl});

  String file() => "${this.name}-py2.py3-none-${_wheelSuffix()}";

  String url() {
    if (Platform.isWindows) return winUrl;
    if (Platform.isMacOS) return macUrl;
    return linuxUrl;
  }

  String _wheelSuffix() {
    if (Platform.isWindows) {
      return "win_amd64.whl";
    }
    if (Platform.isMacOS) {
      return "macosx_10_15_x86_64.macosx_11_0_x86_64.whl";
    }
    return "manylinux1_x86_64.whl";
  }
}

main() {
  // first we need to fetch the following libraries from pypi.org:
  // * mkl 2023.1.0
  // * intel-openmp 2023.1.0
  // * tbb 2021.9.0

  for (var lib in _Lib.values) {
    print(lib.url());
  }

  var targetDir = _ensureDir("./target");

  print(_Lib.MKL.url());
}

Directory _ensureDir(String path) {
  var dir = Directory(path);
  if (!dir.existsSync()) {
    dir.createSync(recursive: true);
  }
  return dir;
}