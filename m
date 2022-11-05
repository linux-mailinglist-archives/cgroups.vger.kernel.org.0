Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B909A61DA6E
	for <lists+cgroups@lfdr.de>; Sat,  5 Nov 2022 13:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbiKEMny (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 5 Nov 2022 08:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiKEMnx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 5 Nov 2022 08:43:53 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 233EF23BE0
        for <cgroups@vger.kernel.org>; Sat,  5 Nov 2022 05:43:52 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id a5so11126340edb.11
        for <cgroups@vger.kernel.org>; Sat, 05 Nov 2022 05:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=c8XA1N0uaxkLO/wKHErNWHaSuu64k5Pjb5u9dmcZrOc=;
        b=mPMWJSv9+I/YyfOX/KhSq6QJxEVF9czxBjlZfOBHyBNprqZzbXMAaGfMuCUz15WUgd
         P8+TrngI9Rc3ViQGUSuldljbiqwUWen18O0hqt/Ie0OeGmALridq11sGaHqFDDc4lalJ
         acwKewZa0Z+JmHCFhOB1EPm3VoCXqyskBeWh+qI8WdUTyGDi2ZRZxfd09WAIYwZTAuE6
         D6FM36pRhxYi0ioJBBk7CWNeJYL6Gz2n7XR51nKKfVaOUPERzSe8HFAiowZB91Qmwfcs
         4SUmlVM/PGDPqE9RxpsHH7kHCVf7N827dpoIMP0fu4UEVHZDK4bGxZoR2Xec1mMJWH/r
         0h6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c8XA1N0uaxkLO/wKHErNWHaSuu64k5Pjb5u9dmcZrOc=;
        b=M+c17Zl1J35oyf+Ia/HU5CnB2FtdaiEa9nBXP17ZLzoTJV0xr19B8c7jHNK5skHNdr
         O+uuYRwJhInb+1tiLrsU0Bz5ebPuFhH8dPDcrYFWsdHZFeWsR28K+ZijtHmi+0CJVNOQ
         wRyj+LjyUH5aJ2zlNqzxmo5Qxx9IckEYd3vAVzZEWgeXPodvgku8ATseNvH87Y+YRKky
         OUCkO2Y5CvlE3zWEHbiV9HC5SCIe8gYB4RWZrZay9lchRyggOd9wcaAnY5U0yDyo3G/b
         +1O5f+e5ZQMTXhCuuiT0qUB8A4rXulT6uhaofBZ8h71u+X8HO4sg/TBqyTQBn9DCXif3
         1w2Q==
X-Gm-Message-State: ACrzQf3I5bSFOvOilV6oRXvb6ska/fleSMWY5cf1i+ONkmn8SfKI1tQR
        /jH3eHawfqmdGp+cRDxQbVaAgJ0H1PjY717u6z8=
X-Google-Smtp-Source: AMsMyM6+i/60GLAa/SmSMCVLMrWq6VlVwX7X2L0dN+kFhjV6izdhKjpdEAZB1JmiGGgnIYpSeGh29lOxg8cgnriAXMM=
X-Received: by 2002:aa7:c504:0:b0:461:122b:882b with SMTP id
 o4-20020aa7c504000000b00461122b882bmr41194609edq.14.1667652230661; Sat, 05
 Nov 2022 05:43:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7208:33:b0:5c:ee07:e4f3 with HTTP; Sat, 5 Nov 2022
 05:43:49 -0700 (PDT)
Reply-To: stefanopessia755@hotmail.com
From:   Stefano Pessina <francisnzioka80@gmail.com>
Date:   Sat, 5 Nov 2022 15:43:49 +0300
Message-ID: <CAL5scYq=1B=-RX8Eh9M9tf4CevQNnnh7JZ63=g4o=AHLN+9dbg@mail.gmail.com>
Subject: Geldspende
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

--=20
Die Summe von 500.000,00 =E2=82=AC wurde Ihnen von STEFANO PESSINA gespende=
t.
Bitte kontaktieren Sie uns f=C3=BCr weitere Informationen =C3=BCber
stefanopessia755@hotmail.com
