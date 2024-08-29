Return-Path: <cgroups+bounces-4561-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B6B9641B3
	for <lists+cgroups@lfdr.de>; Thu, 29 Aug 2024 12:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9E671C2117E
	for <lists+cgroups@lfdr.de>; Thu, 29 Aug 2024 10:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2EA1B29D4;
	Thu, 29 Aug 2024 10:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="MKxaSjVm"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB13F1B29C0
	for <cgroups@vger.kernel.org>; Thu, 29 Aug 2024 10:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724926860; cv=none; b=HkQkpaH/4hd6dvTyw3ouyHXbR+zwU7Zb+zfsL688hrDt9qzL58VKpVQzXeq2TlGwB4rPKycbz7kyQHWgKK/l/GKaFexqAXV1ORuxHrWE/Ith4qzF2Spk1MPN3KMlpVxuvFcR9rW4Lp6hgZEud0jgdtx4xSRU/fyBwahEnTqzGyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724926860; c=relaxed/simple;
	bh=40c3l0mWajhxNNgMzb4upe+3sYMx9023oFtW46W0GCo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L30BisuKSei2RCeQ06DB1GMYXT4JtdzuEJYnh12qlVeKTn0o6W426V7lGbnfCAhOaa7bYd3Zo6aaVviw19mz+BnpNTz5/oCsDFbeG/SfAYbkp2J87rwJKN4monBiPVmevp3+/8pOKbfgi72S9AdqgDDGCz5y1H/M3vwF+Gs29Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=MKxaSjVm; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-201d5af11a4so4133655ad.3
        for <cgroups@vger.kernel.org>; Thu, 29 Aug 2024 03:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1724926858; x=1725531658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LxEuLGuLLlfpVLUQyjdn9XrbJexFuQp9KlY1lBVI+bg=;
        b=MKxaSjVm9BXskdU+F0QHgJeMpDXMoOy5cuUE/88V/jo6ZuAGC4BvgqSMHMRRXu/6uR
         CkYZZXUkfoww6v267HmYa7L7Wan1ohRPznY4vb4xJHosART0Uajn9tbWEmxHJiG1u9ld
         sLGCcdsVlPzyC568FyfEiIvPW2bOLIhhw2I/1uRsfTwoN4ye/yKjYHrMAN4V7DWp/M19
         nDXvZBEa3h2edkM8ZQRDkjuXjjWNJQwL/trBu3S5hpCzSbtjo5mCDqovUOx4TwzitmLB
         XtSasddh5vShMpZXtQQGXl9uS5fOPF+ME2rS3QEbrLLkHIKJzRrotWr3dbdf3gAto90d
         f2cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724926858; x=1725531658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LxEuLGuLLlfpVLUQyjdn9XrbJexFuQp9KlY1lBVI+bg=;
        b=i84GpgO0G74Mq+xB3I/f/OjoywA0SM/mNoBfZoIOlEHDqOlm/3epkvs/E1WjvX+THE
         Ncg83A00fkW/NlB9zU9x8IiNVCHzWxrZUsUVbT1dsikgI0QcY8Gw2qpirp/qtoUcAQha
         dQ4w44Sthh65sv0nMyUZziHicgFrhPTHvOJ+qAcgixSIbmLYyyaNFXewwiMvWCH9Yu4D
         Ed2PwNd+LMYeJtkJMNoQoc9zbwgGrbdukBztaaE+tGkuD5kR2ibqH402JttnkZXedDSe
         eDaqxUmMT7MGJAH0Mi3QJnDMeTx3Qgp3nlSus1LxOU7W9orvhRvG/lAy2Qsc/TgXh8nn
         28vA==
X-Forwarded-Encrypted: i=1; AJvYcCU0fqrGNP74sytyYsvocUkTEGLM71h1JDG3Bju4r9xqeAYNNZ2UEYVXsipNNxNpdyvO6lKfbwJl@vger.kernel.org
X-Gm-Message-State: AOJu0YwOtcSPadphET5GM8ErtfPIUKfLTClQoDh800qCix9fbFN+FOVy
	HzUIL8QHg8p3MOIyYLfJO+ssgSVchKOSDI0EKM8u4OwsxdudOS/NhlAVqflfEhTSG/bxw3leVlT
	d
X-Google-Smtp-Source: AGHT+IGiChsduuOeCBhmi3FuNaA5wdY9oxIgLe+AT8c04YtsobEYBqNcPH6TPr9CWLw8iWUvRNwL9g==
X-Received: by 2002:a17:903:8c8:b0:202:3762:ff88 with SMTP id d9443c01a7336-2050c4d2ebbmr33268465ad.63.1724926858195;
        Thu, 29 Aug 2024 03:20:58 -0700 (PDT)
Received: from n37-034-248.byted.org ([180.184.51.134])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-205155673a2sm8355725ad.303.2024.08.29.03.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 03:20:56 -0700 (PDT)
From: Zhongkun He <hezhongkun.hzk@bytedance.com>
To: akpm@linux-foundation.org,
	hannes@cmpxchg.org,
	mhocko@kernel.org
Cc: roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	lizefan.x@bytedance.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	Zhongkun He <hezhongkun.hzk@bytedance.com>
Subject: [RFC PATCH 2/2] mm: memcg: add disbale_unmap_file arg to memory.reclaim
Date: Thu, 29 Aug 2024 18:20:39 +0800
Message-Id: <20240829102039.3455842-2-hezhongkun.hzk@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240829102039.3455842-1-hezhongkun.hzk@bytedance.com>
References: <20240829102039.3455842-1-hezhongkun.hzk@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow proactively memory reclaimers to submit an additional
disbale_unmap_file argument to memory.reclaim. This will
skip the mapped file for that reclaim attempt.

