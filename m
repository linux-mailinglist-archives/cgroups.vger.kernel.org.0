Return-Path: <cgroups+bounces-5303-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D1EC9B4037
	for <lists+cgroups@lfdr.de>; Tue, 29 Oct 2024 03:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7307283542
	for <lists+cgroups@lfdr.de>; Tue, 29 Oct 2024 02:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B118D1865E3;
	Tue, 29 Oct 2024 02:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lrba836B"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B60A191473
	for <cgroups@vger.kernel.org>; Tue, 29 Oct 2024 02:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730167878; cv=none; b=fui48nmXnSt8OmrtlUn/h33EyGb6JSzJl330sHEJLNpZPTYQeHJQRgLdeZ9m99rtVHQnBmualcwR3hMiiMsWlBd/LVSQSFs4m/sRI/Ga0sMDhPOSbD+hV7RhQGjUkXG2d5w2juz3gFQKqML5xsIl5KswpuH6sIy/ExN76Nrv/qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730167878; c=relaxed/simple;
	bh=G76s8iaF4UVinWPiL0juB0ceCSCC0343XnvW7cJf45s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZYRBkT2xkzn0dZaeOglf3Zs4qvI8kIBv0nHZGV+AvyqS6rBWo2AVsugn58fHscMq6v6NzjeAr2c6CJgPkvh5kSCwloDgBB+u812IfocpRidzTc7W/QM4lEvNY4dNRk9a5yt1snwoURv4sXed9e/n1XiHuzP5bo47u1RQtCDiSTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lrba836B; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7204dff188eso3321694b3a.1
        for <cgroups@vger.kernel.org>; Mon, 28 Oct 2024 19:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730167876; x=1730772676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZfFEnuh6gftdmCwDfPZ6PKpUs+SUjbW0Y//0IHu2mN0=;
        b=Lrba836BWqosXObdO1vy/IRmj/KZBBmmvxS9tWuBQX/UWGVhUFg07Ubhb7lq1y7Gx7
         LmI/G2t2JO/MbvZj7aKZzidW3hTW07sNbkK5uiGacVHql/uZBsJF7pK/r4TuBn/VmKK/
         bLSwDidA9a8Th1u7KzAPLsC759veN+rFJtlJcxZanXlxFMMIaP+Ws21H+fr/Rp313LQM
         fDbFY8zI7p5pjSWTrCbFNJkfYeh+U/veEqYGqRA25lE1XhPMSNkRgEBYRMPGuMkjLjFA
         /DP22hHxzQFypToeX5+VtRi6MA3d23VH2Dz2vuo9PXV3M1gJmwweoZthFc0DFNyDmsAe
         6n3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730167876; x=1730772676;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZfFEnuh6gftdmCwDfPZ6PKpUs+SUjbW0Y//0IHu2mN0=;
        b=DtezPPXYgd/wW5rFLF9jlv/6zIiT0offpXgYMTYgp3zW7nUH4xDCakNtrR1EjZ/WvV
         g/6gftwxH6wTuW+EAvwpE6iBl0ZWR/k+awdKeuLFcOv0sHVNGrhXWdvc0hmV0YQOronv
         Zz2Ld/LPq5Mo3ZJ11N3NY75dbsG/JnfK7P4eUvrECKKk+yNsGNkmRvgEoBqWqH9VSQ17
         7fQbvsimu5U5TMhDa//tWaiVRwcNzrmMcMvEXee9KDo4J9pnGjveJnIaERXtPXd2CKx1
         kg5Wk91adlPndBr1nnLiakEACKiV0fx3rlxBbOXP9eyrvMS8TeYXIp2XCk7DxRYje6dr
         QTag==
X-Forwarded-Encrypted: i=1; AJvYcCVyAkNFDIUIxLKq0HiLHAGsF1CDPiGFPy/x7JY08rd8yqqRPesiDv205wSnaVO73YfAcMh2eQp4@vger.kernel.org
X-Gm-Message-State: AOJu0YyfWDexn41VbiGEfCgJTO/HSWsjbn1oRY6qScFRADAG+xF0uJAA
	W7Ctxbu2QXt9IYf43bcsNbqF+geY4oqrwiBappaFRbJvhtmCdHBU
