Return-Path: <cgroups+bounces-17206-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4FlWOHARO2pJPwgAu9opvQ
	(envelope-from <cgroups+bounces-17206-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 01:06:24 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4663B6BA8B7
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 01:06:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=bHGvuthT;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17206-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17206-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6024530CA3D3
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 23:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B7E3AA9CA;
	Tue, 23 Jun 2026 23:05:13 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F9F395D8C
	for <cgroups@vger.kernel.org>; Tue, 23 Jun 2026 23:05:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782255913; cv=none; b=dJOuNW3LsxmBG2i2BQccAP4vPfvFtGUYDz6ydwZg3BhEwi+WMXe/9fcdp69EvCfbLaem8pg1kJXqWIPFEiJ84zk09fq7y+ZB4I5uMMKW1+B9sG3zxY8/3IwMoWvvNTRyQ9qr5cp+Kuh+h9N3Zq0v6Ci8ggywMs1vG+zYKIBusmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782255913; c=relaxed/simple;
	bh=GFnvqzOA+msWCU116qHmV5FrXG/LnYNeFPPmReb2Bi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ppV+udkWfFkb5by4gX5L8yqkwdCVpLsAxQLZ2Z9Arj8kXvhC7EXfcKgXz1+v3HPK8WwC5EDuYYur5qj0NO8mBGxkOEaNgLDQGuoV3/JAlbEzPSkK8UGHFGQyxtDmLSJJYMRT7hl6g1grFmEEn0QixEFVHyfBcJEW6cymrcfKdnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bHGvuthT; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782255910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o0JYaxtKq5T6dSoG39+ki+lC5EFXV1/igQMvJlCVGE8=;
	b=bHGvuthTa/6wxy/IXPsZ/CJP7OGdUKgzz5cyZgcOFNI8X5X9/gulLmT2/McbefhPWXsZmU
	l0ISRYFtnhGps5u5PRTz7M7ytjzICkfLxpLB5op1wI6fAqCoEVSs9Quk4cO6h+jeHz7lvW
	Eg1qMAo2OnrC89thdbHSIxrkdiYGAlg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-658-Q6dTz-U-PUKZbDoNYwaZXw-1; Tue,
 23 Jun 2026 19:05:07 -0400
X-MC-Unique: Q6dTz-U-PUKZbDoNYwaZXw-1
X-Mimecast-MFC-AGG-ID: Q6dTz-U-PUKZbDoNYwaZXw_1782255906
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AC06E19560A6;
	Tue, 23 Jun 2026 23:05:05 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.2.17.30])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B38631955F6D;
	Tue, 23 Jun 2026 23:05:02 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Ridong Chen <ridong.chen@linux.dev>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Waiman Long <longman@redhat.com>
Subject: [PATCH v2 2/2] cgroup/cpuset: Rebind/migrate mm only for threadgroup leader in cpuset_update_tasks_nodemask()
Date: Tue, 23 Jun 2026 19:04:13 -0400
Message-ID: <20260623230413.1984188-3-longman@redhat.com>
In-Reply-To: <20260623230413.1984188-1-longman@redhat.com>
References: <20260623230413.1984188-1-longman@redhat.com>
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
	TAGGED_FROM(0.00)[bounces-17206-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:ridong.chen@linux.dev,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:longman@redhat.com,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[11];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4663B6BA8B7

As reported by sashiko [1], cpuset_update_tasks_nodemask() will do
mpol_rebind_mm() and possibly cpuset_migrate_mm() for all threads of
a multithreaded process. Since commit 3df9ca0a2b8b ("cpuset: migrate
memory only for threadgroup leaders"), cpuset_attach() had been updated
to rebind and migrate memory only for threadgroup leaders to mark the
group leader as the owner of the mm_struct.

To be consistent and avoid unnecessary performance overhead for heavily
multithreaded processes, follow the cpuset_attach() example and perform
memory rebind and migration only for threadgroup leaders.

Also add a paragraph in cgroup-v2.rst under cpuset.mems that the
threadgroup leader is the memory owner of that threadgroup. Therefore
the non-leading threads shouldn't be in other cgroups whose "cpuset.mems"
doesn't fully overlap that of the group leader.

[1] https://sashiko.dev/#/patchset/20260621032816.1806773-1-longman%40redhat.com

Signed-off-by: Waiman Long <longman@redhat.com>
Reviewed-by: Ridong Chen <ridong.chen@linux.dev>
---
 Documentation/admin-guide/cgroup-v2.rst | 7 +++++++
 kernel/cgroup/cpuset.c                  | 4 ++++
 2 files changed, 11 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 993446ab66d0..f9c353174a7e 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -2527,6 +2527,13 @@ Cpuset Interface Files
 	a need to change "cpuset.mems" with active tasks, it shouldn't
 	be done frequently.
 
+	For a multithreaded process, the threadgroup leader is
+	considered the owner of the group's memory. Memory policy
+	rebinding and migration will only happen with respect to the
+	threadgroup leader. To avoid unexpected result, non-leading
+	threads shouldn't be put into another cgroup whose "cpuset.mems"
+	doesn't fully overlap that of the threadgroup leader.
+
   cpuset.mems.effective
 	A read-only multiple values file which exists on all
 	cpuset-enabled cgroups.
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 044ddbf66f8e..055ae54a040a 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2673,6 +2673,10 @@ void cpuset_update_tasks_nodemask(struct cpuset *cs)
 
 		cpuset_change_task_nodemask(task, &newmems);
 
+		/* Rebind and migrate mm only for thread group leader */
+		if (!thread_group_leader(task))
+			continue;
+
 		mm = get_task_mm(task);
 		if (!mm)
 			continue;
-- 
2.54.0


