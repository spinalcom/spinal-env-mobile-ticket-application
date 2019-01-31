const String kBaseUrl = "http://192.168.43.181";
const String kTicketBaseUrl = "http://ticket-api.spinalcom.com";
const String kUserBaseUrl = "http://user-api.spinalcom.com";

const String kUserPort = ":3333";
const String kUserUrl = kBaseUrl + kUserPort;

const String kLoginUrl = kUserUrl + "/login";
const String kSignUpUrl = kUserUrl + "/user";

const String kTicketPort = ":3000";
const String kTicketUrl = kBaseUrl + kTicketPort;

const String kProcesses = kTicketUrl + '/processes';
const String kTicket = kTicketUrl + '/ticket';
const String kSentences = kTicketUrl + '/sentences';
const String kTicketUser = kTicketUrl + '/tickets';
const String kTicketNode = kTicketUrl + '/node';
