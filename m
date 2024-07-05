Return-Path: <cgroups+bounces-3548-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95AB5928342
	for <lists+cgroups@lfdr.de>; Fri,  5 Jul 2024 09:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5139A28817F
	for <lists+cgroups@lfdr.de>; Fri,  5 Jul 2024 07:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E89B144D23;
	Fri,  5 Jul 2024 07:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="PZCxoNrg"
X-Original-To: cgroups@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D67933C7;
	Fri,  5 Jul 2024 07:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720166170; cv=none; b=nYKwmo5/XVuU6F+KNe4wrJOSiNlLxoDkzLqiSSNDpIYRim6kCJ0TnaSuWbTD/TQcmtVe64ToT2vA53PHORIt/i8Q7pA3VmSwhzWFS+YVMziKSaUeiaxoVrCqXBF8n5nmTG5OprNCs9OjK7at3eoUiMtzXNX7Ygwbh1XojktWQLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720166170; c=relaxed/simple;
	bh=P93m1oYYdGYsw4jp2zJ54KKFIj+wILBPMAUNZzIeFNM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HJtVca7yMXE9p1ZuFJGXdrHdqfYTTG9zacfto8rNKyy7IjsQCssMpqPkUffgcv7poOEVXzO5xfUSQHBCdutKL5hZKvqEb9iuZvrjkk+4Xj9kZBagfzrFMNGTqNn7rvCquDsKOyEG1lXJHzxko31Ih4nNyj0eGa0sX0MS/JS65U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=PZCxoNrg; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 001cd07a3aa411ef99dc3f8fac2c3230-20240705
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=e2ch6CN6/2ILQFX9s+8Go6wgcVOVLzjEhdIrftGsDFs=;
	b=PZCxoNrgopqO0OEo+W6tMrAnRZ+AuqpbidZmuFsKTnMg/5EKUjDPW6oP59+3EIE0Lz9A3oXgCAcZIwJJfT50ZEsjko3q/E230dh6/SzMlQzWHeGWGgxoLfrqTB276eyWg1Y/+w3fvIpDVHtkZ/AvvY3M6t3fqBT5p0Kv+FkYj54=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.40,REQID:bbd7d2e5-1417-431b-9189-aa162cac2592,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:ba885a6,CLOUDID:f782f144-a117-4f46-a956-71ffeac67bfa,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 001cd07a3aa411ef99dc3f8fac2c3230-20240705
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <boy.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1486524761; Fri, 05 Jul 2024 15:55:52 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 5 Jul 2024 15:55:51 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 5 Jul 2024 15:55:51 +0800
From: boy.wu <boy.wu@mediatek.com>
To: Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>, Jens Axboe
	<axboe@kernel.dk>
CC: Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Boris Burkov <boris@bur.io>,
	<cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <iverlin.wang@mediatek.com>, Boy Wu
	<boy.wu@mediatek.com>
Subject: [PATCH] blk-cgroup: add spin_lock for u64_stats_update
Date: Fri, 5 Jul 2024 15:55:44 +0800
Message-ID: <20240705075544.11315-1-boy.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

From: Boy Wu <boy.wu@mediatek.com>

In 32bit SMP systems, if the system is stressed on the sys node
by processes, it may cause blkcg_fill_root_iostats to have a concurrent
problem on the seqlock in u64_stats_update, which will cause a deadlock 
on u64_stats_fetch_begin in blkcg_print_one_stat.

To prevent this problem, add spin_locks.

Fixes: ef45fe470e1e ("blk-cgroup: show global disk stats in root cgroup io.stat")
Signed-off-by: Boy Wu <boy.wu@mediatek.com>
---
 block/blk-cgroup.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 37e6cc91d576..a633b7431e91 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1134,9 +1134,15 @@ static void blkcg_fill_root_iostats(void)
 				cpu_dkstats->sectors[STAT_DISCARD] << 9;
 		}
 
+#if BITS_PER_LONG == 32
+		spin_lock_irq(&blkg->q->queue_lock);
+#endif
 		flags = u64_stats_update_begin_irqsave(&blkg->iostat.sync);
 		blkg_iostat_set(&blkg->iostat.cur, &tmp);
 		u64_stats_update_end_irqrestore(&blkg->iostat.sync, flags);
+#if BITS_PER_LONG == 32
+		spin_unlock_irq(&blkg->q->queue_lock);
+#endif
 	}
 }
 
-- 
2.18.0


