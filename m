Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1A306ED0D2
	for <lists+cgroups@lfdr.de>; Mon, 24 Apr 2023 16:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbjDXO6f (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 24 Apr 2023 10:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbjDXO6e (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 24 Apr 2023 10:58:34 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E56EA
        for <cgroups@vger.kernel.org>; Mon, 24 Apr 2023 07:58:33 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-3ef49c15454so20489881cf.0
        for <cgroups@vger.kernel.org>; Mon, 24 Apr 2023 07:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682348312; x=1684940312;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=txP0S0HHwklInU5qOy6yuyRoSSntFs/HF3tPpTAhNxk=;
        b=grLCK5lmBeu1BKRgNA8uUpWYeyqxx8pLWqQ2RLkPyn27hHNaCDGEHahVG/OA0jDtOG
         AxG85gd6XMx0SmIhxfM16BIisgTMQTdbLHurq/UWUaNpbNSOG1mBV2B8DJCNWWGUS1ks
         n70TQPwLEn4YBHVdYGvigxE/VOrUWEoDmmgCDRVM1e9kCV1rdGe2CNgeUtKkx/gsR8GQ
         jEEvj9Ree4dJdIJLmJnTKNOKh6Y4bLtNqXRMbwq4vwevV5kT0hxVAYoHuseYeUpkDyqx
         /lKwWJBt9ICVJTcE0QNx6zs51DYDDIsfS2aTBu8blva+G1SUU4oOZwj02RH2aI7PivrV
         EjQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682348312; x=1684940312;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=txP0S0HHwklInU5qOy6yuyRoSSntFs/HF3tPpTAhNxk=;
        b=QLs5xmV1c7Xf1TrnlL7TiPbnwJKtLLEm1Z6+/+V2yhsyzOfN/gGjxEo58y9gzXsXZU
         bznaGuq0A7rAFa8u2TMKDxuUvgXh6fl7NDRyqsSoJQIgspy5s59wMwq1KmH2jySOI/7H
         0TPc1YBYdROq5nMbvkoz24kKEOyy2Ma6JLoJFXG5tsokVtKT3QGjUaoxAl06H2U63009
         YmJRKAgb5qI82gnLBDaceT3DbbtuIwfdf319kZmEfS17fbRkMbsyLV/IZSGLG7An0fM/
         /fjmVH/adomIC0ljRMg3U56UMJA4wgMYzW0U+hexeDqtVqVYjKz2X8pDZBCyPxDUcJ9w
         M0pQ==
X-Gm-Message-State: AAQBX9dlmoDVQLOgDrpVR+GVKrMzX+AOgnVa28hJcG6U2LdOfrli01/g
        9wEXEBSk+lZlEG32kYryCp5Nc6JT3n8OQsmzXR8=
X-Google-Smtp-Source: AKy350b7jbHxyrf1NfWTTyTs3aqvMAx6B/mO4+2DFurosma2f90rQd7nDnMzGaE0qzfasrlkFf8zV73UtKB2PQ7GC+E=
X-Received: by 2002:a05:622a:1041:b0:3ef:3ca6:c77d with SMTP id
 f1-20020a05622a104100b003ef3ca6c77dmr19536654qte.47.1682348312481; Mon, 24
 Apr 2023 07:58:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:622a:30d:b0:3ec:d332:58ae with HTTP; Mon, 24 Apr 2023
 07:58:32 -0700 (PDT)
Reply-To: georgebrown0004@gmail.com
From:   george brown <bbruce539@gmail.com>
Date:   Mon, 24 Apr 2023 16:58:32 +0200
Message-ID: <CADiB6YmcKMOaWT6PDxLBubFTZVsLsGOkNkaq=-5+NKNXQa0jBw@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Ahoj

Vol=C3=A1m sa George Brown, povolan=C3=ADm som pr=C3=A1vnik. Chcem v=C3=A1m=
 pon=C3=BAknu=C5=A5
najbli=C5=BE=C5=A1=C3=AD pr=C3=ADbuzn=C3=BD m=C3=B4jho klienta. Zded=C3=ADt=
e sumu (8,5 mili=C3=B3na dol=C3=A1rov)
dol=C3=A1rov, ktor=C3=A9 m=C3=B4j klient nechal v banke pred svojou smr=C5=
=A5ou.

M=C3=B4j klient je ob=C4=8Dan va=C5=A1ej krajiny, ktor=C3=BD zomrel pri aut=
onehode so
svojou man=C5=BEelkou
a jedin=C3=BD syn. Budem ma=C5=A5 n=C3=A1rok na 50 % z celkov=C3=A9ho fondu=
, zatia=C4=BE =C4=8Do 50 % =C3=A1no
by=C5=A5 pre teba.
Pros=C3=ADm, kontaktujte m=C3=B4j s=C3=BAkromn=C3=BD e-mail tu pre viac pod=
robnost=C3=AD:
georgebrown0004@gmail.com

Mnohokr=C3=A1t =C4=8Fakujem vopred,
p=C3=A1n George Brown,
