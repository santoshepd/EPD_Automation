#!/bin/bash
echo "Initializing setup..."
/home/ubuntu/env_automation/bin/python ERCOT_VLR/VLR_ERCOT/Main.py
/home/ubuntu/env_automation/bin/python ERCOT_SHAPING/Scripts/main.py
/home/ubuntu/env_automation/bin/python ISONE_SHAPING/Scripts/main.py
/home/ubuntu/env_automation/bin/python ISONE_VLR/VLR_ISONE_MOD/Main.py
/home/ubuntu/env_automation/bin/python MISO_SHAPING/Scripts/main.py
/home/ubuntu/env_automation/bin/python NYISO_SHAPING/Scripts/main.py
/home/ubuntu/env_automation/bin/python MISO_SHAPING/Scripts/main.py
/home/ubuntu/env_automation/bin/python PJM_SHAPING/Scripts/main.py
/home/ubuntu/env_automation/bin/python VLR_NYISO/VLR_NYISO_MOD/Main.py

/home/ubuntu/env_automation/bin/streamlit run ERCOT_VLR/SCALING_TOOL/Streamlit.py --server.port 8501 --server.headless true --server.enableCORS false --server.enableXsrfProtection false --server.address 0.0.0.0
