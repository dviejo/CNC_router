/**
 * 
 */
package fresado;

/**
 * @author dviejo
 *
 */
public class MapDriller {

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

	}

}
