<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:template match="/">
    <xsl:choose>
      <xsl:when test="result/error">
        <h4 class="alert alert-danger"><xsl:value-of select="result/error"/></h4>
      </xsl:when>
      <xsl:otherwise>
        <h3>Введенные данные </h3>
        <h4><xsl:value-of select="result/initial"/></h4>
        <xsl:choose>
          <xsl:when test="result/calculations/distance">
            <h3>Отрезки</h3>
            <xsl:for-each select="result/calculations/distance">
              <h4 class="alert alert-primary"><xsl:value-of select="."/></h4>
            </xsl:for-each>
            <h3>Максимальный отрезок</h3>
            <h4 class="alert alert-primary"><xsl:value-of select="result/answer"/></h4>
          </xsl:when>
          <xsl:otherwise>
            <h3 class="alert alert-warning">Отрезков из степеней 5 нет</h3>
          </xsl:otherwise>
        </xsl:choose>

      </xsl:otherwise>
    </xsl:choose>
    <a href="/" class="btn btn-primary">Назад</a>
  </xsl:template>
</xsl:stylesheet>