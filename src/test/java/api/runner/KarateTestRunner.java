package api.runner;
import com.intuit.karate.junit5.Karate;
public class KarateTestRunner {
	
	@Karate.Test
	
	public Karate runTests() {
		return Karate.run("classpath:features")
				.tags();
		
	}

}
