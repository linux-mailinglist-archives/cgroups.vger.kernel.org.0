Return-Path: <cgroups+bounces-11578-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CE16EC33F03
	for <lists+cgroups@lfdr.de>; Wed, 05 Nov 2025 05:39:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C3DAE4E4A0E
	for <lists+cgroups@lfdr.de>; Wed,  5 Nov 2025 04:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DEEB25291B;
	Wed,  5 Nov 2025 04:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H65JiNB+"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A7F26E709
	for <cgroups@vger.kernel.org>; Wed,  5 Nov 2025 04:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762317563; cv=none; b=sGt5F35DWVtud9Gp6nWuDrGuTkNeJbJtwKjezhXRU3Mgfac7DB3k7NDttBtnou3i/M9YV/JZPun2/gLuvAt/c5MTNp+/3Re/8pMncEkGcfeyL/H/45JLBofqElMwA/1zDkTZ7ZREUgFPPllq8cqnW4Ta29gv3vZsHAECLDpcmbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762317563; c=relaxed/simple;
	bh=RMjGOSJpyo8rJND2xA3CXsnbb4vc2vX8OFQFw74WN60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=STIYHyEEiBvdovotoIEHdNodM1y4FcdtEbi7nc7p51jkE1Ca/UGo0bHo0nPAv6Bn6q08hrf5LAJPZeeHVL4Ohtw3JPXy8ATXSpCBVEB9K7iZM4LqzTLvz+kPVidnJwD9yItHjdRT41QdxYrLRuUNfTHPuzdr0hh50pTtpj9Kh5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H65JiNB+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762317560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x6GCHt1CiApHsHGJP9FdQ1dyKLj8EW3fJqm5osh6hIc=;
	b=H65JiNB+HP5Hw2McSJCrdne2neDSWxjPXJvN5qsQniMsCZr1lfG9dUMJopWRsZweTs9i2m
	f7CSQOrbO16Nr6ZIW47wYPB9Hi9Aj7K3nyZJC5T+0Wrn4WtP8Gd9P8yRtPkKFwVkkrbsGp
	3IfetN/N0Tvy9Ac+xt0cuepw4uNbqpQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-478-TPZwAlc8MOS7x6WNjQ09NQ-1; Tue,
 04 Nov 2025 23:39:15 -0500
X-MC-Unique: TPZwAlc8MOS7x6WNjQ09NQ-1
X-Mimecast-MFC-AGG-ID: TPZwAlc8MOS7x6WNjQ09NQ_1762317553
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D01361800359;
	Wed,  5 Nov 2025 04:39:13 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.89.34])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C1CFE1956095;
	Wed,  5 Nov 2025 04:39:11 +0000 (UTC)
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
Subject: [cgroup/for-6.19 PATCH v3 3/5] cgroup/cpuset: Move up prstate_housekeeping_conflict() helper
Date: Tue,  4 Nov 2025 23:38:46 -0500
Message-ID: <20251105043848.382703-4-longman@redhat.com>
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

Move up the prstate_housekeeping_conflict() helper so that it can be
used in remote partition code.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 99622e90991a..cc9c3402f16b 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1432,6 +1432,26 @@ static bool isolated_cpus_can_update(struct cpumask *add_cpus,
 	return res;
 }
 
+/*
+ * prstate_housekeeping_conflict - check for partition & housekeeping conflicts
+ * @prstate: partition root state to be checked
+ * @new_cpus: cpu mask
+ * Return: true if there is conflict, false otherwise
+ *
+ * CPUs outside of boot_hk_cpus, if defined, can only be used in an
+ * isolated partition.
+ */
+static bool prstate_housekeeping_conflict(int prstate, struct cpumask *new_cpus)
+{
+	if (!have_boot_isolcpus)
+		return false;
+
+	if ((prstate != PRS_ISOLATED) && !cpumask_subset(new_cpus, boot_hk_cpus))
+		return true;
+
+	return false;
+}
+
 static void update_isolation_cpumasks(bool isolcpus_updated)
 {
 	int ret;
@@ -1727,26 +1747,6 @@ static void remote_cpus_update(struct cpuset *cs, struct cpumask *xcpus,
 	remote_partition_disable(cs, tmp);
 }
 
-/*
- * prstate_housekeeping_conflict - check for partition & housekeeping conflicts
- * @prstate: partition root state to be checked
- * @new_cpus: cpu mask
- * Return: true if there is conflict, false otherwise
- *
- * CPUs outside of boot_hk_cpus, if defined, can only be used in an
- * isolated partition.
- */
-static bool prstate_housekeeping_conflict(int prstate, struct cpumask *new_cpus)
-{
-	if (!have_boot_isolcpus)
-		return false;
-
-	if ((prstate != PRS_ISOLATED) && !cpumask_subset(new_cpus, boot_hk_cpus))
-		return true;
-
-	return false;
-}
-
 /**
  * update_parent_effective_cpumask - update effective_cpus mask of parent cpuset
  * @cs:      The cpuset that requests change in partition root state
-- 
2.51.1


