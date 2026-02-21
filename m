Return-Path: <cgroups+bounces-14090-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CKPJIH3/mWlgXwMAu9opvQ
	(envelope-from <cgroups+bounces-14090-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 21 Feb 2026 19:54:53 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC59D16D8F5
	for <lists+cgroups@lfdr.de>; Sat, 21 Feb 2026 19:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A0C5302BB83
	for <lists+cgroups@lfdr.de>; Sat, 21 Feb 2026 18:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE9D3090C4;
	Sat, 21 Feb 2026 18:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b8fXLHP8"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129CE2F3C18
	for <cgroups@vger.kernel.org>; Sat, 21 Feb 2026 18:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771700088; cv=none; b=eaeAIaN+4WeR+8MEFqHdJLTv76LKgTTttNv4LwK9UXQZivl32ZUJ07nwGCOOdB4oXTWXF+xxuSwzOQuSCEryi0FqSwApXskiADG5xXQMQqE7ChIuJpenByT2GJAIBPQlF0BNUE07CxbkSzVEuIcv9oYTd3HKEQH3DiXbUkZboeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771700088; c=relaxed/simple;
	bh=VHhS8fm7kDxQvXABgihMOlacvQHX9vGIUNwB2e7Zxjk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QiRtDfv8e/a1w8c376fESkWLRXkUnvqKEls1kbqe2gsiksLKPdir6hIm70bLkeNlZLGl9PKbeZGKnIf2hlDnDlRknWPThAzCBnbCXqzx5gZOOCpFAHS0Q5dZCIiiDZQ2tLGDX2Z9jfQKtWpkj3njC7ml6/xacF72aNZFlNfft9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b8fXLHP8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771700086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1iNJTDv12E46ZvUAk+QwQH33JvtwYkmz3TRiSZZMbEM=;
	b=b8fXLHP8d5cKHcQCisMrO9rUGyWTMrzUvvuvnkcPB/P/DKokEWT5z4ZCnbLEmffwTO/RDJ
	dTSRYlGAKUG1rFXwdWPvq7eD9eZZpA0iXuqzKpbtJ2aLJsVgRjTVU0rWbOYIsN9EmWSlFr
	uhAT0wjqZRJHihDO2cA/75+O55BUWro=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-592-Cq4xwRISN1eF4eNzsePtzw-1; Sat,
 21 Feb 2026 13:54:42 -0500
X-MC-Unique: Cq4xwRISN1eF4eNzsePtzw-1
X-Mimecast-MFC-AGG-ID: Cq4xwRISN1eF4eNzsePtzw_1771700080
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D04861956088;
	Sat, 21 Feb 2026 18:54:39 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.2.16.15])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 947161955F22;
	Sat, 21 Feb 2026 18:54:34 +0000 (UTC)
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
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Shuah Khan <shuah@kernel.org>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Waiman Long <longman@redhat.com>
Subject: [PATCH v6 0/8] cgroup/cpuset: Fix partition related locking issues
Date: Sat, 21 Feb 2026 13:54:10 -0500
Message-ID: <20260221185418.29319-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14090-lists,cgroups=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
X-Rspamd-Queue-Id: CC59D16D8F5
X-Rspamd-Action: no action

 v6:
  - Rebase on top of the latest v7.0 pre-RC linux tree.
  - Add another fix patch to fix found during code inspection.
  - Revert back to the v4 idea of just deferring the housekeeping_update()
    call to workqueue to make it simple as v5 change will add quite a
    bit more complexity to the cpuset code.

 v5:
  - https://lore.kernel.org/lkml/20260212164640.2408295-1-longman@redhat.com/

After booting the latest linux debug kernel with the latest cgroup
changes as well as Federic's "cpuset/isolation: Honour kthreads
preferred affinity" patch series [1] merged on top and running the
test-cpuset-prs.sh test, a circular locking dependency lockdep splat
was reported. See patch 5 for details.

To fix this issue, the cpuset code is modified to not call
housekeeping_update() with cpu_hotplug_lock held.  The cpuset hotplug
code is also modified to defer the housekeeping_update() call, if needed,
to workqueue.  A new top level cpuset_top_mutex is added to have more
exclusion control.

With these changes in place, the cpuset test ran to completion with no
failure and no lockdep splat.

[1] https://lore.kernel.org/lkml/20260125224541.50226-1-frederic@kernel.org/

Waiman Long (8):
  cgroup/cpuset: Fix incorrect change to effective_xcpus in
    partition_xcpus_del()
  cgroup/cpuset: Fix incorrect use of cpuset_update_tasks_cpumask() in
    update_cpumasks_hier()
  cgroup/cpuset: Clarify exclusion rules for cpuset internal variables
  cgroup/cpuset: Set isolated_cpus_updating only if isolated_cpus is
    changed
  kselftest/cgroup: Simplify test_cpuset_prs.sh by removing "S+" command
  cgroup/cpuset: Move housekeeping_update()/rebuild_sched_domains()
    together
  cgroup/cpuset: Defer housekeeping_update() calls from CPU hotplug to
    workqueue
  cgroup/cpuset: Call housekeeping_update() without holding
    cpus_read_lock

 kernel/cgroup/cpuset.c                        | 220 +++++++++++------
 kernel/sched/isolation.c                      |   4 +-
 kernel/time/timer_migration.c                 |   4 +-
 .../selftests/cgroup/test_cpuset_prs.sh       | 225 +++++++++---------
 4 files changed, 265 insertions(+), 188 deletions(-)

-- 
2.53.0


