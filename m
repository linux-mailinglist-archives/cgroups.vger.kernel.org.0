Return-Path: <cgroups+bounces-12646-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 686C5CDB9CB
	for <lists+cgroups@lfdr.de>; Wed, 24 Dec 2025 08:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 51D303026972
	for <lists+cgroups@lfdr.de>; Wed, 24 Dec 2025 07:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8307932ED51;
	Wed, 24 Dec 2025 07:45:40 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D88024A069;
	Wed, 24 Dec 2025 07:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766562340; cv=none; b=H+duPrMqv/6m8sYY8SVrPwysKsDnuJQNBFL8s/SpjalLOxNO/XtA4de/ict1N8cc/2R2iPUHdEa1Tai8edKdXSkiN4sh0QR3w9cSXUGOFuUXaO+fFHIJ/ix0bYI0ddXajGzItxA8VxSF3yPyjHRBPzkc+p5F9/B1+hLN9/C7bqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766562340; c=relaxed/simple;
	bh=hXZki+NDZJUnHUEgYtBgc5W01Qu4wSxdc+lohDXPMQU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pkfKNIpjtunZX0BS5QDSLVTxnhvstcVRr1Y1SY9fn5D4pDcirgglwysuxJ+FwqBt/j/QmJC1uTFpVaebKe6tE3mXZv/i2jmMMDERLSrluU1bIoRqWAAXbc+7i/YeYAUMTzW4ZODCmOfGN0U3Fn0G4CxgswI1RLKtwyNDIH6aMfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dbkSC4PQ9zKHMNd;
	Wed, 24 Dec 2025 15:45:15 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 1D7A740577;
	Wed, 24 Dec 2025 15:45:35 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP4 (Coremail) with SMTP id gCh0CgA3l_cMmktp9pcvBQ--.63051S6;
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
Subject: [PATCH -next v2 4/7] mm/mglru: rename should_abort_scan to lru_gen_should_abort_scan
Date: Wed, 24 Dec 2025 07:30:29 +0000
Message-Id: <20251224073032.161911-5-chenridong@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgA3l_cMmktp9pcvBQ--.63051S6
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar15GF17WF48Ww4Utr1fJFb_yoW8CrWDpa
	yDW3y7Aa4rJFW5Ka95XF4kCayakFWxtFyjyFWxJ34xCrZagFyFga1UCry0vryY934kur1x
	XFWaqF1UGa1jvFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
	4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBI
	daVFxhVjvjDU0xZFpf9x0pRQJ5wUUUUU=
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

The function should_abort_scan will be called in shrink_node_memcgs
to integrate shrink_many and shrink_node_memcgs. Renaming it to
lru_gen_should_abort_scan clarifies that it is specific to the
generational LRU implementation.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 mm/vmscan.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index bbdcd4fcfd74..e55c7835cab5 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4690,7 +4690,7 @@ static long get_nr_to_scan(struct lruvec *lruvec, struct scan_control *sc, int s
 	return try_to_inc_max_seq(lruvec, max_seq, swappiness, false) ? -1 : 0;
 }
 
-static bool should_abort_scan(struct lruvec *lruvec, struct scan_control *sc)
+static bool lru_gen_should_abort_scan(struct lruvec *lruvec, struct scan_control *sc)
 {
 	int i;
 	enum zone_watermarks mark;
@@ -4742,7 +4742,7 @@ static bool try_to_shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
 		if (scanned >= nr_to_scan)
 			break;
 
-		if (should_abort_scan(lruvec, sc))
+		if (lru_gen_should_abort_scan(lruvec, sc))
 			break;
 
 		cond_resched();
@@ -4809,7 +4809,7 @@ static void shrink_many(struct pglist_data *pgdat, struct scan_control *sc)
 
 		shrink_one(lruvec, sc);
 
-		if (should_abort_scan(lruvec, sc)) {
+		if (lru_gen_should_abort_scan(lruvec, sc)) {
 			mem_cgroup_iter_break(target_memcg, memcg);
 			break;
 		}
@@ -5561,6 +5561,10 @@ static void lru_gen_shrink_node(struct pglist_data *pgdat, struct scan_control *
 	BUILD_BUG();
 }
 
+static bool lru_gen_should_abort_scan(struct lruvec *lruvec, struct scan_control *sc)
+{
+	return false;
+}
 #endif /* CONFIG_LRU_GEN */
 
 static void shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
-- 
2.34.1


