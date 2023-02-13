Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA25693B60
	for <lists+cgroups@lfdr.de>; Mon, 13 Feb 2023 01:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjBMAeS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 12 Feb 2023 19:34:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjBMAeQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 12 Feb 2023 19:34:16 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4645CEFBF
        for <cgroups@vger.kernel.org>; Sun, 12 Feb 2023 16:34:15 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id p26so28060478ejx.13
        for <cgroups@vger.kernel.org>; Sun, 12 Feb 2023 16:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nametag.social; s=google;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LxA1TCaBk0GL+z3/VOAYiE8xj7jmKbbc+ETm8+jDUgU=;
        b=KjXI8TpYcB7UD4vda6gQOkHeiQ4OFGAzfFk5l6Gm7duO8dyZlqWIhfz2tWFRHFgIk0
         08Zps9JGkKuEMBGwt82tOpXYB0K2oT6QEf4YDHbCfyTizO76atpgcGRV1hNYwpe2XKVS
         WzoZql8vdSoHxWLP/0eH5qjkRZp9+Gey3+AvM/XxBmOtwpEibaxVOQ3hsAiJlK7cZ8nf
         qt9GyG4yiAeIZNEYatEZIj1N9qaMERIacAqK5pb4W1MV5fX34S3FMukm2iZonlNLwRMS
         fDrQfG48USrTgH7DAXotpIa8Q6oFEoY4VJz3fLB9mfz6/XV2Azwr0oJprxLm/goZo7L6
         RC2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LxA1TCaBk0GL+z3/VOAYiE8xj7jmKbbc+ETm8+jDUgU=;
        b=exMtJQB2K+DmfywARadGpJQ2YVOSBvYqErqr5aJGCHlPwwvH3UlwZ7JlyqxEhlGi8A
         O0vIhzr8ou6oXOVR0TG+4GPckfbftumTNvOnxD3qapUQSCDjl2nqMAP1XmOVqtejf9hN
         hkis4VlFwkQHfGieMNhViumD3PHhMAv1V5S/z9AV7rbfTBK7PlcQgQ7C2fm3UThbe5p+
         2okW1KgaCx5fN3Et71YaMojT82jqu4Shyev9kQh5puBeyeAo2gWWexBl4S++3mHAuACI
         3BeGZfNiK3zoqlokfdAQXoLEeXJoXw2/8jzv1m0UpFpgtHo2X9Ema+K9Que5tTlbmnRe
         nSrw==
X-Gm-Message-State: AO0yUKX+dcsUwMWbYMrTXB/V6GX0r9HIdAKyH5a34o7hAdpaBMN6nUOL
        EvVRU0Oy9h0mzWXrfjnSNC9HiUfa7a12tXrvujdL6h5wUD9xL4imeK0=
X-Google-Smtp-Source: AK7set8u+TswiM4EC4XAhGF1keweo8t7/CLbHWqd/CHAl1v2zQREcIl6wkFWh42OjAKhIWeopm0p5cnHZYdXOQXDZL4=
X-Received: by 2002:a17:906:3516:b0:888:6f61:cf55 with SMTP id
 r22-20020a170906351600b008886f61cf55mr3704766eja.14.1676248453623; Sun, 12
 Feb 2023 16:34:13 -0800 (PST)
MIME-Version: 1.0
From:   Victor Stewart <v@nametag.social>
Date:   Mon, 13 Feb 2023 00:34:02 +0000
Message-ID: <CAM1kxwgN40r3tqdUFXPNgSAB3djMTDpDAXOACsS2zOF=LXxeyw@mail.gmail.com>
Subject: [BUG ?]: hugetlb.xxx[.rsvd].max implicit write failure
To:     cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

attempted to use hugetlb resource control for the first time. running 6.1.9

create the subdirectory, then enable the hugetlb controller. reading the
initial value of hugetlb.2MB.rsvd.max returns "max". i write 128 and receive a
return value of 3. but then read hugetlb.2MB.rsvd.max and it now returns 0.
same exact thing happens for hugetlb.2MB.max

so clearly the write is secretly failing somewhere even though the write
operation return success?

there are plenty of pages available:

HugePages_Total:    4096
HugePages_Free:     4096
HugePages_Rsvd:        0
HugePages_Surp:        0
Hugepagesize:       2048 kB
Hugetlb:        13631488 kB

none of the scarce documentation on this controller leads me to believe there's
any required configuration beyond the above. so completely bewildered as to
what's going wrong?
