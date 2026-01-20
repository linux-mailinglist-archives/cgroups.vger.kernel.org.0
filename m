Return-Path: <cgroups+bounces-13325-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id S4CBJ1BgcWkZGgAAu9opvQ
	(envelope-from <cgroups+bounces-13325-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 22 Jan 2026 00:25:04 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B9B5F752
	for <lists+cgroups@lfdr.de>; Thu, 22 Jan 2026 00:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D43A1740A65
	for <lists+cgroups@lfdr.de>; Tue, 20 Jan 2026 13:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F25D43CEC4;
	Tue, 20 Jan 2026 13:57:53 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0CA436344;
	Tue, 20 Jan 2026 13:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768917473; cv=none; b=XqBr8ISERFs7Ob3jIapSurdv+oxTVmSo24Ny8KDfB/qOirbbXpkjUcb7aaCneycdxHzxBL6J/D71VdQ5lRZbnObCEo7VdQpq9+MBTtyxeODXcWGyD2quAUxHAOtMi+v99/7OISTv2TEljCENg5jNM/MVMiwIX5HWIfbvWzM/da0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768917473; c=relaxed/simple;
	bh=p17iXYkwsGW0zMBtU2mO731CQqBuWr+SKG++pwTUTmg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L7QKbv2qOLPVisRFzEo0dBQNBc4w/IVzfRzsz0oqKKCRU1rYbEUIdS27HPbjkSTFxl2aTRUpvzTp6YKi4AF8eQPQf6KyMPGjN6zbsFzIr/cldxOIdtDnvZUQ15grh1TbUE0hJQcA2R61e8lKYuomNzoRgOHeYuQ397cCh+2a4UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dwTQP64cmzKHMkx;
	Tue, 20 Jan 2026 21:56:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 30FF440576;
	Tue, 20 Jan 2026 21:57:47 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP4 (Coremail) with SMTP id gCh0CgCnCPnQiW9pwhTxEQ--.10691S5;
	Tue, 20 Jan 2026 21:57:46 +0800 (CST)
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
Subject: [RFC PATCH -next 3/7] mm/mglru: rename should_abort_scan to lru_gen_should_abort_scan
Date: Tue, 20 Jan 2026 13:42:52 +0000
Message-Id: <20260120134256.2271710-4-chenridong@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgCnCPnQiW9pwhTxEQ--.10691S5
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar15GF17WF48AFy7urW7urg_yoW8Aw1DpF
	WDW3y7Aa4rJF45Ka9YqF4kCa43CrWxtFyDtrWxJ34xCrsagFy8WayUCryIvry5u34kuF1x
	XFWaqF1UGa1jqFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmF14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2
	KfnxnUUI43ZEXa7VUUbAw7UUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.24 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DATE_IN_PAST(1.00)[33];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_FROM(0.00)[bounces-13325-lists,cgroups=lfdr.de];
	DMARC_NA(0.00)[huaweicloud.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kvack.org,vger.kernel.org,huawei.com,huaweicloud.com,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[chenridong@huaweicloud.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	R_DKIM_NA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCPT_COUNT_TWELVE(0.00)[25];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 63B9B5F752
X-Rspamd-Action: no action

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
index 5a156ff48520..ab7a74de80da 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4855,7 +4855,7 @@ static long get_nr_to_scan(struct lruvec *lruvec, struct scan_control *sc, int s
 	return try_to_inc_max_seq(lruvec, max_seq, swappiness, false) ? -1 : 0;
 }
 
-static bool should_abort_scan(struct lruvec *lruvec, struct scan_control *sc)
+static bool lru_gen_should_abort_scan(struct lruvec *lruvec, struct scan_control *sc)
 {
 	int i;
 	enum zone_watermarks mark;
@@ -4907,7 +4907,7 @@ static bool try_to_shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
 		if (scanned >= nr_to_scan)
 			break;
 
-		if (should_abort_scan(lruvec, sc))
+		if (lru_gen_should_abort_scan(lruvec, sc))
 			break;
 
 		cond_resched();
@@ -5011,7 +5011,7 @@ static void shrink_many(struct pglist_data *pgdat, struct scan_control *sc)
 
 		rcu_read_lock();
 
-		if (should_abort_scan(lruvec, sc))
+		if (lru_gen_should_abort_scan(lruvec, sc))
 			break;
 	}
 
@@ -5788,6 +5788,10 @@ static void lru_gen_shrink_node(struct pglist_data *pgdat, struct scan_control *
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


