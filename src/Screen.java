import java.io.File;
import java.util.Scanner;

public class Screen {
	final int height;
	final int width;
	final String name;
	Tile[][] screen;

	public Screen(String name) {
		this.height = 22;
		this.width = 40;
		this.name = name;
		this.screen = new Tile[height][width];
	}

	public static Screen parseScreen(File screen, String name) throws Exception {
		Scanner sc = new Scanner(screen);

		{
			String firstLine = sc.nextLine();
			int left = firstLine.indexOf(":") + 2;

			if (!name.equals(firstLine.substring(left))) {
				sc.close();
				throw new Exception("");
			}
		}

		Screen out = new Screen(name);

		while (sc.hasNextLine()) {
			String line = sc.nextLine();

			
		}

		return out;
	}
}