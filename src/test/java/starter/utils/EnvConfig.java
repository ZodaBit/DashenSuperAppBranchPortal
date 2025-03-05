package starter.utils;

import lombok.extern.slf4j.Slf4j;
import net.serenitybdd.core.di.SerenityInfrastructure;
import net.serenitybdd.model.environment.EnvironmentSpecificConfiguration;
import net.thucydides.model.util.EnvironmentVariables;


@Slf4j
public class EnvConfig {
    private static EnvironmentVariables variables = SerenityInfrastructure.getEnvironmentVariables();
    private static final EnvironmentSpecificConfiguration conf = EnvironmentSpecificConfiguration.from(variables);

    public static String getProperty(String key) {
        try {
            return conf.getProperty(key);
        } catch (Exception e) {
            //log.error("Property {} not found", key);
            return null;
        }
    }

    public static String getBaseUrl() {
        return conf.getProperty("environments.uat.base.url");
    }

    public static String getSourceAppHeader() {
        return conf.getProperty("environments.uat.header.sourceapp");
    }

    public static String getOtpForHeader() {
        return conf.getProperty("environments.uat.header.otpfor");
    }

    public static String getMakerName() {
        return conf.getProperty("environments.uat.maker.user");
    }

    public static String getPassword() {
        return conf.getProperty("environments.uat.maker.password");
    }

}
