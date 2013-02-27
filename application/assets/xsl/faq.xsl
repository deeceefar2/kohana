<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html" indent="yes" encoding="utf-8" omit-xml-declaration="yes" doctype-public="XSLT-compat"/>
<xsl:strip-space elements="*"/>

<xsl:include href="index.xsl"/>
<xsl:include href="snippets/subnav_help.xsl"/>
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
		<xsl:call-template name="subnav_help" />
		<div class="clearer"></div>
		<div class="threeColumn">
			<div class="padding15All">
				<div class="largeSectionWhite">
					<h3>Frequently Asked Questions</h3>
					<div class="floatLeft" style="margin-top: 2px; font-size: 16px; width: 350px;">The most common questions that users have about the website.</div>
					<div class="floatRight">
						<h4 class="floatLeft">Search for a question:</h4>
						<div class="form fullPageForm faqForm floatLeft">
							<form class="faqSearchForm" method="get">
								<xsl:attribute name="action">
									<xsl:value-of select="/root/meta/url"/>
								</xsl:attribute>
								<span class="searchBar">
									<span class="formTextbox formTextbox270 floatLeft">
										<input class="faqSearch" id="faqSearch" type="text" name="question_title">
											<xsl:attribute name="value">
												<xsl:choose>
													<xsl:when test="/root/meta/query/question_title">
														<xsl:value-of select="/root/meta/query/question_title"/>
													</xsl:when>
												</xsl:choose>
											</xsl:attribute>
										</input>
									</span>
									<span class="formSubmit floatLeft">
										<input class="faqSearchSubmit" type="submit" value="" />
									</span>
									<div class="clearer"></div>
								</span>
							</form>
							<div class="clearer"></div>
						</div>
						<div class="clearer"></div>
					</div>
					<div class="clearer"></div>
				</div>
			</div>
		</div>
		<div class="clearer"></div>
		<xsl:apply-templates select="question_sections"/>
		<div class="clearer"></div>
		<div class="threeColumn">
			<div class="padding15All">
				<div class="largeSectionWhite">
					<h5>Ask A Question</h5>
					<xsl:if test="errors">
						<span class="formResult formFailed">Submission failed, please fix the errors and try again</span>
					</xsl:if>
					<div class="clearer"></div>
					<form class="fullPageForm faqQuestionForm" method="post">
						<xsl:attribute name="action">
							<xsl:value-of select="/root/meta/url"/>
						</xsl:attribute>
						<xsl:if test="errors/csrf">
							<span class="fullPageFormError formError floatLeft">
								<xsl:value-of select="errors/csrf" />
							</span>
							<div class="clearer"></div>
						</xsl:if>
						<input name="csrf" type="hidden">
							<xsl:attribute name="value"><xsl:value-of select="/root/meta/csrf"/></xsl:attribute>
						</input>
						<dl class="formSection">


							<!-- Email -->
							<xsl:if test="errors/faq_email">
								<span class="fullPageFormError formError floatLeft">
									<xsl:value-of select="errors/faq_email" />
								</span>
								<div class="clearer"></div>
							</xsl:if>
							<dd class="halfPageTextbox floatLeft">
								<input class="faqEmail email" id="faq_email" type="text" name="faq_email" placeholder="Your e-mail Address" tabindex="1">
									<xsl:if test="/root/meta/post/faq_email">
										<xsl:attribute name="value">
											<xsl:value-of select="/root/meta/post/faq_email" />
										</xsl:attribute>
									</xsl:if>
								</input>
							</dd>
							<div class="clearer"></div>

							<!-- Comments -->
							<xsl:if test="errors/faq_question">
								<span class="fullPageFormError formError floatLeft">
									<xsl:value-of select="errors/faq_question" />
								</span>
								<div class="clearer"></div>
							</xsl:if>
							<dd class="fullPageTextarea floatLeft">
								<textarea id="faq_question" name="faq_question" placeholder="What is your question?" tabindex="2">
									<xsl:if test="/root/meta/post/faq_question">
										<xsl:value-of select="/root/meta/post/faq_question" />
									</xsl:if>
								</textarea>
							</dd>
							<div class="clearer"></div>

							<!-- ReCAPTCHA -->
							<div class="floatRight">
							<xsl:apply-templates select="recaptcha">
								<xsl:with-param name="tabindex" select="3"/>
								<xsl:with-param name="theme" select="1"/>
							</xsl:apply-templates>
							</div>
							<div class="clearer"></div>

							<!-- Send Button -->
							<dt class="floatLeft"></dt>
							<dd class="formSubmit floatRight">
								<input class="formButton floatRight" type="submit" value="Send"  tabindex="4"/>
							</dd>
						</dl>
					</form>
					<div class="clearer"></div>
				</div>
			</div>
		</div>
	</div>
