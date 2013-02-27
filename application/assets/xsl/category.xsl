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
					<h5>Category</h5>
				</div>
			</div>
		</div>
		<div class="clearer"></div>
		<div class="twoColumn alignCenter">
			<div class="padding15All">
				<div class="largeSectionWhite">
					<xsl:if test="successful_submission">
						<xsl:choose>
							<xsl:when test="successful_submission = 1">
								<span class="formResult formSuccessful">Submission successful, thank you</span>
							</xsl:when>
							<xsl:otherwise>
								<span class="formResult formFailed">Submission failed, please fix the errors and try again</span>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:if>
					<div class="clearer"></div>
					<form class="halfPageForm buyPremiumListingContactOwner" method="post">
						<xsl:attribute name="action">
							<xsl:value-of select="/root/meta/url"/>
						</xsl:attribute>
						<input name="csrf" type="hidden">
							<xsl:attribute name="value"><xsl:value-of select="/root/meta/csrf"/></xsl:attribute>
						</input>
						<dl class="formSection">

							<!-- Name -->
							<xsl:if test="errors/category_name">
								<span class="halfPageFormError formError floatLeft">
									<xsl:value-of select="errors/category_name" />
								</span>
								<div class="clearer"></div>
							</xsl:if>
							<dt class="floatLeft">
								<label for="category_name">Name</label>
							</dt>
							<dd class="halfPageTextbox floatLeft">
								<input class="contactOwnerTitle title" id="category_name" type="text" name="category_name" value="{/root/meta/post/category_name}" tabindex="1" />
							</dd>
							<div class="clearer"></div>

							<!-- Parent Category -->
							<xsl:if test="errors/parent_id">
								<div class="clearer"></div>
								<span class="formError floatLeft">
									<xsl:value-of select="errors/parent_id" />
								</span>
								<div class="clearer"></div>
							</xsl:if>
							<dt class="floatLeft">
								<label for="parent_id">Parent Category</label>
							</dt>
							<dd class="halfPageSelect floatLeft">
								<select id="parent_id" name="parent_id" tabindex="1">
									<option value="">Select a Parent Category</option>
									<xsl:apply-templates select="categories/category[category_slug='root']" mode="parent_category">
										<xsl:with-param name="selected" select="/root/meta/post/parent_id"/>
									</xsl:apply-templates>
								</select>
							</dd>

							<!-- Save -->
							<dt class="floatLeft"></dt>
							<dd class="formSubmit floatLeft">
								<input class="formButton floatRight" type="submit" value="Save" tabindex="1" />
							</dd>
							<div class="clearer"></div>
						</dl>
					</form>
				</div>
			</div>
		</div>
		<div class="clearer"></div>
	</div>
</xsl:template>

<xsl:template match="category" mode="parent_category">
	<xsl:param name="selected"/>
	<xsl:param name="parent_id" select="parent_id"/>
	<xsl:param name="category_id" select="category_id"/>
	<option>
		<xsl:if test="$selected = category_id">
			<xsl:attribute name="selected">selected</xsl:attribute>
		</xsl:if>
		<xsl:attribute name="value">
			<xsl:value-of select="category_id"/>
		</xsl:attribute>
		<xsl:call-template name="depth-marker">
			<xsl:with-param name="depth" select="category_depth"/>
		</xsl:call-template>
		<xsl:value-of select="category_name"/>
	</option>
	<xsl:apply-templates select="../category[parent_id=$category_id]" mode="parent_category">
		<xsl:with-param name="selected" select="$selected"/>
	</xsl:apply-templates>
</xsl:template>

<xsl:template name="depth-marker">
	<xsl:param name="depth"/>
	<xsl:if test="$depth &gt; 0">
		<xsl:call-template name="depth-marker">
			<xsl:with-param name="depth" select="$depth - 1"/>
		</xsl:call-template>
		<xsl:text>&amp;nbsp;&amp;nbsp;</xsl:text>
	</xsl:if>
</xsl:template>

<xsl:template match="text()"/>

</xsl:stylesheet>