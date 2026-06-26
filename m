Return-Path: <cgroups+bounces-17343-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MOR5KvTGPmo0LgkAu9opvQ
	(envelope-from <cgroups+bounces-17343-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 26 Jun 2026 20:37:40 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 681E36CFB6E
	for <lists+cgroups@lfdr.de>; Fri, 26 Jun 2026 20:37:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=PTLB0fEA;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17343-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="cgroups+bounces-17343-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D60F53015C14
	for <lists+cgroups@lfdr.de>; Fri, 26 Jun 2026 18:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968BE3B8131;
	Fri, 26 Jun 2026 18:37:38 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260403B7B71
	for <cgroups@vger.kernel.org>; Fri, 26 Jun 2026 18:37:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782499058; cv=none; b=TWD7IpGSqYDzMible7l7KTrjdwaSlvNqkAJe11DVuqsmw6Gdk1aBr1keum/IcWHovr8hFcB/xh+C5YmGZ+zFHdy0tN74ip+rdjueIiAU5r+lcRYa2E356IQ40pWricPglYFrEJmB6yFmv4G8OIRg0WA1QNY04yunfV8CxXprDF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782499058; c=relaxed/simple;
	bh=6dDnymeCyAIjxRoJW74PZ/gV2/Qm9iNCg2yVKleCGx0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ecUQ/h+jTx/SDvpN1Xzj8/DO2DVc5dVDk+CV35W89QQ/l/5X3p0PtOyvCQVApN7eM31ff3cLw4b4vP6KFJ4J9cZ7/m/Kr2gAgP8ASrUHcnBd2J3wspb3pbiw+xhrY2PfYmVZkd3NZxPc6qPDXtVWPRMHTKKnONMhzMr1CKy9PfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PTLB0fEA; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782499056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Xg+gfZZRw6uxD4/DdDYAkO88l6qr/2Ph391mNIOILd4=;
	b=PTLB0fEAKcHHjN2447tjck6d2IPK9JieLCnjxoEGZ3ILyxJL/U55y5jODUIrKEp/V3wsId
	wOY1UtP+vI4617sJBjp63qh0ZdwV3sn8/vJa18v9LMF9TKerFYlj4uMNyg6vZEFvOOyqhZ
	yj5oZL6D0qbxhE5KCelHAPrFX2aOUWU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-638-vKbXLotSONuCiEMUmwOrWQ-1; Fri,
 26 Jun 2026 14:37:30 -0400
X-MC-Unique: vKbXLotSONuCiEMUmwOrWQ-1
X-Mimecast-MFC-AGG-ID: vKbXLotSONuCiEMUmwOrWQ_1782499048
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 077271955DC9;
	Fri, 26 Jun 2026 18:37:28 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.2.16.156])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E358619560A3;
	Fri, 26 Jun 2026 18:37:23 +0000 (UTC)
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
Subject: [PATCH v8 00/11] cgroup/cpuset: Support multiple source/destination cpusets for cpuset_*attach()
Date: Fri, 26 Jun 2026 14:19:12 -0400
Message-ID: <20260626181923.133658-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-17343-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:ridong.chen@linux.dev,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:farhad.alemi@berkeley.edu,m:akpm@linux-foundation.org,m:shuah@kernel.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:atomlin@atomlin.com,m:guopeng.zhang@linux.dev,m:gourry@gourry.net,m:david@kernel.org,m:longman@redhat.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 681E36CFB6E

 v8:
  - Update patch 3 to make attach_in_progress a global flag which block
    all cpuset write operations until the attach is done.
  - Add a new patch 4 to collect most of the attach related variables
    into a attach_ctx structure as suggested by Ridong.
  - Add a test_cpuset selftest patch contributed by Michal Koutný.
  - Keep the existing Reviewed-by tags as there is no functional change
    to the other patches other than rename of some variables. Also add
    some new tags.

 v7: https://lore.kernel.org/lkml/20260621032816.1806773-1-longman@redhat.com/
  - Include the fix patch from Farhad Alemi to fix a div/0 crash that
    was part of the old patch 1.
  - Integrated v6 patch 7 into earlier patches.
  - Add a new "cgroup/cpuset: Prevent race between task attach and
    cpuset state change" patch to ensure that there will be no cpuset
    state change between cpuset_can_attach() and cpuset_attach() or
    cpuset_cancel_attach().
  - Break v6 patch 6 into 2 separate patches for supporting multiple
    source cpusets and multiple destination cpusets respectively and
    further simplify and streamline the code.

 v6:
  - Make guarantee_online_mems() to only return cs->effective_mems with v2
    in patch 1.
  - Remove obsolete commit description text from patch 3.
  - Add Reviewed-by tags.
  - In patch 6, add WARN_ON_ONCE() test in cpuset_can_attach() to
    confirm that cs != oldcs.

