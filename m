Return-Path: <cgroups+bounces-13059-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0487AD10CBD
	for <lists+cgroups@lfdr.de>; Mon, 12 Jan 2026 08:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 050AD30080CF
	for <lists+cgroups@lfdr.de>; Mon, 12 Jan 2026 07:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4382531ED8A;
	Mon, 12 Jan 2026 07:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="O/vABpDb"
X-Original-To: cgroups@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F44B30BF68;
	Mon, 12 Jan 2026 07:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768201543; cv=none; b=f5Pmezg4SE9c2WgquP0HiQRa4YTSj9C5Yo2XndIZz79HxaX0VrA8LIPzZcInSBT7SIDJaBW1SHjPTGK3SzpDj0PpRascf78EYwlUBQmFwatex4ShcSXQsjCr+ssNWRi1z9Dn0+uXl4NnraY+QKmzpapHi9cTfy3mC9E5OSbGu1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768201543; c=relaxed/simple;
	bh=+eDzYP/LfsxOFeUuQWUeafx+EqO5hhR2zS9iHy2mbQg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VpXo3Aq5UY2IXR8Rzgf58v6Oc2Gw7UIlXMHgUTE6DlwXIOe+7/AgxKhyXxK+s9KPgns0BVUfOUhvbgvhDL1Dxlscw8eoooenLHvFfVvUuGmq0R1CRMk1QL5+G417oALi+1HEN4xH9M6Z0msJaTM5zv6o9dibgKfT4Z9SgPeGv+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=O/vABpDb; arc=none smtp.client-ip=220.197.31.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=pH
	NYFOcQM11YRJbnVQvxctU1eYf8uhkNNwR1233d158=; b=O/vABpDbRCz97xeOK2
	8df7H1B7QEoxmNKrUt4DJULtanA0iMmnSz7gtf8WlZdviL24SWBjWDPjZKjsjvYi
	jdGG6h/5Hjld7abfbeZ7a5tGPYyU7pGrucQaPAUf1qJU3WL1QCDeF4owQSLSGymT
	pRCeSy/fcp4ugqQiiMyb7aZQs=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD3fz0XnWRpMmFLBg--.3040S2;
	Mon, 12 Jan 2026 15:04:56 +0800 (CST)
From: Zhao Mengmeng <zhaomzhao@126.com>
To: longman@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: zhaomengmeng@kylinos.cn,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] cpuset: replace direct lockdep_assert_held() with lockdep_assert_cpuset_lock_held()
Date: Mon, 12 Jan 2026 15:04:53 +0800
Message-ID: <20260112070453.203370-1-zhaomzhao@126.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3fz0XnWRpMmFLBg--.3040S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWw4ktry8GrWkJw17JFWxCrg_yoW5AFy3pF
	1Uur4xtrW0qF18ua1Dta9rXr1Igwn5GFW5JF45K3yrAF13XFW8ZFy8XFnIyF43WryxGFs3
	XFnFqw42g3ZrCa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Ul0PDUUUUU=
X-CM-SenderInfo: 52kd0zp2kd0qqrswhudrp/xtbBlhjgWGlknRgy2gAA3W

From: Zhao Mengmeng <zhaomengmeng@kylinos.cn>

We already added lockdep_assert_cpuset_lock_held(), use this new function
to keep consistency.

Signed-off-by: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
---
 kernel/cgroup/cpuset.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 7ac7665f0bb6..44848e43fc8a 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -325,7 +325,7 @@ static inline void check_insane_mems_config(nodemask_t *nodes)
  */
 static inline void dec_attach_in_progress_locked(struct cpuset *cs)
 {
-	lockdep_assert_held(&cpuset_mutex);
+	lockdep_assert_cpuset_lock_held();
 
 	cs->attach_in_progress--;
 	if (!cs->attach_in_progress)
@@ -361,7 +361,7 @@ static inline bool is_in_v2_mode(void)
 
 static inline bool cpuset_is_populated(struct cpuset *cs)
 {
-	lockdep_assert_held(&cpuset_mutex);
+	lockdep_assert_cpuset_lock_held();
 
 	/* Cpusets in the process of attaching should be considered as populated */
 	return cgroup_is_populated(cs->css.cgroup) ||
@@ -913,7 +913,7 @@ void dl_rebuild_rd_accounting(void)
 	int cpu;
 	u64 cookie = ++dl_cookie;
 
-	lockdep_assert_held(&cpuset_mutex);
+	lockdep_assert_cpuset_lock_held();
 	lockdep_assert_cpus_held();
 	lockdep_assert_held(&sched_domains_mutex);
 
@@ -964,7 +964,7 @@ void rebuild_sched_domains_locked(void)
 	int i;
 
 	lockdep_assert_cpus_held();
-	lockdep_assert_held(&cpuset_mutex);
+	lockdep_assert_cpuset_lock_held();
 	force_sd_rebuild = false;
 
 	/* Generate domain masks and attrs */
@@ -1660,7 +1660,7 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
 	int parent_prs = parent->partition_root_state;
 	bool nocpu;
 
-	lockdep_assert_held(&cpuset_mutex);
+	lockdep_assert_cpuset_lock_held();
 	WARN_ON_ONCE(is_remote_partition(cs));	/* For local partition only */
 
 	/*
@@ -2232,7 +2232,7 @@ static void update_sibling_cpumasks(struct cpuset *parent, struct cpuset *cs,
 	struct cpuset *sibling;
 	struct cgroup_subsys_state *pos_css;
 
-	lockdep_assert_held(&cpuset_mutex);
+	lockdep_assert_cpuset_lock_held();
 
 	/*
 	 * Check all its siblings and call update_cpumasks_hier()
@@ -3103,7 +3103,7 @@ static nodemask_t cpuset_attach_nodemask_to;
 
 static void cpuset_attach_task(struct cpuset *cs, struct task_struct *task)
 {
-	lockdep_assert_held(&cpuset_mutex);
+	lockdep_assert_cpuset_lock_held();
 
 	if (cs != &top_cpuset)
 		guarantee_active_cpus(task, cpus_attach);
@@ -4029,7 +4029,7 @@ static void __cpuset_cpus_allowed_locked(struct task_struct *tsk, struct cpumask
  */
 void cpuset_cpus_allowed_locked(struct task_struct *tsk, struct cpumask *pmask)
 {
-	lockdep_assert_held(&cpuset_mutex);
+	lockdep_assert_cpuset_lock_held();
 	__cpuset_cpus_allowed_locked(tsk, pmask);
 }
 
-- 
2.43.0


