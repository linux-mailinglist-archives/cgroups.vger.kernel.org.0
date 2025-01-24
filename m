Return-Path: <cgroups+bounces-6261-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C32A1B113
	for <lists+cgroups@lfdr.de>; Fri, 24 Jan 2025 08:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7B75188AD00
	for <lists+cgroups@lfdr.de>; Fri, 24 Jan 2025 07:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9091DB363;
	Fri, 24 Jan 2025 07:46:14 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C801D9A6E;
	Fri, 24 Jan 2025 07:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737704774; cv=none; b=Jb0pTgJLSvn7bT8nsAI5d8OhisdTZOO1N8dimTj+V+V/flMokcWDTxETjiMmSINFnL4hMRZ6bjbxj4kSabJCdbcnKgruiDvoFOJZgSpaRat74Ug7WxkFVbGb30Ox71Qr5PAyl3pqqWdLDBhSqL/MuKVM30avbKfRvSHkmgsH/XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737704774; c=relaxed/simple;
	bh=/n8xGYAV0lo3e3m/M1f+T71ATzlfER8hP+5EADjB3kg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ugc7FVejeLfw3VnOxNxxAtHW6wIjh9B2TM4Cd7llhHCIl4Zhd9YlgxM5Be2ZRg7fEp5Na0ozpp6wbUcq7eueYiYcPRlb3WQY4ADY+6QPJfLDSEzW2OaC5+soWX6FU1VYO1Oz7pa24jKRxGNpDZo/RfepuLXRceyS68HpWCkIQIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YfVH04DJHz4f3jdc;
	Fri, 24 Jan 2025 15:45:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 4819E1A1020;
	Fri, 24 Jan 2025 15:46:09 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP1 (Coremail) with SMTP id cCh0CgBHqnozRZNn89xFBw--.58969S5;
	Fri, 24 Jan 2025 15:46:09 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: akpm@linux-foundation.org,
	mhocko@kernel.org,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	davidf@vimeo.com,
	vbabka@suse.cz,
	mkoutny@suse.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	chenridong@huawei.com,
	wangweiyang2@huawei.com
Subject: [PATCH -v4 next 3/4] memcg: factor out the replace_stock_objcg function
Date: Fri, 24 Jan 2025 07:35:13 +0000
Message-Id: <20250124073514.2375622-4-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250124073514.2375622-1-chenridong@huaweicloud.com>
References: <20250124073514.2375622-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBHqnozRZNn89xFBw--.58969S5
X-Coremail-Antispam: 1UD129KBjvJXoW7trykJFWUuF1fWryrKF4UJwb_yoW5JF1fpa
	9rKas8Jr48AFW2gan8Ga17Zr1fXF4vvFnFkr4Iqw1xCFnIgFn0q342yFyjya4kJr93tF4x
	Jr4qyFsFkayUJ37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP2b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
	0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUbd-
	BtUUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

Factor out the 'replace_stock_objcg' function to make the code more
cohesive.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/memcontrol.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 98f84a9fa228..b10e0a8f3375 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2691,6 +2691,20 @@ void __memcg_kmem_uncharge_page(struct page *page, int order)
 	obj_cgroup_put(objcg);
 }
 
+/* Replace the stock objcg with objcg, return the old objcg */
+static struct obj_cgroup *replace_stock_objcg(struct memcg_stock_pcp *stock,
+					     struct obj_cgroup *objcg)
+{
+	struct obj_cgroup *old = NULL;
+
+	old = drain_obj_stock(stock);
+	obj_cgroup_get(objcg);
+	stock->nr_bytes = atomic_read(&objcg->nr_charged_bytes)
+			? atomic_xchg(&objcg->nr_charged_bytes, 0) : 0;
+	WRITE_ONCE(stock->cached_objcg, objcg);
+	return old;
+}
+
 static void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
 		     enum node_stat_item idx, int nr)
 {
@@ -2708,11 +2722,7 @@ static void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
 	 * changes.
 	 */
 	if (READ_ONCE(stock->cached_objcg) != objcg) {
-		old = drain_obj_stock(stock);
-		obj_cgroup_get(objcg);
-		stock->nr_bytes = atomic_read(&objcg->nr_charged_bytes)
-				? atomic_xchg(&objcg->nr_charged_bytes, 0) : 0;
-		WRITE_ONCE(stock->cached_objcg, objcg);
+		old = replace_stock_objcg(stock, objcg);
 		stock->cached_pgdat = pgdat;
 	} else if (stock->cached_pgdat != pgdat) {
 		/* Flush the existing cached vmstat data */
@@ -2866,11 +2876,7 @@ static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
 
 	stock = this_cpu_ptr(&memcg_stock);
 	if (READ_ONCE(stock->cached_objcg) != objcg) { /* reset if necessary */
-		old = drain_obj_stock(stock);
-		obj_cgroup_get(objcg);
-		WRITE_ONCE(stock->cached_objcg, objcg);
-		stock->nr_bytes = atomic_read(&objcg->nr_charged_bytes)
-				? atomic_xchg(&objcg->nr_charged_bytes, 0) : 0;
+		old = replace_stock_objcg(stock, objcg);
 		allow_uncharge = true;	/* Allow uncharge when objcg changes */
 	}
 	stock->nr_bytes += nr_bytes;
-- 
2.34.1


