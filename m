Return-Path: <cgroups+bounces-7401-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E19BDA7EFC1
	for <lists+cgroups@lfdr.de>; Mon,  7 Apr 2025 23:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F62A17C926
	for <lists+cgroups@lfdr.de>; Mon,  7 Apr 2025 21:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F702222D2;
	Mon,  7 Apr 2025 21:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jOOIysrs"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A028B225A39
	for <cgroups@vger.kernel.org>; Mon,  7 Apr 2025 21:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744060935; cv=none; b=a9MgRzw9q2pSCZFisqMLW8I7bmqMPsQpZSxWiPRe8yzSyBDi9UzbxrsIpdTrcI0oxaGnBvTET4ZLhC+zMF1Fe99buWhXyvzS350Zkze7CvX2n556bRAM5LfgllsqGo6sP5WpbuIfXBOSGNDQVZKxWGCJBjWCXnu7xn949H/kJjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744060935; c=relaxed/simple;
	bh=lgWxqBtLH9pJAIx5zVJb3BGHn1TkxNAuETrUPhk326w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ieeiyO41Q1g2DwjKVgrYJasNJ8OT5cqSQZdSINnYdxdOjgTjDSTKsflnjYYnc9V4931CNeEkrrDs1WyrftKIO43o1oSI/pQs76VVf0+x0nI/BeKUchcJYLyTTP/6md0wKid/VUzUsRGQHqGQuWplodVYRugAlG3qrdjwHdYkyNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jOOIysrs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744060932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NR/Ky/GsJ2q9CL9cmUdAHPUCzxFT+B+70sC+38xj5+8=;
	b=jOOIysrsEQLu8UbJTLUwTOmUV2KKoYU9pvYQ4EscTtnB/tZ5vj0+41YW2uBnfIEdVcntzd
	ykLhQkFGx/+g92FuEgz/hQYvOmPfiCJLTsQ7wdor3Ztu6Y4zPDcBZdtId6ow5789Gf6bgM
	KUl59m/OYfbuZgZnQCXXOLRoWo6ifhg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-650-2kV8-peZO2uTnlO-MfBbcQ-1; Mon,
 07 Apr 2025 17:22:09 -0400
X-MC-Unique: 2kV8-peZO2uTnlO-MfBbcQ-1
X-Mimecast-MFC-AGG-ID: 2kV8-peZO2uTnlO-MfBbcQ_1744060928
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 72CA9180AF4D;
	Mon,  7 Apr 2025 21:22:08 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.90.98])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 083C8180B488;
	Mon,  7 Apr 2025 21:22:06 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Waiman Long <longman@redhat.com>
Subject: [PATCH 3/3] cgroup/cpuset: Add warnings to catch inconsistency in exclusive CPUs
Date: Mon,  7 Apr 2025 17:21:05 -0400
Message-ID: <20250407212127.1534285-4-longman@redhat.com>
In-Reply-To: <20250407212127.1534285-1-longman@redhat.com>
References: <20250407212127.1534285-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Add WARN_ON_ONCE() statements whenever new exclusive CPUs are being
added to a partition root to catch inconsistency in the way exclusive
CPUs are being handled in the cpuset code.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 43 ++++++++++++++++++++++++++++++++----------
 1 file changed, 33 insertions(+), 10 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 1497a2a4b2a3..d0143b3dce47 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1453,13 +1453,15 @@ static int remote_partition_enable(struct cpuset *cs, int new_prs,
 	 * The requested exclusive_cpus must not be allocated to other
 	 * partitions and it can't use up all the root's effective_cpus.
 	 *
-	 * Note that if there is any local partition root above it or
-	 * remote partition root underneath it, its exclusive_cpus must
-	 * have overlapped with subpartitions_cpus.
+	 * The effective_xcpus mask can contain offline CPUs, but there must
+	 * be at least one or more online CPUs present before it can be enabled.
+	 *
+	 * Note that creating a remote partition with any local partition root
+	 * above it or remote partition root underneath it is not allowed.
 	 */
 	compute_effective_exclusive_cpumask(cs, tmp->new_cpus, NULL);
-	if (cpumask_empty(tmp->new_cpus) ||
-	    cpumask_intersects(tmp->new_cpus, subpartitions_cpus) ||
+	WARN_ON_ONCE(cpumask_intersects(tmp->new_cpus, subpartitions_cpus));
+	if (!cpumask_intersects(tmp->new_cpus, cpu_active_mask) ||
 	    cpumask_subset(top_cpuset.effective_cpus, tmp->new_cpus))
 		return PERR_INVCPUS;
 
@@ -1555,6 +1557,7 @@ static void remote_cpus_update(struct cpuset *cs, struct cpumask *xcpus,
 	 * left in the top cpuset.
 	 */
 	if (adding) {
+		WARN_ON_ONCE(cpumask_intersects(tmp->addmask, subpartitions_cpus));
 		if (!capable(CAP_SYS_ADMIN))
 			cs->prs_err = PERR_ACCESS;
 		else if (cpumask_intersects(tmp->addmask, subpartitions_cpus) ||
@@ -1664,7 +1667,7 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
 	bool nocpu;
 
 	lockdep_assert_held(&cpuset_mutex);
-	WARN_ON_ONCE(is_remote_partition(cs));
+	WARN_ON_ONCE(is_remote_partition(cs));	/* For local partition only */
 
 	/*
 	 * new_prs will only be changed for the partcmd_update and
@@ -1710,7 +1713,7 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
 		 * exclusive_cpus not set. Sibling conflict should only happen
 		 * if exclusive_cpus isn't set.
 		 */
-		xcpus = tmp->new_cpus;
+		xcpus = tmp->delmask;
 		if (compute_effective_exclusive_cpumask(cs, xcpus, NULL))
 			WARN_ON_ONCE(!cpumask_empty(cs->exclusive_cpus));
 
@@ -1731,9 +1734,20 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
 		if (nocpu)
 			return PERR_NOCPUS;
 
-		deleting = cpumask_and(tmp->delmask, xcpus, parent->effective_xcpus);
-		if (deleting)
-			subparts_delta++;
+		/*
+		 * This function will only be called when all the preliminary
+		 * checks have passed. At this point, the following condition
+		 * should hold.
+		 *
+		 * (cs->effective_xcpus & cpu_active_mask) ⊆ parent->effective_cpus
+		 *
+		 * Warn if it is not the case.
+		 */
+		cpumask_and(tmp->new_cpus, xcpus, cpu_active_mask);
+		WARN_ON_ONCE(!cpumask_subset(tmp->new_cpus, parent->effective_cpus));
+
+		deleting = true;
+		subparts_delta++;
 		new_prs = (cmd == partcmd_enable) ? PRS_ROOT : PRS_ISOLATED;
 	} else if (cmd == partcmd_disable) {
 		/*
@@ -1787,6 +1801,15 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
 			deleting = cpumask_and(tmp->delmask, tmp->delmask,
 					       parent->effective_xcpus);
 		}
+		/*
+		 * The new CPUs to be removed from parent's effective CPUs
+		 * must be present.
+		 */
+		if (deleting) {
+			cpumask_and(tmp->new_cpus, tmp->delmask, cpu_active_mask);
+			WARN_ON_ONCE(!cpumask_subset(tmp->new_cpus, parent->effective_cpus));
+		}
+
 		/*
 		 * Make partition invalid if parent's effective_cpus could
 		 * become empty and there are tasks in the parent.
-- 
2.48.1


