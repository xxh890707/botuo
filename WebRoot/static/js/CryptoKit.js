function Cryptokit() {
};


Cryptokit.prototype.init = function () {
    var eDiv = document.createElement("div");
    if (navigator.appName.indexOf("Internet") >= 0 || navigator.appVersion.indexOf("Trident") >= 0) {
        if (window.navigator.cpuClass == "x86") {
            eDiv.innerHTML = "<object id=\"cryptokitCtrl\" codebase=\"CryptoKit.CEBPS.x86.cab\" classid=\"clsid:59311870-843D-402E-AFE0-318E95C48B72\" ></object>";
        }
        else {
            eDiv.innerHTML = "<object id=\"cryptokitCtrl\" codebase=\"CryptoKit.CEBPS.x64.cab\" classid=\"clsid:97848F89-D465-49E3-A921-4A098239F45F\" ></object>";
        }
    }
    else {
        eDiv.innerHTML = "<embed id=\"cryptokitCtrl\" type=\"application/npCryptoKit.CEBPS.x86\" style=\"height: 0px; width: 0px\">";
    }
    document.body.appendChild(eDiv);
}


Cryptokit.prototype.uninit = function () {
}


Cryptokit.prototype.GetVersion = function (callback) {
    var result = new Object(); 
    try {
        result.error = 0;
        result.value = document.getElementById("cryptokitCtrl").GetVersion();
    }
    catch (e) {
        result.error = -1;
        result.value = e.message;
    }
    callback(result);
}


Cryptokit.prototype.selectCertificate = function (bstrSubjectDNFilter, bstrIssuerDNFilter, serialNo, SM2CSPNameList, callback) {
    var result = new Object() ;
    try {
        result.error = 0;
        result.value = document.getElementById("cryptokitCtrl").SelectSignCert(bstrSubjectDNFilter, bstrIssuerDNFilter, serialNo, SM2CSPNameList);
    }
    catch (e) {
        result.error = -1;
        result.value = e.message;
    }
    callback(result);
}


Cryptokit.prototype.getSignCertInfo = function (InfoTypeID, callback) {
    var result = new Object(); 
    try {
        result.error = 0;
        result.value = document.getElementById("cryptokitCtrl").GetSignCertInfo(InfoTypeID);
    }
    catch (e) {
        result.error = -1;
        result.value = e.message;
    }
    callback(result);
}


Cryptokit.prototype.signMsgPKCS7 = function (source, selectedAlg, IsWithSource, callback) {
    var result = new Object();
    try {
        result.error = 0;
        result.value = document.getElementById("cryptokitCtrl").SignMsgPKCS7(source, selectedAlg, IsWithSource); 
    }
    catch (e) {
        result.error = -1;
        result.value = e.message;
    }
    callback(result);
}


Cryptokit.prototype.GetDataInfo = function(Signature, nDataType, callback) {
    var result = new Object();
    try {
        result.error = 0;
        result.value = document.getElementById("cryptokitCtrl").GetDataInfo(Signature, nDataType); 
    }
    catch (e) {
        result.error = -1;
        result.value = e.message;
    }
    callback(result);
}


Cryptokit.prototype.verifyMsgSignaturePKCS7Attached = function (signature, callback)  {
    var result = new Object();
    try {
        result.error = 0;
        result.value = document.getElementById("cryptokitCtrl").VerifyMsgSignaturePKCS7Attached(signature); 
    }
    catch (e) {
        result.error = -1;
        result.value = e.message;
    }
    callback(result);
}


Cryptokit.prototype.verifyMsgSignaturePKCS7Detached = function (signature, source, callback) {
    var result = new Object();
    try {
        result.error = 0;
        result.value = document.getElementById("cryptokitCtrl").VerifyMsgSignaturePKCS7Detached(signature, source); 
    }
    catch (e) {
        result.error = -1;
        result.value = e.message;
    }
    callback(result);
}

