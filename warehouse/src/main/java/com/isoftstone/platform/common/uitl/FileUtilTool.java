package com.isoftstone.platform.common.uitl;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;

import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerConfigurationException;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.TransformerFactoryConfigurationError;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;

import org.apache.poi.hwpf.HWPFDocument;
import org.apache.poi.hwpf.converter.PicturesManager;
import org.apache.poi.hwpf.converter.WordToHtmlConverter;
import org.apache.poi.hwpf.usermodel.PictureType;
import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import com.isoftstone.contract.entity.ContractDataBean;

public class FileUtilTool
{
    /**
     * 下载文件
     * <一句话功能简述>
     * <功能详细描述>
     * @param inputStream
     * @param fileNamePath
     * @throws FileNotFoundException
     * @throws IOException
     * @see [类、类#方法、类#成员]
     */
    public static void downFile(InputStream inputStream, String fileNamePath)
        throws FileNotFoundException, IOException
    {
        File file = new File(fileNamePath);
        
        if (!file.getParentFile().exists())
        {
            file.getParentFile().mkdirs();
        }
        
        FileOutputStream fop = new FileOutputStream(fileNamePath);
        int length = 0;
        byte[] block = new byte[1024];
        while ((length = inputStream.read(block)) > 0)
        {
            fop.write(block, 0, length);
            fop.flush();
        }
        fop.close();
    }
    
    public static String convert2Html(final String inputFile, final String uuidStr, ContractDataBean contractHeadBean,
        ContractDataBean contractBodyBean)
        throws TransformerException, IOException, ParserConfigurationException
    {
        HWPFDocument wordDocument = new HWPFDocument(new FileInputStream(inputFile));
        WordToHtmlConverter wordToHtmlConverter =
            new WordToHtmlConverter(DocumentBuilderFactory.newInstance().newDocumentBuilder().newDocument());
        wordToHtmlConverter.setPicturesManager(new PicturesManager()
        {
            public String savePicture(byte[] content, PictureType pictureType, String suggestedName, float widthInches,
                float heightInches)
            {
                String picturePath = inputFile.substring(0, inputFile.lastIndexOf('/'));
                picturePath = picturePath.substring(0, picturePath.lastIndexOf('/'));
                String fileNameString = picturePath + "/" + uuidStr + "/" + suggestedName;
                File file = new File(fileNameString);
                file = file.getParentFile();
                if (!file.exists())
                {
                    file.mkdirs();
                }
                FileOutputStream fos = null;
                try
                {
                    fos = new FileOutputStream(fileNameString);
                    fos.write(content);
                    fos.flush();
                }
                catch (FileNotFoundException e)
                {
                    e.printStackTrace();
                }
                catch (IOException e)
                {
                    e.printStackTrace();
                }
                finally
                {
                    try
                    {
                        if (fos != null)
                        {
                            fos.close();
                        }
                        
                    }
                    catch (IOException e)
                    {
                        e.printStackTrace();
                    }
                }
                fileNameString = "##" + "/" + uuidStr + "/" + suggestedName;
                return fileNameString;
            }
        });
        wordToHtmlConverter.processDocument(wordDocument);
        
        Document htmlDocument = wordToHtmlConverter.getDocument();
        NodeList headNodeList = htmlDocument.getElementsByTagName("head");
        contractHeadBean.setDocutmentData(xml2string(htmlDocument, headNodeList));
        headNodeList = htmlDocument.getElementsByTagName("body");
        contractBodyBean.setDocutmentData(xml2string(htmlDocument, headNodeList));
        return xml2string(htmlDocument, headNodeList);
    }
    
    public static String xml2string(Document htmlDocument, NodeList headNodeList)
        throws TransformerFactoryConfigurationError, TransformerConfigurationException, TransformerException,
        IOException
    {
        ByteArrayOutputStream out = new ByteArrayOutputStream();
        DOMSource domSource = new DOMSource(htmlDocument);
        StreamResult streamResult = new StreamResult(out);
        if (headNodeList.getLength() > 0)
        {
            Node headNode = headNodeList.item(0);
            domSource = new DOMSource(headNode);
        }
        
        TransformerFactory tf = TransformerFactory.newInstance();
        Transformer serializer = tf.newTransformer();
        serializer.setOutputProperty(OutputKeys.ENCODING, "GB2312");
        serializer.setOutputProperty(OutputKeys.INDENT, "yes");
        serializer.setOutputProperty(OutputKeys.METHOD, "html");
        serializer.transform(domSource, streamResult);
        out.close();
        return new String(out.toByteArray());
    }
    
    /** 
     * 删除一个文件或者目录 
     * 
     * @param targetPath 文件或者目录路径 
     * @IOException 当操作发生异常时抛出 
     */
    public static void deleteFile(String targetPath)
        throws IOException
    {
        File file = new File(targetPath);
        if (file.exists())
        {
            // 当且仅当此抽象路径名表示的文件存在且 是一个目录时，返回 true  
            if (!file.isDirectory())
            {
                file.delete();
            }
            else if (file.isDirectory())
            {
                File[] filelist = file.listFiles();
                for (int i = 0; i < filelist.length; i++)
                {
                    File delfile = filelist[i];
                    if (!delfile.isDirectory())
                    {
                        delfile.delete();
                    }
                    else if (delfile.isDirectory())
                    {
                        deleteFile(filelist[i].getAbsolutePath());
                    }
                }
                file.delete();
            }
        }
    }
}
