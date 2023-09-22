<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    exclude-result-prefixes="xs math xd"
    version="3.0">
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Apr 17, 2023</xd:p>
            <xd:p><xd:b>Author:</xd:b> takeda</xd:p>
            <xd:p></xd:p>
        </xd:desc>
    </xd:doc>

    <xsl:output method="json"/>
    
    <xsl:mode on-no-match="shallow-skip"/>
        
    <xsl:template match="*:successful-report | *:failed-assert">
        <xsl:map>
            <xsl:apply-templates select="@*|*"/>
        </xsl:map>
    </xsl:template>
    
    <xsl:template match="*:failed-assert/@* | *:successful-report/@*">
        <xsl:map-entry key="local-name(.)" select="normalize-space(.)"/>
    </xsl:template>
    
    <xsl:template match="*:text">
        <xsl:map-entry key="'text'" select="normalize-space(.)"/>
    </xsl:template>
</xsl:stylesheet>