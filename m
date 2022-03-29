Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0544EB5BE
	for <lists+cgroups@lfdr.de>; Wed, 30 Mar 2022 00:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233386AbiC2WUO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 29 Mar 2022 18:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiC2WUN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 29 Mar 2022 18:20:13 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB52220F4B
        for <cgroups@vger.kernel.org>; Tue, 29 Mar 2022 15:18:27 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id n63-20020a1c2742000000b0038d0c31db6eso2359301wmn.1
        for <cgroups@vger.kernel.org>; Tue, 29 Mar 2022 15:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:mime-version:content-transfer-encoding
         :content-description:subject:to:from:date:reply-to;
        bh=+v//v9bV1cKxYYqp6E5HrJfuFydY/JXcjMGnmfr7lM0=;
        b=kbqRnaL7ShdczDKxlbY4xppRRUiDsJCrVlFQ10EAUWTXTOdAKkELgH/Hh9p6Sw6kq2
         jwX1V3BBx4mWbLFTncNpsWiAXfcqKUTh01WX8GTYB1LLuMjs8lhFiRcJiLi6+qKVCTJX
         66n+kQ0hm1fn8ny2F1WmkAfIk6+cYFVaeZnavcDGsHw6oL32dZ47bB5zjNAQjTZ5fCUT
         Zezv5+l52rQEcp/ouFViQedDWI/l1qM7Y14o9IyJAj6G5cCeWtz/9SONAUpTJH/+uFVE
         Q0k+bwQkgirioFQXZUfUd6IOBKyGQ/kBe/SAh6kSlg9rav6kgcmPnoUSojBYDjj4JVrr
         wTww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:content-description:subject:to:from:date
         :reply-to;
        bh=+v//v9bV1cKxYYqp6E5HrJfuFydY/JXcjMGnmfr7lM0=;
        b=ATO8r2Gf0oL/mRYRD7K+2rNPY8Inlp//GYHOd1rKjy2K9T8vM+HW0r5VRHsdIeidmT
         XyLuDeZ9tL/czFnKhLST278ZuG+Yrmt6fGSCHEshhmdH+fybhQUxYj7QQwFX/B2mV80M
         Rc/DdA3RjOlvnSv1DmRl7TWYpmvg8Qs6XX7lclQNWXBp39aLvj3qZQ/e7Gi0RMiqrXZZ
         oiVX+D6SrHkKQclefOcA56Ym3LW4X445zsItr0SGfhc9SbtYkKBzZm6tmcv8baSJAmm1
         taZaI1XHu1N2aAegxy25juGs6YKcao5qENx0sb/RmiNOheGup6Pu1I+12ppnENFMZ3ky
         qJHQ==
X-Gm-Message-State: AOAM532bgcewGT3AV2XOaTYNobqyKa0PXouSid8LA+6j4VQbRf0TKtus
        9LPvR6CEmoUyiGnI89BXJVA=
X-Google-Smtp-Source: ABdhPJxN5Qoc7PnxPYYo5+hsC8bR//NaxGwj/dDJXJmohVH1r8+a9EAuzobM8J2e2Eo69yoi+gtnTw==
X-Received: by 2002:a7b:ce83:0:b0:37b:f1f1:3a0c with SMTP id q3-20020a7bce83000000b0037bf1f13a0cmr1614158wmj.10.1648592306417;
        Tue, 29 Mar 2022 15:18:26 -0700 (PDT)
Received: from [172.20.10.4] ([102.91.5.18])
        by smtp.gmail.com with ESMTPSA id u7-20020a05600c19c700b0038cc9aac1a3sm3344347wmq.23.2022.03.29.15.18.17
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 29 Mar 2022 15:18:25 -0700 (PDT)
Message-ID: <624385b1.1c69fb81.4c767.e457@mx.google.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Gefeliciteerd, er is geld aan je gedoneerd
To:     Recipients <adeboyejofolashade55@gmail.com>
From:   adeboyejofolashade55@gmail.com
Date:   Tue, 29 Mar 2022 23:18:12 +0100
Reply-To: mike.weirsky.foundation003@gmail.com
X-Spam-Status: No, score=2.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,T_US_DOLLARS_3 autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Beste begunstigde,

 Je hebt een liefdadigheidsdonatie van ($ 10.000.000,00) van Mr. Mike Weirs=
ky, een winnaar van een powerball-jackpotloterij van $ 273 miljoen.  Ik don=
eer aan 5 willekeurige personen als je deze e-mail ontvangt, dan is je e-ma=
il geselecteerd na een spin-ball. Ik heb vrijwillig besloten om het bedrag =
van $ 10 miljoen USD aan jou te doneren als een van de geselecteerde 5, om =
mijn winst te verifi=EBren
 =

  Vriendelijk antwoord op: mike.weirsky.foundation003@gmail.com
 Voor uw claim.
