Return-Path: <cgroups+bounces-5506-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5543B9C30A7
	for <lists+cgroups@lfdr.de>; Sun, 10 Nov 2024 03:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 609541C20B84
	for <lists+cgroups@lfdr.de>; Sun, 10 Nov 2024 02:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF99145335;
	Sun, 10 Nov 2024 02:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZQ4UQOXh"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0E1148302
	for <cgroups@vger.kernel.org>; Sun, 10 Nov 2024 02:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731207077; cv=none; b=dj+zE3kBauTJru6SJh8t9hLo0y6lJi8RFMW+uu2CQAmb+Mz6HioDDnT8Uz+jlT06OmAlRFjPnja0ng9TKlrpJO/p/o1T/TSmrGzwRiB8P1Faf67/bhmvagA0UDFcGh8T2R4mBofkb7vYqs7KQnGub7Su9ViMzFe6hkJr5cIpvbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731207077; c=relaxed/simple;
	bh=C7F0hzSEvRCvJoaGfUa7jxx615Hn7j/4+kWTa1FsAmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YI3vkn+oZ0y2knFsmZIIM2IgSfsKsbb2wIYMRiTRy4NioRy2LTqOh5ch2ltzuNwvD7H+KHwnXdgPpyscuXWgG4kfMd7ezghPM6TyF/Zv2gKsuOKKR6xjByQ0HvAyXyKMC/0KEMJA/40xKzYEog9kGyFLssnh6O7+ayOpTJYPvks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZQ4UQOXh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731207074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mgT/glyX8PvJewj2/e81B/ji7YZiFdXrkaiYQgRzgk0=;
	b=ZQ4UQOXhUXeUDNFE5JO4dKwqZFwjoBSbur1XEOjZw00Px3MZ38U+fnhIKI4/X2/i72Q6NJ
	4lRjU9wy7U7OFfpDvvn1EBjBknDWk4qjqeDaYNz3QZprMYbOyUZFJDQxCv3F6YWRDCKDcx
	y4zKM4Z4Evv5CvSaDV9sZ6jfNQHGBJU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-56-XOcphakvOOW-wLlRePT7FA-1; Sat,
 09 Nov 2024 21:51:10 -0500
X-MC-Unique: XOcphakvOOW-wLlRePT7FA-1
X-Mimecast-MFC-AGG-ID: XOcphakvOOW-wLlRePT7FA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9841D19560AF;
	Sun, 10 Nov 2024 02:51:08 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.2.16.3])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DF98F300019E;
	Sun, 10 Nov 2024 02:51:06 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Juri Lelli <juri.lelli@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH 3/3] cgroup/cpuset: Further optimize code if CONFIG_CPUSETS_V1 not set
Date: Sat,  9 Nov 2024 21:50:23 -0500
Message-ID: <20241110025023.664487-4-longman@redhat.com>
In-Reply-To: <20241110025023.664487-1-longman@redhat.com>
References: <20241110025023.664487-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Currently the cpuset code uses group_subsys_on_dfl() to check if we
are running with cgroup v2. If CONFIG_CPUSETS_V1 isn't set, there is
really no need to do this check and we can optimize out some of the
unneeded v1 specific code paths. Introduce a new cpuset_v2() and use it
to replace the cgroup_subsys_on_dfl() check to further optimize the
code.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 39 +++++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 0d56a226c522..655396e75b58 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -293,6 +293,12 @@ static inline void dec_attach_in_progress(struct cpuset *cs)
 	mutex_unlock(&cpuset_mutex);
 }
 
+static inline bool cpuset_v2(void)
+{
+	return !IS_ENABLED(CONFIG_CPUSETS_V1) ||
+		cgroup_subsys_on_dfl(cpuset_cgrp_subsys);
+}
+
 /*
  * Cgroup v2 behavior is used on the "cpus" and "mems" control files when
  * on default hierarchy or when the cpuset_v2_mode flag is set by mounting
@@ -303,7 +309,7 @@ static inline void dec_attach_in_progress(struct cpuset *cs)
  */
 static inline bool is_in_v2_mode(void)
 {
-	return cgroup_subsys_on_dfl(cpuset_cgrp_subsys) ||
+	return cpuset_v2() ||
 	      (cpuset_cgrp_subsys.root->flags & CGRP_ROOT_CPUSET_V2_MODE);
 }
 
