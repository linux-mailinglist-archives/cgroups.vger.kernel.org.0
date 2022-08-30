Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 476275A6261
	for <lists+cgroups@lfdr.de>; Tue, 30 Aug 2022 13:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbiH3Lrq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 30 Aug 2022 07:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiH3Lrp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 30 Aug 2022 07:47:45 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CBD9A0313
        for <cgroups@vger.kernel.org>; Tue, 30 Aug 2022 04:47:42 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id se27so13842490ejb.8
        for <cgroups@vger.kernel.org>; Tue, 30 Aug 2022 04:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date;
        bh=nrkgH02o2Rcq15VakJfrbQDQa/xxZur4E42yyaQ4r1Y=;
        b=jhTg8UtYppSqj8jX0RoOrmqprQjI7Yvmh4o2tsTKBjuofW+T9hjUfcbMfVjUnPQGN1
         Tsp0aCyjG2WrD35/qALy75D4rJQvb0sf7wclFU89XB4gTbQzmKLlPDezAS5ZoiWy/CEM
         bIPvhr9VpSrd3GxaKg/5k2ntTatmyK0l/zbu04bFe6XZjsgYkUkTgaMWBwlAQSi7Fzbv
         PVm1lD9mfkIhb9QzSMZOLpf+7UY/fDU0xLMhsDCZlfiNcW8Nu61qTIsfY0WMyPXrYDbG
         4i3JS23A7VCqW77pgDhey5fj6C6krCiBz3N+jxPg0QSqLYZVMv3BX4Hwjs4JkDijb1/J
         4bTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=nrkgH02o2Rcq15VakJfrbQDQa/xxZur4E42yyaQ4r1Y=;
        b=iP8dvKc6UElpywGAcIUjCWpR7jKMXhRRvKH685bs1KY8jn3E81ovFDukp4q48e1Rf1
         kotg1pfpocCrCn0XiIHNJbNNAlDSszP9w/ZfBmur41aJWJ/CJSdwu2yGyYWou+9XYObq
         mC4EUosUOEvGoSOnhOITc8ga/1KPWGUDMz3Xy23vxQMT1HV74Y1lsFBHPta+ZhzPMeW7
         Bzzb+CcmOZc6Oa2MBD3UpifHD/oiDm/aMc6nUmcU3HZPXvvSi5J1BPKMsbpc6eP7bIEH
         RVMdz0EKS2tuT7VmUFGjN4TiN9dTSRmmoDkG84iqN5nnI/0lVX09VbaZ8nxvc68T/IiU
         TdKg==
X-Gm-Message-State: ACgBeo1gZss1SE5R8cb0P23Jw4hVoZpVqcE42MUK22dI+6GfcVnT1rPh
        4Vdt984vOrPB1yw4mDe2dBTDBFttNErVTZ+JdnA=
X-Google-Smtp-Source: AA6agR4WkQaJ5ltNk0udMHRuVQdcaY1S5Xr+ZTXKJtUX+N/KOf80gc9D53ZL2eoDZxWcvFsgLXfROsRil7Lo0iniQP8=
X-Received: by 2002:a17:907:7601:b0:73d:9f0b:d99f with SMTP id
 jx1-20020a170907760100b0073d9f0bd99fmr16543600ejc.300.1661860060627; Tue, 30
 Aug 2022 04:47:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:906:31cb:b0:73d:6076:ca65 with HTTP; Tue, 30 Aug 2022
 04:47:40 -0700 (PDT)
