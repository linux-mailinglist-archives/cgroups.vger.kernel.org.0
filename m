Return-Path: <cgroups+bounces-16537-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iIyTNM9AHmraiAkAu9opvQ
	(envelope-from <cgroups+bounces-16537-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 02 Jun 2026 04:32:47 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 73531627410
	for <lists+cgroups@lfdr.de>; Tue, 02 Jun 2026 04:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 29A18300DD7D
	for <lists+cgroups@lfdr.de>; Tue,  2 Jun 2026 02:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C71C360EC6;
	Tue,  2 Jun 2026 02:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Al3JWyQJ"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F3D2045AD
	for <cgroups@vger.kernel.org>; Tue,  2 Jun 2026 02:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780367543; cv=none; b=Ld99PC+P0n+IhOW4r8xgxYGq9j6/e4G/ybhn7w5gXSJ6V1Zx5hs9/KPxjeqm1+x3ftkNINZxCPedbOKOAjBLv75UPpmeS8KoiX5Y5V9LlQ9nt2pvRDBBzyPcaaW6ivt5vJANPYHLznM8ecjI5qvWElHz5i/x7yo51Wfted8y8rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780367543; c=relaxed/simple;
	bh=aDi5mfBLJePJ9cElwr7l1gkTzrYVvkp5Kk1WQXza0kM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A7AZQUpoUlov0VH4Mmc4BK60StoQHeDueyxkVoPwaMld/dm6odKFkr3ojhEf5OH2wkzYcCF2A8fPU6g3M5gOaxFVut74oRjq09fAtnzcAuKbRTXYyUpMWwP5M8geibGQ91nJkn6xCiJVY/CP5a/FnvAjm8xnjRN9m0l11p8UAKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Al3JWyQJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780367540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ei6RZLWWRgHzEmmQD0bdmoiX9CqLr08dCbblQuXjCco=;
	b=Al3JWyQJ5znOFq3VqJKdIW92YsrqkHS9Sk7UJEpibLHEAHzZIHT5RmWUXVOAAMLFTVJByY
	RjCItpIL0XBiTg6SAXCpcHbQ/MWgCsu/TNNy7g/3kcrC3rIX5K+cSr+j2khGnG4v8wqAse
	GkLxogriTsQ/gynYvGB0zv6U88QaP14=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-526-rgCsdgQgMied8FwE7lPZSQ-1; Mon,
 01 Jun 2026 22:32:16 -0400
X-MC-Unique: rgCsdgQgMied8FwE7lPZSQ-1
X-Mimecast-MFC-AGG-ID: rgCsdgQgMied8FwE7lPZSQ_1780367534
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0D0B51956050;
	Tue,  2 Jun 2026 02:32:14 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.88.124])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2B1B819560A3;
	Tue,  2 Jun 2026 02:32:10 +0000 (UTC)
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
	Waiman Long <longman@redhat.com>
Subject: [PATCH-next v5 0/6] cgroup/cpuset: Support multiple source/destination cpusets for cpuset_*attach()
Date: Mon,  1 Jun 2026 22:31:57 -0400
Message-ID: <20260602023203.248077-1-longman@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-16537-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 73531627410
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

 v5:
  - Remove the WARN_ON() call as it can be triggered in a corner case.
  - Instead of passing an attach_cpus_updated and attach_mems_updated
    flags from cpuset_can_attach() to cpuset_attach(), re-evaluate the
    flags at the beginning of cpuset_attach() based on data in the source &
    destination cpusets in the singly linked lists to eliminate the
    Time-of-Check to Time-of-Use (TOCTOU) race condition & simplify the
    code changes.
  - Add back the dropped optimization in patch 5.

 v4:
  - Add a new patch 1 to fix inconsistency in node mask usage in
    cpuset_update_tasks_nodemask() and cpuset_attach() and adjust
    the subsequent patches accordingly.
  - Update patch 3 to set the update flags whenever the CPU or node
    mask is updated to address issue reported by Sashiko.
  - Update patch 5 to remove unneeded setting of old_mems_allowed as
    well as calling schedule_flush_migrate_mm() if queue_task_work is
    set.

 v3:
  - Rebased to the lastest linux-next tree.
  - Keep cpuset_attach_old_cs as suggested by Chen Ridong and replace
    patch 3 by a new one to make it track task group leader.

Sashiko AI review of another cpuset patch had found that cpuset_attach()
and cpuset_can_attach() can be passed a cgroup_taskset with tasks
migrating from one source cpuset to multiple destination cpusets and
vice versa.  Further testing of the cpuset code indicates that this is
indeed the case when the v2 cpuset controller is enabled or disabled.

Unfortunately, cpuset_attach() and cpuset_can_attach() still assume that
there will be one source and one destinaton cpuset which may result in
inocrrect behavior.

This patch series is created to fix this issue.

Patch 1 is to fix an inconsistency in the way node mask update is being
handled in cpuset_update_tasks_nodemask() and cpuset_attach() so that
they match each other.

Patches 2 and 3 are just preparatory patches to make the remaining
patches easier to review.

Patch 4 makes cpuset_attach_old_cs to track group leader for use by
cpuset_migrate_mm().

Patch 5 moves mpol_rebind_mm() and cpuset_migrate_mm() inside
cpuset_attach_task() to make CLONE_INTO_CGROUP flag of clone(2) works
more like moving task from one cpuset to another one, while also make
supporting multiple source and destination cpusets easier.

Patch 6 makes the necessary changes to enable the support of multiple
source and destination cpusets by keeping all the source and destination
cpusets found during task iterations in two singly linked lists for
source and destination cpusets respectively.

Waiman Long (6):
  cgroup/cpuset: Fix node inconsistencies between
    cpuset_update_tasks_nodemask() and cpuset_attach()
  cgroup/cpuset: Add a cpuset_reserve_dl_bw() helper
  cgroup/cpuset: Expand the scope of cpuset_can_attach_check()
  cgroup/cpuset: Make cpuset_attach_old_cs track task group leaders
  cgroup/cpuset: Move mpol_rebind_mm/cpuset_migrate_mm() calls inside
    cpuset_attach_task()
  cgroup/cpuset: Support multiple source/destination cpusets for
    cpuset_*attach()

 kernel/cgroup/cpuset-internal.h |   6 +
 kernel/cgroup/cpuset.c          | 411 +++++++++++++++++++++++---------
 2 files changed, 299 insertions(+), 118 deletions(-)

-- 
2.54.0


