Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2B58547F1C
	for <lists+cgroups@lfdr.de>; Mon, 13 Jun 2022 07:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232622AbiFMFgd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 Jun 2022 01:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232741AbiFMFgD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 13 Jun 2022 01:36:03 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD47912A9D
        for <cgroups@vger.kernel.org>; Sun, 12 Jun 2022 22:35:36 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id a2so7116024lfg.5
        for <cgroups@vger.kernel.org>; Sun, 12 Jun 2022 22:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=LySdGa6WSWuP57DyggEJLR/XgrjUl+fsCS3/BfNoxBo=;
        b=MMQLuUr/04JdD6h+bOSVzq6FkKGW1jK4dRUQ5RRZgULnPkx8ZPAbdMfROKB0f01oM2
         xtYIkf9112uEUuIkZV/zBrk6d7Ru8iB3LRi1ee260+FrR1jNCqxsW8hBdTa4M6TVqb42
         PNJS7FJvKSSTEmrzL+Jgf91ADt0Ca0zpmxEJhBKqzC84MYEsuwd+4SSmote16X1Mvqps
         kvUAWAoCgOTXygT1y7N5+eb0PZ5bGR63mHbra6sZ3h+5LaEY7aZRoJ9G2vwSfkzRDk/M
         otgCOEA+Ecp2xbajvZSrKQmj9agTuFAAuD9tN2aAfrcL5UdcrflBlsakdQrPqksA4xT9
         i+GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=LySdGa6WSWuP57DyggEJLR/XgrjUl+fsCS3/BfNoxBo=;
        b=yYYMq6MdqPRlsNN+2lfwMPu5YmAToknEzq3vPbrNLmc0SDgtzStj+rL0qKw3dcaZL1
         rpsSIzh5d5vKQAI8NvjcS+SI7pbxKdoGjbf97gWFX4s+KOKRvp4HI5C9OVRvz3docq+9
         buQJoI7EqaIaPR7M17QdBb7xG8SoJ6G/VRI8hj5uwb3/6F3KbB9wPP9f//PR9UNm8LsG
         L18QDH58LmcpgILtM/RVjBASUSRqv5TqDRg0ry8EzzgaQt98S0zI4643W7dt4By7M3/C
         IP1pzlrGDUpOasSIFKHLiv7OBU3RxolLocFrw+fQxnA8rsv8N57hDBnxOuPIDmY6wU8a
         XCdQ==
X-Gm-Message-State: AOAM530RnxFkGbXuKmB/jr2HRdOKD45ngiYECWj1Kr2Omn+o+KBZstrT
        ZSdK7XMOsH6pJbSDByz9AEUrOQ==
X-Google-Smtp-Source: ABdhPJxMkyKV5vTx93A1xGgc69W892dcXfu6ndsf9V1Krre+8NazIcBvdEnZNLY1jvfV+XYxmOL/zg==
X-Received: by 2002:a05:6512:ac6:b0:479:2bdf:749 with SMTP id n6-20020a0565120ac600b004792bdf0749mr27273040lfu.686.1655098535032;
        Sun, 12 Jun 2022 22:35:35 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.129])
        by smtp.gmail.com with ESMTPSA id y2-20020a05651c020200b002557df3669bsm880245ljn.21.2022.06.12.22.35.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jun 2022 22:35:34 -0700 (PDT)
Message-ID: <b49f38c5-7544-c297-6198-6ec20852d043@openvz.org>
Date:   Mon, 13 Jun 2022 08:35:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
From:   Vasily Averin <vvs@openvz.org>
Subject: [PATCH mm v4 7/9] memcg: enable accounting for large allocations in
 mem_cgroup_css_alloc
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel@openvz.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Muchun Song <songmuchun@bytedance.com>, cgroups@vger.kernel.org
References: <3e1d6eab-57c7-ba3d-67e1-c45aa0dfa2ab@openvz.org>
Content-Language: en-US
In-Reply-To: <3e1d6eab-57c7-ba3d-67e1-c45aa0dfa2ab@openvz.org>
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
index 27cebaa53472..a8647a8417e4 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5086,7 +5086,7 @@ static int alloc_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
 {
 	struct mem_cgroup_per_node *pn;
 
-	pn = kzalloc_node(sizeof(*pn), GFP_KERNEL, node);
+	pn = kzalloc_node(sizeof(*pn), GFP_KERNEL_ACCOUNT, node);
 	if (!pn)
 		return 1;
 
@@ -5138,7 +5138,7 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
 	int __maybe_unused i;
 	long error = -ENOMEM;
 
-	memcg = kzalloc(struct_size(memcg, nodeinfo, nr_node_ids), GFP_KERNEL);
+	memcg = kzalloc(struct_size(memcg, nodeinfo, nr_node_ids), GFP_KERNEL_ACCOUNT);
 	if (!memcg)
 		return ERR_PTR(error);
 
-- 
2.36.1

