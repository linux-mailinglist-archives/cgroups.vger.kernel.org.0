Return-Path: <cgroups+bounces-13598-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SOq/A9ebgGl2/wIAu9opvQ
	(envelope-from <cgroups+bounces-13598-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 02 Feb 2026 13:43:03 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DFCCC701
	for <lists+cgroups@lfdr.de>; Mon, 02 Feb 2026 13:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4ED7302978F
	for <lists+cgroups@lfdr.de>; Mon,  2 Feb 2026 12:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C37F3644CF;
	Mon,  2 Feb 2026 12:42:18 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9325E2DCF71;
	Mon,  2 Feb 2026 12:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770036138; cv=none; b=EcaXX0DXYxRKDJYH5wC6IhqQ/WlDGRXG2s7KnBaK2bWtU3ANr0ewoeUX2EedALxhV3MHtvR4k9/DeehAKgj4kGbSN1uSy+j1GpD8C2PpSWvAPDkjnmo8bvx2Tz053AgDJQfeSBwGG+rtkmqyU/yrFa3nwwBz1iyKKPFLUa+QW1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770036138; c=relaxed/simple;
	bh=7wmnCue5Y0C6XF5PJuLF8gkAiY38K7W7twqYFuQ2yiU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g3YXCUTmin9e+qKRklXqKGhlMavz0lCOkO5GF5cFbhGsliYGfORh0mTbpCurTf2KEA9uhcUVonVQGxcoHEdJi+40YuBNPS6Et+rGKNhnYg5Pyngf+PLiOWX/KOf87XQ/uxrQwDhOHZ0Gisg3cAkwbWvgnibVm89f4ngGh/09bN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4f4R7S6MjTzYQv6b;
	Mon,  2 Feb 2026 20:41:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 921404056E;
	Mon,  2 Feb 2026 20:42:10 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP1 (Coremail) with SMTP id cCh0CgDXj+WWm4Bpt7ipFw--.14648S6;
	Mon, 02 Feb 2026 20:42:10 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: dev@lankhorst.se,
	mripard@kernel.org,
	natalie.vock@gmx.de,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huaweicloud.com
Subject: [PATCH -next v2 4/4] cgroup/dmem: add argument checks in helpers
Date: Mon,  2 Feb 2026 12:27:19 +0000
Message-Id: <20260202122719.414466-5-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260202122719.414466-1-chenridong@huaweicloud.com>
References: <20260202122719.414466-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDXj+WWm4Bpt7ipFw--.14648S6
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww13ZryrGFWfXFW5urykZrb_yoW8Cw48pF
	4qka45Kw4FvF47Zws2ya4xZFyFka1xtw1UC3y7Xr4SvF1xJw1rGr47Jw1jqF1FyF9rGr18
	XFZ0yF1akrWSyrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUma14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsG
	vfC2KfnxnUUI43ZEXa7VUbPC7UUUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13598-lists,cgroups=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_TO(0.00)[lankhorst.se,kernel.org,gmx.de,cmpxchg.org,suse.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_NA(0.00)[huaweicloud.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[11];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenridong@huaweicloud.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huaweicloud.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:email]
X-Rspamd-Queue-Id: 62DFCCC701
X-Rspamd-Action: no action

From: Chen Ridong <chenridong@huawei.com>

Add WARN_ON_ONCE guards for NULL-sensitive arguments in dmem helpers to
avoid NULL dereferences on misused APIs. Valid callers are unaffected.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/dmem.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/kernel/cgroup/dmem.c b/kernel/cgroup/dmem.c
index 1ea6afffa985..aa5bacf5fe45 100644
--- a/kernel/cgroup/dmem.c
+++ b/kernel/cgroup/dmem.c
@@ -307,6 +307,9 @@ bool dmem_cgroup_state_evict_valuable(struct dmem_cgroup_pool_state *limit_pool,
 	struct page_counter *ctest;
 	u64 used, min, low;
 
+	if (WARN_ON_ONCE(!test_pool))
+		return false;
+
 	/* Can always evict from current pool, despite limits */
 	if (limit_pool == test_pool)
 		return true;
@@ -343,7 +346,8 @@ bool dmem_cgroup_state_evict_valuable(struct dmem_cgroup_pool_state *limit_pool,
 		low = READ_ONCE(ctest->elow);
 		if (used > low)
 			return true;
-
+		if (WARN_ON_ONCE(!ret_hit_low))
+			return false;
 		*ret_hit_low = true;
 		return false;
 	}
@@ -512,7 +516,7 @@ struct dmem_cgroup_region *dmem_cgroup_register_region(u64 size, const char *fmt
 	char *region_name;
 	va_list ap;
 
-	if (!size)
+	if (WARN_ON_ONCE(!size || !fmt))
 		return NULL;
 
 	va_start(ap, fmt);
@@ -520,6 +524,10 @@ struct dmem_cgroup_region *dmem_cgroup_register_region(u64 size, const char *fmt
 	va_end(ap);
 	if (!region_name)
 		return ERR_PTR(-ENOMEM);
+	if (WARN_ON_ONCE(!region_name[0])) {
+		kfree(region_name);
+		return ERR_PTR(-EINVAL);
+	}
 
 	ret = kzalloc(sizeof(*ret), GFP_KERNEL);
 	if (!ret) {
@@ -657,6 +665,9 @@ int dmem_cgroup_try_charge(struct dmem_cgroup_region *region, u64 size,
 	struct page_counter *fail;
 	int ret;
 
+	if (WARN_ON_ONCE(!region || !ret_pool))
+		return -EINVAL;
+
 	*ret_pool = NULL;
 	if (ret_limit_pool)
 		*ret_limit_pool = NULL;
-- 
2.34.1


