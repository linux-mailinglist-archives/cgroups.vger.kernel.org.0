Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF2434BC980
	for <lists+cgroups@lfdr.de>; Sat, 19 Feb 2022 18:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242557AbiBSRUr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 19 Feb 2022 12:20:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239016AbiBSRUr (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 19 Feb 2022 12:20:47 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601DE13FAE9
        for <cgroups@vger.kernel.org>; Sat, 19 Feb 2022 09:20:28 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id y11so4989370pfa.6
        for <cgroups@vger.kernel.org>; Sat, 19 Feb 2022 09:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=pbBDnjkjekxFlDHnJjueH+2zcYzFHyGPFQ9ahc980I8=;
        b=dlXOwTgRrfzmWFrcL1eZDBrcVjJQcF2Cis3Ucu1ukwwidn6aLzkgu85oBW6gNOA1qH
         oHv55qNgl5BGrqHPzO2ayjhYTqXWSJSCjFv1Ara+93xGjJZ2H+t14A2hoXtP+tvig1ID
         9sR68/P7zXnSmRwmOvstSK860F1F0baE8jRNFdvrohX68DeuizlMijtZZkafMOhYgI0A
         bsLdHPMX6D+aDxcRC+V/NMj26p594l8/nJVH7NeXtHCOfxFq345/MfqDN/6djKZAClsx
         HNQAKLoRkF9qWk8FCIwgvND2JOxEME57uZDqyuJBvuSV7+ON6RP1qJwErlCNIX6xMthP
         Id4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=pbBDnjkjekxFlDHnJjueH+2zcYzFHyGPFQ9ahc980I8=;
        b=KG2hWIeykkx/PnoKJJhXIT1nWiqHTas6uKqoA4yTP158Njq35MYCSYT9U83zOxo43C
         FniBGxWuko8XSigJfWWz4BGh9TZpIQA9/q2Qm629jlILWotDE5ypS/sMuDjQmTOCqjQd
         8C02XoSHPRYc8nIdufXViNN/fbh7VlmDUkK+YP5aPqusVCrjJrFV6IsFZcjaPMEYMqJc
         QaNkBdphRxVe3oV3GVw5w89P6t77q8ptc1W7ZA3aNJYVNx5u4IlWUsjtevgR/J8yaSCg
         Sn1tkQiMj611RZEZjHAfpfxCfFoCPJXFnTKwnb9/z59RlMLSjZ0AnkSo52uu//DDc5v5
         xAEg==
X-Gm-Message-State: AOAM5313oTKOZAzr/Cv8K8xV6FG7D8Ac3cLC8JDxlRT8Dt8hynpusWpx
        nueAwj/g9hbGSm9pmfYkdBzR3h1o5gYV7J4i9VY=
X-Google-Smtp-Source: ABdhPJwHSkBeP4LtuHrNzOhyUKFEOx2nSaFLpe7wwKixddshmqtp/kkZMzcZPoUqSQpFhn6EztA6IEGMK9kE+wr1hHc=
X-Received: by 2002:a05:6a00:2285:b0:4e0:617e:dcee with SMTP id
 f5-20020a056a00228500b004e0617edceemr12957968pfe.66.1645291227846; Sat, 19
 Feb 2022 09:20:27 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6a10:235:0:0:0:0 with HTTP; Sat, 19 Feb 2022 09:20:26
 -0800 (PST)
Reply-To: michelleongcheung41@gmail.com
From:   "Mrs. Michelle Ong-Cheung" <hgshsfjhs@gmail.com>
Date:   Sat, 19 Feb 2022 11:20:26 -0600
Message-ID: <CAO8L-O2Au4Z7b87b+4F+fH_N_DMvPLS93xXGc4ycFF_9QR-+yQ@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3AGesch=C3=A4ftsvorschlag?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:441 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [hgshsfjhs[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [michelleongcheung41[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  3.5 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

--=20
Sch=C3=B6nen Tag,

  Ich bin Frau Michelle Ong-Cheung, Kredit- und Marketingdirektorin
bei der CITIBANK OF Hong Kong. Ich habe einen Gesch=C3=A4ftsvorschlag f=C3=
=BCr
Sie. F=C3=BCr weitere Informationen senden Sie mir bitte eine E-Mail
(michelleongcheung41@gmail.com)