@@ -738,7 +744,7 @@ static int generate_sched_domains(cpumask_var_t **domains,
 	int nslot;		/* next empty doms[] struct cpumask slot */
 	struct cgroup_subsys_state *pos_css;
 	bool root_load_balance = is_sched_load_balance(&top_cpuset);
-	bool cgrpv2 = cgroup_subsys_on_dfl(cpuset_cgrp_subsys);
+	bool cgrpv2 = cpuset_v2();
 	int nslot_update;
 
 	doms = NULL;
@@ -1198,7 +1204,7 @@ static void reset_partition_data(struct cpuset *cs)
 {
 	struct cpuset *parent = parent_cs(cs);
 
-	if (!cgroup_subsys_on_dfl(cpuset_cgrp_subsys))
+	if (!cpuset_v2())
 		return;
 
 	lockdep_assert_held(&callback_lock);
@@ -2017,7 +2023,7 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
 		 */
 		if (!cp->partition_root_state && !force &&
 		    cpumask_equal(tmp->new_cpus, cp->effective_cpus) &&
-		    (!cgroup_subsys_on_dfl(cpuset_cgrp_subsys) ||
+		    (!cpuset_v2() ||
 		    (is_sched_load_balance(parent) == is_sched_load_balance(cp)))) {
 			pos_css = css_rightmost_descendant(pos_css);
 			continue;
@@ -2091,8 +2097,7 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
 		 * from parent if current cpuset isn't a valid partition root
 		 * and their load balance states differ.
 		 */
-		if (cgroup_subsys_on_dfl(cpuset_cgrp_subsys) &&
-		    !is_partition_valid(cp) &&
+		if (cpuset_v2() && !is_partition_valid(cp) &&
 		    (is_sched_load_balance(parent) != is_sched_load_balance(cp))) {
 			if (is_sched_load_balance(parent))
 				set_bit(CS_SCHED_LOAD_BALANCE, &cp->flags);
@@ -2108,8 +2113,7 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
 		 */
 		if (!cpumask_empty(cp->cpus_allowed) &&
 		    is_sched_load_balance(cp) &&
-		   (!cgroup_subsys_on_dfl(cpuset_cgrp_subsys) ||
-		    is_partition_valid(cp)))
+		   (!cpuset_v2() || is_partition_valid(cp)))
 			need_rebuild_sched_domains = true;
 
 		rcu_read_lock();
@@ -2246,7 +2250,7 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 
 	retval = validate_change(cs, trialcs);
 
-	if ((retval == -EINVAL) && cgroup_subsys_on_dfl(cpuset_cgrp_subsys)) {
+	if ((retval == -EINVAL) && cpuset_v2()) {
 		struct cgroup_subsys_state *css;
 		struct cpuset *cp;
 
@@ -2738,8 +2742,7 @@ int cpuset_update_flag(cpuset_flagbits_t bit, struct cpuset *cs,
 	spin_unlock_irq(&callback_lock);
 
 	if (!cpumask_empty(trialcs->cpus_allowed) && balance_flag_changed) {
-		if (!IS_ENABLED(CONFIG_CPUSETS_V1) ||
-		    cgroup_subsys_on_dfl(cpuset_cgrp_subsys))
+		if (cpuset_v2())
 			cpuset_force_rebuild();
 		else
 			rebuild_sched_domains_locked();
@@ -2925,8 +2928,7 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 		 * migration permission derives from hierarchy ownership in
 		 * cgroup_procs_write_permission()).
 		 */
-		if (!cgroup_subsys_on_dfl(cpuset_cgrp_subsys) ||
-		    (cpus_updated || mems_updated)) {
+		if (!cpuset_v2() || (cpus_updated || mems_updated)) {
 			ret = security_task_setscheduler(task);
 			if (ret)
 				goto out_unlock;
@@ -3040,8 +3042,7 @@ static void cpuset_attach(struct cgroup_taskset *tset)
 	 * in effective cpus and mems. In that case, we can optimize out
 	 * by skipping the task iteration and update.
 	 */
-	if (cgroup_subsys_on_dfl(cpuset_cgrp_subsys) &&
-	    !cpus_updated && !mems_updated) {
+	if (cpuset_v2() && !cpus_updated && !mems_updated) {
 		cpuset_attach_nodemask_to = cs->effective_mems;
 		goto out;
 	}
@@ -3391,7 +3392,7 @@ cpuset_css_alloc(struct cgroup_subsys_state *parent_css)
 	INIT_LIST_HEAD(&cs->remote_sibling);
 
 	/* Set CS_MEMORY_MIGRATE for default hierarchy */
-	if (cgroup_subsys_on_dfl(cpuset_cgrp_subsys))
+	if (cpuset_v2())
 		__set_bit(CS_MEMORY_MIGRATE, &cs->flags);
 
 	return &cs->css;
@@ -3418,8 +3419,7 @@ static int cpuset_css_online(struct cgroup_subsys_state *css)
 	/*
 	 * For v2, clear CS_SCHED_LOAD_BALANCE if parent is isolated
 	 */
-	if (cgroup_subsys_on_dfl(cpuset_cgrp_subsys) &&
-	    !is_sched_load_balance(parent))
+	if (cpuset_v2() && !is_sched_load_balance(parent))
 		clear_bit(CS_SCHED_LOAD_BALANCE, &cs->flags);
 
 	cpuset_inc();
@@ -3489,8 +3489,7 @@ static void cpuset_css_offline(struct cgroup_subsys_state *css)
 	if (is_partition_valid(cs))
 		update_prstate(cs, 0);
 
-	if (!cgroup_subsys_on_dfl(cpuset_cgrp_subsys) &&
-	    is_sched_load_balance(cs))
+	if (!cpuset_v2() && is_sched_load_balance(cs))
 		cpuset_update_flag(CS_SCHED_LOAD_BALANCE, cs, 0);
 
 	cpuset_dec();
-- 
2.47.0


