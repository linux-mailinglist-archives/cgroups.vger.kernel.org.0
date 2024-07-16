Return-Path: <cgroups+bounces-3696-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3781932180
	for <lists+cgroups@lfdr.de>; Tue, 16 Jul 2024 09:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A324B21801
	for <lists+cgroups@lfdr.de>; Tue, 16 Jul 2024 07:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7766D3BB32;
	Tue, 16 Jul 2024 07:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="hnYVYX+7"
X-Original-To: cgroups@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517A64C74;
	Tue, 16 Jul 2024 07:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721116372; cv=none; b=ttnzVf+tt2bE8oaNBQeWGVc98vMVCQvBQrhyHDr8v6vIONhPhbb13B5CWS+d8ilqA2k2SjfOJrueame6G6YSo1v8b/1tTCXlCc4zEwuS3j8B5Y0pVIoH2TeCRWMxUNuBhN+wceWyH6woZQe1ndlNboyeQ27FtoZC9u+4t5lDpGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721116372; c=relaxed/simple;
	bh=5uc7rrG9KrjMyPTpkNMDYR1ta11ZOmQf1e7qWomrJNg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LqbFcXaWi185y8g3NkgYWB01Vs3Ui8uR/h62cto8+cyH65oEbRtPtVuQwAd+51RmrCkeivOBu5IP7zbuul+EDMZ//92JTR3CuBtOqBYWBj7ob5ptC8pMCU6iKw5W38l1cSKvF4gwDNrsdl6heSJPd4t20NoNpY2rPpRjpKbJFiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=hnYVYX+7; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 6067477e434811efb5b96b43b535fdb4-20240716
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=LKn59Eo61gPgXwLDdueCeuGeu9W7m6IyUvCxQVSnSK8=;
	b=hnYVYX+7p9MVV3BhZXLLs4/LQEanl4cv9/V4/kLJdaOpXZuIgk/2VWNXiL2g2dy1T85TANUZ9rSP+Oajlof3BGcT0uoVJOhmSgF1xm2EtCVwhG7XpPTiFM9fWjwhrQa5PL4eebcOaaUg6X2M40QsCV72neROypEw+m3AaxJxXPc=;
X-CID-CACHE: Type:Local,Time:202407161547+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.40,REQID:8bdfee71-8f8b-4de4-bb00-85dada6e92da,IP:0,U
	RL:0,TC:0,Content:-25,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-META: VersionHash:ba885a6,CLOUDID:692c830d-46b0-425a-97d3-4623fe284021,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:5,IP:nil,UR
	L:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:
	1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 6067477e434811efb5b96b43b535fdb4-20240716
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <boy.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1902591506; Tue, 16 Jul 2024 15:52:40 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 16 Jul 2024 15:52:39 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 16 Jul 2024 15:52:39 +0800
From: boy.wu <boy.wu@mediatek.com>
To: Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>, Jens Axboe
	<axboe@kernel.dk>
CC: Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Boris Burkov <boris@bur.io>,
	<cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <iverlin.wang@mediatek.com>, Boy Wu
	<boy.wu@mediatek.com>
Subject: [PATCH v3] blk-cgroup: Replace u64 sync with spinlock for iostat update
Date: Tue, 16 Jul 2024 15:52:06 +0800
Message-ID: <20240716075206.23121-1-boy.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--11.866300-8.000000
X-TMASE-MatchedRID: aeJu7N9qZHyZtBi01n3C9xafLXbshfogcx5k3wffojOHwGEm+CpYGTEG
	FjeZwyRUzbrWhbT2b8cTMOv2lZG8w2zFfXEzaNt8wCZxkTHxccn64i5lgawyBFSOymiJfTYXZmL
	HoWzm2fSMZBHIGOaSwOKOmN63egZIkKjL2IOi2LBbuDP8ZuCmXgApx/9nOtgkVo+424uIBNJYTM
	99NlfBm1EXNKIgpuQj+9p3HcFJM3mVhIWL9FEuNwwfhKwa9GwDgGa+oYp5i6qgWMz+iaWIIaPFj
	JEFr+olwXCBO/GKkVqOhzOa6g8KrUiBZ6mmQX3xiIMgDE0zxa/IQ+RZPevUbELozoV1kXEbSPck
	h7/tXqI=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--11.866300-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	9AF1EA2C7774CC56D1B87B197E4E94559A0CE677E0D6E0E611350B3A934B048A2000:8
