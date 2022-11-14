Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 325BB6277A2
	for <lists+cgroups@lfdr.de>; Mon, 14 Nov 2022 09:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236411AbiKNI2k (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 14 Nov 2022 03:28:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236448AbiKNI2i (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 14 Nov 2022 03:28:38 -0500
Received: from mail-yw1-x1142.google.com (mail-yw1-x1142.google.com [IPv6:2607:f8b0:4864:20::1142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1165E17899
        for <cgroups@vger.kernel.org>; Mon, 14 Nov 2022 00:28:35 -0800 (PST)
Received: by mail-yw1-x1142.google.com with SMTP id 00721157ae682-367cd2807f2so99387307b3.1
        for <cgroups@vger.kernel.org>; Mon, 14 Nov 2022 00:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0+TUOsPnDycx17yT5y3SaYxN2lSmtxkJKGL2zeQTOy8=;
        b=DvHVT3Kf+Qfmcc5lHR7qLISxeX+xAoAj2Zg0e4+daovqy9CDlkUmbtqLYoNIzlYFoF
         jHIifKdQbU4Z7SWgFBU4Q8qf0yPRvzc5s0pjalnnG0n/Ee7hcDjR6xG0mvvr0B7HwQru
         bSTlAiW7sOQK56+ae+aR7Efej+FTej0y3teo2A3a7uV7Et2p2lxRwGAXROx+T5veOg4J
         p5OSh8Gj6j05SzN5w+y5RxRikm08j7qWTSgAj0IkXs+u9kw6osoz9vdkPEiFwebtOY5T
         QIx7sT+vj/AtZErFusksDl/0a1nc8cCHGQdBwgdnk5C1zy9LcRSOzFusO6yKd5iSI+J/
         prTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0+TUOsPnDycx17yT5y3SaYxN2lSmtxkJKGL2zeQTOy8=;
        b=lwbdQQnNYAA5B34a6c4F7SaWpx1k+tll1mUAYhseuTw+6lEuMGE6tW6EnLcCmpbcbG
         ns+xf/UKh1F+4/AOWWEfYb55S9WW7tWAgTZgbOzUna4jnTI2S6ZPWmGdkbgrV8knBZ6G
         2wOUqikbLimwRNkbPDVHIg8/Fu3CKOMhDuLAwjNANBO4hbCVfZI+7GAoI0QoMkFr4VnQ
         7He7SCRxwcZQSsqMpxb2gX5BKbtfN8PyC7vtF+8cOGXockNKMAYBPEMsPFBVCgk+bpUZ
         WlpAPRv5hd4Ya9g+c1+FzVnDEBTeKljnayMvom9MmRlOyo7hA/y+7yGN2BXOV+xk3uis
         JqcQ==
X-Gm-Message-State: ANoB5pkXHEAQxj9ixC0pI1qA/CiA1EvPgWB3DvY0GTniI1Y9LK1iJWHS
        MgyWGTJmOpmNuW5kAXef9WZ4lzk2pahZs8aTh8c=
X-Google-Smtp-Source: AA0mqf7VL1tomoCDo2fgbZD3zI+xwBBLGqUVvLbzl5gvbSsUsaBJTdFC41CBwphYMKn89kK82Db14iV2E0kiZQMTwjk=
X-Received: by 2002:a81:1ac9:0:b0:370:5fad:6c01 with SMTP id
 a192-20020a811ac9000000b003705fad6c01mr11375203ywa.327.1668414514498; Mon, 14
 Nov 2022 00:28:34 -0800 (PST)
MIME-Version: 1.0
Sender: goochieng100@gmail.com
Received: by 2002:a05:7000:8464:b0:3dd:a13f:f50d with HTTP; Mon, 14 Nov 2022
 00:28:33 -0800 (PST)
From:   Richard Wahl <richardwahls16@gmail.com>
Date:   Mon, 14 Nov 2022 00:28:33 -0800
X-Google-Sender-Auth: Wb-xsAEhz1PJ_e55LdHikgKA6Gk
Message-ID: <CALn1HmWWyi0F5t2u3_6fEOZ40ivYESz8+emfL7J5NR5gL4AbFg@mail.gmail.com>
Subject: 1.200.000 Euro werden Ihnen zugesprochen
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

--=20
Gute Nachrichten,

Es wird erwartet, dass Sie Ihren Preis in K=C3=BCrze einl=C3=B6sen. Ich bin
"Herr Richard Wahl". Ich habe in der Power Ball-Lotterie ein Verm=C3=B6gen
gewonnen und spende einen Teil davon an zehn
Wohlt=C3=A4tigkeitsorganisationen und zehn gl=C3=BCckliche Menschen. Zum Gl=
=C3=BCck
stehen Sie auf meiner Liste, um dieses freiwillige Spendenangebot zu
erhalten. Antworten Sie jetzt f=C3=BCr weitere Informationen
