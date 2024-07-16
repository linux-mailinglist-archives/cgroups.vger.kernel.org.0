Return-Path: <cgroups+bounces-3695-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ECFC932176
	for <lists+cgroups@lfdr.de>; Tue, 16 Jul 2024 09:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E92522819F1
	for <lists+cgroups@lfdr.de>; Tue, 16 Jul 2024 07:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5393CF5E;
	Tue, 16 Jul 2024 07:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="No0vRYJZ"
X-Original-To: cgroups@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742CE58210;
	Tue, 16 Jul 2024 07:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721116045; cv=none; b=Y2plIQo5r3IDrt1fC86Z021vT+fJazdkJS4mrrOI1WED3WCQZyhUlX/DJ+WUumxk4Cxxd0GQlULhYMHXGe0t9BnqFeF/+oTHs0qj9ntRa2srbJklTzKgCJBXkQYEZJhTJDXidTrwU3Vxh2Vx15J7T1e1VVQdP9cOTCt42Fxr+b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721116045; c=relaxed/simple;
	bh=5uc7rrG9KrjMyPTpkNMDYR1ta11ZOmQf1e7qWomrJNg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hNqvsF+y6UPkRmk1sWU2gUySY+Y0a8WzTl7aY3971nSj4gQ8gYK+sjMqDukdxRDOfxQ8Yq9hjy1WWWSxdNd7rNVFK7oIGHDhw8pxkCh3sUVeUV0JfEuiW0Nd+14iVEuY73L08WRFMl5vHXSeWozeuqDHLlC5IsNbj12tolPNXU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=No0vRYJZ; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 99663cac434711efb5b96b43b535fdb4-20240716
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=LKn59Eo61gPgXwLDdueCeuGeu9W7m6IyUvCxQVSnSK8=;
	b=No0vRYJZ6fiKCoCDrc3Yr2oYco+UgTo2zEbdb2uXliyJ1CPe0crGhvr81TM4Q/vSWhoYG3lC9wgiLV4s7+6UZ2jMTXXWyesD6mN2whmP80IdoAJ9etsx9DCsheW8YU0cMzR/4kg2s6npL7Cj6o/G6RsPObkQz8BHHOqXLDNAl0M=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.40,REQID:4ec84318-5d4f-4a0d-a58a-640a0719a037,IP:0,U
	RL:0,TC:0,Content:-25,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-META: VersionHash:ba885a6,CLOUDID:692c830d-46b0-425a-97d3-4623fe284021,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:5,IP:nil,UR
	L:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:
	1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 99663cac434711efb5b96b43b535fdb4-20240716
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <boy.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 602789564; Tue, 16 Jul 2024 15:47:06 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 16 Jul 2024 15:47:02 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 16 Jul 2024 15:47:02 +0800
From: boy.wu <boy.wu@mediatek.com>
To: Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>, Jens Axboe
	<axboe@kernel.dk>
CC: Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Boris Burkov <boris@bur.io>,
	<cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <iverlin.wang@mediatek.com>, Boy Wu
	<boy.wu@mediatek.com>
Subject: [PATCH] blk-cgroup: Replace u64 sync with spinlock for iostat update
Date: Tue, 16 Jul 2024 15:46:53 +0800
Message-ID: <20240716074653.22524-1-boy.wu@mediatek.com>
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
	E00DA929F0B966481D5D967B554312843F43A8CF74639FB456D70D4308E86AB62000:8
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


