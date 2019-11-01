package com.isoftstone.contract.service;

import java.io.IOException;

import org.springframework.http.ResponseEntity;

public interface ContractDownloadService
{
    ResponseEntity<byte[]> getWordContents(String htmlfile2)
        throws IOException;
}
