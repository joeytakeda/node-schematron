<xsl:transform version="2.0"
               xmlns="http://www.w3.org/1999/XSL/TransformAlias"
               xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
               xmlns:sch="http://purl.oclc.org/dsdl/schematron"
               xmlns:error="https://doi.org/10.5281/zenodo.1495494#error"
               xmlns:schxslt="https://doi.org/10.5281/zenodo.1495494"
               xmlns:schxslt-api="https://doi.org/10.5281/zenodo.1495494#api"
               xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
               xmlns:xs="http://www.w3.org/2001/XMLSchema"
               xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:param name="svrl" as="xs:string"/>
    <xsl:output method="json"/>
    <xsl:mode name="json" on-no-match="shallow-skip"/>

    <xsl:template match="/">
        <xsl:apply-templates select="svrl:*"/>
    </xsl:template>

    <xsl:template match="text()"/>

    <xsl:template match="svrl:successful-report">
        <xsl:map>
            <xsl:for-each select="svrl:text">
                <xsl:map-entry key="local-name()" select="string(.)"/>
            </xsl:for-each>
        </xsl:map>
    </xsl:template>

</xsl:transform>