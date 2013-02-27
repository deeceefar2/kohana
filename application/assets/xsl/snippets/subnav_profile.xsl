<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template name="subnav_profile">
	<div class="threeColumn">
		<div class="padding15All">
			<div class="blueBar">
				<h5 class="floatLeft">
					<a href="/profile">
						<xsl:attribute name="class">
							<xsl:choose>
								<xsl:when test="/root/meta/controller='profile'">
									<xsl:text>selected</xsl:text>
								</xsl:when>
							</xsl:choose>
						</xsl:attribute>
						Profile
					</a>
				</h5>
				<h5 class="floatLeft">
					<a href="/profile/bookmarks">
						<xsl:attribute name="class">
							<xsl:choose>
								<xsl:when test="/root/meta/controller='bookmarks'">
									<xsl:text>selected</xsl:text>
								</xsl:when>
							</xsl:choose>
						</xsl:attribute>
						Bookmarks
					</a>
				</h5>
				<h5 class="floatLeft">
					<a href="/profile/reviews">
						<xsl:attribute name="class">
							<xsl:choose>
								<xsl:when test="/root/meta/controller='reviews'">
									<xsl:text>selected</xsl:text>
								</xsl:when>
							</xsl:choose>
						</xsl:attribute>
						My Reviews
					</a>
				</h5>
				<h5 class="floatLeft">
					<a href="/profile/account">
						<xsl:attribute name="class">
							<xsl:choose>
								<xsl:when test="/root/meta/controller='account'">
									<xsl:text>selected</xsl:text>
								</xsl:when>
							</xsl:choose>
						</xsl:attribute>
						Account
					</a>
				</h5>
				<h5 class="floatLeft">
					<a href="/profile/listings">
						<xsl:attribute name="class">
							<xsl:choose>
								<xsl:when test="/root/meta/controller='listings'">
									<xsl:text>selected</xsl:text>
								</xsl:when>
							</xsl:choose>
						</xsl:attribute>
						My Listings
					</a>
				</h5>
				<h5 class="floatLeft">
					<a href="/profile/referrals">
						<xsl:attribute name="class">
							<xsl:choose>
								<xsl:when test="/root/meta/controller='referrals'">
									<xsl:text>selected</xsl:text>
								</xsl:when>
							</xsl:choose>
						</xsl:attribute>
						Referrals
					</a>
				</h5>
				<xsl:choose>
					<xsl:when test="/root/meta/controller='profile' or
									/root/meta/controller='account'">
						<span class="expandHideAllSections floatRight">
							<h5 class="expandHide expandAll" style="display: none;">Expand All +</h5>
							<h5 class="expandHide" style="display: block;">Collapse All -</h5>
						</span>
					</xsl:when>
					<xsl:when test="/root/meta/controller='listings'">
						<a class="myListingsAddListing floatRight" href="/list">Add Listing +</a>
					</xsl:when>
				</xsl:choose>
			</div>
		</div>
	</div>
</xsl:template>

</xsl:stylesheet>