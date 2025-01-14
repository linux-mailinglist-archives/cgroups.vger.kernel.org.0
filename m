Return-Path: <cgroups+bounces-6125-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD001A106BB
	for <lists+cgroups@lfdr.de>; Tue, 14 Jan 2025 13:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 053C5165956
	for <lists+cgroups@lfdr.de>; Tue, 14 Jan 2025 12:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8C0234D0D;
	Tue, 14 Jan 2025 12:36:05 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E143F3232;
	Tue, 14 Jan 2025 12:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736858165; cv=none; b=KGrVlDwifG1KD9cym3geIKS4CQ/ihDzbE3ytPcTmaZsCdJ41GNeWpP48Xtn+/GE++7LnoxVCwrSZUpfITvD+iQcTkv3xKHPd18bLmK/txETnUfHcQ1K+OQtr1zX6d3g3lV5c9gDkCW0yi937aN6dzXG+0zgMj9pyHyt51QlQDq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736858165; c=relaxed/simple;
	bh=E5OnCd+5HbAvduRuEc07ImF7YcU7dE5G+ggySo2KgyI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H+jKtylnuqijBcZRz7i85ZH1/bIrOEILpz1UNBfFZUH8TPxdRNpJQATGNbgctmum1EJsan3d9kTg+by4JncaUspcvlvZZeT8PmMicLCa+MPhk/wD5b82y7KJW8D0ZP+JPsoVN8sVYcgEOYddEq59mvM9iVtxn2cMPs9a6SP1T+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YXTB31RcNz4f3khK;
	Tue, 14 Jan 2025 20:35:39 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 8FB911A111E;
	Tue, 14 Jan 2025 20:35:59 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP3 (Coremail) with SMTP id _Ch0CgB3F8IhWoZnN4KvAw--.1325S5;
	Tue, 14 Jan 2025 20:35:59 +0800 (CST)
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
Subject: [PATCH -v2 next 3/4] memcg: factor out the replace_stock_objcg function
Date: Tue, 14 Jan 2025 12:25:18 +0000
Message-Id: <20250114122519.1404275-4-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250114122519.1404275-1-chenridong@huaweicloud.com>
References: <20250114122519.1404275-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgB3F8IhWoZnN4KvAw--.1325S5
X-Coremail-Antispam: 1UD129KBjvJXoW7tryDAw47ur15CF4UuF1xZrb_yoW8Kr1kpF
	srJas8Jw18AFW2gws8Ga17Zr1fJF4vqFnrKrs2qw1xCFnIgF1Yq342yFyjya48Jr93tF4x
	Jr4qyanrGay7J37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP2b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
	0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU14x
	RDUUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

Factor out the 'replace_stock_objcg' function to make the code more
cohesive.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
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


