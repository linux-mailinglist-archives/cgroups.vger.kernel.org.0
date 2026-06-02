Return-Path: <cgroups+bounces-16541-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8JivHC1BHmraiAkAu9opvQ
	(envelope-from <cgroups+bounces-16541-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 02 Jun 2026 04:34:21 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D14DC627486
	for <lists+cgroups@lfdr.de>; Tue, 02 Jun 2026 04:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6ABB7307679B
	for <lists+cgroups@lfdr.de>; Tue,  2 Jun 2026 02:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086F5369219;
	Tue,  2 Jun 2026 02:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eIrZd/Fw"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF6436495B
	for <cgroups@vger.kernel.org>; Tue,  2 Jun 2026 02:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780367549; cv=none; b=KAbZggiASLwdk/DeDw3OxAYbqVnhCM/tRwSWKkBOGFasVWYESVbri6Vj+JJ7VytfjC5jx17St63Q7D2+f/eS9AQ1uULaYqEOT0ZMCSqqaeFlXieA5pSJlPUFkTWJhbwju8qQKoS/1gFc+Xmovpk8hwAJxon01OKlzQDkhlqzJ2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780367549; c=relaxed/simple;
	bh=e0tF03sz0fkUMkvZhKDfyygUxl+jIyGjwPqmI6JduJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dKFWuHEQkuTFPproXedy5vuej7VR42OX4+E3BlPi9OAaiuqbvzpizh2DgNbU4IjTgGWVLwfWRsNeT3/Q6KMcG3zrNyP2rCjjCZb53Ai2/QyX2p2eZSZjo9X50JF556stgnhM0ZDWR2456C6w/Wa+2Dbjaub6pRi2eb/DbIkm5QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eIrZd/Fw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780367547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P766uOaEzf7FaP4mrGt+IxDVIY80/uF6sL77FXvH+7k=;
	b=eIrZd/Fwfv728SYPkvFNMvpY9jZCnphQqIPYPKz86xAqV5d6GSXrpMkxIEMbZqGMkOkvGG
	QWRPS7nMam2kVfJvqzsCMBUnXnlRsFCXJ/8gZ7NTN6mMnhK1EhM+mbeCpbK+HuNY2azaHc
	6vNVUbRS69UTJb7TRYdVO12IYHmmCxw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-600-4bpSQxgyMESgmowRTR4PNg-1; Mon,
 01 Jun 2026 22:32:24 -0400
X-MC-Unique: 4bpSQxgyMESgmowRTR4PNg-1
X-Mimecast-MFC-AGG-ID: 4bpSQxgyMESgmowRTR4PNg_1780367542
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C257F195608F;
	Tue,  2 Jun 2026 02:32:22 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.88.124])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EB5E019560A7;
	Tue,  2 Jun 2026 02:32:20 +0000 (UTC)
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
Subject: [PATCH-next v5 4/6] cgroup/cpuset: Make cpuset_attach_old_cs track task group leaders
Date: Mon,  1 Jun 2026 22:32:01 -0400
Message-ID: <20260602023203.248077-5-longman@redhat.com>
In-Reply-To: <20260602023203.248077-1-longman@redhat.com>
References: <20260602023203.248077-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-16541-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: D14DC627486
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
group leader in cpuset_can_attach(), but fall back to that of the first
task if there is no group leader in the taskset.

Suggested-by: Ridong Chen <ridong.chen@linux.dev>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 5c777b1237a8..60e8149cc907 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2975,6 +2975,10 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 	return 0;
 }
 
+/*
+ * cpuset_can_attach() and cpuset_attach() specific internal data
+ * Protected by cpuset_mutex
+ */
 static struct cpuset *cpuset_attach_old_cs;
 
 /*
@@ -3065,11 +3069,32 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
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