Sashiko AI review of another cpuset patch had found that cpuset_attach()
and cpuset_can_attach() can be passed a cgroup_taskset with tasks
migrating from one source cpuset to multiple destination cpusets and
vice versa.  Further testing of the cpuset code indicates that this is
indeed the case when the v2 cpuset controller is enabled or disabled.

Unfortunately, cpuset_attach() and cpuset_can_attach() still assume that
there will be one source and one destinaton cpuset which may result in
inocrrect behavior.

This patch series is created to fix this issue.

Patch 1 is a fix that fix a cgroup v2 div/0 crash due to bug in
cpuset_update_tasks_nodemask().

Patch 2 is to fix an inconsistency in the way node mask update is being
handled in cpuset_update_tasks_nodemask() and cpuset_attach() so that
they match each other.

Patch 3 makes any cpuset state change to wait for the completion of the
pending cpuset attach operation, if any.

Patch 4 collects task attach related data into a common attach_ctx
structure.

Patches 5 and 6 are just preparatory patches to make the remaining
patches easier to review.

Patch 7 makes attach_ctx.old_cs track group leader for use by
cpuset_migrate_mm().

Patch 8 moves mpol_rebind_mm() and cpuset_migrate_mm() inside
cpuset_attach_task() to make CLONE_INTO_CGROUP flag of clone(2) works
more like moving task from one cpuset to another one, while also make
supporting multiple source and destination cpusets easier.

Patch 9 makes the necessary changes to enable the support of multiple
source cpusets by keeping all the source cpusets found during task
iterations in a singly linked lists.

Patch 10 enables the support of multiple destination cpusets during the
the enabling of cpuset v2 controller.

Patch 11 adds new test case to test_cpuset to test disabling of cpuset
controller.

Farhad Alemi (1):
  cgroup/cpuset: rebind mm mempolicy to effective_mems, not mems_allowed

Michal Koutný (1):
  selftests/cgroup: Add test for cpuset affinity on controller disable

Waiman Long (9):
  cgroup/cpuset: Fix node inconsistencies between
    cpuset_update_tasks_nodemask() and cpuset_attach()
  cgroup/cpuset: Prevent race between task attach and cpuset state
    change
  cgroup/cpuset: Put all task attach related variables into attach_ctx
  cgroup/cpuset: Add a cpuset_reserve_dl_bw() helper
  cgroup/cpuset: Expand the scope of cpuset_can_attach_check()
  cgroup/cpuset: Make attach_ctx.old_cs track task group leader
  cgroup/cpuset: Move mpol_rebind_mm/cpuset_migrate_mm() calls inside
    cpuset_attach_task()
  cgroup/cpuset: Support multiple source cpusets for cpuset_*attach()
  cgroup/cpuset: Support multiple destination cpusets for
    cpuset_*attach()

 kernel/cgroup/cpuset-internal.h              |  11 +-
 kernel/cgroup/cpuset.c                       | 442 ++++++++++++-------
 tools/testing/selftests/cgroup/test_cpuset.c | 243 ++++++++++
 3 files changed, 541 insertions(+), 155 deletions(-)

-- 
2.54.0


