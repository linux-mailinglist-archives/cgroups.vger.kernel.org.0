Return-Path: <cgroups+bounces-9003-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4A3B1CAA4
	for <lists+cgroups@lfdr.de>; Wed,  6 Aug 2025 19:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD084624CE4
	for <lists+cgroups@lfdr.de>; Wed,  6 Aug 2025 17:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706C129E0E5;
	Wed,  6 Aug 2025 17:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a6s77UZc"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B838D29CB4F
	for <cgroups@vger.kernel.org>; Wed,  6 Aug 2025 17:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754501098; cv=none; b=p4AOyfcttK38QsaJ6RSlpEEQAKSy8svHzLoEFN7VGAXExM/89SCgpgVPQhDUgVu9zJP4z/g+xyu9RJfJFhxONCwi8FNGPhE47BvBYVnIo2qiSCQPEUlalU8/+O33lNBfT74+BrWRx46bmHLyi+ITMHX8F7Gh6I73yQREW2O1o7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754501098; c=relaxed/simple;
	bh=Oj/vm0Gkw6edpCEs5FxHS4upaCO0j/bOzRv0a/F3qW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nVSqAlFhUnI4Qp1lBddFNISbnthknSGYDSaDK6IjPUojWwniMpiF+SZvRdy21XY4xZwtIpD+4KOucCnq0FesOf1kB91Obin5zGTRIdn6uyjduIsR/wl2ENfC9y0GNWdhgtdHq2fQVEqX4THkfCelHhLqMXUI5KjC2v0yJALojlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a6s77UZc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754501095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5wrB6DGlnEetp0cy09fMeZaav/mSCyKZPlRkJ96Aoso=;
	b=a6s77UZcay+RL0Pw5qzkrGyDpfQzD2C4MBQGGQgfHYS5oKI+P6WqJTseUtg1m+CX+LvqJJ
	klUfEDkJt6dSZdSx+AGy0VK0ZUt8Lqv/V2GGDF3qEwL06PjCDEOI3Z4bu2yrcb89xPP6Lh
	uiAZAB1e9OSrIdtI7EUuxxaRPxzDDzg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-684-O8SO42uDMRmlLRxO4Fthkw-1; Wed,
 06 Aug 2025 13:24:52 -0400
X-MC-Unique: O8SO42uDMRmlLRxO4Fthkw-1
X-Mimecast-MFC-AGG-ID: O8SO42uDMRmlLRxO4Fthkw_1754501091
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9AF721800357;
	Wed,  6 Aug 2025 17:24:50 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.89.125])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AE33C3000198;
	Wed,  6 Aug 2025 17:24:48 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH 2/3] cgroup/cpuset.c: Fix a partition error with CPU hotplug
Date: Wed,  6 Aug 2025 13:24:29 -0400
Message-ID: <20250806172430.1155133-3-longman@redhat.com>
In-Reply-To: <20250806172430.1155133-1-longman@redhat.com>
References: <20250806172430.1155133-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

It was found during testing that an invalid leaf partition with an
empty effective exclusive CPU list can become a valid empty partition
with no CPU afer an offline/online operation of an unrelated CPU. An
empty partition root is allowed in the special case that it has no
task in its cgroup and has distributed out all its CPUs to its child
partitions. That is certainly not the case here.

The problem is in the cpumask_subsets() test in the hotplug case
(update with no new mask) of update_parent_effective_cpumask() as it
also returns true if the effective exclusive CPU list is empty. Fix that
by addding the cpumask_empty() test to root out this exception case.
Also add the cpumask_empty() test in cpuset_hotplug_update_tasks()
to avoid calling update_parent_effective_cpumask() for this special case.

Fixes: 0c7f293efc87 ("cgroup/cpuset: Add cpuset.cpus.exclusive.effective for v2")
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index bf149246e001..d993e058a663 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1843,7 +1843,7 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
 			if (is_partition_valid(cs))
 				adding = cpumask_and(tmp->addmask,
 						xcpus, parent->effective_xcpus);
-		} else if (is_partition_invalid(cs) &&
+		} else if (is_partition_invalid(cs) && !cpumask_empty(xcpus) &&
 			   cpumask_subset(xcpus, parent->effective_xcpus)) {
 			struct cgroup_subsys_state *css;
 			struct cpuset *child;
@@ -3870,9 +3870,10 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
 		partcmd = partcmd_invalidate;
 	/*
 	 * On the other hand, an invalid partition root may be transitioned
-	 * back to a regular one.
+	 * back to a regular one with a non-empty effective xcpus.
 	 */
-	else if (is_partition_valid(parent) && is_partition_invalid(cs))
+	else if (is_partition_valid(parent) && is_partition_invalid(cs) &&
+		 !cpumask_empty(cs->effective_xcpus))
 		partcmd = partcmd_update;
 
 	if (partcmd >= 0) {
-- 
2.50.0


