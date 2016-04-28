/**
 * 
 */
package fresado;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.StreamTokenizer;
import java.util.ArrayList;

/**
 * @author dviejo
 *
 */
public class MapDriller {

	static public String FILE_EXT = ".g"; 
	static public String PREAMBLE = "M106 \n";
	static public String END = "M107 \n";
	private float stepD; 
	private float stepDRev;
	private float drillSpeed;
	private float drillSpeedRev;
	private float movHeight;
	private float movSpeed;
	/**
	 * 
	 */
	public MapDriller() {
		stepD = 0.5f; 
		stepDRev = 0.25f;
		drillSpeed = 120;
		drillSpeedRev = 600;
		movHeight = 20;
		movSpeed = 600;
	}

	private String move(float x, float y)
	{
		String ret;
		//lift head to movHeight at drillSpeedRev
		ret = "G1 Z"+movHeight+" F"+drillSpeedRev+"\n";
		//move to x,y at movSpeed
		ret += "G1 X"+x+" Y"+y+" F"+movSpeed+"\n";
		
		return ret;
	}
	
	private String drill(float depth)
	{
		String ret;
		float d;
		//drop head to 1mm over surface at drillSpeedRev
		ret = "G1 Z1 F"+drillSpeedRev+"\n";
		d=1;
		while(d>-depth)
		{
			d -= stepD;
			ret +="G1 Z"+d+" F"+drillSpeed+"\n";
			d += stepDRev;
			ret +="G1 Z"+d+" F"+drillSpeedRev+"\n";
			d -= stepDRev;
			ret +="G1 Z"+d+" F"+drillSpeedRev+"\n";
		}
		
		return ret;
	}
	
	public void generateCode(String inputName)
	{
		String outputName = inputName.substring(0, inputName.lastIndexOf('.'))+FILE_EXT;
		FileReader fr;
		StreamTokenizer st;
		ArrayList<Float> coordinates = new ArrayList<Float>();
		int input = 0;
		int totalSize;
		int numDrills, cont;
		float x, y, depth;
		FileWriter fw;
		String outputString = PREAMBLE;
		
		System.out.println("Fichero de salida: "+outputName);
		
		//comenzamos la lectura del fichero
		try {
			fr = new FileReader(inputName);
			st = new StreamTokenizer(fr);
			do
			{
				input = st.nextToken();
				if(input==StreamTokenizer.TT_NUMBER)
					coordinates.add((float)st.nval);
			}while(input!=StreamTokenizer.TT_EOF);
			
		} catch (FileNotFoundException e) {
			System.err.println("Fichero no encontrado: "+inputName);
			e.printStackTrace();
		}catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		totalSize = coordinates.size();
		if(totalSize%3!=0)
		{
			System.err.println("Fichero de entrada corrupto");
			return;
		}
		numDrills = totalSize/3;
		System.out.println("Datos leídos: "+totalSize);
		System.out.println("Número de taladros: "+totalSize/3);
		for(cont=0;cont<numDrills;cont++)
		{
			x = coordinates.remove(0);
			y = coordinates.remove(0);
			depth = coordinates.remove(0);
			
			outputString += move(x, y);
			outputString += drill(depth);
		}
		//levantamos finalmente el taladro hasta la distancia de seguridad
		outputString += "G1 Z"+movHeight+" F"+drillSpeedRev+" \n";
		outputString += END;
		//System.out.println(outputString);
		
		try {
			fw = new FileWriter(outputName);
			fw.write(outputString);
			fw.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	/**
	 * @param args Se recibe el nombre de un fichero de texto con las coordenadas 
	 * de los taladros a realizar
	 * Cada línea del fichero tendrá las coordenadas de un taladro: x, y, depth
	 */
	public static void main(String[] args) {
		if(args.length!=1)
		{
			System.err.println("Error: Se espera el nombre de fichero de entrada como parametro");
			System.err.println("Uso $ java MapDriller inputFile.txt");
			return;
		}
		String inputName = args[0];
		System.out.println("El fichero de entrada es "+inputName);
		
		MapDriller md = new MapDriller();
		md.generateCode(inputName);

	}

}
