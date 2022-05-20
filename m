Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E75152EDEA
	for <lists+cgroups@lfdr.de>; Fri, 20 May 2022 16:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241390AbiETOPh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 20 May 2022 10:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234377AbiETOPg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 20 May 2022 10:15:36 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE5A166D5F
        for <cgroups@vger.kernel.org>; Fri, 20 May 2022 07:15:35 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id w200so7864268pfc.10
        for <cgroups@vger.kernel.org>; Fri, 20 May 2022 07:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=QTCWBzEezgLv+Z2QZNvCkKQgrxXaSDur4w34RcJaRzY=;
        b=B65s5AG+hwem0a8I0Ls4R/CTbYBjo3OWH/zWWT7NDb+vOl3EK3PXmuc3oFF//fdti/
         FP631Q0F2fQdOMXWPw3ewm+3ILGKADYne3USF+0B0zojhWOw19lHkyZwSM3nno/CAnez
         JWM5UifI1ani12qNeKr82itA1HrxiaV6/cRzX54zpKAhwLT4WnCO1SwN+ynHOyOw5BmN
         GfdXcAo/s38qNSDGqUHJD2IJPvDtuo+Y1Vl16KNowThCbhfuC/daT0cVUfaGZcO7QkeD
         M0u60YeVEe9mQhpzf7Xawee/2jaAWWw2YxqT8DeAcGtLyuq0gir2TIROW4bZK1f0fFEl
         MUWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=QTCWBzEezgLv+Z2QZNvCkKQgrxXaSDur4w34RcJaRzY=;
        b=58yy+NuMEQgXD5sqO3fvu+wqd3FscRqn9pS9TQ88qanFrVnMng487YD9q4zVI8OWlZ
         3bU1AVp660gVNjyYXbTZHs005Pxx6tCBl/1aLtqnrXCAtU2RMQdZ4ixv6Abpi/joOKVe
         J9LbQYzGnnQE4P/wveGpLCM/KlwUlqArAoD8LWCPm0uWhk+YClnJr0Uh4uJgBJ7bxEAE
         435hDNCYyXA9xRL2tQ0rGT0d/fFHj3zJcGv0NfIeR4sil4mHaqsDxnMh8KwqemoBez89
         jcLZz+JFYOvCmegDdc9z5ZpbFYOM2mTUnUwAWUk+D0blDzjfBGhiWDAg/7jcc+nijmgM
         W4uQ==
X-Gm-Message-State: AOAM532q04r6oKJoKhH9l137C3KKgF5Z5ep86gUyWt74WkjuseriWB+r
        1wWmZMz63Y6Jxy+BPpDrp422+Tryb3UFvahmJg==
X-Google-Smtp-Source: ABdhPJxo95LVy9Dk2IVCVleqVzTUtx7IZDkBxkuR44+wNwvK+OyO0Nyt/qAqJuKh9ArybGKTGcfuWGfqbWxBn6nSMz4=
X-Received: by 2002:a63:2c91:0:b0:3c6:bd44:6719 with SMTP id
 s139-20020a632c91000000b003c6bd446719mr8669816pgs.516.1653056135134; Fri, 20
 May 2022 07:15:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a06:8cd:b0:4ba:836d:48bc with HTTP; Fri, 20 May 2022
 07:15:34 -0700 (PDT)
Reply-To: illuminatifame157@gmail.com
From:   illuminati <jamesgabriel0805@gmail.com>
Date:   Fri, 20 May 2022 07:15:34 -0700
Message-ID: <CAED57p5DX0zQunM1sE9T+zgbG1H_rw5ympFry9ENw=DGFav0iA@mail.gmail.com>
Subject: illuminati
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:444 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [jamesgabriel0805[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [jamesgabriel0805[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [illuminatifame157[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.4 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  0.0 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  1.4 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

--=20
WILLKOMMEN BEI DER ILLUMINATI BROTHERHOOD ORGANISATION, einem Club der
Reichen und Ber=C3=BChmten, ist die =C3=A4lteste und gr=C3=B6=C3=9Fte Brude=
rschaft der
Welt und besteht aus 3 Millionen Mitgliedern. Wir sind eine gro=C3=9Fe
Familie unter einem Vater, der das h=C3=B6chste Wesen ist. GOTT
. Ich glaube, wir alle haben einen Traum, einen Traum, etwas Gro=C3=9Fes im
Leben zu werden, so viele Menschen sterben heute, ohne ihre Tr=C3=A4ume zu
verwirklichen. Einige von uns sind dazu bestimmt, Pr=C3=A4sident unserer
verschiedenen L=C3=A4nder zu werden oder zu werden. einer der weltbesten
Musiker, Fu=C3=9Fballer, Politiker, Gesch=C3=A4ftsmann, Komiker oder ein He=
lfer
f=C3=BCr andere Menschen zu sein, die in Not sind E.T.C. M=C3=B6chten Sie
Mitglied dieser gro=C3=9Fartigen Organisation werden und Ihren ersten
Vorteil von 1.000.000 Euro erhalten? Wenn JA, antworten Sie bitte auf
diese E-Mail: illuminatifame157@gmail.com oder WhatsApp the great
Grandmaster mit +12312246136
