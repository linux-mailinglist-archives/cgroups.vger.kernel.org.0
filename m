Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F23FE3FA201
	for <lists+cgroups@lfdr.de>; Sat, 28 Aug 2021 02:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232693AbhH1ADy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 27 Aug 2021 20:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232707AbhH1ADs (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 27 Aug 2021 20:03:48 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5ADC06179A
        for <cgroups@vger.kernel.org>; Fri, 27 Aug 2021 17:02:58 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id 18so6987186pfh.9
        for <cgroups@vger.kernel.org>; Fri, 27 Aug 2021 17:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vpHRD/GDXCtXf6T/R+VbfrDOl4cnu8hdcSMOeGwnnmk=;
        b=AVx/g4V6fRSiYb5+aCUHZ+vvxQpnkLRjlTpl7etiotwvxzABQ7KoFK4acqYfMxpiNQ
         5eCZy4qTlgADhnUkwzr4MoogCRVr/zH5sQ2xmZGhTzW1TkuISRoeOuWocUplwnJFXoLQ
         x5D2WdKAJouPT7KPod3M9eUkF+ETxeQ91jdnw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vpHRD/GDXCtXf6T/R+VbfrDOl4cnu8hdcSMOeGwnnmk=;
        b=LM/17DNvDasrN9CVURu/K7UD0qX26I4/ScTgJ5uDdnhz4Jnc3LxzOyU31mffiCB6ry
         IiH0+Cm3yKKUSBYhHFRfXwQJeskIhyEW4Nfo7BQYc0ZxEEADhWXg425BI8wDEiDRyPxE
         wdvQIbEsRwHWA+Q8BpXLdTDvr8GhZqrtaUz0cHH9haSnNyAOwbuG31poxYYv8pRppYky
         VAM5Wv3i1aP8c8aKIrDZiAQBw+LHU72Cz+Cywn96KvXszDWzG64fjgJJ5caeprCbz4Hm
         iBnMHIEIWFk5QU/ZmXOmiEKLet/MwLS4Yb+6OiHYwBq6BDP/1JhWVVz9FeiPmx377B5h
         bXVA==
X-Gm-Message-State: AOAM533t1eZa/tldnWL9BlIYTP+JyIsoQ3CyNSIhdpn9HRFk5jDz3LBM
        PKC03Ecxas7Nx47ZqyrLHMRTUQ==
X-Google-Smtp-Source: ABdhPJx0Nkoil6Eq3hwUY2XNreZKWHup+/K9Or0Gjs+lkadYQjDQK7Zpttu4uPwhV9lWa+YqLolpSA==
X-Received: by 2002:a63:cf41:: with SMTP id b1mr9930209pgj.407.1630108977982;
        Fri, 27 Aug 2021 17:02:57 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g6sm7149077pjs.11.2021.08.27.17.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 17:02:57 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v3] cgroup: Avoid compiler warnings with no subsystems
Date:   Fri, 27 Aug 2021 17:02:55 -0700
Message-Id: <20210828000255.3213497-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5181; h=from:subject; bh=wfnValxKLcACBeIlJMD51jipqZPz6JJchrYHO4kvj0I=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhKX0uxRBPCEWXPaLksSSzYiRg+n0CdzY1PINGJ8SW P1zYi2CJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYSl9LgAKCRCJcvTf3G3AJl1dD/ 455E8QbUu9CfXqJUHZOvqlHmjm22DvsSzSW1FWeWAI7It4PMgHxUTiLfg0FJkIsgeMBOeAKcV/jcRd 3Nh9uyToj0AeRctJQpUXvdKkV+7L331/48X1VB6SqggfDjjD1jQ+y49UuEBfBau7uNL41eSUSn7t4p ex6wcBQEiP4HY32Yg4Zn9BhNtO2Xjt/bZbF62hAuQ5HNQOwbs6woKWMD4g4cP41/NdvIYGIw6fssOl 0yYheNhN8ZVr+dqnBuB41D+R0Pu85zOCvvKFEz4NKRjTbSiYrInn+2AXE8NNg9QJ07SxNl1D7UJufG 8W1BvYjery34OinE/USvhcJjL52tcijrogxCnuRsz5CactotX8+TRYGnTiVs86dAs2K8f/YZImyoAS TiODY7y/7G8aaik3UxNr6beDSIyP2c8AJZuZxdYllDlYSzywQxJvL5kTROhtBvdEycw0A6TgxUnbvk LaWk5PUi9+pFt09hfomWW2kyDYzVfE0YV9Etr5VltjaVm8r0F9cAm0psYiNKdDY+ZReYAJG5V+CCUm IqBc2FBj7tIWRNMdSYARi/DMwqa8eZrQhxWBlCbbj5d/ta4Y5y8IscSte3LLB2nLPilxWDMEffP+2z HyNBhjySSGyqA0VEsEoHDFctzEdCNI2nNULdiqaGCH/5VelsV8CQi2Z3NUVg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

