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
					<h5>Bookmark Delete</h5>
				</div>
			</div>
		</div>
		<div class="clearer"></div>
		<div class="twoColumn alignCenter">
			<div class="padding15All">
				<div class="largeSectionWhite">
					<h4>Are you sure you want to delete your bookmark for "<xsl:value-of select="listing/listing_name"/>"?</h4>
					<xsl:if test="errors">
						<span class="formResult formFailed">Submission failed, please fix the errors and try again</span>
					</xsl:if>
					<div class="clearer"></div>
					<form class="deleteBookmarkForm" method="post">
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
								<xsl:if test="errors/bookmark_delete">
									<div class="formElementRight floatLeft">
										<span class="formError">
											<xsl:value-of select="errors/bookmark_delete" />
										</span>
									</div>
									<div class="clearer"></div>
								</xsl:if>
								<!-- Delete Confirm Box -->
								<dt class="floatLeft">
									<label for="bookmarkDelete">Type "Delete"</label>
								</dt>
								<dd class="halfPageTextbox floatLeft">
									<input class="bookmarkDelete" id="bookmarkDelete" type="text" name="bookmarkDelete" value="">
										<xsl:if test="errors != ''">
											<xsl:attribute name="value">
												<xsl:value-of select="validation/bookmark_delete" />
											</xsl:attribute>
										</xsl:if>
									</input>
								</dd>
								<div class="clearer"></div>

								<!-- Form Buttons -->
								<dt class="floatLeft"></dt>
								<dd class="formsubmit floatRight">
										<input class="formButton floatRight" type="submit" value="Delete" />
										<a href="/profile/bookmarks" class="formButton">Cancel</a>
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