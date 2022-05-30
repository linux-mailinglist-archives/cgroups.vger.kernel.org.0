Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFAD15379C7
	for <lists+cgroups@lfdr.de>; Mon, 30 May 2022 13:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235256AbiE3L0o (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 30 May 2022 07:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235730AbiE3L0n (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 30 May 2022 07:26:43 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5248EB1F6
        for <cgroups@vger.kernel.org>; Mon, 30 May 2022 04:26:39 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id m26so545541ljb.0
        for <cgroups@vger.kernel.org>; Mon, 30 May 2022 04:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=lq150UndXxHEWEhIvsqNd7aCUGl0NaprSMERTMCukMc=;
        b=yL39YrAU3i/NoAsVN95rMmJdSBldmOz1PwlQ73jfMuWdBXrupcnQd2G2xM7mDHLOTw
         5cG1/LbM9ELIeheHf4QRIj9qoEGrwWMMYtTwVRLQaMrZRY2GTI6OHsCLJntYiy66xJLY
         dcyIU7JJNYbu0N8ONgoWHtdXARu59CTqL/J5y5kDSzriAP6IQIHw/6y+net9f403FUOP
         Aes5Xixs/Zs3CgFNNxQ0wi8z2ztQjubVeeh91mEi5dPW+K70JTAiWKmInlePnVUr/5IK
         DTGNdcEdAZiKlmqMNwtccV54snA1/n0921UB4g/zMC0+ndU8bwXFam+o5cqi5VihlEFc
         srgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=lq150UndXxHEWEhIvsqNd7aCUGl0NaprSMERTMCukMc=;
        b=TNIT4Fdl7t3Sl9ZS6RSYFwPxPCygKKD2ZtZUc3kx45dOCNY2B1zhJamEkcJMeE0pAJ
         p9kP4L4vU78QMeErQUKHdoyTXJUF0V4IwsMvNO7T7JN8WvNlcWxj/BOksRZyqNEcP51g
         DH7UYxjivifGMuPwi7iPrVT66TGrVGBLhlmu4qFqJunLVvqeAw4ybZwwPGqQS3hoTldv
         2oWYCc0VyJS79N/ODxgXDoW3hAZUkxXXgjaH/vDIxYF5tMnJewPA9TskD5dlJ6xAipUG
         RUE6+u4wG66o9fpuEE0GVlWgF9pB5EdWVQkVYmzp4tg9h0KsS+o/9PLMMWqqP93ZoDsP
         tQHA==
X-Gm-Message-State: AOAM530tocIbetuOxynpgA0KsY70MtXJVwNq8E4Z+8lB6dPOqiDb4Yr7
        95HB1gSo51vQPpg6hVshOaMV3w==
X-Google-Smtp-Source: ABdhPJwoNEILXS/Ta/5QtJ50Sqhv6gqI05zlzE2tSZ8ZQnzFJ2iJChwRNpf+PMd3ZkCKWgErKXBsxQ==
X-Received: by 2002:a2e:a286:0:b0:253:bff6:ed52 with SMTP id k6-20020a2ea286000000b00253bff6ed52mr33837134lja.229.1653909998100;
        Mon, 30 May 2022 04:26:38 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.129])
        by smtp.gmail.com with ESMTPSA id i16-20020a056512341000b0047855972515sm2257257lfr.72.2022.05.30.04.26.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 May 2022 04:26:37 -0700 (PDT)
Message-ID: <2fbede88-6ef7-4ce7-b3a3-ec349bc2cc06@openvz.org>
Date:   Mon, 30 May 2022 14:26:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
From:   Vasily Averin <vvs@openvz.org>
Subject: [PATCH mm v3 6/9] memcg: enable accounting for percpu allocation of
 struct cgroup_rstat_cpu
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel@openvz.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Muchun Song <songmuchun@bytedance.com>, cgroups@vger.kernel.org
References: <06505918-3b8a-0ad5-5951-89ecb510138e@openvz.org>
 <cover.1653899364.git.vvs@openvz.org>
Content-Language: en-US
In-Reply-To: <cover.1653899364.git.vvs@openvz.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

struct cgroup_rstat_cpu is percpu allocated for each new cgroup and
can consume a significant portion of all allocated memory on nodes
with a large number of CPUs.

Common part of the cgroup creation:
Allocs  Alloc   $1*$2   Sum	Allocation
number  size
--------------------------------------------
16  ~   352     5632    5632    KERNFS
1   +   4096    4096    9728    (cgroup_mkdir+0xe4)
1       584     584     10312   (radix_tree_node_alloc.constprop.0+0x89)
1       192     192     10504   (__d_alloc+0x29)
2       72      144     10648   (avc_alloc_node+0x27)
2       64      128     10776   (percpu_ref_init+0x6a)
1       64      64      10840   (memcg_list_lru_alloc+0x21a)
percpu:
1   +   192     192     192     call_site=psi_cgroup_alloc+0x1e
1   +   96      96      288     call_site=cgroup_rstat_init+0x5f
2       12      24      312     call_site=percpu_ref_init+0x23
1       6       6       318     call_site=__percpu_counter_init+0x22

 '+' -- to be accounted,
 '~' -- partially accounted

Signed-off-by: Vasily Averin <vvs@openvz.org>
Acked-by: Shakeel Butt <shakeelb@google.com>
Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 kernel/cgroup/rstat.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index 24b5c2ab5598..2904b185b01b 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -257,7 +257,8 @@ int cgroup_rstat_init(struct cgroup *cgrp)
 
 	/* the root cgrp has rstat_cpu preallocated */
 	if (!cgrp->rstat_cpu) {
-		cgrp->rstat_cpu = alloc_percpu(struct cgroup_rstat_cpu);
+		cgrp->rstat_cpu = alloc_percpu_gfp(struct cgroup_rstat_cpu,
+						   GFP_KERNEL_ACCOUNT);
 		if (!cgrp->rstat_cpu)
 			return -ENOMEM;
 	}
-- 
2.36.1

