Return-Path: <cgroups+bounces-13482-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KKzaBQaUeWmOxgEAu9opvQ
	(envelope-from <cgroups+bounces-13482-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 28 Jan 2026 05:43:50 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A1AD9D0D2
	for <lists+cgroups@lfdr.de>; Wed, 28 Jan 2026 05:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 559963016D0F
	for <lists+cgroups@lfdr.de>; Wed, 28 Jan 2026 04:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8680309F1C;
	Wed, 28 Jan 2026 04:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LNgNxgHV"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1463093DF
	for <cgroups@vger.kernel.org>; Wed, 28 Jan 2026 04:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769575427; cv=none; b=WdEEzo8PWTlQtOtLcsxlI15C0nQaHn/Z/jypjnRHUSVWD1D2+JwNoo9wFKla0P/0CRIav15HSlrHEfd/r6guE4t/kNOnpRl/1dANlYu1UtSBYCsnDpc7khG8EojiGha2wSn6i6s9k+OKp/AwkE+1ARj/XHrkJQ+ce4nXEwZFwcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769575427; c=relaxed/simple;
	bh=Na08qf2jeYA+I2H+hE/yjoqlFxSIRte5RSq8QCHGynw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LwWOJ/EaiSf3+/pErI/WjuL1UyK7B/7MHJfbivSYVpq/+SVW3kqjv4Vp989O7YWiJVj71OBO75cZQMFPc/qhYGYTn5BXc9sP5a7dBOhtH/8zn1vEe+unX2bUTRXw309tT1n3ZES3R4arUYUI4ppnO42ULm6S+1KPe/kbRO5rrng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LNgNxgHV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769575425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NaQ/CDnPwfTasasbEir9k1gSpnJdJQCwBstwGtlH3Gk=;
	b=LNgNxgHVhHLUGOMsK8uSouGrKBdhz+BLA5e+Kizh9A9Vpfck7+1LevkfFv0iRLih1Og594
	SOvBxm4CVhFMjZhdQcFR27gx9zDyV+PKggetwl3C80w3jeqtVFimuOz5ULnVjAGK8OefgG
	s4CiHiouKE2Wza7z+lzV+s8rxOIp5jM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-669-3eNpm5EMOw-pPkkrFRakSA-1; Tue,
 27 Jan 2026 23:43:42 -0500
X-MC-Unique: 3eNpm5EMOw-pPkkrFRakSA-1
X-Mimecast-MFC-AGG-ID: 3eNpm5EMOw-pPkkrFRakSA_1769575420
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A02CC1944F12;
	Wed, 28 Jan 2026 04:43:39 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.80.3])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BA7861800947;
	Wed, 28 Jan 2026 04:43:34 +0000 (UTC)
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
Subject: [PATCH/for-next 0/2] cgroup/cpuset: Fix partition related locking issues
Date: Tue, 27 Jan 2026 23:42:49 -0500
Message-ID: <20260128044251.1229702-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13482-lists,cgroups=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[test-cpuset-prs.sh:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7A1AD9D0D2
X-Rspamd-Action: no action

After booting the latest cgroup for-next debug kernel with the latest
cgroup changes as well as Federic's "cpuset/isolation: Honour kthreads
preferred affinity" patch series [1] merged on top and running the
test-cpuset-prs.sh test, a circular locking dependency lockdep splat
was reported. See patch 2 for details.

The following changes are made to resolve this locking problem.
 1) Deferring calling housekeeping_update() from CPU hotplug to task work
 2) Release cpus_read_lock before calling housekeeping_update()

With these changes, the cpuset test ran to completion with no failure
and no lockdep splat.

[1] https://lore.kernel.org/lkml/20260125224541.50226-1-frederic@kernel.org/

Waiman Long (2):
  cgroup/cpuset: Defer housekeeping_update() call from CPU hotplug to
    task_work
  cgroup/cpuset: Introduce a new top level isolcpus_update_mutex

 kernel/cgroup/cpuset.c                        | 124 ++++++++++++++----
 kernel/sched/isolation.c                      |   4 +-
 kernel/time/timer_migration.c                 |   3 +-
 .../selftests/cgroup/test_cpuset_prs.sh       |   9 ++
 4 files changed, 111 insertions(+), 29 deletions(-)

-- 
2.52.0


