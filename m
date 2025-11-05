Return-Path: <cgroups+bounces-11577-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6FBC33EFD
	for <lists+cgroups@lfdr.de>; Wed, 05 Nov 2025 05:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D4EB44E4C18
	for <lists+cgroups@lfdr.de>; Wed,  5 Nov 2025 04:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4B026F29F;
	Wed,  5 Nov 2025 04:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NuIRXePy"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D208226E16E
	for <cgroups@vger.kernel.org>; Wed,  5 Nov 2025 04:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762317562; cv=none; b=NDHey6jyqpquiRdNt6WO8ubUdD8+GnaHkFFMMeYf1wfQh2BFzCilVu6PaLxCbN5qeDJIzBFUeM7bXbdiCCGfFfBj4GcGpmoddQ/3j7RC97YCYxWOFo4k4H1m3eRfcRgPAQOdWwbtkQTDzq5BF5ZWtpdYSJgqZcyhRewwmGGi1TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762317562; c=relaxed/simple;
	bh=lksMERBV1ushFLKX6VsS5voiCsPgNY/nOBWjYiN++aE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HQp6Bn+f7kvrBXM7TCY+fbz0iTNeaFlLI6GH9jOiOiG0DSTX8JSeANRV4DDVRdem4CuNkSGg9BeC5HGNtenFUpMxjmY3Yzrs3w9gZ2KFo42BuGvu2FovjOpJVgK1BEnPmvRCjZpxeCGdmxGGY4Qt1P6tJPHzjGDLdTIMJln1NOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NuIRXePy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762317559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IPEm3+lCvSFTomkEaqugdFQCEEtIwhV9OiG9EpvN3L4=;
	b=NuIRXePyu7zlneVZl6tl0HUa6u7+OYhoIP9JAXGy/xr1T2ke6Y7bx4Q2bilLS6hYPYgxRH
	4vFJhYn+ZlL7r+9HFFUU2czrQ7zGOQp5Jrd5kUzfH5q0iMe3hSu8pQavvk1qdga7NhwGdx
	KUDyWs2qaRl8ZcYT6WzFSwmcfcfqN04=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-295-fjv1-XboNpGD31spmWZB8g-1; Tue,
 04 Nov 2025 23:39:17 -0500
X-MC-Unique: fjv1-XboNpGD31spmWZB8g-1
X-Mimecast-MFC-AGG-ID: fjv1-XboNpGD31spmWZB8g_1762317556
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E2B98195606D;
	Wed,  5 Nov 2025 04:39:15 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.89.34])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0452F195608E;
	Wed,  5 Nov 2025 04:39:13 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Ridong <chenridong@huawei.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Waiman Long <longman@redhat.com>
Subject: [cgroup/for-6.19 PATCH v3 4/5] cgroup/cpuset: Ensure domain isolated CPUs stay in root or isolated partition
Date: Tue,  4 Nov 2025 23:38:47 -0500
Message-ID: <20251105043848.382703-5-longman@redhat.com>
In-Reply-To: <20251105043848.382703-1-longman@redhat.com>
References: <20251105043848.382703-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Commit 4a74e418881f ("cgroup/cpuset: Check partition conflict with
housekeeping setup") is supposed to ensure that domain isolated CPUs
designated by the "isolcpus" boot command line option stay either in
root partition or in isolated partitions. However, the required check
wasn't implemented when a remote partition was created or when an
existing partition changed type from "root" to "isolated".

Even though this is a relatively minor issue, we still need to add the
required prstate_housekeeping_conflict() call in the right places to
ensure that the rule is strictly followed.

The following steps can be used to reproduce the problem before this
fix.

  # fmt -1 /proc/cmdline | grep isolcpus
  isolcpus=9
  # cd /sys/fs/cgroup/
  # echo +cpuset > cgroup.subtree_control
  # mkdir test
  # echo 9 > test/cpuset.cpus
  # echo isolated > test/cpuset.cpus.partition
  # cat test/cpuset.cpus.partition
  isolated
  # cat test/cpuset.cpus.effective
  9
  # echo root > test/cpuset.cpus.partition
  # cat test/cpuset.cpus.effective
  9
  # cat test/cpuset.cpus.partition
  root

With this fix, the last few steps will become:

  # echo root > test/cpuset.cpus.partition
  # cat test/cpuset.cpus.effective
  0-8,10-95
  # cat test/cpuset.cpus.partition
  root invalid (partition config conflicts with housekeeping setup)

Reported-by: Chen Ridong <chenridong@huawei.com>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index cc9c3402f16b..2daf58bf0bbb 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1610,8 +1610,9 @@ static int remote_partition_enable(struct cpuset *cs, int new_prs,
 	if (!cpumask_intersects(tmp->new_cpus, cpu_active_mask) ||
 	    cpumask_subset(top_cpuset.effective_cpus, tmp->new_cpus))
 		return PERR_INVCPUS;
-	if ((new_prs == PRS_ISOLATED) &&
-	    !isolated_cpus_can_update(tmp->new_cpus, NULL))
+	if (((new_prs == PRS_ISOLATED) &&
+	     !isolated_cpus_can_update(tmp->new_cpus, NULL)) ||
+	    prstate_housekeeping_conflict(new_prs, tmp->new_cpus))
 		return PERR_HKEEPING;
 
 	spin_lock_irq(&callback_lock);
@@ -3062,8 +3063,9 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 		 * A change in load balance state only, no change in cpumasks.
 		 * Need to update isolated_cpus.
 		 */
-		if ((new_prs == PRS_ISOLATED) &&
-		    !isolated_cpus_can_update(cs->effective_xcpus, NULL))
+		if (((new_prs == PRS_ISOLATED) &&
+		     !isolated_cpus_can_update(cs->effective_xcpus, NULL)) ||
+		    prstate_housekeeping_conflict(new_prs, cs->effective_xcpus))
 			err = PERR_HKEEPING;
 		else
 			isolcpus_updated = true;
-- 
2.51.1


