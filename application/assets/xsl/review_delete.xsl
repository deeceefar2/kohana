<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html" indent="yes" encoding="utf-8" omit-xml-declaration="yes" doctype-public="XSLT-compat"/>
<xsl:strip-space elements="*"/>

<xsl:include href="index.xsl"/>
<xsl:include href="snippets/subnav_profile.xsl"/>

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
					<h5>Review Delete</h5>
				</div>
			</div>
		</div>
		<div class="clearer"></div>
		<div class="twoColumn alignCenter">
			<div class="padding15All">
				<div class="largeSectionWhite">
					<h4>Are you sure you want to delete your review for "<xsl:value-of select="listing/listing_name"/>"?</h4>
					<xsl:if test="errors">
						<span class="formResult formFailed">Submission failed, please fix the errors and try again</span>
					</xsl:if>
					<div class="clearer"></div>
					<form class="deleteReviewForm" method="post">
						<xsl:attribute name="action">
							<xsl:value-of select="/root/meta/url"/>
						</xsl:attribute>
						<xsl:if test="errors/csrf">
							<span class="formError floatLeft">
								<xsl:value-of select="errors/csrf" />
							</span>
							<div class="clearer"></div>
						</xsl:if>
						<input name="csrf" type="hidden">
							<xsl:attribute name="value"><xsl:value-of select="/root/meta/csrf"/></xsl:attribute>
						</input>
						<div class="halfPageForm">
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
								<!-- Delete Confirm Box -->
								<dt class="floatLeft">
									<label for="reviewDelete">Type "Delete"</label>
								</dt>
								<dd class="halfPageTextbox floatLeft">
									<input class="reviewDelete" id="reviewDelete" type="text" name="reviewDelete" value="">
										<xsl:if test="errors != ''">
											<xsl:attribute name="value">
												<xsl:value-of select="validation/review_delete" />
											</xsl:attribute>
										</xsl:if>
									</input>
								</dd>
								<div class="clearer"></div>

								<!-- Delete & Cancel Buttons -->
								<dt class="floatLeft"></dt>
								<dd class="formSubmit floatLeft">
									<input class="formButton floatLeft" type="submit" value="Delete" />
									<a href="/profile/reviews" class="formButton floatRight">Cancel</a>
								</dd>
								<div class="clearer"></div>
							</dl>
						</div>
					</form>
					<div class="clearer"></div>
				</div>
			</div>
		</div>
		<div class="clearer"></div>
	</div>
</xsl:template>

<xsl:template match="text()"/>

</xsl:stylesheet>