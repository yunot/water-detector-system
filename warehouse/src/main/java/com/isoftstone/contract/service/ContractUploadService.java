package com.isoftstone.contract.service;

import java.io.IOException;
import java.io.InputStream;

import org.springframework.http.ResponseEntity;

public interface ContractUploadService
{
    void addContract(String string, InputStream inputStream)
        throws IOException;
    
    ResponseEntity<byte[]> download(String fileId)
        throws IOException;
    
}
