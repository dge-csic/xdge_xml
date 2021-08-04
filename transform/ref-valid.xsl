<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    version="1.0"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="tei"
    >
    <xsl:output indent="yes" encoding="UTF-8" method="text"/>
    <xsl:key name="id" match="id" use="translate(@xml:id, $id1, $id2)"/>
    <xsl:variable name="exclude">OK FUTURE INFER LOCAL</xsl:variable>
    <xsl:variable name="root" select="/*"/>
    
    <xsl:variable name="ref1">ᾰᾱῐῑῠῡ ·*()[]&lt;&gt;†</xsl:variable>
    <xsl:variable name="ref2">αααααεεεεεεεεεειιοοοοοοοουυ_</xsl:variable>
  
    <xsl:variable name="id1">ᾰᾱ&#xE1B3;ῐῑ&#xE1C3;ῠῡ</xsl:variable>
    <xsl:variable name="id2">ααειιουυ</xsl:variable>
    <xsl:variable name="tab"><xsl:text>	</xsl:text></xsl:variable>
    <xsl:variable name="alphanum">0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz_ )</xsl:variable>
    <xsl:variable name="init1" select="concat(
        'άἀἁἂἃἄἅἆἇἈἉἊἋἌἍἎἏάὰᾀᾁᾂᾃᾄᾅᾆᾇᾈᾉᾊᾋᾌᾍᾎᾏᾰᾱᾲᾳᾴᾶᾷᾸᾹᾺΆᾼΑ',
        'ϐΒΓΔ',
        'ϵέἐἑἒἓἔἕἘἙἚἛἜἝὲέῈΈΕ',
        'Ζ',
        'ήἠἡἢἣἤἥἦἧἨἩἪἫἬἭἮἯὴήᾐᾑᾒᾓᾔᾕᾖᾗᾘᾙᾚᾛᾜᾝᾞᾟῂῃῄῆῇῊΉῌΗ',
        'Θϑ',
        'ίἰἱἲἳἴἵἶἷἸἹἺἻἼἽἾἿὶίϊῐῑῒΐῖῗΐῘῙῚΊΙ',
        'ϙΚΛΜΝΞ',
        'όὀὁὂὃὄὅὈὉὊὋὌὍὸόῸΌΟ',
        'ΠϱΡῤῥῬΣΤ',
        'ϒύὐὑὒὓὔὕὖὗὙὛὝὟὺύῠῡῢΰῦῧῨῩῪΎΥϓ',
        'ΦΧΨ',
        'ώὠὡὢὣὤὥὦὧὨὩὪὫὬὭὮὯὼώᾠᾡᾢᾣᾤᾥᾦᾧᾨᾩᾪᾫᾬᾭᾮᾯῲῳῴῶῷῺΏῼΩ'
     )"/>
    <xsl:variable name="init2" select="concat(
        'ααααααααααααααααααααααααααααααααααααααααααααααααααα',
        'ββγδ',
        'εεεεεεεεεεεεεεεεεεεεεεεεεεεεε',
        'ζ',
        'ηηηηηηηηηηηηηηηηηηηηηηηηηηηηηηηηηηηηηηηηηηηη',
        'θθ',
        'ιιιιιιιιιιιιιιιιιιιιιιιιιιιιιιιι',
        'κκλμνξ',
        'οοοοοοοοοοοοοοοοοοοοοοοοοο',
        'πρρρρρστ',
        'υυυυυυυυυυυυυυυυυυυυυυυυυυυυ',
        'φχψ',
        'ωωωωωωωωωωωωωωωωωωωωωωωωωωωωωωωωωωωωωωωωωωωω'
        )"/>
    <xsl:template match="/">
      <xsl:text>File</xsl:text>
      <xsl:value-of select="$tab"/>
      <xsl:text>Source</xsl:text>
      <xsl:value-of select="$tab"/>
      <xsl:text>Destination</xsl:text>
      <xsl:value-of select="$tab"/>
      <xsl:text>Rewrite</xsl:text>
      <xsl:value-of select="$tab"/>
      <xsl:text>Status</xsl:text>
      <refs>
            <xsl:apply-templates select="document('xdge1.xml')/*"/>
            <xsl:apply-templates select="document('xdge2.xml')/*"/>
            <xsl:apply-templates select="document('xdge3.xml')/*"/>
            <xsl:apply-templates select="document('xdge4.xml')/*"/>
            <xsl:apply-templates select="document('xdge5.xml')/*"/>
            <xsl:apply-templates select="document('xdge6.xml')/*"/>
            <xsl:apply-templates select="document('xdge7.xml')/*"/>
        </refs>
    </xsl:template>
    <xsl:template match="*">
        <xsl:apply-templates select="*"/>
    </xsl:template>
    <xsl:template match="tei:ref | tei:xr[not(tei:ref)]">
        <xsl:variable name="ref">
            <xsl:for-each select="text()">
                <xsl:value-of select="normalize-space(.)"/>
            </xsl:for-each>
            <xsl:if test="tei:hi[@rend='bold'] and local-name(node()[normalize-space(.)!=''][1])='hi'">
                <xsl:value-of select="tei:hi[@rend='bold']"/>
            </xsl:if>
        </xsl:variable>
        <xsl:variable name="start">
          <xsl:text>
