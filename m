Return-Path: <cgroups+bounces-15133-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8KPfLAzmy2myMQYAu9opvQ
	(envelope-from <cgroups+bounces-15133-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 31 Mar 2026 17:19:40 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31DF136B903
	for <lists+cgroups@lfdr.de>; Tue, 31 Mar 2026 17:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D178530DDF68
	for <lists+cgroups@lfdr.de>; Tue, 31 Mar 2026 15:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51545402B91;
	Tue, 31 Mar 2026 15:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KlYvRnaV"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9110402456
	for <cgroups@vger.kernel.org>; Tue, 31 Mar 2026 15:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774969884; cv=none; b=jpDxUYIpOz6HEEcnrBoOqklg2ibtlXOtZU5TJ9q0I/ryI9O2J1p6jWljFAWqQ5et43ASzQYCJeKAC4k4iKyYzxrHkVDVKj/X7rAB5bZnUpjlIhXq7YcDwvvrBeiyW//GaU3dsNmkQcqg/5UJDEdgEVjqoGUIvzzLv9T7TFqwaAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774969884; c=relaxed/simple;
	bh=6kYN1yfArpdpANnsQsRCo/XXbIUoswyvKUr/Nj8Lwfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k+ByCGyC0ov4L4S3y1AzgNmaK4NspN0J2f/BdRNfS2ofoU90gMlVAtTK/7nd2m5kpxCdXCgAfaPjezVEmmBKTdKh6GSTbBIjdfxc5cUu47jBrLlQpj2lZpv7GETIeKBDY/npLdL5Zx/nCKuO2dlpvVE0MHYxG1VzUacCpAlpzSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KlYvRnaV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774969881;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hYeHjIWbLnPYYWY4RAAm9AikWR5jWAoS/OI3HEP/0/A=;
	b=KlYvRnaVIVRY+M4HAzoWl0DxYtgBDexx/sFwBt9YIxeVNS9H+KmPCBJ86VyPpedEzl5kmh
	f8WaDJmfDmLHVsSfPtrmpqz6hKpWpPlUbqqQ+QqxemgmgF0m5I66VEpVqZUvVB2YLIstyM
	dedQnfp7icZxwWEEV02WcFD6RqtD9Vk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-642-zS5Sac5hP6SmaSMcAggJpg-1; Tue,
 31 Mar 2026 11:11:18 -0400
X-MC-Unique: zS5Sac5hP6SmaSMcAggJpg-1
X-Mimecast-MFC-AGG-ID: zS5Sac5hP6SmaSMcAggJpg_1774969877
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 621881800611;
	Tue, 31 Mar 2026 15:11:17 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.80.26])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0795B1954102;
	Tue, 31 Mar 2026 15:11:15 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Chen Ridong <chenridong@huawei.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Waiman Long <longman@redhat.com>
Subject: [PATCH v3 2/2] cgroup/cpuset: Skip security check for hotplug induced v1 task migration
Date: Tue, 31 Mar 2026 11:11:08 -0400
Message-ID: <20260331151108.2771560-3-longman@redhat.com>
In-Reply-To: <20260331151108.2771560-1-longman@redhat.com>
References: <20260331151108.2771560-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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
	TAGGED_FROM(0.00)[bounces-15133-lists,cgroups=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,cpuset_hotplug_test.sh:url]
X-Rspamd-Queue-Id: 31DF136B903
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
cpuset_hotplug_test.sh. Fix this problem by treating this special case as
an exception to skip the setsched security check in cpuset_can_attach()
when a v1 cpuset with tasks have no CPU left.

With that patch applied, the cpuset_hotplug_test.sh test can be run
successfully without failure.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 58c5b7b72cca..1335e437098e 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -3012,6 +3012,16 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 		!cpumask_equal(cs->effective_cpus, oldcs->effective_cpus) ||
 		!nodes_equal(cs->effective_mems, oldcs->effective_mems);
 
+	/*
+	 * A v1 cpuset with tasks will have no CPU left only when CPU hotplug
+	 * brings the last online CPU offline as users are not allowed to empty
+	 * cpuset.cpus when there are active tasks inside. When that happens,
+	 * we should allow tasks to migrate out without security check to make
+	 * sure they will be able to run after migration.
+	 */
+	if (!is_in_v2_mode() && cpumask_empty(oldcs->effective_cpus))
+		setsched_check = false;
+
 	cgroup_taskset_for_each(task, css, tset) {
 		ret = task_can_attach(task);
 		if (ret)
-- 
2.53.0


