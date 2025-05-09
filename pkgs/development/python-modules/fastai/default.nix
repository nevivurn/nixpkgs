{
  lib,
  buildPythonPackage,
  fetchPypi,
  fastprogress,
  fastcore,
  fastdownload,
  torchvision,
  matplotlib,
  pillow,
  scikit-learn,
  scipy,
  spacy,
  pandas,
  requests,
  pythonOlder,
}:

buildPythonPackage rec {
  pname = "fastai";
  version = "2.7.19";
  format = "setuptools";

  disabled = pythonOlder "3.7";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-CoBABtO2NkrNVUTzQ58vBdRe2rr4ji26iJOzema4Nsg=";
  };

  propagatedBuildInputs = [
    fastprogress
    fastcore
    fastdownload
    torchvision
    matplotlib
    pillow
    scikit-learn
    scipy
    spacy
    pandas
    requests
  ];

  doCheck = false;
  pythonImportsCheck = [ "fastai" ];

  meta = with lib; {
    homepage = "https://github.com/fastai/fastai";
    description = "Fastai deep learning library";
    mainProgram = "configure_accelerate";
    changelog = "https://github.com/fastai/fastai/blob/${version}/CHANGELOG.md";
    license = licenses.asl20;
    maintainers = with maintainers; [ rxiao ];
  };
}
