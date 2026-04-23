Return-Path: <cgroups+bounces-15478-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDSdNWeD6mn80AIAu9opvQ
	(envelope-from <cgroups+bounces-15478-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 23 Apr 2026 22:39:03 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC1345751C
	for <lists+cgroups@lfdr.de>; Thu, 23 Apr 2026 22:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BF1723061DDD
	for <lists+cgroups@lfdr.de>; Thu, 23 Apr 2026 20:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28BDE345CBF;
	Thu, 23 Apr 2026 20:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J18JoHN7"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FB7344DBE
	for <cgroups@vger.kernel.org>; Thu, 23 Apr 2026 20:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776976502; cv=none; b=ITiV17MAySr6oCg8FrmH6ues9qkQ3Oy8o4WKo7z2dwg4KHVW08CYlOcmhHT/opYtoQ6JQcje/aZ/lJdFVpCPD5g3BtzUnePlEHZ5T33UofdY/sG7yhjlNHKUiWzS8sYGrOVKfnBxk0Mn8pM+2c+rFxL8auN95Xp/AJZY73Npuis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776976502; c=relaxed/simple;
	bh=0Vuo5qORGM2ky+6lFQl452VquXyeurxVpPag1KuYUsM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nSncdBaM7ixPig9uLgZda9G3MdvcD9NWcrohcBhQTZmdVu7Hv65HiR3Noaqtq5gMCpN6dXVRvUz6fprA3TZDtkE/j2EZaoIG4l5vmoB3gbXIM+XnBxixXivD+EdNJV0Qr+OkaLoxm3hCrBjE7WMygoXQC/z6ocVH6Khc/yPsX0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J18JoHN7; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-479dc6d26e3so2460442b6e.0
        for <cgroups@vger.kernel.org>; Thu, 23 Apr 2026 13:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776976494; x=1777581294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fdJLrTxdQHuW/q5XioIV4K0g79ptTVlTBoTPrKNx/x0=;
        b=J18JoHN7RzmOAsZTPvnBNDKMM+U2DseL1GsxjtgrjqO0zTpigcT9lql2vsZFWHEUWg
         lE0GOR39hXw5U6zOUuE7eNhVrwWKU+WzbOVJdBa8GYL7Y25wWWrTZo6RwFqnGyy+kp8w
         FPDcf9H6zd0jNILNKlGDDiRkodjeMui6tlCQ7xinJMYmTs/4VBBhMbUchkT4bKw3JkF2
         LDriWL+u5Q6z9Rb2DGSOuCVZTbI5edch3jf/+NPdHHKql2VKLlMbR5Dd92QOaoG+jSED
         Dl/srQNrR+yZ4aXpBBzxptacHBHsFwfLY+7gDlwgQPRiqE/kXXsY7uYeHieQ5WBGiW2f
         8vZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776976494; x=1777581294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fdJLrTxdQHuW/q5XioIV4K0g79ptTVlTBoTPrKNx/x0=;
        b=Ag8+xvbvJAigqbSWn5snxcEOAp0rKC3HLnnPrKD+Ael5YF6Vpu0FtERt0y0zLHumGM
         ak98r0iTDQVWQ7oD69T677rABPC89EffgkPUSsQzTBeWDwzZakv91+Gvj+ZQHMdow1l4
         YtnQAUPA+wMT/A5LLU5X2vuahbW+WOINsGRwqizd+R/S0dFJln257zK+/uACY8urH7OZ
         lzwQW9IKlr19WyaEsuu9bcuyididqLXaG4/oSKLjgoKyhOuUuC7CnH262ftZMwsPJUIK
         2RvWhdkFj+MM0bfahik/Ts2oLuTGoricrnAOzAjevqOZizTdNxk6ZHbH4fMdLzXw50cd
         GhzQ==
X-Forwarded-Encrypted: i=1; AFNElJ8lvnFava/FUfzU0wkOewTMBDuXstb3oBYf1tpHAutgq2CmnTJ6fNJUfDScHKw7nNCpdyKmVMFy@vger.kernel.org
X-Gm-Message-State: AOJu0YwnR4MUrk51jg41eauyqyku3Q0KU6Xa5meE8fyHo8Ww3aFhs6JZ
	Aa4iQ55s0gDoejtMnGYAie0AlHyKCWeAMSYIiG0jlbuevMOK56y9iWpS
X-Gm-Gg: AeBDievqoRgijl9vaBbJxTl+DqMTFfHuR34wc4ky1rZOYPrUh4qLKNf/uwNt/xsoqiE
	JjZjoiUTVJI1LGcmqDvBALSqKo4JcfTGVzwYt1jeBuY6RcOlKM9RtpczF5RWIax168nMvqofBVn
	Ubh3e/ZfJKvYKismU3wB6MGm03vwjHEC2OKtNXe+spruB7ofAmwKoNcocV0ZMRY6xlZSOuuWeUG
	xrJ/dNfymqUm+dr+fUFbyKDIpr6GSTQDpsk0eReAn0/NNKhQCR8tjVkzvWVK5OCWDvO8fF3itY+
	zaB2jnGec6L3ooNSSuEmQ+hwpZcjv3Q2jRPkKRavZiLZLgjKGSyjX9wGesXQ+a+hPK59NVAZbEk
	STuczPHdW2zyjirnSa5zgGYuMuM4GiST33AiKIEV+MGoDPaHYzPjgYq0GKfbp09JZ4GS0UbIMyg
	7PVJT5orD/wTRUpM7R2ta2xJJs0/wufVDgH54lBjdYFg==
X-Received: by 2002:a05:6808:4f53:b0:467:58e:5d4b with SMTP id 5614622812f47-4799c8809admr14587198b6e.20.1776976494595;
        Thu, 23 Apr 2026 13:34:54 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:7::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-479a0169edfsm13908805b6e.9.2026.04.23.13.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 13:34:53 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: linux-mm@kvack.org
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [RFC PATCH 5/9 v2] mm/memcontrol: Set toptier limits proportional to memory limits
Date: Thu, 23 Apr 2026 13:34:39 -0700
Message-ID: <20260423203445.2914963-6-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260423203445.2914963-1-joshua.hahnjy@gmail.com>
References: <20260423203445.2914963-1-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-15478-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuahahnjy@gmail.com,cgroups@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4CC1345751C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Compute proportional toptier limits based on memory limits when
users write to memory limit sysfs files, or when memory hotplug causes
the toptier capacity / total capacity ratio to be shifted.

Also introduce new read-only cgroup files memory.toptier_{min,low,high,max}
to expose the derived toptier limits.

Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
---
 include/linux/memcontrol.h | 12 +++++
 mm/memcontrol.c            | 93 ++++++++++++++++++++++++++++++++++++++
 mm/memory-tiers.c          |  8 +++-
 3 files changed, 111 insertions(+), 2 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 0cdb6cd1955dc..6bcb866440075 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -543,6 +543,14 @@ static inline bool mem_cgroup_tiered_limits(void)
 #endif
 }
 
