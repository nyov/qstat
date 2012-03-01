<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:media="http://search.yahoo.com/mrss/" xmlns:rsscache="data:,rsscache">
<!-- xmlns:media="http://search.yahoo.com/mrss/" xmlns:rsscache="data:,rsscache" xmlns:cms="data:,cms" -->
<xsl:output cdata-section-elements="description" method="xml" indent="yes"/>

<xsl:strip-space elements="gametype"/>
<xsl:variable name="lowercase" select="'abcdefghijklmnopqrstuvwxyz'" />
<xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />


<xsl:template name="item">
<!--
<qstat>
	<server type="Q3S" address="78.159.99.170:27982" status="UP">
		<hostname>78.159.99.170:27982</hostname>
		<name>Vanilla! TAG</name>
		<gametype>excessiveplus</gametype>
		<map>q3dm3</map>
		<numplayers>4</numplayers>
		<maxplayers>18</maxplayers>
		<numspectators>0</numspectators>
		<maxspectators>0</maxspectators>
		<ping>14</ping>
		<retries>0</retries>
		<rules>
			<rule name="game">excessiveplus</rule>
			<rule name="punkbuster">0</rule>
			<rule name="pure">0</rule>
			<rule name="gametype">8</rule>
			<rule name="protocol">68</rule>
			<rule name="version">Q3 1.32c linux-i386 May  8 2006</rule>
			<rule name="dmflags">0</rule>
			<rule name="fraglimit">5</rule>
			<rule name="timelimit">20</rule>
			<rule name="g_gametype">8</rule>
			<rule name="sv_hostname">Vanilla^2! ^7TAG</rule>
			<rule name="sv_punkbuster">0</rule>
			<rule name="sv_maxRate">25000</rule>
			<rule name="sv_pure">0</rule>
			<rule name="sv_allowDownload">1</rule>
			<rule name="bot_minplayers">2</rule>
			<rule name=".Admin">edy, easy</rule>
			<rule name=".Email">servers@excessiveplus.net</rule>
			<rule name="gamename">excessiveplus</rule>
			<rule name="g_needpass">0</rule>
			<rule name="g_redTeam">^1RED</rule>
			<rule name="g_blueTeam">^4BLUE</rule>
			<rule name="xp_version">2.2b-dev vanilla.cfg aeb2c33b78d2d55b8d2a413fca1db262 Vanilla Excessive v2.2</rule>
			<rule name="xp_date">Jul 28 2011</rule>
			<rule name="Uptime">12:51:00</rule>
			<rule name="Info">Z&#9;&#9;1 &#9;2 1 6 1 &#9;4 4 4 4 &#9;Z Z Z Z &#9;</rule>
		</rules>
		<players>
			<player>
				<name>Daemia</name>
				<score>0</score>
				<ping>0</ping>
			</player>
			<player>
				<name>Klesk</name>
				<score>2</score>
				<ping>0</ping>
			</player>
			<player>
				<name>Mynx</name>
				<score>0</score>
				<ping>0</ping>
			</player>
			<player>
				<name>Phobos</name>
				<score>1</score>
				<ping>0</ping>
			</player>
		</players>
	</server>

          <player>
                                <name>wei suo nan ?</name>
                                <score>12</score>
                                <time>23m1s</time>
                        </player>
-->
<xsl:for-each select="qstat/server">
<xsl:sort select="numplayers" data-type="number" order="descending"/>
<xsl:if test="hostname">
<xsl:if test="name != '?'">
<xsl:if test="@status = 'UP'">
<!-- xsl:if test="@type = 'Q3S'" -->
<!-- xsl:if test="gametype = 'defrag'" -->

<xsl:variable name="numbots">
<xsl:value-of select="count(players/player/ping[text() = '0'])"/>
</xsl:variable>
<!-- xsl:if test="$numbots = 0">
<xsl:variable name="numbots">
<xsl:value-of select="count(players/player/time[text() = '-1s'])"/>
</xsl:variable>
</xsl:if -->

<item>

<category>
<!-- xsl:value-of disable-output-escaping="yes" select="gametype"/ -->
<xsl:for-each select="rules/rule">
<xsl:if test="@name = 'gamename'"><xsl:value-of disable-output-escaping="yes" select="translate (., $uppercase, $lowercase)"/></xsl:if>
</xsl:for-each>
</category>

<title>
<xsl:choose>
<xsl:when test="name != ''"><xsl:value-of select="name"/></xsl:when>
<xsl:otherwise><xsl:value-of disable-output-escaping="yes" select="hostname"/></xsl:otherwise>
</xsl:choose>
</title>

<link><xsl:value-of disable-output-escaping="yes" select="hostname"/></link>

<description>
<!-- -->Server: <xsl:value-of select="name"/>
<!-- -->&lt;br/&gt;Hostname: <xsl:value-of disable-output-escaping="yes" select="hostname"/>&lt;br/&gt;<!-- -->

