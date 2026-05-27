Return-Path: <cgroups+bounces-16354-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CA/FI1UQF2o12wcAu9opvQ
	(envelope-from <cgroups+bounces-16354-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 17:40:05 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D9B85E7056
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 17:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A69E230594D7
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 15:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1DF3EE1C6;
	Wed, 27 May 2026 15:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="acxUL2c6"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDB9436379
	for <cgroups@vger.kernel.org>; Wed, 27 May 2026 15:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779896338; cv=none; b=f8RAhyd3Bky+i1F/4FWbnnbHNTKLSUqAmGcep7g4encznNAW+bowBOXVvaMkziOTay6KOxRd/SEElXCenbhyrgu/NN73ON4Jj5tLRVJ9TIw1aPa16ymKRwzeqyDXBB/v/jfESlBV/UFJtvNvkBaMQeWlF2OvBqi8hnT2eizxLvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779896338; c=relaxed/simple;
	bh=OLNffvkgl1ovsnrqb2K6N6l8f/aTUdIpEwwjy4z02ME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p0RhAweGBIDpcRheWmeClad9NVghUdWypNEBJXNwNy+J1VhRl9+e5uVdb2aEjK/tENp2KFSlw2/5WrE6AWRKoNWnZasts2KLUaToxI/yvuykmB4XZL+yDvaWpF50/uJvVBO6VU8zfsBE8/Vd8LrbBfKSs/6p18j+a8foq/7Iq8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=acxUL2c6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779896336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rpJVZBPFGZbIsRP5AHhxkSw+X6Ro5peC0Xs5UJEJH3E=;
	b=acxUL2c6K2BW3GZ6wMF8mkml7LQbxWTHpuFVeRoavfWmu063mch/oGlWT/wTeW3bUB+Dxh
	arI//3vg5v3e6sPt4op0dZUB5sfd5ifMEmEeMjNU36YmKTkx93GIhxGRSgKdasRL4CXgfk
	oU1yJmWT913Ep4gmGbJWGA3284d89D8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-561-pmwdyfNcPFW0sLw2OOJRDQ-1; Wed,
 27 May 2026 11:38:51 -0400
X-MC-Unique: pmwdyfNcPFW0sLw2OOJRDQ-1
X-Mimecast-MFC-AGG-ID: pmwdyfNcPFW0sLw2OOJRDQ_1779896330
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C58AF19560A6;
	Wed, 27 May 2026 15:38:49 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.81.53])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 10A081800465;
	Wed, 27 May 2026 15:38:47 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Chen Ridong <chenridong@huaweicloud.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aaron Tomlin <atomlin@atomlin.com>,
	Waiman Long <longman@redhat.com>,
	Ridong Chen <ridong.chen@linux.dev>
Subject: [PATCH-next v3 3/5] cgroup/cpuset: Made cpuset_attach_old_cs track task group leaders
Date: Wed, 27 May 2026 11:37:58 -0400
Message-ID: <20260527153800.1557449-4-longman@redhat.com>
In-Reply-To: <20260527153800.1557449-1-longman@redhat.com>
References: <20260527153800.1557449-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16354-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linux.dev:email]
X-Rspamd-Queue-Id: 2D9B85E7056
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

There are two possible ways that migration of tasks from multiple source
cpusets to a target cpuset can happen. Either a multithread application
with threads in different cpusets is wholely moved to a new cpuset
or disabling of v2 cpuset controller will move all the tasks in child
cpusets to the parent cpuset.

In the former case, t is the mm setting of the group leader that really
matters. So cpuset_attach_old_cs should track the oldcs of the thread
leader. In the latter case, effective_mems of child cpusets must always
be a subset of the parent. So no real page migration will be necessary
no matter which child cpuset is selected as cpuset_attach_old_cs.

IOW, cpuset_attach_old_cs should be updated to match the latest task
group leader in cpuset_can_attach().

Suggested-by: Ridong Chen <ridong.chen@linux.dev>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 4457c4f11fce..b233a71f9b7c 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2967,6 +2967,20 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 /*
  * cpuset_can_attach() and cpuset_attach() specific internal data
  * Protected by cpuset_mutex
+ *
+ * The cpuset_attach_old_cs is used mainly by cpuset_migrate_mm() tp get the
+ * old_mems_allowed value. There are two ways that many-to-one cpuset migration
+ * can happen:
+ * 1) A multithread application with threads in different cpusets is wholely
+ *    moved to a new cpuset.
+ * 2) Disabling v2 cpuset controller will move all the tasks in child cpusets
+ *    to the parent cpuset.
+ *
+ * In the former case, it is the mm setting of the group leader that really
+ * matters. So cpuset_attach_old_cs should track the oldcs of the thread
+ * leader. In the latter case, effective_mems of child cpusets must always
+ * be a subset of the parent. So no real page migration will be necessary no
+ * matter which child cpuset is selected as cpuset_attach_old_cs.
  */
 static struct cpuset *cpuset_attach_old_cs;
 static bool attach_cpus_updated;
@@ -3069,6 +3083,10 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
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


