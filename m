Return-Path: <cgroups+bounces-17443-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kHPmNTndRmooewsAu9opvQ
	(envelope-from <cgroups+bounces-17443-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 02 Jul 2026 23:50:49 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FAD96FD111
	for <lists+cgroups@lfdr.de>; Thu, 02 Jul 2026 23:50:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b="TG/K6lvE";
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17443-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17443-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C979303ADDD
	for <lists+cgroups@lfdr.de>; Thu,  2 Jul 2026 21:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7873AFAE4;
	Thu,  2 Jul 2026 21:48:39 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6683ABD8D
	for <cgroups@vger.kernel.org>; Thu,  2 Jul 2026 21:48:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783028919; cv=none; b=cU6plrX2bWALE8T3/TKqscXJY1ASu8hyOTyrWPujYq3JTNudhBb4Ap+7kpO24DMlTw5xe1SUx3GQGbf2+dpNqLoPkzJhbWZU6kls7aZjoAhK3R/Ze6JseqnuYmwFkVAqrcwTCOdJM8pckw2roBOsCk33/gnLAXmXJbGYyQrLSn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783028919; c=relaxed/simple;
	bh=g5MMhWXgNSsTkOWjoGCaEbc1QtGQi3ZNPHLAzCfkltU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eHQTvYN+Qc0EZVbSyGQ07Ud16pNsw0FbdkiChHjMN7Lz/k5drG1egtIZmfE6+jj0EDYvM3q4Mvv5zu21qTVT98y+JKO0oHkfd/TY2gPbbsDXLNsBZzuJRVbUlC4h8u3ZFkYsTKPLbtVUX++r//o8csD6Kga4XDPWrriUR+SFUD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TG/K6lvE; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783028916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tJo1xq+H68wGHTCJ8EpBtInDY7c/Mfm7eNvFYrR3pf8=;
	b=TG/K6lvEmiJTn4jhQdD67BtIPP4F6eH6ZgD4iq0WWT4DJNB8GSLW1vTJm1DUl+U3AWBCnl
	Aob5BfVIvSXkEeyie/+q3o8yZcZUoU93qgISfGTVn5AFsxVpu8wDdqI3890Ka/9is7RQp1
	cNrI/e0Rp7JsyDtG+jcsa24rYJzN+hs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-272--w7SewmuNLuCft1Wl_ABZQ-1; Thu,
 02 Jul 2026 17:48:33 -0400
X-MC-Unique: -w7SewmuNLuCft1Wl_ABZQ-1
X-Mimecast-MFC-AGG-ID: -w7SewmuNLuCft1Wl_ABZQ_1783028912
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 91723187959C;
	Thu,  2 Jul 2026 21:48:31 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.2.16.58])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E368236F24;
	Thu,  2 Jul 2026 21:48:27 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Ridong Chen <ridong.chen@linux.dev>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	Juri Lelli <juri.lelli@redhat.com>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Aaron Tomlin <atomlin@atomlin.com>,
	Guopeng Zhang <guopeng.zhang@linux.dev>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH-next v10 00/11] cgroup/cpuset: Support multiple source/destination cpusets for cpuset_*attach()
Date: Thu,  2 Jul 2026 17:47:46 -0400
Message-ID: <20260702214757.579012-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-17443-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:ridong.chen@linux.dev,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:shuah@kernel.org,m:juri.lelli@redhat.com,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:atomlin@atomlin.com,m:guopeng.zhang@linux.dev,m:longman@redhat.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7FAD96FD111

 v10:
  - Update the commit log of patch 1 to highlight the fact that it
    can only partially fix the race problem.
  - Fix some typos, remove some redundant code and add review tags.

 v9: https://lore.kernel.org/lkml/20260630033344.352702-1-longman@redhat.comk
  - Drop Farhad's mm mempolicy rebind fix patch as it has been merged to
    linux-next via the mm tree.
  - Add a new patch to make nr_deadline_tasks an atomic_t to prevent
    data corruption due to concurrent update & adjust some later patches
    accordingly.
  - Add a new wait_attach_done_lock() helper for waiting ongoing task
    operation as suggested by Ridong.

 v8: https://lore.kernel.org/lkml/20260626181923.133658-1-longman@redhat.com/
  - Update patch 3 to make attach_in_progress a global flag which block
    all cpuset write operations until the attach is done.
  - Add a new patch 4 to collect most of the attach related variables
    into a attach_ctx structure as suggested by Ridong.
  - Add a test_cpuset selftest patch contributed by Michal Koutný.
  - Keep the existing Reviewed-by tags as there is no functional change
    to the other patches other than rename of some variables. Also add
    some new tags.

Sashiko AI review of another cpuset patch had found that cpuset_attach()
and cpuset_can_attach() can be passed a cgroup_taskset with tasks
migrating from one source cpuset to multiple destination cpusets and
vice versa.  Further testing of the cpuset code indicates that this is
indeed the case when the v2 cpuset controller is enabled or disabled.

Unfortunately, cpuset_attach() and cpuset_can_attach() still assume that
there will be one source and one destinaton cpuset which may result in
inocrrect behavior.

This patch series is created to fix this issue.

Patch 1 is to fix another nr_deadline_tasks data corruption problem
reported by sashiko by making it an atomic_t data type.

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

Patch 11 adds a new test case to test_cpuset to test disabling of cpuset
controller.

*** BLURB HERE ***

Michal Koutný (1):
  selftests/cgroup: Add test for cpuset affinity on controller disable

Waiman Long (10):
  cgroup/cpuset: Make nr_deadline_tasks an atomic_t
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

 kernel/cgroup/cpuset-internal.h              |  13 +-
 kernel/cgroup/cpuset.c                       | 467 ++++++++++++-------
 tools/testing/selftests/cgroup/test_cpuset.c | 243 ++++++++++
 3 files changed, 552 insertions(+), 171 deletions(-)

-- 
2.54.0