<xsl:for-each select="rules/rule">
<xsl:if test="@name = 'gamename'">Game: <xsl:value-of disable-output-escaping="yes" select="."/>&lt;br/&gt;</xsl:if>
<xsl:if test="@name = 'version'">Version: <xsl:value-of disable-output-escaping="yes" select="."/>&lt;br/&gt;</xsl:if>
<xsl:if test="@name = 'gametype'">Gametype: <xsl:value-of disable-output-escaping="yes" select="."/>&lt;br/&gt;</xsl:if>
<xsl:if test="@name = 'fraglimit'">Fraglimit: <xsl:value-of disable-output-escaping="yes" select="."/>&lt;br/&gt;</xsl:if>
<xsl:if test="@name = 'capturelimit'">Capturelimit: <xsl:value-of disable-output-escaping="yes" select="."/>&lt;br/&gt;</xsl:if>
<xsl:if test="@name = 'timelimit'">Timelimit: <xsl:value-of disable-output-escaping="yes" select="."/>&lt;br/&gt;</xsl:if>
<xsl:if test="@name = 'protocol'">Protocol: <xsl:value-of disable-output-escaping="yes" select="."/>&lt;br/&gt;</xsl:if>
</xsl:for-each>
<xsl:if test="$numbots != 0">
<!-- -->Bots: <xsl:value-of disable-output-escaping="yes" select="$numbots"/>&lt;br/&gt;<!-- -->
</xsl:if>
<!-- -->Map: <xsl:value-of disable-output-escaping="yes" select="map"/>&lt;br/&gt;<!-- -->
<!-- -->Players: <xsl:value-of disable-output-escaping="yes" select="numplayers"/>/<xsl:value-of disable-output-escaping="yes" select="maxplayers"/>&lt;br/&gt;<!-- -->
<xsl:if test="maxspectators != 0">
<!-- -->Spectators: <xsl:value-of disable-output-escaping="yes" select="numspectators"/>/<xsl:value-of disable-output-escaping="yes" select="maxspectators"/>&lt;br/&gt;<!-- -->
</xsl:if>

<xsl:for-each select="players/player">
<xsl:sort select="score" data-type="number" order="descending"/>

<xsl:if test="position() = 1">
<!-- -->Score<!-- -->
<xsl:if test="ping">&amp;nbsp;&amp;nbsp;Ping</xsl:if>
<xsl:if test="time">&amp;nbsp;&amp;nbsp;Time</xsl:if>
<!-- -->&lt;br/&gt;<!-- -->
</xsl:if>

<xsl:value-of select="score"/> frags&amp;nbsp;&amp;nbsp;<!-- -->
<xsl:if test="ping">
<xsl:value-of select="ping"/>ms&amp;nbsp;&amp;nbsp;<!-- -->
</xsl:if>
<xsl:if test="time">
<xsl:value-of select="time"/>&amp;nbsp;&amp;nbsp;<!-- -->
</xsl:if>
<xsl:value-of disable-output-escaping="yes" select="name"/>&lt;br/&gt;<!-- -->
</xsl:for-each>

<!-- Rules: <xsl:for-each select="rules/rule"><xsl:value-of disable-output-escaping="yes" select="."/>/</xsl:for-each -->

</description>

<xsl:choose>
<xsl:when test="gametype != ''">
<media:thumbnail url="http://static.pwnoogle.com/levelshots_{translate (gametype, $uppercase, $lowercase)}/{translate (map, $uppercase, $lowercase)}.jpg" 
media:url="http://static.pwnoogle.com/levelshots_{translate (gametype, $uppercase, $lowercase)}/{translate (map, $uppercase, $lowercase)}.jpg" />
</xsl:when>
<xsl:otherwise>
<media:thumbnail url="http://static.pwnoogle.com/levelshots_idtech3/{translate (map, $uppercase, $lowercase)}.jpg" 
media:url="http://static.pwnoogle.com/levelshots_idtech3/{translate (map, $uppercase, $lowercase)}.jpg" />
</xsl:otherwise>
</xsl:choose>

<rsscache:rating>
<xsl:choose>
<xsl:when test="numplayers &gt; maxplayers">0</xsl:when><!-- it happens -->
<xsl:when test="(numplayers - $numbots) &gt; 0"><xsl:value-of select="(numplayers - $numbots) div maxplayers"/></xsl:when>
<xsl:otherwise>0</xsl:otherwise>
</xsl:choose>
</rsscache:rating>

</item>
<!-- /xsl:if -->
<!-- /xsl:if -->
</xsl:if>
</xsl:if>
</xsl:if>
</xsl:for-each>
</xsl:template>


<xsl:template name="channel">
<channel>
<title>qstat_xml2rss.xsl</title>
<link>http://wiki.pwnoogle.com/</link>
<description><![CDATA[transform qstat output into RSS (with by-ping detection of bots and server rating ((players - bots) / slots))<br/>
USAGE: qstat ... -P -R -xml | xsltproc qstat_xml2rss.xsl -]]></description>
<xsl:call-template name="item"/>
</channel>
</xsl:template>


<xsl:template match="/">
<rss version="2.0" xmlns:media="http://search.yahoo.com/mrss/"><!-- xmlns:rsscache="data:,rsscache" xmlns:cms="data:,cms" -->
<xsl:call-template name="channel"/>
</rss>
</xsl:template>


</xsl:stylesheet>
