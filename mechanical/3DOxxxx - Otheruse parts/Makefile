OPENSCAD:=$(shell which openscad)
TARGET=STL

OPENSCAD_SETTINGS=$$fa=3;$$fs=0.2;

EXTRAS=configuration.scad shapes.scad

FILES=3DO0001_Bearing_Joint.scad 3DO0002_Catenary_Effector_Rod.scad 3DO0002H_Catenary_Effector_Rod.scad 3DO0003_Delta_Arm.scad 3DO0004_ATC_Hub_End_Effector.scad 3DO0005_Delta_Arm_Connector.scad

PARTS=$(join $(addsuffix $(TARGET)/, $(dir $(FILES))), $(notdir $(FILES:.scad=.stl))) 


TARGETS=$(PARTS)

all: parts 
parts : $(TARGET) $(TARGETS)

$(TARGET) :
	mkdir -p $(TARGET)

$(TARGET)/%.stl : %.scad $(EXTRAS)
	@echo "Processing $@"
	$(OPENSCAD) -o $@ -D'$(OPENSCAD_SETTINGS)' $<

clean :
	rm @-rm -f $(TARGET) $(TARGETS)

