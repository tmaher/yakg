set
        `security add-generic-password -a keyname -s service_name -w password`

get
        `security find-generic-password -a somekey -s service_name -w`

delete
        `security delete-generic-password -a somekey -s service_name`

update
        delete and add, or call add with `-U`
