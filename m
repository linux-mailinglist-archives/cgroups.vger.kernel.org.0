Return-Path: <cgroups+bounces-7256-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD074A75CCC
	for <lists+cgroups@lfdr.de>; Sun, 30 Mar 2025 23:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3F623A9081
	for <lists+cgroups@lfdr.de>; Sun, 30 Mar 2025 21:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43891DF248;
	Sun, 30 Mar 2025 21:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UQBfEads"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046F6158DD8
	for <cgroups@vger.kernel.org>; Sun, 30 Mar 2025 21:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743371630; cv=none; b=rziDuJJyoHQuMj7fxtIh6CZFYHB+5jStvSnZxuLEtWJC6Nkgj+ie90JQv2MZ7LagQlxEUBqmQi/KIPplBFxcjUG+S3/aUfc6cZ5Kd8med+2IPHV1g+ceoRID/lM5fUxRi1eaVnLDOyEQWWMyGRumb8txaP5UjtLyoqXXSf/mg6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743371630; c=relaxed/simple;
	bh=Ox8I+KsHJM/Hp9i+72vOxpoGY/J+Vg/IxtAIFoY2xws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ViWzcVsijJZKOHWawImzjL6jSSFbwkr+73SnCKz88ISdvbQfkDFWDepTbhulP63xQu18+aWDXeyXLFexidn8JH6IelB2EQRvkVoY5sjXVmoSbTWE2IiIIJJCZ3wr+MPwT4IhjVkV4FTNrDP5uw6rNWL1jx5p9PZyh+Jey1I5+Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UQBfEads; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743371627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vw65CPhHbDV9z4RzImsAKCyoHA3C3OtcQYbmcYf66vQ=;
	b=UQBfEads9Vyq2mNBjGjT9Lshpix6BLIEEmV6xFJ0F5n0Dj9hznSWd39WEYBXm3xuHB4l4U
	1K5dYbpnUHgJS4HSc6pCzgg4U1x44vh2CvRoB/pTLRr0c3VcAeT5jGgVWm05fcRAV8bK8r
	3kNvNLdJvDTZERN0R+HCmUZDZVtc3WM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-447-K47zeyw9OzKpuPV2LR1woQ-1; Sun,
 30 Mar 2025 17:53:44 -0400
X-MC-Unique: K47zeyw9OzKpuPV2LR1woQ-1
X-Mimecast-MFC-AGG-ID: K47zeyw9OzKpuPV2LR1woQ_1743371623
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D1AB41800349;
	Sun, 30 Mar 2025 21:53:42 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.64.34])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1BC9D180175A;
	Sun, 30 Mar 2025 21:53:40 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Shuah Khan <shuah@kernel.org>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Waiman Long <longman@redhat.com>
Subject: [PATCH 01/10] cgroup/cpuset: Fix race between newly created partition and dying one
Date: Sun, 30 Mar 2025 17:52:39 -0400
Message-ID: <20250330215248.3620801-2-longman@redhat.com>
In-Reply-To: <20250330215248.3620801-1-longman@redhat.com>
References: <20250330215248.3620801-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

There is a possible race between removing a cgroup diectory that is
a partition root and the creation of a new partition.  The partition
to be removed can be dying but still online, it doesn't not currently
participate in checking for exclusive CPUs conflict, but the exclusive
CPUs are still there in subpartitions_cpus and isolated_cpus. These
two cpumasks are global states that affect the operation of cpuset
partitions. The exclusive CPUs in dying cpusets will only be removed
when cpuset_css_offline() function is called after an RCU delay.

As a result, it is possible that a new partition can be created with
exclusive CPUs that overlap with those of a dying one. When that dying
partition is finally offlined, it removes those overlapping exclusive
CPUs from subpartitions_cpus and maybe isolated_cpus resulting in an
incorrect CPU configuration.

This bug was found when a warning was triggered in
remote_partition_disable() during testing because the subpartitions_cpus
mask was empty.

One possible way to fix this is to iterate the dying cpusets as well and
avoid using the exclusive CPUs in those dying cpusets. However, this
can still cause random partition creation failures or other anomalies
due to racing. A better way to fix this race is to reset the partition
state at the moment when a cpuset is being killed.