</xsl:template>

<xsl:template match="question_sections">
	<div class="threeColumn">
		<div class="padding15All">
			<div class="largeSectionWhite">
				<span class="expandHideAllQuestions floatRight">
					<h5 class="expandHide expandAll">Expand All +</h5>
					<h5 class="expandHide hideAll">Collapse All -</h5>
				</span>
				<div class="faqContent">
					<xsl:apply-templates select="question_section"/>
				</div>
				<div class="clearer"></div>
			</div>
		</div>
	</div>
</xsl:template>

<xsl:template match="question_section">
	<xsl:param name="question_section_id" select="question_section_id"/>
	<div class="faqSection">
		<h5><xsl:value-of select="question_section_title"/></h5>
		<xsl:apply-templates select="/root/content/questions/question[question_section_id=$question_section_id]"/>
	</div>
</xsl:template>

<xsl:template match="question">
	<xsl:if test="question_answer != ''">
		<span class="expandableSection question">
			<div class="sectionTitle">
				<span class="bold lightBlueText">
					<xsl:text>Q: </xsl:text>
				</span>
				<a class="questionText lightBlueText">
					<xsl:call-template name="findreplace">
						<xsl:with-param name="haystack" select="question_title"/>
						<xsl:with-param name="delimiter" select="/root/meta/query/question_title"/>
						<xsl:with-param name="element" select="'b'"/>
					</xsl:call-template>
					<xsl:text>?</xsl:text>
				</a>
				<span class="expandHideIndividualSection">
					<div class="plusSmallBlue"></div>
					<div class="minusSmallBlue" style="display: none;"></div>
				</span>
			</div>
			<div class="clearer"></div>
			<span class="collapsible answer">
				<span class="answerTextContainer">
					<span class="bold">A: </span>
					<span class="answerText">
						<xsl:call-template name="findreplace">
							<xsl:with-param name="haystack" select="question_answer"/>
							<xsl:with-param name="delimiter" select="/root/meta/query/question_title"/>
							<xsl:with-param name="element" select="'b'"/>
						</xsl:call-template>
					</span>
				</span>
			</span>
			<div class="clearer"></div>
		</span>
		<div class="clearer"></div>
	</xsl:if>
</xsl:template>

<!--
<xsl:variable name="uc" select="ABCDEFGHIJKLMNOPQRSTUVWXYZ"/>
<xsl:variable name="lc" select="abcdefghijklmnopqrstuvwxyz"/>
<xsl:when test="translate($text, $lc, $uc) = translate($delimiter, $lc, $uc)">
-->

<xsl:template name="findreplace">
	<xsl:param name="haystack"/>
	<xsl:param name="delimiter"/>
	<xsl:param name="element"/>
	<xsl:choose>
		<xsl:when test="contains($haystack, $delimiter)">
			<xsl:value-of select="substring-before($haystack, $delimiter)"/>
			<xsl:element name="{$element}">
				<xsl:value-of select="$delimiter"/>
			</xsl:element>
			<xsl:value-of select="substring-after($haystack, $delimiter)"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="$haystack"/>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>


<xsl:template match="text()"/>

</xsl:stylesheet>