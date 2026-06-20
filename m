Return-Path: <cgroups+bounces-17093-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dRdOF1rZNmo9FgcAu9opvQ
	(envelope-from <cgroups+bounces-17093-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 20 Jun 2026 20:18:02 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6CE6A975C
	for <lists+cgroups@lfdr.de>; Sat, 20 Jun 2026 20:18:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=sv646IAs;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17093-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17093-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 373AC302D952
	for <lists+cgroups@lfdr.de>; Sat, 20 Jun 2026 18:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F81533F591;
	Sat, 20 Jun 2026 18:17:08 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC060348C5E
	for <cgroups@vger.kernel.org>; Sat, 20 Jun 2026 18:17:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781979427; cv=none; b=YN/3ZXiX/TnUIhjw7eLe+QqIGUb5lL65IxeperCihGplbzhK5RGLf6Aa+h5vOPpwILzYsELOwLdiZwLi2YyEAF6UJYWBrBjRBHeWif1NfXxIEp/NyAjwSJUxs/DMRT9QBXKZ0NJTI+4yWuudOmrJWhTPd6uadIlXan/qmpqDQjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781979427; c=relaxed/simple;
	bh=ENr6YAPp19BxIaCtJXBCCOLDywZxLaNSRUcJ1CCqy2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uPxDp08+8IRZcU4fMhH1VHcyitxuvz1RpAA1Euqv9OPE4v4HhGvVgAblDshS2fnnEGf2Xq80tX3Q2kr+UMy5W9ZHA9joOanZikZaL0CzucWSeozdPGB1f/S3ydRa3czZ1TXSzKq5h/bqTNcEeS9XJs8qPTh9NT4bLi6Fvg8mtJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sv646IAs; arc=none smtp.client-ip=209.85.214.178
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2c6d31bfc70so19715465ad.3
        for <cgroups@vger.kernel.org>; Sat, 20 Jun 2026 11:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781979424; x=1782584224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XJdnGcYqrN2PZHNQjPn0cMT+HfsR3sWO/K33y7osfm0=;
        b=sv646IAs7JfFif9oT2DxdubR9EqQ1IvNTdLOFGJrkr2aymstSh4cc/rvv8RnRiapGw
         QJXEHxXe5aDfCg4eBYtmx8Y4Z7KpvKqDjQfUWccpEdrdGc6ON1LM3p/6z/BPPooBKTxs
         evivdNpbu/pUQxLpnvx2EMYpxaX9pWMf1vOnFmKJC/uMN6TvFA81uM9uph3NpNDpCb5I
         haDaIqQAktbUqTrZFoYxtylFgVChodI+aV92qTYb79zzHLYaTOu5O/AFJJJMGrM6zkR3
         2ebU/Fs3zrNM4rwi4oWBHRTD9hPISj5/3tqYi05broeoA4XTkpNd1Q/778CUREYFCAoI
         9a7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781979424; x=1782584224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XJdnGcYqrN2PZHNQjPn0cMT+HfsR3sWO/K33y7osfm0=;
        b=o57Ug83WsGsqj0hn2iP6kuhHtEpU39GDs13JkpRUeqDlYwfCy6EJtOUt+AaDQMOMtY
         II+QTRQkmmG9l90SLrI8fIOol1Cscd9KHZHhgUJoz0p7tH+u7SAQ4jJzC/QGwt0TAh7K
         Lb9M2chNbVKz5pSr8fICR/ZiYRfU+JgbwnGMikN+MTg6BdWwXMP8Ag+BAkdewRf2Y+mA
         GvycwYSlHeduXFaCgZmU2VpqWx4rUSEjVOWr1JbDOTC3mVIbRiy52H5TCWs3Bu89iRvi
         va/hDYei5M4BJ3jgLc3FJBTJAZoraCuY3k5cRujcx5JaONnrHjPz/FAJs7le3MIm6si0
         avJA==
X-Forwarded-Encrypted: i=1; AHgh+Rrl58Aub/nP0IRih1uFV3TyKQMKmAZsDrB1jOg8XUJ4QtcqxVaYS1esoWOiIabgL25H2h+WY5/+@vger.kernel.org
X-Gm-Message-State: AOJu0YwfzJUf+ROPqJmfFkI/WAsjg88QOEaEEsecQMwHJtN69+PlBxSn
	SduZu3IdRzp0Crborr1m1lCQwOa0VF3nKijn7xrYDUwrMMWI/LkLsxkx
X-Gm-Gg: AfdE7ckILZN2djw1U888TQOZeAkaXD82t6LsxeCOWHqIxC3ppoO+uTDIfbouFJK5rii
	izzFYJEkfCuX6+WiPQPZx4aQqQvC15OWXVzaDg/qUezwDxnXeknXZMp7GYrhZal0ME8mtf+V2DC
	G9q2lpNdZfj9ScmXNDYx96ICg4gxlbNZeOkvmLTLLLdkPoPhfj1LpRBN7qTeqDYjm3+ymgFQ3iR
	IOdXZj6S5EAKs7oRag5HYF47D4vFhQ0eFhAzOKISO8qNvJm1VBXUBmKfyXALQifu4ogr/EEjhlV
	WA6pGuoV4Lija7/JLV+ej9V/s/FgN2F3UT35kdErungeoas030PZCYcwrXjHFdQ2s0kws1+r9vH
	S/4DnYpSazyHwDpyy+HUKXCgKSMCJR0H75Xd7sa1/3gzIBl7ff+I8JpWMcmg++NO543Ka+3yp46
	qwd7pj0eLOgA0tWFEFgPevtYDRHAhTvcgboKltnxDaTnP4tsdZ7KPGQIsysfQbH3hw3xoDfcR6f
	Q==
X-Received: by 2002:a17:903:1a44:b0:2ba:6518:a6d4 with SMTP id d9443c01a7336-2c725d7ee92mr81603135ad.20.1781979424175;
        Sat, 20 Jun 2026 11:17:04 -0700 (PDT)
Received: from localhost.localdomain ([220.85.166.190])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7436af6d9sm30339465ad.4.2026.06.20.11.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 11:17:03 -0700 (PDT)
From: Youngjun Park <her0gyugyu@gmail.com>
X-Google-Original-From: Youngjun Park <youngjun.park@lge.com>
To: akpm@linux-foundation.org
Cc: chrisl@kernel.org,
	youngjun.park@lge.com,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kasong@tencent.com,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	shikemeng@huaweicloud.com,
	nphamcs@gmail.com,
	baoquan.he@linux.dev,
	baohua@kernel.org,
	yosry@kernel.org,
	gunho.lee@lge.com,
	taejoon.song@lge.com,
	hyungjun.cho@lge.com,
	mkoutny@suse.com,
	baver.bae@lge.com,
	matia.kim@lge.com
Subject: [PATCH v9 3/6] mm: memcontrol: add interface for swap tier selection
Date: Sun, 21 Jun 2026 03:16:28 +0900
Message-ID: <20260620181635.299364-4-youngjun.park@lge.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260620181635.299364-1-youngjun.park@lge.com>
References: <20260620181635.299364-1-youngjun.park@lge.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:akpm@linux-foundation.org,m:chrisl@kernel.org,m:youngjun.park@lge.com,m:linux-mm@kvack.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:kasong@tencent.com,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:shikemeng@huaweicloud.com,m:nphamcs@gmail.com,m:baoquan.he@linux.dev,m:baohua@kernel.org,m:yosry@kernel.org,m:gunho.lee@lge.com,m:taejoon.song@lge.com,m:hyungjun.cho@lge.com,m:mkoutny@suse.com,m:baver.bae@lge.com,m:matia.kim@lge.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-17093-lists,cgroups=lfdr.de];
	FORGED_SENDER(0.00)[her0gyugyu@gmail.com,cgroups@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_CC(0.00)[kernel.org,lge.com,kvack.org,vger.kernel.org,tencent.com,cmpxchg.org,linux.dev,huaweicloud.com,gmail.com,suse.com];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[her0gyugyu@gmail.com,cgroups@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,linux.dev:email,swap.events:url,lge.com:mid,lge.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AF6CE6A975C

Introduce memory.swap.tiers.max, a flat-keyed file listing each
tier defined in /sys/kernel/mm/swap/tiers with its state, "max"
(allowed, the default) or "0" (disabled).  A tier is one bit in the
cgroup's tier mask, so writing "<tier> max" or "<tier> 0" sets or
clears that bit.

Since the current use case lacks amount control, it only supports
"max" (on) and "0" (off). Therefore, it does not track per-tier swap
usage, relying instead on a fast runtime bitmask check.

We maintain both `mask` and `effective_mask`. The `effective_mask` is
strictly bounded by the parent (e.g., if a parent is "0", the child's
effective state is "0" even if its `mask` is "max"). Maintaining this
separately avoids costly cgroup tree traversals to check ancestors at
runtime.

Suggested-by: Shakeel Butt <shakeel.butt@linux.dev>
Suggested-by: Yosry Ahmed <yosry@kernel.org>
Signed-off-by: Youngjun Park <youngjun.park@lge.com>
---
 Documentation/admin-guide/cgroup-v2.rst |  20 +++++
 Documentation/mm/swap-tier.rst          |   9 +++
 include/linux/memcontrol.h              |   5 ++
 mm/memcontrol.c                         |  67 ++++++++++++++++
 mm/swap_state.c                         |   5 +-
 mm/swap_tier.c                          | 102 +++++++++++++++++++++++-
 mm/swap_tier.h                          |  57 +++++++++++--
 7 files changed, 255 insertions(+), 10 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 6efd0095ed99..4843ffcfd110 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1850,6 +1850,26 @@ The following nested keys are defined.
 	Swap usage hard limit.  If a cgroup's swap usage reaches this
 	limit, anonymous memory of the cgroup will not be swapped out.
 
+  memory.swap.tiers.max
+	A read-write flat-keyed file which exists on non-root
+	cgroups.  The default is "max" for every tier.
+
+	Limits the swap tiers this cgroup may swap to.  Tiers are
+	defined globally in /sys/kernel/mm/swap/tiers and listed here,
+	one per line. When read, the values are displayed in descending
+	order of the tiers (highest tier first)::
+
+	  <tier_1> max
+	  <tier_2> 0
+	  ...
+
+	Currently, only "max" and "0" are supported. "max" allows the
+	tier, "0" disables it.  Each write sets a single "<tier> max"
+	or "<tier> 0" pair.
+
+	A child may only narrow what its parent allows. A tier an
+	ancestor disabled stays disabled regardless of the value here.
+
   memory.swap.events
 	A read-only flat-keyed file which exists on non-root cgroups.
 	The following entries are defined.  Unless specified
diff --git a/Documentation/mm/swap-tier.rst b/Documentation/mm/swap-tier.rst
index 0fb4a1153a67..addbc495de8c 100644
--- a/Documentation/mm/swap-tier.rst
+++ b/Documentation/mm/swap-tier.rst
@@ -15,6 +15,15 @@ speed to fully utilize this feature. While the current implementation is
 integrated with cgroups, the concept is designed to be extensible for other
 subsystems in the future.
 
+Use case
+---------
+
+Users can perform selective swapping by choosing a swap tier assigned according
+to speed within a cgroup.
+
+For more information on cgroup v2, please refer to
+``Documentation/admin-guide/cgroup-v2.rst``.
+
 Priority Range
 --------------
 
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index e1f46a0016fc..d53826c68562 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -283,6 +283,11 @@ struct mem_cgroup {
 	struct lru_gen_mm_list mm_list;
 #endif
 
+#ifdef CONFIG_SWAP
+	int tier_mask;
+	int tier_effective_mask;
+#endif
+
 #ifdef CONFIG_MEMCG_V1
 	/* Legacy consumer-oriented counters */
 	struct page_counter kmem;		/* v1 only */
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 56cd4af08232..63259576792a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -68,6 +68,7 @@
 #include <net/ip.h>
 #include "slab.h"
 #include "memcontrol-v1.h"
+#include "swap_tier.h"
 
 #include <linux/uaccess.h>
 
@@ -4244,6 +4245,8 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
 	refcount_set(&memcg->id.ref, 1);
 	css_get(css);
 
+	swap_tiers_memcg_inherit_mask(memcg);
+
 	/*
 	 * Ensure mem_cgroup_from_private_id() works once we're fully online.
 	 *
@@ -5785,6 +5788,64 @@ static int swap_events_show(struct seq_file *m, void *v)
 	return 0;
 }
 
+static int swap_tier_max_show(struct seq_file *m, void *v)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
+
+	swap_tiers_mask_show(m, memcg);
+	return 0;
+}
+
+static ssize_t swap_tier_max_write(struct kernfs_open_file *of,
+				char *buf, size_t nbytes, loff_t off)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
+	char *pos, *name, *val;
+	bool enable;
+	int mask;
+	int ret = 0;
+
+	pos = strstrip(buf);
+	name = strsep(&pos, " \t\n");
+	if (!name || !*name)
+		return -EINVAL;
+	if (pos)
+		pos = skip_spaces(pos);
+	val = strsep(&pos, " \t\n");
+	if (!val || !*val)
+		return -EINVAL;
+	if (pos && *skip_spaces(pos))
+		return -EINVAL;
+
+	if (!strcmp(val, "max"))
+		enable = true;
+	else if (!strcmp(val, "0"))
+		enable = false;
+	else
+		return -EINVAL;
+
+	spin_lock(&swap_tier_lock);
+	mask = swap_tiers_mask_lookup(name);
+	if (!mask) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/*
+	 * tier_mask is set per memcg here; the effective mask is clamped
+	 * to the parent's in swap_tiers_memcg_sync_mask().
+	 */
+	if (enable)
+		WRITE_ONCE(memcg->tier_mask, memcg->tier_mask | mask);
+	else
+		WRITE_ONCE(memcg->tier_mask, memcg->tier_mask & ~mask);
+
+	swap_tiers_memcg_sync_mask(memcg);
+out:
+	spin_unlock(&swap_tier_lock);
+	return ret ? ret : nbytes;
+}
+
 static struct cftype swap_files[] = {
 	{
 		.name = "swap.current",
@@ -5817,6 +5878,12 @@ static struct cftype swap_files[] = {
 		.file_offset = offsetof(struct mem_cgroup, swap_events_file),
 		.seq_show = swap_events_show,
 	},
+	{
+		.name = "swap.tiers.max",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.seq_show = swap_tier_max_show,
+		.write = swap_tier_max_write,
+	},
 	{ }	/* terminate */
 };
 
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 2f382d4dcbdc..712b225509cc 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -1021,6 +1021,7 @@ static ssize_t tiers_store(struct kobject *kobj,
 	char *p, *token, *name, *tmp;
 	int ret = 0;
 	short prio;
+	int mask = 0;
 
 	tmp = kstrdup(buf, GFP_KERNEL);
 	if (!tmp)
@@ -1053,7 +1054,7 @@ static ssize_t tiers_store(struct kobject *kobj,
 				goto restore;
 			break;
 		case '-':
-			ret = swap_tiers_remove(token + 1);
+			ret = swap_tiers_remove(token + 1, &mask);
 			if (ret)
 				goto restore;
 			break;
@@ -1063,7 +1064,7 @@ static ssize_t tiers_store(struct kobject *kobj,
 		}
 	}
 
-	if (!swap_tiers_update()) {
+	if (!swap_tiers_update(mask)) {
 		ret = -EINVAL;
 		goto restore;
 	}
diff --git a/mm/swap_tier.c b/mm/swap_tier.c
index 6b57cadb3e95..98bfee760b8d 100644
--- a/mm/swap_tier.c
+++ b/mm/swap_tier.c
@@ -253,7 +253,7 @@ int swap_tiers_add(const char *name, int prio)
 	return ret;
 }
 
-int swap_tiers_remove(const char *name)
+int swap_tiers_remove(const char *name, int *mask)
 {
 	int ret = 0;
 	struct swap_tier *tier;
@@ -276,6 +276,7 @@ int swap_tiers_remove(const char *name)
 		list_prev_entry(tier, list)->prio = DEF_SWAP_PRIO;
 
 	swap_tier_inactivate(tier);
+	*mask |= TIER_MASK(tier);
 
 	return ret;
 }
@@ -344,7 +345,24 @@ void swap_tiers_assign_dev(struct swap_info_struct *swp)
 	swp->tier_mask = TIER_DEFAULT_MASK;
 }
 
-bool swap_tiers_update(void)
+#ifdef CONFIG_MEMCG
+static void swap_tier_memcg_propagate(int mask)
+{
+	struct mem_cgroup *child;
+
+	for_each_mem_cgroup_tree(child, root_mem_cgroup) {
+		WRITE_ONCE(child->tier_mask, child->tier_mask | mask);
+		WRITE_ONCE(child->tier_effective_mask,
+			   child->tier_effective_mask | mask);
+	}
+}
+#else
+static void swap_tier_memcg_propagate(int mask)
+{
+}
+#endif
+
+bool swap_tiers_update(int mask)
 {
 	struct swap_tier *tier;
 	struct swap_info_struct *swp;
@@ -375,5 +393,85 @@ bool swap_tiers_update(void)
 		swap_tiers_assign_dev(swp);
 	}
 
+	/*
+	 * When a tier is removed, its index (bit position in the mask) becomes
+	 * free for reassignment to a future tier. If a memcg had previously
+	 * disabled this tier (cleared the bit in its swap.tiers.max file), the
+	 * effective mask would keep that bit clear -- meaning the new tier at
+	 * the same index would be silently unavailable, an invisible cgroup
+	 * constraint left behind by a tier that no longer exists.
+	 *
+	 * To prevent this, OR the removed tier's mask bit into every memcg's
+	 * tier_mask and tier_effective_mask. This resets the bit so the new
+	 * tier is accessible by default; users who want to restrict it must
+	 * explicitly disable it after the tier is re-created.
+	 */
+	if (mask)
+		swap_tier_memcg_propagate(mask);
+
 	return true;
 }
+
+#ifdef CONFIG_MEMCG
+void swap_tiers_mask_show(struct seq_file *m, struct mem_cgroup *memcg)
+{
+	struct swap_tier *tier;
+	int mask;
+
+	spin_lock(&swap_tier_lock);
+	mask = READ_ONCE(memcg->tier_mask);
+
+	for_each_active_tier(tier)
+		seq_printf(m, "%s %s\n", tier->name,
+			   (mask & TIER_MASK(tier)) ? "max" : "0");
+	spin_unlock(&swap_tier_lock);
+}
+
+int swap_tiers_mask_lookup(const char *name)
+{
+	struct swap_tier *tier;
+
+	lockdep_assert_held(&swap_tier_lock);
+
+	for_each_active_tier(tier) {
+		if (!strcmp(name, tier->name))
+			return TIER_MASK(tier);
+	}
+
+	return 0;
+}
+
+static void __swap_tier_memcg_inherit_mask(struct mem_cgroup *memcg,
+	struct mem_cgroup *parent)
+{
+	int parent_mask = parent
+		? READ_ONCE(parent->tier_effective_mask)
+		: TIER_ALL_MASK;
+
+	WRITE_ONCE(memcg->tier_effective_mask,
+		   parent_mask & READ_ONCE(memcg->tier_mask));
+}
+
+/* Computes the initial effective mask from the parent's effective mask. */
+void swap_tiers_memcg_inherit_mask(struct mem_cgroup *memcg)
+{
+	spin_lock(&swap_tier_lock);
+	memcg->tier_mask = TIER_ALL_MASK;
+	__swap_tier_memcg_inherit_mask(memcg, parent_mem_cgroup(memcg));
+	spin_unlock(&swap_tier_lock);
+}
+
+/*
+ * Called when a memcg's tier_mask is modified. Walks the subtree
+ * and recomputes each descendant's effective mask against its parent.
+ */
+void swap_tiers_memcg_sync_mask(struct mem_cgroup *memcg)
+{
+	struct mem_cgroup *child;
+
+	lockdep_assert_held(&swap_tier_lock);
+
+	for_each_mem_cgroup_tree(child, memcg)
+		__swap_tier_memcg_inherit_mask(child, parent_mem_cgroup(child));
+}
+#endif
diff --git a/mm/swap_tier.h b/mm/swap_tier.h
index 3e355f857363..e2f0cf32035b 100644
--- a/mm/swap_tier.h
+++ b/mm/swap_tier.h
@@ -10,22 +10,67 @@ struct swap_info_struct;
 
 extern spinlock_t swap_tier_lock;
 
-#define TIER_ALL_MASK		(~0)
-#define TIER_DEFAULT_IDX	(31)
-#define TIER_DEFAULT_MASK	(1U << TIER_DEFAULT_IDX)
-
 /* Initialization and application */
 void swap_tiers_init(void);
 ssize_t swap_tiers_sysfs_show(char *buf);
 
 int swap_tiers_add(const char *name, int prio);
-int swap_tiers_remove(const char *name);
+int swap_tiers_remove(const char *name, int *mask);
 
 void swap_tiers_snapshot(void);
 void swap_tiers_snapshot_restore(void);
-bool swap_tiers_update(void);
+bool swap_tiers_update(int mask);
 
 /* Tier assignment */
 void swap_tiers_assign_dev(struct swap_info_struct *swp);
 
+#define TIER_ALL_MASK		(~0)
+#define TIER_DEFAULT_IDX	(31)
+#define TIER_DEFAULT_MASK	(1U << TIER_DEFAULT_IDX)
+
+#if defined(CONFIG_SWAP) && defined(CONFIG_MEMCG)
+/* Memcg related functions */
+void swap_tiers_mask_show(struct seq_file *m, struct mem_cgroup *memcg);
+void swap_tiers_memcg_inherit_mask(struct mem_cgroup *memcg);
+void swap_tiers_memcg_sync_mask(struct mem_cgroup *memcg);
+int swap_tiers_mask_lookup(const char *name);
+static inline int folio_tier_effective_mask(struct folio *folio)
+{
+	struct mem_cgroup *memcg;
+	int mask = TIER_ALL_MASK;
+
+	rcu_read_lock();
+	memcg = folio_memcg(folio);
+	if (memcg)
+		mask = READ_ONCE(memcg->tier_effective_mask);
+	rcu_read_unlock();
+
+	return mask;
+}
+#else
+static inline void swap_tiers_mask_show(struct seq_file *m,
+	struct mem_cgroup *memcg) {}
+static inline void swap_tiers_memcg_inherit_mask(struct mem_cgroup *memcg) {}
+static inline void swap_tiers_memcg_sync_mask(struct mem_cgroup *memcg) {}
+static inline int swap_tiers_mask_lookup(const char *name)
+{
+	return 0;
+}
+static inline int folio_tier_effective_mask(struct folio *folio)
+{
+	return TIER_ALL_MASK;
+}
+#endif
+
+/**
+ * swap_tiers_mask_test - Check if the tier mask is valid
+ * @tier_mask: The tier mask to check
+ * @mask: The mask to compare against
+ *
+ * Return: true if condition matches, false otherwise
+ */
+static inline bool swap_tiers_mask_test(int tier_mask, int mask)
+{
+	return tier_mask & mask;
+}
 #endif /* _SWAP_TIER_H */
-- 
2.48.1


