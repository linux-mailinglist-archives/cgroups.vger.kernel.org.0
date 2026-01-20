Return-Path: <cgroups+bounces-13327-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aMmqFGGlb2kfEgAAu9opvQ
	(envelope-from <cgroups+bounces-13327-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 20 Jan 2026 16:55:13 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB1D46D58
	for <lists+cgroups@lfdr.de>; Tue, 20 Jan 2026 16:55:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E7521741127
	for <lists+cgroups@lfdr.de>; Tue, 20 Jan 2026 13:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E695B43CEEE;
	Tue, 20 Jan 2026 13:57:53 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2078B436358;
	Tue, 20 Jan 2026 13:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768917473; cv=none; b=Tencpt3Ps6OApm6gAMWj4Ds0JOh8REgCLvFadZciYM0PF+ijlxoGWoglBoWRiwNh/Zk2rWOawQ8r1KgysoaOrChZIFbdj0ARnLlzIE2YuC/9o8yHV2PP+Dbd+s3QN7bvGkZZUtLI9c8axxsL5KwS3feCtOae+1PI3ly8t7K+dr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768917473; c=relaxed/simple;
	bh=VEei/FBbQUWoBnky82fXrK1tQd7KhKGHHLmMZXOEVAE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QeJPqp8zSpUn+SqSIK3phAazfq1srR+pboF4L/ZETCHxepNUR5tD+wTC0RujHOMhhMXhSk6EvFeFWjQ2tfjwx9tleOdjprve+X3dsk/sSXKcSs2TNrO34FcEjU3TZvCKvkWBn/4GdTFeYUQuyRnSGff6m67Z0pGQv8H3NoUakgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dwTR749kYzYQvJD;
	Tue, 20 Jan 2026 21:57:23 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 784174058F;
	Tue, 20 Jan 2026 21:57:47 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP4 (Coremail) with SMTP id gCh0CgCnCPnQiW9pwhTxEQ--.10691S8;
	Tue, 20 Jan 2026 21:57:47 +0800 (CST)
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
	skhan@linuxfoundation.org,
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
	ryncsn@gmail.com
Subject: [RFC PATCH -next 6/7] mm/mglru: remove memcg disable handling from lru_gen_shrink_node
Date: Tue, 20 Jan 2026 13:42:55 +0000
Message-Id: <20260120134256.2271710-7-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260120134256.2271710-1-chenridong@huaweicloud.com>
References: <20260120134256.2271710-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCnCPnQiW9pwhTxEQ--.10691S8
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar4ruFWfuFWDGryfGry8Krg_yoW8KFyfpF
	Z3GrWIy3yrJF1ag3ZaqF47uasxCw48tr1rJrWUtw4fAr1furyrKa4UCrW8Wry5Arykur13
	Jr9Ivr1rG3yjqF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmS14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
	4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBI
	daVFxhVjvjDU0xZFpf9x0pRiF4iUUUUU=
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/
X-Spamd-Result: default: False [0.24 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kvack.org,vger.kernel.org,huawei.com,huaweicloud.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-13327-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[huaweicloud.com];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TAGGED_RCPT(0.00)[cgroups];
	R_DKIM_NA(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenridong@huaweicloud.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TO_DN_NONE(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,huawei.com:email,huaweicloud.com:mid]
X-Rspamd-Queue-Id: EDB1D46D58
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chen Ridong <chenridong@huawei.com>

Since shrink_node_memcgs already handles the memcg disabled case,
this special-case logic in lru_gen_shrink_node is unnecessary.
Remove it.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 mm/vmscan.c | 46 +---------------------------------------------
 1 file changed, 1 insertion(+), 45 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index f806838c3cea..d4eaa8221174 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4924,47 +4924,6 @@ static bool try_to_shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
 	return nr_to_scan < 0;
 }
 
-static int shrink_one(struct lruvec *lruvec, struct scan_control *sc)
-{
-	bool success;
-	unsigned long scanned = sc->nr_scanned;
-	unsigned long reclaimed = sc->nr_reclaimed;
-	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
-	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
-
-	/* lru_gen_age_node() called mem_cgroup_calculate_protection() */
-	if (mem_cgroup_below_min(NULL, memcg))
-		return MEMCG_LRU_YOUNG;
-
-	if (mem_cgroup_below_low(NULL, memcg)) {
-		/* see the comment on MEMCG_NR_GENS */
-		if (READ_ONCE(lruvec->lrugen.seg) != MEMCG_LRU_TAIL)
-			return MEMCG_LRU_TAIL;
-
-		memcg_memory_event(memcg, MEMCG_LOW);
-	}
-
-	success = try_to_shrink_lruvec(lruvec, sc);
-
-	shrink_slab(sc->gfp_mask, pgdat->node_id, memcg, sc->priority);
-
-	if (!sc->proactive)
-		vmpressure(sc->gfp_mask, memcg, false, sc->nr_scanned - scanned,
-			   sc->nr_reclaimed - reclaimed);
-
-	flush_reclaim_state(sc);
-
-	if (success && mem_cgroup_online(memcg))
-		return MEMCG_LRU_YOUNG;
-
-	if (!success && lruvec_is_sizable(lruvec, sc))
-		return 0;
-
-	/* one retry if offlined or too small */
-	return READ_ONCE(lruvec->lrugen.seg) != MEMCG_LRU_TAIL ?
-	       MEMCG_LRU_TAIL : MEMCG_LRU_YOUNG;
-}
-
 static void lru_gen_shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
 {
 	struct blk_plug plug;
@@ -5021,10 +4980,7 @@ static void lru_gen_shrink_node(struct pglist_data *pgdat, struct scan_control *
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


