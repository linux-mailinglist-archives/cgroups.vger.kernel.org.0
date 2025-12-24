Return-Path: <cgroups+bounces-12640-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B845CCDB9B8
	for <lists+cgroups@lfdr.de>; Wed, 24 Dec 2025 08:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B5773014AE1
	for <lists+cgroups@lfdr.de>; Wed, 24 Dec 2025 07:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C39D2E2299;
	Wed, 24 Dec 2025 07:45:39 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7E3241663;
	Wed, 24 Dec 2025 07:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766562339; cv=none; b=rkBDcMYPopMDWKuUXc6EsBFELTYiBb8grru48155AWEg2zFeGaTmaC+f8Qz6f4nimbi288goo5mFKEibiL60VOKZSrOd2MAHhiQZ7JjxU0Vr/YgIP3Yc+pA3T9pNDsHT6t8IhSoACsuSJYYaxFtaW2QiZ7MlLRUB4LLgGGHqrCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766562339; c=relaxed/simple;
	bh=af/sk98zsUM4g+eqRJUDh8CH/q9VRnBLA99zr4H3VD0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PIwZXRekth0A7XvcMieMKj4Ey5YiMvtXNcQk4Z4tpxOToLrXgukC9a1Pa4GbiQ+KJ7na8hWkBmzJtqjJFvd2VLIzE0ooEmQkz1KR3rlAbg7sFE7ndjrftXV7MxVzgnx3jGwwMNe5KWtwOqeWsSW3xrJs6EGth1m9dlPOgLvy7cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dbkRr6RSkzYQtpR;
	Wed, 24 Dec 2025 15:44:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 34B4C40576;
	Wed, 24 Dec 2025 15:45:35 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP4 (Coremail) with SMTP id gCh0CgA3l_cMmktp9pcvBQ--.63051S7;
	Wed, 24 Dec 2025 15:45:34 +0800 (CST)
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
Subject: [PATCH -next v2 5/7] mm/mglru: extend lru_gen_shrink_lruvec to support root reclaim
Date: Wed, 24 Dec 2025 07:30:30 +0000
Message-Id: <20251224073032.161911-6-chenridong@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgA3l_cMmktp9pcvBQ--.63051S7
X-Coremail-Antispam: 1UD129KBjvJXoWrKF4xKF1rJrWUWFWrWw4kJFb_yoW8Jr1rpa
	9xG3yUZa4rAr4ag3Z3Xa1kWa4ruw48JF1xJrZrXry8AF4fXFy5K3y2kr4UCrW5Aw4kXrya
	qryYgryUW3WUZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

The upcoming patch will integrate shrink_many and shrink_node_memcgs.
Currently, lru_gen_shrink_lruvec only supports non-root reclaim invoked
from shrink_node_memcgs. This patch extends it to also handle root reclaim.

Since the initial setup for root reclaim is already completed in
lru_gen_shrink_node, we can simply call try_to_shrink_lruvec within
lru_gen_shrink_lruvec for root reclaim.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 mm/vmscan.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index e55c7835cab5..3a266f6456af 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4820,7 +4820,15 @@ static void lru_gen_shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc
 {
 	struct blk_plug plug;
 
-	VM_WARN_ON_ONCE(root_reclaim(sc));
+	/*
+	 * For root reclaim, the initial setup has already been completed externally;
+	 * proceed directly with the shrinking operation.
+	 */
+	if (root_reclaim(sc)) {
+		try_to_shrink_lruvec(lruvec, sc);
+		return;
+	}
+
 	VM_WARN_ON_ONCE(!sc->may_writepage || !sc->may_unmap);
 
 	lru_add_drain();
-- 
2.34.1