+#ifdef CONFIG_NUMA
+void update_memcg_toptier_limits(void);
+#else
+static inline void update_memcg_toptier_limits(void)
+{
+}
+#endif
+
 static inline void mem_cgroup_protection(struct mem_cgroup *root,
 					 struct mem_cgroup *memcg,
 					 unsigned long *min,
@@ -1099,6 +1107,10 @@ static inline bool mem_cgroup_tiered_limits(void)
 	return false;
 }
 
+static inline void update_memcg_toptier_limits(void)
+{
+}
+
 static inline void memcg_memory_event(struct mem_cgroup *memcg,
 				      enum memcg_memory_event event)
 {
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index d891cf77cf6d6..3acb06388405c 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3875,6 +3875,7 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
 		return ERR_CAST(memcg);
 
 	page_counter_set_high(&memcg->memory, PAGE_COUNTER_MAX);
+	page_counter_set_high(&memcg->toptier, PAGE_COUNTER_MAX);
 	memcg1_soft_limit_reset(memcg);
 #ifdef CONFIG_ZSWAP
 	memcg->zswap_max = PAGE_COUNTER_MAX;
@@ -4092,6 +4093,7 @@ static void mem_cgroup_css_reset(struct cgroup_subsys_state *css)
 	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
 
 	page_counter_set_max(&memcg->memory, PAGE_COUNTER_MAX);
+	page_counter_set_max(&memcg->toptier, PAGE_COUNTER_MAX);
 	page_counter_set_max(&memcg->swap, PAGE_COUNTER_MAX);
 #ifdef CONFIG_MEMCG_V1
 	page_counter_set_max(&memcg->kmem, PAGE_COUNTER_MAX);
@@ -4100,6 +4102,9 @@ static void mem_cgroup_css_reset(struct cgroup_subsys_state *css)
 	page_counter_set_min(&memcg->memory, 0);
 	page_counter_set_low(&memcg->memory, 0);
 	page_counter_set_high(&memcg->memory, PAGE_COUNTER_MAX);
+	page_counter_set_min(&memcg->toptier, 0);
+	page_counter_set_low(&memcg->toptier, 0);
+	page_counter_set_high(&memcg->toptier, PAGE_COUNTER_MAX);
 	memcg1_soft_limit_reset(memcg);
 	page_counter_set_high(&memcg->swap, PAGE_COUNTER_MAX);
 	memcg_wb_domain_size_changed(memcg);
@@ -4438,12 +4443,51 @@ static ssize_t memory_peak_write(struct kernfs_open_file *of, char *buf,
 
 #undef OFP_PEAK_UNSET
 
+static inline unsigned long page_counter_max_or_scale(unsigned long val)
+{
+	return val == PAGE_COUNTER_MAX ? PAGE_COUNTER_MAX :
+					 mt_scale_by_toptier(val);
+}
+
+void update_memcg_toptier_limits(void)
+{
+	struct mem_cgroup *memcg;
+
+	if (!mem_cgroup_tiered_limits())
+		return;
+
+	for_each_mem_cgroup(memcg) {
+		unsigned long old_min = READ_ONCE(memcg->memory.min);
+		unsigned long old_low = READ_ONCE(memcg->memory.low);
+		unsigned long old_high = READ_ONCE(memcg->memory.high);
+		unsigned long old_max = READ_ONCE(memcg->memory.max);
+
+		if (memcg == root_mem_cgroup)
+			continue;
+
+		page_counter_set_min(&memcg->toptier,
+				page_counter_max_or_scale(old_min));
+		page_counter_set_low(&memcg->toptier,
+				page_counter_max_or_scale(old_low));
+		page_counter_set_high(&memcg->toptier,
+				page_counter_max_or_scale(old_high));
+		xchg(&memcg->toptier.max,
+				page_counter_max_or_scale(old_max));
+	}
+}
+
 static int memory_min_show(struct seq_file *m, void *v)
 {
 	return seq_puts_memcg_tunable(m,
 		READ_ONCE(mem_cgroup_from_seq(m)->memory.min));
 }
 
+static int toptier_min_show(struct seq_file *m, void *v)
+{
+	return seq_puts_memcg_tunable(m,
+		READ_ONCE(mem_cgroup_from_seq(m)->toptier.min));
+}
+
 static ssize_t memory_min_write(struct kernfs_open_file *of,
 				char *buf, size_t nbytes, loff_t off)
 {
@@ -4457,6 +4501,9 @@ static ssize_t memory_min_write(struct kernfs_open_file *of,
 		return err;
 
 	page_counter_set_min(&memcg->memory, min);
+	if (mem_cgroup_tiered_limits())
+		page_counter_set_min(&memcg->toptier,
+				     page_counter_max_or_scale(min));
 
 	return nbytes;
 }
@@ -4467,6 +4514,12 @@ static int memory_low_show(struct seq_file *m, void *v)
 		READ_ONCE(mem_cgroup_from_seq(m)->memory.low));
 }
 
+static int toptier_low_show(struct seq_file *m, void *v)
+{
+	return seq_puts_memcg_tunable(m,
+		READ_ONCE(mem_cgroup_from_seq(m)->toptier.low));
+}
+
 static ssize_t memory_low_write(struct kernfs_open_file *of,
 				char *buf, size_t nbytes, loff_t off)
 {
@@ -4480,6 +4533,9 @@ static ssize_t memory_low_write(struct kernfs_open_file *of,
 		return err;
 
 	page_counter_set_low(&memcg->memory, low);
+	if (mem_cgroup_tiered_limits())
+		page_counter_set_low(&memcg->toptier,
+				     page_counter_max_or_scale(low));
 
 	return nbytes;
 }
@@ -4490,6 +4546,12 @@ static int memory_high_show(struct seq_file *m, void *v)
 		READ_ONCE(mem_cgroup_from_seq(m)->memory.high));
 }
 
