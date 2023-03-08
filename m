Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 703506B0EA3
	for <lists+cgroups@lfdr.de>; Wed,  8 Mar 2023 17:26:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjCHQ0V (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 8 Mar 2023 11:26:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbjCHQ0T (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 8 Mar 2023 11:26:19 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F28C6E65;
        Wed,  8 Mar 2023 08:26:16 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id ff4so11435499qvb.2;
        Wed, 08 Mar 2023 08:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678292775;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dSGH6XW8GGWy2Vlt5EOF3HzragLrWkAt6Pl6/u4DucU=;
        b=En9ZXMIVUd6NZpo/Upabpi/wUSCx0yExcRdNjF/axSruKy2K9v6CA7OeDMP3a/ru9n
         pL9y2zjezsuviNzL0E6V/HZCzlzqC90vqu7LGfuG08q9vH1O0eE411zH8qUX+D/gtGE0
         tSEiT6I5xfRcgCFgsfPzksV+nRLOqFCHPY18ucVNS++GJg2xfxfkOXzCC8d+b+09OF/Z
         bS8fbe+mIauuqeZpC97vkqdt7Y0sqyo3ZSskkmZzZFmjxZnk5N7M41AqEXZdXVK+A1gx
         eHODoCOX9g9owrKSLb6HJPHJjDy1UznEl8NXE104v6PUHJ0AFQeyPIAg3F36YfKq2Oqd
         Snpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678292775;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dSGH6XW8GGWy2Vlt5EOF3HzragLrWkAt6Pl6/u4DucU=;
        b=4NMfs6fKW8zH/2/2/0+8qiuweTyC6gdvJ8AWiHwy9H6W0LQX4edhDjoHa5L8qSvJiw
         ExELkhOWLC7pDL7inx5l8fddbGz/geeODqHi8cpa/moJvQPLWXChiU4PKw8ZEbcblfHY
         4N2ZZDMlpCEGMAxGOwtqQyCTFETAUfoIIbh/prti3KsB2hKgxhu+nS+TYrc/V6S2RRsh
         WnohYKc/C3Zr3pHxmXJPd6WS6QJMYeTeG5pJUwKb8il0v8expGPnzix1aQpfJT+n/fk7
         ZMZorcKDNcf+oT0YViwBQp/fwLE3v42W0veCSWySIkYv4f55oaLLLPpYB0O5Naa/LD5n
         QA6Q==
X-Gm-Message-State: AO0yUKXuMJ8qV4r12J7qYABGRQnYzzu/7MRhIu3TVyjnm+vS3Ozkj+Lw
        rvlBNR5D4O7IjaeHHenetvA=
X-Google-Smtp-Source: AK7set9TI3vxqdtLO0j+SXqyOYnua//R3FeO4371rl129WwGAWY1BSc+8N+B24s98/n93FGr9Iq/EA==
X-Received: by 2002:a05:6214:19cb:b0:570:ee5c:2953 with SMTP id j11-20020a05621419cb00b00570ee5c2953mr45162467qvc.11.1678292775368;
        Wed, 08 Mar 2023 08:26:15 -0800 (PST)
Received: from MSI-FindNS.localdomain ([107.191.40.138])
        by smtp.gmail.com with ESMTPSA id w20-20020a05620a0e9400b0073b8459d221sm11619813qkm.31.2023.03.08.08.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 08:26:15 -0800 (PST)
From:   Yue Zhao <findns94@gmail.com>
To:     akpm@linux-foundation.org
Cc:     roman.gushchin@linux.dev, hannes@cmpxchg.org, mhocko@kernel.org,
        shakeelb@google.com, muchun.song@linux.dev, willy@infradead.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, tangyeechou@gmail.com,
        Yue Zhao <findns94@gmail.com>
Subject: [PATCH v3, 1/4] mm, memcg: Prevent memory.oom.group load/store tearing
Date:   Thu,  9 Mar 2023 00:25:52 +0800
Message-Id: <20230308162555.14195-2-findns94@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230308162555.14195-1-findns94@gmail.com>
References: <20230308162555.14195-1-findns94@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The knob for cgroup v2 memory controller: memory.oom.group
is not protected by any locking so it can be modified while it is used.
This is not an actual problem because races are unlikely (the knob is
usually configured long before any workloads hits actual memcg oom)
but it is better to use [READ|WRITE]_ONCE to prevent compiler from
doing anything funky.

The access of memcg->oom_group is lockless, so it can be
concurrently set at the same time as we are trying to read it.
All occurrences of memcg->oom_group are updated with [READ|WRITE]_ONCE.

Signed-off-by: Yue Zhao <findns94@gmail.com>
---
 mm/memcontrol.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 5abffe6f8389..06821e5f7604 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2067,7 +2067,7 @@ struct mem_cgroup *mem_cgroup_get_oom_group(struct task_struct *victim,
 	 * highest-level memory cgroup with oom.group set.
 	 */
 	for (; memcg; memcg = parent_mem_cgroup(memcg)) {
-		if (memcg->oom_group)
+		if (READ_ONCE(memcg->oom_group))
 			oom_group = memcg;
 
 		if (memcg == oom_domain)
@@ -6623,7 +6623,7 @@ static int memory_oom_group_show(struct seq_file *m, void *v)
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
 
-	seq_printf(m, "%d\n", memcg->oom_group);
+	seq_printf(m, "%d\n", READ_ONCE(memcg->oom_group));
 
 	return 0;
 }
@@ -6645,7 +6645,7 @@ static ssize_t memory_oom_group_write(struct kernfs_open_file *of,
 	if (oom_group != 0 && oom_group != 1)
 		return -EINVAL;
 
-	memcg->oom_group = oom_group;
+	WRITE_ONCE(memcg->oom_group, oom_group);
 
 	return nbytes;
 }
-- 
2.17.1

