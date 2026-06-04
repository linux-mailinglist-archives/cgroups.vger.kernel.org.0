Return-Path: <cgroups+bounces-16646-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nDUJB+qYIWqGJgEAu9opvQ
	(envelope-from <cgroups+bounces-16646-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 04 Jun 2026 17:25:30 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B49641670
	for <lists+cgroups@lfdr.de>; Thu, 04 Jun 2026 17:25:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=GOYYNWTI;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16646-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-16646-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7804331B6775
	for <lists+cgroups@lfdr.de>; Thu,  4 Jun 2026 15:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C89533E35F;
	Thu,  4 Jun 2026 15:03:15 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2A433F383
	for <cgroups@vger.kernel.org>; Thu,  4 Jun 2026 15:03:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780585395; cv=none; b=qW0L8TMYJywT0o5Ry4cPTNO5zs2aYjRkjuwBqNHGyQfH5TJzUzFD2SQGTNlioQlJpnA7X+cZuOGz/j1NUeCOUqR0qXuUjl9hzB7ua4NpcIqmntsK0dOHv3hq5xoq/Ye2r/BxL+X/BCMNtkiI5IPDJTgLwPSBLe/tZdG51Zou0Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780585395; c=relaxed/simple;
	bh=5B99D09DdyBmXZ5XDwXOMeMAK7xGYCfxD+zxkPwMjNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NjIkMslZsTUuNKQ4r5ejeF2izdDV74Ge5g7hkD9G2+4ZtuhAZ4zw/Z61PX08vHv9OXfMTFNA37VfMPzu/uqewqhG+bFOXAdWElFN4vU6Cc3WFBxLFwbGwURvMsfsrVfEspIsgAFvpo1St2Bys62sBR4k9OQaFbhtBebvTS9aW84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GOYYNWTI; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780585392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xIDyanHY/OuAC5+5/iBjnUiC6sENK2eFiQwui8IGqGU=;
	b=GOYYNWTI1D7bc5G2shgsYuctZ64U6Z/bArx6fpcRTaH/qmVo6QrhnK1szn0p1BfbnW7dOU
	wiawiFSSH1iSWGn9jyLIzuFVcyy5Ebb9tjrG/RjeuBNrpfLGZKx9Ia3n8YzLitX+cMkvBB
	4NcZsiRs4L/H444+cNxyIOVokZJ53MA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-269-nU2XziAhMgSUVSZYDBhIUA-1; Thu,
 04 Jun 2026 11:03:07 -0400
X-MC-Unique: nU2XziAhMgSUVSZYDBhIUA-1
X-Mimecast-MFC-AGG-ID: nU2XziAhMgSUVSZYDBhIUA_1780585384
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BE3801944CC5;
	Thu,  4 Jun 2026 15:03:04 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.88.175])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A8AA9195608E;
	Thu,  4 Jun 2026 15:03:02 +0000 (UTC)
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
Subject: [PATCH-next v6 4/6] cgroup/cpuset: Make cpuset_attach_old_cs track task group leaders
Date: Thu,  4 Jun 2026 11:02:27 -0400
Message-ID: <20260604150229.414135-5-longman@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-16646-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ridong.chen@linux.dev,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:peterz@infradead.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:atomlin@atomlin.com,m:guopeng.zhang@linux.dev,m:longman@redhat.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 66B49641670

There are two possible ways that migration of tasks from multiple source
cpusets to a target cpuset can happen. Either a multithread application
with threads in different cpusets is wholely moved to a new cpuset
or disabling of v2 cpuset controller will move all the tasks in child
cpusets to the parent cpuset.

In the former case, it is the mm setting of the group leader that really
matters. So cpuset_attach_old_cs should track the oldcs of the thread
leader. In the latter case, effective_mems of child cpusets must always
be a subset of the parent. So no real page migration will be necessary
no matter which child cpuset is selected as cpuset_attach_old_cs.

IOW, cpuset_attach_old_cs should be updated to match the latest task
group leader in cpuset_can_attach(), but fall back to that of the first
task if there is no group leader in the taskset.

Suggested-by: Ridong Chen <ridong.chen@linux.dev>
Reviewed-by: Ridong Chen <ridong.chen@linux.dev>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 90fb40760dcc..e29129467c98 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2978,6 +2978,10 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 	return 0;
 }
 
+/*
+ * cpuset_can_attach() and cpuset_attach() specific internal data
+ * Protected by cpuset_mutex
+ */
 static struct cpuset *cpuset_attach_old_cs;
 
 /*
@@ -3068,11 +3072,32 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 	if (ret)
 		goto out_unlock;
 
+	/*
+	 * The cpuset_attach_old_cs is used mainly by cpuset_migrate_mm() to get
+	 * the old_mems_allowed value. There are two ways that many-to-one
+	 * cpuset migration can happen:
+	 * 1) A multithread application with threads in different cpusets is
+	 *    wholely migrated to a new cpuset.
+	 * 2) Disabling v2 cpuset controller will move all the tasks in child
+	 *    cpusets to the parent cpuset.
+	 *
+	 * In the former case, it is the mm setting of the group leader that
+	 * really matters. So cpuset_attach_old_cs should track the oldcs of the
+	 * group leader. It falls back to the oldcs of the first task if there
+	 * is no group leader in the taskset. In the latter case, effective_mems
+	 * of child cpusets must always be a subset of the parent. So no real
+	 * page migration will be necessary no matter which child cpuset is
+	 * selected as cpuset_attach_old_cs.
+	 */
 	cgroup_taskset_for_each(task, css, tset) {
 		ret = task_can_attach(task);
 		if (ret)
 			goto out_unlock;
 
+		/* Update cpuset_attach_old_cs to the latest group leader */
+		if (task == task->group_leader)
+			cpuset_attach_old_cs = task_cs(task);
+
 		if (setsched_check) {
 			ret = security_task_setscheduler(task);
 			if (ret)
-- 
2.54.0


