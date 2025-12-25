Return-Path: <cgroups+bounces-12695-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9107BCDD70F
	for <lists+cgroups@lfdr.de>; Thu, 25 Dec 2025 08:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 842AF3031CF0
	for <lists+cgroups@lfdr.de>; Thu, 25 Dec 2025 07:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D032E1758;
	Thu, 25 Dec 2025 07:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iV0/Ckh0"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57642F5474
	for <cgroups@vger.kernel.org>; Thu, 25 Dec 2025 07:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766647934; cv=none; b=S2r3RFC3iBGLA58PL52L1Ako1keD/k9uG+YyqEpc0BmmR5PZGc6oRL9/ZFuOzlnYzdAAAVWWpS+s9aQsq/t+JKbdtj8O7A3hwjmDhdX5j1hEE4sWamQ0EBaHxOlWnM2FnyrdHY49Y1O6NjyJgUi56m392BqZ8q+QpvauFICBgoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766647934; c=relaxed/simple;
	bh=CJaGZjpJs2+vnsnm8O3kOZuG6Na1R+ZtwLcAQalKPs0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XQTzixuE1GXm0/0xz3amwirowR+DbP1Y1VWs330ofsZ/57is/uGUzXSg82Wji3oD7druoOQOAh5KjLW5pctNRs2gNySWYjjaJk6ibxtAloGg3haY3zU4wNzQnVjKBsNUc4ZFQ8/3eqyTiRWL/p45fxG1unIEVJPuZe2pd7h2r3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iV0/Ckh0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766647931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cp5bpt5G7GyNdNrZ0HyPBBNCrzvoPT8Jv2FHYXiJko4=;
	b=iV0/Ckh0aKd9oK4/GtTHPqFfKfQvPoQigbOj2JLJBVgjUG/k+9lRmarmUo3DIbiCIDjbS0
	Y/KBc9XzMZFHgH3sqjC5+Frsq6utXBxQG2NcY76dC3RxEmjhUee4y0rvlI3dBhRJpzGb1N
	u2zqDdh1Cq8JmYNC7G5UUtVg5Fu4Abg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-692--PtmfDfNMQmMfs93vMBFQg-1; Thu,
 25 Dec 2025 02:32:08 -0500
X-MC-Unique: -PtmfDfNMQmMfs93vMBFQg-1
X-Mimecast-MFC-AGG-ID: -PtmfDfNMQmMfs93vMBFQg_1766647926
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B1E0618002E4;
	Thu, 25 Dec 2025 07:32:05 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.2.16.7])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 08B851956056;
	Thu, 25 Dec 2025 07:32:02 +0000 (UTC)
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
Subject: [cgroup/for-6.20 PATCH 1/4] cgroup/cpuset: Streamline rm_siblings_excl_cpus()
Date: Thu, 25 Dec 2025 02:30:53 -0500
Message-ID: <20251225073056.30789-2-longman@redhat.com>
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

If exclusive_cpus is set, effective_xcpus must be a subset of
exclusive_cpus. Currently, rm_siblings_excl_cpus() checks both
exclusive_cpus and effective_xcpus connectively. It is simpler
to check only exclusive_cpus if non-empty or just effective_xcpus
otherwise.

No functional change is expected.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 221da921b4f9..3d2d28f0fd03 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1355,23 +1355,24 @@ static int rm_siblings_excl_cpus(struct cpuset *parent, struct cpuset *cs,
 	int retval = 0;
 
 	if (cpumask_empty(excpus))
-		return retval;
+		return 0;
 
 	/*
 	 * Exclude exclusive CPUs from siblings
 	 */
 	rcu_read_lock();
 	cpuset_for_each_child(sibling, css, parent) {
+		struct cpumask *sibling_xcpus;
+
 		if (sibling == cs)
 			continue;
 
-		if (cpumask_intersects(excpus, sibling->exclusive_cpus)) {
-			cpumask_andnot(excpus, excpus, sibling->exclusive_cpus);
-			retval++;
-			continue;
-		}
-		if (cpumask_intersects(excpus, sibling->effective_xcpus)) {
-			cpumask_andnot(excpus, excpus, sibling->effective_xcpus);
+		sibling_xcpus = cpumask_empty(sibling->exclusive_cpus)
+			      ? sibling->effective_xcpus
+			      : sibling->exclusive_cpus;
+
+		if (cpumask_intersects(excpus, sibling_xcpus)) {
+			cpumask_andnot(excpus, excpus, sibling_xcpus);
 			retval++;
 		}
 	}
-- 
2.52.0