X-MTK: N

From: Boy Wu <boy.wu@mediatek.com>

In 32bit SMP systems, if multiple CPUs call blkcg_print_stat,
it may cause blkcg_fill_root_iostats to have a concurrent problem
on the seqlock in u64_stats_update, which will cause a deadlock
on u64_stats_fetch_begin in blkcg_print_one_stat.

Thus, replace u64 sync with spinlock to protect iostat update.

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
---
 block/blk-cgroup.c | 62 +++++++++++++++++++---------------------------
 block/blk-cgroup.h |  1 +
 2 files changed, 26 insertions(+), 37 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 37e6cc91d576..4b66f37c45a0 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -329,7 +329,7 @@ static struct blkcg_gq *blkg_alloc(struct blkcg *blkcg, struct gendisk *disk,
 	INIT_WORK(&blkg->async_bio_work, blkg_async_bio_workfn);
 #endif
 
-	u64_stats_init(&blkg->iostat.sync);
+	spin_lock_init(&blkg->iostat.spinlock);
 	for_each_possible_cpu(cpu) {
 		u64_stats_init(&per_cpu_ptr(blkg->iostat_cpu, cpu)->sync);
 		per_cpu_ptr(blkg->iostat_cpu, cpu)->blkg = blkg;
@@ -995,15 +995,13 @@ static void blkcg_iostat_update(struct blkcg_gq *blkg, struct blkg_iostat *cur,
 				struct blkg_iostat *last)
 {
 	struct blkg_iostat delta;
-	unsigned long flags;
 
 	/* propagate percpu delta to global */
-	flags = u64_stats_update_begin_irqsave(&blkg->iostat.sync);
+	guard(spinlock_irqsave)(&blkg->iostat.spinlock);
 	blkg_iostat_set(&delta, cur);
 	blkg_iostat_sub(&delta, last);
 	blkg_iostat_add(&blkg->iostat.cur, &delta);
 	blkg_iostat_add(last, &delta);
-	u64_stats_update_end_irqrestore(&blkg->iostat.sync, flags);
 }
 
 static void __blkcg_rstat_flush(struct blkcg *blkcg, int cpu)
@@ -1034,7 +1032,6 @@ static void __blkcg_rstat_flush(struct blkcg *blkcg, int cpu)
 		struct blkcg_gq *blkg = bisc->blkg;
 		struct blkcg_gq *parent = blkg->parent;
 		struct blkg_iostat cur;
-		unsigned int seq;
 
 		/*
 		 * Order assignment of `next_bisc` from `bisc->lnode.next` in
@@ -1051,10 +1048,8 @@ static void __blkcg_rstat_flush(struct blkcg *blkcg, int cpu)
 			goto propagate_up; /* propagate up to parent only */
 
 		/* fetch the current per-cpu values */
-		do {
-			seq = u64_stats_fetch_begin(&bisc->sync);
+		scoped_guard(spinlock_irqsave, &bisc->spinlock)
 			blkg_iostat_set(&cur, &bisc->cur);
-		} while (u64_stats_fetch_retry(&bisc->sync, seq));
 
 		blkcg_iostat_update(blkg, &cur, &bisc->last);
 
@@ -1112,7 +1107,6 @@ static void blkcg_fill_root_iostats(void)
 		struct blkcg_gq *blkg = bdev->bd_disk->queue->root_blkg;
 		struct blkg_iostat tmp;
 		int cpu;
-		unsigned long flags;
 
 		memset(&tmp, 0, sizeof(tmp));
 		for_each_possible_cpu(cpu) {
@@ -1134,9 +1128,8 @@ static void blkcg_fill_root_iostats(void)
 				cpu_dkstats->sectors[STAT_DISCARD] << 9;
 		}
 
-		flags = u64_stats_update_begin_irqsave(&blkg->iostat.sync);
+		guard(spinlock_irqsave)(&blkg->iostat.spinlock);
 		blkg_iostat_set(&blkg->iostat.cur, &tmp);
-		u64_stats_update_end_irqrestore(&blkg->iostat.sync, flags);
 	}
 }
 
@@ -1145,7 +1138,6 @@ static void blkcg_print_one_stat(struct blkcg_gq *blkg, struct seq_file *s)
 	struct blkg_iostat_set *bis = &blkg->iostat;
 	u64 rbytes, wbytes, rios, wios, dbytes, dios;
 	const char *dname;
-	unsigned seq;
 	int i;
 
 	if (!blkg->online)
