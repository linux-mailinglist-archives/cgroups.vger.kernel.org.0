Return-Path: <cgroups+bounces-15081-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iA5zKD3oxmloQAUAu9opvQ
	(envelope-from <cgroups+bounces-15081-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 27 Mar 2026 21:27:41 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1939B34AF13
	for <lists+cgroups@lfdr.de>; Fri, 27 Mar 2026 21:27:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9ABFD30D9443
	for <lists+cgroups@lfdr.de>; Fri, 27 Mar 2026 20:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE773A0E97;
	Fri, 27 Mar 2026 20:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hzqqzcLq"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4B1392C4B
	for <cgroups@vger.kernel.org>; Fri, 27 Mar 2026 20:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774642583; cv=none; b=db9t/T72s64torLPW8hsJOKiu51veiB0jLhKF6r8vj5nCAIPcr/SwEeA0EXuOqpSHFCLNIo6MF5Kz2eWv+Jy7CkSEk9Z2saw1kqQbQ/yebM5ldTXCKKyI1gYDwTD12ojeI+AiowM8EAxysRF5UY//gexytRiRGL15hVexnOwZ1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774642583; c=relaxed/simple;
	bh=UwHGidqQtOhZBXcfMhDwIUf24rh0TsirELntVjjUw9I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Uan5AMSz4rDKgDhzjh9W7Y21yUcEdQfocAFtnrFqS6+bYv7ZZxmWdkwwDTZXU14fxO0D25a8Lu9o9jCV8xZXkQcaAUaokiaOJGO48NbRr/QY/xkWuQGdk8CALcund7tdlkqgbKhXbS1r4eY+7DefPKVEHA64Y5CfK/nEe31w1ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hzqqzcLq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774642581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9O5AV/rkd4Q52cCaHKOLtmgBDJ/7TC2adV5g3Ipf4JE=;
	b=hzqqzcLqpolZBVdZ/HzKCJoVA4oJ4yV+xqvTi3gfBQPUXjizUl9RuXcDgQcmZcBnZC6zRI
	TMXhh/DerbBE4tHfbQ3Ofzr1Y4l6Ism9Ah+o/WH6+FJIJLeGuIQvzoPLWjJ+wjJdUQ8cvP
	3nARLaE2XgjR7QwqVnV/9aCAqbgELTg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-50-aThWYds_P4-Oe7MPm9SHPg-1; Fri,
 27 Mar 2026 16:16:15 -0400
X-MC-Unique: aThWYds_P4-Oe7MPm9SHPg-1
X-Mimecast-MFC-AGG-ID: aThWYds_P4-Oe7MPm9SHPg_1774642574
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 446FB18005BF;
	Fri, 27 Mar 2026 20:16:14 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.90.2])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 82C231800761;
	Fri, 27 Mar 2026 20:16:12 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Chen Ridong <chenridong@huawei.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Waiman Long <longman@redhat.com>
Subject: [PATCH] cgroup/cpuset: Skip security check for hotplug induced v1 task migration
Date: Fri, 27 Mar 2026 16:15:46 -0400
Message-ID: <20260327201546.2463644-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15081-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1939B34AF13
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When a CPU hot removal causes a v1 cpuset to lose all its CPUs, the
cpuset hotplug handler will schedule a work function to migrate tasks
in that cpuset with no CPU to its parent to enable those tasks to
continue running.

If a strict security policy is in place, however, the task migration
may fail when security_task_setscheduler() call in cpuset_can_attach()
returns a -EACCESS error. That will mean that those tasks will have
no CPU to run on. The system administrators will have to explicitly
intervene to either add CPUs to that cpuset or move the tasks elsewhere
if they are aware of it.

This problem was found by a reported test failure in the LTP's
cpuset_hotplug_test.sh. Fix this problem by treating this special case
as an exception to skip the setsched security check as it is initated
internally within the kernel itself instead of from user input. With that
patch applied, the cpuset_hotplug_test.sh test can be run successfully
without failure.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index d21868455341..88ce7ed91cd1 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2989,6 +2989,7 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 	struct cpuset *cs, *oldcs;
 	struct task_struct *task;
 	bool cpus_updated, mems_updated;
+	bool kthread_move_task_from_empty_cs;
 	int ret;
 
 	/* used later by cpuset_attach() */
@@ -3006,6 +3007,14 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 	cpus_updated = !cpumask_equal(cs->effective_cpus, oldcs->effective_cpus);
 	mems_updated = !nodes_equal(cs->effective_mems, oldcs->effective_mems);
 
+	/*
+	 * Set to true if a kthread is moving tasks away from a v1 cpuset with
+	 * no CPUs
+	 */
+	kthread_move_task_from_empty_cs = !cpuset_v2() &&
+					  cpumask_empty(oldcs->effective_cpus) &&
+					  (current->flags & PF_KTHREAD);
+
 	cgroup_taskset_for_each(task, css, tset) {
 		ret = task_can_attach(task);
 		if (ret)
@@ -3015,8 +3024,15 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 		 * Skip rights over task check in v2 when nothing changes,
 		 * migration permission derives from hierarchy ownership in
 		 * cgroup_procs_write_permission()).
+		 *
+		 * In the special case of forced cpuset1 task migration to
+		 * parent via workqueue because of empty cpuset.cpus caused by
+		 * hotplug, skip the task check to prevent restrictive security
+		 * policy from denying the task migration. Otherwise those
+		 * tasks will have no CPU to run on.
 		 */
-		if (!cpuset_v2() || (cpus_updated || mems_updated)) {
+		if (!kthread_move_task_from_empty_cs &&
+		   (!cpuset_v2() || cpus_updated || mems_updated)) {
 			ret = security_task_setscheduler(task);
 			if (ret)
 				goto out_unlock;
-- 
2.53.0


