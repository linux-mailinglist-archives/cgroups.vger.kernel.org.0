Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F75552668F
	for <lists+cgroups@lfdr.de>; Fri, 13 May 2022 17:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382263AbiEMPwE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 13 May 2022 11:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236362AbiEMPwA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 13 May 2022 11:52:00 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39AB11D8B57
        for <cgroups@vger.kernel.org>; Fri, 13 May 2022 08:51:59 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id t25so15234438lfg.7
        for <cgroups@vger.kernel.org>; Fri, 13 May 2022 08:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=xdLDfq+CWT8JDkKJCr5lOfzn0f1CBOYqpqvcgd4oF3I=;
        b=AOt8diTFiicIrXp0RywXesaFiBTVFqNQpRUmgcob7AdT1m4qVHyAT/nPjfEfourXYu
         VFFaL/IDpLxzjUSSTYCu5hMuf+OKjYOe/HamJ6cYFtndD5F80Cxs9vngm1uigjcBc6YV
         McmK5Boa/eUKkqJaZzTZaqNWHiI/9NzMTpCfl0yHN9zl8kJEZnuUvwE/hiAx8v0cXZ7k
         xQyr4Lsk69dMvKMPJu61svF+KqC73U4AGIa8cXKDNGEkykKhh2PtQC0YkehHHGgigu32
         U5z6wawLGwA5a18ezUpeVzwNCtOjC6Wxio0XMepLaQpfoVKBQVIkqv61BTkxIPek6ifk
         u0lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=xdLDfq+CWT8JDkKJCr5lOfzn0f1CBOYqpqvcgd4oF3I=;
        b=phjZ9dAXMe0aQMMmJkHZ1qEi4YUbsEQr5gbA9Qwc6IInsghg3zIhQPn6h6MkfZAjOF
         TNsAFlce8lwbMMC5qZFOodNM5kp1humBAAWuVqMnZJ0gKNN+BiHE1tU1NtJbXuLhNjdG
         wmcwJiLXF50mqv3tyu2F+KVkdu16a0ul9zKY7AnNEYTGkWuUzLIS2Pr1+P/W4wb7j7Kq
         B8gFFNnK24xKhrNuibdojbKvop4INMXdo19iw1Iabq0Z/tifyuLky+6lo8i96NW/8Lj0
         I+XKlRIW6HSa8N8sAOFuZ1DrUBqpjJ3F2oCy1zSAF13udSXEzpQPt9GNW+cKkaFf3/dU
         p0Yg==
X-Gm-Message-State: AOAM5323FHIhibfgxcom3ngxjQ5SE2ScteyDy6SFgxZCAVTX+VXXKSU3
        mLzqxxCy5Ei6eaEdGj6F/PwZJg6qbgm64Q==
X-Google-Smtp-Source: ABdhPJym7XGGezghwcny0ZJvKb40eiQrd9ujhf41bXkzlGVxcZGs1sS9w9gXzrrcTz+3XxNXw5MX8A==
X-Received: by 2002:a05:6512:3d86:b0:473:a237:6e09 with SMTP id k6-20020a0565123d8600b00473a2376e09mr3812958lfv.441.1652457117596;
        Fri, 13 May 2022 08:51:57 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.177])
        by smtp.gmail.com with ESMTPSA id m13-20020a2e934d000000b0024f3d1daef1sm477359ljh.121.2022.05.13.08.51.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 May 2022 08:51:57 -0700 (PDT)
Message-ID: <22ccf325-6aa5-9b55-4729-d03f34125650@openvz.org>
Date:   Fri, 13 May 2022 18:51:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
From:   Vasily Averin <vvs@openvz.org>
Subject: [PATCH 2/4] memcg: enable accounting for kernfs nodes and iattrs
To:     Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Cc:     kernel@openvz.org, linux-kernel@vger.kernel.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>, cgroups@vger.kernel.org
References: <Ynv7+VG+T2y9rpdk@carbon>
Content-Language: en-US
In-Reply-To: <Ynv7+VG+T2y9rpdk@carbon>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

kernfs nodes are quite small kernel objects, however there are few
scenarios where it consumes significant piece of all allocated memory:

1) creating a new netdevice allocates ~50Kb of memory, where ~10Kb
   was allocated for 80+ kernfs nodes.

2) cgroupv2 mkdir allocates ~60Kb of memory, ~10Kb of them are kernfs
   structures.

3) Shakeel Butt reports that Google has workloads which create 100s
   of subcontainers and they have observed high system overhead
   without memcg accounting of kernfs.

It makes sense to enable accounting for kernfs objects, otherwise its
misuse inside memcg-limited can lead to global memory shortage,
OOM and random kills of host processes.

Signed-off-by: Vasily Averin <vvs@openvz.org>
---
 fs/kernfs/mount.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index cfa79715fc1a..40e896c7c86b 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -391,10 +391,12 @@ void __init kernfs_init(void)
 {
 	kernfs_node_cache = kmem_cache_create("kernfs_node_cache",
 					      sizeof(struct kernfs_node),
-					      0, SLAB_PANIC, NULL);
+					      0, SLAB_PANIC | SLAB_ACCOUNT,
+					      NULL);
 
 	/* Creates slab cache for kernfs inode attributes */
 	kernfs_iattrs_cache  = kmem_cache_create("kernfs_iattrs_cache",
 					      sizeof(struct kernfs_iattrs),
-					      0, SLAB_PANIC, NULL);
+					      0, SLAB_PANIC | SLAB_ACCOUNT,
+					      NULL);
 }
-- 
2.31.1

