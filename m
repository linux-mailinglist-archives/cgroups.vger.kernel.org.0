Return-Path: <cgroups+bounces-12198-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2442CC87CFC
	for <lists+cgroups@lfdr.de>; Wed, 26 Nov 2025 03:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BB045354A0D
	for <lists+cgroups@lfdr.de>; Wed, 26 Nov 2025 02:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366C123EABF;
	Wed, 26 Nov 2025 02:19:44 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF15B18FDBE;
	Wed, 26 Nov 2025 02:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764123584; cv=none; b=EG6gXwNY0/Tn8l+Ac9pcwec89Khnp25Cwg0ynjkAVg9WGuDzHe4zNhyMDxTdLWxFimutbBQRdFBk4eXBDmCidMBFetjEFIg6s5FbGnUPwYJra0jzvgcPu/5BYJrimm/WKCZOc1KaElkE0trvVzTBiqw4t8MGpT/mOU4+0YddX04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764123584; c=relaxed/simple;
	bh=6v6jNecWnbeG8h5Pl19s891nhh1tLwl152jolqshuVY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TtzVkzQTzCumM/UovRuqvESZhl8cb/vKHk77OfqhJfnY9Sd2Rma2lRnT+GcsuPOcDv5Gyc3xs07deZmLdCYvgyaAZxACakUV0Jt4XFQxZPyy4wRiJz9XLq4rGl+5tssCXvXdzed6MfW9DcnDT3nY/cExkyzZNZl2B605bd4ms2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dGNXZ6pPHzKHMYR;
	Wed, 26 Nov 2025 10:18:54 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 11DE11A12D2;
	Wed, 26 Nov 2025 10:19:33 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP2 (Coremail) with SMTP id Syh0CgBH8XepYyZpRnwmCA--.22181S2;
	Wed, 26 Nov 2025 10:19:32 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	akpm@linux-foundation.org,
	david@kernel.org,
	zhengqi.arch@bytedance.com,
	lorenzo.stoakes@oracle.com,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com
Cc: cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huawei.com
Subject: [PATCH -next] memcg: Remove inc/dec_lruvec_kmem_state helpers
Date: Wed, 26 Nov 2025 02:04:35 +0000
Message-Id: <20251126020435.1511637-1-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBH8XepYyZpRnwmCA--.22181S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJF1rGFy5tF48AFWruF4Durg_yoW8Ar4UpF
	srJrWFkayUXFyYvFZrKanrCryUua1xGr4UXrZFgw1fAasxt34FgwnrKFZ5JrWjq3yFvr18
	Xaya9rWUWaySqrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0E
	n4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
	0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8
	ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
	CY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7IU0s2-5UUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

The dec_lruvec_kmem_state helper is unused by any caller and can be safely
removed. Meanwhile, the inc_lruvec_kmem_state helper is only referenced by
shadow_lru_isolate, retaining these two helpers is unnecessary. This patch
removes both helper functions to eliminate redundant code.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 include/linux/memcontrol.h | 10 ----------
 mm/workingset.c            |  2 +-
 2 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index d35390f9892a..0651865a4564 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1452,16 +1452,6 @@ struct slabobj_ext {
 #endif
 } __aligned(8);
 
-static inline void inc_lruvec_kmem_state(void *p, enum node_stat_item idx)
-{
-	mod_lruvec_kmem_state(p, idx, 1);
-}
-
-static inline void dec_lruvec_kmem_state(void *p, enum node_stat_item idx)
-{
-	mod_lruvec_kmem_state(p, idx, -1);
-}
-
 static inline struct lruvec *parent_lruvec(struct lruvec *lruvec)
 {
 	struct mem_cgroup *memcg;
diff --git a/mm/workingset.c b/mm/workingset.c
index 892f6fe94ea9..e9f05634747a 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -749,7 +749,7 @@ static enum lru_status shadow_lru_isolate(struct list_head *item,
 	if (WARN_ON_ONCE(node->count != node->nr_values))
 		goto out_invalid;
 	xa_delete_node(node, workingset_update_node);
-	inc_lruvec_kmem_state(node, WORKINGSET_NODERECLAIM);
+	mod_lruvec_kmem_state(node, WORKINGSET_NODERECLAIM, 1);
 
 out_invalid:
 	xa_unlock_irq(&mapping->i_pages);
-- 
2.34.1