As done before in commit cb4a31675270 ("cgroup: use bitmask to filter
for_each_subsys"), avoid compiler warnings for the pathological case of
having no subsystems (i.e. CGROUP_SUBSYS_COUNT == 0). This condition is
hit for the arm multi_v7_defconfig config under -Wzero-length-bounds:

In file included from ./arch/arm/include/generated/asm/rwonce.h:1,
                 from include/linux/compiler.h:264,
                 from include/uapi/linux/swab.h:6,
                 from include/linux/swab.h:5,
                 from arch/arm/include/asm/opcodes.h:86,
                 from arch/arm/include/asm/bug.h:7,
                 from include/linux/bug.h:5,
                 from include/linux/thread_info.h:13,
                 from include/asm-generic/current.h:5,
                 from ./arch/arm/include/generated/asm/current.h:1,
                 from include/linux/sched.h:12,
                 from include/linux/cgroup.h:12,
                 from kernel/cgroup/cgroup-internal.h:5,
                 from kernel/cgroup/cgroup.c:31:
kernel/cgroup/cgroup.c: In function 'of_css':
kernel/cgroup/cgroup.c:651:42: warning: array subscript '<unknown>' is outside the bounds of an
interior zero-length array 'struct cgroup_subsys_state *[0]' [-Wzero-length-bounds]
  651 |   return rcu_dereference_raw(cgrp->subsys[cft->ss->id]);

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Tejun Heo <tj@kernel.org>
Cc: Zefan Li <lizefan.x@bytedance.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: cgroups@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v3:
- encapsulate test in a macro with a big comment (tj)
v2: https://lore.kernel.org/lkml/20210827150424.2729274-1-keescook@chromium.org
v1: https://lore.kernel.org/lkml/20210827034741.2214318-1-keescook@chromium.org
---
 kernel/cgroup/cgroup.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 3a0161c21b6b..b320cace5342 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -67,6 +67,14 @@
 /* let's not notify more than 100 times per second */
 #define CGROUP_FILE_NOTIFY_MIN_INTV	DIV_ROUND_UP(HZ, 100)
 
+/*
+ * To avoid confusing the compiler (and generating warnings) with code
+ * that attempts to access what would be a 0-element array (i.e. sized
+ * to a potentially empty array when CGROUP_SUBSYS_COUNT == 0), this
+ * constant expression can be added.
+ */
+#define CGROUP_HAS_SUBSYS_CONFIG	(CGROUP_SUBSYS_COUNT > 0)
+
 /*
  * cgroup_mutex is the master lock.  Any modification to cgroup or its
  * hierarchy must be performed while holding it.
@@ -248,7 +256,7 @@ static int cgroup_addrm_files(struct cgroup_subsys_state *css,
  */
 bool cgroup_ssid_enabled(int ssid)
 {
-	if (CGROUP_SUBSYS_COUNT == 0)
+	if (!CGROUP_HAS_SUBSYS_CONFIG)
 		return false;
 
 	return static_key_enabled(cgroup_subsys_enabled_key[ssid]);
@@ -472,7 +480,7 @@ static u16 cgroup_ss_mask(struct cgroup *cgrp)
 static struct cgroup_subsys_state *cgroup_css(struct cgroup *cgrp,
 					      struct cgroup_subsys *ss)
 {
-	if (ss)
+	if (CGROUP_HAS_SUBSYS_CONFIG && ss)
 		return rcu_dereference_check(cgrp->subsys[ss->id],
 					lockdep_is_held(&cgroup_mutex));
 	else
@@ -550,6 +558,9 @@ struct cgroup_subsys_state *cgroup_e_css(struct cgroup *cgrp,
 {
 	struct cgroup_subsys_state *css;
 
+	if (!CGROUP_HAS_SUBSYS_CONFIG)
+		return NULL;
+
 	do {
 		css = cgroup_css(cgrp, ss);
 
@@ -577,6 +588,9 @@ struct cgroup_subsys_state *cgroup_get_e_css(struct cgroup *cgrp,
 {
 	struct cgroup_subsys_state *css;
 
+	if (!CGROUP_HAS_SUBSYS_CONFIG)
+		return NULL;
+
 	rcu_read_lock();
 
 	do {
@@ -647,7 +661,7 @@ struct cgroup_subsys_state *of_css(struct kernfs_open_file *of)
 	 * the matching css from the cgroup's subsys table is guaranteed to
 	 * be and stay valid until the enclosing operation is complete.
 	 */
-	if (cft->ss)
+	if (CGROUP_HAS_SUBSYS_CONFIG && cft->ss)
 		return rcu_dereference_raw(cgrp->subsys[cft->ss->id]);
 	else
 		return &cgrp->self;
@@ -695,7 +709,7 @@ EXPORT_SYMBOL_GPL(of_css);
  */
 #define do_each_subsys_mask(ss, ssid, ss_mask) do {			\
 	unsigned long __ss_mask = (ss_mask);				\
-	if (!CGROUP_SUBSYS_COUNT) { /* to avoid spurious gcc warning */	\
+	if (!CGROUP_HAS_SUBSYS_CONFIG) {					\
 		(ssid) = 0;						\
 		break;							\
 	}								\
@@ -2373,7 +2387,7 @@ struct task_struct *cgroup_taskset_next(struct cgroup_taskset *tset,
 	struct css_set *cset = tset->cur_cset;
 	struct task_struct *task = tset->cur_task;
 
-	while (&cset->mg_node != tset->csets) {
+	while (CGROUP_HAS_SUBSYS_CONFIG && &cset->mg_node != tset->csets) {
 		if (!task)
 			task = list_first_entry(&cset->mg_tasks,
 						struct task_struct, cg_list);
@@ -4644,7 +4658,7 @@ void css_task_iter_start(struct cgroup_subsys_state *css, unsigned int flags,
 	it->ss = css->ss;
 	it->flags = flags;
 
-	if (it->ss)
+	if (CGROUP_HAS_SUBSYS_CONFIG && it->ss)
 		it->cset_pos = &css->cgroup->e_csets[css->ss->id];
 	else
 		it->cset_pos = &css->cgroup->cset_links;
-- 
2.30.2

