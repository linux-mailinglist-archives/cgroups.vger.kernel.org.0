Return-Path: <cgroups+bounces-17177-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BPLPIrEnOmqQ2wcAu9opvQ
	(envelope-from <cgroups+bounces-17177-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 08:29:05 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B87D6B4795
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 08:29:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=IdTW5MBS;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17177-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17177-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E2B5230151D0
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 06:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860063C3452;
	Tue, 23 Jun 2026 06:28:57 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8903B9935
	for <cgroups@vger.kernel.org>; Tue, 23 Jun 2026 06:28:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782196137; cv=none; b=LC9giK2zx6GIWcctowI0yuHKzpsf2F5s9eog5c3K/RWv7i2WmFFMaAFeAK/uEwv9VpYaMn/3vpInoE6oe1CEqFHHrV+o5TQ3k+zdGvU+Os3BzmUVU1BtpiIEffCM2eerizXoz/bagxET/QW7a6iyfxmtjvaoI2J9Ov1yRsA7Wzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782196137; c=relaxed/simple;
	bh=VCguBDvHAvuVWf4nyW9f2ZN6GnenYj5/QONWunLTJe0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FCZ4TmuZA9lU/IcPsCPe2lAUDpSfnz1CiF2Iq3w/y1b9mLJkKvTwscsSX2gFIZKPTUr3/c/UQbUqI7B3xc3yzf6fc3RGbhyQgPZfcmT1XqD4o/Z5vWnf8H3s+44PaIDqXeJHJnj8Uva9wjy/URFC3Azq5DUUWQaGN3ZGpqpg+Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IdTW5MBS; arc=none smtp.client-ip=95.215.58.188
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782196123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=E6PGLy8bRZ4LM0S8hHpE/Y/YUCNvl+OFBFABUP2H23E=;
	b=IdTW5MBSADxS8XZ0gHcWA1wGgaLk8bwhNf/HRGpWJAGM5WPrWEGrPy/z3rQlH52bjeGixp
	XWpMTvaaA/ZVCWTwd12p7mbJDZXrwx2CAvKFxNfnFWfLas9Tv/u08dxgnFqGD9040mBWsk
	HVmeFbXjuySevsa+5qOTMe/t+YUJpfU=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: linux-mm@kvack.org
Cc: yingfu.zhou@shopee.com,
	jiayuan.chen@linux.dev,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kairui Song <kasong@tencent.com>,
	Qi Zheng <qi.zheng@linux.dev>,
	Barry Song <baohua@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Wei Xu <weixugc@google.com>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] memcg: bail out reclaim when memcg is dying
Date: Tue, 23 Jun 2026 14:27:53 +0800
Message-ID: <20260623062800.298514-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17177-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-mm@kvack.org,m:yingfu.zhou@shopee.com,m:jiayuan.chen@linux.dev,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:akpm@linux-foundation.org,m:kasong@tencent.com,m:qi.zheng@linux.dev,m:baohua@kernel.org,m:axelrasmussen@google.com,m:yuanchu@google.com,m:weixugc@google.com,m:david@kernel.org,m:ljs@kernel.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jiayuan.chen@linux.dev,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linux.dev:dkim,linux.dev:mid,linux.dev:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7B87D6B4795


Hi,

This series mitigates a system-wide stall we hit when a cgroup is
removed while one of its memory control files is doing synchronous
reclaim.

Problem Description
===================

Writing to memory.high, memory.max or memory.reclaim runs reclaim
synchronously in the writer's context, looping until the usage drops
below the target (or, for memory.reclaim, until the requested amount has
been reclaimed). On a large cgroup this can take a long time. The
latency is especially bad when reclaim has to perform swap I/O, where it
is bound by the swap device write bandwidth, and under thrashing it is
effectively unbounded - each round reclaims a few pages that the
workload immediately faults back in, so the loop keeps making "progress"
and never converges.

These writes go through cgroup_file_write(), which does not take
cgroup_mutex and does not pin the css. Instead, kernfs guarantees the
node (and thus the css) stays alive for the duration of the operation by
holding an active reference. So while the reclaim loop runs, the active
reference on the file is held.

