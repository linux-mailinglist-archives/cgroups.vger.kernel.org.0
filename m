Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12E1A512320
	for <lists+cgroups@lfdr.de>; Wed, 27 Apr 2022 21:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234869AbiD0Tzt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 27 Apr 2022 15:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234954AbiD0Tzr (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 27 Apr 2022 15:55:47 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65363633A3
        for <cgroups@vger.kernel.org>; Wed, 27 Apr 2022 12:52:32 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id ay11so1967948qtb.4
        for <cgroups@vger.kernel.org>; Wed, 27 Apr 2022 12:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5hVT2KZy0tNO5QjzJ5BALuuraIswglFaGXimoEvq+80=;
        b=RoLeBSaeDEDxPoktV5qrOLc4/I2Dx+LTpNZ7Wj6fyQ77YMNwSeXgLPRJ1qSONbpqLR
         mHqNHPCRGKYe4R+86xtlO2LmdTXr+KGN3o2tP5wf1HtVfe2yfZhPfgKQ/S0pSXjGeWkc
         mxQ86Ev3GYvi7pRNES2AeprnQeaQfkrJsRuJwSjC6LRlRdwc3/TvxRjyMO+O/MRok5Px
         FhRWQcQ5QwoUtjRBdLtHkOqa6ia+JwES89j3PzlUKwIvB9YocPRIFt9yXcpXWS0SHeAa
         OYC3h+xkoY6Sima1XoDlvOxF49Whe+96OBjV3uqLt3BX1y19vbvUsaastqGEdSSxG0RR
         66Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5hVT2KZy0tNO5QjzJ5BALuuraIswglFaGXimoEvq+80=;
        b=2q+Jdn7xlWq84x5GFNOV/SFfK33QhrvhqOquluEiDtYTCGeSsz5lFOrlxgxvL1pbYP
         VK6hipZPOBwj+AF++g2KvVOZtsopyJw5ddviR5ai8xv4KZPl+Pmi6jNdHSmueSYV778m
         zIFbX9vrPFOUsnZscz5b/EQ2SL3mNcJudKxiqCC+ygCyOxZZLYZ8jsLgRTerFH9Vj1z4
         ije6hOwMimcgTzy0FWEUjKl4vqjByv7dG630s5Je0vBRaICmxvfU+CewmapS0jn/togX
         jhjzfkbhHw04PT5NRkyN4wLY93cp/BNYpqh7UtlmVGeIZt1fopVkicXd9STJQLgfpoJL
         VXqQ==
X-Gm-Message-State: AOAM533PaGPhanBYSsssYl54MRsWMMUprESYUsO08ck8XYLpFJGThGyE
        p+pCvSL5OJCVzupidxfCj7Moqw==
X-Google-Smtp-Source: ABdhPJwRhN/7MCHg4fuQDFiFHMuBEQ5tjpxnfulCpOI07KCpS4he5/I7tFCZ8oP28DLZFm5ReGemrQ==
X-Received: by 2002:ac8:5f50:0:b0:2f2:1e88:f919 with SMTP id y16-20020ac85f50000000b002f21e88f919mr20853567qta.535.1651089151565;
        Wed, 27 Apr 2022 12:52:31 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:f617])
        by smtp.gmail.com with ESMTPSA id t10-20020a05620a034a00b0069c06c95bf7sm8327696qkm.14.2022.04.27.12.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 12:52:31 -0700 (PDT)
Date:   Wed, 27 Apr 2022 15:51:55 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 4/5] mm: zswap: add basic meminfo and vmstat coverage
Message-ID: <Ymme244DTWy/tAli@cmpxchg.org>
References: <20220427160016.144237-1-hannes@cmpxchg.org>
 <20220427160016.144237-5-hannes@cmpxchg.org>
 <20220427113654.ef8f543d7ba279952deff6f7@linux-foundation.org>
 <YmmRFOXJsjLj4a7T@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmmRFOXJsjLj4a7T@cmpxchg.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Apr 27, 2022 at 02:53:10PM -0400, Johannes Weiner wrote:
> [...] and a delta fixlet for 4/5.

From 35851ad3ddbf30122d755bdf8abea6dc188492a2 Mon Sep 17 00:00:00 2001
From: Johannes Weiner <hannes@cmpxchg.org>
Date: Wed, 27 Apr 2022 15:44:23 -0400
Subject: [PATCH 6/7] mm: zswap: add basic meminfo and vmstat coverage fix

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 Documentation/filesystems/proc.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 736ed384750c..8b5a94cfa722 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -964,6 +964,8 @@ Example output. You may not have all of these fields.
     Mlocked:               0 kB
     SwapTotal:             0 kB
     SwapFree:              0 kB
+    Zswap:              1904 kB
+    Zswapped:           7792 kB
     Dirty:                12 kB
     Writeback:             0 kB
     AnonPages:       4654780 kB
@@ -1055,6 +1057,10 @@ SwapTotal
 SwapFree
               Memory which has been evicted from RAM, and is temporarily
               on the disk
+Zswap
+              Memory consumed by the zswap backend (compressed size)
+Zswapped
+              Amount of anonymous memory stored in zswap (original size)
 Dirty
               Memory which is waiting to get written back to the disk
 Writeback
-- 
2.35.3

