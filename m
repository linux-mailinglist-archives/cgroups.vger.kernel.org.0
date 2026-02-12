Return-Path: <cgroups+bounces-13898-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YCzGB7IEjmlf+gAAu9opvQ
	(envelope-from <cgroups+bounces-13898-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 17:49:54 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADD012F9FD
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 17:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6174B301D6B1
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 16:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69707337111;
	Thu, 12 Feb 2026 16:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UdSSXF9H"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFE22E645
	for <cgroups@vger.kernel.org>; Thu, 12 Feb 2026 16:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770914887; cv=none; b=jlI4osxBTEf7vCX1JRE6wDsH41LwZ1eQcBOyyAKYqu0tsVgLhIuFiiBUCYOV2Ou4FgTztEidEUMgE2HCAhO1DtLYVVA5WRDYM+VbWpqm/FyH0lUUa/uzh5mMepivXeN3wp6xUar3EIFYfvNmokQOC3ClEG9Sd4yt8lTAHeLcJlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770914887; c=relaxed/simple;
	bh=uwuysDv4Egm6HWkJcFBTn/BxyyKBdYqBBBP9D+4JqtU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gg680h+9SFH5m3MJgyzSrqYganxwPMdyq8AfRTD0Z3qG9U61qNv0++DfoJTgB/F9N5BzQXy74tt2zTrR5qi8b3d3sVz7b/bWesw4XrBfwEl6dS6w0K9JZWuAAs7z+G/X+pHLzLrz/VAUIKWoMqV7M6kq5m86YT62gQo2QmaX66c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UdSSXF9H; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770914885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Fv0QQ/LzpI3se0WIY5xcYuoXMkPUfDvoExJnqJMuXLA=;
	b=UdSSXF9HvaaytDlrDYyy7n9hwtToNS6qlBjcW1rEc/aUkAksknl+Bmra9KG23dePT1unIH
	zlaJl4z2pWnjUwqqS7Mq//uReIegiqnesp9RMV4rbYuj/CEkyRwkorONDol+EAdSyw3lxT
	jDMC3SWpFS9NnfoyoL5i2wHleqVbwbk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-13-NtwfyrDXMBa8kZ1dcxoubA-1; Thu,
 12 Feb 2026 11:48:01 -0500
X-MC-Unique: NtwfyrDXMBa8kZ1dcxoubA-1
X-Mimecast-MFC-AGG-ID: NtwfyrDXMBa8kZ1dcxoubA_1770914879
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1A69D19560AA;
	Thu, 12 Feb 2026 16:47:59 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.80.194])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2962918003F5;
	Thu, 12 Feb 2026 16:47:55 +0000 (UTC)
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
Subject: [PATCH v5 0/6] cgroup/cpuset: Fix partition related locking issues
Date: Thu, 12 Feb 2026 11:46:34 -0500
Message-ID: <20260212164640.2408295-1-longman@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13898-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	RCVD_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,test-cpuset-prs.sh:url]
X-Rspamd-Queue-Id: 6ADD012F9FD
X-Rspamd-Action: no action

 v5:
  - Reapply on top of the latest upstream linux tree.
  - Add a new fix patch for a cpuset bug found during testing.
  - Add a patch to not update isolated_cpus when calling from CPU
    hotplug. As a result, CPU hotplug won't need to call
    housekeeping_update() at all and the corresponding wq deferral
    patch is dropped.

 v4:
  - https://lore.kernel.org/lkml/20260206203712.1989610-1-longman@redhat.com/

After booting the latest cgroup for-next debug kernel with the latest
cgroup changes as well as Federic's "cpuset/isolation: Honour kthreads
preferred affinity" patch series [1] merged on top and running the
test-cpuset-prs.sh test, a circular locking dependency lockdep splat
was reported. See patch 5 for details.

To fix this issue, the cpuset code is modified to not doing any
update to isolated_cpus when calling from CPU hotplug. In addition,
the housekeeping_update() call, when needed, is deferred to task_work
so that it can be called without holding a cpus_read_lock. A new top
level cpuset_top_mutex is also added to have more exclusion control.

With these changes in place, the cpuset test ran to completion with no
failure and no lockdep splat.

[1] https://lore.kernel.org/lkml/20260125224541.50226-1-frederic@kernel.org/

Waiman Long (6):
  cgroup/cpuset: Fix incorrect change to effective_xcpus in
    partition_xcpus_del()
  cgroup/cpuset: Clarify exclusion rules for cpuset internal variables
  cgroup/cpuset: Set isolated_cpus_updating only if isolated_cpus is
    changed
  cgroup/cpuset: Don't update isolated_cpus from CPU hotplug
  cgroup/cpuset: Call housekeeping_update() without holding
    cpus_read_lock
  cgroup/cpuset: Eliminate some duplicated rebuild_sched_domains() calls

 kernel/cgroup/cpuset.c                        | 313 ++++++++++++++----
 kernel/sched/isolation.c                      |   4 +-
 kernel/time/timer_migration.c                 |   4 +-
 .../selftests/cgroup/test_cpuset_prs.sh       |  21 +-
 4 files changed, 259 insertions(+), 83 deletions(-)

-- 
2.52.0


