LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY sen IS 
PORT( motion_sensor1,motion_sensor2,motion_sensor3,infrared_sensor,CLK,reset:IN STD_LOGIC;
      LAMPG,LAMPR,BUZZER:OUT STD_LOGIC);
END sen;

ARCHITECTURE behaviour OF sen IS 
TYPE statetype IS (s1,s2,s3,s4);
SIGNAL currentstate,nextstate : statetype;
BEGIN 
PROCESS(CLK,reset)
BEGIN
IF(reset = '1') THEN
	LAMPR <= '1'; 
	LAMPG <= '0';
	BUZZER <= '0';
ELSIF(CLK'EVENT AND CLK = '1') THEN
	CASE currentstate IS
		WHEN s1 => IF(motion_sensor1 = '0') THEN
						LAMPR <= '1';
						LAMPG <= '0';
						BUZZER <= '0';
						nextstate <= s2;
						ELSE
						nextstate <= s1;
					  END IF;
					  IF(infrared_sensor = '1') THEN
						nextstate <= s4;
					  END IF;
		WHEN s2=> IF(motion_sensor2 = '0') THEN
						LAMPR <= '1';
						LAMPG <= '0';
						BUZZER <= '0';
						nextstate <= s3;
						ELSE
						nextstate <= s2;
					 END IF;
				    IF(infrared_sensor = '1') THEN
						nextstate <= s4;
					 END IF;				    
		WHEN s3=> IF(motion_sensor3 = '0') THEN
						LAMPG <='1';
						LAMPR <= '0';	
						BUZZER <= '0';
					  END IF;
				     IF(infrared_sensor = '1') THEN
						 nextstate <= s4;
					  END IF;
		WHEN s4 =>	IF(infrared_sensor = '1') THEN
							BUZZER <= '1';
							LAMPG <= '1';
							LAMPR <= '0';
						END IF;
	END CASE;
END IF;
END PROCESS;
currentstate <= nextstate;
END behaviour;
     