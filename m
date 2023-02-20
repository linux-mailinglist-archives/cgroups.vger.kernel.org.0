Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B683569D06B
	for <lists+cgroups@lfdr.de>; Mon, 20 Feb 2023 16:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbjBTPR1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 20 Feb 2023 10:17:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232153AbjBTPRZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 20 Feb 2023 10:17:25 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC6720D31;
        Mon, 20 Feb 2023 07:16:54 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id s12so1048119qtq.11;
        Mon, 20 Feb 2023 07:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cqn4UGJ8kCDms9H9/KZqG5/8iucyQK2p5fp/dnG15U4=;
        b=j6cDxs5wY9U8hZTNmaA5a6G3X37iP6qPEHkLWjF3w7xw24mwLSVZpKI7rxdjw1DpZ1
         yY3HX6QPcbT3Hd/LyxjYTjBA05guiSfsDuxWRGGTd8aownt9eC8n/LdIYeVDC2sgMrqB
         i6d+3SWBGt8xWt6JyP7sZYNA7Tfn5a/IpE3CJdqvtfCEjBFbjA4aEz14bA7gPajX+FsU
         6S4ckl2T5nrl/y6w8/wgrsRceuNbaQXMGH/piHbPKDSHcxmFIqfdN2WMKCsIyshV0bsw
         GuuYFaBlwrGuwVmo907/NUQAabfHJiFSVy4cVLHfx36k014MeW+bYodgSSyeLrJ2wMos
         WIBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cqn4UGJ8kCDms9H9/KZqG5/8iucyQK2p5fp/dnG15U4=;
        b=6CfQQCLj+aXkzq27lDiL8TywxAWz/60gnU6C+42BUGMZFmZTFLPWbWoaE0jckvjPGM
         ft9InM+ZZgzaMmCyu4GZCqvEy8I5qcAYYVXPNQA6RDopvmUJTpFm92FTNuvo5kNt6ja2
         FUmD5sfvMWRY/z+yaY7Iqg6bqSND9D40yM5xcCgFZqolggIkLm0UnwQ5P5ibjgIHQuDc
         Qb7KncXvESfMvCpazim3RcE7pAN34ccb3x1yIFTneUIl6mbPV4GZ9GRkkh1FhWR8ps3l
         GyUr2cAf2nxYSURun4giB4vkpS7OQbNHHLw4NncSEy3csEMe5XiEVENsNzMVGW98FWEF
         bPiQ==
X-Gm-Message-State: AO0yUKWjAgnV5F2DaIrV8eO04/ZFrYsl9tMawJzYMlaiOTq8hI6WJZjC
        OcIC8Md/EYZmEfZw+N2wiEAgHPuEbldCvh1OqI0=
X-Google-Smtp-Source: AK7set+hAg5SJUcL3lnto1FlTkGqymX3B2++g3tb10cpff1CKBCBS89E1ytt/AWMSw8GP8DfPTzNAA==
X-Received: by 2002:ac8:7dd5:0:b0:3b4:d5be:a2e0 with SMTP id c21-20020ac87dd5000000b003b4d5bea2e0mr94419qte.20.1676906212012;
        Mon, 20 Feb 2023 07:16:52 -0800 (PST)
Received: from MSI-FindNS.localdomain ([107.191.40.138])
        by smtp.gmail.com with ESMTPSA id d127-20020ae9ef85000000b0073ba92629e1sm7292448qkg.23.2023.02.20.07.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 07:16:51 -0800 (PST)
From:   Yue Zhao <findns94@gmail.com>
To:     linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, roman.gushchin@linux.dev,
        hannes@cmpxchg.org, mhocko@kernel.org, shakeelb@google.com,
        muchun.song@linux.dev, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yue Zhao <findns94@gmail.com>
Subject: [PATCH] mm: change memcg->oom_group access with atomic operations
Date:   Mon, 20 Feb 2023 23:16:38 +0800
Message-Id: <20230220151638.1371-1-findns94@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The knob for cgroup v2 memory controller: memory.oom.group
will be read and written simultaneously by user space
programs, thus we'd better change memcg->oom_group access
with atomic operations to avoid concurrency problems.

Signed-off-by: Yue Zhao <findns94@gmail.com>
---
 mm/memcontrol.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 73afff8062f9..e4695fb80bda 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2057,7 +2057,7 @@ struct mem_cgroup *mem_cgroup_get_oom_group(struct task_struct *victim,
 	 * highest-level memory cgroup with oom.group set.
 	 */
 	for (; memcg; memcg = parent_mem_cgroup(memcg)) {
-		if (memcg->oom_group)
+		if (READ_ONCE(memcg->oom_group))
 			oom_group = memcg;
 
 		if (memcg == oom_domain)
@@ -6569,7 +6569,7 @@ static int memory_oom_group_show(struct seq_file *m, void *v)
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
 
-	seq_printf(m, "%d\n", memcg->oom_group);
+	seq_printf(m, "%d\n", READ_ONCE(memcg->oom_group));
 
 	return 0;
 }
@@ -6591,7 +6591,7 @@ static ssize_t memory_oom_group_write(struct kernfs_open_file *of,
 	if (oom_group != 0 && oom_group != 1)
 		return -EINVAL;
 
-	memcg->oom_group = oom_group;
+	WRITE_ONCE(memcg->oom_group, oom_group);
 
 	return nbytes;
 }
-- 
2.17.1