If another task removes the same cgroup in parallel, cgroup_rmdir()
takes cgroup_mutex and then blocks in kernfs_drain() waiting for that
active reference to drain. Because cgroup_mutex is held throughout the
wait, every other task that needs it piles up behind the remover - in
our case the whole machine ground to a halt, with hung_task reports for
the remover and for unrelated tasks merely reading /proc/<pid>/cgroup:

INFO: task cgdelete:366634 blocked for more than 159 seconds.
      Not tainted 6.6.102+ #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Call Trace:
 <TASK>
 __schedule+0x3da/0x1650
 schedule+0x58/0x100
 kernfs_drain+0xe6/0x150
 __kernfs_remove.part.0+0xd0/0x200
 kernfs_remove_by_name_ns+0x75/0xd0
 cgroup_addrm_files+0x325/0x410
 css_clear_dir+0x50/0xf0
 cgroup_destroy_locked+0xdf/0x1e0
 cgroup_rmdir+0x2d/0xd0
 kernfs_iop_rmdir+0x53/0x90
 vfs_rmdir+0x98/0x240
 do_rmdir+0x172/0x1b0
 __x64_sys_rmdir+0x42/0x70
 x64_sys_call+0xeb0/0x2210
 do_syscall_64+0x56/0x90
 entry_SYSCALL_64_after_hwframe+0x78/0xe2


INFO: task systemd-journal:2352 blocked for more than 182 seconds.
      Not tainted 6.6.102+ #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Call Trace:
 <TASK>
 __schedule+0x3da/0x1650
 schedule+0x58/0x100
 schedule_preempt_disabled+0xe/0x20
 __mutex_lock.constprop.0+0x3bb/0x640
 __mutex_lock_slowpath+0x13/0x20
 mutex_lock+0x3c/0x50
 proc_cgroup_show+0x4d/0x380
 proc_single_show+0x53/0xe0
 seq_read_iter+0x12f/0x4b0
 seq_read+0xcd/0x110
 vfs_read+0xb1/0x360
 ? __seccomp_filter+0x368/0x590
 ksys_read+0x73/0x100
 __x64_sys_read+0x19/0x30
 x64_sys_call+0x18d3/0x2210
 do_syscall_64+0x56/0x90
 entry_SYSCALL_64_after_hwframe+0x78/0xe2

The system recovers only once the reclaim finally finishes and releases
the active reference. The reclaim itself is pointless here: the cgroup
is being torn down and its remaining pages will be reparented to the
parent anyway.

Even though we check signal_pending(current) in the reclaim loop, the
typical symptom is that cat /proc/<pid>/cgroup gets stuck.
By the time someone looks for which task is actually stuck in reclaim,
the hung task timeout has already been hit. This makes the problem
particularly nasty to debug from a hung-task report alone, because the
blocked tasks shown are often the victims, not the reclaim writer itself.

Our Mitigation
==============

cgroup destruction sets CSS_DYING in kill_css_sync() *before*
css_clear_dir() triggers the kernfs_drain() that blocks the remover. The
in-flight reclaim loop is therefore guaranteed to observe it. This series
checks memcg_is_dying() in the three reclaim loops (memory.high,
memory.max and proactive reclaim) and bails out early, so the writer
drops the active reference promptly and the remover can make progress.

Unlike the no-progress guard (MAX_RECLAIM_RETRIES), which only fires when
reclaim makes zero progress, the dying check also covers the slow swap
I/O and thrashing cases, where reclaim keeps succeeding a little and the
loop would otherwise never converge.

This is orthogonal to commit c8e6002bd611 ("memcg: introduce
non-blocking limit setting option"): O_NONBLOCK lets a caller avoid the
synchronous reclaim up front, while this series handles the case where
reclaim is already running when the cgroup starts being removed.

The legacy (v1) reclaim loops in mem_cgroup_force_empty() and
mem_cgroup_resize_max() share the same pattern but are left out for now.

Jiayuan Chen (3):
  memcg: bail out memory.high when memcg is dying
  memcg: bail out memory.max when memcg is dying
  memcg: bail out proactive reclaim when memcg is dying

 mm/memcontrol.c | 6 ++++++
 mm/vmscan.c     | 3 +++
 2 files changed, 9 insertions(+)

-- 
2.43.0


