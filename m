Return-Path: <cgroups+bounces-15989-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCmRJLjxB2qbQQMAu9opvQ
	(envelope-from <cgroups+bounces-15989-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 16 May 2026 06:25:28 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD3D55A283
	for <lists+cgroups@lfdr.de>; Sat, 16 May 2026 06:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D10A23012EBB
	for <lists+cgroups@lfdr.de>; Sat, 16 May 2026 04:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE36282F3E;
	Sat, 16 May 2026 04:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SBrJTWux"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6F232C8B
	for <cgroups@vger.kernel.org>; Sat, 16 May 2026 04:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778905519; cv=none; b=Qcn/qhctXswjwkLT2i8gZgA/5MTsewhpSJmq0RunCsN2NmgJwr1VsGo/h4w7rcOl7Xui/QaCd2lf+7lX+MqeHOu/+qvHIK1j92T5m7Re6C1cCvaLc3DLg8GrdTVjPVK7MgsdDRK24JavDQYNzHTfe959TIzFcaFNFOQDqs3Nmbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778905519; c=relaxed/simple;
	bh=r5b+8EUCI91LkakUoQjFAlgSQMKK3CKEYAJTIVjmvQA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VEAbBC2x8NsCZup9e7nHrmOUPyNZoU627Foxh0vztNmnSWWKls6/lFNylpKso4qcdD5Tm8DrA34ovo/N82GhC4vA0XqeZCECatJvv5u4yNwhxBZkVjV38ip8x7kzuS2ujzRmHoHwaDb3ZvB+R1q7xpJayi908eJ+EmBmvfCJEQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SBrJTWux; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778905516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/XrclBCKvAQvKrK4aWf5bYmaCYAyjKG90hViAKbvnAI=;
	b=SBrJTWuxYJpunczObrzjlQeAZ+4tKEdQGPdjLIBsIByI4qQ9Y/K/zMvKuyghiC0XXUoCqq
	hd0BaRsZhRCmbZxuXohU33zjUbNkZ43lP7m+AXq88o3svcmg+ftpn2tORKDJJ4Afm1OOO6
	PU7VnDJbo7kG/OZChX4ZP2nBJAzTXHQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-96-A0BkG7eKOD-u1GnB1wTjJA-1; Sat,
 16 May 2026 00:25:14 -0400
X-MC-Unique: A0BkG7eKOD-u1GnB1wTjJA-1
X-Mimecast-MFC-AGG-ID: A0BkG7eKOD-u1GnB1wTjJA_1778905512
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3FE3F1956052;
	Sat, 16 May 2026 04:25:11 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.2.16.156])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5957A1800576;
	Sat, 16 May 2026 04:25:04 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Chen Ridong <chenridong@huaweicloud.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aaron Tomlin <atomlin@atomlin.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH cgroup/for-next v2 0/5] cgroup/cpuset: Support multiple source/destination cpusets for cpuset_*attach()
Date: Sat, 16 May 2026 00:24:43 -0400
Message-ID: <20260516042448.698216-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Queue-Id: 1AD3D55A283
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15989-lists,cgroups=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Sashiko AI review of another cpuset patch had found that cpuset_attach()
and cpuset_can_attach() can be passed a cgroup_taskset with tasks
migrating from one source cpuset to multiple destination cpusets and
vice versa.  Further testing of the cpuset code indicates that this is
indeed the case when the v2 cpuset controller is enabled or disabled.

Unfortunately, cpuset_attach() and cpuset_can_attach() still assume that
there will be one source and one destinaton cpuset which may result in
inocrrect behavior.

This patch series is created to fix this issue. The first 2 patches are
just preparatory patches to make the remaining patches easier to review.

Patch 3 adds a new attach_old_cs field into task_struct to track the
old cpuset to be used in case when cpuset_migrate_mm() needs to be
called in cpuset_attach().

Patch 4 moves mpol_rebind_mm() and cpuset_migrate_mm() inside
cpuset_attach_task() to make CLONE_INTO_CGROUP flag of clone(2) works
more like moving task from one cpuset to another one, while also make
supporting multiple source and destination cpusets easier.

Patch 5 makes the necessary changes to enable the support of multiple
source and destination cpusets by keeping all the source and destination
cpusets found during task iterations in two singly linked lists for
source and destination cpusets respectively.

Waiman Long (5):
  cgroup/cpuset: Add a cpuset_reserve_dl_bw() helper
  cgroup/cpuset: Expand the scope of cpuset_can_attach_check()
  cgroup/cpuset: Replace cpuset_attach_old_cs by a new attach_old_cs
    field in task_struct
  cgroup/cpuset: Move mpol_rebind_mm/cpuset_migrate_mm() calls inside
    cpuset_attach_task()
  cgroup/cpuset: Support multiple source/destination cpusets for
    cpuset_*attach()

 include/linux/sched.h           |   3 +
 kernel/cgroup/cpuset-internal.h |   6 +
 kernel/cgroup/cpuset.c          | 358 +++++++++++++++++++++-----------
 3 files changed, 249 insertions(+), 118 deletions(-)

-- 
2.54.0


