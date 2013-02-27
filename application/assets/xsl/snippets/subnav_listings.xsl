<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template name="subnav_listings">
	<xsl:param name="crumbs"/>
	<div class="threeColumn">
		<div class="padding15All">
			<div class="blueBar">
				<span class="listingBreadcrumbsContainer floatLeft">
					<h5>
						<a href="/listings/">
							<xsl:text>Categories</xsl:text>
						</a>
						<xsl:text> / </xsl:text>
						<xsl:apply-templates select="$crumbs/category" mode="crumb">
							<xsl:sort select="category_depth" data-type="number" order="ascending" />
						</xsl:apply-templates>
					</h5>
				</span>
				<a href="/listings/new" class="floatRight">Add Listing +</a>
			</div>
		</div>
	</div>
</xsl:template>

<xsl:template match="category" mode="crumb">
	<xsl:param name="parent_id" select="parent_id"/>
	<xsl:choose>
		<xsl:when test="category_depth=0">
		</xsl:when>
		<xsl:otherwise>
			<a>
				<xsl:attribute name="href">
					<xsl:text>/listings/category/</xsl:text>
					<xsl:apply-templates select="../category[category_id=$parent_id]" mode="crumbhref"/>
					<xsl:value-of select="category_slug"/>
					<xsl:text>/</xsl:text>
				</xsl:attribute>
				<xsl:value-of select="category_name"/>
			</a>
			<xsl:if test="position()!=last()">
				<xsl:text> / </xsl:text>
			</xsl:if>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template match="category" mode="crumbhref">
	<xsl:param name="parent_id" select="parent_id"/>
	<xsl:choose>
		<xsl:when test="category_slug='root'">
		</xsl:when>
		<xsl:otherwise>
			<xsl:apply-templates select="../category[category_id=$parent_id]" mode="crumbhref"/>
			<xsl:value-of select="category_slug"/>
			<xsl:text>/</xsl:text>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

</xsl:stylesheet>