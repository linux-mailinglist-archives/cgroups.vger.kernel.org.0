Return-Path: <cgroups+bounces-6210-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C79A147F9
	for <lists+cgroups@lfdr.de>; Fri, 17 Jan 2025 03:15:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9563D3A7308
	for <lists+cgroups@lfdr.de>; Fri, 17 Jan 2025 02:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CAA91F5612;
	Fri, 17 Jan 2025 02:14:59 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DAFD1F5606;
	Fri, 17 Jan 2025 02:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737080099; cv=none; b=IhKm5HbWvrrLRjwaePlWIn3ciIoV14KKp7qe3mtLeKYC+X6OQgsooVK05Vn/myAzOgjBL83OiZxPvXWD76zgb88rpaWXO9d6kP1ZG3rihIacsMbljYuDMmO/FnSTrzDq55c7QbtB1JeUrYTZXAyyD++TsvNRHqzIqsspe7Psmvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737080099; c=relaxed/simple;
	bh=139wZiZAYzcX1f9OvPYAgt8ouCnZd/ur8n21fqubZb4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GVvNCVVRCrcUIyS7tSNL4T796IAhSCTT7vAzKBrmQouLFUKAq+0Mlx7eW/VqPdkd6YBT++Y7MmlksaHUllxBuNtC2De2Xn+j3VI5rQirZmE7VyAH4eWHENQusuxdNasLXaHTz+Bb/bjGYucIrAf8jVpO/8Xks3vcXYtJI4fvTQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YZ2t03Plgz4f3kvv;
	Fri, 17 Jan 2025 09:57:12 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 2DDEB1A0E3E;
	Fri, 17 Jan 2025 09:57:34 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP2 (Coremail) with SMTP id Syh0CgCnsWT7uIln8NWrBA--.20802S4;
	Fri, 17 Jan 2025 09:57:33 +0800 (CST)
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
Subject: [PATCH v3 next 2/5] memcg: call the free function when allocation of pn fails
Date: Fri, 17 Jan 2025 01:46:42 +0000
Message-Id: <20250117014645.1673127-3-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250117014645.1673127-1-chenridong@huaweicloud.com>
References: <20250117014645.1673127-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgCnsWT7uIln8NWrBA--.20802S4
X-Coremail-Antispam: 1UD129KBjvJXoW7WFWUuFykKFWktw1xCr13CFg_yoW8trWrpa
	nxKa45Z3y5Jr4UWa1fKa4jva4rZa18Xw4UWryxXw1IkF1aqwnYqr12yw1F9r98CFyfXrnr
	trn8Aw1xK39FkrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUob18
	DUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

The 'free_mem_cgroup_per_node_info' function is used to free
the 'mem_cgroup_per_node' struct. Using 'pn' as the input for the
free_mem_cgroup_per_node_info function will be much clearer.
Call 'free_mem_cgroup_per_node_info' when 'alloc_mem_cgroup_per_node_info'
fails, to free 'pn' as a whole, which makes the code more cohesive.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
Reviewed-by: Michal Koutný <mkoutny@suse.com>
Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 mm/memcontrol.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 05a32c860554..98f84a9fa228 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3424,6 +3424,16 @@ struct mem_cgroup *mem_cgroup_get_from_ino(unsigned long ino)
 }
 #endif
 
+static void free_mem_cgroup_per_node_info(struct mem_cgroup_per_node *pn)
+{
+	if (!pn)
+		return;
+
+	free_percpu(pn->lruvec_stats_percpu);
+	kfree(pn->lruvec_stats);
+	kfree(pn);
+}
+
 static bool alloc_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
 {
 	struct mem_cgroup_per_node *pn;
@@ -3448,23 +3458,10 @@ static bool alloc_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
 	memcg->nodeinfo[node] = pn;
 	return true;
 fail:
-	kfree(pn->lruvec_stats);
-	kfree(pn);
+	free_mem_cgroup_per_node_info(pn);
 	return false;
 }
 
-static void free_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
-{
-	struct mem_cgroup_per_node *pn = memcg->nodeinfo[node];
-
-	if (!pn)
-		return;
-
-	free_percpu(pn->lruvec_stats_percpu);
-	kfree(pn->lruvec_stats);
-	kfree(pn);
-}
-
 static void __mem_cgroup_free(struct mem_cgroup *memcg)
 {
 	int node;
@@ -3472,7 +3469,7 @@ static void __mem_cgroup_free(struct mem_cgroup *memcg)
 	obj_cgroup_put(memcg->orig_objcg);
 
 	for_each_node(node)
-		free_mem_cgroup_per_node_info(memcg, node);
+		free_mem_cgroup_per_node_info(memcg->nodeinfo[node]);
 	memcg1_free_events(memcg);
 	kfree(memcg->vmstats);
 	free_percpu(memcg->vmstats_percpu);
-- 
2.34.1


