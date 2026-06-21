Return-Path: <cgroups+bounces-17099-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ExJdFCpbN2pbMwcAu9opvQ
	(envelope-from <cgroups+bounces-17099-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 21 Jun 2026 05:31:54 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A59636AA1D1
	for <lists+cgroups@lfdr.de>; Sun, 21 Jun 2026 05:31:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=VbhuX03M;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17099-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17099-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 223DD301FF98
	for <lists+cgroups@lfdr.de>; Sun, 21 Jun 2026 03:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE25C303A04;
	Sun, 21 Jun 2026 03:29:06 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4AC2BEFFE
	for <cgroups@vger.kernel.org>; Sun, 21 Jun 2026 03:29:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782012546; cv=none; b=JO1XTeaTmWsIcdwbkxlwlgH3Ruxz5ww3sYg32iql8WHzanilAq2eb9ElsvZPLycuZqJfYgxAJaBp4O5Ao9x7eQEHvdIXEBBv+p3I256+o6IHan4fuQ06AFnfbwNn5a0pHIv+eD9GiWOPtKkvg8g7OhPfJPlwIl1k/dC5819JHuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782012546; c=relaxed/simple;
	bh=VZlQB+bbx3d9xPS7cn2DFtBXFsOGDmIjqZjeeIR+f1c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tljeprNcKjYt4IsgZ9h7sLwc3+dNAtA/osiHsVk5EskMbq8nJ2Vv40LlN/4O52X1oiE0p6Yqk4SIRc6XfVEN7EGlSsj4IQVifZsqifzDGENZenccT532F0MVsyvAFHgeWK8LXxrTGJHPdRIewDWKX+cgUZyl7Qw7VYhansmubbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VbhuX03M; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782012543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=l2m/VE8xnPaCMx0qhe/P8AgXTxKXkdc8Kh24NZPYrzE=;
	b=VbhuX03M0l2vNKL881YzzT42jtER/nERvBQp0I00Ef4EHFVsEa+9pH+Cc81/9ngIqCSUqk
	wIm9Sb8ACqxfMm6proPe6NXMGQCfovq4MknYh8bYMA3ZDm1fXVkMk72dn2t6cdQ9TVv4/Y
	uBtk7GxOBxd/utucRJs41V+GjJfBsW4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-676-8yRK9bvpP3m6qX_9nSVJYA-1; Sat,
 20 Jun 2026 23:28:58 -0400
X-MC-Unique: 8yRK9bvpP3m6qX_9nSVJYA-1
X-Mimecast-MFC-AGG-ID: 8yRK9bvpP3m6qX_9nSVJYA_1782012537
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 32C671800D9C;
	Sun, 21 Jun 2026 03:28:56 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.88.8])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 07E8C195604D;
	Sun, 21 Jun 2026 03:28:52 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Ridong Chen <ridong.chen@linux.dev>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Li Zefan <lizefan@huawei.com>,
	Farhad Alemi <farhad.alemi@berkeley.edu>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aaron Tomlin <atomlin@atomlin.com>,
	Guopeng Zhang <guopeng.zhang@linux.dev>,
	Gregory Price <gourry@gourry.net>,
	David Hildenbrand <david@kernel.org>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH v7 0/9] cgroup/cpuset: Support multiple source/destination cpusets for cpuset_*attach()
Date: Sat, 20 Jun 2026 23:28:07 -0400
Message-ID: <20260621032816.1806773-1-longman@redhat.com>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17099-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ridong.chen@linux.dev,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:lizefan@huawei.com,m:farhad.alemi@berkeley.edu,m:akpm@linux-foundation.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:atomlin@atomlin.com,m:guopeng.zhang@linux.dev,m:gourry@gourry.net,m:david@kernel.org,m:longman@redhat.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A59636AA1D1

 v7:
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

 v5:
  - Remove the WARN_ON() call as it can be triggered in a corner case.
  - Instead of passing an attach_cpus_updated and attach_mems_updated
    flags from cpuset_can_attach() to cpuset_attach(), re-evaluate the
    flags at the beginning of cpuset_attach() based on data in the source &
    destination cpusets in the singly linked lists to eliminate the
    Time-of-Check to Time-of-Use (TOCTOU) race condition & simplify the
    code changes.
  - Add back the dropped optimization in patch 5.

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

Patches 4 and 5 are just preparatory patches to make the remaining
patches easier to review.

Patch 6 makes cpuset_attach_old_cs to track group leader for use by
cpuset_migrate_mm().

Patch 7 moves mpol_rebind_mm() and cpuset_migrate_mm() inside
cpuset_attach_task() to make CLONE_INTO_CGROUP flag of clone(2) works
more like moving task from one cpuset to another one, while also make
supporting multiple source and destination cpusets easier.

Patch 8 makes the necessary changes to enable the support of multiple
source cpusets by keeping all the source cpusets found during task
iterations in a singly linked lists.

Patch 9 enables the support of multiple destination cpusets during the
the enabling of cpuset v2 controller.

Farhad Alemi (1):
  cgroup/cpuset: rebind mm mempolicy to effective_mems, not mems_allowed

Waiman Long (8):
  cgroup/cpuset: Fix node inconsistencies between
    cpuset_update_tasks_nodemask() and cpuset_attach()
  cgroup/cpuset: Prevent race between task attach and cpuset state
    change
  cgroup/cpuset: Add a cpuset_reserve_dl_bw() helper
  cgroup/cpuset: Expand the scope of cpuset_can_attach_check()
  cgroup/cpuset: Make cpuset_attach_old_cs track task group leaders
  cgroup/cpuset: Move mpol_rebind_mm/cpuset_migrate_mm() calls inside
    cpuset_attach_task()
  cgroup/cpuset: Support multiple source cpusets for cpuset_*attach()
  cgroup/cpuset: Support multiple destination cpusets for
    cpuset_*attach()

 kernel/cgroup/cpuset-internal.h |   2 +
 kernel/cgroup/cpuset.c          | 400 ++++++++++++++++++++++----------
 2 files changed, 277 insertions(+), 125 deletions(-)

-- 
2.54.0


