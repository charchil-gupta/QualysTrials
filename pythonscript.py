import sys, json


def print_failed_checks(output):
    if output.get("status") != "FINISHED":
        exit(-1)
    failed_checks = False
    for result in output.get("result"):
        #print(result.get("checkType"))
        if result.get("results").get("failedChecks"):
            for r in result.get("results").get("failedChecks"):
                line_range = "None"
                if r.get("fileLineRange"):
                    line_range = str(r.get("fileLineRange")[0]) + "-" + str(r.get("fileLineRange")[1])
                print("::error file="+ str(r.get("filePath")) +",line=" + line_range +"::Check_Id = "+ str(r.get("checkId")) +", Description = "+ str(r.get("checkName")) +", Remediation = "+ str(r.get("remediation")))

            failed_checks = True
    if failed_checks:
        exit(-1)

# Press the green button in the gutter to run the script.
if __name__ == '__main__':

    fp = open(sys.argv[1], "r")
    data = fp.read()
    fp.close()
    message = "The scan result is successfully retrieved. JSON output is as follows:"
    pos = data.find(message)
    pos += len(message)
    data = data[pos:]
    print_failed_checks(json.loads(data))

