package parsing;
import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class FileIO {
	
	// static variables
	static String mFileName;
	private static boolean checked = false;
	static List<City> mCities = new ArrayList<City>();
	
	// Constructor with input file name
	public FileIO(String inFileName) throws FileNotFoundException, IOException, NotEnoughException, FormatException {
		mFileName = inFileName;
		foundFile();
	}
	
	// if file is found, validate it
	static void foundFile() throws FileNotFoundException, IOException, NotEnoughException, FormatException {
		FileReader fr = new FileReader(mFileName);
		validateFile(fr);
	}
	
	// validating file
	static  void validateFile(FileReader fr) throws IOException, NotEnoughException, FormatException {
		mCities.clear();
		BufferedReader br = new BufferedReader(fr);
		String line = br.readLine();
		while (line != null) {
			try {
				City city = validateArguments(line);
				mCities.add(city);
				line = br.readLine();
			} catch (NotEnoughException nee) {
				nee.addToMessage(line);
				throw nee;
			}
		}
		br.close();
	}
	
	// validating the arguments in line
	static City validateArguments(String line) throws NotEnoughException, FormatException {
		String[] cityStrings = line.split("[|]");
		City city = new City(cityStrings);
		return city;
	}
	
	// getters and setters
	public static List<City> getCities() {
		return mCities;
	}
	static void setCities(List<City> mCities) {
		FileIO.mCities = mCities;
	}
	static boolean isChecked() {
		return checked;
	}
	static void setChecked(boolean checked) {
		FileIO.checked = checked;
	}
}