Return-Path: <cgroups+bounces-15990-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLl2D97xB2qbQQMAu9opvQ
	(envelope-from <cgroups+bounces-15990-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 16 May 2026 06:26:06 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA3A55A28E
	for <lists+cgroups@lfdr.de>; Sat, 16 May 2026 06:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8A843025906
	for <lists+cgroups@lfdr.de>; Sat, 16 May 2026 04:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F3B2D1916;
	Sat, 16 May 2026 04:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pjkxbbf9"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38F432C8B
	for <cgroups@vger.kernel.org>; Sat, 16 May 2026 04:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778905526; cv=none; b=XWy/LZW82a+ri+HMqhQE1C3e34WnwijgAQXdPa2i7x2rkV7D8TVtRDVD7ag4DRIKWXFdL2dYsvkh2J+X5luu8UTgPy3UAWqW1ZBQ1GrakNwqNKKGk6QQq5EdazTYVWf/+Nd76D3UxYpnYkspdPaaQ9sI575lhmXdGczjZHbJr+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778905526; c=relaxed/simple;
	bh=7GhbxdSY7+sfNr9B19nBc/YPJyog7BtsacD5usebgTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZObqPrsPUa5NNQn7GF6HONNktbj8Oi6zMXlwWPBNjaT0GJmFdkXJWMvrYpf5nkHjtq/oWg6gAxlcWR7ThAEkdJMhdacyyFch6JKIM7jpGy1IIOCwp3Is087C5hxtYzigDLGcmepqGRSWVBLeBOiHXnrjIQFzNkQi60jpUJSt9Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pjkxbbf9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778905523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3vjyTSbf1KtAbtYJwAX+RB0XaZHDboatGaFSQtnfftE=;
	b=Pjkxbbf9mORmqrydjbb9YC+okblA0rqfVoHOmbqFkLZY7/MSJvSpSzxsihE1zxWZz+Wsj1
	e8A01vSW5jQvL5oVhdxD5uYagippJGk9XlDnw2jaLcyX78lJPzFmvip04aCk6//OmEyeBe
	T+Kx6TuSi4MoL6q61DwvUS1cBbx8HzE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-650-wo-uFs6SOmmStEBSYOot4g-1; Sat,
 16 May 2026 00:25:19 -0400
X-MC-Unique: wo-uFs6SOmmStEBSYOot4g-1
X-Mimecast-MFC-AGG-ID: wo-uFs6SOmmStEBSYOot4g_1778905517
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AFA641800367;
	Sat, 16 May 2026 04:25:16 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.2.16.156])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AE8891803A8E;
	Sat, 16 May 2026 04:25:11 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Chen Ridong <chenridong@huaweicloud.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aaron Tomlin <atomlin@atomlin.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH cgroup/for-next v2 1/5] cgroup/cpuset: Add a cpuset_reserve_dl_bw() helper
Date: Sat, 16 May 2026 00:24:44 -0400
Message-ID: <20260516042448.698216-2-longman@redhat.com>
In-Reply-To: <20260516042448.698216-1-longman@redhat.com>
References: <20260516042448.698216-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Queue-Id: 9DA3A55A28E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15990-lists,cgroups=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Extract the DL bandwidth allocation code in cpuset_attach() to a new
cpuset_reserve_dl_bw() helper to simplify code.

No functional change is expected.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 53 ++++++++++++++++++++++++------------------
 1 file changed, 30 insertions(+), 23 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index bcefc9f50ac5..7cae47829013 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2980,6 +2980,25 @@ static int cpuset_can_attach_check(struct cpuset *cs)
 	return 0;
 }
 
+static int cpuset_reserve_dl_bw(struct cpuset *cs)
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
@@ -3050,31 +3069,19 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
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
+	ret = cpuset_reserve_dl_bw(cs);
 
 out_unlock:
-	if (ret)
+	if (ret) {
 		reset_migrate_dl_data(cs);
+	} else {
+		/*
+		 * Mark attach is in progress.  This makes validate_change() fail
+		 * changes which zero cpus/mems_allowed.
+		 */
+		cs->attach_in_progress++;
+	}
+
 	mutex_unlock(&cpuset_mutex);
 	return ret;
 }
-- 
2.54.0


