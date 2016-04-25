OPENSCAD:=$(shell which openscad)
TARGET=STL

OPENSCAD_SETTINGS=$$fa=2;$$fs=0.3;

EXTRAS=configuration.scad shapes.scad

BEARING_FILES=3DO0001_Bearing_Joint.scad 3DO0002_Catenary_Effector_Rod.scad 3DO0002H_Catenary_Effector_Rod.scad 3DO0003_Delta_Arm.scad 3DO0004_ATC_Hub_End_Effector.scad 3DO0005_Limit_Switch_Interruptor.scad 3DO0006_Bearing_Fork.scad 3DO0002b_Catenary_Effector_Rod_Bearing_Cap.scad


BALLSTUD_FILES=3DO0002S_Catenary_Effector_Rod_ballcups.scad 3DO0002SH_Catenary_Effector_Rod_ballcups.scad 3DO0003S_Delta_Arm_M4.scad 3DO0004S_ATC_Hub_End_Effector_M4.scad 3DO0008_Delta_Arm_Connector.scad 3DO0012_Delta_pulley_152T.scad 3DO0013_608_Bearing_Block.scad 3DO0004Sb_ATC_Hub_End_Effector_M4_cap.scad 3DO0014_ATC_Hub_End_Effector_M4_M36.scad

BEARING_PARTS=$(join $(addsuffix $(TARGET)/, $(dir $(BEARING_FILES))), $(notdir $(BEARING_FILES:.scad=.stl))) 
BALLSTUD_PARTS=$(join $(addsuffix $(TARGET)/, $(dir $(BALLSTUD_FILES))), $(notdir $(BALLSTUD_FILES:.scad=.stl))) 


ballstud_parts : $(TARGET) $(BALLSTUD_PARTS)
bearing_parts : $(TARGET) $(BEARING_PARTS)

assembly: $(TARGET) $(TARGET)/assembly.stl

all: bearing_parts ballstud_parts assembly


$(TARGET) :
	mkdir -p $(TARGET)

$(TARGET)/%.stl : %.scad $(EXTRAS)
	@echo "Processing $@"
	$(OPENSCAD) -o $@ -D'$(OPENSCAD_SETTINGS);$(subst $(TARGET)/,,$(subst .stl,();,$@))' $<

clean :
	rm -f $(TARGETS) $(TARGET)/assembly.stl

