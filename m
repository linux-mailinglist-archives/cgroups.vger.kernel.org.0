Return-Path: <cgroups+bounces-12642-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D0DDCCDB9DC
	for <lists+cgroups@lfdr.de>; Wed, 24 Dec 2025 08:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB6EE30343E9
	for <lists+cgroups@lfdr.de>; Wed, 24 Dec 2025 07:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8949E32D45E;
	Wed, 24 Dec 2025 07:45:39 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D95C27467E;
	Wed, 24 Dec 2025 07:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766562339; cv=none; b=fpb8vCA29zqFLKvvYsp5lEYK04nhR+UR6h1QXeI8eBbXSw4hhEYo+eF8GN5rRSSpCAUkiwDC3MUxDXuB29Y6IGFGnuyK4/Gc1E23q8sqkN3ok3Tyx2Q/QtkGb6ubNA9+sRhPvRYCKVxgm3u2Tq1zrXscGvi5eGAK/F2FEfYhJRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766562339; c=relaxed/simple;
	bh=DbpShU26qQ4O1m4yA0hD4vJiMDWCn3kQpM9khGcqbAg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ju+gfL4z3y+r6qHvnsQOrpAbUfgAZjZOk0xkfc0YK3GXlu11OQ/JmUz0xgL/P+VA+kwiYpYVcTcz97BeKpf7Uoph8e8naUb4ARVBPLR2moxbOMMfZMtFUDWhUtpxhwYRh5cRo1+5NwWQ4OtFTrcdIAZEHMTsJQDsWDETlfdPlx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dbkSD055HzKHMP3;
	Wed, 24 Dec 2025 15:45:16 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 7CAE140572;
	Wed, 24 Dec 2025 15:45:35 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP4 (Coremail) with SMTP id gCh0CgA3l_cMmktp9pcvBQ--.63051S9;
	Wed, 24 Dec 2025 15:45:35 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: akpm@linux-foundation.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	david@kernel.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	corbet@lwn.net,
	hannes@cmpxchg.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	zhengqi.arch@bytedance.com,
	mkoutny@suse.com
Cc: linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huaweicloud.com
Subject: [PATCH -next v2 7/7] mm/mglru: remove memcg disable handling from lru_gen_shrink_node
Date: Wed, 24 Dec 2025 07:30:32 +0000
Message-Id: <20251224073032.161911-8-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251224073032.161911-1-chenridong@huaweicloud.com>
References: <20251224073032.161911-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgA3l_cMmktp9pcvBQ--.63051S9
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar4ruFW5Zr4UXr45JFW5KFg_yoW8Ww1rpF
	ZxG3y2y3yrJ3Z0g3WSvFsrua43C3yxKr18JrWUJw1fCr1SqFyrKFyUCry8Wry5ArykZr13
	Zr9Ivw1UW3y0qF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmS14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
	4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBI
	daVFxhVjvjDU0xZFpf9x0pRQJ5wUUUUU=
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

Since shrink_node_memcgs already handles the memcg disabled case,
this special-case logic in lru_gen_shrink_node is unnecessary.
Remove it.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 mm/vmscan.c | 23 +----------------------
 1 file changed, 1 insertion(+), 22 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 1d13ce7338b4..5ea98bb94156 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4759,24 +4759,6 @@ static bool try_to_shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
 	return nr_to_scan < 0;
 }
 
-static void shrink_one(struct lruvec *lruvec, struct scan_control *sc)
-{
-	unsigned long scanned = sc->nr_scanned;
-	unsigned long reclaimed = sc->nr_reclaimed;
-	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
-	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
-
-	try_to_shrink_lruvec(lruvec, sc);
-
-	shrink_slab(sc->gfp_mask, pgdat->node_id, memcg, sc->priority);
-
-	if (!sc->proactive)
-		vmpressure(sc->gfp_mask, memcg, false, sc->nr_scanned - scanned,
-			   sc->nr_reclaimed - reclaimed);
-
-	flush_reclaim_state(sc);
-}
-
 static void lru_gen_shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
 {
 	struct blk_plug plug;
@@ -4832,10 +4814,7 @@ static void lru_gen_shrink_node(struct pglist_data *pgdat, struct scan_control *
 	if (current_is_kswapd())
 		sc->nr_reclaimed = 0;
 
-	if (mem_cgroup_disabled())
-		shrink_one(&pgdat->__lruvec, sc);
-	else
-		shrink_node_memcgs(pgdat, sc);
+	shrink_node_memcgs(pgdat, sc);
 
 	if (current_is_kswapd())
 		sc->nr_reclaimed += reclaimed;
-- 
2.34.1


