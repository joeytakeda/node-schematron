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
        <xsl:variable name="transform" select="transform(
            map{
                'stylesheet-text': $svrl,
                'source-node': /
            }
        )"/>
        <xsl:map>
            <xsl:for-each-group select="$transform?output/svrl:schematron-output/svrl:*" group-by="local-name()">
                <xsl:message select="current-grouping-key()"/>
                <xsl:map-entry key="current-grouping-key()">
                    <xsl:variable name="results" as="map(*)*">
                        <xsl:apply-templates select="current-group()" mode="json"/>
                    </xsl:variable>
                    <xsl:sequence select="array{$results}"/>
                </xsl:map-entry>
            </xsl:for-each-group>
        </xsl:map>
    </xsl:template>

    <xsl:template match="svrl:*" mode="json" as="map(*)">
        <xsl:map>
            <xsl:for-each select="@*, svrl:text">
                <xsl:map-entry key="local-name()" select="string(.)"/>
            </xsl:for-each>
        </xsl:map>
    </xsl:template>


</xsl:transform>