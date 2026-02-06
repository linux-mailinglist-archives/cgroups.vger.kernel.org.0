Return-Path: <cgroups+bounces-13749-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UIOeHzFRhmnQLwQAu9opvQ
	(envelope-from <cgroups+bounces-13749-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 06 Feb 2026 21:38:09 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DA95110327D
	for <lists+cgroups@lfdr.de>; Fri, 06 Feb 2026 21:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 11CEC30401B2
	for <lists+cgroups@lfdr.de>; Fri,  6 Feb 2026 20:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5428130EF81;
	Fri,  6 Feb 2026 20:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fvLiAQGT"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E3730DEDD
	for <cgroups@vger.kernel.org>; Fri,  6 Feb 2026 20:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770410268; cv=none; b=hpQKeQthU6vQr3KNcpGL8gmRI7IogxCAA2KTV3bTxG2pkHOJzYpkVWLR1dtHfoVfPblAwzplf9yK1iNFya6lJbbTWitqzQBOzMDcz5GOL/rTrlXAFljjEeY5KdbR5fQetwhN/xy3gtylvde0gsMazf5M6YNM92hlvftM1KA6kR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770410268; c=relaxed/simple;
	bh=i4Uh+l4kvRN5zATgc6vOIEZ/4peCmiUHtNn9nTVYxI8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P/i+HbIf7fgS8kka6AL9Z1/5XG9J4hxNOhi2yVWArtSpT2YeqBBJVNkiFvFwLCtUcJTeO7hY5XuDuTmOgGJZoYD8yJaIlkXQWuDc1lKJ3/o9w4rAwn+nIRiIjuxHnB6YOW7Qlx4mi7xo28mjzWfryOcSlhz5r40Qn0xNs1RrvDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fvLiAQGT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770410266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=h4LBYUTBx6JOuIa9T2/oVmdddjNcWzl+HbR8l6hPpQY=;
	b=fvLiAQGTCm2wnPXWw16UURfnadEUygQ+apz/nk8waVi0h7SoEeog3vUFv695Con49CaxTC
	jt5L8AoCXbTt6JjVgMgWXo8ZQQ8H7FJ7YHQiuYEgPkr1JlYvK46f73uvnWLOZbilYU444w
	jthqEzE8RnkRSu22neNqqpKOB8ctf78=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-456-i0hvvCDUOfaf6Wiv6Cq27g-1; Fri,
 06 Feb 2026 15:37:40 -0500
X-MC-Unique: i0hvvCDUOfaf6Wiv6Cq27g-1
X-Mimecast-MFC-AGG-ID: i0hvvCDUOfaf6Wiv6Cq27g_1770410257
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2B38D1956068;
	Fri,  6 Feb 2026 20:37:36 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.90.86])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5EF5218003F6;
	Fri,  6 Feb 2026 20:37:31 +0000 (UTC)
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
Subject: [PATCH/for-next v4 0/4] cgroup/cpuset: Fix partition related locking issues
Date: Fri,  6 Feb 2026 15:37:08 -0500
Message-ID: <20260206203712.1989610-1-longman@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13749-lists,cgroups=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,test-cpuset-prs.sh:url]
X-Rspamd-Queue-Id: DA95110327D
X-Rspamd-Action: no action

 v4:
  - Fix various issues as reported by Chen Ridong.

 v3:
  - Add a new patch to clarify the locking rules for internal variables
  - Defer all housekeeping_update() calls with associated
    rebuild_sched_domains*() calls to either workqueue or task_work.

 v2:
  - Change patch 1 to use workqueue instead of task run as it is a
    per-cpu kthread that performs the cpuset shutdown and bringup work.
  - Simplify and streamline some of the code.

After booting the latest cgroup for-next debug kernel with the latest
cgroup changes as well as Federic's "cpuset/isolation: Honour kthreads
preferred affinity" patch series [1] merged on top and running the
test-cpuset-prs.sh test, a circular locking dependency lockdep splat
was reported. See patch 2 for details.

To fix this issue, a new top level cpuset_top_mutex is added and the
call to housekeeping_update() is deferred to either a task_work or to
a workqueue.

With these changes in place, the cpuset test ran to completion with no
failure and no lockdep splat.

[1] https://lore.kernel.org/lkml/20260125224541.50226-1-frederic@kernel.org/

Waiman Long (4):
  cgroup/cpuset: Clarify exclusion rules for cpuset internal variables
  cgroup/cpuset: Defer housekeeping_update() calls from CPU hotplug to
    workqueue
  cgroup/cpuset: Call housekeeping_update() without holding
    cpus_read_lock
  cgroup/cpuset: Eliminate some duplicated rebuild_sched_domains() calls

 kernel/cgroup/cpuset.c                        | 241 +++++++++++++-----
 kernel/sched/isolation.c                      |   4 +-
 kernel/time/timer_migration.c                 |   4 +-
 .../selftests/cgroup/test_cpuset_prs.sh       |  13 +-
 4 files changed, 196 insertions(+), 66 deletions(-)

-- 
2.52.0