@@ -1157,16 +1149,14 @@ static void blkcg_print_one_stat(struct blkcg_gq *blkg, struct seq_file *s)
 
 	seq_printf(s, "%s ", dname);
 
-	do {
-		seq = u64_stats_fetch_begin(&bis->sync);
-
+	scoped_guard(spinlock_irqsave, &bis->spinlock) {
 		rbytes = bis->cur.bytes[BLKG_IOSTAT_READ];
 		wbytes = bis->cur.bytes[BLKG_IOSTAT_WRITE];
 		dbytes = bis->cur.bytes[BLKG_IOSTAT_DISCARD];
 		rios = bis->cur.ios[BLKG_IOSTAT_READ];
 		wios = bis->cur.ios[BLKG_IOSTAT_WRITE];
 		dios = bis->cur.ios[BLKG_IOSTAT_DISCARD];
-	} while (u64_stats_fetch_retry(&bis->sync, seq));
+	}
 
 	if (rbytes || wbytes || rios || wios) {
 		seq_printf(s, "rbytes=%llu wbytes=%llu rios=%llu wios=%llu dbytes=%llu dios=%llu",
@@ -2141,7 +2131,6 @@ void blk_cgroup_bio_start(struct bio *bio)
 	struct blkcg *blkcg = bio->bi_blkg->blkcg;
 	int rwd = blk_cgroup_io_type(bio), cpu;
 	struct blkg_iostat_set *bis;
-	unsigned long flags;
 
 	if (!cgroup_subsys_on_dfl(io_cgrp_subsys))
 		return;
@@ -2152,30 +2141,29 @@ void blk_cgroup_bio_start(struct bio *bio)
 
 	cpu = get_cpu();
 	bis = per_cpu_ptr(bio->bi_blkg->iostat_cpu, cpu);
-	flags = u64_stats_update_begin_irqsave(&bis->sync);
-
-	/*
-	 * If the bio is flagged with BIO_CGROUP_ACCT it means this is a split
-	 * bio and we would have already accounted for the size of the bio.
-	 */
-	if (!bio_flagged(bio, BIO_CGROUP_ACCT)) {
-		bio_set_flag(bio, BIO_CGROUP_ACCT);
-		bis->cur.bytes[rwd] += bio->bi_iter.bi_size;
-	}
-	bis->cur.ios[rwd]++;
+	scoped_guard(spinlock_irqsave, &bis->spinlock) {
+		/*
+		 * If the bio is flagged with BIO_CGROUP_ACCT it means this is a split
+		 * bio and we would have already accounted for the size of the bio.
+		 */
+		if (!bio_flagged(bio, BIO_CGROUP_ACCT)) {
+			bio_set_flag(bio, BIO_CGROUP_ACCT);
+			bis->cur.bytes[rwd] += bio->bi_iter.bi_size;
+		}
+		bis->cur.ios[rwd]++;
 
-	/*
-	 * If the iostat_cpu isn't in a lockless list, put it into the
-	 * list to indicate that a stat update is pending.
-	 */
-	if (!READ_ONCE(bis->lqueued)) {
-		struct llist_head *lhead = this_cpu_ptr(blkcg->lhead);
+		/*
+		 * If the iostat_cpu isn't in a lockless list, put it into the
+		 * list to indicate that a stat update is pending.
+		 */
+		if (!READ_ONCE(bis->lqueued)) {
+			struct llist_head *lhead = this_cpu_ptr(blkcg->lhead);
 
-		llist_add(&bis->lnode, lhead);
-		WRITE_ONCE(bis->lqueued, true);
+			llist_add(&bis->lnode, lhead);
+			WRITE_ONCE(bis->lqueued, true);
+		}
 	}
 
-	u64_stats_update_end_irqrestore(&bis->sync, flags);
 	cgroup_rstat_updated(blkcg->css.cgroup, cpu);
 	put_cpu();
 }
diff --git a/block/blk-cgroup.h b/block/blk-cgroup.h
index bd472a30bc61..b9544969a131 100644
--- a/block/blk-cgroup.h
+++ b/block/blk-cgroup.h
@@ -44,6 +44,7 @@ struct blkg_iostat {
 };
 
 struct blkg_iostat_set {
+	spinlock_t			spinlock;
 	struct u64_stats_sync		sync;
 	struct blkcg_gq		       *blkg;
 	struct llist_node		lnode;
-- 
2.18.0


