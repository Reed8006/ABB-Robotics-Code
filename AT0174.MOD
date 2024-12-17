
MODULE AT0174
    ! revision history log:05-04-18 copied from AT0069
    ! rev_00_01 added single cycle, made variable spray distance 60 - 120mm
    ! prompt operator
    
    ! declare and/or define variables that are local to this module
    LOCAL CONST listitem partProgram{4}:=[["","AT0174, rotating samples"],["","Cooldown"],["","Stop table"],[stEmpty,"Stop"]];
    LOCAL VAR num itemSelected;
    LOCAL VAR btnres buttonAnswer;
    LOCAL VAR string defaultValueString;
    
    ! declare and/or define position variables that are local to this module
    PERS robtarget home:=[[-339.12,-750.45,1056.11],[0.689054,-0.0839297,0.715795,0.0761443],[-1,-1,-3,0],[-0.00169285,-0.418633,9E+09,9E+09,9E+09,9E+09]];
    PERS robtarget pounce:=[[127.23,4.28,802.46],[0.504555,-0.498066,0.501962,-0.495367],[-1,0,-1,0],[0.00172391,0.00024372,9E+09,9E+09,9E+09,9E+09]];
    PERS robtarget Int_1:=[[-136.72,1020.38,1373.26],[0.536579,0.471492,-0.504415,-0.485122],[-1,0,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    PERS robtarget pTop_B:=[[156.17,4.27,660],[0.504542,-0.498084,0.501992,-0.495332],[-1,0,-1,0],[0.000405548,0.00024372,9E+09,9E+09,9E+09,9E+09]];
    PERS robtarget pBottom_B:=[[156.17,4.27,585],[0.504539,-0.498084,0.501996,-0.495331],[-1,0,-1,0],[0.000295684,0.00024372,9E+09,9E+09,9E+09,9E+09]];
    PERS robtarget pBottom_T:=[[295,21.1,827.78],[0.560766,-0.384928,0.590696,-0.434108],[0,0,-3,1],[-0.0014072,-0.0387577,9E+09,9E+09,9E+09,9E+09]];
    PERS robtarget pTop_T:=[[295,21.09,927.41],[0.560785,-0.384899,0.590684,-0.434127],[0,0,-3,1],[-0.0014072,-0.0415043,9E+09,9E+09,9E+09,9E+09]];
    PERS robtarget pdown1:=[[132.84,29.97,542.49],[0.430287,-0.609912,0.623494,-0.232629],[-1,0,-3,1],[-0.00371433,-0.0546879,9E+09,9E+09,9E+09,9E+09]];
    PERS robtarget pdown2:=[[131.96,29.73,499.59],[0.430287,-0.609917,0.623491,-0.232622],[-1,0,-3,1],[-0.00382419,-0.0546879,9E+09,9E+09,9E+09,9E+09]];
    PERS robtarget pdown3:=[[134.34,28.90,463.12],[0.430261,-0.609954,0.623467,-0.232638],[-1,0,-3,1],[-0.00415378,-0.0574345,9E+09,9E+09,9E+09,9E+09]];
    PERS robtarget pdown4:=[[137.74,28.94,423.88],[0.430245,-0.609951,0.623503,-0.23258],[-1,0,-3,1],[-0.00415378,-0.0574345,9E+09,9E+09,9E+09,9E+09]];
    PERS robtarget pint5:=[[-41.06,-28.11,440.93],[0.576865,-0.512565,0.552982,-0.314188],[-1,0,-3,1],[-0.00404392,-0.0387577,9E+09,9E+09,9E+09,9E+09]];
    PERS robtarget pdown21:=[[158.49,-124.23,293.16],[0.350615,-0.914196,-0.166172,0.117056],[0,-1,-1,0],[-0.00269791,9E+09,9E+09,9E+09,9E+09,9E+09]];
    PERS robtarget pdown22:=[[157.45,-126.92,258.42],[0.350621,-0.914187,-0.166202,0.117064],[0,-1,-1,0],[-0.00379654,9E+09,9E+09,9E+09,9E+09,9E+09]];
    PERS robtarget pdown23:=[[150.58,-126.39,210.08],[0.378021,-0.884276,-0.193431,0.194271],[0,-1,-1,0],[0.00718979,9E+09,9E+09,9E+09,9E+09,9E+09]];
    PERS robtarget pdown24:=[[150.82,-126.42,180.85],[0.378037,-0.884269,-0.193461,0.194241],[0,-1,-1,0],[0.00718979,9E+09,9E+09,9E+09,9E+09,9E+09]];
    PERS robtarget pint25:=[[244.47,-201.92,166.44],[0.487998,-0.827092,-0.157467,0.230175],[0,-1,-1,0],[-0.00104996,9E+09,9E+09,9E+09,9E+09,9E+09]];
    PERS robtarget pounce_1:=[[-26.64,-431.12,1261.13],[0.521644,-0.512107,0.470385,-0.49434],[-1,-1,-3,1],[-0.0034946,-0.0387577,9E+09,9E+09,9E+09,9E+09]];
    CONST speeddata spv21:=[21,500,5000,1000];
    CONST speeddata spv8:=[8,500,5000,1000];
    CONST robtarget p10:=[[318.66,35.67,553.54],[0.603846,-0.416607,0.55673,-0.389692],[0,0,-3,1],[-0.00256076,320.428,9E+09,9E+09,9E+09,9E+09]];
    VAR num nCoatingSpeed:=10;
    VAR num nWait:=0;

    PROC Main()
		  ActUnit MTT180;

      StartCycle:

      ! start cycle
      WaitDI DI_OP_Start, 1;

      ! move to home position
      MoveJ home, v100, z10, Cascade_100MM\WObj:=table;

        ! get part program from operator
        itemSelected:=UIListView(\Result:=buttonAnswer,\Header:="Samples",partProgram,\Buttons:=btnOKCancel,\Icon:=iconInfo,\DefaultIndex:=1);

        IF buttonAnswer=resOK THEN
            IF itemSelected=1 THEN
              Samples;
            ELSEIF itemSelected=2 THEN
              Cooldown;
            ELSEIF itemSelected=3 THEN
		          stopTableRotation;
            ELSEIF itemSelected=4 THEN
              GOTO StopCycle;
            ELSE
              GOTO StopCycle;
            ENDIF
        ELSE
            ! if user selects cancel then stop cycle
            GOTO StopCycle;
        ENDIF
        
        ! return to the top of main for another program selection by the user
        GOTO StartCycle;
        
        StopCycle:
        
    ENDPROC

    PROC Samples()
    	VAR num nSprayDistance:=0;
    	VAR num nRotationSpeed:=0;
    	VAR num nRobotSpeed:=0;

        ! set preheat cycle counters
        preheatCycleCounter:=2;

        ! set cycle counters
        coatingCycleCounter:=10;
        
        ! allow operator to change the number of coating cycles from the default value
        defaultValueString := "default value = " + NumtoStr(coatingCycleCounter,0);
        coatingCycleCounter := UINumEntry (\Header:="Change Coating Cycles", \MsgArray:=["How many coating cycles?", defaultValueString], \InitValue:=coatingCycleCounter, \MinValue:=coatingCycleCounter-5, \MaxValue:=coatingCycleCounter+20, \AsInteger);
  lblRetry:
        TPErase;
        TPReadNum nSprayDistance,"What Spray distance would you like? 60 - 180";
        IF (nSprayDistance < 60) OR (nSprayDistance > 180) THEN
        	!NOK
        	Goto lblRetry;
        ELSE
        	!OK
        	nSprayDistance:=nSprayDistance - 60;
        ENDIF
        TPErase;
        TPReadNum nRotationSpeed,"What RPM for table rotation?";
        TPReadNum nRobotSpeed,"What traverse speed for robot?";
        TPErase;
        TPReadNum nWait, "How many seconds to pause?";


        ! move to pounce position
        MoveL pounce, v800, z10, Cascade_80MM\WObj:=table;      
         
        ! start turn table
		    rotateTableAtSpeed nRotationSpeed;
        TPErase;
        TPWrite "start gun and press 'Cycle Start'";
        WaitDI DI_OP_Start, 1;
        TPErase;
        ! move to start position
        MoveL Offs(pTop_B,-nSprayDistance,0,25), v800, z10, Cascade_80MM\WObj:=table;

        WHILE PreheatCycleCounter>0 DO
          ! 
          ! start sppTopray
          MoveL Offs(pTop_B,-nSprayDistance,0,0), spv21\V:=nRobotSpeed, z1, Cascade_80MM\WObj:=table;
          MoveL Offs(pBottom_B,-nSprayDistance,0,0), spv21\V:=nRobotSpeed, z1, Cascade_80MM\WObj:=table;
          MoveL Offs(pTop_B,-nSprayDistance,0,0), spv21\V:=nRobotSpeed, z1, Cascade_80MM\WObj:=table;
        
          ! decrement the cycle counter
          Decr PreheatCycleCounter;
          ! check for single cycle
          IF TestDI(DI_Single_Cycle) GOTO Skip;
          TPErase;
          TPWrite "number of preheat cycles remaining = "\Num:=PreheatCycleCounter;
        ENDWHILE

        ! move to home position
        MoveL Offs(pTop_B,-nSprayDistance,0,50), v800, z10, Cascade_80MM\WObj:=table;
        MoveL pounce, v800, z10, Cascade_100MM\WObj:=table;
        MoveL home, v800, z10, Cascade_100MM\WObj:=table;


        TPErase;
        TPWrite "start powder and press 'Cycle Start'";
        WaitDI DI_OP_Start, 1;
        TPErase;
        ! move to start position
        MoveL Offs(pTop_B,-nSprayDistance,0,45), v800, z10, Cascade_80MM\WObj:=table;

        WHILE coatingCycleCounter>0 DO
          ! 
          ! start spray
          MoveL Offs(pTop_B,-nSprayDistance,0,0), spv21\V:=nRobotSpeed, z1, Cascade_80MM\WObj:=table;
          MoveL Offs(pBottom_B,-nSprayDistance,0,0), spv21\V:=nRobotSpeed, z1, Cascade_80MM\WObj:=table;
          MoveL Offs(pTop_B,-nSprayDistance,0,0), spv21\V:=nRobotSpeed, z1, Cascade_80MM\WObj:=table;
          WaitTime nWait;
        
          ! decrement the cycle counter
          Decr coatingCycleCounter;
          ! check for single cycle
          IF TestDI(DI_Single_Cycle) GOTO Skip;
          TPErase;
          TPWrite "number of coating cycles remaining = "\Num:=coatingCycleCounter;
        ENDWHILE

        ! move to home position
        Skip:
        MoveL Offs(pTop_B,-nSprayDistance,0,50), v800, z10, Cascade_80MM\WObj:=table;
        MoveL pounce, v800, z10, Cascade_100MM\WObj:=table;
        MoveL home, v800, z10, Cascade_100MM\WObj:=table;

      RETURN;
    ENDPROC

	PROC Cooldown()
    TPErase;
    TPWrite "Cooldown selected";
    TPReadNum reg1, "How many minutes?";
    ! start turn table
		rotateTableAtSpeed 100;
		WaitTime reg1 * 60;
    ! stop turn table
		stopTableRotation;
	ENDPROC

ENDMODULE