package com.example.karate;

import io.karatelabs.core.Runner;
import io.karatelabs.core.SuiteResult;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertTrue;

class KarateSuiteTest {

    @Test
    void runKarateSuite() {
        int threads = Integer.parseInt(System.getProperty("karate.threads", "4"));

        SuiteResult result = Runner.path("classpath:features")
                .tags("~@ignore")
                .outputHtmlReport(true)
                .outputJunitXml(true)
                .outputCucumberJson(true)
                .parallel(threads);

        assertTrue(result.isPassed(), "Karate suite failed. See target/karate-reports for details.");
    }
}
