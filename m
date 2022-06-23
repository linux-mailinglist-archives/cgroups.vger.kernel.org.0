Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62302557E3E
	for <lists+cgroups@lfdr.de>; Thu, 23 Jun 2022 16:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbiFWOv4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 23 Jun 2022 10:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232120AbiFWOvu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 23 Jun 2022 10:51:50 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D538473B1
        for <cgroups@vger.kernel.org>; Thu, 23 Jun 2022 07:51:49 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id a13so23938660lfr.10
        for <cgroups@vger.kernel.org>; Thu, 23 Jun 2022 07:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=RJ0ABL9uCwvFv63ZyK8hl1S+g8awXPTVNvHTVH+sSkA=;
        b=VgAQKKEsiHE7SoRPkk1oRDOCQig2wAGOd4W/o+dF2VxecW1m7m7A8NKaTdjY6rAajT
         mVPbyprusIoCKB4TPm6SHYIe3KpCqQ4pzIY7CbdHfGyr5ORXzNRmj2PRvHPzPDQPueHn
         Z76hXIZzwuiGUftMNpZoKoWS9xthi1G7AC/Ew2GNKdBfQqhZ3MUsCmNqCVzvGpl9wzfU
         sa/0UyQ27uVR+L11DOohImUdZ4+okomUQIW1WXxaGaYIvE/q5N8bZW/ooU71RpIi+Eo/
         iAM0GC4i5D9/nVN8TJEWbT3QYi7fwJCEyg7P3n9TS/6boGeH0zIjxQU8xKVtxvk7K9A7
         5rYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=RJ0ABL9uCwvFv63ZyK8hl1S+g8awXPTVNvHTVH+sSkA=;
        b=FfkH5sjuZD4o92A1gv6/MfB9qUEvuq9yZdQ29wT7vzRT95m71XJeCyepzPMmfhlv/n
         HTOWCD6QubziucBDZNT7ZT8W9fdXHsOOKEIO+cQCzfbMOj/r1D6bsRIxDMwZg+mwMQRL
         RFL0YkQhvoeq6OeoaWmWWs44xcMf7WIagZbw0DLGv2kokAIvaY29otJOlCKmyyBEGxfD
         7e/9dKCahIHTH8DJx3E1h2I5ZcYAuQaRiqs52+AkrzsDGKbSlkiDur60Ot8OMq/D30yu
         1m/PJaU7ASgnhi6e0Z1GhFAUMjmMHFlMrADUVK6yDKwd/msfLPX+pXQkt27U6l2hzgFg
         vSvw==
X-Gm-Message-State: AJIora+gw/aHvy8OzhfCiUcHvknIVDJNcw+erNP4ehgIcLRMnzXIz8Ff
        7FqtbY28ikuNHR9nkHSuD/cwYQ==
X-Google-Smtp-Source: AGRyM1v+wrtYYFhb0JXolKG7l98gJTFPDw4sPts1HZmI4WNoqYhmZ/QU9LxTvX7ieU9TzkpzKZmNyw==
X-Received: by 2002:a05:6512:2247:b0:47f:5dff:2eef with SMTP id i7-20020a056512224700b0047f5dff2eefmr5689792lfu.493.1655995907826;
        Thu, 23 Jun 2022 07:51:47 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.129])
        by smtp.gmail.com with ESMTPSA id bd7-20020a05651c168700b0025a8ef49c64sm342231ljb.140.2022.06.23.07.51.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jun 2022 07:51:47 -0700 (PDT)
Message-ID: <045740af-d2a0-a81d-cbb6-153649705087@openvz.org>
Date:   Thu, 23 Jun 2022 17:51:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
From:   Vasily Averin <vvs@openvz.org>
Subject: [PATCH mm v5 7/9] memcg: enable accounting for large allocations in
 mem_cgroup_css_alloc
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel@openvz.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Muchun Song <songmuchun@bytedance.com>, cgroups@vger.kernel.org
References: <4e685057-b07d-745d-fdaa-1a6a5a681060@openvz.org>
Content-Language: en-US
In-Reply-To: <4e685057-b07d-745d-fdaa-1a6a5a681060@openvz.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Creation of each memory cgroup allocates few huge objects in
mem_cgroup_css_alloc(). Its size exceeds the size of memory
accounted in common part of cgroup creation:

common part: 	~11Kb	+  318 bytes percpu
memcg: 		~17Kb	+ 4692 bytes percpu

memory:
------
Allocs  Alloc   $1*$2   Sum     Allocation
number  size
--------------------------------------------
1   +   8192    8192    8192    (mem_cgroup_css_alloc+0x4a) <NB
14  ~   352     4928    13120   KERNFS
1   +   2048    2048    15168   (mem_cgroup_css_alloc+0xdd) <NB
1       1024    1024    16192   (alloc_shrinker_info+0x79)
1       584     584     16776   (radix_tree_node_alloc.constprop.0+0x89)
2       64      128     16904   (percpu_ref_init+0x6a)
1       64      64      16968   (mem_cgroup_css_online+0x32)

1   =   3684    3684    3684    call_site=mem_cgroup_css_alloc+0x9e
1   =   984     984     4668    call_site=mem_cgroup_css_alloc+0xfd
2       12      24      4692    call_site=percpu_ref_init+0x23

     '=' -- already accounted,
     '+' -- to be accounted,
     '~' -- partially accounted

Accounting for this memory helps to avoid misuse inside memcg-limited
contianers.

Signed-off-by: Vasily Averin <vvs@openvz.org>
Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
Reviewed-by: Michal Koutný <mkoutny@suse.com>
Acked-by: Shakeel Butt <shakeelb@google.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/memcontrol.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 85adc43c5a25..275d0c847f05 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5257,7 +5257,7 @@ static int alloc_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
 {
 	struct mem_cgroup_per_node *pn;
 
-	pn = kzalloc_node(sizeof(*pn), GFP_KERNEL, node);
+	pn = kzalloc_node(sizeof(*pn), GFP_KERNEL_ACCOUNT, node);
 	if (!pn)
 		return 1;
 
@@ -5309,7 +5309,7 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
 	int __maybe_unused i;
 	long error = -ENOMEM;
 
-	memcg = kzalloc(struct_size(memcg, nodeinfo, nr_node_ids), GFP_KERNEL);
+	memcg = kzalloc(struct_size(memcg, nodeinfo, nr_node_ids), GFP_KERNEL_ACCOUNT);
 	if (!memcg)
 		return ERR_PTR(error);
 
-- 
2.36.1

