<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html" indent="yes" encoding="utf-8" omit-xml-declaration="yes" doctype-public="XSLT-compat"/>
<xsl:strip-space elements="*"/>

<xsl:template match="pagination">
	<xsl:if test="total_pages&gt;1">
		<div class="pagination">
			<span class="pageLinks">
				<a class="pageLink pageLeft">
					<xsl:if test="previous_page != ''">
						<xsl:attribute name="href">
							<xsl:call-template name="url">
								<xsl:with-param name="page_num" select="previous_page"/>
							</xsl:call-template>
						</xsl:attribute>
					</xsl:if>
					<xsl:text>&lt;</xsl:text>
				</a>
				<xsl:call-template name="for.loop">
					<xsl:with-param name="i">
						<xsl:choose>
							<xsl:when test="first_page != ''">
								<xsl:value-of select="first_page"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:text>1</xsl:text>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:with-param>
					<xsl:with-param name="count" select="total_pages" />
					<xsl:with-param name="current_page" select="current_page" />
				</xsl:call-template>
				<a class="pageLink pageRight">
					<xsl:if test="next_page != ''">
						<xsl:attribute name="href">
							<xsl:call-template name="url">
								<xsl:with-param name="page_num" select="next_page"/>
							</xsl:call-template>
						</xsl:attribute>
					</xsl:if>
					<xsl:text>&gt;</xsl:text>
				</a>
			</span>
			<div id="loadmore" class="loadMoreSection" style="display: none;">
				<div class="loadMoreHeading">
					<h5>Load More</h5>
				</div>
				<div class="loadMoreButton"></div>
				<div class="clearer"></div>
			</div>
		</div>
	</xsl:if>
</xsl:template>

<xsl:template name="for.loop">
	<xsl:param name="i" select="1"/>
	<xsl:param name="count" />
	<xsl:param name="current_page" />

	<xsl:if test="$i &lt;= $count">
		<a>
			<xsl:attribute name="class">
				<xsl:text>pageLink</xsl:text>
				<xsl:if test="$i=$current_page">
					<xsl:text> selected</xsl:text>
				</xsl:if>
			</xsl:attribute>
			<xsl:if test="$i!=$current_page">
				<xsl:attribute name="href">
					<xsl:call-template name="url">
						<xsl:with-param name="page_num" select="$i"/>
					</xsl:call-template>
				</xsl:attribute>
			</xsl:if>
			<xsl:value-of select="$i"/>
		</a>
	</xsl:if>

	<xsl:if test="$i &lt;= $count">
		<xsl:call-template name="for.loop">
			<xsl:with-param name="i">
				<xsl:value-of select="$i + 1"/>
			</xsl:with-param>
			<xsl:with-param name="count">
				<xsl:value-of select="$count"/>
			</xsl:with-param>
			<xsl:with-param name="current_page">
				<xsl:value-of select="$current_page"/>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:if>
</xsl:template>

<xsl:template name="url">
	<xsl:param name="page_num"/>
	<xsl:value-of select="base"/>
	<xsl:value-of select="path"/>
	<xsl:text>?</xsl:text>
	<xsl:for-each select="/root/meta/query/node()">
		<xsl:if test="local-name()!='page'">
			<xsl:value-of select="local-name()"/><xsl:text>=</xsl:text><xsl:value-of select="text()"/>
			<xsl:text>&amp;</xsl:text>
		</xsl:if>
	</xsl:for-each>
	<xsl:value-of select="config/query_string/key"/>
	<xsl:text>=</xsl:text>
	<xsl:value-of select="$page_num"/>
</xsl:template>

<xsl:template match="text()"/>

</xsl:stylesheet>