Introduce a new css_killed() CSS function pointer and call it, if
defined, before setting CSS_DYING flag in kill_css(). Also update the
css_is_dying() helper to use the CSS_DYING flag introduced by commit
33c35aa48178 ("cgroup: Prevent kill_css() from being called more than
once") for proper synchronization.

Add a new cpuset_css_killed() function to reset the partition state of
a valid partition root if it is being killed.

Fixes: ee8dde0cd2ce ("cpuset: Add new v2 cpuset.sched.partition flag")
Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/cgroup-defs.h |  1 +
 include/linux/cgroup.h      |  2 +-
 kernel/cgroup/cgroup.c      |  6 ++++++
 kernel/cgroup/cpuset.c      | 20 +++++++++++++++++---
 4 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 485b651869d9..5bc8f55c8cca 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -710,6 +710,7 @@ struct cgroup_subsys {
 	void (*css_released)(struct cgroup_subsys_state *css);
 	void (*css_free)(struct cgroup_subsys_state *css);
 	void (*css_reset)(struct cgroup_subsys_state *css);
+	void (*css_killed)(struct cgroup_subsys_state *css);
 	void (*css_rstat_flush)(struct cgroup_subsys_state *css, int cpu);
 	int (*css_extra_stat_show)(struct seq_file *seq,
 				   struct cgroup_subsys_state *css);
diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 28e999f2c642..e7da3c3b098b 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -344,7 +344,7 @@ static inline u64 cgroup_id(const struct cgroup *cgrp)
  */
 static inline bool css_is_dying(struct cgroup_subsys_state *css)
 {
-	return !(css->flags & CSS_NO_REF) && percpu_ref_is_dying(&css->refcnt);
+	return css->flags & CSS_DYING;
 }
 
 static inline void cgroup_get(struct cgroup *cgrp)
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index f231fe3a0744..49d622205997 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -5909,6 +5909,12 @@ static void kill_css(struct cgroup_subsys_state *css)
 	if (css->flags & CSS_DYING)
 		return;
 
+	/*
+	 * Call css_killed(), if defined, before setting the CSS_DYING flag
+	 */
+	if (css->ss->css_killed)
+		css->ss->css_killed(css);
+
 	css->flags |= CSS_DYING;
 
 	/*
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 39c1fc643d77..749994312d47 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -3475,9 +3475,6 @@ static void cpuset_css_offline(struct cgroup_subsys_state *css)
 	cpus_read_lock();
 	mutex_lock(&cpuset_mutex);
 
-	if (is_partition_valid(cs))
-		update_prstate(cs, 0);
-
 	if (!cpuset_v2() && is_sched_load_balance(cs))
 		cpuset_update_flag(CS_SCHED_LOAD_BALANCE, cs, 0);
 
@@ -3488,6 +3485,22 @@ static void cpuset_css_offline(struct cgroup_subsys_state *css)
 	cpus_read_unlock();
 }
 
+static void cpuset_css_killed(struct cgroup_subsys_state *css)
+{
+	struct cpuset *cs = css_cs(css);
+
+	cpus_read_lock();
+	mutex_lock(&cpuset_mutex);
+
+	/* Reset valid partition back to member */
+	if (is_partition_valid(cs))
+		update_prstate(cs, PRS_MEMBER);
+
+	mutex_unlock(&cpuset_mutex);
+	cpus_read_unlock();
+
+}
+
 static void cpuset_css_free(struct cgroup_subsys_state *css)
 {
 	struct cpuset *cs = css_cs(css);
@@ -3609,6 +3622,7 @@ struct cgroup_subsys cpuset_cgrp_subsys = {
 	.css_alloc	= cpuset_css_alloc,
 	.css_online	= cpuset_css_online,
 	.css_offline	= cpuset_css_offline,
+	.css_killed	= cpuset_css_killed,
 	.css_free	= cpuset_css_free,
 	.can_attach	= cpuset_can_attach,
 	.cancel_attach	= cpuset_cancel_attach,
-- 
2.48.1


