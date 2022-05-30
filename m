Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A283A5379E2
	for <lists+cgroups@lfdr.de>; Mon, 30 May 2022 13:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235433AbiE3L26 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 30 May 2022 07:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235774AbiE3L1K (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 30 May 2022 07:27:10 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 818F71FCF4
        for <cgroups@vger.kernel.org>; Mon, 30 May 2022 04:27:02 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id e4so11271621ljb.13
        for <cgroups@vger.kernel.org>; Mon, 30 May 2022 04:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=1bz2HF6EsnuVkI8ZLNySbZ6/e4i0Dqd56vDd6/MtYsM=;
        b=MJH7jgZ0nByKKabpLoAPA5HN9v21BI0dbjoYKv7JTJsZIG9t7CYmKL10/W6A4CAJjz
         YjoRkjjkc7rnBG4iIl52t8YBffLXDTaOk0FPU+R/iUFJxypPSriGxh9W/Yp0Xb2YBS3n
         u8rGfnyQ69D7OdxyAxhEqBpRbcEOZtgatuzFi1ROaPTtGWFVuQ8Ynlz3uO4xDFqo8r4l
         WK/pDR4j7nZ8vJmIiytexPw++UZNwa2TUENNay2Qdqs1hgi/d47tM/IS92zI/+yxh40n
         /qegCkoMk0oOX1fRJCG8CUX8qr6p2SS7H4vuyz1TCOxloqJz6bEygG1OkLqHyZ3QIEiK
         J+yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=1bz2HF6EsnuVkI8ZLNySbZ6/e4i0Dqd56vDd6/MtYsM=;
        b=J9MO0IupE9sQ+aRehE/UQ9puV01U5+aTdqfdLrh5M/jJIvTCO6KvJFgGiSJwqNapTM
         hS/bFLl5HJ4CBW1RXbpYfdEHdemXq4AXSnHq9OKu/7oiftpeSZhDmnOCRz5qcoY0w3td
         hyRqXfyKP2VSR23aQehlXfh03fReX2d/jLUBXkJEh8qreet1pEDKLUugWrBrrQziQSxg
         KlHIaOdZagZYivGpDKe22u9pRw5twoLdcbFovkEd/xugQKYW6XlJx0aLJXIDiZiVq7nj
         Lh+xMEHTJ0YiD7eDPujLMJLgomYG2K0NDbuGC4c5TIYdbBnAlFmCTZheu3iKUdBFTIOr
         CYZg==
X-Gm-Message-State: AOAM530KgUCgg5YnDsfXwOAwKxBjRm5o+UPRY3UsjO5Wr0ra+FMEYLYy
        X/UxS5sGdgMGba0CaEKvgE7eVQ==
X-Google-Smtp-Source: ABdhPJxchjq+vPEv7BDN5f83/B73zaDF6zRhHb+aUExV2DDt1M6CIZoAIgyJaA82Tud2AlFiPpMv+A==
X-Received: by 2002:a2e:a448:0:b0:24c:8fe8:f3c6 with SMTP id v8-20020a2ea448000000b0024c8fe8f3c6mr32212835ljn.115.1653910021164;
        Mon, 30 May 2022 04:27:01 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.129])
        by smtp.gmail.com with ESMTPSA id x37-20020a056512132500b0047255d2115csm2254247lfu.139.2022.05.30.04.27.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 May 2022 04:27:00 -0700 (PDT)
Message-ID: <ea77f3ea-3832-83e8-b33d-6df40b01ee67@openvz.org>
Date:   Mon, 30 May 2022 14:26:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
From:   Vasily Averin <vvs@openvz.org>
Subject: [PATCH mm v3 8/9] memcg: enable accounting for allocations in
 alloc_fair_sched_group
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
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Creating of each new cpu cgroup allocates two 512-bytes kernel objects
per CPU. This is especially important for cgroups shared parent memory
cgroup. In this scenario, on nodes with multiple processors, these
allocations become one of the main memory consumers.

Memory allocated during new cpu cgroup creation:
common part: 	~11Kb	+  318 bytes percpu
cpu cgroup:	~2.5Kb	+ 1036 bytes percpu

Accounting for this memory helps to avoid misuse inside memcg-limited
contianers.

Signed-off-by: Vasily Averin <vvs@openvz.org>
Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
Reviewed-by: Michal Koutný <mkoutny@suse.com>
Acked-by: Shakeel Butt <shakeelb@google.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
---
 kernel/sched/fair.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8c5b74f66bd3..f4fc39d5aa4b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11499,12 +11499,12 @@ int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
 
 	for_each_possible_cpu(i) {
 		cfs_rq = kzalloc_node(sizeof(struct cfs_rq),
-				      GFP_KERNEL, cpu_to_node(i));
+				      GFP_KERNEL_ACCOUNT, cpu_to_node(i));
 		if (!cfs_rq)
 			goto err;
 
 		se = kzalloc_node(sizeof(struct sched_entity_stats),
-				  GFP_KERNEL, cpu_to_node(i));
+				  GFP_KERNEL_ACCOUNT, cpu_to_node(i));
 		if (!se)
 			goto err_free_rq;
 
-- 
2.36.1

