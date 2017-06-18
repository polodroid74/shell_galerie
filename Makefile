# Source and destination directories, to be configured here:
SOURCE=./tests/galerie_style
DEST=./tests/dest
ABS=$$(cd "$$(dirname ".")" && pwd)

IMAGES=${shell cd $(SOURCE) && echo *.jpg}
THUMBS=$(IMAGES:%=$(DEST)/%)
IMAGE_DESC=$(IMAGES:%.jpg=$(DEST)/%.inc)
HTML=$(THUMBS:%=%.html)  #génération des fichiers HTML pour images pleines


# TODO

$(DEST)/%.inc : $(SOURCE)/%.jpg
	./generate-img-fragment.sh  $$(basename $<) $(ABS) $(SOURCE) > $@

$(DEST)/index.html : $(DEST)
	 ./concat.sh $(DEST) > $@


$(DEST)/%.jpg.html : $(SOURCE)/%.jpg 		#règle pour la création des fichiers HTML pour images pleines.
	./imagespleines.sh $(ABS)/$< > $@


$(DEST)/%.jpg : $(SOURCE)/%.jpg
	cp $< $@			# On copie le fichier avnt de le convertir (convert réécrit sur le fichier source).
	convert -resize 200x200 $@ $@ 

.PHONY: gallery

gallery: ./exiftags $(IMAGE_DESC) $(DEST)/index.html   $(THUMBS) $(HTML)

.PHONY: view

view: gallery
	firefox $(DEST)/index.html &

.PHONY:clean
clean:		
	rm -f $(THUMBS) $(IMAGE_DESC) $(DEST)/index.html $(HTML)
#-f permet d'eviter les messages d'erreurs dans le cas de fichiers inexistants.	

# Simplified version of exiftags's Makefile
EXIFTAGS_OBJS=exiftags-1.01/exif.o exiftags-1.01/tagdefs.o exiftags-1.01/exifutil.o \
	exiftags-1.01/exifgps.o exiftags-1.01/jpeg.o exiftags-1.01/makers.o \
	exiftags-1.01/canon.o exiftags-1.01/olympus.o exiftags-1.01/fuji.o \
	exiftags-1.01/nikon.o exiftags-1.01/casio.o exiftags-1.01/minolta.o \
	exiftags-1.01/sanyo.o exiftags-1.01/asahi.o exiftags-1.01/leica.o \
	exiftags-1.01/panasonic.o exiftags-1.01/sigma.o exiftags-1.01/exiftags.o
EXIFTAGS_HDRS=exiftags-1.01/exif.h exiftags-1.01/exifint.h \
	exiftags-1.01/jpeg.h exiftags-1.01/makers.h

%.o: %.c $(EXIFTAGS_HDRS)
	$(CC) $(CFLAGS) -o $@ -c $<

./exiftags: $(EXIFTAGS_OBJS)
	$(CC) $(CFLAGS) -o $@ $(EXIFTAGS_OBJS) -lm

