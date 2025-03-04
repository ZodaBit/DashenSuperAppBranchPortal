package starter.utils.jsons;

public class TransferLimitJson {

    public static String TRANSFER_LIMIT_PAYLOAD= """
                   {
                        "userCode": "%s",
                        "serviceName": "%s",
                        "transactionOneTimeLimit": %d,
                        "transactionDailyLimit": %d
                    }
            """;


}