Reply-To: omrtonyelumelu98@gmail.cm
From:   " Mrs. Kristalina Georgieva" <oze123456788@gmail.com>
Date:   Tue, 30 Aug 2022 12:47:40 +0100
Message-ID: <CACOHB+1TOE0ycx6yw0qL8q+umYZ36SM+H5o2rbnNpfBWoVyYpQ@mail.gmail.com>
Subject: hi
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: Yes, score=5.7 required=5.0 tests=BAYES_99,BAYES_999,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FROMSPACE,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:630 listed in]
        [list.dnswl.org]
        *  3.5 BAYES_99 BODY: Bayes spam probability is 99 to 100%
        *      [score: 1.0000]
        *  0.2 BAYES_999 BODY: Bayes spam probability is 99.9 to 100%
        *      [score: 1.0000]
        *  2.0 FROMSPACE Idiosyncratic "From" header format
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [oze123456788[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [oze123456788[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

5Zu96Zqb6YCa6LKo5Z+66YeRIChJTUYpDQrlm73pmpvlgrXli5nnrqHnkIboqrINCu+8gzE5MDDj
gIFBVi5EVeekvumVtw0KDQpJLk0uRi4g44OH44Kj44Os44Kv44K/44O844Gu5YWs5byP6Zu75a2Q
44Oh44O844OrIOOCouODieODrOOCueOBuOOCiOOBhuOBk+OBneOAguOCr+ODquOCueOCv+ODquOD
vOODiuODu+OCsuOCquODq+OCruOCqOODrw0KDQoNCuimquaEm+OBquOCi+WPl+ebiuiAhe+8gQ0K
DQrmlrDjgZ/jgavku7vlkb3jgZXjgozjgZ/osqHli5nplbflrpjjgajlm73pgKPpgJrosqjlvZPl
sYDjga7ntbHmsrvmqZ/plqLjga/jgIHlm73pgKPmlL/lupzjgavplbfjgYTplpPlgrXli5njgpLo
sqDjgaPjgabjgYTjgZ/mnKroq4vmsYLjga7os4fph5HjgpLoqr/mn7vjgZnjgovjgZPjgajjgpLo
qLHlj6/jgZfjgZ/jgZ/jgoHjgIHmiYDmnInogIXjga/oqZDmrLrjgaflkYrnmbrjgZXjgozjgb7j
gZfjgZ8u5Zu96YCj44Gu5ZCN5YmN44KS5L2/55So44GX44Gf6KmQ5qy65bir44CC6Kq/5p+75Lit
44Gu44K344K544OG44Og44Gu6Zu75a2Q44Oh44O844OrDQrjgqLjg4njg6zjgrnjga7jg4fjg7zj
gr8g44K544OI44Os44O844K46KiY6Yyy44Gr44KI44KL44Go44CB44GC44Gq44Gf44Gu5pSv5omV
44GE44Gv44CB5qyh44Gu44Kr44OG44K044Oq44GuIDE1MCDkurrjga7lj5fnm4rogIXjga7jg6rj
grnjg4jjgavlkKvjgb7jgozjgabjgYTjgb7jgZnjgILlpZHntITos4fph5HjgIINCg0K44GC44Gq
44Gf44Gu6LOH6YeR44KS44Gg44G+44GX5Y+W44KL44Gf44KB44Gr5rGa6IG344KS54qv44GX44Gf
6IWQ5pWX44GX44Gf6YqA6KGM6IG35ZOh44Gv44CB44GC44Gq44Gf44Gu5pSv5omV44GE44KS5LiN
5b2T44Gr6YGF44KJ44Gb44CB44GC44Gq44Gf44Gu5YG044Gr5aSa44GP44Gu6LK755So44GM44GL
44GL44KK44CB44GC44Gq44Gf44Gu5pSv5omV44GE44Gu5Y+X44GR5YWl44KM44GM5LiN5b2T44Gr
6YGF44KM44G+44GX44GfLuWbvemAo+OBqOWbvemam+mAmuiyqOWfuumHkQ0KKElNRikg44Gv44CB
5YyX57Gz44CB5Y2X57Gz44CB57Gz5Zu944CB44Oo44O844Ot44OD44OR44CB44Ki44K444Ki44CB
44GK44KI44Gz5LiW55WM5Lit44GuIEFUTSBWaXNhIOOCq+ODvOODieOCkuS9v+eUqOOBl+OBpiAx
NTANCuS6uuOBruWPl+ebiuiAheOBq+OBmeOBueOBpuOBruijnOWEn+OCkuaUr+aJleOBhuOBk+OB
qOOCkumBuOaKnuOBl+OBvuOBl+OBn+OAguOBk+OBruOCsOODreODvOODkOODq+OBquaUr+aJleOB
hOaKgOihk+OBjOWIqeeUqOWPr+iDveOBp+OBguOCi+OBn+OCgeOBp+OBmeOAgua2iOiyu+iAheOA
geS8gealreOAgemHkeiejeapn+mWouOBq+OAguaUv+W6nOOBjOePvumHkeOChOWwj+WIh+aJi+OB
ruS7o+OCj+OCiuOBq+ODh+OCuOOCv+ODq+mAmuiyqOOCkuS9v+eUqOOBp+OBjeOCi+OCiOOBhuOB
q+OBl+OBvuOBmeOAgg0KDQpBVE0gVmlzYeOCq+ODvOODieOCkuS9v+eUqOOBl+OBpuaUr+aJleOB
hOOCkuihjOOBhuOCiOOBhuOBq+aJi+mFjeOBl+OBvuOBl+OBn+OAguOCq+ODvOODieOBr+eZuuih
jOOBleOCjOOAgeWIqeeUqOWPr+iDveOBquWuhemFjeS+v+OCteODvOODk+OCueOCkuS7i+OBl+OB
puebtOaOpeS9j+aJgOOBq+mAgeOCieOCjOOBvuOBmeOAguOBlOmAo+e1oeW+jOOAgTEsNTAwLDAw
MC4wMA0K57Gz44OJ44Or44Gu6YeR6aGN44GMIEFUTSBWaXNhIOOCq+ODvOODieOBq+i7oumAgeOB
leOCjOOBvuOBmeOAguOBk+OCjOOBq+OCiOOCiuOAgeOBiuS9j+OBvuOBhOOBruWbveOBriBBVE0g
44GL44KJIDEg5pel44GC44Gf44KK5bCR44Gq44GP44Go44KCIDEwLDAwMA0K57Gz44OJ44Or44KS
5byV44GN5Ye644GZ44GT44Go44Gn44CB44GK6YeR44KS5byV44GN5Ye644GZ44GT44Go44GM44Gn
44GN44G+44GZ44CC44GU6KaB5pyb44Gr5b+c44GY44Gm44CBMSDml6XjgYLjgZ/jgoogMjAsMDAw
LjAwDQrjg4njg6vjgb7jgafkuIrpmZDjgpLlvJXjgY3kuIrjgZLjgovjgZPjgajjgYzjgafjgY3j
gb7jgZnjgILjgZPjgozjgavplqLjgZfjgabjgIHlm73pmpvmlK/miZXjgYrjgojjgbPpgIHph5Hl
sYDjgavpgKPntaHjgZfjgIHopoHmsYLjgZXjgozjgZ/mg4XloLHjgpLmrKHjga7mlrnms5Xjgafm
j5DkvpvjgZnjgovlv4XopoHjgYzjgYLjgorjgb7jgZnjgIINCg0KMS7jgYLjgarjgZ/jga7jg5Xj
g6vjg43jg7zjg6AuLi4uLi4uLi4NCjIu44GC44Gq44Gf44Gu5a6M5YWo44Gq5L2P5omALi4uLi4u
Li4NCjMuIOWbveexjSAuLi4uLi4uLi4uLi4uLi4uLg0KNC7nlJ/lubTmnIjml6Xjg7vmgKfliKXi
gKbigKbigKbigKYNCjUu5bCC6ZaA5oCnLi4uLi4uLi4NCjYuIOmbu+ipseeVquWPtyAuLi4uLi4u
Li4uDQo3LiDlvqHnpL7jga7jg6Hjg7zjg6vjgqLjg4njg6zjgrnigKbigKYNCjgu5YCL5Lq644Gu
44Oh44O844Or44Ki44OJ44Os44K54oCm4oCmDQoNCg0K44GT44Gu44Kz44O844OJICjjg6rjg7Pj
gq86IENMSUVOVC05NjYvMTYpIOOCkuitmOWIpeOBmeOCi+OBq+OBr+OAgembu+WtkOODoeODvOOD
q+OBruS7tuWQjeOBqOOBl+OBpuS9v+eUqOOBl+OAgeS4iuiomOOBruaDheWgseOCkuasoeOBruW+
k+alreWToeOBq+aPkOS+m+OBl+OBpiBBVE0NClZpc2Eg44Kr44O844OJ44Gu55m66KGM44Go6YWN
6YCB44KS5L6d6aC844GX44Gm44GP44Gg44GV44GE44CCDQoNCumKgOihjOOBruaLheW9k+iAheOB
jOOBk+OBruaUr+aJleOBhOOCkui/vei3oeOBl+OAgeODoeODg+OCu+ODvOOCuOOCkuS6pOaPm+OB
l+OBpuOAgeizh+mHkeOBruOBleOCieOBquOCi+mBheW7tuOChOiqpOOBo+OBn+aWueWQkeS7mOOB
keOCkumYsuOBkOOBk+OBqOOBjOOBp+OBjeOCi+OCiOOBhuOBq+OAgeaWsOOBl+OBhOeVquWPt+OB
p+WAi+S6uuOBrumbu+WtkOODoeODvOODqw0K44Ki44OJ44Os44K544KS6ZaL44GP44GT44Go44KS
44GK5Yun44KB44GX44G+44GZ44CC5Lul5LiL44Gu6YCj57Wh5YWI5oOF5aCx44KS5L2/55So44GX
44Gm44CB44Om44OK44Kk44OG44OD44OJIOODkOODs+OCryDjgqrjg5Yg44Ki44OV44Oq44Kr44Gu
44Ko44O844K444Kn44Oz44OI44Gr5LuK44GZ44GQ44GU6YCj57Wh44GP44Gg44GV44GE44CCDQoN
CumAo+e1oeeqk+WPo++8muODiOODi+ODvOODu+OCqOODq+ODoeODq+awjw0K6KOc5YSf6YeR6YCB
6YeR6YOoIFVuaXRlZCBCYW5rIG9mIEFmcmljYSDpgKPntaHlhYjjg6Hjg7zjg6vjgqLjg4njg6zj
grk6ICwobXJ0b255ZWx1bWVsdTk4QGdtYWlsLmNvbSkNCg0K44GT44KM5Lul5LiK44Gu6YGF44KM
44KS6YG/44GR44KL44Gf44KB44Gr44CB44GT44Gu44Oh44O844Or44G444Gu6L+F6YCf44Gq5a++
5b+c44GM5b+F6KaB44Gn44GZ44CCDQoNCuaVrOWFtw0K44Kv44Oq44K544K/44Oq44O844OK44O7
44Ky44Kq44Or44Ku44Ko44OQ5aSr5Lq6DQo=
