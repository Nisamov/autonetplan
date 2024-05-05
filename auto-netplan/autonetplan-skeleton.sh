if [[ $1 == "-h" || $1 == "--help" ]]; then

elif [[ $1 == "-i" || $1 == "--integrity" ]]; then

elif [[ $1 == "-m" || $1 == "--manual" ]]; then

elif [[ $1 == "-r" || $1 == "--remove" ]]; then

elif [[ $1 == "-b" || $1 == "--backup" ]]; then

elif [[ $1 == "-l" || $1 == "--license" ]]; then
    
elif [[ $1 == "-x" || $1 == "--execute" ]]; then
    # Continuacion de programa
    if [[ $2 == "-m" || $2 == "--manual" ]]; then
       
    elif [[ $2 == "-a" || $2 == "--automatic" ]]; then
        
        if [[ $3 == "-iface" || $3 == "--interface" ]]; then
            
            if [[ $4 == "-f" || $3 == "--fluid" ]]; then
                 
            elif [[ $4 == "-s" || $4 == "--static" ]]; then
                
                if [[ $5 == "-lnkd" || $5 == "--linkeddoor" ]]; then
                   
                elif [[ $5 == "-ntcd" || $5 == "--networkcard" ]]; then
                    
                else
                    
                fi
                if [[ $5 != "-ntcd" && $6 == "-ntcd" || $5 != "-ntcd" && $6 == "--networkcard" ]]; then
                   
                else
                    
                fi
                
                if [[ "$opcionaab" == "true" ]]; then
                    
                elif [[ "$opcionaab" == "false" ]]; then
                   
                else
                   
                fi
            else
                
            fi
        else
            
        fi
    else
        
    fi
else
    
fi