import java.io.*;
import org.xhtmlrenderer.pdf.ITextRenderer;

public class Xhtml2Pdf
{
    public static void main(String[] args) throws Exception {
       
        String input = args[0];
        String url = new File(input).toURI().toURL().toString();
        String output = args[1];
        
        OutputStream os = new FileOutputStream(output);
        ITextRenderer renderer = new ITextRenderer();
        renderer.setDocument(url);
        renderer.layout();
        renderer.createPDF(os);
        os.close();

    }
}
