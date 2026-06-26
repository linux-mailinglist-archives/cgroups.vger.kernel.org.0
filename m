Return-Path: <cgroups+bounces-17350-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +4T8KjXHPmpJLgkAu9opvQ
	(envelope-from <cgroups+bounces-17350-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 26 Jun 2026 20:38:45 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83FDE6CFBA8
	for <lists+cgroups@lfdr.de>; Fri, 26 Jun 2026 20:38:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=U5WYEQ1g;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17350-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17350-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DC95D304439E
	for <lists+cgroups@lfdr.de>; Fri, 26 Jun 2026 18:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730AA3B895D;
	Fri, 26 Jun 2026 18:38:06 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2923B8D40
	for <cgroups@vger.kernel.org>; Fri, 26 Jun 2026 18:38:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782499086; cv=none; b=p5cLKsGRAVWh7rUYh8OBGFW3j+/h5eK/Uuzz80qKy8mp2Thn0a2BmNRsk1zTzsXlpWVr42jPIgWFa69zlbqGKZfOw3CJqbxUn+R4HWtOsitO9aLclWDo784TIV1Lz1b1VZq5OE1CXANlmH81FemW4oSMrCu8R1DYTtbxlQNV6mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782499086; c=relaxed/simple;
	bh=Gs6mbfrdBmFcPfxIGQpGRYkRJypGTZA8RHJBoaD+4nk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JpDpKYh8OHlpvr9PkswvSes5Kz77bUhF8QQEcjzxPe7L5qS4/aZ3bvz7oZw5w37EGJR/b9YSOwzlNZulWpuJxlC7aOcPHCNk7HxA/0vXb7fXc5qvREgjyxxUC4nMhjVio0R1SM6cVdVYCh+MgGUaThAiLAsfFOqp4cHottaztJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U5WYEQ1g; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782499084;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FR85SqjTioxEOnr06yRon6rto8Olp0PTbmWX15TMEEU=;
	b=U5WYEQ1gWZsoXcudZmoZHEA4l30agDnYDaWKC9TGOC9/+g4EU1jMyFf2cQXCdWH3Fl+Wyi
	7riHZPi1VKaJnhSVYY1y4qw4KggH+m/QoWRNfQUYk6N3KIPCAKZEgmd7mJAp3k41vufFJ/
	UvTdmpzKkpRwJsxD3esTBVKCQdW+dbs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-447-gZz9MSDAMQiY_jRPd4egBA-1; Fri,
 26 Jun 2026 14:37:58 -0400
X-MC-Unique: gZz9MSDAMQiY_jRPd4egBA-1
X-Mimecast-MFC-AGG-ID: gZz9MSDAMQiY_jRPd4egBA_1782499076
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 79B571954AE1;
	Fri, 26 Jun 2026 18:37:56 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.2.16.156])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8C02619560A3;
	Fri, 26 Jun 2026 18:37:52 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Ridong Chen <ridong.chen@linux.dev>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Farhad Alemi <farhad.alemi@berkeley.edu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Aaron Tomlin <atomlin@atomlin.com>,
	Guopeng Zhang <guopeng.zhang@linux.dev>,
	Gregory Price <gourry@gourry.net>,
	David Hildenbrand <david@kernel.org>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH v8 07/11] cgroup/cpuset: Make attach_ctx.old_cs track task group leader
Date: Fri, 26 Jun 2026 14:19:19 -0400
Message-ID: <20260626181923.133658-8-longman@redhat.com>
In-Reply-To: <20260626181923.133658-1-longman@redhat.com>
References: <20260626181923.133658-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17350-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ridong.chen@linux.dev,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:farhad.alemi@berkeley.edu,m:akpm@linux-foundation.org,m:shuah@kernel.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:atomlin@atomlin.com,m:guopeng.zhang@linux.dev,m:gourry@gourry.net,m:david@kernel.org,m:longman@redhat.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 83FDE6CFBA8

There are two possible ways that migration of tasks from multiple source
cpusets to a target cpuset can happen. Either a multithread application
with threads in different cpusets is wholely migrated to a new cpuset
or disabling of v2 cpuset controller will move all the tasks in child
cpusets to the parent cpuset.

In the former case, it is the mm setting of the group leader that
really matters. So attach_ctx.old_cs should track the oldcs of the
thread leader. In the latter case, effective_mems of child cpusets
must always be a subset of the parent. So no real page migration
will not be necessary no matter which child cpuset is selected as
attach_ctx.old_cs.

IOW, attach_ctx.old_cs should be updated to match the latest task
group leader in cpuset_can_attach(), but fall back to that of the first
task if there is no group leader in the taskset.

Suggested-by: Ridong Chen <ridong.chen@linux.dev>
Signed-off-by: Waiman Long <longman@redhat.com>
Reviewed-by: Ridong Chen <ridong.chen@linux.dev>
---
 kernel/cgroup/cpuset.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 05a81839966b..e830ba13be9b 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -3086,11 +3086,32 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 	if (ret)
 		goto out_unlock;
 
+	/*
+	 * The attach_ctx.old_cs is used mainly by cpuset_migrate_mm() to get
+	 * the old_mems_allowed value. There are two ways that many-to-one
+	 * cpuset migration can happen:
+	 * 1) A multithread application with threads in different cpusets is
+	 *    wholely migrated to a new cpuset.
+	 * 2) Disabling v2 cpuset controller will move all the tasks in child
+	 *    cpusets to the parent cpuset.
+	 *
+	 * In the former case, it is the mm setting of the group leader that
+	 * really matters. So attach_ctx.old_cs should track the oldcs of the
+	 * group leader. It falls back to the oldcs of the first task if there
+	 * is no group leader in the taskset. In the latter case, effective_mems
+	 * of child cpusets must always be a subset of the parent. So no real
+	 * page migration will be necessary no matter which child cpuset is
+	 * selected as attach_ctx.old_cs.
+	 */
 	cgroup_taskset_for_each(task, css, tset) {
 		ret = task_can_attach(task);
 		if (ret)
 			goto out_unlock;
 
+		/* Update attach_ctx.old_cs to the latest group leader */
+		if (task == task->group_leader)
+			attach_ctx.old_cs = task_cs(task);
+
 		if (setsched_check) {
 			ret = security_task_setscheduler(task);
 			if (ret)
-- 
2.54.0


