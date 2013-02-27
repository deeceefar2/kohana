<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html" indent="yes" encoding="utf-8" omit-xml-declaration="yes" doctype-public="XSLT-compat"/>
<xsl:strip-space elements="*"/>

<xsl:include href="index.xsl"/>
<xsl:include href="snippets/recaptcha.xsl"/>

<xsl:template match="/">
	<xsl:choose>
		<xsl:when test="root/meta/ajax != ''">
			<xsl:apply-templates select="/root/content"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:apply-templates select="root"/>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template match="content">
	<div class="content">
		<div class="threeColumn">
			<div class="padding15All">
				<div class="blueBar">
					<a href="/listings/">
						<xsl:text>Browse</xsl:text>
					</a>
					<xsl:text> / </xsl:text>
				</div>
			</div>
		</div>
		<div class="clearer"></div>
		<div class="threeColumn">
			<div class="padding15All">
				<div class="largeSectionWhite">
					<form class="advancedSearchForm" method="get">
						<xsl:attribute name="action">
							<xsl:value-of select="/root/meta/url"/>
						</xsl:attribute>
						<h3>Advanced Search</h3>
						<h4>Words</h4>
						<dl class="formSection">
							<!-- Exact Phrase -->
							<xsl:if test="errors/words_exact_phrase">
								<div class="formElementRight floatRight">
									<span class="formError">
										<xsl:value-of select="errors/words_exact_phrase" />
									</span>
								</div>
								<div class="clearer"></div>
							</xsl:if>
							<dt class="floatLeft">
								<label for="wordsExactPhrase">Exact Phrase</label>
							</dt>
							<dd class="halfPageTextbox floatLeft">
								<input class="wordsExactPhrase" id="wordsExactPhrase" type="text" name="wordsExactPhrase" value="">
									<xsl:if test="errors != ''">
										<xsl:attribute name="value">
											<xsl:value-of select="validation/words_exact_phrase" />
										</xsl:attribute>
									</xsl:if>
								</input>
							</dd>

							<!-- All -->
							<xsl:if test="errors/words_all">
								<div class="formElementRight floatRight">
									<span class="formError">
										<xsl:value-of select="errors/words_all" />
									</span>
								</div>
								<div class="clearer"></div>
							</xsl:if>
							<dt class="floatLeft">
								<label for="wordsAll">All</label>
							</dt>
							<dd class="halfPageTextbox floatLeft">
								<input class="wordsAll" id="wordsAll" type="text" name="wordsAll" value="">
									<xsl:if test="errors != ''">
										<xsl:attribute name="value">
											<xsl:value-of select="validation/words_all" />
										</xsl:attribute>
									</xsl:if>
								</input>
							</dd>
							<div class="clearer"></div>

							<!-- Exclude -->
							<xsl:if test="errors/words_exclude">
								<div class="formElementRight floatRight">
									<span class="formError">
										<xsl:value-of select="errors/words_exclude" />
									</span>
								</div>
								<div class="clearer"></div>
							</xsl:if>
							<dt class="floatLeft">
								<label for="wordsExclude">Exclude</label>
							</dt>
							<dd class="halfPageTextbox floatLeft">
								<input class="wordsExclude" id="wordsExclude" type="text" name="wordsExclude" value="">
									<xsl:if test="errors != ''">
										<xsl:attribute name="value">
											<xsl:value-of select="validation/words_exclude" />
										</xsl:attribute>
									</xsl:if>
								</input>
							</dd>

							<!-- Any -->
							<xsl:if test="errors/advanced_search_any">
								<div class="formElementRight floatRight">
									<span class="formError">
										<xsl:value-of select="errors/words_any" />
									</span>
								</div>
								<div class="clearer"></div>
							</xsl:if>
							<dt class="floatLeft">
								<label for="wordsAny">Any</label>
							</dt>
							<dd class="halfPageTextbox floatLeft">
								<input class="wordsAny" id="wordsAny" type="text" name="wordsAny" value="">
									<xsl:if test="errors != ''">
										<xsl:attribute name="value">
											<xsl:value-of select="validation/words_any" />
										</xsl:attribute>
									</xsl:if>
								</input>
							</dd>
						</dl>
						<div class="clearer"></div>
						<div class="formSpacer"></div>
						<h4>Location</h4>
						<dl class="formSection">
							<!-- City -->
							<xsl:if test="errors/location_city">
								<div class="formElementRight floatRight">
									<span class="formError">
										<xsl:value-of select="errors/location_city" />
									</span>
								</div>
								<div class="clearer"></div>
							</xsl:if>
							<dt class="floatLeft">
								<label for="locationCity">City</label>
							</dt>
							<dd class="halfPageTextbox floatLeft">
								<input class="locationCity" id="locationCity" type="text" name="locationCity" value="">
									<xsl:if test="errors != ''">
										<xsl:attribute name="value">
											<xsl:value-of select="validation/location_city" />
										</xsl:attribute>
									</xsl:if>
								</input>
							</dd>

							<!-- Zipcode -->
							<xsl:if test="errors/location_zipcode">
								<div class="formElementRight floatRight">
									<span class="formError">
										<xsl:value-of select="errors/location_zipcode" />
									</span>
								</div>
								<div class="clearer"></div>
							</xsl:if>
							<dt class="floatLeft">
								<label for="locationZipcode">Zipcode</label>
							</dt>
							<dd class="halfPageTextbox floatLeft">
								<input class="locationZipcode" id="locationZipcode" type="text" name="locationZipcode" value="">
									<xsl:if test="errors != ''">
										<xsl:attribute name="value">
											<xsl:value-of select="validation/location_zipcode" />
										</xsl:attribute>
									</xsl:if>
								</input>
							</dd>
							<div class="clearer"></div>

							<!-- Within -->
							<xsl:if test="errors/location_within">
								<div class="formElementRight floatRight">
									<span class="formError">
										<xsl:value-of select="errors/location_within" />
									</span>
								</div>
								<div class="clearer"></div>
							</xsl:if>
							<dt class="floatLeft">
								<label for="locationWithin">Within</label>
							</dt>
							<dd class="halfPageSelect floatLeft">
								<select id="locationWithin" name="locationWithin">
									<option value="default">
										<xsl:if test="errors != ''">
											<xsl:if test="validation/location_within = 'default'">
												<xsl:attribute name="selected">
													<xsl:text>selected</xsl:text>
												</xsl:attribute>
											</xsl:if>
										</xsl:if>
									</option>
									<option value="10">
										<xsl:if test="errors != ''">
											<xsl:if test="validation/location_within = '10'">
												<xsl:attribute name="selected">
													<xsl:text>selected</xsl:text>
												</xsl:attribute>
											</xsl:if>
										</xsl:if>
										10 miles
									</option>
									<option value="25">
										<xsl:if test="errors != ''">
											<xsl:if test="validation/location_within = '25'">
												<xsl:attribute name="selected">
													<xsl:text>selected</xsl:text>
												</xsl:attribute>
											</xsl:if>
										</xsl:if>
										25 miles
									</option>
									<option value="50">
										<xsl:if test="errors != ''">
											<xsl:if test="validation/location_within = '50'">
												<xsl:attribute name="selected">
													<xsl:text>selected</xsl:text>
												</xsl:attribute>
											</xsl:if>
										</xsl:if>
										50 miles
									</option>
								</select>
							</dd>
						</dl>
						<div class="clearer"></div>
						<div class="formSpacer"></div>
						<h4>Type</h4>
						<dl class="formSection">
							<!-- Type -->
							<xsl:if test="errors/type_type">
								<div class="formElementRight floatRight">
									<span class="formError">
										<xsl:value-of select="errors/type_type" />
									</span>
								</div>
								<div class="clearer"></div>
							</xsl:if>
							<dt class="floatLeft">
								<label for="selectType">Select</label>
							</dt>
							<dd class="halfPageSelect floatLeft">
								<select id="selectType" name="selectType">
									<option value="default"></option>
									<option value="hospital">Hospital</option>
									<option value="clinic">Clinic</option>
									<option value="pharmacy">Pharmacy</option>
								</select>
							</dd>
							<div class="clearer"></div>

							<!-- Search -->
							<dt class="floatLeft"></dt>
							<dd class="formSubmit floatRight">
								<input class="formButton floatRight" type="submit" value="Search" />
							</dd>
							<div class="clearer"></div>
						</dl>
					</form>
				</div>
			</div>
		</div>
		<div class="clearer"></div>
		<xsl:apply-templates />
	</div>
</xsl:template>

<xsl:template match="text()"/>

</xsl:stylesheet>