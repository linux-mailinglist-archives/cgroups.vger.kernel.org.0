Return-Path: <cgroups+bounces-16112-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SINDHqlPDWqgvwUAu9opvQ
	(envelope-from <cgroups+bounces-16112-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 20 May 2026 08:07:37 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 981A6587FE3
	for <lists+cgroups@lfdr.de>; Wed, 20 May 2026 08:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A4A0302A056
	for <lists+cgroups@lfdr.de>; Wed, 20 May 2026 06:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19FB367B95;
	Wed, 20 May 2026 06:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SGaWx3ub"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37315299937
	for <cgroups@vger.kernel.org>; Wed, 20 May 2026 06:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779257251; cv=none; b=GYgaeyFgshj1EFFVtsAj19gB3IL4owvpUjmOC7hy4pX2E0ymxJGNqst2gzabVSPwhrnJ6WHdRsebC/teRb8KWPxsmpkno3LgoFb0ooKsDcO1CPPKJGrpvW6YHJYYUtkZbULmWSPuKwQi73S28TOkemr3ff/Xa8M/oamlt0BGsRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779257251; c=relaxed/simple;
	bh=dGP8zb2hZsokw/Lvq1510DQXDH5w0sqc0ISBnrn2reQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=SiWDwOA95YAdgCTwTFGBBGovodS1Ga0w5JZcYDsMXPd0VOGH/yZGda/JXJqYXKTAS6xsj+FNyoHXIF8x8s4jiF7E1Nb/v8Tl/KyLVuE+ORUchQ2Oxzmj9QML0Vr2ebx87++mEgFTxWCoi2AIAu8YpzGPt9RdBPlzE2ThWqtE0YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SGaWx3ub; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-304106b1204so942665eec.0
        for <cgroups@vger.kernel.org>; Tue, 19 May 2026 23:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779257249; x=1779862049; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FkbUxOw9XQFqUtX2Z9eJ32TNe+t+n97l8FjGhNB6Arg=;
        b=SGaWx3ubBahIIHQg7gr4gGLxUrcZDYmq2TF0JW+Nc7Xb6f5j838APuxmD+yyiMZyU4
         3BhzHKz0wAgqp1dGVKv2QAu2Z7MPBSVSwnxIpwJDUuUmVjV0mIszhlHWhuy2Cz/81L6Z
         fAqYtk9mJo070qTFFMdXS4c6oSFw+Y7zNVmkQJF1J88/x+xufm4ks+m2FvtOnbkt0F8i
         N0tmXHAQYX7vhhbbK9X/d+U28PFWU9SzBYnGcYVCcx4a53PEINI+fA46E7xlfyYkn0Pe
         ePLJPb+A1krm0OVYPM3L9y0uJXnzvPYf0DvVzOUtf65AdWY5Bnl4925gbkhBuDStEQy8
         RhpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779257249; x=1779862049;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FkbUxOw9XQFqUtX2Z9eJ32TNe+t+n97l8FjGhNB6Arg=;
        b=Y7b8ml9i+zBbzFw4yeN7jOQCFa71D+1JPY9aZY/MB3/BDesPkNF7T2cB4TC+8jztUt
         Zxlc5plvpB3nKCIYUlkn4uN0SQuPoghi479Dp6dwlept2q+P2PhFw3c6SPLvbTzYnHLr
         m1iP2aNctxPyrBKtIW5IXls+liQrhHTvkcjInTTGJOk+nvqRkn7JallY+oLXZWKh/jjd
         XW6TiU0TVlF9D3m/JdHTZh62RgSmop8JplIHuhERjVXNE76xVqDTxTH/g/5ZbFDUH63Q
         7LMgrq3B6hiul1xhrg9fbiRuqYYIkkVUZBpyoqJP5azgUEpgTJmCRcLTkRtQieWASN/i
         sdKA==
X-Gm-Message-State: AOJu0YwE4di8qYihTSGsdwuAF4Qy7ukGe+YK4/3PPGFQolYq+l/XrjFl
	GI061SF14aiG50wvaTU1bYjlmtK3TxRX6UF3lJX6ugOITlDdEOVla2LN
X-Gm-Gg: Acq92OHp0r0EYv/xkhoFgrUWGaaJKXyXoa0KkXvQ0qLGmP/lWygYp4M58j8wZ5WXKG5
	qdjNrexRvDhuEldpijC4DuskLHRtjHQ8YxEVEy947LstqfezY+EQogE55XTBDxmHYL8GgFQSDxh
	POz0xblGtMh8gCUuiDIcABArscZF/+ZKIc4KTk7Ftfa+d9bV+RPsLkT4ck0VFLH8vBs1vTf+6Ug
	suOyqXov+j2S3xHoJGLMu3SseMcetRx5c2qqpC/3yTPdg3sLNoxhryTIgBSjS8YskJJ0QIk3qeo
	o74CbJeS0CjlSn+9CNJ02Kr+K8bPRq7Gic+yFn89wrM5J6rNFx5q714g9QoxL5xFO25IUhYcBwO
	JEAdYszIe/is6ono8hB9feLiNcXX+MhfJ7DovKPNZeA58H0ULuzA7S981PtL9Pxgemom7m8JHbQ
	AtfvO5LYtFvIpGmKYUC0FwbuTymmWJlww+1udo7xGdcQ==
X-Received: by 2002:a05:7301:600c:b0:2dd:6937:79d5 with SMTP id 5a478bee46e88-303982b788dmr10220464eec.8.1779257249365;
        Tue, 19 May 2026 23:07:29 -0700 (PDT)
Received: from wujing.localdomain ([74.48.213.230])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30294500a97sm20885330eec.9.2026.05.19.23.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 23:07:29 -0700 (PDT)
From: Qiliang Yuan <realwujing@gmail.com>
Date: Wed, 20 May 2026 14:07:20 +0800
Subject: [PATCH] cgroup/dmem: implement dmem.high soft limit and throttling
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260520-feature-dmem-high-v1-1-97ca0cb7f95a@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MTQqAIBBA4avErBvIfiy7SrSQnHIWVmhFIN49a
 fkt3osQyDMFGIsInh4OfOwZoixgsXrfCNlkQ13VsuqEwpX0dXtC48ih5c2ikEr1oh3M0gyQu9P
 Tyu//nOaUPnDDIj9jAAAA
X-Change-ID: 20260519-feature-dmem-high-16997148dc38
To: Maarten Lankhorst <dev@lankhorst.se>, 
 Maxime Ripard <mripard@kernel.org>, Natalie Vock <natalie.vock@gmx.de>, 
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Qiliang Yuan <realwujing@gmail.com>
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16112-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lankhorst.se,kernel.org,gmx.de,cmpxchg.org,suse.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[realwujing@gmail.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lankhorst.se:email,suse.com:email,gmx.de:email]
X-Rspamd-Queue-Id: 981A6587FE3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Introduce the "high" soft limit for the dmem cgroup v2 controller.
When a cgroup's device memory usage exceeds its high limit, tasks
belonging to that cgroup are throttled by being forced into a sleep
before returning to user space, instead of being failed outright
as with the "max" limit.

Key changes:
- Add high counter configuration to dmem_cgroup_pool.
- Add over-high check in the try_charge path and set TIF_NOTIFY_RESUME.
- Inject the dmem throttling handler into resume_user_mode_work.
- Implement the handler to perform a 100ms interruptible sleep for
  over-limit tasks.

This mechanism provides smoother over-subscription support for device
memory resources.

Signed-off-by: Qiliang Yuan <realwujing@gmail.com>
---
This series introduces the "high" soft limit and associated task
throttling mechanism to the dmem cgroup v2 controller.

The device memory (VRAM) management currently only supports hard limits
(max), which leads to immediate allocation failures when reached. This
can be disruptive for GPU-bound AI workloads. By introducing a soft
limit, we allow cgroups to exceed their quota temporarily while
applying backpressure via task throttling before the process returns
to user space.

The mechanism is inspired by the memory cgroup's high limit:
- When usage > high, the task is marked with TIF_NOTIFY_RESUME.
- Upon returning to user space, it triggers a 100ms sleep.
- This provides a smoother over-subscription model for GPU resources.

Qiliang Yuan (1):

cgroup/dmem: implement dmem.high soft limit and throttling
---
To: Maarten Lankhorst <dev@lankhorst.se>
To: Maxime Ripard <mripard@kernel.org>
To: Natalie Vock <natalie.vock@gmx.de>
To: Tejun Heo <tj@kernel.org>
To: Johannes Weiner <hannes@cmpxchg.org>
To: Michal Koutný <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
---
 include/linux/cgroup_dmem.h      | 10 +++++++
 include/linux/resume_user_mode.h |  2 ++
 kernel/cgroup/dmem.c             | 60 +++++++++++++++++++++++++++++++++++++++-
 3 files changed, 71 insertions(+), 1 deletion(-)

diff --git a/include/linux/cgroup_dmem.h b/include/linux/cgroup_dmem.h
index dd4869f1d736e..d58972de7c910 100644
--- a/include/linux/cgroup_dmem.h
+++ b/include/linux/cgroup_dmem.h
@@ -21,6 +21,13 @@ int dmem_cgroup_try_charge(struct dmem_cgroup_region *region, u64 size,
 			   struct dmem_cgroup_pool_state **ret_pool,
 			   struct dmem_cgroup_pool_state **ret_limit_pool);
 void dmem_cgroup_uncharge(struct dmem_cgroup_pool_state *pool, u64 size);
+void __dmem_cgroup_handle_over_high(void);
+
+static inline void dmem_cgroup_handle_over_high(void)
+{
+	__dmem_cgroup_handle_over_high();
+}
+
 bool dmem_cgroup_state_evict_valuable(struct dmem_cgroup_pool_state *limit_pool,
 				      struct dmem_cgroup_pool_state *test_pool,
 				      bool ignore_low, bool *ret_hit_low);
@@ -51,6 +58,9 @@ static inline int dmem_cgroup_try_charge(struct dmem_cgroup_region *region, u64
 static inline void dmem_cgroup_uncharge(struct dmem_cgroup_pool_state *pool, u64 size)
 { }
 
+static inline void dmem_cgroup_handle_over_high(void)
+{ }
+
 static inline
 bool dmem_cgroup_state_evict_valuable(struct dmem_cgroup_pool_state *limit_pool,
 				      struct dmem_cgroup_pool_state *test_pool,
diff --git a/include/linux/resume_user_mode.h b/include/linux/resume_user_mode.h
index bf92227c78d0d..afcab20998c41 100644
--- a/include/linux/resume_user_mode.h
+++ b/include/linux/resume_user_mode.h
@@ -8,6 +8,7 @@
 #include <linux/memcontrol.h>
 #include <linux/rseq.h>
 #include <linux/blk-cgroup.h>
+#include <linux/cgroup_dmem.h>
 
 /**
  * set_notify_resume - cause resume_user_mode_work() to be called
@@ -58,6 +59,7 @@ static inline void resume_user_mode_work(struct pt_regs *regs)
 
 	mem_cgroup_handle_over_high(GFP_KERNEL);
 	blkcg_maybe_throttle_current();
+	dmem_cgroup_handle_over_high();
 
 	rseq_handle_slowpath(regs);
 }
diff --git a/kernel/cgroup/dmem.c b/kernel/cgroup/dmem.c
index 4753a67d0f0f2..f77c692b887b1 100644
--- a/kernel/cgroup/dmem.c
+++ b/kernel/cgroup/dmem.c
@@ -15,6 +15,7 @@
 #include <linux/page_counter.h>
 #include <linux/parser.h>
 #include <linux/refcount.h>
+#include <linux/resume_user_mode.h>
 #include <linux/rculist.h>
 #include <linux/slab.h>
 
@@ -156,6 +157,12 @@ set_resource_low(struct dmem_cgroup_pool_state *pool, u64 val)
 	page_counter_set_low(&pool->cnt, val);
 }
 
+static void
+set_resource_high(struct dmem_cgroup_pool_state *pool, u64 val)
+{
+	page_counter_set_high(&pool->cnt, val);
+}
+
 static void
 set_resource_max(struct dmem_cgroup_pool_state *pool, u64 val)
 {
@@ -167,6 +174,11 @@ static u64 get_resource_low(struct dmem_cgroup_pool_state *pool)
 	return pool ? READ_ONCE(pool->cnt.low) : 0;
 }
 
+static u64 get_resource_high(struct dmem_cgroup_pool_state *pool)
+{
+	return pool ? READ_ONCE(pool->cnt.high) : 0;
+}
+
 static u64 get_resource_min(struct dmem_cgroup_pool_state *pool)
 {
 	return pool ? READ_ONCE(pool->cnt.min) : 0;
@@ -186,6 +198,7 @@ static void reset_all_resource_limits(struct dmem_cgroup_pool_state *rpool)
 {
 	set_resource_min(rpool, 0);
 	set_resource_low(rpool, 0);
+	set_resource_high(rpool, PAGE_COUNTER_MAX);
 	set_resource_max(rpool, PAGE_COUNTER_MAX);
 }
 
@@ -685,6 +698,9 @@ int dmem_cgroup_try_charge(struct dmem_cgroup_region *region, u64 size,
 		goto err;
 	}
 
+	if (page_counter_read(&pool->cnt) > READ_ONCE(pool->cnt.high))
+		set_notify_resume(current);
+
 	/* On success, reference from get_current_dmemcs is transferred to *ret_pool */
 	*ret_pool = pool;
 	return 0;
@@ -835,13 +851,24 @@ static ssize_t dmem_cgroup_region_low_write(struct kernfs_open_file *of,
 	return dmemcg_limit_write(of, buf, nbytes, off, set_resource_low);
 }
 
+static int dmem_cgroup_region_high_show(struct seq_file *sf, void *v)
+{
+	return dmemcg_limit_show(sf, v, get_resource_high);
+}
+
+static ssize_t dmem_cgroup_region_high_write(struct kernfs_open_file *of,
+					  char *buf, size_t nbytes, loff_t off)
+{
+	return dmemcg_limit_write(of, buf, nbytes, off, set_resource_high);
+}
+
 static int dmem_cgroup_region_max_show(struct seq_file *sf, void *v)
 {
 	return dmemcg_limit_show(sf, v, get_resource_max);
 }
 
 static ssize_t dmem_cgroup_region_max_write(struct kernfs_open_file *of,
-				      char *buf, size_t nbytes, loff_t off)
+					  char *buf, size_t nbytes, loff_t off)
 {
 	return dmemcg_limit_write(of, buf, nbytes, off, set_resource_max);
 }
@@ -868,6 +895,12 @@ static struct cftype files[] = {
 		.seq_show = dmem_cgroup_region_low_show,
 		.flags = CFTYPE_NOT_ON_ROOT,
 	},
+	{
+		.name = "high",
+		.write = dmem_cgroup_region_high_write,
+		.seq_show = dmem_cgroup_region_high_show,
+		.flags = CFTYPE_NOT_ON_ROOT,
+	},
 	{
 		.name = "max",
 		.write = dmem_cgroup_region_max_write,
@@ -877,6 +910,31 @@ static struct cftype files[] = {
 	{ } /* Zero entry terminates. */
 };
 
+void __dmem_cgroup_handle_over_high(void)
+{
+	struct dmemcg_state *dmemcs;
+	struct dmem_cgroup_pool_state *pool;
+
+	dmemcs = css_to_dmemcs(task_get_css(current, dmem_cgrp_id));
+	if (!dmemcs)
+		return;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(pool, &dmemcs->pools, css_node) {
+		unsigned long usage, high;
+
+		usage = page_counter_read(&pool->cnt);
+		high = READ_ONCE(pool->cnt.high);
+
+		if (usage > high)
+			schedule_timeout_killable(HZ / 10);
+	}
+	rcu_read_unlock();
+
+	css_put(&dmemcs->css);
+}
+EXPORT_SYMBOL_GPL(__dmem_cgroup_handle_over_high);
+
 struct cgroup_subsys dmem_cgrp_subsys = {
 	.css_alloc	= dmemcs_alloc,
 	.css_free	= dmemcs_free,

---
base-commit: ab5fce87a778cb780a05984a2ca448f2b41aafbf
change-id: 20260519-feature-dmem-high-16997148dc38

Best regards,
-- 
Qiliang Yuan <realwujing@gmail.com>


