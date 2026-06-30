Return-Path: <cgroups+bounces-17387-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SGoKDD05Q2ooVgoAu9opvQ
	(envelope-from <cgroups+bounces-17387-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 30 Jun 2026 05:34:21 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBBF6E0166
	for <lists+cgroups@lfdr.de>; Tue, 30 Jun 2026 05:34:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=ZOVFTCOF;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17387-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17387-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 55B593006B3A
	for <lists+cgroups@lfdr.de>; Tue, 30 Jun 2026 03:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2031436A02C;
	Tue, 30 Jun 2026 03:34:19 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61062256C6D
	for <cgroups@vger.kernel.org>; Tue, 30 Jun 2026 03:34:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782790458; cv=none; b=Xkh5RRBPLkE5eG4zqNcJHFME08ig+ZoN1KJwypQV0s9SWDHjgF5cD0vKC3u2EG3NqaPGHg9wsZYaU+ZwTTqS4ZCFnJtaaZDOX18m0Kgf3FGVQHvsO8bkhApFrzi/Ye0R5yx+xv7vC3ZGrcWY5YBebFe0mPVXV2jTUM4vyxWm22E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782790458; c=relaxed/simple;
	bh=ugfWSrFiPleG+ghQzQN67OwO5CmNudRh6qTqW6E+gRg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Oly8pcpbHerOUNW26tCn8KqEbxJEw/F3+pY5ERjaIOm3Vihia8EKrtl8KpQSjcF9FG8jI4dO1muJnigLnHDzgDqd6HoOu/vp4ff1TlHnMmhc1x9D2mT6ebuOhmlu4YAZXFAiwJSZxWBB+uQrmxxZfH1j0goj22K5I8DWOU805uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZOVFTCOF; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782790456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tRBBu3ZIXmcqdE061SpizXf8XoM1oYM+ieGMsu0EF8k=;
	b=ZOVFTCOFBRfz4LyL1JyoHjiUbTIyfabSBxxIUA3iY69IQ0fkiZJNRh3fCd21m3ZGavUQwH
	4eNtqqHTCdsDFoq7A/sVP2+LoMOjPb2F2scpRrf+wKG+eV0VHackvPQ0BQOw0EjDBX8wvK
	U9EqbmdZjW2NZNW5GAWxY7CAl615M7s=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-80-3-FrZpR9MBa3MJZMIwDSCw-1; Mon,
 29 Jun 2026 23:34:13 -0400
X-MC-Unique: 3-FrZpR9MBa3MJZMIwDSCw-1
X-Mimecast-MFC-AGG-ID: 3-FrZpR9MBa3MJZMIwDSCw_1782790451
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 02C19195604C;
	Tue, 30 Jun 2026 03:34:11 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.2.16.200])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4C506195608D;
	Tue, 30 Jun 2026 03:34:06 +0000 (UTC)
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
Subject: [PATCH-next v9 00/11] cgroup/cpuset: Support multiple source/destination cpusets for cpuset_*attach()
Date: Mon, 29 Jun 2026 23:33:33 -0400
Message-ID: <20260630033344.352702-1-longman@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-17387-lists,cgroups=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7EBBF6E0166

 v9:
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
 kernel/cgroup/cpuset.c                       | 468 ++++++++++++-------
 tools/testing/selftests/cgroup/test_cpuset.c | 243 ++++++++++
 3 files changed, 553 insertions(+), 171 deletions(-)

-- 
2.54.0