For example:

echo "2M disable_unmap_file" > /sys/fs/cgroup/test/memory.reclaim

will perform reclaim on the test cgroup with no mapped file page.

The memory.reclaim is a useful interface. We can carry out proactive
memory reclaim in the user space, which can increase the utilization
rate of memory. In the actual usage scenarios, we found that when
there are sufficient anonymous pages, mapped file pages with a
relatively small proportion would still be reclaimed. This is likely
to cause an increase in refaults and an increase in task delay,
because mapped file pages usually include important executable codes,
data, and shared libraries, etc. According to the verified situation,
if we can skip this part of the memory, the business delay will be reduced.

Even if there are sufficient anonymous pages and a small number of
page cache and mapped file pages, mapped file pages will still be reclaimed.
Here is an example of anonymous pages being sufficient but mapped
file pages still being reclaimed:

cat memory.stat | grep -wE 'anon|file|file_mapped'
anon 3406462976
file 332967936
file_mapped 300302336

echo 1g > memory.reclaim swappiness=200 > memory.reclaim
cat memory.stat | grep -wE 'anon|file|file_mapped'
anon 2613276672
file 52523008
file_mapped 30982144

echo 1g > memory.reclaim swappiness=200 > memory.reclaim
cat memory.stat | grep -wE 'anon|file|file_mapped'
anon 1552130048
file 39759872
file_mapped 20299776

With this patch, the file_mapped pages will be skiped.

echo 1g > memory.reclaim swappiness=200 disable_unmap_file  > memory.reclaim
cat memory.stat | grep -wE 'anon|file|file_mapped'
anon 480059392
file 37978112
file_mapped 20299776

IMO,it is difficult to balance the priorities of various pages in the kernel,
there are too many scenarios to consider. However, for the scenario of proactive
memory reclaim in user space, we can make a simple judgment in this case.

Signed-off-by: Zhongkun He <hezhongkun.hzk@bytedance.com>
---
 include/linux/swap.h | 1 +
 mm/memcontrol.c      | 9 +++++++--
 mm/vmscan.c          | 4 ++++
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index ca533b478c21..49df8f3748e8 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -409,6 +409,7 @@ extern unsigned long try_to_free_pages(struct zonelist *zonelist, int order,
 
 #define MEMCG_RECLAIM_MAY_SWAP (1 << 1)
 #define MEMCG_RECLAIM_PROACTIVE (1 << 2)
+#define MEMCG_RECLAIM_DIS_UNMAP_FILE (1 << 3)
 #define MIN_SWAPPINESS 0
 #define MAX_SWAPPINESS 200
 extern unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 35431035e782..7b0181553b0c 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4282,11 +4282,13 @@ static ssize_t memory_oom_group_write(struct kernfs_open_file *of,
 
 enum {
 	MEMORY_RECLAIM_SWAPPINESS = 0,
+	MEMORY_RECLAIM_DISABLE_UNMAP_FILE,
 	MEMORY_RECLAIM_NULL,
 };
 
 static const match_table_t tokens = {
 	{ MEMORY_RECLAIM_SWAPPINESS, "swappiness=%d"},
+	{ MEMORY_RECLAIM_DISABLE_UNMAP_FILE, "disable_unmap_file"},
 	{ MEMORY_RECLAIM_NULL, NULL },
 };
 
@@ -4297,7 +4299,7 @@ static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
 	unsigned int nr_retries = MAX_RECLAIM_RETRIES;
 	unsigned long nr_to_reclaim, nr_reclaimed = 0;
 	int swappiness = -1;
-	unsigned int reclaim_options;
+	unsigned int reclaim_options = 0;
 	char *old_buf, *start;
 	substring_t args[MAX_OPT_ARGS];
 
@@ -4320,12 +4322,15 @@ static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
 			if (swappiness < MIN_SWAPPINESS || swappiness > MAX_SWAPPINESS)
 				return -EINVAL;
 			break;
+		case MEMORY_RECLAIM_DISABLE_UNMAP_FILE:
+			reclaim_options = MEMCG_RECLAIM_DIS_UNMAP_FILE;
+			break;
 		default:
 			return -EINVAL;
 		}
 	}
 
-	reclaim_options	= MEMCG_RECLAIM_MAY_SWAP | MEMCG_RECLAIM_PROACTIVE;
+	reclaim_options	|= MEMCG_RECLAIM_MAY_SWAP | MEMCG_RECLAIM_PROACTIVE;
 	while (nr_reclaimed < nr_to_reclaim) {
 		/* Will converge on zero, but reclaim enforces a minimum */
 		unsigned long batch_size = (nr_to_reclaim - nr_reclaimed) / 4;
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 50ac714cba2f..1b58126a8246 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -6609,6 +6609,10 @@ unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
 		.may_swap = !!(reclaim_options & MEMCG_RECLAIM_MAY_SWAP),
 		.proactive = !!(reclaim_options & MEMCG_RECLAIM_PROACTIVE),
 	};
+
+	if (reclaim_options & MEMCG_RECLAIM_DIS_UNMAP_FILE)
+		sc.may_unmap &= ~UNMAP_FILE;
+
 	/*
 	 * Traverse the ZONELIST_FALLBACK zonelist of the current node to put
 	 * equal pressure on all the nodes. This is based on the assumption that
-- 
2.20.1


