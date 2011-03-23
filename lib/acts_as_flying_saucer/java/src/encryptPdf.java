import java.io.*;
import org.xhtmlrenderer.pdf.ITextRenderer;
import com.lowagie.text.pdf.PdfReader;
import com.lowagie.text.pdf.PdfWriter;
import com.lowagie.text.pdf.PdfEncryptor;
public class encryptPdf
{
    public static void main(String[] args) throws Exception {
       
        String input = args[0];
        String output = args[1];
        String password = args[2];

        PdfReader pr = new PdfReader(input);
        OutputStream os = new FileOutputStream(output);
        PdfEncryptor.encrypt(pr,os, false,password,password, PdfWriter.AllowAssembly |
 PdfWriter.AllowCopy | PdfWriter.AllowDegradedPrinting | PdfWriter.AllowFillIn | PdfWriter.AllowModifyAnnotations | PdfWriter.AllowModifyContents  | PdfWriter.AllowPrinting | PdfWriter.AllowScreenReaders);
        os.close();
    }
}
