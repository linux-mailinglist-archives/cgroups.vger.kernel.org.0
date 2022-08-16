Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3117159562B
	for <lists+cgroups@lfdr.de>; Tue, 16 Aug 2022 11:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233444AbiHPJ0x (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 16 Aug 2022 05:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232633AbiHPJ00 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 16 Aug 2022 05:26:26 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91FAA4BA58
        for <cgroups@vger.kernel.org>; Tue, 16 Aug 2022 00:43:07 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id y23so9815671ljh.12
        for <cgroups@vger.kernel.org>; Tue, 16 Aug 2022 00:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :reply-to:mime-version:from:to:cc;
        bh=mTe6rsF1WlocKfWRCIawejpNJl6lRYSIlYxDz8jltlQ=;
        b=OTkyhqiu4eL0Rx2gQO4KaokXvXIhe7HTt/scr7ZrIw0uSNgo3kpcmp7McVEJCc8+jH
         9KT05LAJht97tyYTK+DaLfSrz9wd/aATs4E1EBlNlwetM/qdF8ryUlFBxUyWygTcRVt0
         ZhkecAnhoRA0yq55+jZxFtQEZVvEyJAW/2LL3QgEcMNh60St9Sg4ggqlWbm63NMD9mZ1
         0pIoNpY/alVmEU+8ARHyfbwVJg/7rheXFJVmhZslqWG2pN54sncVLJRMEYyk28/YBX+4
         lEN18rD5lO/9t2Jy2ugPRCMRClMGLCBsRxTkVSWvyNchqR0LXld4M7rizizxXdZRvr45
         XErA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :reply-to:mime-version:x-gm-message-state:from:to:cc;
        bh=mTe6rsF1WlocKfWRCIawejpNJl6lRYSIlYxDz8jltlQ=;
        b=QTZsbX3BE0EofYSAGOIdGTmeF+oq+sAbmeCARFor3haMqIiSBezHZA6Ir0YBy3n1zA
         BJlKH2qjBaShgb+Jzl5s0PPcGaDxSiNs91oz90LrST5dMueZMx+id/va3JV4sSHDiG/k
         TYT7HY9dGJJFo6aWDaJvxLSpFWpqgrU2H3T468yCOseXGR1DjcyTtjmCQipnDKVVy3IM
         0E4vppgtKFmc2Ebo9a7xWuFOdP2Hxk64SfWW9VgXcJt7JcMFGdXos2zSZLGycY6zUL58
         fQrtGr2rI6JZIRJwZDY73W+jfBSR4ZGAXmMF4yg5JRsWic6vI8TOSNq/o5+SRCSIrQ7t
         lZ+w==
X-Gm-Message-State: ACgBeo3i8kIpmwZrs19JzYDP6fAzh+vygp/T9ZQcTFrgHeUd3HHzP4sw
        eRk3Lu/md669piUN8l6WX4eHAJuNqkdvbnM54w==
X-Google-Smtp-Source: AA6agR55sWPvoUJBqM+k8/BXGWKZU1FXCEbbGsJnIHJkCQ4WGHjZW6g25js68KE573+mAh7Q+hcz/xs/s/deIjthHbk=
X-Received: by 2002:a05:651c:1026:b0:25e:77f3:e0bd with SMTP id
 w6-20020a05651c102600b0025e77f3e0bdmr5803529ljm.383.1660635785664; Tue, 16
 Aug 2022 00:43:05 -0700 (PDT)
MIME-Version: 1.0
Reply-To: zahirikeen@gmail.com
Sender: aliwattara1961@gmail.com
Received: by 2002:a05:6500:2109:b0:152:a956:cc09 with HTTP; Tue, 16 Aug 2022
 00:43:04 -0700 (PDT)
From:   Zahiri Keen <zahirikeen2@gmail.com>
Date:   Tue, 16 Aug 2022 07:43:04 +0000
X-Google-Sender-Auth: mr9dljV6nY0FpHbE1lTHGBIDHPg
Message-ID: <CAFX=yDN7Lh1-f_tsHDzH-dkUnYqFguDNO5=BeFFPDbx=oLFP4g@mail.gmail.com>
Subject: Urgent Please.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Good Day,

I know this email might come to you as a surprise because is coming
from someone you haven=E2=80=99t met with before.

I am Mr. Zahiri Keen, the bank manager with BOA bank i contact you for
a deal relating to the funds which are in my position I shall furnish
you with more detail once your response.

Regards,
Mr.Zahiri
