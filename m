Return-Path: <cgroups+bounces-12300-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 11ABCCAEA55
	for <lists+cgroups@lfdr.de>; Tue, 09 Dec 2025 02:41:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 240AC300E7BA
	for <lists+cgroups@lfdr.de>; Tue,  9 Dec 2025 01:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5332FF642;
	Tue,  9 Dec 2025 01:41:15 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560EC2FF151;
	Tue,  9 Dec 2025 01:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765244475; cv=none; b=oHaRoX0ycSgAyfS3HbnSVIMSgyrS0vWbi0Uoi6KbmY2CaTdkfqZ3GrIBivoijbVYJpAghYb6XTismYZOaRYiEzg9qJABEjENWkPJ19zuF8C3bPKIRkUy3M4VCxG2EM2p89u0xAB7gd/cl6E3fLJImLhdyqeTOI80YjCsSV0LnaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765244475; c=relaxed/simple;
	bh=oGyGsrhl+bT6RvC4sisJDQxidB4pVVdXpZbBrZRHauQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tXM4bRA3/tAM5PNUif/+Za6BcKzn/SBu5dcoh11H1b5qzSgDvSgfsgsk4PDiXf6sHYIOBVDtE/3kNB1tsEkKSGuQ72IvLWdrVn9q6mAtuospb+UQgYJ6IPVGGHpX0cvLykO6UMjRFkLwFlixJVKHHA+BnwzLHIPXmx8ZbMHHR+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dQM3x4nV0zKHMMf;
	Tue,  9 Dec 2025 09:40:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 7A2581A15CB;
	Tue,  9 Dec 2025 09:41:11 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP2 (Coremail) with SMTP id Syh0CgBnRlAafjdpkF9fBA--.23909S7;
	Tue, 09 Dec 2025 09:41:11 +0800 (CST)
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
	zhengqi.arch@bytedance.com
Cc: linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huaweicloud.com,
	zhongjinji@honor.com
Subject: [PATCH -next 5/5] mm/mglru: factor lrugen state out of shrink_lruvec
Date: Tue,  9 Dec 2025 01:25:57 +0000
Message-Id: <20251209012557.1949239-6-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251209012557.1949239-1-chenridong@huaweicloud.com>
References: <20251209012557.1949239-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBnRlAafjdpkF9fBA--.23909S7
X-Coremail-Antispam: 1UD129KBjvJXoW7tw1UurW8Aw1rCFy5XFWUurg_yoW8try5pa
	9xG3yUZa4FyFn0qr9xJF4DWa45ur4UtrWxJr9rWw18CF4Sqa4rK347Cr4Uury5Z3ykZr13
	Xry5Gr17Ww1jvFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

A previous patch updated shrink_node_memcgs to handle lrugen root reclaim
and extended shrink_one to support both lrugen and non-lrugen. However,
in shrink_one, lrugen non-root reclaim still invokes shrink_lruvec, which
should only be used for non-lrugen reclaim.

To clarify the semantics, this patch moves the lrugen-specific logic out of
shrink_lruvec, leaving shrink_lruvec exclusively for non-lrugen reclaim.

Now for lrugen, shrink_one invokes lru_gen_shrink_lruvec, which calls
try_to_shrink_lruvec directly, without extra handling for root reclaim, as
that processing is already done in lru_gen_shrink_node. Non-root reclaim
behavior remains unchanged.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 mm/vmscan.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index dbf2cfbe3243..c5f517ec52a7 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4762,7 +4762,12 @@ static void lru_gen_shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc
 {
 	struct blk_plug plug;
 
-	VM_WARN_ON_ONCE(root_reclaim(sc));
+	/* Root reclaim has finished other extra work outside, just shrink. */
+	if (root_reclaim(sc)) {
+		try_to_shrink_lruvec(lruvec, sc);
+		return;
+	}
+
 	VM_WARN_ON_ONCE(!sc->may_writepage || !sc->may_unmap);
 
 	lru_add_drain();
@@ -5524,11 +5529,6 @@ static void shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
 	bool proportional_reclaim;
 	struct blk_plug plug;
 
-	if (lru_gen_enabled() && !root_reclaim(sc)) {
-		lru_gen_shrink_lruvec(lruvec, sc);
-		return;
-	}
-
 	get_scan_count(lruvec, sc, nr);
 
 	/* Record the original scan target for proportional adjustments later */
@@ -5708,8 +5708,8 @@ static void shrink_one(struct lruvec *lruvec, struct scan_control *sc)
 	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
 	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
 
-	if (lru_gen_enabled() && root_reclaim(sc))
-		try_to_shrink_lruvec(lruvec, sc);
+	if (lru_gen_enabled())
+		lru_gen_shrink_lruvec(lruvec, sc);
 	else
 		shrink_lruvec(lruvec, sc);
 
-- 
2.34.1


