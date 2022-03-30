Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F377D4ECB9F
	for <lists+cgroups@lfdr.de>; Wed, 30 Mar 2022 20:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349907AbiC3STK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 30 Mar 2022 14:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349934AbiC3STB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 30 Mar 2022 14:19:01 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1452A7A98B
        for <cgroups@vger.kernel.org>; Wed, 30 Mar 2022 11:17:08 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id p10so31392138lfa.12
        for <cgroups@vger.kernel.org>; Wed, 30 Mar 2022 11:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=R19eqkXokhchW1j6UdGp+QXG6KM5ZSnkZ3jLzYlEUFE=;
        b=MYVH88i9fG73Xt2UZCd0Qo9J/0kERZsDmwpC9YvHUho1pwCVkkAyQR++y+da3CB+xN
         Aong+0mIpH7x1JtrVW1+00epXjRz5E7haNQITADKUTy5O9iK0KojcLsbWGt0VWV4bUjF
         dcanGOKcG80WBSP2UcbUEfuDppjDU1suhdUnLIL806cgAoWlhZoLGJ9HNp0ya22uyzGL
         8Zz2NsumGv7TsgDEJo57iN3/iftyZvQiBKFo1/3O6Ic5eDJnM6dnipsJudYnfAuUKG6H
         4c6MTCh8UVhGiP1BcJXFj4FXOq59L/l7HcT/oaitFNAjAC/qyi7NQJ20p7b60H9yRGwt
         HMIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=R19eqkXokhchW1j6UdGp+QXG6KM5ZSnkZ3jLzYlEUFE=;
        b=rpLuOSukWBfD6VctRkUQhChXvOsSu+qChsDfn386UPIuNFrgQ8U7cZWVZN1CVsGyi5
         IzbRznZK0FLnxTXsERTxR1QBfYdFDgt+OiPWt6JYXwCAPFht7Bt9vJMcYOu9Yr6iLilw
         KJ1pigjoaVdclVpDelfzA5xsi6HeWZtyBViS+JzBCOogKS7q5kr7Nd6oZyRhdPiQHzdE
         +xqq0SiaygLj/SPrlJumahFT4kgt07HZ3gKU/09BTz0Itp1+xJCkvgMw64EJjNeXXP8k
         npgkNPVbd7vjy4c+wn9Oye2QKVqs2EVx2epbAJx8kDkbwCAYutbjoiVrcZYUYVw4l/Ji
         Pr6w==
X-Gm-Message-State: AOAM533O5bGcJxL+alb3BJTQz7yE7Y++oJkbEIXhnh4gvqwI9n8vSz6y
        EwEiQ/DRmoc1SftVwIQ1BW2zRpzvWiFB9mEp+VI=
X-Google-Smtp-Source: ABdhPJxkDjLx77c8JdB7fFEPULpOi/Q8+OBiNFWj9QLVa5V8Ig6azrESHw88OmslPERhw/LyJeCST8sDoWAUK3zDhE4=
X-Received: by 2002:a05:6512:3f99:b0:447:1ef5:408a with SMTP id
 x25-20020a0565123f9900b004471ef5408amr8030858lfa.490.1648664225845; Wed, 30
 Mar 2022 11:17:05 -0700 (PDT)
MIME-Version: 1.0
Reply-To: isabellasayouba0@gmail.com
Sender: 33s.marshaa0@gmail.com
Received: by 2002:a05:6512:3b85:0:0:0:0 with HTTP; Wed, 30 Mar 2022 11:17:04
 -0700 (PDT)
From:   Mrs Isabella Sayouba <isabellasayouba0@gmail.com>
Date:   Wed, 30 Mar 2022 18:17:04 +0000
X-Google-Sender-Auth: HIH969s_sQBJ0QdYT7t82eNfrkw
Message-ID: <CAFsTCOprxpLd3Cfdv=UXJ4b9o6SRuJE1sZ8M0VcBrWf_WaXoQA@mail.gmail.com>
Subject: =?UTF-8?B?5ZCR5L2g6Zeu5aW944CC?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=4.0 required=5.0 tests=BAYES_99,BAYES_999,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

