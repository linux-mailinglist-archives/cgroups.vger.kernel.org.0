Return-Path: <cgroups+bounces-15946-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Ps7EnQABmrFdwIAu9opvQ
	(envelope-from <cgroups+bounces-15946-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 14 May 2026 19:03:48 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B9EE75450DE
	for <lists+cgroups@lfdr.de>; Thu, 14 May 2026 19:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EB4123054FDA
	for <lists+cgroups@lfdr.de>; Thu, 14 May 2026 17:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBECA38888F;
	Thu, 14 May 2026 17:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d5Or0pxw"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5613876AF
	for <cgroups@vger.kernel.org>; Thu, 14 May 2026 17:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778778202; cv=none; b=OFKlsIXKtLIV5KvBlpjUpOWptQlHTYPRWxHOEEdU1UDgKCs8WilV8x2EFcEiQh3qx9M/a6pbQ49HQ7zCGp9xvUY1uv4nKLMOvjASqTpXghqn2AO1VOIDdvhIOMTqqSuU09nNUsbw3iKaNIlZQv+3IkjreZWVVedSb/3XUGUmHig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778778202; c=relaxed/simple;
	bh=iKoFddTMDlVHV4CXsvi7sFe225ba9qRiv/Yem/1K3g0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XjlExI1w2MOInNPNLSCTAOytDc+1uFb3FXwBVUF+W9z8PzcGrwpvXCchTKOzMdu0N+UWC5JaRD4bF3K0eIZxqhV9V9CNhdAUFCApw9GJgFNqmmSYRDq5j34u4oAt2N/GCoZpojVQCQy4nl9SIuVtBfoQmeNM5i2Y+a2AsBwQbFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d5Or0pxw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778778200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X5qv11FgV5fy/6EX+8T25xoRvDD1FKxp0C5IFRIAwRw=;
	b=d5Or0pxwhHbjjJAJWamY1L4nV90SpYEUziyKpbL1EmEHX30WUv1VHHkGV5l7OQBO4EeAqD
	Sb/fw9UsFnug+dm6qgeWCcgLAW0iZ4l3VAVa7HQ9FfoVhwkUQXeku/swlmcp4nY1vM5FZD
	ZI9XF5/x1iwysTYR4Q4deMeBJBkffkw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-610-3OmNstXvN1m3sRrU8EZYlQ-1; Thu,
 14 May 2026 13:03:16 -0400
X-MC-Unique: 3OmNstXvN1m3sRrU8EZYlQ-1
X-Mimecast-MFC-AGG-ID: 3OmNstXvN1m3sRrU8EZYlQ_1778778194
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0F2DA1800626;
	Thu, 14 May 2026 17:03:14 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.2.16.73])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 47AD530002DA;
	Thu, 14 May 2026 17:03:10 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Chen Ridong <chenridong@huaweicloud.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH cgroup/for-next 1/4] cgroup/cpuset: Add an alloc_dl_bw() helper
Date: Thu, 14 May 2026 13:02:37 -0400
Message-ID: <20260514170240.575156-2-longman@redhat.com>
In-Reply-To: <20260514170240.575156-1-longman@redhat.com>
References: <20260514170240.575156-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Queue-Id: B9EE75450DE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15946-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Extract the DL bandwidth allocation code in cpuset_attach() to a new
alloc_dl_bw() helper to simplify code.

No functional change is expected.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 50 +++++++++++++++++++++++-------------------
 1 file changed, 28 insertions(+), 22 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index bcefc9f50ac5..9de3c907436f 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2980,6 +2980,25 @@ static int cpuset_can_attach_check(struct cpuset *cs)
 	return 0;
 }
 
+static int alloc_dl_bw(struct cpuset *cs)
+{
+	int cpu, ret;
+
+	if (!cs->sum_migrate_dl_bw)
+		return 0;
+
+	cpu = cpumask_any_and(cpu_active_mask, cs->effective_cpus);
+	if (unlikely(cpu >= nr_cpu_ids))
+		return -EINVAL;
+
+	ret = dl_bw_alloc(cpu, cs->sum_migrate_dl_bw);
+	if (ret)
+		return ret;
+
+	cs->dl_bw_cpu = cpu;
+	return 0;
+}
+
 static void reset_migrate_dl_data(struct cpuset *cs)
 {
 	cs->nr_migrate_dl_tasks = 0;
@@ -2994,7 +3013,7 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 	struct cpuset *cs, *oldcs;
 	struct task_struct *task;
 	bool setsched_check;
-	int cpu, ret;
+	int ret;
 
 	/* used later by cpuset_attach() */
 	cpuset_attach_old_cs = task_cs(cgroup_taskset_first(tset, &css));
@@ -3050,31 +3069,18 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 		}
 	}
 
-	if (!cs->sum_migrate_dl_bw)
-		goto out_success;
-
-	cpu = cpumask_any_and(cpu_active_mask, cs->effective_cpus);
-	if (unlikely(cpu >= nr_cpu_ids)) {
-		ret = -EINVAL;
-		goto out_unlock;
-	}
-
-	ret = dl_bw_alloc(cpu, cs->sum_migrate_dl_bw);
-	if (ret)
-		goto out_unlock;
-
-	cs->dl_bw_cpu = cpu;
-
-out_success:
-	/*
-	 * Mark attach is in progress.  This makes validate_change() fail
-	 * changes which zero cpus/mems_allowed.
-	 */
-	cs->attach_in_progress++;
+	ret = alloc_dl_bw(cs);
 
 out_unlock:
 	if (ret)
 		reset_migrate_dl_data(cs);
+	else
+		/*
+		 * Mark attach is in progress.  This makes validate_change() fail
+		 * changes which zero cpus/mems_allowed.
+		 */
+		cs->attach_in_progress++;
+
 	mutex_unlock(&cpuset_mutex);
 	return ret;
 }
-- 
2.54.0


