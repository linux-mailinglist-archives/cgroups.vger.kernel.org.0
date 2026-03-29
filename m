Return-Path: <cgroups+bounces-15096-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Jh7LlBkyWlXxwUAu9opvQ
	(envelope-from <cgroups+bounces-15096-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 29 Mar 2026 19:41:36 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8B735365D
	for <lists+cgroups@lfdr.de>; Sun, 29 Mar 2026 19:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A76C2302C6D1
	for <lists+cgroups@lfdr.de>; Sun, 29 Mar 2026 17:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504B63859FC;
	Sun, 29 Mar 2026 17:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OmZ70iC0"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162BB38655D
	for <cgroups@vger.kernel.org>; Sun, 29 Mar 2026 17:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774806020; cv=none; b=Z8Kpc+GPIeOF04TOlR9FdPa+PvD4xoHEyifSeWvLMgUbHFWo5E0igURDlxzlQD699SeuGBGrRNjfISpwrgScuN3ZotrSQz6pP0vUgS9gcGXINpAvNdWwaBXHUQhR6HK2fEIhChVVZbhgHNZGJbt6FjqvdrwBp0KExdC5aqpBCCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774806020; c=relaxed/simple;
	bh=af5FS7aH6ycz5uhw1iiYzwZOSp7R9NC8fQ3SwU79FCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yxc2NWRMxocFKp41sB7bwRk31FqvZ+b3gHWA1dVjiAd7qETjFEAhYxilGkTCCWnyku+aApQnMp0F7xgnSf3sxW7F89UDSIJH/tyDeUhfFdgywdxi/9l0c/2VL+Z5GAoi11cM5rx4UBqWx3no3iSkpKjimCCIUDCCpTxPX4u3zo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OmZ70iC0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774806017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NzNlRR4r4LS+8lLlmBQyOyMhjPBuedud46GINMqUfas=;
	b=OmZ70iC0ba5DZpvZuThrE5XhdPmvBQYDhIhmcpjyYcJRJ48+J74eaGdt+tt/SM4hbBRJrx
	3T4HRYxD/apzeWafiQloLHdNI4HbtMz/MiiTODU5xwauyPgm68EfnxQK+iKmXpgHRu1uyn
	u/Nfd86Swd26VcRk95oAmogE1ICwkQc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-335-JbtemHT-MPmiF57KR9ykLQ-1; Sun,
 29 Mar 2026 13:40:13 -0400
X-MC-Unique: JbtemHT-MPmiF57KR9ykLQ-1
X-Mimecast-MFC-AGG-ID: JbtemHT-MPmiF57KR9ykLQ_1774806012
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 496081800283;
	Sun, 29 Mar 2026 17:40:12 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.80.75])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E3D7219560AB;
	Sun, 29 Mar 2026 17:40:10 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Chen Ridong <chenridong@huawei.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Waiman Long <longman@redhat.com>
Subject: [PATCH v2 2/3] cgroup/cpuset: Skip security check for hotplug induced v1 task migration
Date: Sun, 29 Mar 2026 13:39:57 -0400
Message-ID: <20260329173958.2634925-3-longman@redhat.com>
In-Reply-To: <20260329173958.2634925-1-longman@redhat.com>
References: <20260329173958.2634925-1-longman@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15096-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cpuset_hotplug_test.sh:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5F8B735365D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When a CPU hot removal causes a v1 cpuset to lose all its CPUs, the
cpuset hotplug handler will schedule a work function to migrate tasks
in that cpuset with no CPU to its ancestor to enable those tasks to
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
internally within the kernel itself instead of from user input. Do that
by setting a new one-off CS_TASKS_OUT flag in the affected cpuset by the
hotplug handler to allow cpuset_can_attach() to skip the security check.

With that patch applied, the cpuset_hotplug_test.sh test can be run
successfully without failure.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset-internal.h |  1 +
 kernel/cgroup/cpuset-v1.c       |  3 +++
 kernel/cgroup/cpuset.c          | 14 ++++++++++++++
 3 files changed, 18 insertions(+)

diff --git a/kernel/cgroup/cpuset-internal.h b/kernel/cgroup/cpuset-internal.h
index fd7d19842ded..75e2c20249ad 100644
--- a/kernel/cgroup/cpuset-internal.h
+++ b/kernel/cgroup/cpuset-internal.h
@@ -46,6 +46,7 @@ typedef enum {
 	CS_SCHED_LOAD_BALANCE,
 	CS_SPREAD_PAGE,
 	CS_SPREAD_SLAB,
+	CS_TASKS_OUT,
 } cpuset_flagbits_t;
 
 /* The various types of files and directories in a cpuset file system */
diff --git a/kernel/cgroup/cpuset-v1.c b/kernel/cgroup/cpuset-v1.c
index 7308e9b02495..0c818edd0a1d 100644
--- a/kernel/cgroup/cpuset-v1.c
+++ b/kernel/cgroup/cpuset-v1.c
@@ -322,6 +322,9 @@ void cpuset1_hotplug_update_tasks(struct cpuset *cs,
 			return;
 		}
 
+		/* Enable task removal without security check */
+		set_bit(CS_TASKS_OUT, &cs->flags);
+
 		s->cs = cs;
 		INIT_WORK(&s->work, cpuset_migrate_tasks_workfn);
 		schedule_work(&s->work);
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 58c5b7b72cca..24d3ceef7991 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -3011,6 +3011,20 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 	setsched_check = !cpuset_v2() ||
 		!cpumask_equal(cs->effective_cpus, oldcs->effective_cpus) ||
 		!nodes_equal(cs->effective_mems, oldcs->effective_mems);
+	/*
+	 * Also check if task migration away from the old cpuset is allowed
+	 * without security check. This bit should only be set by the hotplug
+	 * handler when task migration from a child v1 cpuset to its ancestor
+	 * is needed because there is no CPU left for the tasks to run on after
+	 * a hot CPU removal. Clear the bit if set as it is one-off. Also
+	 * doube-check the CPU emptiness of oldcs to be sure before clearing
+	 * setsched_check.
+	 */
+	if (test_bit(CS_TASKS_OUT, &oldcs->flags)) {
+		if (cpumask_empty(oldcs->effective_cpus))
+			setsched_check = false;
+		clear_bit(CS_TASKS_OUT, &oldcs->flags);
+	}
 
 	cgroup_taskset_for_each(task, css, tset) {
 		ret = task_can_attach(task);
-- 
2.53.0


