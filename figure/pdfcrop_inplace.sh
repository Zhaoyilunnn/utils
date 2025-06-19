#!/bin/bash

pdfcrop $1 tmp && mv tmp $1
