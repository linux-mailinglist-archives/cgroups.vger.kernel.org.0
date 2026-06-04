Return-Path: <cgroups+bounces-16645-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id H10HLxuXIWoFJgEAu9opvQ
	(envelope-from <cgroups+bounces-16645-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 04 Jun 2026 17:17:47 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C0364157C
	for <lists+cgroups@lfdr.de>; Thu, 04 Jun 2026 17:17:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=AzWpTHuC;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16645-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16645-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A2E3431B0FD4
	for <lists+cgroups@lfdr.de>; Thu,  4 Jun 2026 15:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40BBC344046;
	Thu,  4 Jun 2026 15:03:14 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB80130C15C
	for <cgroups@vger.kernel.org>; Thu,  4 Jun 2026 15:03:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780585394; cv=none; b=SCgLxZWdUD2tiZzQ8ZyD/j/sNZfoEwp+JQTy8Z5Y7f9j4YzQETo2Qr7OA3/3T7M2cc6HOElWqE447WxTUrDsD61gzXjHVvzxFdPcBs23AvQRx7rnLyh07QPxnjV6gHGza9uRZbia2bAjFjurgdiFkusgMkZEx5ovXry7gvz0Sg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780585394; c=relaxed/simple;
	bh=Web3NhGOEgJly7BqxpjC+2T3f6MY2rQiRKu4qUJn/Ho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bja9ZEa+dZqpXUzwDOow3gIXrX6Z6X6d3xgshvVwBVzckAvHHlnHsI/kS9VSfeumSEaFJBnf0M+w2HL/1I5GUXBNer5U+9UlULP6Cdlrlks1qZ0CZzg5b/341pIUSRBrmHDO+ggUUxQ3ewZf8lFJqaqdB/pzVK99+PxWXhZyPTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AzWpTHuC; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780585391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JxdjWzovNnqXR2QwuqvSpwhzvQnZWNNgULA2P9EiwMk=;
	b=AzWpTHuCFcdW9BQeUzet5KVOzGR3GcFe2rVy9PnRJzn5luC9/4XMU7/RUKkpAasY7iNyoa
	2URXijjqBEgYHEXGm5NFtgVa9zKgifxgVPwuvXgK6aFVISKrHzZFVr/AwJzcbf0SKtAyQB
	3pqTjJgV+vHAhbozq7QUhVJcoXsLrUA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-634-uCFo5UABNVOyAg9Yf1O8NQ-1; Thu,
 04 Jun 2026 11:03:05 -0400
X-MC-Unique: uCFo5UABNVOyAg9Yf1O8NQ-1
X-Mimecast-MFC-AGG-ID: uCFo5UABNVOyAg9Yf1O8NQ_1780585382
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6FCD61801BEC;
	Thu,  4 Jun 2026 15:03:02 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.88.175])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 50738195608E;
	Thu,  4 Jun 2026 15:03:00 +0000 (UTC)
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
Subject: [PATCH-next v6 3/6] cgroup/cpuset: Expand the scope of cpuset_can_attach_check()
Date: Thu,  4 Jun 2026 11:02:26 -0400
Message-ID: <20260604150229.414135-4-longman@redhat.com>
In-Reply-To: <20260604150229.414135-1-longman@redhat.com>
References: <20260604150229.414135-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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
	TAGGED_FROM(0.00)[bounces-16645-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ridong.chen@linux.dev,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:peterz@infradead.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:atomlin@atomlin.com,m:guopeng.zhang@linux.dev,m:longman@redhat.com,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[10];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 19C0364157C

Expand the scope of cpuset_can_attach_check() by including the setting
of setsched flag inside cpuset_can_attach_check() with the new @oldcs
and @psetsched argument. As cpuset_can_attach_check() is also called
from cpuset_can_fork(), set the new arguments to NULL from that caller.

Reviewed-by: Ridong Chen <ridong.chen@linux.dev>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 52 ++++++++++++++++++++++++------------------
 1 file changed, 30 insertions(+), 22 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 7c23d26a04fc..90fb40760dcc 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2985,12 +2985,39 @@ static struct cpuset *cpuset_attach_old_cs;
  * For v1, cpus_allowed and mems_allowed can't be empty.
  * For v2, effective_cpus can't be empty.
  * Note that in v1, effective_cpus = cpus_allowed.
+ *
+ * Also set the boolean flag passed in by @psetsched depending on if
+ * security_task_setscheduler() call is needed and @oldcs is not NULL.
  */
-static int cpuset_can_attach_check(struct cpuset *cs)
+static int cpuset_can_attach_check(struct cpuset *cs, struct cpuset *oldcs,
+				   bool *psetsched)
 {
 	if (cpumask_empty(cs->effective_cpus) ||
 	   (!is_in_v2_mode() && nodes_empty(cs->mems_allowed)))
 		return -ENOSPC;
+
+	if (!oldcs)
+		return 0;
+
+	/*
+	 * Skip rights over task setsched check in v2 when nothing changes,
+	 * migration permission derives from hierarchy ownership in
+	 * cgroup_procs_write_permission()).
+	 */
+	*psetsched = !cpuset_v2() ||
+		!cpumask_equal(cs->effective_cpus, oldcs->effective_cpus) ||
+		!nodes_equal(cs->effective_mems, oldcs->effective_mems);
+
+	/*
+	 * A v1 cpuset with tasks will have no CPU left only when CPU hotplug
+	 * brings the last online CPU offline as users are not allowed to empty
+	 * cpuset.cpus when there are active tasks inside. When that happens,
+	 * we should allow tasks to migrate out without security check to make
+	 * sure they will be able to run after migration.
+	 */
+	if (!is_in_v2_mode() && cpumask_empty(oldcs->effective_cpus))
+		*psetsched = false;
+
 	return 0;
 }
 
@@ -3037,29 +3064,10 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 	mutex_lock(&cpuset_mutex);
 
 	/* Check to see if task is allowed in the cpuset */
-	ret = cpuset_can_attach_check(cs);
+	ret = cpuset_can_attach_check(cs, oldcs, &setsched_check);
 	if (ret)
 		goto out_unlock;
 
-	/*
-	 * Skip rights over task setsched check in v2 when nothing changes,
-	 * migration permission derives from hierarchy ownership in
-	 * cgroup_procs_write_permission()).
-	 */
-	setsched_check = !cpuset_v2() ||
-		!cpumask_equal(cs->effective_cpus, oldcs->effective_cpus) ||
-		!nodes_equal(cs->effective_mems, oldcs->effective_mems);
-
-	/*
-	 * A v1 cpuset with tasks will have no CPU left only when CPU hotplug
-	 * brings the last online CPU offline as users are not allowed to empty
-	 * cpuset.cpus when there are active tasks inside. When that happens,
-	 * we should allow tasks to migrate out without security check to make
-	 * sure they will be able to run after migration.
-	 */
-	if (!is_in_v2_mode() && cpumask_empty(oldcs->effective_cpus))
-		setsched_check = false;
-
 	cgroup_taskset_for_each(task, css, tset) {
 		ret = task_can_attach(task);
 		if (ret)
@@ -3604,7 +3612,7 @@ static int cpuset_can_fork(struct task_struct *task, struct css_set *cset)
 	mutex_lock(&cpuset_mutex);
 
 	/* Check to see if task is allowed in the cpuset */
-	ret = cpuset_can_attach_check(cs);
+	ret = cpuset_can_attach_check(cs, NULL, NULL);
 	if (ret)
 		goto out_unlock;
 
-- 
2.54.0


