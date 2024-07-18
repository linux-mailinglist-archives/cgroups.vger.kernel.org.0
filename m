Return-Path: <cgroups+bounces-3769-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 257BC934A22
	for <lists+cgroups@lfdr.de>; Thu, 18 Jul 2024 10:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A76A1F24CAF
	for <lists+cgroups@lfdr.de>; Thu, 18 Jul 2024 08:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923587D3EF;
	Thu, 18 Jul 2024 08:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="f7uD2/F7"
X-Original-To: cgroups@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783933B784;
	Thu, 18 Jul 2024 08:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721292125; cv=none; b=UlKkxI+0JIzzllN8gwIErQto9Gr4FcN2NZZ58Y9DPOS89DvobUlQ8VH+GFXyud5HJ4rZ2SUYqX9u+wT5Wnje5YJX7NghyVpDjNHpNNu+zKWJzzPcKFP1R5JrHwPgHmi8V5AV85Mh7g07OuB7cIrr030fFMe6NyIjLvhEobx804w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721292125; c=relaxed/simple;
	bh=bZxPqhxRGdkOe6ZLtw3jKcUWDWSwAmYsYQ61dXx/HOM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n8PIYb4gV/t2p7F6PPCiu5NEaXDnGbSnNnjw/TFc5E3SVGQL4f++IjkfMMO/JycI3aVxEZLzzxeIOHb5VdBIeqr6S/1lYVf6Yuwi6Js0Y6jkpw+K7em2ZBqUWCTbo6Eb031M+zwNHL9W1QyusGTZmLWu36tfPlLVhyKwkKI3OEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=f7uD2/F7; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 954dd25644e111ef87684b57767b52b1-20240718
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=7cJPIYBOZKxw9By0YCCiUkOLCsHVgJUmv6aYpcZa7dk=;
	b=f7uD2/F7SkTFOfUYHRiR66c1Sk2Hi+FvaLxUyzevtOaezO80RN9BEmg9rJz0ekolP6FcjJKCmy60GT9YNMmNRLexmkAAKLL1IU6+2uEkN9hQuRq471+y4EiQKy4L4L7F6aKrVpqXMzhVQbP3pHW84cehEMVTCGJ5M5Da7rTWl4o=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.40,REQID:53f467ad-055b-4c6d-be37-d96deb48ce75,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:ba885a6,CLOUDID:6b877245-a117-4f46-a956-71ffeac67bfa,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 954dd25644e111ef87684b57767b52b1-20240718
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
	(envelope-from <boy.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 717439943; Thu, 18 Jul 2024 16:41:53 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 18 Jul 2024 16:41:53 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 18 Jul 2024 16:41:53 +0800
From: boy.wu <boy.wu@mediatek.com>
To: Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>, Jens Axboe
	<axboe@kernel.dk>
CC: Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Boris Burkov <boris@bur.io>,
	<cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <iverlin.wang@mediatek.com>, Boy Wu
	<boy.wu@mediatek.com>
Subject: [PATCH v4] blk-cgroup: Replace u64 sync with spinlock for iostat
Date: Thu, 18 Jul 2024 16:41:12 +0800
Message-ID: <20240718084112.12202-1-boy.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--7.618200-8.000000
X-TMASE-MatchedRID: YZKi2GGnn9+ZtBi01n3C9xafLXbshfogcx5k3wffojOHwGEm+CpYGTEG
	FjeZwyRUzbrWhbT2b8cTMOv2lZG8w2zFfXEzaNt8wCZxkTHxccn64i5lgawyBFSOymiJfTYXZmL
	HoWzm2fS1hH+43GdK0QG2ORx9EyapCCk23kSAVszovZduO2AF9zQAp53S718HVo+424uIBNJYTM
	99NlfBm1EXNKIgpuQj+9p3HcFJM3mVhIWL9FEuN54CIKY/Hg3AGdQnQSTrKGPEQdG7H66TyH4gK
	q42LRYkpO8ojRYm4lcl4rDZgwtgKw3kTcv9FMbtpUElRFcYt7l+3BndfXUhXQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--7.618200-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: F123CDD9A65F6182C8CF3180A6DA8AB398AC9F1B101EEA855735D2109E5C8CC32000:8
X-MTK: N

From: Boy Wu <boy.wu@mediatek.com>

In 32bit SMP systems, if multiple CPUs call blkcg_print_stat,
it may cause blkcg_fill_root_iostats to have a concurrent problem
on the seqlock in u64_stats_update, which will cause a deadlock
on u64_stats_fetch_begin in blkcg_print_one_stat.

Thus, replace u64 sync with spinlock to protect iostat.

Fixes: ef45fe470e1e ("blk-cgroup: show global disk stats in root cgroup io.stat")
Signed-off-by: Boy Wu <boy.wu@mediatek.com>
---
Change in v2:
 - update commit message
 - Remove u64_sync
 - Replace spin_lock_irq with guard statement
 - Replace blkg->q->queue_lock with blkg_stat_lock
Change in v3:
 - update commit message
 - Add spinlock in blkg_iostat_set structure
 - Replace all u64_sync with spinlock for iostat
 - Replace blkg_stat_lock with iostat.spinlock
Change in v4:
 - update commit message
 - Remove spinlock in blkg_iostat_set structure
 - Replace iostat.spinlock with blkg_stat_lock
 - Add 32-bit systems only define
---
 block/blk-cgroup.c | 34 +++++++++++++---------------------
 1 file changed, 13 insertions(+), 21 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 37e6cc91d576..faa604c6fab9 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -329,7 +329,6 @@ static struct blkcg_gq *blkg_alloc(struct blkcg *blkcg, struct gendisk *disk,
 	INIT_WORK(&blkg->async_bio_work, blkg_async_bio_workfn);
 #endif
 
-	u64_stats_init(&blkg->iostat.sync);
 	for_each_possible_cpu(cpu) {
 		u64_stats_init(&per_cpu_ptr(blkg->iostat_cpu, cpu)->sync);
 		per_cpu_ptr(blkg->iostat_cpu, cpu)->blkg = blkg;
@@ -632,18 +631,18 @@ static void blkg_iostat_set(struct blkg_iostat *dst, struct blkg_iostat *src)
 static void __blkg_clear_stat(struct blkg_iostat_set *bis)
 {
 	struct blkg_iostat cur = {0};
-	unsigned long flags;
 
-	flags = u64_stats_update_begin_irqsave(&bis->sync);
 	blkg_iostat_set(&bis->cur, &cur);
 	blkg_iostat_set(&bis->last, &cur);
-	u64_stats_update_end_irqrestore(&bis->sync, flags);
 }
 
 static void blkg_clear_stat(struct blkcg_gq *blkg)
 {
 	int cpu;
 
+#if BITS_PER_LONG == 32
+	guard(raw_spinlock_irqsave)(&blkg_stat_lock);
+#endif
 	for_each_possible_cpu(cpu) {
 		struct blkg_iostat_set *s = per_cpu_ptr(blkg->iostat_cpu, cpu);
 
@@ -995,15 +994,12 @@ static void blkcg_iostat_update(struct blkcg_gq *blkg, struct blkg_iostat *cur,
 				struct blkg_iostat *last)
 {
 	struct blkg_iostat delta;
-	unsigned long flags;
 
 	/* propagate percpu delta to global */
-	flags = u64_stats_update_begin_irqsave(&blkg->iostat.sync);
 	blkg_iostat_set(&delta, cur);
 	blkg_iostat_sub(&delta, last);
 	blkg_iostat_add(&blkg->iostat.cur, &delta);
 	blkg_iostat_add(last, &delta);
-	u64_stats_update_end_irqrestore(&blkg->iostat.sync, flags);
 }
 
 static void __blkcg_rstat_flush(struct blkcg *blkcg, int cpu)
@@ -1034,7 +1030,6 @@ static void __blkcg_rstat_flush(struct blkcg *blkcg, int cpu)
 		struct blkcg_gq *blkg = bisc->blkg;
 		struct blkcg_gq *parent = blkg->parent;
 		struct blkg_iostat cur;
-		unsigned int seq;
 
 		/*
 		 * Order assignment of `next_bisc` from `bisc->lnode.next` in
@@ -1051,10 +1046,7 @@ static void __blkcg_rstat_flush(struct blkcg *blkcg, int cpu)
 			goto propagate_up; /* propagate up to parent only */
 
 		/* fetch the current per-cpu values */
-		do {
-			seq = u64_stats_fetch_begin(&bisc->sync);
-			blkg_iostat_set(&cur, &bisc->cur);
-		} while (u64_stats_fetch_retry(&bisc->sync, seq));
+		blkg_iostat_set(&cur, &bisc->cur);
 
 		blkcg_iostat_update(blkg, &cur, &bisc->last);
 
@@ -1112,7 +1104,6 @@ static void blkcg_fill_root_iostats(void)
 		struct blkcg_gq *blkg = bdev->bd_disk->queue->root_blkg;
 		struct blkg_iostat tmp;
 		int cpu;
-		unsigned long flags;
 
 		memset(&tmp, 0, sizeof(tmp));
 		for_each_possible_cpu(cpu) {
@@ -1133,10 +1124,10 @@ static void blkcg_fill_root_iostats(void)
 			tmp.bytes[BLKG_IOSTAT_DISCARD] +=
 				cpu_dkstats->sectors[STAT_DISCARD] << 9;
 		}
-
-		flags = u64_stats_update_begin_irqsave(&blkg->iostat.sync);
+#if BITS_PER_LONG == 32
+		guard(raw_spinlock_irqsave)(&blkg_stat_lock);
+#endif
 		blkg_iostat_set(&blkg->iostat.cur, &tmp);
-		u64_stats_update_end_irqrestore(&blkg->iostat.sync, flags);
 	}
 }
 
@@ -1145,7 +1136,6 @@ static void blkcg_print_one_stat(struct blkcg_gq *blkg, struct seq_file *s)
 	struct blkg_iostat_set *bis = &blkg->iostat;
 	u64 rbytes, wbytes, rios, wios, dbytes, dios;
 	const char *dname;
-	unsigned seq;
 	int i;
 
 	if (!blkg->online)
@@ -1157,16 +1147,18 @@ static void blkcg_print_one_stat(struct blkcg_gq *blkg, struct seq_file *s)
 
 	seq_printf(s, "%s ", dname);
 
-	do {
-		seq = u64_stats_fetch_begin(&bis->sync);
-
+#if BITS_PER_LONG == 32
+	scoped_guard(raw_spinlock_irqsave, &blkg_stat_lock) {
+#endif
 		rbytes = bis->cur.bytes[BLKG_IOSTAT_READ];
 		wbytes = bis->cur.bytes[BLKG_IOSTAT_WRITE];
 		dbytes = bis->cur.bytes[BLKG_IOSTAT_DISCARD];
 		rios = bis->cur.ios[BLKG_IOSTAT_READ];
 		wios = bis->cur.ios[BLKG_IOSTAT_WRITE];
 		dios = bis->cur.ios[BLKG_IOSTAT_DISCARD];
-	} while (u64_stats_fetch_retry(&bis->sync, seq));
+#if BITS_PER_LONG == 32
+	}
+#endif
 
 	if (rbytes || wbytes || rios || wios) {
 		seq_printf(s, "rbytes=%llu wbytes=%llu rios=%llu wios=%llu dbytes=%llu dios=%llu",
-- 
2.18.0


