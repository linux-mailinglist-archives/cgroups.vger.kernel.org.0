Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D97970480C
	for <lists+cgroups@lfdr.de>; Tue, 16 May 2023 10:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbjEPIla (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 16 May 2023 04:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbjEPIl3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 16 May 2023 04:41:29 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFAFCA0
        for <cgroups@vger.kernel.org>; Tue, 16 May 2023 01:41:24 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-55a5a830238so127728787b3.3
        for <cgroups@vger.kernel.org>; Tue, 16 May 2023 01:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684226483; x=1686818483;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GEPNOTi0O563AQ3e/CnntBnII46i4Ayd1UOvpdk56sI=;
        b=gQlHQiiRWqADn4c+/edzhs9Es8YiRqj3rkLKqvVd77h9x5UXFn980M7k3WsXWxbkgZ
         jli1pr2OgzTCJQCGRPRIPAor6akC+UJe0RxRzQehpJXgIY0FgdtTaEh8msckHxJ2pCaI
         J5CeI9ymi+Ib75F/QemNapjjksKU0US+/uHviHRSq2ns13sOp6/oOE1ha/l3jAlkrIUs
         qhc1PSjPXr1mJig+ah1AFgBaLcQEz4mtbVNGffShoZF+pgrnbtbJXdTU1pX1bokF5QC9
         9WDqHA5/S54ng5nf2WjHLc8aplwCtoMhA0bCaFVRRTgRQdW6ZosU+wyoMZ3IgZh/kHWs
         TyIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684226483; x=1686818483;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GEPNOTi0O563AQ3e/CnntBnII46i4Ayd1UOvpdk56sI=;
        b=Dsf/vZfIiJuqPq8OGpoF1aqVEmgXT78Djk9Pod7VwDJnYDeevnZ6Ti1ur3KBl5cPjl
         1Su3KH811hSBFg3GjwFF+dPbiqGMTLFb3WKq0vdfBKaDfNfF3E2HJyYls0su10NOdipz
         P/LWAJYNXqUkt5DRqNSbYa0f5wCNgJejHtTsGuUGzrFxjzb0SWBodhCRhgR0Zh9Kcc3c
         mXMPVS7y1Ilgy4gbWPo5PaEf7Vbp9/aCi4r6QHHtGjkOWWlJgdZG+URuJQF1HARjUpiJ
         zZyh6SP9KHeQvc//gU3P51zf6pQUziwDZj12uwLMF1Mob+ZAUbdD0O30smI4RyhwOlun
         cDcg==
X-Gm-Message-State: AC+VfDxfOOk4a8NhV0TF7a0Q/RJsoilC5byBGGMv+v/GtYU2XjnID29k
        K4Dtn5VlSBFBfTTHMwwTcdzMn2tnu4U6oY2hbNQ=
X-Google-Smtp-Source: ACHHUZ4JKxxgxgrbS630qmcu+hRpERGf900yYvfmqtydb+Tk7X8wOjIff1dBFQLmhQQbXjzFZdD4b6m2hqtQFT0u4bU=
X-Received: by 2002:a0d:c604:0:b0:55a:8226:6192 with SMTP id
 i4-20020a0dc604000000b0055a82266192mr30835393ywd.7.1684226482979; Tue, 16 May
 2023 01:41:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7010:3828:b0:34b:8a0e:6970 with HTTP; Tue, 16 May 2023
 01:41:22 -0700 (PDT)
Reply-To: didieracouetey2@gmail.com
From:   "Mrs. Cristalina Georgieva" <zayna4618@gmail.com>
Date:   Tue, 16 May 2023 08:41:22 +0000
Message-ID: <CAEEyOcdWeH4DngoE4BOupOSs49U+eYBEywoZS8OMH9pUJ8YrQQ@mail.gmail.com>
Subject: hi
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

IOazqOaEjzog6Kaq5oSb44Gq44KL5Z+66YeR5Y+X55uK6ICF44Gu55qG5qeYDQoNCiAgIOaFjumH
jeOBq+iqreOCgO+8ge+8ge+8gQ0KDQogICDjgZPjga7pm7vlrZDjg6Hjg4Pjgrvjg7zjgrjjga/m
qZ/lr4bjgafjgYLjgorjgIHljrPlr4bjgavjgYLjgarjgZ/lrpvjga7jgoLjga7jgafjgZnjgIIN
Cg0K44GC44Gq44Gf44GMMTXlhITjg4njg6vopo/mqKHjga7os4fph5HjgpLlj5fjgZHlj5bjgaPj
gabjgYTjgarjgYTjga7jga/mmI7jgonjgYvjgafjgZnjgILjgZPjgozjga/jgIHpgY7ljrvjga7o
hZDmlZfjgZfjgZ/mlL/lupzlvbnkurrjgYzliKnlt7HnmoTjgarnkIbnlLHjgafos4fph5HjgpLj
gbvjgajjgpPjganoh6rliIbjgZ/jgaHjgaDjgZHjga7jgoLjga7jgavjgZfjgIHjgYLjgarjgZ/j
ga7os4fph5HjgpLjgZnjgbnjgaboqZDmrLrjgZfjgojjgYbjgajjgZfjgabliKnnlKjjgZfjgZ/j
gZ/jgoHjgafjgZnjgIINCuWfuumHkeOAgiDjgZPjgozjgavjgojjgorjgIHjgYrlrqLmp5jlgbTj
gavlpJrlpKfjgarmkI3lpLHjgYznmbrnlJ/jgZfjgIHos4fph5Hjga7lj5fjgZHlj5bjgorjgavk
uI3lv4XopoHjgarpgYXjgozjgYznlJ/jgZjjgb7jgZfjgZ/jgIINCg0K44Kk44Oz44K/44O844Od
44O844Or44Gu5Zu95a625Lit5aSu5bGA44Gv44CB5Zu96YCj44Go6YCj6YKm5o2c5p+75bGA77yI
RklC77yJ44Gu5pSv5o+044KS5Y+X44GR44Gm44CB54++5Zu96Zqb6YCa6LKo5Z+66YeR57eP6KOB
44Gr5a++44GX44CB44GC44Gq44Gf44KE5LuW44Gu5Lq644Gf44Gh44Gr5a++44GZ44KL44GZ44G5
44Gm44Gu5a++5aSW5YK15YuZ44Gu5riF566X44KS5o6o6YCy44GZ44KL44KI44GG5aeU5Lu744GZ
44KL44GT44Go44Gr5oiQ5Yqf44GX44G+44GX44Gf44CCDQrlpZHntITph5HjgIHlrp3jgY/jgZgv
44Ku44Oj44Oz44OW44Or44CB55u457aa44Gq44Gp44KS5Y+X44GR5Y+W44KJ44Gq44GE5YCL5Lq6
44CCIEFUTeOCq+ODvOODieOBp+aUr+aJleOBhOOCkuWPl+OBkeWPluOCiuOBvuOBmeOAgg0KDQpP
UkEg44OQ44Oz44KvIOOCq+ODvOODiTog5ZCN5YmN44GM5pqX5Y+35YyW44GV44KM44Gf44OR44O8
44K944OK44Op44Kk44K644GV44KM44GfIE9SQSDjg5Djg7Pjgq8gQVRNDQrjgqvjg7zjg4njgpLn
mbrooYzjgZfjgb7jgZnjgILjgZPjga7jgqvjg7zjg4njgpLkvb/nlKjjgZnjgovjgajjgIFWaXNh
IOOCq+ODvOODieOBruODreOCtOOBjOS7mOOBhOOBpuOBhOOCiyBBVE0g44GL44KJIDEg5pel44GC
44Gf44KK5pyA5aSnIDIwLDAwMA0K44OJ44Or44KS5byV44GN5Ye644GZ44GT44Go44GM44Gn44GN
44G+44GZ44CCIOOBvuOBn+OAgU9SQSDjg5Djg7Pjgq8g44Kr44O844OJ44KS5L2/55So44GZ44KL
44Go44CB6LOH6YeR44KS6YqA6KGM5Y+j5bqn44Gr6YCB6YeR44Gn44GN44G+44GZ44CCIEFUTQ0K
44Kr44O844OJ44Gr44Gv44CB44GC44Gq44Gf44Gu5Zu944GK44KI44Gz5LiW55WM5Lit44Gu44Gp
44GuIEFUTSDmqZ/jgafjgoLkvb/nlKjjgafjgY3jgovjgZPjgajjgpLmmI7norrjgavjgZnjgovj
g57jg4vjg6XjgqLjg6vjgYzku5jlsZ7jgZfjgabjgYTjgb7jgZnjgIINCg0K6LOH6YeR44GvIEFU
TSBWaXNhIOOCq+ODvOODiee1jOeUseOBp+mAgeOCieOCjOOAgUZlZEV4IEV4cHJlc3Mg57WM55Sx
44Gn6YWN6YGU44GV44KM44G+44GZ44CCIOengeOBn+OBoeOBryBGZWRFeCBFeHByZXNzDQrjgajl
pZHntITjgpLntZDjgpPjgafjgYTjgb7jgZnjgILpgKPntaHjgZnjgovlv4XopoHjgYzjgYLjgovj
ga7jga/jgIFPUkEg6YqA6KGM44Gu44OH44Kj44Os44Kv44K/44O844Gn44GC44KLIE1SIOOBoOOB
keOBp+OBmeOAgiBESURJRVIgQUNPVUVURVkNCuOBk+OBruODoeODvOODq+OCouODieODrOOCueOB
i+OCiTogLCAoZGlkaWVyYWNvdWV0ZXkyQGdtYWlsLmNvbSkNCg0KDQrpgJrluLjjga7jg6zjg7zj
g4jjgpLotoXjgYjjgovph5HpoY3jgpLopoHmsYLjgZnjgovkurrjga/plpPpgZXjgYTjgarjgY/o
qZDmrLrluKvjgafjgYLjgorjgIHku5bjga7kurrjgavpgKPntaHjgpLlj5bjgaPjgZ/loLTlkIjj
ga/jgZ3jga7kurrjgajjga7pgKPntaHjgpLkuK3mraLjgZnjgovlv4XopoHjgYzjgYLjgovjgZPj
gajjgavms6jmhI/jgZfjgabjgY/jgaDjgZXjgYTjgIINCg0K44G+44Gf44CB44GU6LKg5ouF44GE
44Gf44Gg44GP44Gu44Gv6YWN6YCB5paZ44Gu44G/44Gn44GZ44Gu44Gn44GU5a6J5b+D44GP44Gg
44GV44GE44CCIOOBneOCjOS7peS4iuOBruOCguOBruOBr+OBguOCiuOBvuOBm+OCk++8gSDlv4Xo
poHjgarmg4XloLHjgajphY3pgIHmlpnjgpLlj5fjgZHlj5bjgaPjgabjgYvjgokgMg0K5Za25qWt
5pel5Lul5YaF44Gr6LOH6YeR44KS5Y+X44GR5Y+W44KL44GT44Go44KS5L+d6Ki844GX44G+44GZ
44CCDQoNCuazqDog56iO6YeR5omL5pWw5paZ44KS5ZCr44KB44CB44GZ44G544Gm44GvIElNRiDj
gajkuJbnlYzpioDooYzjgavjgojjgaPjgablh6bnkIbjgZXjgozjgovjgZ/jgoHjgIHmlK/miZXj
gYblv4XopoHjgYzjgYLjgovjga7jga8gRmVkRXgg44Gu6YWN6YCB5paZ44Gg44GR44Gn44GZ44CC
DQrjgZPjgozjga/jgIFGZWRFeCBFeHByZXNzIOOBriBDT0QgKOS7o+mHkeW8leaPmykg44K144O8
44OT44K544GM6KaP57SE44Gr44KI44KK5Zu96Zqb6YWN6YCB44Gr44Gv6YGp55So44GV44KM44Gq
44GE44Gf44KB44Gn44GZ44CCDQoNCjE1IOWEhOODieODq+ebuOW9k+OBruODleOCoeODs+ODieOC
kuODquODquODvOOCueOBmeOCi+OBq+OBr+OAgeiqpOmFjemAgeOCkumBv+OBkeOCi+OBn+OCgeOB
q+mFjemAgeaDheWgseOCkuaPkOS+m+OBmeOCi+W/heimgeOBjOOBguOCiuOBvuOBmeOAgg0KDQog
ICAxLiDjgYLjgarjgZ/jga7jg5Xjg6vjg43jg7zjg6AgLi4uLi4uLi4uLi4uLi4uLi4uLg0KMi4g
44GC44Gq44Gf44Gu5Zu9Li4uLi4NCjMuIOOBguOBquOBn+OBruihly4uLi4uDQo0LiDjgYLjgarj
gZ/jga7lrozlhajjgarkvY/miYAgLi4uLi4uDQo1LiDlm73nsY0gLi4uLi4uDQo2LiDnlJ/lubTm
nIjml6Uv5oCn5Yil4oCm4oCmDQo3LiDogbfmpa3igKbigKYNCjguIOmbu+ipseeVquWPt+KApuKA
pg0KOS4g6LK056S+44Gu44Oh44O844Or44Ki44OJ44Os44K5IOKApuKApg0KMTAuIOWAi+S6uuOD
oeODvOODq+OCouODieODrOOCuSAuLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4NCjEx
LiDlm73pmpvjg5Hjgrnjg53jg7zjg4jjgb7jgZ/jga/mnInlirnjgarouqvliIboqLzmmI7mm7jj
ga7jgrPjg5Tjg7w6DQoNCuW/heimgeS6i+mgheOCkk1S44G+44Gn44GK6YCB44KK44GP44Gg44GV
44GE44CCIERJRElFUiBBQ09VRVRFWSBPcmFCYW5rIOODh+OCo+ODrOOCr+OCv+ODvOOAgeODoeOD
vOODq+OCouODieODrOOCuSA9DQooZGlkaWVyYWNvdWV0ZXkyQGdtYWlsLmNvbSkg44G+44Gn5LuK
44GZ44GQ44GU6YCj57Wh44GP44Gg44GV44GE44CCDQoNCuOBiuOCgeOBp+OBqOOBhuOBlOOBluOB
hOOBvuOBmQ0K