+static int toptier_high_show(struct seq_file *m, void *v)
+{
+	return seq_puts_memcg_tunable(m,
+		READ_ONCE(mem_cgroup_from_seq(m)->toptier.high));
+}
+
 static ssize_t memory_high_write(struct kernfs_open_file *of,
 				 char *buf, size_t nbytes, loff_t off)
 {
@@ -4505,6 +4567,9 @@ static ssize_t memory_high_write(struct kernfs_open_file *of,
 		return err;
 
 	page_counter_set_high(&memcg->memory, high);
+	if (mem_cgroup_tiered_limits())
+		page_counter_set_high(&memcg->toptier,
+				      page_counter_max_or_scale(high));
 
 	if (of->file->f_flags & O_NONBLOCK)
 		goto out;
@@ -4542,6 +4607,12 @@ static int memory_max_show(struct seq_file *m, void *v)
 		READ_ONCE(mem_cgroup_from_seq(m)->memory.max));
 }
 
+static int toptier_max_show(struct seq_file *m, void *v)
+{
+	return seq_puts_memcg_tunable(m,
+		READ_ONCE(mem_cgroup_from_seq(m)->toptier.max));
+}
+
 static ssize_t memory_max_write(struct kernfs_open_file *of,
 				char *buf, size_t nbytes, loff_t off)
 {
@@ -4557,6 +4628,8 @@ static ssize_t memory_max_write(struct kernfs_open_file *of,
 		return err;
 
 	xchg(&memcg->memory.max, max);
+	if (mem_cgroup_tiered_limits())
+		xchg(&memcg->toptier.max, page_counter_max_or_scale(max));
 
 	if (of->file->f_flags & O_NONBLOCK)
 		goto out;
@@ -4762,6 +4835,26 @@ static struct cftype memory_files[] = {
 		.seq_show = memory_max_show,
 		.write = memory_max_write,
 	},
+	{
+		.name = "toptier_min",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.seq_show = toptier_min_show,
+	},
+	{
+		.name = "toptier_low",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.seq_show = toptier_low_show,
+	},
+	{
+		.name = "toptier_high",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.seq_show = toptier_high_show,
+	},
+	{
+		.name = "toptier_max",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.seq_show = toptier_max_show,
+	},
 	{
 		.name = "events",
 		.flags = CFTYPE_NOT_ON_ROOT,
diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index acc02679e312d..ddcc11e3919da 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -924,15 +924,19 @@ static int __meminit memtier_hotplug_callback(struct notifier_block *self,
 	switch (action) {
 	case NODE_REMOVED_LAST_MEMORY:
 		mutex_lock(&memory_tier_lock);
-		if (clear_node_memory_tier(nn->nid))
+		if (clear_node_memory_tier(nn->nid)) {
 			establish_demotion_targets();
+			update_memcg_toptier_limits();
+		}
 		mutex_unlock(&memory_tier_lock);
 		break;
 	case NODE_ADDED_FIRST_MEMORY:
 		mutex_lock(&memory_tier_lock);
 		memtier = set_node_memory_tier(nn->nid);
-		if (!IS_ERR(memtier))
+		if (!IS_ERR(memtier)) {
 			establish_demotion_targets();
+			update_memcg_toptier_limits();
+		}
 		mutex_unlock(&memory_tier_lock);
 		break;
 	}
-- 
2.52.0


