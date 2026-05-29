Return-Path: <cgroups+bounces-16469-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4NAmCiQFGmrK0ggAu9opvQ
	(envelope-from <cgroups+bounces-16469-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 23:29:08 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B98F9608DD9
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 23:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2D9EA3033F6E
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 21:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCAAC3B6C11;
	Fri, 29 May 2026 21:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fAdCyinI"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2483B6350
	for <cgroups@vger.kernel.org>; Fri, 29 May 2026 21:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780090145; cv=none; b=nRF1lz8XVFtjMDKzHyRpq8vH2lkIZa/6DBeAJ4D71Qxw5Z4819G6pd0HJCkajStt66uhc3NhsFpmPeR8Np9UWseLvX/NQFl0fw3IsWr0idxfjBnVV/Hq9CIqc+HJx+C9vrZ5nD7n1T76X486IM9nXqp/+XpMtn7N85R6LkOCkNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780090145; c=relaxed/simple;
	bh=LLl8YSsAIOLYo3nmxGvTC6JxMFgJ1qBEOowVfPSxbTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UOT/JIzGoa1NpHIYoFmvunzLC9VJf0505Tixqa+WMXBm2L9DzaY3Tp+GYPWK11zQux8g0lnkqU5ZueEVCc2wvNcvqXDZK9kzihWt/MdC9C1uCIhPPJi0F79zM5CvTXEn6P/LQd1adHHTvlAldzAojO00IJii0ACkWwK/eLL0W/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fAdCyinI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780090138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=no9433L2vTEzwg3X66k17tcFeYU0ZZ98IuFscRMp3x4=;
	b=fAdCyinIiFXvngjfS68phNx+8v6VWntymKJ7/jke/90cUJHfNEj9a+7XENDbM5zFgeXvUi
	eQQTebtOm1yTNzO+f6NOa1bqQmU8voQdULtJ2S9TzJV7nU/uZ/VgrormA4SH/WWaASzoYc
	+vhEHUpHjQUk0kbjL/ckFIDIx+jn3vg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-54-3wmb1PK7MiGmJyc436yqig-1; Fri,
 29 May 2026 17:28:55 -0400
X-MC-Unique: 3wmb1PK7MiGmJyc436yqig-1
X-Mimecast-MFC-AGG-ID: 3wmb1PK7MiGmJyc436yqig_1780090133
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 49F0F18005B9;
	Fri, 29 May 2026 21:28:53 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.64.54])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 355B419560A3;
	Fri, 29 May 2026 21:28:51 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Chen Ridong <chenridong@huaweicloud.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aaron Tomlin <atomlin@atomlin.com>,
	Guopeng Zhang <guopeng.zhang@linux.dev>,
	Waiman Long <longman@redhat.com>,
	Ridong Chen <ridong.chen@linux.dev>
Subject: [PATCH-next v4 4/6] cgroup/cpuset: Made cpuset_attach_old_cs track task group leaders
Date: Fri, 29 May 2026 17:21:06 -0400
Message-ID: <20260529212108.120506-5-longman@redhat.com>
In-Reply-To: <20260529212108.120506-1-longman@redhat.com>
References: <20260529212108.120506-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16469-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linux.dev:email]
X-Rspamd-Queue-Id: B98F9608DD9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
group leader in cpuset_can_attach().

Suggested-by: Ridong Chen <ridong.chen@linux.dev>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 0f93f3d84494..0bb63a9cda0b 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1111,6 +1111,20 @@ static void update_sibling_cpumasks(struct cpuset *parent, struct cpuset *cs,
 /*
  * cpuset_can_attach() and cpuset_attach() specific internal data
  * Protected by cpuset_mutex
+ *
+ * The cpuset_attach_old_cs is used mainly by cpuset_migrate_mm() to get the
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
@@ -3091,6 +3105,10 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
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


