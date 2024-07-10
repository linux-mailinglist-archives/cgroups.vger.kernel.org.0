Return-Path: <cgroups+bounces-3592-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D4E92CAA1
	for <lists+cgroups@lfdr.de>; Wed, 10 Jul 2024 08:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 847DC1C22B6E
	for <lists+cgroups@lfdr.de>; Wed, 10 Jul 2024 06:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0DE57CBA;
	Wed, 10 Jul 2024 06:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="uwSiQuKz"
X-Original-To: cgroups@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1AD770E6;
	Wed, 10 Jul 2024 06:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720592026; cv=none; b=YNTTlHZPZndF35KQV8XVkrcEGtsP+rRqIPF5t7kyELJVvQ2fDvrDAQutDYdOA5biXT7V8JWXEmjoNy23mPrGOIY5FHsdV6f/zuj/2HDRjMKiowbp6hRSzjLpherG5MMIn0C2WEebdRlXlBgTG+zW1WqNKVPzEqswrxH5uy2vK4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720592026; c=relaxed/simple;
	bh=SHbGtm4D0/iCitNfCWYTkWOmmCOtMKwROWXrGH5JhSE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=u88TV23g/GihR58KpIhr2xDC/2oQwOZr5cfYiEZZUO1GrEGw6kFq/0utkicSVh3tgNLZBQ/EiP9sbERPeKOQN753uNTZwXZ4WBruELpMxTFcNTn2QtNskiLJrXoAeB6b6O1gCXsfZ6QM+w6mLF3DXbmUwVzxHb7KjBxq88VCn1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=uwSiQuKz; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 8b6d3ee83e8311efb5b96b43b535fdb4-20240710
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=d95Fo6b+G68P3kj0InKe88LIEg8qwPI54rMQxA2Bxok=;
	b=uwSiQuKzKKvip5XYmGbNlBFO1yvk3YW4x3ca1a1uu2voFf31r17fou63yWYqLWMnsohWZanjztaoPW/EAjP6c0pLTonXrwMBpBZNNoy1H6R0VEQnkb8PSB+IrcjL8nFturTG3k97ke+rYjaPYkHmigWq4qUaHPzZwNqPtAAO5Nw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.40,REQID:04f5a53c-2f11-4d4c-adae-69db6a0018c7,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:ba885a6,CLOUDID:66bc2ad5-0d68-4615-a20f-01d7bd41f0bb,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 8b6d3ee83e8311efb5b96b43b535fdb4-20240710
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <boy.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 69503522; Wed, 10 Jul 2024 14:13:37 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 10 Jul 2024 14:13:36 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 10 Jul 2024 14:13:36 +0800
From: boy.wu <boy.wu@mediatek.com>
To: Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>, Jens Axboe
	<axboe@kernel.dk>
CC: Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Boris Burkov <boris@bur.io>,
	<cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <iverlin.wang@mediatek.com>, Boy Wu
	<boy.wu@mediatek.com>
Subject: [PATCH v2] blk-cgroup: Replace u64_sync with blkg_stat_lock for stats update
Date: Wed, 10 Jul 2024 14:13:34 +0800
Message-ID: <20240710061334.1888-1-boy.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--5.944900-8.000000
X-TMASE-MatchedRID: qLbn38WZ3sSZtBi01n3C9xafLXbshfogcx5k3wffojOHwGEm+CpYGTEG
	FjeZwyRUzogSaVJZzAL+luKvsi8YwoAemPpsxJ+FwCZxkTHxccn64i5lgawyBFSOymiJfTYXpR4
	7IzBwt4ZOFu8ssjxG84NY9+fuummTlzyv7BXwQ5GeAiCmPx4NwBnUJ0Ek6yhjxEHRux+uk8jHUU
	+U0ACZwMVeAuLeAGwuBp7q3lDk3HqIXtzfrt5hBCumh16iMSocnqg/VrSZEiM=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--5.944900-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	6E5764C31209FE9AC971FCE68D722875165DEF69209A65E7F099ADB9A84DB4E32000:8
X-MTK: N

From: Boy Wu <boy.wu@mediatek.com>

In 32bit SMP systems, if multiple CPUs call blkcg_print_stat,
which may cause blkcg_fill_root_iostats to have a concurrent problem
on the seqlock in u64_stats_update, which will cause a deadlock
on u64_stats_fetch_begin in blkcg_print_one_stat.

Thus use blkg_stat_lock to replace u64_sync.

Fixes: ef45fe470e1e ("blk-cgroup: show global disk stats in root cgroup io.stat")
Signed-off-by: Boy Wu <boy.wu@mediatek.com>
---
Change in v2:
 - update commit message
 - Remove u64_sync
 - Replace spin_lock_irq with guard statement
 - Replace blkg->q->queue_lock with blkg_stat_lock
---
 block/blk-cgroup.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 85b3b9051455..18b47ee1a640 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -952,7 +952,6 @@ static void blkcg_fill_root_iostats(void)
 		struct blkcg_gq *blkg = bdev->bd_disk->queue->root_blkg;
 		struct blkg_iostat tmp;
 		int cpu;
-		unsigned long flags;
 
 		memset(&tmp, 0, sizeof(tmp));
 		for_each_possible_cpu(cpu) {
@@ -974,9 +973,10 @@ static void blkcg_fill_root_iostats(void)
 				cpu_dkstats->sectors[STAT_DISCARD] << 9;
 		}
 
-		flags = u64_stats_update_begin_irqsave(&blkg->iostat.sync);
+#if BITS_PER_LONG == 32
+		guard(raw_spinlock_irqsave)(&blkg_stat_lock);
+#endif
 		blkg_iostat_set(&blkg->iostat.cur, &tmp);
-		u64_stats_update_end_irqrestore(&blkg->iostat.sync, flags);
 	}
 }
 
-- 
2.18.0