5ZCR5L2g6Zeu5aW944CCDQoNCuaIkeWQq+edgOazquawtOe7meS9oOWGmei/meWwgemCruS7tu+8
jOaIkeeahOecvOedm+mHjOWFhea7oeS6huaCsuS8pO+8jOaIkeeahOWQjeWtl+aYryBJc2FiZWxs
YSBTYXlvdWJhDQrlpKvkurrvvIzmiJHmnaXoh6rnqoHlsLzmlq/vvIzmiJHmraPlnKjluIPln7rn
urPms5XntKLnmoTkuIDlrrbljLvpmaLkuI7kvaDogZTns7vvvIzmiJHmg7PlkYror4nkvaDov5nm
mK/lm6DkuLrmiJHliKvml6DpgInmi6nvvIzlj6rog73lkYror4nkvaDvvIzmiJHlvojpq5jlhbTl
kJHkvaDmlZ7lvIDlv4PmiYnvvIzmiJHlq4Hnu5nkuobkuI7nqoHlsLzmlq/pqbvluIPln7rnurPm
s5XntKLlpKfkvb/lhbHkuovkuZ3lubTnmoTokKjlsKTlt7TigKLluIPmnJflhYjnlJ/vvIzku5bk
uo4NCjIwMTEg5bm05Y675LiW44CC5oiR5Lus5piv57uT5ama5Y2B5LiA5bm05rKh5pyJ5a2p5a2Q
44CCDQoNCuS7luWcqOWPquaMgee7reS6huS6lOWkqeeahOefreaagueWvueXheWQjuWOu+S4luOA
guiHquS7juS7luatu+WQjuaIkeWGs+WumuS4jeWGjeWGjeWpmu+8jOWcqOaIkeW3suaVheeahOS4
iOWkq+WcqOS4luaXtu+8jOS7luWtmOS6hjg1MC4wMOS4h+e+juWFg+OAgg0K77yI5YWr55m+5LqU
5Y2B5LiH576O5YWD77yJ5Zyo6KW/6Z2e5biD5Z+657qz5rOV57Si6aaW6YO955Om5Yqg5p2c5Y+k
55qE5LiA5a626ZO26KGM44CC55uu5YmN6L+Z56yU6ZKx6L+Y5Zyo6ZO26KGM6YeM44CC5LuW5bCG
6L+Z56yU6ZKx55So5LqO5Ye65Y+j5biD5Z+657qz5rOV57Si55+/5Lia55qE6buE6YeR44CCDQoN
CuacgOi/ke+8jOaIkeeahOWMu+eUn+WRiuivieaIke+8jOeUseS6jueZjOeXh+WSjOS4remjjumX
rumimO+8jOaIkeS4jeS8muaMgee7reS4g+S4quaciOeahOaXtumXtOOAguacgOWbsOaJsOaIkeea
hOaYr+aIkeeahOS4remjjueXheOAguWcqOS6huino+S6huaIkeeahOaDheWGteWQju+8jOaIkeWG
s+WumuWwhui/meeslOmSseS6pOe7meaCqO+8jOS7peeFp+mhvuW8seWKv+e+pOS9k++8jOaCqOWw
huaMieeFp+aIkeWcqOatpOaMh+ekuueahOaWueW8j+S9v+eUqOi/meeslOmSseOAguaIkeW4jOac
m+S9oOaKiuaAu+mHkemineeahA0KMzAlIOeUqOS6juS4quS6uueUqOmAlOOAguiAjOS9oOWwhueU
qDcwJeeahOmSseS7peaIkeeahOWQjeS5ieW7uumAoOWtpOWEv+mZou+8jOW4ruWKqeihl+S4iuea
hOept+S6uuOAguaIkeaYr+S4gOS4quWtpOWEv+mVv+Wkp+eahO+8jOaIkeayoeacieS7u+S9leS6
uuS9nOS4uuaIkeeahOWutuS6uu+8jOWPquaYr+S4uuS6huWKquWKm+e7tOaKpOelnueahOWutuOA
guaIkei/meagt+WBmuaYr+S4uuS6huiuqeS4iuW4nei1puWFjeaIkeeahOe9quW5tuWcqOWkqeWg
guaOpee6s+aIkeeahOeBtemtgu+8jOWboOS4uui/meenjeeWvueXheiuqeaIkeWmguatpOeXm+iL
puOAgg0KDQrmlLbliLDmgqjnmoTlm57lpI3lkI7vvIzmiJHlsIbnq4vljbPnu5nmgqjluIPln7rn
urPms5XntKLpk7booYznmoTogZTns7vmlrnlvI/vvIzmiJHov5jlsIbmjIfnpLrpk7booYznu4/n
kIblkJHmgqjnrb7lj5HmjojmnYPkuabvvIzor4HmmI7mgqjmmK/pk7booYzotYTph5HnmoTlvZPl
iY3lj5fnm4rkurrvvIzlpoLmnpzmgqjlkJHmiJHkv53or4HvvIzmgqjlsIbmjInnhafmiJHlnKjm
raTlo7DmmI7nmoTmlrnlvI/ph4flj5bnm7jlupTnmoTooYzliqjjgIINCg0K5p2l6Ieq5LyK6I6O
6LSd5ouJ4oCi6JCo5bCk5be05aSr5Lq644CCDQo=
