Return-Path: <cgroups+bounces-13547-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJaSObfRfGlbOwIAu9opvQ
	(envelope-from <cgroups+bounces-13547-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 30 Jan 2026 16:43:51 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B650BC262
	for <lists+cgroups@lfdr.de>; Fri, 30 Jan 2026 16:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2BD64303B7CA
	for <lists+cgroups@lfdr.de>; Fri, 30 Jan 2026 15:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D6F33A9E0;
	Fri, 30 Jan 2026 15:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H3fPoN+r"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE94433858F
	for <cgroups@vger.kernel.org>; Fri, 30 Jan 2026 15:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769787799; cv=none; b=oduFghM0102abPbGIppnT84pK1FJvNvmT6aO53qvQeBqktTfTnOA++m5tqPBa3Zh5UVeh/lZ7+URmay56D6Neb45dMf9qVxnmcWN5rVKjWsgQEd+quWPTt2Wvi2Tnepy+n0vfdd7enJBqP8D4qbLaB0XWjql2oU9WfVy7sshBxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769787799; c=relaxed/simple;
	bh=SsFmLSHb5J0NAZ23lFisSmeBgg/BtjqNTQyLl+86f48=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ow3aaZ4FMO6FqooXdg1ge9YxN0ihoXaMzBnLv8P25K6jfPt5rL917wiCAgPU0kacmoozxallMTUPa7uz17w3wcOM80A9nbbW+VORt/Ec/7zhJeEvFNST4Gpxl4PBSkT4YvrFp9JBj4xxiJ7fSpW+I+uPdAea9nAWSDq2qDT58m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H3fPoN+r; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769787797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lyKTkxtjGkkJponhc08CCVmlm33pThZT+VVBZCTwDCU=;
	b=H3fPoN+rnmSP2Nc1z2AYVgY4CXchEn6P7DSe+H+Gn5edpzt1t6ra1/kANNsWCvrDhK9L5R
	huPQJbPbeSmH8jCsBv9Rj93H7eusrJCj7mtNlT29FWGsLZ29HufW2CRUVjKGJT4rICpPOE
	GwT7Ldcdq4XvFFx92C/Ud2oG8hVmXUA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-401-dZiaz88dNVmGDxjgHBSjTA-1; Fri,
 30 Jan 2026 10:43:11 -0500
X-MC-Unique: dZiaz88dNVmGDxjgHBSjTA-1
X-Mimecast-MFC-AGG-ID: dZiaz88dNVmGDxjgHBSjTA_1769787789
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 09C031954204;
	Fri, 30 Jan 2026 15:43:09 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.81.137])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9A001180009E;
	Fri, 30 Jan 2026 15:43:05 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Chen Ridong <chenridong@huaweicloud.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Shuah Khan <shuah@kernel.org>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Waiman Long <longman@redhat.com>
Subject: [PATCH/for-next v2 0/2] cgroup/cpuset: Fix partition related locking issues
Date: Fri, 30 Jan 2026 10:42:52 -0500
Message-ID: <20260130154254.1422113-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13547-lists,cgroups=lfdr.de];
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
X-Rspamd-Queue-Id: 4B650BC262
X-Rspamd-Action: no action

 v2:
  - Change patch 1 to use workqueue instead of task run as it is a
    per-cpu kthread that performs the cpuset shutdown and bringup work.
  - Simplify and streamline some of the code.

After booting the latest cgroup for-next debug kernel with the latest
cgroup changes as well as Federic's "cpuset/isolation: Honour kthreads
preferred affinity" patch series [1] merged on top and running the
test-cpuset-prs.sh test, a circular locking dependency lockdep splat
was reported. See patch 2 for details.

The following changes are made to resolve this locking problem.
 1) Deferring calling housekeeping_update() from CPU hotplug to workqueue
 2) Release cpus_read_lock before calling housekeeping_update()

With these changes, the cpuset test ran to completion with no failure
and no lockdep splat.

[1] https://lore.kernel.org/lkml/20260125224541.50226-1-frederic@kernel.org/

Waiman Long (2):
  cgroup/cpuset: Defer housekeeping_update() call from CPU hotplug to
    workqueue
  cgroup/cpuset: Introduce a new top level cpuset_top_mutex

 kernel/cgroup/cpuset.c                        | 124 ++++++++++++++----
 kernel/sched/isolation.c                      |   4 +-
 kernel/time/timer_migration.c                 |   3 +-
 .../selftests/cgroup/test_cpuset_prs.sh       |  13 +-
 4 files changed, 107 insertions(+), 37 deletions(-)

-- 
2.52.0


