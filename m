Return-Path: <cgroups+bounces-17670-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Bl8eK9CsU2pydQMAu9opvQ
	(envelope-from <cgroups+bounces-17670-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 12 Jul 2026 17:03:44 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3DA74515D
	for <lists+cgroups@lfdr.de>; Sun, 12 Jul 2026 17:03:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=DA6GQSzA;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17670-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17670-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CDA3E302353C
	for <lists+cgroups@lfdr.de>; Sun, 12 Jul 2026 15:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797D033F58E;
	Sun, 12 Jul 2026 15:01:46 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B25335555
	for <cgroups@vger.kernel.org>; Sun, 12 Jul 2026 15:01:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783868506; cv=none; b=gD9324+5lLNRQkf4yRuU4JqAHOHrf4/rX+2uhkuJRMcgGeFeeDYpaHDpJwqiWAPA/qToM3KVlKn/sK5eWutnD55rszSGrYSs5ofNs9aN58rUdfDRwHPkuPrKyc2wDKMf55usmtdx4fcoOD/ArdTUd89DIkj45c0V0/eSPhz0FT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783868506; c=relaxed/simple;
	bh=pHDGywNEMjucH1pm/H1+YHJKdnYw+vQDrwC1wqvPfvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o98z28XkRGMMDlWg1+xSD74F1izxaZ0BlpWDiYVU5uUGsNnMWqE71pKAJR5BTKwgAQ4FY92CVt3jtfMUEvoDkEC/5P4pHPig413bqPmlocR1x78wVsC5KrMHDearzWaCALTPI484W5+E/GjmwgO1BZP4+W1fGBhg4W4KQe+Gc6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DA6GQSzA; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783868502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FB69Y+VvNoTOSkjmMegtswoHj9QUfF0cVIM7Z0B1wYY=;
	b=DA6GQSzAwDLpOkDx3dUfu7+Xa111c1CS6Prp0IABhXry3Oc4tjztSiNaAnLYLiOqANQHm/
	DCg64yZPZv6QrbUVeUPT7UXdjKZhoBMF3sUtoZFuBmcKRd5mTZM7y0AvCyxj1DzglzMt1M
	OANQUoKC2Yt7euBqArF6yEBKb0xORsc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-308-SD9P9dNHOY236uZa85uewA-1; Sun,
 12 Jul 2026 11:01:39 -0400
X-MC-Unique: SD9P9dNHOY236uZa85uewA-1
X-Mimecast-MFC-AGG-ID: SD9P9dNHOY236uZa85uewA_1783868497
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 788BA18009E4;
	Sun, 12 Jul 2026 15:01:37 +0000 (UTC)
Received: from llong-thinkpadp1gen5.rmtusnh.csb (unknown [10.22.80.43])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E73383000B54;
	Sun, 12 Jul 2026 15:01:35 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Ridong Chen <ridong.chen@linux.dev>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Shuah Khan <shuah@kernel.org>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Waiman Long <longman@redhat.com>
Subject: [PATCH-next v2 1/3] cgroup/cpuset: Handle the special case of non-moving tasks in cpuset_can_attach()
Date: Sun, 12 Jul 2026 11:01:25 -0400
Message-ID: <20260712150127.236790-2-longman@redhat.com>
In-Reply-To: <20260712150127.236790-1-longman@redhat.com>
References: <20260712150127.236790-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-17670-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ridong.chen@linux.dev,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:shuah@kernel.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:longman@redhat.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1A3DA74515D

With cgroup v2 migration of a multithreaded process having threads
in different cgroups of a threaded subtree, it is possible that
cpuset_can_attach() can be called with tasks that are not migrating with
respect to cpuset if cpuset controller is not enabled in some of the
subtree cgroups. IOW, the old cpuset can be the same as the new one. This
can cause problem when we need to track the set of old cpusets and the
new cpusets in singly linked lists as a cpuset cannot be in both lists.

As reported by Tejun, the following is an example threaded subtree with
partial cpuset delegation that can cause this issue to show up.

  P (+cpuset)
  |- R (cpuset)        <- destination
  |  `- C (no cpuset)  -> effective cpuset == R
  `- W (cpuset)

Group leader in R, thread_a in C, thread_b in W; migrate the whole
process into R (echo $PID > R/cgroup.procs). thread_a moves C->R:
its cgroup changes so compare_css_sets() keeps it in the taskset, but
its cpuset css is unchanged (C inherits R's), so task_cs() == cs ==
R. cpuset is in ss_mask because thread_b (W->R) changed. can_attach()
then tags R as a source (thread_a) and the destination (thread_b):

Handle this special case by skipping tasks that are not migrating in
cpuset_can_attach() and avoid calling cpuset_can_attach_check() in this
case. By doing so, the destination cpuset will not be put into source
cpuset linked list.

As the source cpuset cannot be easily determined in cpuset_attach(),
unnecessary work can be performed if a task is not actually
migrating. However, no harm will be done except wasting some
CPU cycles. If it happens that none of the tasks is migrating,
attach_ctx.old_cs will be NULL and task iteration won't be needed.

Reported-by: Tejun Heo <tj@kernel.org>
Closes: https://lore.kernel.org/lkml/e254af713b5345aec3d086771ecf1e71@kernel.org
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index cf0d005d2b78..957c80a99fde 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -3134,20 +3134,12 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 	bool setsched_check;
 	int ret;
 
-	/* used later by cpuset_attach() */
-	attach_ctx.old_cs = task_cs(cgroup_taskset_first(tset, &css));
-	oldcs = attach_ctx.old_cs;
-	cs = css_cs(css);
-
+	oldcs = NULL;
 	mutex_lock(&cpuset_mutex);
+	attach_ctx.old_cs = NULL;	/* Used later in cpuset_attach_task() */
 	attach_ctx.cpus_updated = false;
 	attach_ctx.mems_updated = false;
 
-	/* Check to see if task is allowed in the cpuset */
-	ret = cpuset_can_attach_check(cs, oldcs, &setsched_check);
-	if (ret)
-		goto out_unlock;
-
 	/*
 	 * The attach_ctx.old_cs is used mainly by cpuset_migrate_mm() to get
 	 * the old_mems_allowed value. There are two ways that many-to-one
@@ -3164,17 +3156,30 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 	 * of child cpusets must always be a subset of the parent. So no real
 	 * page migration will be necessary no matter which child cpuset is
 	 * selected as attach_ctx.old_cs.
+	 *
+	 * For a v2 threaded subtree where cpuset isn't enabled in some of the
+	 * cgroups, it is possible that oldcs == cs for some of the tasks.
+	 * In this case, we can skip checking on those tasks as there is no
+	 * actual migration wrt cpuset.
 	 */
 	cgroup_taskset_for_each(task, css, tset) {
 		struct cpuset *new_oldcs = task_cs(task);
 
+		cs = css_cs(css);
 		if (new_oldcs != oldcs) {
 			oldcs = new_oldcs;
+			if (oldcs == cs)
+				continue;
+			if (!attach_ctx.old_cs)
+				attach_ctx.old_cs = oldcs;
 			ret = cpuset_can_attach_check(cs, oldcs, &setsched_check);
 			if (ret)
 				goto out_unlock;
 		}
 
+		if (oldcs == cs)
+			continue;
+
 		ret = task_can_attach(task);
 		if (ret)
 			goto out_unlock;
@@ -3312,6 +3317,14 @@ static void cpuset_attach(struct cgroup_taskset *tset)
 	attach_ctx.task_work_queued = false;
 	guarantee_online_mems(cs, &attach_ctx.nodemask_to);
 
+	/*
+	 * attach_ctx.old_cs can only be NULL if no task is actually migrating.
+	 * This is highly unlikely. If it happens at all, there is nothing we
+	 * need to do here.
+	 */
+	if (unlikely(!attach_ctx.old_cs))
+		goto out;
+
 	/*
 	 * In the default hierarchy, enabling cpuset in the child cgroups
 	 * will trigger a cpuset_attach() call with no change in effective cpus
-- 
2.55.0