</xsl:text>
          <xsl:value-of select="/*/@xml:id"/>
          <xsl:value-of select="$tab"/>
          <!-- source -->
          <xsl:value-of select="ancestor::tei:entry/@xml:id"/>
          <xsl:value-of select="$tab"/>
          <!-- target -->
          <xsl:value-of select="."/>
          <xsl:value-of select="$tab"/>
        </xsl:variable>
        <!-- nombres ?
        
        -->
        <xsl:variable name="dest">
            <xsl:for-each select="$root">
                <xsl:value-of select="count(key('id', $ref))"/>
            </xsl:for-each>
        </xsl:variable> 
            
        <xsl:choose>
            <!--
            <xsl:when test="$dest and $dest/@type">
                <xsl:value-of select="$ref"/>
                <xsl:value-of select="$tab"/>
                <xsl:value-of select="$dest/@type"/>
            </xsl:when>
            -->
          <!-- FOUND -->
          <xsl:when test="$dest = 1">
            <xsl:if test="not(contains($exclude, 'OK'))">
              <xsl:value-of select="$start"/>
              <xsl:value-of select="$ref"/>
              <xsl:value-of select="$tab"/>
              <xsl:text>OK</xsl:text>
            </xsl:if>
          </xsl:when>
          <xsl:when test="$dest &gt; 1">
            <xsl:if test="not(contains($exclude, 'MULTIPLE'))">
              <xsl:value-of select="$start"/>
              <xsl:value-of select="$ref"/>
              <xsl:value-of select="$tab"/>
              <xsl:text>MULTIPLE</xsl:text>
            </xsl:if>
          </xsl:when>
          <!-- LOCAL -->
          <xsl:when test="translate($ref, $alphanum, '')=''">
            <xsl:if test="not(contains($exclude, 'LOCAL'))">
              <xsl:value-of select="$start"/>
              <xsl:value-of select="$ref"/>
              <xsl:value-of select="$tab"/>
              <xsl:text>LOCAL</xsl:text>
            </xsl:if>
          </xsl:when>
          <xsl:otherwise>
              <xsl:variable name="nref">
                    <xsl:value-of select="translate($ref, $ref1,  $ref2 )"/>
                </xsl:variable>
                <xsl:variable name="id">
                    <xsl:choose>
                        <xsl:when test="contains($nref, '_') and translate(substring-before($nref, '_'), '1234567890', '')=''">
                            <xsl:variable name="after" select="substring-after($nref, '_')"/>
                            <!-- strip -->
                            <xsl:choose>
                                <xsl:when test="contains($after, '_')">
                                    <xsl:value-of select="substring-before($after, '_')"/>
                                    <xsl:value-of select="substring-before($nref, '_')"/>
                                    <!-- sense
                                    <xsl:text>_</xsl:text>
                                    <xsl:value-of select="substring-after($after, '_')"/>
                                    -->
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="$after"/>
                                    <xsl:value-of select="substring-before($nref, '_')"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="$nref"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <xsl:variable name="char1" select="translate(substring($id,1,1), $init1, $init2)"/>
                <xsl:variable name="char2" select="translate(substring($id,2,1), $init1, $init2)"/>
                <xsl:variable name="future">
                    <xsl:choose>
                        <xsl:when test="contains('αβγδ',$char1)"/>
                        <xsl:when test="$char1='ε' and contains('αβγδεζηθικλμν',$char2)"/>
                      <xsl:when test="contains('εζηθικλμνξοπρστυφχψω',$char1)">FUTURE</xsl:when>
                    </xsl:choose>
                </xsl:variable>
                <xsl:variable name="infer">
                    <xsl:for-each select="$root">
                        <xsl:value-of select="count(key('id', $id))"/>
                    </xsl:for-each>
                </xsl:variable>
                <xsl:choose>
                    <xsl:when test="$infer &gt; 0">
                      <xsl:if test="not(contains($exclude, 'INFER'))">
                        <xsl:value-of select="$start"/>
                        <xsl:value-of select="$id"/>
                        <xsl:value-of select="$tab"/>
                        <xsl:text>INFER</xsl:text>
                      </xsl:if>
                    </xsl:when>
                    <xsl:when test="$future != ''">
                      <xsl:if test="not(contains($exclude, 'FUTURE'))">
                        <xsl:value-of select="$start"/>
                        <xsl:value-of select="$id"/>
                        <xsl:value-of select="$tab"/>
                        <xsl:text>INFER</xsl:text>
                      </xsl:if>
                    </xsl:when>
                    <xsl:when test="substring($id, string-length($id))='-'">
                      <xsl:value-of select="$start"/>
                      <xsl:value-of select="$root/id[starts-with(@xml:id,substring($id,1, string-length($id) - 1))][1]/@xml:id"/>
                        <xsl:value-of select="$tab"/>
                        <xsl:text>PREFIX</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="$start"/>
                        <xsl:value-of select="$id"/>
                        <xsl:value-of select="$tab"/>
                        <xsl:text>???</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
</xsl:transform>