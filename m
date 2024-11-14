Return-Path: <cgroups+bounces-5566-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB549C918D
	for <lists+cgroups@lfdr.de>; Thu, 14 Nov 2024 19:19:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A338C1F23427
	for <lists+cgroups@lfdr.de>; Thu, 14 Nov 2024 18:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C661974EA;
	Thu, 14 Nov 2024 18:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hYHTpjaf"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8620A18C038
	for <cgroups@vger.kernel.org>; Thu, 14 Nov 2024 18:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731608375; cv=none; b=rB+VU6aM0C4394KzeCTmfd/ooz2e9H44ZKE+Kl0kqK3dLbxIHxrYOiG2Lvev2ZLBJ/GLReLtQQHl4xzcNhyXHRGrxf2mshZUw3y3Tufg/Om9kaGMYJoYeOYWBhpHpocZfvd5Jmi9QHGqUQoT2L9VuzjWABSiB6GzHp8KwLsP7/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731608375; c=relaxed/simple;
	bh=wo9xO9JhMa+6uVjc/CHr8kq/xCgRsOlrP++lSGCNvdA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iORcsx/AGatYu6N1HnNLw0ph0xgGcow0LXeAU8faNcnQY4AF3KqzopL1gMlpCx3ZtBKYS1BAJAB2EnZZB1HcEYkvgDmCQE0mw+iJUER/sW3v8/i3R/gYDtNvFmTH2OEHtMXKUKksQMnbY7z+j3ZzQrkpVYZEpXnnwkUow0AAI0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hYHTpjaf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731608372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ttcm/kqUVer/q0syy3ilItGelSv7M9+D+CHaMEMjRqw=;
	b=hYHTpjafSxlUsIsKhVpTrWwgqaBxmjUEKVhF1wlg2VUFZi05uurKXO8tCPTkzTXtGA/Oc7
	pfW1U3Q89h+fo40Q+KRffgu87CdYlD9lUnc2ITEvgFgtJe2TJckOPNcw/fbRBB8dWRCuYt
	Desjdgzabne+IkqZX2D+4JZeJ6IesEs=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-Erfyu-f3ODGAVPxYA_8aKQ-1; Thu,
 14 Nov 2024 13:19:29 -0500
X-MC-Unique: Erfyu-f3ODGAVPxYA_8aKQ-1
X-Mimecast-MFC-AGG-ID: Erfyu-f3ODGAVPxYA_8aKQ
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AC2F81955F77;
	Thu, 14 Nov 2024 18:19:27 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.81.222])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A20331955F21;
	Thu, 14 Nov 2024 18:19:25 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Juri Lelli <juri.lelli@redhat.com>,
	Phil Auld <pauld@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH] cgroup/cpuset: Disable cpuset_cpumask_can_shrink() test if not load balancing
Date: Thu, 14 Nov 2024 13:19:15 -0500
Message-ID: <20241114181915.142894-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

With some recent proposed changes [1] in the deadline server code,
it has caused a test failure in test_cpuset_prs.sh when a change
is being made to an isolated partition. This is due to failing
the cpuset_cpumask_can_shrink() check for SCHED_DEADLINE tasks at
validate_change().

This is actually a false positive as the failed test case involves an
isolated partition with load balancing disabled. The deadline check
is not meaningful in this case and the users should know what they
are doing.

Fix this by doing the cpuset_cpumask_can_shrink() check only when loading
balanced is enabled. Also change its arguments to use effective_cpus
for the current cpuset and user_xcpus() as an approiximation for the
target effective_cpus as the real effective_cpus hasn't been fully
computed yet as this early stage.

As the check isn't comprehensive, there may be false positives or
negatives. We may have to revise the code to do a more thorough check
in the future if this becomes a concern.

[1] https://lore.kernel.org/lkml/82be06c1-6d6d-4651-86c9-bcc828cbcb80@redhat.com/T/#t

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 655396e75b58..21050cacff0d 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -581,12 +581,24 @@ static int validate_change(struct cpuset *cur, struct cpuset *trial)
 
 	/*
 	 * We can't shrink if we won't have enough room for SCHED_DEADLINE
-	 * tasks.
+	 * tasks. This check is not done when scheduling is disabled as the
+	 * users should know what they are doing.
+	 *
+	 * For v1, effective_cpus == cpus_allowed & user_xcpus() returns
+	 * cpus_allowed.
+	 *
+	 * For v2, is_cpu_exclusive() & is_sched_load_balance() are true only
+	 * for non-isolated partition root. At this point, the target
+	 * effective_cpus isn't computed yet. user_xcpus() is the best
+	 * approximation.
+	 *
+	 * TBD: May need to precompute the real effective_cpus here in case
+	 * incorrect scheduling of SCHED_DEADLINE tasks in a partition
+	 * becomes an issue.
 	 */
 	ret = -EBUSY;
-	if (is_cpu_exclusive(cur) &&
-	    !cpuset_cpumask_can_shrink(cur->cpus_allowed,
-				       trial->cpus_allowed))
+	if (is_cpu_exclusive(cur) && is_sched_load_balance(cur) &&
+	    !cpuset_cpumask_can_shrink(cur->effective_cpus, user_xcpus(trial)))
 		goto out;
 
 	/*
-- 
2.47.0