X-Google-Smtp-Source: AGHT+IGfQBvk0vmxp09GuYzYsGZsv+PuE0xeLirh8A59YQf/ZpVgCAgrN87P7cfWEpfhY3L0VGgiYQ==
X-Received: by 2002:a05:6a00:cd2:b0:71e:8046:2728 with SMTP id d2e1a72fcca58-7206303dfa3mr14853618b3a.17.1730167875780;
        Mon, 28 Oct 2024 19:11:15 -0700 (PDT)
Received: from saturn.. (c-67-188-127-15.hsd1.ca.comcast.net. [67.188.127.15])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057a0df99sm6500884b3a.118.2024.10.28.19.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 19:11:15 -0700 (PDT)
From: JP Kobryn <inwardvessel@gmail.com>
To: shakeel.butt@linux.dev,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	akpm@linux-foundation.org,
	rostedt@goodmis.org
Cc: linux-mm@kvack.org,
	cgroups@vger.kernel.org
Subject: [PATCH 1/2 v3] memcg: rename do_flush_stats and add force flag
Date: Mon, 28 Oct 2024 19:11:05 -0700
Message-ID: <20241029021106.25587-2-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241029021106.25587-1-inwardvessel@gmail.com>
References: <20241029021106.25587-1-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change the name to something more consistent with others in the file and
use double unders to signify it is associated with the
mem_cgroup_flush_stats() API call. Additionally include a new flag that
call sites use to indicate a forced flush; skipping checks and flushing
unconditionally. There are no changes in functionality.

Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
---
 mm/memcontrol.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 18c3f513d766..59f6f247fc13 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -588,8 +588,11 @@ static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val)
 	}
 }
 
-static void do_flush_stats(struct mem_cgroup *memcg)
+static void __mem_cgroup_flush_stats(struct mem_cgroup *memcg, bool force)
 {
+	if (!force && !memcg_vmstats_needs_flush(memcg->vmstats))
+		return;
+
 	if (mem_cgroup_is_root(memcg))
 		WRITE_ONCE(flush_last_time, jiffies_64);
 
@@ -613,8 +616,7 @@ void mem_cgroup_flush_stats(struct mem_cgroup *memcg)
 	if (!memcg)
 		memcg = root_mem_cgroup;
 
-	if (memcg_vmstats_needs_flush(memcg->vmstats))
-		do_flush_stats(memcg);
+	__mem_cgroup_flush_stats(memcg, false);
 }
 
 void mem_cgroup_flush_stats_ratelimited(struct mem_cgroup *memcg)
@@ -630,7 +632,7 @@ static void flush_memcg_stats_dwork(struct work_struct *w)
 	 * Deliberately ignore memcg_vmstats_needs_flush() here so that flushing
 	 * in latency-sensitive paths is as cheap as possible.
 	 */
-	do_flush_stats(root_mem_cgroup);
+	__mem_cgroup_flush_stats(root_mem_cgroup, true);
 	queue_delayed_work(system_unbound_wq, &stats_flush_dwork, FLUSH_TIME);
 }
 
@@ -5281,11 +5283,8 @@ bool obj_cgroup_may_zswap(struct obj_cgroup *objcg)
 			break;
 		}
 
-		/*
-		 * mem_cgroup_flush_stats() ignores small changes. Use
-		 * do_flush_stats() directly to get accurate stats for charging.
-		 */
-		do_flush_stats(memcg);
+		/* Force flush to get accurate stats for charging */
+		__mem_cgroup_flush_stats(memcg, true);
 		pages = memcg_page_state(memcg, MEMCG_ZSWAP_B) / PAGE_SIZE;
 		if (pages < max)
 			continue;
-- 
2.47.0


