Return-Path: <cgroups+bounces-16653-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zXpFODYSImq8SAEAu9opvQ
	(envelope-from <cgroups+bounces-16653-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 05 Jun 2026 02:03:02 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C99AB64413C
	for <lists+cgroups@lfdr.de>; Fri, 05 Jun 2026 02:03:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=UOmN4jjB;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16653-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16653-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ABD36300FB28
	for <lists+cgroups@lfdr.de>; Fri,  5 Jun 2026 00:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42986EACD;
	Fri,  5 Jun 2026 00:02:57 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03A8A59
	for <cgroups@vger.kernel.org>; Fri,  5 Jun 2026 00:02:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780617777; cv=none; b=cYAbw3L0iG/ihWl47A1oypHS/HvOMM2/1GoJCabk6vG/OyL3zMiyLAgTpBaxLQWzAx4sDJE1ECjEBLgwNKf4ZVxp0vYOKvrdR1DeArf3N+gR7P/dRXqZ+aivvVul1iReDOObr3pEouL4OU/NFMlSRWOb+SU2Ab06NJV59bmiSRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780617777; c=relaxed/simple;
	bh=P9p+dDC1Pm0NxCW9h9JkGjTDMxVUUWDqx8OgsaK0rY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=igFu3uQ1xyUCXqEy+dIjYDJglZG5gw+1X2H8Ncduv0kETR2so0SdEqOFKypW3v5wHkr8Kd21FuQUnDA46N+wscj6uf9ET02hzegqzNOB5e8vKj0Qy5Q4QlakZ4KUQvY1RUeJxO7u2tFAdtl84sKYAccMtXRG7UpcNF4emADC+jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UOmN4jjB; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780617774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=utEQQW0nk2SmWoR5Bw701AMJOQWS7AJnnjatBLSvYJY=;
	b=UOmN4jjBhHm50SiScsndzet0ess5OaODiCWYF/RZfA4gZuwHA5tCd8TpXQbu9SV8zcCfv/
	K4A59ocpKnw+QclikGkGRueJwgfDHarhQjg37OmiTxHjbHZRCDjmUrNm2T0CxmIbzoua5X
	nhrylziMkgnU10hC02Ukc7sjkv9PqUA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-463-zyIxCLm8Mx-2AZh2XlUDew-1; Thu,
 04 Jun 2026 20:02:51 -0400
X-MC-Unique: zyIxCLm8Mx-2AZh2XlUDew-1
X-Mimecast-MFC-AGG-ID: zyIxCLm8Mx-2AZh2XlUDew_1780617769
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8F65218005B6;
	Fri,  5 Jun 2026 00:02:48 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.88.175])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0AF21414;
	Fri,  5 Jun 2026 00:02:45 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Ridong Chen <ridong.chen@linux.dev>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aaron Tomlin <atomlin@atomlin.com>,
	Guopeng Zhang <guopeng.zhang@linux.dev>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH-next v6 7/6] cgroup/cpuset: Set old_mems_allowed from guarantee_online_mems() consistently
Date: Thu,  4 Jun 2026 20:02:24 -0400
Message-ID: <20260605000224.451246-1-longman@redhat.com>
In-Reply-To: <20260604150229.414135-1-longman@redhat.com>
References: <20260604150229.414135-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:ridong.chen@linux.dev,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:peterz@infradead.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:atomlin@atomlin.com,m:guopeng.zhang@linux.dev,m:longman@redhat.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16653-lists,cgroups=lfdr.de];
	FORGED_SENDER(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C99AB64413C

An earlier patch has added an optimization in guarantee_online_mems()
to just return effective_mems for v2. However there is a short window
during memory hotunplug operation that it can return a nodemask with
no online node leading to possible memory OOM. To avoid this scenario,
though highly unlikely, the optimization is dropped.

Also set old_mems_allowed of the cpuset structure consistently with
the output of guarantee_online_mems() whenever an attach or a related
operation is in progress.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index d624cd0a1e04..5dabe9d040e9 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -502,10 +502,6 @@ static void guarantee_active_cpus(struct task_struct *tsk,
  */
 static void guarantee_online_mems(struct cpuset *cs, nodemask_t *pmask)
 {
-	if (cpuset_v2()) {
-		*pmask = cs->effective_mems;
-		return;
-	}
 	while (!nodes_and(*pmask, cs->effective_mems, node_states[N_MEMORY]))
 		cs = parent_cs(cs);
 }
@@ -3350,22 +3346,24 @@ static void cpuset_attach(struct cgroup_taskset *tset)
 	}
 
 	cs = css_cs(css);
+	guarantee_online_mems(cs, &cpuset_attach_nodemask_to);
+
 	/*
 	 * In the default hierarchy, enabling cpuset in the child cgroups
 	 * will trigger a cpuset_attach() call with no change in effective cpus
 	 * and mems. In that case, we can optimize out by skipping the task
 	 * iteration and update, but the destination cpuset list is iterated to
-	 * set old_mems_sllowed.
+	 * set old_mems_allowed.
 	 */
-	if (cpuset_v2()) {
-		cpuset_attach_nodemask_to = cs->effective_mems;
-		if (!attach_cpus_updated && !attach_mems_updated) {
-			llist_for_each_entry(cs, dst_cs_head.first, attach_node)
-				cs->old_mems_allowed = cs->effective_mems;
-			goto out;
+	if (cpuset_v2() && !attach_cpus_updated && !attach_mems_updated) {
+		struct cpuset *tcs;
+
+		llist_for_each_entry(tcs, dst_cs_head.first, attach_node) {
+			if (tcs == cs)
+				continue;
+			guarantee_online_mems(tcs, &tcs->old_mems_allowed);
 		}
-	} else {
-		guarantee_online_mems(cs, &cpuset_attach_nodemask_to);
+		goto out;
 	}
 
 	cgroup_taskset_for_each(task, css, tset) {
@@ -3381,8 +3379,8 @@ static void cpuset_attach(struct cgroup_taskset *tset)
 
 	if (queue_task_work)
 		schedule_flush_migrate_mm();
-	cs->old_mems_allowed = cpuset_attach_nodemask_to;
 out:
+	cs->old_mems_allowed = cpuset_attach_nodemask_to;
 	reset_attach_in_progress();
 	clear_attach_data(false);
 	mutex_unlock(&cpuset_mutex);
@@ -3824,6 +3822,8 @@ static void cpuset_fork(struct task_struct *task)
 	/* CLONE_INTO_CGROUP */
 	mutex_lock(&cpuset_mutex);
 	guarantee_online_mems(cs, &cpuset_attach_nodemask_to);
+	cs->old_mems_allowed = cpuset_attach_nodemask_to;
+
 	/*
 	 * Assume CPUs and memory nodes are updated
 	 * A CLONE_INTO_CGROUP operation should have taken the cgroup mutex
-- 
2.54.0


