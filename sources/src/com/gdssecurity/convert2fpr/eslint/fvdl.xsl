<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="/">

<FVDL xmlns="xmlns://www.fortifysoftware.com/schema/fvdl" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="1.11">  
<CreatedTS date="2015-08-17Z" time="22:09:48Z"/>
  <UUID>
    <xsl:sequence select="generate-id(.)" />
  </UUID>
  <Build>
    <Project></Project>
    <Version></Version>
    <Label></Label>
    <BuildID></BuildID>
    <NumberFiles>48</NumberFiles>
    <SourceBasePath></SourceBasePath>
    <ScanTime value="35"/>
  </Build>

   <Vulnerabilities>
   <xsl:for-each select="jslint/file/issue">
  
      <Vulnerability>
        <ClassInfo>
          <ClassID>classid-<xsl:sequence select="generate-id(.)" /></ClassID>
          <Kingdom>Security</Kingdom>
          <Type>ESLint Security Issue</Type>
          <AnalyzerName>eslint</AnalyzerName>
          <DefaultSeverity>3.0</DefaultSeverity>
        </ClassInfo>
        <InstanceInfo>
          <InstanceID>instanceid-<xsl:sequence select="generate-id(.)" /></InstanceID>
          <InstanceSeverity>3.0</InstanceSeverity>
        </InstanceInfo>
        <AnalysisInfo>
          <Unified>
            <Context>
              <FunctionDeclarationSourceLocation>
                <xsl:attribute name="line" namespace="" select="@line" />
                <xsl:attribute name="lineEnd" namespace="" select="@line" />
                <xsl:attribute name="path" namespace="" select="../@name" />
                <xsl:attribute name="snippet" namespace="" select="concat('snippet-', generate-id(.))" />
              </FunctionDeclarationSourceLocation>
            </Context>
            <Trace>
                <Primary>
                  <Entry>
                    <Node isDefault="true">
                      <SourceLocation>
                           <xsl:attribute name="path" namespace="" select="../@name" />
                           <xsl:attribute name="line" namespace="" select="@line" />
                           <xsl:attribute name="snippet" namespace="" select="concat('snippet-', generate-id(.))" />
                      </SourceLocation>
                      <Action type="InOutCall">None</Action>
                  
                      <Reason>
                        <Internal text="None" />
                      </Reason>
                    </Node>
                  </Entry>
                </Primary>
            </Trace>
          </Unified>
        </AnalysisInfo>
      </Vulnerability>

    </xsl:for-each>
  </Vulnerabilities>

<xsl:for-each select="jslint/file/issue">

      <Description>
        <xsl:attribute name="classID" select="concat('classid-', generate-id(.))" />
        <Abstract><xsl:value-of select="@reason"/></Abstract>
        <Details>None</Details>
      </Description>

</xsl:for-each>

  <Snippets>
    <xsl:for-each select="jslint/file/issue">

    <Snippet>
      <xsl:attribute name="id" select="concat('snippet-', generate-id(.))" />

      <File><xsl:value-of select="../@name"/></File>
      <StartLine><xsl:value-of select="@line"/></StartLine>
      <EndLine><xsl:value-of select="@line"/></EndLine>
      <Text>
            <xsl:value-of disable-output-escaping="yes"
              select="'&lt;![CDATA['" />
            <xsl:value-of disable-output-escaping="yes">
                      <xsl:value-of select="@evidence"/>
            </xsl:value-of>
            <xsl:value-of disable-output-escaping="yes" select="']]&gt;'" />
      </Text>
    </Snippet>

    </xsl:for-each>

  </Snippets>

 <EngineData>
    <EngineVersion/>
    <Properties/>
    <CommandLine/>
    <MachineInfo>
      <Hostname>None</Hostname>
      <Username>None</Username>
      <Platform>None</Platform>
    </MachineInfo>
  </EngineData>

</FVDL>
</xsl:template>

</xsl:stylesheet>