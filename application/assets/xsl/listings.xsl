<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html" indent="yes" encoding="utf-8" omit-xml-declaration="yes" doctype-public="XSLT-compat"/>
<xsl:strip-space elements="*"/>

<xsl:include href="index.xsl"/>

<xsl:include href="snippets/listing_small.xsl" />
<xsl:include href="snippets/categories.xsl"/>
<xsl:include href="snippets/states.xsl"/>
<xsl:include href="snippets/pagination.xsl"/>
<xsl:include href="snippets/subnav_listings.xsl" />

<xsl:template match="/">
	<xsl:choose>
		<xsl:when test="root/meta/ajax != ''">
			<xsl:apply-templates select="/root/content/listings/listing"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:apply-templates select="root"/>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template match="content">
	<div class="content">
		<xsl:call-template name="subnav_listings">
			<xsl:with-param name="crumbs" select="crumbs"/>
		</xsl:call-template>

		<div class="threeColumn">
			<div class="padding15All">
				<div class="browseSearch largeSectionWhite">
					<form class="browseForm" method="get">
						<dl class="browseFormSection">

							<!-- State -->
							<xsl:if test="errors/state">
								<span class="formError floatLeft">
									<xsl:value-of select="errors/state" />
								</span>
								<div class="clearer"></div>
							</xsl:if>
							<dd class="select floatLeft">
								<select id="registerState" name="state" tabindex="1">
									<xsl:call-template name="states">
										<xsl:with-param name="selected" select="/root/meta/query/state" />
									</xsl:call-template>
								</select>
							</dd>

							<!-- Within -->
							<xsl:if test="errors/within">
								<span class="formError floatLeft">
									<xsl:value-of select="errors/within" />
								</span>
								<div class="clearer"></div>
							</xsl:if>
							<span class="darkGrayText floatLeft">Within</span>
							<dd class="select floatLeft">
								<select id="browseWithin" name="browseWithin">
									<option value="5">5 Miles</option>
									<option value="10">10 Miles</option>
									<option value="25">25 Miles</option>
									<option value="50">50 Miles</option>
									<option value="100">100 Miles</option>
								</select>
							</dd>

							<span class="floatLeft">Of</span>

							<!-- City -->
							<xsl:if test="errors/city">
								<span class="formError floatLeft">
									<xsl:value-of select="errors/city" />
								</span>
								<div class="clearer"></div>
							</xsl:if>
							<dt class="darkGrayText floatLeft">
								<label for="reportTitle">City</label>
							</dt>
							<dd class="textbox floatLeft">
								<input id="city" type="text" name="city" value="{/root/meta/query/city}" />
							</dd>

							<span class="floatLeft">Or</span>

							<!-- Zipcode -->
							<xsl:if test="errors/zip">
								<span class="formError floatLeft">
									<xsl:value-of select="errors/zip" />
								</span>
								<div class="clearer"></div>
							</xsl:if>
							<dt class="darkGrayText floatLeft">
								<label for="zip">Zip</label>
							</dt>
							<dd class="textbox floatLeft">
								<input id="zip" type="text" name="zip" value="{/root/meta/query/zip}" style="width: 50px;" />
							</dd>


							<!-- Rating -->
							<script type="text/javascript">
								$(function(){
									$("#starify").children().not(":input").hide();

									// Create stars from :radio boxes
									$("#starify").stars({
										cancelShow: false
									});
								});
							</script>
							<dd id="starify" class="floatLeft" style="margin-top: 5px;">
								<label for="vote1" class="blockLabel">
									<input type="radio" name="rating" id="vote1" value="1">
										<xsl:if test="/root/meta/query/rating=1">
											<xsl:attribute name="checked">checked</xsl:attribute>
										</xsl:if>
									</input>
								</label>
								<label for="vote2" class="blockLabel">
									<input type="radio" name="rating" id="vote2" value="2">
										<xsl:if test="/root/meta/query/rating=2">
											<xsl:attribute name="checked">checked</xsl:attribute>
										</xsl:if>
									</input>
								</label>
								<label for="vote3" class="blockLabel">
									<input type="radio" name="rating" id="vote3" value="3">
										<xsl:if test="/root/meta/query/rating=3">
											<xsl:attribute name="checked">checked</xsl:attribute>
										</xsl:if>
									</input>
								</label>
								<label for="vote4" class="blockLabel">
									<input type="radio" name="rating" id="vote4" value="4">
										<xsl:if test="/root/meta/query/rating=4 or not(/root/meta/query/rating)">
											<xsl:attribute name="checked">checked</xsl:attribute>
										</xsl:if>
									</input>
								</label>
								<label for="vote5" class="blockLabel">
									<input type="radio" name="rating" id="vote5" value="5">
										<xsl:if test="/root/meta/query/rating=5">
											<xsl:attribute name="checked">checked</xsl:attribute>
										</xsl:if>
									</input>
								</label>
							</dd>

							<!-- Go -->
							<dd class="floatRight">
								<input id="search" class="formButton" type="submit" value="Go" tabindex="4"/>
							</dd>
						</dl>
					</form>
					<div class="clearer"></div>
				</div>
			</div>
		</div>
		<div class="clearer"></div>

		<div>
			<xsl:attribute name="class">
				<xsl:text>listings</xsl:text>
				<xsl:choose>
					<xsl:when test="/root/meta/action='category'">
						<xsl:text> categories</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text> browse</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>

			<div class="oneColumn floatLeft">
				<div class="padding15All">
					<div class="whiteBar">
						<div class="browseToggleSection">
							<a class="browseHeading">
								<h5>Browse Categories</h5>
							</a>
							<div class="browseButton">
								<a class="browseButtonToggle browseOpen">
								</a>
								<a class="browseButtonToggle browseClose">
								</a>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="twoColumn floatLeft">
				<div class="padding15All">
					<div class="resultsBreadcrumbContainer whiteBar">
						<xsl:if test="crumbs">
							<span class="resultsText darkGrayText">Showing results for: </span>
							<span style="color:#1d76bb">
								<xsl:value-of select="crumbs/category[last()]/category_name"/>
							</span>
						</xsl:if>
					</div>
				</div>
			</div>
			<div class="clearer"></div>

			<div class="browseColumn oneColumn floatLeft">
				<xsl:if test="/root/meta/action='category'">
					<xsl:attribute name="style">display: block;</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="categories"/>
			</div>
			<div class="browseResults threeColumn floatRight">
				<xsl:if test="/root/meta/action = 'category'">
					<xsl:attribute name="class">
						<xsl:text>browseResults twoColumn floatRight</xsl:text>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="listings"/>
			</div>
			<div class="clearRight"></div>
			<xsl:if test="/root/meta/pagination/total_pages &gt; 1">
				<div class="loadMoreResults threeColumn floatRight">
					<xsl:if test="/root/meta/action = 'category'">
						<xsl:attribute name="class">
							<xsl:text>loadMoreResults twoColumn floatRight</xsl:text>
						</xsl:attribute>
					</xsl:if>
					<div class="padding15All">
						<div class="whiteBar">
							<xsl:apply-templates select="/root/meta/pagination"/>
						</div>
					</div>
				</div>
				<div class="clearer"></div>
			</xsl:if>
		</div>
	</div>
</xsl:template>

<xsl:template match="listings">
	<div class="listingContainer">
		<xsl:apply-templates select="listing"/>
	</div>
</xsl:template>

<xsl:template match="text()"/>

</xsl:stylesheet>