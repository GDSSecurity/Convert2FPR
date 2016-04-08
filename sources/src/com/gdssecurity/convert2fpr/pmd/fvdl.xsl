<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template match="/">

		<FVDL xmlns="xmlns://www.fortifysoftware.com/schema/fvdl"
			xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="1.11">
			<CreatedTS date="2015-08-17Z" time="22:09:48Z" />
			<UUID>
				<xsl:sequence select="generate-id(.)" />
			</UUID>
			<Build>
				<Project></Project>
				<Version></Version>
				<Label></Label>
				<BuildID></BuildID>
				<NumberFiles></NumberFiles>
				<SourceBasePath></SourceBasePath>
				<ScanTime value="35" />
			</Build>

			<Vulnerabilities>
				<xsl:for-each select="pmd/file">
					<xsl:for-each select="violation">
						<Vulnerability>
							<ClassInfo>
								<ClassID>classid-<xsl:value-of select="@rule" /></ClassID>
								<Kingdom>Security</Kingdom>
								<Type><xsl:value-of select="@rule"/></Type>
								<AnalyzerName>pmd</AnalyzerName>
								<DefaultSeverity>4.0</DefaultSeverity>
							</ClassInfo>
							<InstanceInfo>
								<InstanceID>instanceid-<xsl:sequence select="generate-id(.)" /></InstanceID>
								<InstanceSeverity>4.0</InstanceSeverity>
							</InstanceInfo>
							<AnalysisInfo>
								<Unified>
									<Context>
										<FunctionDeclarationSourceLocation>
											<xsl:attribute name="line" namespace="" select="@beginline" />
											<xsl:attribute name="lineEnd" namespace=""
												select="@endline" />
											<xsl:attribute name="path" namespace="" select="substring-after(../@name,'scanning')" />
										</FunctionDeclarationSourceLocation>
									</Context>
									<Trace>
										<Primary>
											<Entry>
												<Node isDefault="true">
													<SourceLocation>
														<xsl:attribute name="path" namespace=""
															select="substring-after(../@name,'scanning\')" />
														<xsl:attribute name="line" namespace=""
															select="@beginline" />
													</SourceLocation>
												</Node>
											</Entry>
										</Primary>
									</Trace>
								</Unified>
							</AnalysisInfo>
						</Vulnerability>

					</xsl:for-each>
				</xsl:for-each>
			</Vulnerabilities>

			<xsl:for-each select="pmd/file/violation">

				<Description>
					<xsl:attribute name="classID"
						select="concat('classid-', @rule)" />
					<Abstract><xsl:value-of select="@externalInfoUrl"/></Abstract>
        			
        			<Details><xsl:value-of select="@externalInfoUrl"/></Details>
				</Description>

			</xsl:for-each>

			<EngineData>
				<EngineVersion />
				<Properties />
				<CommandLine />
				<MachineInfo>
					<Hostname>Olivaw</Hostname>
				</MachineInfo>
			</EngineData>

		</FVDL>
	</xsl:template>

</xsl:stylesheet>