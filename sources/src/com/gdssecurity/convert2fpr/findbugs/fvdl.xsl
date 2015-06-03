<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	version="2.0" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2005/xpath-functions"
	exclude-result-prefixes="xs fn">
	<xsl:preserve-space elements="Description" />
	<xsl:template match="/">
		<xsl:variable name="var1_resultof_cast" as="xs:integer"
			select="xs:integer(xs:decimal('0'))" />
		<xsl:variable name="var2_BugCollection" as="node()?"
			select="BugCollection" />
		<FVDL xmlns="xmlns://www.fortifysoftware.com/schema/fvdl"
			xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="1.3"
			xsi:type="FVDL">
			<xsl:attribute name="version" namespace=""
				select="xs:string(xs:decimal('1.12'))" />
			<xsl:variable as="xs:dateTime" name="fdate">
				<xsl:value-of
					select='xs:dateTime("1970-01-01T00:00:00") + //BugCollection/@timestamp * xs:dayTimeDuration("PT0.001S")' />
			</xsl:variable>
			<xsl:variable name="ftime" as="xs:dateTime">
				<xsl:value-of
					select='xs:dateTime("1970-01-01T00:00:00") + //BugCollection/@timestamp * xs:dayTimeDuration("PT0.001S")' />
			</xsl:variable>
			<CreatedTS>
				<xsl:attribute name="date"><xsl:value-of
					select="format-dateTime($fdate,'[Y0001]-[M01]-[D01]')" /></xsl:attribute>
				<xsl:attribute name="time"><xsl:value-of
					select="format-dateTime($fdate,'[H01]:[m01]:[s01]')" /></xsl:attribute>
			</CreatedTS>
			<xsl:for-each select="$var2_BugCollection">
				<UUID>
					<xsl:sequence select="generate-id(.)" />
				</UUID>
			</xsl:for-each>
			<Build>
				<xsl:for-each select="$var2_BugCollection">
					<BuildID>
						<xsl:sequence
							select="fn:string(*:Project[fn:namespace-uri() eq '']/@projectName)" />
					</BuildID>
				</xsl:for-each>
				<xsl:for-each select="$var2_BugCollection">
					<NumberFiles>
						<xsl:sequence
							select="xs:string(xs:integer(fn:string(*:FindBugsSummary[fn:namespace-uri() eq '']/@total_classes)))" />
					</NumberFiles>
				</xsl:for-each>
				<xsl:for-each select="$var2_BugCollection">
					<LOC>
						<xsl:attribute name="type" namespace="" select="'Line Count'" />
						<xsl:sequence
							select="xs:string(xs:integer(fn:string(*:FindBugsSummary[fn:namespace-uri() eq '']/@total_size)))" />
					</LOC>
				</xsl:for-each>
				<SourceBasePath></SourceBasePath>
				<SourceFiles>
					<File>
						<xsl:attribute name="size" namespace=""
							select="xs:string($var1_resultof_cast)" />
						<xsl:attribute name="timestamp" namespace=""
							select="xs:string($var1_resultof_cast)" />
						<xsl:attribute name="type" namespace="" select="''" />
						<xsl:attribute name="encoding" namespace="" select="''" />
						<Name></Name>
					</File>
				</SourceFiles>
				<ScanTime>
					<xsl:for-each select="$var2_BugCollection">
						<xsl:attribute name="value" namespace=""
							select="xs:string(xs:integer(xs:decimal(fn:string(*:FindBugsSummary[fn:namespace-uri() eq '']/@cpu_seconds))))" />
					</xsl:for-each>
				</ScanTime>
			</Build>
			<Vulnerabilities>
				<xsl:for-each
					select="$var2_BugCollection/*:BugInstance[fn:namespace-uri() eq '']">
					<xsl:variable name="var3_resultof_cast" as="xs:string"
						select="xs:string(xs:decimal('4.0'))" />
					<xsl:variable name="var4_resultof_cast" as="xs:string"
						select="xs:string($var1_resultof_cast)" />
					<Vulnerability>
						<ClassInfo>
							<ClassID>
								<xsl:sequence select="fn:string(@type)" />
							</ClassID>

							<xsl:variable name="bugAbbrev">
								<xsl:value-of select="@abbrev" />
							</xsl:variable>
							<xsl:variable name="bugCategory">
								<xsl:value-of select="@category" />
							</xsl:variable>
							<xsl:variable name="bugCodeDescription">
								<xsl:value-of select="//BugCode[@abbrev=$bugAbbrev]/text()" />
							</xsl:variable>
							<xsl:choose>
								<xsl:when test="@type = 'ST_WRITE_TO_STATIC_FROM_INSTANCE_METHOD'">
									<Kingdom>Time and State</Kingdom>
								</xsl:when>
								<xsl:when test="@type = 'DM_EXIT'">
									<Kingdom>Time and State</Kingdom>
								</xsl:when>
								<xsl:when test="@type = 'CN_IDIOM_NO_SUPER_CALL'">
									<Kingdom>API Abuse</Kingdom>
								</xsl:when>
								<xsl:when test="@type = 'DM_GC'">
									<Kingdom>API Abuse</Kingdom>
								</xsl:when>
								<xsl:when test="@type = 'FI_PUBLIC_SHOULD_BE_PROTECTED'">
									<Kingdom>Encapsulation</Kingdom>
								</xsl:when>
								<xsl:when test="$bugAbbrev = 'SQL'">
									<Kingdom>Input Validation and Representation</Kingdom>
								</xsl:when>
								<xsl:when test="$bugAbbrev = 'Se'">
									<Kingdom>Time and State</Kingdom>
								</xsl:when>
								<xsl:when test="$bugAbbrev = 'SnVI'">
									<Kingdom>Time and State</Kingdom>
								</xsl:when>
								<xsl:when test="$bugAbbrev = 'PS'">
									<Kingdom>Time and State</Kingdom>
								</xsl:when>
								<xsl:when test="$bugAbbrev = 'MTIA'">
									<Kingdom>Time and State</Kingdom>
								</xsl:when>
								<xsl:when test="$bugAbbrev = 'J2EE'">
									<Kingdom>Time and State</Kingdom>
								</xsl:when>
								<xsl:when test="$bugAbbrev = 'STI'">
									<Kingdom>Time and State</Kingdom>
								</xsl:when>
								<xsl:when test="$bugAbbrev = 'SW'">
									<Kingdom>Time and State</Kingdom>
								</xsl:when>
								<xsl:when test="$bugAbbrev = 'RR'">
									<Kingdom>API Abuse</Kingdom>
								</xsl:when>
								<xsl:when test="$bugAbbrev = 'SR'">
									<Kingdom>API Abuse</Kingdom>
								</xsl:when>
								<xsl:when test="$bugAbbrev = 'RV'">
									<Kingdom>API Abuse</Kingdom>
								</xsl:when>
								<xsl:when test="$bugAbbrev = 'FI'">
									<Kingdom>API Abuse</Kingdom>
								</xsl:when>
								<xsl:when test="$bugAbbrev = 'HE'">
									<Kingdom>API Abuse</Kingdom>
								</xsl:when>
								<xsl:when test="$bugAbbrev = 'AM'">
									<Kingdom>API Abuse</Kingdom>
								</xsl:when>
								<xsl:when test="$bugAbbrev = 'BOA'">
									<Kingdom>API Abuse</Kingdom>
								</xsl:when>
								<xsl:when test="$bugAbbrev = 'BRSA'">
									<Kingdom>API Abuse</Kingdom>
								</xsl:when>
								<xsl:when test="$bugAbbrev = 'RE'">
									<Kingdom>API Abuse</Kingdom>
								</xsl:when>
								<xsl:when test="$bugAbbrev = 'REC'">
									<Kingdom>Errors</Kingdom>
								</xsl:when>
								<xsl:when test="$bugAbbrev = 'DE'">
									<Kingdom>Errors</Kingdom>
								</xsl:when>
								<xsl:when test="$bugAbbrev = 'IMSE'">
									<Kingdom>Errors</Kingdom>
								</xsl:when>
								<xsl:when test="$bugCategory = 'MALICIOUS_CODE'">
									<Kingdom>Encapsulation</Kingdom>
								</xsl:when>
								<xsl:when test="$bugCategory = 'MT_CORRECTNESS'">
									<Kingdom>Time and State</Kingdom>
								</xsl:when>
								<xsl:otherwise>
									<Kingdom>Code Quality</Kingdom>
								</xsl:otherwise>
							</xsl:choose>
							<xsl:variable name="bugAbbrev">
								<xsl:value-of select="@abbrev" />
							</xsl:variable>
							<xsl:variable name="bugCategory">
								<xsl:value-of select="@category" />
							</xsl:variable>
							<xsl:variable name="bugCodeDescription">
								<xsl:value-of select="//BugCode[@abbrev=$bugAbbrev]/text()" />
							</xsl:variable>
							<Type>
								<xsl:value-of select="$bugCodeDescription" />
							</Type>
							<AnalyzerName>findbugs</AnalyzerName>
							<xsl:variable name="priority">
								<xsl:value-of select="@priority" />
							</xsl:variable>
							<DefaultSeverity><xsl:value-of select="4-$priority" />.0</DefaultSeverity>
							<FindbugsCategory>
								<xsl:sequence select="fn:string(@category)" />
							</FindbugsCategory>
						</ClassInfo>
						<InstanceInfo>
							<xsl:variable name="priority">
								<xsl:value-of select="@priority" />
							</xsl:variable>
							<InstanceID>fb-<xsl:sequence select="generate-id(.)" /></InstanceID>
							<InstanceSeverity><xsl:value-of select="4-$priority" />.0</InstanceSeverity>
							<InstanceDescription>
								<xsl:variable name="current_type">
									<xsl:value-of select="@type" />
								</xsl:variable>
								<xsl:value-of
									select="//BugPattern[@type=$current_type]/ShortDescription" />
							</InstanceDescription>
							<xsl:variable name="bugCategory">
								<xsl:value-of select="@category" />
							</xsl:variable>
							<xsl:choose>
								<xsl:when test="$bugCategory = 'CORRECTNESS'">
									<Confidence>5.0</Confidence>
								</xsl:when>
								<xsl:when test="$bugCategory = 'MALICIOUS_CODE'">
									<Confidence>4.0</Confidence>
								</xsl:when>
								<xsl:when test="$bugCategory = 'BAD_PRACTICE'">
									<Confidence>4.0</Confidence>
								</xsl:when>
								<xsl:otherwise>
									<Confidence>3.0</Confidence>
								</xsl:otherwise>
							</xsl:choose>
						</InstanceInfo>
						<xsl:variable name="classContainingBug">
							<xsl:value-of select="Class[0]/@classname" />
						</xsl:variable>
						<xsl:variable name="packageContainingBug">
							<xsl:value-of
								select="replace($classContainingBug,'(^[^.]+$)|(\.[^.]+$)','')" />
						</xsl:variable>
						<AnalysisInfo>
							<Unified>
								<Context>
									<NamespaceIdent>
										<xsl:attribute name="name"><xsl:value-of
											select="$packageContainingBug" /></xsl:attribute>
									</NamespaceIdent>
								</Context>
								<Trace>
									<Primary>
										<Entry>
											<Node isDefault="true">
												<SourceLocation>
													<xsl:for-each select="*:Class/SourceLine[fn:namespace-uri() eq '']">
														<xsl:attribute name="path" namespace=""
															select="fn:string(@sourcepath)" />
													</xsl:for-each>
													<xsl:choose>
							<xsl:when
								test="not(*:Method/SourceLine/@start)" >
								<xsl:for-each select="*:Class/SourceLine">
														<xsl:attribute name="line" namespace=""
															select="fn:string(@start)" />
													</xsl:for-each>
							</xsl:when>
							<xsl:otherwise>
								<xsl:for-each select="*:Method/SourceLine">
														<xsl:attribute name="line" namespace=""
															select="fn:string(@start)" />
													</xsl:for-each>
							</xsl:otherwise>
						</xsl:choose>
						
												
												</SourceLocation>
											</Node>
										</Entry>
									</Primary>
								</Trace>
							</Unified>
						</AnalysisInfo>
					</Vulnerability>
				</xsl:for-each>
			</Vulnerabilities>
			<ContextPool>
				<xsl:for-each
					select="$var2_BugCollection/*:BugInstance[fn:namespace-uri() eq '']">
					<xsl:variable name="var8_current" as="node()" select="." />
					<xsl:for-each select="*:Method[fn:namespace-uri() eq '']">
						<xsl:variable name="var5_resultof_cast" as="xs:integer"
							select="xs:integer(xs:decimal('1'))" />
						<xsl:variable name="var6_resultof_cast" as="xs:string"
							select="xs:string($var1_resultof_cast)" />
						<Context>
							<Function>
								<xsl:attribute name="name" namespace=""
									select="fn:string(@name)" />
								<xsl:attribute name="namespace" namespace=""
									select="fn:string(@signature)" />
								<xsl:for-each select="$var8_current/*:Class[fn:namespace-uri() eq '']">
									<xsl:attribute name="enclosingClass" namespace=""
										select="fn:string(@classname)" />
								</xsl:for-each>
							</Function>
							<FunctionDeclarationSourceLocation>
								<xsl:for-each select="*:SourceLine[fn:namespace-uri() eq '']">
									<xsl:attribute name="path" namespace=""
										select="fn:string(@classname)" />
								</xsl:for-each>
								<xsl:for-each
									select="*:SourceLine[fn:namespace-uri() eq ''][fn:exists(@start)]">
									<xsl:attribute name="line" namespace=""
										select="xs:string(xs:integer(fn:string(@start)))" />
								</xsl:for-each>
								<xsl:for-each
									select="*:SourceLine[fn:namespace-uri() eq ''][fn:exists(@end)]">
									<xsl:attribute name="lineEnd" namespace=""
										select="xs:string(xs:integer(fn:string(@end)))" />
								</xsl:for-each>
								<xsl:attribute name="colStart" namespace=""
									select="$var6_resultof_cast" />
								<xsl:attribute name="colEnd" namespace=""
									select="$var6_resultof_cast" />
							</FunctionDeclarationSourceLocation>
						</Context>
					</xsl:for-each>
				</xsl:for-each>
			</ContextPool>
			<xsl:for-each select="//BugInstance">
				<xsl:variable name="current_type" select="@type" />
				<Description xmlns="xmlns://www.fortifysoftware.com/schema/fvdl">
					<xsl:attribute name="classID">
						<xsl:value-of select="$current_type" />
					</xsl:attribute>
					<xsl:attribute name="contentType">html</xsl:attribute>
					<Abstract>
						<xsl:value-of select="//BugPattern[@type=$current_type]/ShortDescription" />
					</Abstract>
					<Explanation>
						<xsl:choose>
							<xsl:when
								test="string-length(//BugPattern[@type=$current_type]/LongDescription) &gt; string-length(//BugPattern[@type=$current_type]/Details) ">
								<xsl:value-of
									select="//BugPattern[@type=$current_type]/LongDescription" />
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="//BugPattern[@type=$current_type]/Details" />
							</xsl:otherwise>
						</xsl:choose>
					</Explanation>
				</Description>
			</xsl:for-each>
			<EngineData>
				<EngineVersion>6.10.0120</EngineVersion>
				<Properties>
					<xsl:attribute name="type" namespace="" select="'System'" />
					<Property>
						<name>user.dir</name>
						<xsl:for-each select="$var2_BugCollection">
							<value>
								<xsl:sequence
									select="fn:string(*:Project[fn:namespace-uri() eq '']/*:Jar[fn:namespace-uri() eq ''])" />
							</value>
						</xsl:for-each>
					</Property>
				</Properties>
				<Errors>
					<Error>
						<xsl:variable name='newline'>
							<xsl:text>
							</xsl:text>
						</xsl:variable>
						<xsl:attribute name="code" namespace=""
							select="xs:string(xs:integer('1237'))" />
						<xsl:variable name="var9_resultof_map" as="xs:string*">
							<xsl:for-each
								select="$var2_BugCollection/*:Errors[fn:namespace-uri() eq '']/*:MissingClass[fn:namespace-uri() eq '']">
								<xsl:sequence select="fn:string(.)" />
							</xsl:for-each>
						</xsl:variable>
						<xsl:value-of disable-output-escaping="yes"
							select="'&lt;![CDATA['" />
						<xsl:value-of disable-output-escaping="yes">
							<xsl:sequence
								select="fn:concat('The following references could not be resolved. Please make sure to supply all the required files that contain these classes to SCA.', fn:string-join($var9_resultof_map, $newline))" />
						</xsl:value-of>
						<xsl:value-of disable-output-escaping="yes" select="']]&gt;'" />
					</Error>
				</Errors>
			</EngineData>
		</FVDL>
	</xsl:template>
</xsl:stylesheet>