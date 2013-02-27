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
					<h5>Report Issue</h5>
				</div>
			</div>
		</div>
		<div class="clearer"></div>
		<div class="twoColumn alignCenter">
			<div class="padding15All">
				<div class="largeSectionWhite">
					<div class="form halfPageForm">
						<div class="commentHeader">
							<p>Lorem Ipsum policy information</p>
						</div>
						<div class="clearer"></div>
						<xsl:if test="errors">
							<span class="formResult formFailed">
								<xsl:text>Submission failed, please fix the errors and try again</xsl:text>
							</span>
							<div class="clearer"></div>
						</xsl:if>
						<form class="contactUsForm" method="post">
							<xsl:attribute name="action">
								<xsl:value-of select="/root/meta/url"/>
							</xsl:attribute>
							<xsl:if test="errors/_external/csrf">
								<span class="formError floatLeft">
									<xsl:value-of select="errors/_external/csrf" />
								</span>
								<div class="clearer"></div>
							</xsl:if>
							<input name="csrf" type="hidden">
								<xsl:attribute name="value"><xsl:value-of select="/root/meta/csrf"/></xsl:attribute>
							</input>
							<dl class="formSection">
								<!-- Issue -->
								<xsl:if test="errors/report_category_id">
									<span class="formError floatLeft">
										<xsl:value-of select="errors/report_category_id" />
									</span>
									<div class="clearer"></div>
								</xsl:if>
								<dt class="floatLeft">
									<label for="reportIssue">Issue</label>
								</dt>
								<dd class="halfPageSelect floatLeft">
									<select id="reportIssue" name="report_category_id" tabindex="1">
										<xsl:apply-templates select="report_categories/report_category"/>
									</select>
								</dd>
								<div class="clearer"></div>

								<!-- Title -->
								<xsl:if test="errors/report_title">
									<span class="formError floatLeft">
										<xsl:value-of select="errors/report_title" />
									</span>
									<div class="clearer"></div>
								</xsl:if>
								<dt class="floatLeft">
									<label for="report_title">Title</label>
								</dt>
								<dd class="halfPageTextbox floatLeft">
									<input class="loginForgotUsername" id="loginForgotUsername" type="text" name="report_title" value="{/root/meta/post/report_title}" tabindex="1" />
								</dd>
								<div class="clearer"></div>

								<!-- Comments -->
								<xsl:if test="errors/report_text">
									<span class="formError floatLeft">
										<xsl:value-of select="errors/report_text" />
									</span>
									<div class="clearer"></div>
								</xsl:if>
								<dt class="floatLeft">
									<label for="reportComments">Comments</label>
								</dt>
								<dd class="halfPageTextarea floatLeft">
									<textarea id="reportComments" name="report_text" tabindex="1">
										<xsl:value-of select="/root/meta/post/report_text"/>
									</textarea>
								</dd>
								<div class="clearer"></div>

								<!-- ReCAPTCHA -->
								<xsl:apply-templates select="recaptcha">
									<xsl:with-param name="tabindex" select="1"/>
									<xsl:with-param name="theme" select="2"/>
								</xsl:apply-templates>
								<div class="clearer"></div>

								<!-- Submit -->
								<dt class="floatLeft"></dt>
								<dd class="formSubmit floatLeft">
									<input class="formButton floatRight" type="submit" value="Submit" tabindex="1"/>
								</dd>
								<div class="clearer"></div>
							</dl>
						</form>
					</div>
				</div>
			</div>
		</div>
		<div class="clearer"></div>
	</div>
</xsl:template>

<xsl:template match="report_category">
	<option>
		<xsl:attribute name="value"><xsl:value-of select="report_category_id"/></xsl:attribute>
		<xsl:if test="/root/meta/post/report_category_id = report_category_id">
			<xsl:attribute name="selected">
				<xsl:text>selected</xsl:text>
			</xsl:attribute>
		</xsl:if>
		<xsl:value-of select="report_category_name"/>
	</option>
</xsl:template>

<xsl:template match="text()"/>

</xsl:stylesheet>