Cryptokit.prototype.SignFilePKCS7Detached = function (sourcefile, selectedAlg, callback) {
    var result = new Object();
    try {
        result.error = 0;
        result.value = document.getElementById("cryptokitCtrl").SignFilePKCS7Detached (sourcefile, selectedAlg); 
    }
    catch (e) {
        result.error = -1;
        result.value = e.message;
    }
    callback(result);
}

Cryptokit.prototype.VerifyFileSignaturePKCS7Detached = function (Signature, sourcefile, callback) {
    var result = new Object() ;
    try {
        result.error = 0;
        result.value = document.getElementById("cryptokitCtrl").VerifyFileSignaturePKCS7Detached(Signature, sourcefile);
    }
    catch (e) {
        result.error = -1;
        result.value = e.message;
    }
    callback(result);
}


Cryptokit.prototype.SelectEncryptCertificate = function (bstrSubjectDNFilter, bstrIssuerDNFilter, serialNo, SM2CSPNameList, callback) {
    var result = new Object() ;
    try {
        result.error = 0;
        result.value = document.getElementById("cryptokitCtrl").SelectEncryptCertificate(bstrSubjectDNFilter, bstrIssuerDNFilter, serialNo, SM2CSPNameList);
    }
    catch (e) {
        result.error = -1;
        result.value = e.message;
    }
    callback(result);
}


Cryptokit.prototype.SetEncryptCert = function (Base64CertData, callback) {
    var result = new Object() ;
    try {
        result.error = 0;
        result.value = document.getElementById("cryptokitCtrl").SetEncryptCert(Base64CertData);
    }
    catch (e) {
        result.error = -1;
        result.value = e.message;
    }
    callback(result);
}


Cryptokit.prototype.GetEncryptCertInfo = function (InfoTypeID, callback) {
    var result = new Object();
    try {
        result.error = 0;
        result.value = document.getElementById("cryptokitCtrl").GetEncryptCertInfo(InfoTypeID);
    }
    catch (e) {
        result.error = -1;
        result.value = e.message;
    }
    callback(result);
}

Cryptokit.prototype.encryptMsgCMSEnvelope = function (EncryptSourceData, SysAlg, callback) {
    var result = new Object(); 
    try {
        result.error = 0;
        result.value = document.getElementById("cryptokitCtrl").EncryptMsgCMSEnvelope(EncryptSourceData, SysAlg);
    }
    catch (e) {
        result.error = -1;
        result.value = e.message;
    }
    callback(result);
}


Cryptokit.prototype.decryptMsgCMSEnvelope = function (EncryptData, SM2CSPNameList, callback) {
    var result = new Object();
    try {
        result.error = 0;
        result.value = document.getElementById("cryptokitCtrl").DecryptMsgCMSEnvelope(EncryptData, SM2CSPNameList);
    }
    catch (e) {
        result.error = -1;
        result.value = e.message;
    }
    callback(result);
}


Cryptokit.prototype.encryptFile = function (SourceFile, EncryptedFile, callback) {
    var result = new Object(); 
    try {
        result.error = 0;
        result.value = document.getElementById("cryptokitCtrl").EncryptFile(SourceFile, EncryptedFile);
    }
    catch (e) {
        result.error = -1;
        result.value = e.message;
    }
    callback(result);
}


Cryptokit.prototype.decryptFile = function (EncryptedFile, DecryptedFile, SymKey, SM2CertProviderNameList, callback) {
    var result = new Object() ;
    try {
        result.error = 0;
        result.value = document.getElementById("cryptokitCtrl").DecryptFile(EncryptedFile, DecryptedFile,  SymKey, SM2CertProviderNameList);
    }
    catch (e) {
        result.error = -1;
        result.value = e.message;
    }
    callback(result);
}


Cryptokit.prototype.GetLastErrorDesc = function (callback) {
    var result = new Object();
    try {
        result.error = 0;
        result.value = document.getElementById("cryptokitCtrl").GetLastErrorDesc();
        callback(result);
    }
    catch (e) {
        result.error = -1;
        result.value = e.message;
    }
}
