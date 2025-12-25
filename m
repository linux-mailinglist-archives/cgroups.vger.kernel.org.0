Return-Path: <cgroups+bounces-12696-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC52CDD715
	for <lists+cgroups@lfdr.de>; Thu, 25 Dec 2025 08:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 254573049B01
	for <lists+cgroups@lfdr.de>; Thu, 25 Dec 2025 07:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4CD2EAB6E;
	Thu, 25 Dec 2025 07:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L2XdZkK7"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F412BE629
	for <cgroups@vger.kernel.org>; Thu, 25 Dec 2025 07:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766647940; cv=none; b=dpSyI9zLhdtpGLfAOxrtqaIGCautdOfU1JRuvk6s4Z7I8hoyp9jtnaVPqm6IqAwF6linSHsUEy4bCpccUyKuvtE7c7nwuEgKFlQxThyzZtDb1WD2fEU8Ssy0WdVPfjZRyCu9cngS48FJHrMEfu6nS5ObzPe6CtiPxmzpg0KPQ0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766647940; c=relaxed/simple;
	bh=sH+5miPshqDkdtfq9E6/zLk+kBgJe09PnQWL091CP4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZhhiRqOoHBpqS4hBJODNNSb+WOfmQUOU8M+PYr3tUQ/LeBFV36l1WhBcGE313unbx4BCqzbDlnGZam74sKKPTg4yRUTCGWGdNFDHrxM8tOjQ4/cZaaVuMikBiakCD7VATVygXyxCrzhIxRt1R8Id3WZzrrssBV9rZ6MOMFIK3cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L2XdZkK7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766647936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uKn3Wb9FBU24/WkZZGdo+7ZlhH/dyKA25oZV0rC9FuM=;
	b=L2XdZkK7avavtvb3tgFkF4b8sWvAXdZuzcs3iOZkUpOP0wsWVSY6xfxZWJmDiu5kOL37lY
	FZjOkAvKMvEDfxTDbOgPpvNvBeJllYyJejHQ/Cp/E8kAA4PMiVZ3XTx0RsibGccxV8p3Fb
	yCh6tHCZOluBKwKnmLzaodlaZJethBo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-Gj_sz55TMdqK0WjLH4yoQw-1; Thu,
 25 Dec 2025 02:32:10 -0500
X-MC-Unique: Gj_sz55TMdqK0WjLH4yoQw-1
X-Mimecast-MFC-AGG-ID: Gj_sz55TMdqK0WjLH4yoQw_1766647928
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9E80119560B2;
	Thu, 25 Dec 2025 07:32:08 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.2.16.7])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0F9E419560AB;
	Thu, 25 Dec 2025 07:32:05 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Sun Shaojie <sunshaojie@kylinos.cn>,
	Chen Ridong <chenridong@huaweicloud.com>,
	Waiman Long <longman@redhat.com>
Subject: [cgroup/for-6.20 PATCH 2/4] cgroup/cpuset: Consistently compute effective_xcpus in update_cpumasks_hier()
Date: Thu, 25 Dec 2025 02:30:54 -0500
Message-ID: <20251225073056.30789-3-longman@redhat.com>
In-Reply-To: <20251225073056.30789-1-longman@redhat.com>
References: <20251225073056.30789-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Since commit f62a5d39368e ("cgroup/cpuset: Remove remote_partition_check()
& make update_cpumasks_hier() handle remote partition"), the
compute_effective_exclusive_cpumask() helper was extended to
strip exclusive CPUs from siblings when computing effective_xcpus
(cpuset.cpus.exclusive.effective). This helper was later renamed to
compute_excpus() in commit 86bbbd1f33ab ("cpuset: Refactor exclusive
CPU mask computation logic").

This helper is supposed to be used consistently to compute
effective_xcpus. However, there is an exception within the callback
critical section in update_cpumasks_hier() when exclusive_cpus of a
valid partition root is empty. This can cause effective_xcpus value to
differ depending on where exactly it is last computed. Fix this by using
compute_excpus() in this case to give a consistent result.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 3d2d28f0fd03..850334dbc36a 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2050,6 +2050,7 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
 		struct cpuset *parent = parent_cs(cp);
 		bool remote = is_remote_partition(cp);
 		bool update_parent = false;
+		bool empty_xcpus;
 
 		old_prs = new_prs = cp->partition_root_state;
 
@@ -2160,20 +2161,14 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
 			new_prs = cp->partition_root_state;
 		}
 
+		empty_xcpus = cpumask_empty(cp->exclusive_cpus);
 		spin_lock_irq(&callback_lock);
 		cpumask_copy(cp->effective_cpus, tmp->new_cpus);
 		cp->partition_root_state = new_prs;
-		if (!cpumask_empty(cp->exclusive_cpus) && (cp != cs))
+		if (((new_prs > 0) && empty_xcpus) ||
+		    ((cp != cs) && !empty_xcpus))
 			compute_excpus(cp, cp->effective_xcpus);
-
-		/*
-		 * Make sure effective_xcpus is properly set for a valid
-		 * partition root.
-		 */
-		if ((new_prs > 0) && cpumask_empty(cp->exclusive_cpus))
-			cpumask_and(cp->effective_xcpus,
-				    cp->cpus_allowed, parent->effective_xcpus);
-		else if (new_prs < 0)
+		if (new_prs < 0)
 			reset_partition_data(cp);
 		spin_unlock_irq(&callback_lock);
 
-- 
2.52.0


