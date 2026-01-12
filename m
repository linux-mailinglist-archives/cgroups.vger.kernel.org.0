Return-Path: <cgroups+bounces-13060-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 323D2D10D60
	for <lists+cgroups@lfdr.de>; Mon, 12 Jan 2026 08:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 139643028D6F
	for <lists+cgroups@lfdr.de>; Mon, 12 Jan 2026 07:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A0632E68D;
	Mon, 12 Jan 2026 07:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="YCYYWbfE"
X-Original-To: cgroups@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB19732E72B;
	Mon, 12 Jan 2026 07:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768202410; cv=none; b=lswiIQt7WLtY9rv3nNd66LJmioCPOURkwwO+eHQBOcySgtoWiZjkTVJ0UUYT+dcciqXQaPKGQEWYNHS/2PVtkZasjuUwB4SiH54bCZVe2J86JXvkfbA/4VO6Or70EF7529y4yBbGtY1Svir4l7vY5GNop9KMN1GVhNKCizHbEvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768202410; c=relaxed/simple;
	bh=+eDzYP/LfsxOFeUuQWUeafx+EqO5hhR2zS9iHy2mbQg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZF3S4QaYBKnHLtC39awMJiI0P6Jfx4vTN5u72p6NENwXU3lLuaByO2NElqhbzhGz8XA6yJyfQ0DTPksznKrAlSI9c3oQGpCdse8becGUOWkFWXpa9ozUmgtCbsoTnIr1OVoke5uLSMyFMSSUsRPU2NFv6Ipr/qBFIL8oRNxJ7ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=YCYYWbfE; arc=none smtp.client-ip=220.197.31.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=pH
	NYFOcQM11YRJbnVQvxctU1eYf8uhkNNwR1233d158=; b=YCYYWbfEouXAPLBwbu
	bGQQkIVewQDr0IZAbNEP1WRuuG4wirnEb78dmdoHMOQ8kG2MlRtWKftOeP+Q26Or
	xKoKVJnecJpewEVRY8G6P4jxGz4V5ho6vKeKRC1S85UE7T5uo8tPUtgnfwhRkr6F
	ygZIN2YD9DGPe8hSKS09s1sNo=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3V+GDoGRpFy0rBQ--.62356S2;
	Mon, 12 Jan 2026 15:19:32 +0800 (CST)
From: Zhao Mengmeng <zhaomzhao@126.com>
To: longman@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: zhaomengmeng@kylinos.cn,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [cgroup/for-next PATCH RESEND] cpuset: replace direct lockdep_assert_held() with lockdep_assert_cpuset_lock_held()
Date: Mon, 12 Jan 2026 15:19:27 +0800
Message-ID: <20260112071927.211682-1-zhaomzhao@126.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3V+GDoGRpFy0rBQ--.62356S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWw4ktry8GrWkJw17JFWxCrg_yoW5AFy3pF
	1Uur4xtrW0qF18ua1Dta9rXr1Igwn5GFW5JF45K3yrAF13XFW8ZFy8XFnIyF43WryxGFs3
	XFnFqw42g3ZrCa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07ULo7_UUUUU=
X-CM-SenderInfo: 52kd0zp2kd0qqrswhudrp/xtbBqwS8NGlkoITEIgAA3o

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


