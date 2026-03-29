Return-Path: <cgroups+bounces-15095-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNJzLDxkyWlXxwUAu9opvQ
	(envelope-from <cgroups+bounces-15095-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 29 Mar 2026 19:41:16 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF10353656
	for <lists+cgroups@lfdr.de>; Sun, 29 Mar 2026 19:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC1FA3021E93
	for <lists+cgroups@lfdr.de>; Sun, 29 Mar 2026 17:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA25386C22;
	Sun, 29 Mar 2026 17:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B+6N7fAx"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7B73859D3
	for <cgroups@vger.kernel.org>; Sun, 29 Mar 2026 17:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774806018; cv=none; b=AVUSBTQa6J0WFUgL0eboCvkHwqu7W15oVCcDeDQXU+EL6P+mgaLLYaPlVwmkjqiNU6baoKt862qnbm8EpJc8gg70yAkCUMlgwzfLIlzw3hJBZXOQMcVT/2Y1oVj2cZ2q/WEHkLa98C+Ug22z4OrAIJBkFdYA0zw7HtgchfXLBfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774806018; c=relaxed/simple;
	bh=gdTMaxVewZevxekZoWFMV5QbPBw4+0c6ISVvV4ELeaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IhyVzcXDQbCEwkagMMFqBn5atQzKBar8zEJ31dDlxd93/ZxEWmQxW9vFQblHFzKh7NY6I7m1VDcu9aQwy9G5IUNM8o3/xQFC/G4pAtYZiLLmGtmDyCLa9V5ax69hYpHUHiitCqYK8UtLYsMyJkGTNETE4ny+g5owJCn3BGu3YWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B+6N7fAx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774806016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=23vwVawhhdaUlEZbOs+YhGbbQr0Na89/CEeqFQu0cCc=;
	b=B+6N7fAxOZ8x0CZ4IPbKU+5bMFzqtZLc5ftjdTJ86XKDAlQ8zMw57Km4LCd3LcQKzwLAad
	0y9heNgxH5cUYMrvkZvJW7aQLX9vEdWuqULcf6y4NiFulUJuwRntBzbvIuh02Vhqys4HlO
	dXHr8aW0Sq5uYYPXs6CXr/ozG+QeptQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-318-RiNbVYAcN4iF8KNkaQFHMA-1; Sun,
 29 Mar 2026 13:40:12 -0400
X-MC-Unique: RiNbVYAcN4iF8KNkaQFHMA-1
X-Mimecast-MFC-AGG-ID: RiNbVYAcN4iF8KNkaQFHMA_1774806010
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 78205180035C;
	Sun, 29 Mar 2026 17:40:10 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.80.75])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1CFBF19560B1;
	Sun, 29 Mar 2026 17:40:08 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Chen Ridong <chenridong@huawei.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Waiman Long <longman@redhat.com>
Subject: [PATCH v2 1/3] cgroup/cpuset: Simplify setsched decision check in task iteration loop of cpuset_can_attach()
Date: Sun, 29 Mar 2026 13:39:56 -0400
Message-ID: <20260329173958.2634925-2-longman@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15095-lists,cgroups=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3DF10353656
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Centralize the check required to run security_task_setscheduler() in
the task iteration loop of cpuset_can_attach() outside of the loop as
it has no dependency on the characteristics of the tasks themselves.

There is no functional change.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index d21868455341..58c5b7b72cca 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2988,7 +2988,7 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 	struct cgroup_subsys_state *css;
 	struct cpuset *cs, *oldcs;
 	struct task_struct *task;
-	bool cpus_updated, mems_updated;
+	bool setsched_check;
 	int ret;
 
 	/* used later by cpuset_attach() */
@@ -3003,20 +3003,21 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 	if (ret)
 		goto out_unlock;
 
-	cpus_updated = !cpumask_equal(cs->effective_cpus, oldcs->effective_cpus);
-	mems_updated = !nodes_equal(cs->effective_mems, oldcs->effective_mems);
+	/*
+	 * Skip rights over task setsched check in v2 when nothing changes,
+	 * migration permission derives from hierarchy ownership in
+	 * cgroup_procs_write_permission()).
+	 */
+	setsched_check = !cpuset_v2() ||
+		!cpumask_equal(cs->effective_cpus, oldcs->effective_cpus) ||
+		!nodes_equal(cs->effective_mems, oldcs->effective_mems);
 
 	cgroup_taskset_for_each(task, css, tset) {
 		ret = task_can_attach(task);
 		if (ret)
 			goto out_unlock;
 
-		/*
-		 * Skip rights over task check in v2 when nothing changes,
-		 * migration permission derives from hierarchy ownership in
-		 * cgroup_procs_write_permission()).
-		 */
-		if (!cpuset_v2() || (cpus_updated || mems_updated)) {
+		if (setsched_check) {
 			ret = security_task_setscheduler(task);
 			if (ret)
 				goto out_unlock;
-- 
2.53.0


