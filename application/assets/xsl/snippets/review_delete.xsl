<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html" indent="yes" encoding="utf-8" omit-xml-declaration="yes" doctype-public="XSLT-compat"/>
<xsl:strip-space elements="*"/>

<xsl:include href="index.xsl"/>
<xsl:include href="snippets/subnav_profile.xsl"/>

<xsl:template match="/">
	<xsl:choose>
		<xsl:when test="root/meta/ajax=0">
			<xsl:apply-templates select="root"/>
		</xsl:when>
		<xsl:otherwise>
			<title>asdf</title>
			<xsl:apply-templates select="root"/>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template match="content">
	<div class="content">
		<xsl:call-template name="subnav_profile" />
		<div class="clearer"></div>
		<div class="threeColumn">
			<div class="padding15All">
				<div class="largeSectionWhite">
					<h4>Are you sure you want to delete this listing from your reviews?</h4>
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
					<form class="deleteReviewForm" action="" method="post">
						<input name="csrf" type="hidden">
							<xsl:attribute name="value"><xsl:value-of select="/root/meta/csrf"/></xsl:attribute>
						</input>
						<div class="deleteReview twoColumn alignCenter">
							<dl class="formSection">
								<!-- Delete -->
								<xsl:if test="errors/review_delete">
									<div class="formElementRight floatLeft">
										<span class="formError">
											<xsl:value-of select="errors/review_delete" />
										</span>
									</div>
									<div class="clearer"></div>
								</xsl:if>
								<dt class="floatLeft">
									<label for="reviewDelete">Type "Delete" to confirm</label>
								</dt>
								<dd class="halfPageTextbox floatLeft">
									<input class="reviewDelete" id="reviewDelete" type="text" name="reviewDelete" value="">
										<xsl:if test="errors/node()">
											<xsl:attribute name="value">
												<xsl:value-of select="validation/review_delete" />
											</xsl:attribute>
										</xsl:if>
									</input>
								</dd>
								<div class="clearer"></div>
								<div class="deleteReviewFormSubmit floatRight">
									<span class="formSubmit floatRight">
										<input class="formButton" type="submit" value="Cancel" />
									</span>
									<span class="formSubmit floatRight">
										<input class="formButton" type="submit" value="Delete" />
									</span>
								</div>
								<div class="clearer"></div>
							</dl>
						</div>
					</form>
					<div class="clearer"></div>
				</div>
			</div>
		</div>
		<div class="clearer"></div>
		<xsl:apply-templates />
	</div>
</xsl:template>

<xsl:template match="text()"/>

</xsl:stylesheet>