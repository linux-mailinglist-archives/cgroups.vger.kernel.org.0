Return-Path: <cgroups+bounces-17109-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 07wlOHDsN2q9VgcAu9opvQ
	(envelope-from <cgroups+bounces-17109-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 21 Jun 2026 15:51:44 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DF46AAFBD
	for <lists+cgroups@lfdr.de>; Sun, 21 Jun 2026 15:51:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=smail.nju.edu.cn header.s=iohv2404 header.b=2l6T2vod;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17109-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17109-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=smail.nju.edu.cn;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 262DD301AF7E
	for <lists+cgroups@lfdr.de>; Sun, 21 Jun 2026 13:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67814284693;
	Sun, 21 Jun 2026 13:50:58 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20214367F25;
	Sun, 21 Jun 2026 13:50:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782049858; cv=none; b=PtXzg7IDFzAXmD8c6Cyqo/3z3Jd7al+NJzlJuVPaSH2ylT0uvJ4l+Nsfvo9ZbktwhIcbLFD7PnFEU1IQDLIdnJTsjJApup28+S1p7ADUDDc/y4RKI9LKx2oTb4HGGo1q+rz5AJUvPzjCva+RyoPicMsM3Br7NjqleFf49XDmkFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782049858; c=relaxed/simple;
	bh=4I7llRwOexdLfHFbpeIY7b2YSY8ud3/lSpeyWQd2550=;
	h=Content-Type:Message-ID:Date:MIME-Version:From:Subject:To:Cc; b=HTp2hdDQNg5hcjXut481B5hAIoO5osHJXyDhamK8Nng1PKIvH2MM79LwzuK5vyScodYHUFwWmZI1I/sM8u9tldO1pPg2dEUe+078lZzimhr3mkSQDyDcTftU/ZImQF0t4eqtdO64LkV8llEEjYAZcP669tgwk1teu9wKxKrSArc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b=2l6T2vod; arc=none smtp.client-ip=54.243.244.52
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
	s=iohv2404; t=1782049835;
	bh=1qMpDbgC70bC5KaRwZaPCdyTFwfWmYX0bjO7MplJL0M=;
	h=Message-ID:Date:MIME-Version:From:Subject:To;
	b=2l6T2vodKj58Y325BryzeGwvruhbo6avL65BBV+6Nx/6JV47epgDBazkPFDzZ72QE
	 dtub+APgpNmYyMC5RYpgVpl73xoUuyj5hBLIFE8yOzudeZpZ3RvRnc3NgZu7u1EHSW
	 81Wt5Dakm7g1oiz/a18hHjaJ8FLBvuuI0eZEttZw=
X-QQ-mid: zesmtpsz8t1782049827t67e7db56
X-QQ-Originating-IP: l20e2MZlJYjUG7DBlF2FT7GhxhTjDN07OK8aD+mY6ps=
Received: from [127.0.0.1] ( [202.119.42.245])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 21 Jun 2026 21:50:24 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17906991210919308474
Content-Type: multipart/mixed; boundary="------------4exgc87OP1BHmbzgeiNkZl3w"
Message-ID: <5A9E929D82717101+12fcf643-efb8-4b9a-a53a-1e28cc894f0b@smail.nju.edu.cn>
Date: Sun, 21 Jun 2026 21:50:23 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Peiyang He <peiyang_he@smail.nju.edu.cn>
Subject: [BUG] mm: mglru: stale aging batch triggers lru_gen_exit_memcg
 warning
To: akpm@linux-foundation.org, hannes@cmpxchg.org, linux-mm@kvack.org
Cc: mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
 muchun.song@linux.dev, qi.zheng@linux.dev, kasong@tencent.com,
 baohua@kernel.org, axelrasmussen@google.com, yuanchu@google.com,
 weixugc@google.com, david@kernel.org, ljs@kernel.org,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller@googlegroups.com
Content-Language: en-US
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: NX8UFBkt3Mu8iybAc4OBn937jKT9EX7QxnPnTiK9IlxASGwCvuue1R/+
	JZzP+jDwqUd3cYfjWZsSl/fIvrstEDdVPO1pVBLfIlAZMCg6v3m4g5CI60KeigMc6CnDwL+
	gcuK6eOXdL1wgPZDp8Qa1ir8qqmiKuWOhoVJ3G/JP/CzJjKWmqKWeBHZkdMBCzuL2DghvV2
	rYLYQ2tFDOpAonvp6Q6tYTRpo4fTkYw30w/xBeWnNm20ryMDAK/2fxLj3WX3fWfoJYNzbOy
	TSMxjUOMVXHYXmBAif7HDRzSygsmI+VJWjADkx5m/3osRBrBv5Gs3X1RTNO/RhtTHTELR6j
	Zj5SpSsXP883soi++GESpfMUAsepPk7lmYIPRgNybEq5eDFO3hrFABdEMVK1ap5hipTA02r
	k4ub0A+MgchCssG1+52F//wKu+eJVt95azCyuxIhvBqVsiJdcEtCPARTI2WgyK3nQghIXux
	vpGiS5LxfOuoug2jS5+EbI5e/LEMjHwXIsFL9II7s8peE5K1FkWIsGKHU77d2iuJ/aOgqyj
	Oc2NjWjrEJVCYGiNYnQQOFT0LyqDIWsLI8c9VPpmPuIyC1r3KvO34bNLmq0x91ll5X4OMVl
	1lsqInVZK6PyAEKkkdTxEs8/qU2L4qzLXCopk5pdSzSoF/CfHkUaq3TrHigJ6+N/uPnU6z9
	5Zqc/GFR5yB2gGiTxeivZaG4eC18ajgHXO8vPdbt63ZRNrNUux+A3awpS5mxT6ElmAeoKlW
	0oqEl0+h9EiXWQcG+rueLvfjlTbwpu4G5/098oS+G3HCFWHa4Hqs8HsFWbAGX251yDmSrd2
	Y1mVRSZgEucSbarC7f17wkJktmk1MdusGE5p2E69Xq6BV/OiLMBg73idP3Z4jaQr6CZ8R3Z
	2FE4M8AWFowN5CB+jP7kohJ0pkKRp4E+vdITahDoHCTqi99TqI1EuUtq6oe+hUsSzJPSug0
	pjWoNXih/Yr3deZ0d5agIqQs65IVHUgfqZ00wbB+2s95USgPlvijW7i4l9HUvvYoi7Kp0Ud
	2fjsGzQ7itcZV7Y9E6lBLnFxhhXdXycLEX5BqTWf2Z8JtreY9P9Sv/AeqC3m6qh5PfzF3Qh
	rXd6ak7FV3SL0N/QgyMSPdGDGRcX5pFJsxnX/VdojlF4txRiDV/eMndcXFBuJhy94dEMEcQ
	DumY
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.96 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[smail.nju.edu.cn,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[smail.nju.edu.cn:s=iohv2404];
	MAILLIST(-0.15)[generic];
	MIME_UNKNOWN(0.10)[application/x-sh];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:akpm@linux-foundation.org,m:hannes@cmpxchg.org,m:linux-mm@kvack.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:qi.zheng@linux.dev,m:kasong@tencent.com,m:baohua@kernel.org,m:axelrasmussen@google.com,m:yuanchu@google.com,m:weixugc@google.com,m:david@kernel.org,m:ljs@kernel.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:syzkaller@googlegroups.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:+,4:~];
	TAGGED_FROM(0.00)[bounces-17109-lists,cgroups=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[peiyang_he@smail.nju.edu.cn,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_MUA_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[smail.nju.edu.cn:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peiyang_he@smail.nju.edu.cn,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,smail.nju.edu.cn:dkim,smail.nju.edu.cn:mid,smail.nju.edu.cn:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E4DF46AAFBD

This is a multi-part message in MIME format.
--------------4exgc87OP1BHmbzgeiNkZl3w
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

I hit the following warning while fuzzing other kernel code with Syzkaller.

The original Syzkaller report:

WARNING: mm/vmscan.c:5867 at lru_gen_exit_memcg+0x26f/0x300 
mm/vmscan.c:5867, CPU#0: kworker/0:0/9
Modules linked in:
CPU: 0 UID: 0 PID: 9 Comm: kworker/0:0 Not tainted 7.1.0 #2 PREEMPT(full)
Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 
1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Workqueue: cgroup_free css_free_rwork_fn
RIP: 0010:lru_gen_exit_memcg+0x26f/0x300 mm/vmscan.c:5867
Code: 89 de e8 d4 62 ba ff 49 83 fd 3f 0f 86 9c fe ff ff 48 83 c4 08 5b 
5d 41 5c 41 5d 41 5e 41 5f e9 17 68 ba ff e8 12 68 ba ff 90 <0f> 0b 90 
e9 b0 fe ff ff e8 04 68 ba ff 66 90 e8 fd 67 ba ff 90 0f
RSP: 0018:ffffc900001afb78 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff82049e88
RDX: ffff888016f35c40 RSI: ffffffff8204a02e RDI: ffff88801d4103b8
RBP: dffffc0000000000 R08: 0000000000000005 R09: 0000000000000040
R10: 0000000000000000 R11: 0000000000002ba4 R12: ffff8880481f1600
R13: ffff88801d410650 R14: ffff88801d410040 R15: dead000000000100
FS:  0000000000000000(0000) GS:ffff888098d91000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055ac6490c1d8 CR3: 00000000249b0000 CR4: 0000000000350ef0
Call Trace:
  <TASK>
  mem_cgroup_free mm/memcontrol.c:3972 [inline]
  mem_cgroup_css_free+0x76/0xb0 mm/memcontrol.c:4241
  css_free_rwork_fn+0x125/0x1260 kernel/cgroup/cgroup.c:5575
  process_one_work+0xa0d/0x1c30 kernel/workqueue.c:3314
  process_scheduled_works kernel/workqueue.c:3397 [inline]
  worker_thread+0x645/0xe80 kernel/workqueue.c:3478
  kthread+0x367/0x480 kernel/kthread.c:436
  ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
  </TASK>

Kernel version: commit 8cd9520d35a6c38db6567e97dd93b1f11f185dc6 (tag v7.1)

Relevant kernel config:

   CONFIG_MEMCG=y
   CONFIG_LRU_GEN=y
   CONFIG_LRU_GEN_ENABLED=y
   CONFIG_LRU_GEN_WALKS_MMU=y
   CONFIG_NUMA=y

Root Cause:

The bug is a race between two code paths that each hold 
`lruvec->lru_lock`, but at
non-overlapping times.

Component 1 - `reset_batch_size()`:

During `walk_mm()`, `update_batch_size()` accumulates per-generation 
page deltas into
`walk->nr_pages` WITHOUT holding `lruvec_lock`.  After 
`mmap_read_unlock(mm)`, the
walker reacquires `lruvec_lock` and `reset_batch_size()` writes those deltas
UNCONDITIONALLY into `lrugen->nr_pages`.

Component 2 - `lru_gen_reparent_memcg()`:

When a memcg is offlined, `lru_gen_reparent_memcg()` moves all folios to 
the parent
lruvec and zeros the child's `lrugen->nr_pages`, all under `lruvec_lock`.

I have not bisected the issue.  Based on code inspection, the important 
interaction
appears to be the reparenting path that clears the child's `nr_pages` while
`reset_batch_size()` can still commit a batch that was generated before 
the memcg
went offline.  This looks related to f304652609ea ("mm: vmscan: prepare for
reparenting MGLRU folios").

Race sequence:

     1. The aging path enters walk_mm() for the child memcg lruvec.

     2. walk_page_range() scans PTEs and update_batch_size() stores 
deltas in
        walk->nr_pages.  At this point the deltas have not been committed to
        lruvec->lrugen.nr_pages yet.

     3. walk_mm() drops mmap_read_lock(mm).  Before it reaches
        reset_batch_size(), the child memcg is killed and removed.

     4. The memcg offline path runs lru_gen_reparent_memcg().  Under
        lruvec_lock, it moves the child folios to the parent and clears the
        child's lrugen.nr_pages.

     5. The old aging walk resumes, takes lruvec_lock, and 
reset_batch_size()
        writes the stale walk->nr_pages deltas back into the original child
        lruvec.

     6. Later, lru_gen_exit_memcg(child) checks the child's 
lrugen.nr_pages with
        memchr_inv(...).  Since the stale batch made some slots non-zero 
again,
        VM_WARN_ON_ONCE() triggers.

The two critical sections are serialized by `lruvec_lock`, but the batch 
accumulation
in `walk->nr_pages` happens outside that lock, so there is no ordering 
between the
accumulation and the reparenting zeroing.

The relevant code path:

   mm/vmscan.c:
     run_cmd('+')              selects the target memcg and child lruvec
     try_to_inc_max_seq()      stores the child lruvec in walk->lruvec
     update_batch_size()       accumulates deltas in walk->nr_pages
     walk_mm()                 calls walk_page_range(), then later 
reset_batch_size()
     reset_batch_size()        writes cached deltas into 
walk->lruvec->lrugen.nr_pages
     lru_gen_reparent_memcg()  reparents child MGLRU state and clears 
child nr_pages
     lru_gen_exit_memcg()      warns if the exiting memcg has non-zero 
nr_pages

   mm/memcontrol.c:
     mem_cgroup_css_offline()  calls memcg_reparent_objcgs() and 
lru_gen_offline_memcg()
     mem_cgroup_free()         calls lru_gen_exit_memcg()

Reproducer:

The C reproducer and the helper script for running it are provided in 
the attachments.

The PoC creates a leaf memory cgroup, moves a victim process into it, 
and makes the victim fault and continuously touch file-backed pages so 
MGLRU aging can produce cached generation deltas for that memcg. A 
separate `lru_ager` thread repeatedly writes aging commands to 
`/sys/kernel/debug/lru_gen`; when the instrumentation reports that the 
ager is delayed just before `reset_batch_size()`, the PoC kills the 
victim and removes the leaf cgroup, forcing memcg offline/reparenting 
before the stale batch is committed.

The helper script builds the PoC, creates a temporary qcow2 overlay, 
boots the instrumented kernel in QEMU with fake NUMA and SSH port 
forwarding, copies the PoC into the guest, runs it, and scans the serial 
console for `exit_nonzero`, `WARNING: mm/vmscan.c`, or `Kernel panic`. 
It writes the full serial console, extracted kernel events, and guest 
stdout/stderr under the chosen output directory.

The example command:

   ./repros/lru_gen_exit_memcg/run_poc_qemu.sh /tmp/lru_gen_poc_manual 
10450 20 32

The arguments are:

   /tmp/lru_gen_poc_manual  output directory for the overlay, console log,
                            extracted events and guest log
   10450                    host TCP port forwarded to guest SSH
   20                       number of PoC iterations to run
   32                       file-backed working-set size in MiB per 
iteration

The script uses default `KERNEL`, `IMAGE` and `SSH_KEY` paths, or they 
can be
overridden with environment variables.

Since this bug requires a specific race window, kernel instrumentation 
is needed
to enlarge the race window in order to reproduce the bug more reliably.  The
instrumentation patch is also included in the attachments.

The patch only instruments `mm/vmscan.c`: it delays the PoC aging task just
before `reset_batch_size()`, logs when a stale batch is written into an 
already
offlined and zeroed memcg lruvec, and dumps the non-zero 
`lrugen.nr_pages` slots
before `lru_gen_exit_memcg()` triggers the warning.

A successful run reports `status=repro_triggered`, and the extracted events
include a warning like:

   WARNING: mm/vmscan.c:5943 at lru_gen_exit_memcg+0x420/0x520

Proposed Fix:

One possible fix direction is to make `reset_batch_size()` skip writing 
back the
stale delta when the memcg is no longer online. `reset_batch_size()` is 
called
under `lruvec_lock`, the same lock that `lru_gen_reparent_memcg()` holds 
when it
zeroes `nr_pages`, so this should avoid committing a batch after 
reparenting has
completed.

Possible fix direction, not a tested patch:

--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -... reset_batch_size() ...
  static void reset_batch_size(struct lru_gen_mm_walk *walk)
  {
      int gen, type, zone;
      struct lruvec *lruvec = walk->lruvec;
      struct lru_gen_folio *lrugen = &lruvec->lrugen;
+    struct mem_cgroup *memcg = lruvec_memcg(lruvec);

      walk->batched = 0;

      for_each_gen_type_zone(gen, type, zone) {
          enum lru_list lru = type * LRU_INACTIVE_FILE;
          int delta = walk->nr_pages[gen][type][zone];

          if (!delta)
              continue;

          walk->nr_pages[gen][type][zone] = 0;
+
+        /*
+         * If the memcg went offline while we were walking page tables,
+         * lru_gen_reparent_memcg() has already zeroed nr_pages and moved
+         * all folios to the parent.  Writing our stale batch delta back
+         * would corrupt the offline child and trigger WARN_ON in
+         * lru_gen_exit_memcg().  Discard the delta; the parent lruvec
+         * already owns the pages and accounts for them correctly.
+         */
+        if (memcg && !mem_cgroup_online(memcg))
+            continue;
+
          WRITE_ONCE(lrugen->nr_pages[gen][type][zone],
                 lrugen->nr_pages[gen][type][zone] + delta);

          if (lru_gen_is_active(lruvec, gen))
              lru += LRU_ACTIVE;
          __update_lru_size(lruvec, lru, zone, delta);
      }
  }

Thanks
--------------4exgc87OP1BHmbzgeiNkZl3w
Content-Type: text/plain; charset=UTF-8; name="poc_lru_race.c"
Content-Disposition: attachment; filename="poc_lru_race.c"
Content-Transfer-Encoding: base64

LyoKICogTWluaW1hbCBNR0xSVSBtZW1jZyByZXBhcmVudCByYWNlIFBvQy4KICoKICogVGhp
cyBwcm9ncmFtIGV4cGVjdHMgdGhlIGNvbXBhbmlvbiBpbnN0cnVtZW50YXRpb24gcGF0Y2gg
dG8gYWRkIGEgc2hvcnQKICogZGVsYXkgYmVmb3JlIHJlc2V0X2JhdGNoX3NpemUoKSBmb3Ig
Y2dyb3VwcyBuYW1lZCAvbHJ1X2dlbl9yYWNlXyogYW5kIHRvIGxvZwogKiAiZGVsYXlfYmVm
b3JlX3Jlc2V0Ii4gIFRoZSBwcm9ncmFtIHdhaXRzIGZvciB0aGF0IGxvZyBsaW5lLCB0ZWFy
cyBkb3duIHRoZQogKiB0YXJnZXQgbWVtY2csIGFuZCBsZXRzIHRoZSBzdGFsZSBNR0xSVSBi
YXRjaCBjb21taXQgaW50byB0aGUgb2ZmbGluZWQgY2hpbGQuCiAqLwoKI2RlZmluZSBfR05V
X1NPVVJDRQojaW5jbHVkZSA8ZXJybm8uaD4KI2luY2x1ZGUgPGZjbnRsLmg+CiNpbmNsdWRl
IDxwdGhyZWFkLmg+CiNpbmNsdWRlIDxzaWduYWwuaD4KI2luY2x1ZGUgPHN0ZGF0b21pYy5o
PgojaW5jbHVkZSA8c3RkYm9vbC5oPgojaW5jbHVkZSA8c3RkaW50Lmg+CiNpbmNsdWRlIDxz
dGRpby5oPgojaW5jbHVkZSA8c3RkbGliLmg+CiNpbmNsdWRlIDxzdHJpbmcuaD4KI2luY2x1
ZGUgPHN5cy9tbWFuLmg+CiNpbmNsdWRlIDxzeXMvbW91bnQuaD4KI2luY2x1ZGUgPHN5cy9w
cmN0bC5oPgojaW5jbHVkZSA8c3lzL3N0YXQuaD4KI2luY2x1ZGUgPHN5cy93YWl0Lmg+CiNp
bmNsdWRlIDx1bmlzdGQuaD4KCiNkZWZpbmUgQ0dST1VQX1JPT1QgIi9zeXMvZnMvY2dyb3Vw
IgojZGVmaW5lIExSVV9HRU5fRklMRSAiL3N5cy9rZXJuZWwvZGVidWcvbHJ1X2dlbiIKI2Rl
ZmluZSBQQUdFX0JZVEVTIDQwOTZVTAojZGVmaW5lIE1BWF9OT0RFUyA4CiNkZWZpbmUgREVG
QVVMVF9JVEVSUyAyMAojZGVmaW5lIERFRkFVTFRfRklMRV9NSUIgMzIKI2RlZmluZSBXSU5E
T1dfVElNRU9VVF9NUyA5MDAwMAojZGVmaW5lIENPTkZJUk1fVElNRU9VVF9NUyA1MDAwCgpl
bnVtIHsKCVBIQVNFX0lETEUgPSAwLAoJUEhBU0VfV0lORE9XID0gMSwKCVBIQVNFX0RPTkUg
PSAyLAp9OwoKLyogTHJ1SW5mbyBzdG9yZXMgdGhlIGRlYnVnZnMgTUdMUlUgaWRzIG5lZWRl
ZCB0byBpc3N1ZSBhZ2luZyBjb21tYW5kcy4gKi8Kc3RydWN0IGxydV9pbmZvIHsKCXVuc2ln
bmVkIGxvbmcgbWVtY2dfaWQ7IC8qIE1lbWNnIGlkIGFjY2VwdGVkIGJ5IC9zeXMva2VybmVs
L2RlYnVnL2xydV9nZW4uICovCglpbnQgbnJfbm9kZXM7IC8qIE51bWJlciBvZiBOVU1BIG5v
ZGVzIHBhcnNlZCBmb3IgdGhpcyBtZW1jZy4gKi8KCWludCBub2Rlc1tNQVhfTk9ERVNdOyAv
KiBOb2RlIGlkcyBwYXJzZWQgZnJvbSAvc3lzL2tlcm5lbC9kZWJ1Zy9scnVfZ2VuLiAqLwoJ
dW5zaWduZWQgbG9uZyBtYXhfc2VxW01BWF9OT0RFU107IC8qIExhdGVzdCBnZW5lcmF0aW9u
IHNlcXVlbmNlIGZvciBlYWNoIG5vZGUuICovCn07CgovKiBSYWNlU3RhdGUgaXMgc2hhcmVk
IGJ5IHRoZSBhZ2VyLCBrbXNnIHJlYWRlciwgYW5kIG1haW4gaXRlcmF0aW9uLiAqLwpzdHJ1
Y3QgcmFjZV9zdGF0ZSB7CgljaGFyIGxlYWZbMTAyNF07IC8qIEFic29sdXRlIGNncm91cCBw
YXRoIGZvciB0aGUgY3VycmVudCBsZWFmLiAqLwoJY2hhciBsZWFmX3JlbFsxMDI0XTsgLyog
Q2dyb3VwIHBhdGggYXMgcHJpbnRlZCBieSBjZ3JvdXBfcGF0aCgpLiAqLwoJY2hhciBmaWxl
X3BhdGhbNTEyXTsgLyogRmlsZSBtYXBwZWQgYnkgdGhlIHZpY3RpbSBwcm9jZXNzLiAqLwoJ
cGlkX3QgdmljdGltOyAvKiBWaWN0aW0gcGlkIGNoYXJnZWQgdG8gdGhlIGxlYWYgbWVtY2cu
ICovCglhdG9taWNfaW50IHBoYXNlOyAvKiBDdXJyZW50IHN5bmNocm9uaXphdGlvbiBwaGFz
ZS4gKi8KCWludCBpdGVyOyAvKiBJdGVyYXRpb24gaW5kZXggdXNlZCBvbmx5IGZvciBjb25j
aXNlIHByb2dyZXNzIG91dHB1dC4gKi8KfTsKCi8qIERpZSBwcmludHMgYSBzeXNjYWxsIGZh
aWx1cmUgYW5kIGV4aXRzIHRoZSBwcm9jZXNzLiAqLwpzdGF0aWMgdm9pZCBkaWUoY29uc3Qg
Y2hhciAqd2hhdCkKewoJcGVycm9yKHdoYXQpOwoJZXhpdCgxKTsKfQoKLyogV3JpdGVGaWxl
IHdyaXRlcyBhIHNob3J0IHN0cmluZyBpbnRvIGEgc3lzZnMvY2dyb3VwZnMgY29udHJvbCBm
aWxlLiAqLwpzdGF0aWMgaW50IHdyaXRlX2ZpbGUoY29uc3QgY2hhciAqcGF0aCwgY29uc3Qg
Y2hhciAqdmFsdWUpCnsKCWludCBmZCA9IG9wZW4ocGF0aCwgT19XUk9OTFkgfCBPX0NMT0VY
RUMpOwoKCWlmIChmZCA8IDApCgkJcmV0dXJuIC0xOwoKCXNzaXplX3QgcmV0ID0gd3JpdGUo
ZmQsIHZhbHVlLCBzdHJsZW4odmFsdWUpKTsKCWludCBzYXZlZF9lcnJubyA9IGVycm5vOwoK
CWNsb3NlKGZkKTsKCWVycm5vID0gc2F2ZWRfZXJybm87CglyZXR1cm4gcmV0IDwgMCA/IC0x
IDogMDsKfQoKLyogTWtkaXJJZk1pc3NpbmcgY3JlYXRlcyBhIGNncm91cCBkaXJlY3Rvcnkg
aWYgaXQgaXMgbm90IGFscmVhZHkgcHJlc2VudC4gKi8Kc3RhdGljIGludCBta2Rpcl9pZl9t
aXNzaW5nKGNvbnN0IGNoYXIgKnBhdGgpCnsKCWlmICghbWtkaXIocGF0aCwgMDc1NSkgfHwg
ZXJybm8gPT0gRUVYSVNUKQoJCXJldHVybiAwOwoKCXJldHVybiAtMTsKfQoKLyogRW5hYmxl
TWVtb3J5Q29udHJvbGxlciBlbmFibGVzIG1lbW9yeSBhY2NvdW50aW5nIGJlbG93IGEgY2dy
b3VwLiAqLwpzdGF0aWMgdm9pZCBlbmFibGVfbWVtb3J5X2NvbnRyb2xsZXIoY29uc3QgY2hh
ciAqY2cpCnsKCWNoYXIgcGF0aFs2NDBdOwoKCXNucHJpbnRmKHBhdGgsIHNpemVvZihwYXRo
KSwgIiVzL2Nncm91cC5zdWJ0cmVlX2NvbnRyb2wiLCBjZyk7Cgkodm9pZCl3cml0ZV9maWxl
KHBhdGgsICIrbWVtb3J5Iik7Cn0KCi8qIE1vdmVQaWQgbW92ZXMgYSBwcm9jZXNzIGludG8g
dGhlIHRhcmdldCBjZ3JvdXAuICovCnN0YXRpYyBpbnQgbW92ZV9waWQoY29uc3QgY2hhciAq
Y2csIHBpZF90IHBpZCkKewoJY2hhciBwYXRoWzY0MF07CgljaGFyIHZhbHVlWzMyXTsKCglz
bnByaW50ZihwYXRoLCBzaXplb2YocGF0aCksICIlcy9jZ3JvdXAucHJvY3MiLCBjZyk7Cglz
bnByaW50Zih2YWx1ZSwgc2l6ZW9mKHZhbHVlKSwgIiVkIiwgKGludClwaWQpOwoJcmV0dXJu
IHdyaXRlX2ZpbGUocGF0aCwgdmFsdWUpOwp9CgovKiBSbWRpclJldHJ5IHJlbW92ZXMgYSBj
Z3JvdXAgYWZ0ZXIgY3NzIHRlYXJkb3duIGhhcyBtYWRlIGl0IHJlbW92YWJsZS4gKi8Kc3Rh
dGljIGludCBybWRpcl9yZXRyeShjb25zdCBjaGFyICpwYXRoKQp7Cglmb3IgKGludCBpID0g
MDsgaSA8IDYwMDsgaSsrKSB7CgkJaWYgKCFybWRpcihwYXRoKSkKCQkJcmV0dXJuIDA7CgkJ
aWYgKGVycm5vICE9IEVCVVNZICYmIGVycm5vICE9IEVJTlZBTCkKCQkJcmV0dXJuIC0xOwoJ
CXVzbGVlcCg1MDAwKTsKCX0KCglyZXR1cm4gLTE7Cn0KCi8qIFdhaXRQaGFzZSB3YWl0cyB1
bnRpbCB0aGUgc2hhcmVkIHBoYXNlIHJlYWNoZXMgdGhlIHJlcXVlc3RlZCB2YWx1ZS4gKi8K
c3RhdGljIGJvb2wgd2FpdF9waGFzZShzdHJ1Y3QgcmFjZV9zdGF0ZSAqc3QsIGludCB3YW50
LCBpbnQgdGltZW91dF9tcykKewoJZm9yIChpbnQgaSA9IDA7IGkgPCB0aW1lb3V0X21zOyBp
KyspIHsKCQlpZiAoYXRvbWljX2xvYWQoJnN0LT5waGFzZSkgPj0gd2FudCkKCQkJcmV0dXJu
IHRydWU7CgkJdXNsZWVwKDEwMDApOwoJfQoKCXJldHVybiBmYWxzZTsKfQoKLyogVmljdGlt
TWFpbiBmYXVsdHMgZmlsZS1iYWNrZWQgcGFnZXMgYWZ0ZXIgaXQgaGFzIGJlZW4gbW92ZWQg
aW50byB0aGUgbGVhZi4gKi8Kc3RhdGljIHZvaWQgdmljdGltX21haW4oaW50IHN0YXJ0X2Zk
LCBpbnQgcmVhZHlfZmQsIGNvbnN0IGNoYXIgKnBhdGgsIHNpemVfdCBieXRlcykKewoJY2hh
ciBjaDsKCglpZiAocmVhZChzdGFydF9mZCwgJmNoLCAxKSAhPSAxKQoJCV9leGl0KDEwKTsK
CWNsb3NlKHN0YXJ0X2ZkKTsKCglpbnQgZmQgPSBvcGVuKHBhdGgsIE9fQ1JFQVQgfCBPX1RS
VU5DIHwgT19SRFdSIHwgT19DTE9FWEVDLCAwNjAwKTsKCglpZiAoZmQgPCAwKQoJCV9leGl0
KDExKTsKCWlmIChmdHJ1bmNhdGUoZmQsIChvZmZfdClieXRlcykpCgkJX2V4aXQoMTIpOwoK
CXZvbGF0aWxlIHVpbnQ4X3QgKm1hcHBpbmcgPSBtbWFwKE5VTEwsIGJ5dGVzLCBQUk9UX1JF
QUQgfCBQUk9UX1dSSVRFLAoJCQkJCSBNQVBfU0hBUkVELCBmZCwgMCk7CglpZiAobWFwcGlu
ZyA9PSBNQVBfRkFJTEVEKQoJCV9leGl0KDEzKTsKCWNsb3NlKGZkKTsKCglmb3IgKHNpemVf
dCBvZmYgPSAwOyBvZmYgPCBieXRlczsgb2ZmICs9IFBBR0VfQllURVMpCgkJbWFwcGluZ1tv
ZmZdID0gKHVpbnQ4X3QpKG9mZiA+PiAxMik7CgoJc3NpemVfdCByZWFkeV9yZXQgPSB3cml0
ZShyZWFkeV9mZCwgIlIiLCAxKTsKCgkodm9pZClyZWFkeV9yZXQ7CgljbG9zZShyZWFkeV9m
ZCk7CgoJZm9yICh1aW50OF90IHNlZWQgPSAxOzsgc2VlZCsrKSB7CgkJZm9yIChzaXplX3Qg
b2ZmID0gMDsgb2ZmIDwgYnl0ZXM7IG9mZiArPSBQQUdFX0JZVEVTKQoJCQltYXBwaW5nW29m
Zl0gXj0gc2VlZDsKCX0KfQoKLyogUmVhZExydUluZm8gcGFyc2VzIHRoZSB0YXJnZXQgbWVt
Y2cgc2VjdGlvbiBmcm9tIC9zeXMva2VybmVsL2RlYnVnL2xydV9nZW4uICovCnN0YXRpYyBp
bnQgcmVhZF9scnVfaW5mbyhjb25zdCBjaGFyICpsZWFmX3JlbCwgc3RydWN0IGxydV9pbmZv
ICppbmZvKQp7CglGSUxFICpmaWxlID0gZm9wZW4oTFJVX0dFTl9GSUxFLCAiciIpOwoJY2hh
ciAqbGluZSA9IE5VTEw7CglzaXplX3QgY2FwID0gMDsKCWJvb2wgaW5fdGFyZ2V0ID0gZmFs
c2U7CglpbnQgY3VycmVudCA9IC0xOwoJaW50IHJldCA9IC0xOwoKCWlmICghZmlsZSkKCQly
ZXR1cm4gLTE7CgoJbWVtc2V0KGluZm8sIDAsIHNpemVvZigqaW5mbykpOwoKCXdoaWxlIChn
ZXRsaW5lKCZsaW5lLCAmY2FwLCBmaWxlKSA+IDApIHsKCQl1bnNpZ25lZCBsb25nIGlkOwoJ
CXVuc2lnbmVkIGxvbmcgc2VxOwoJCWNoYXIgcGF0aFsxMDI0XTsKCQlpbnQgbm9kZTsKCgkJ
aWYgKHNzY2FuZihsaW5lLCAiIG1lbWNnICVsdSAlMTAyM3MiLCAmaWQsIHBhdGgpID09IDIp
IHsKCQkJaW5fdGFyZ2V0ID0gIXN0cmNtcChwYXRoLCBsZWFmX3JlbCk7CgkJCWN1cnJlbnQg
PSAtMTsKCQkJaWYgKGluX3RhcmdldCkgewoJCQkJaW5mby0+bWVtY2dfaWQgPSBpZDsKCQkJ
CXJldCA9IDA7CgkJCX0KCQkJY29udGludWU7CgkJfQoKCQlpZiAoIWluX3RhcmdldCkKCQkJ
Y29udGludWU7CgoJCWlmIChzc2NhbmYobGluZSwgIiBub2RlICVkIiwgJm5vZGUpID09IDEp
IHsKCQkJaWYgKGluZm8tPm5yX25vZGVzID49IE1BWF9OT0RFUykKCQkJCWNvbnRpbnVlOwoJ
CQljdXJyZW50ID0gaW5mby0+bnJfbm9kZXMrKzsKCQkJaW5mby0+bm9kZXNbY3VycmVudF0g
PSBub2RlOwoJCQljb250aW51ZTsKCQl9CgoJCWlmIChjdXJyZW50ID49IDAgJiYgc3NjYW5m
KGxpbmUsICIgJWx1IiwgJnNlcSkgPT0gMSAmJgoJCSAgICBzZXEgPiBpbmZvLT5tYXhfc2Vx
W2N1cnJlbnRdKQoJCQlpbmZvLT5tYXhfc2VxW2N1cnJlbnRdID0gc2VxOwoJfQoKCWZyZWUo
bGluZSk7CglmY2xvc2UoZmlsZSk7CglyZXR1cm4gcmV0Owp9CgovKiBBZ2VyVGhyZWFkIHJl
cGVhdGVkbHkgYXNrcyBNR0xSVSBkZWJ1Z2ZzIHRvIGFnZSB0aGUgdGFyZ2V0IG1lbWNnLiAq
LwpzdGF0aWMgdm9pZCAqYWdlcl90aHJlYWQodm9pZCAqYXJnKQp7CglzdHJ1Y3QgcmFjZV9z
dGF0ZSAqc3QgPSBhcmc7CglpbnQgZmQ7CgoJcHJjdGwoUFJfU0VUX05BTUUsICJscnVfYWdl
ciIsIDAsIDAsIDApOwoKCWZkID0gb3BlbihMUlVfR0VOX0ZJTEUsIE9fV1JPTkxZIHwgT19D
TE9FWEVDKTsKCWlmIChmZCA8IDApCgkJcmV0dXJuIE5VTEw7CgoJd2hpbGUgKGF0b21pY19s
b2FkKCZzdC0+cGhhc2UpIDwgUEhBU0VfV0lORE9XKSB7CgkJc3RydWN0IGxydV9pbmZvIGlu
Zm87CgoJCWlmIChyZWFkX2xydV9pbmZvKHN0LT5sZWFmX3JlbCwgJmluZm8pIHx8ICFpbmZv
Lm1lbWNnX2lkKQoJCQlicmVhazsKCgkJZm9yIChpbnQgaSA9IDA7IGkgPCBpbmZvLm5yX25v
ZGVzOyBpKyspIHsKCQkJY2hhciBjbWRbMTI4XTsKCgkJCWlmIChhdG9taWNfbG9hZCgmc3Qt
PnBoYXNlKSA+PSBQSEFTRV9XSU5ET1cpCgkJCQlicmVhazsKCgkJCXNucHJpbnRmKGNtZCwg
c2l6ZW9mKGNtZCksICIrICVsdSAlZCAlbHUgMSAxXG4iLAoJCQkJIGluZm8ubWVtY2dfaWQs
IGluZm8ubm9kZXNbaV0sIGluZm8ubWF4X3NlcVtpXSk7CgkJCXNzaXplX3Qgd3JpdGVfcmV0
ID0gd3JpdGUoZmQsIGNtZCwgc3RybGVuKGNtZCkpOwoKCQkJKHZvaWQpd3JpdGVfcmV0OwoJ
CX0KCX0KCgljbG9zZShmZCk7CglyZXR1cm4gTlVMTDsKfQoKLyogS21zZ1RocmVhZCB3YXRj
aGVzIGZvciB0aGUgaW5zdHJ1bWVudGF0aW9uIGxpbmVzIHVzZWQgZm9yIHN5bmNocm9uaXph
dGlvbi4gKi8Kc3RhdGljIHZvaWQgKmttc2dfdGhyZWFkKHZvaWQgKmFyZykKewoJc3RydWN0
IHJhY2Vfc3RhdGUgKnN0ID0gYXJnOwoJY2hhciBidWZbODE5Ml07CglpbnQgZmQgPSBvcGVu
KCIvZGV2L2ttc2ciLCBPX1JET05MWSB8IE9fTk9OQkxPQ0sgfCBPX0NMT0VYRUMpOwoKCWlm
IChmZCA8IDApCgkJcmV0dXJuIE5VTEw7CgoJbHNlZWsoZmQsIDAsIFNFRUtfRU5EKTsKCgl3
aGlsZSAoYXRvbWljX2xvYWQoJnN0LT5waGFzZSkgPCBQSEFTRV9ET05FKSB7CgkJc3NpemVf
dCBsZW4gPSByZWFkKGZkLCBidWYsIHNpemVvZihidWYpIC0gMSk7CgkJY29uc3QgY2hhciAq
bXNnOwoJCWJvb2wgb3VyczsKCgkJaWYgKGxlbiA8PSAwKSB7CgkJCXVzbGVlcCg1MDApOwoJ
CQljb250aW51ZTsKCQl9CgoJCWJ1ZltsZW5dID0gJ1wwJzsKCQltc2cgPSBzdHJjaHIoYnVm
LCAnOycpOwoJCWlmIChtc2cpCgkJCW1zZysrOwoJCWVsc2UKCQkJbXNnID0gYnVmOwoKCQlv
dXJzID0gc3Ryc3RyKG1zZywgc3QtPmxlYWZfcmVsKSAhPSBOVUxMOwoJCWlmIChvdXJzICYm
IHN0cnN0cihtc2csICJkZWxheV9iZWZvcmVfcmVzZXQiKSkgewoJCQlpbnQgaWRsZSA9IFBI
QVNFX0lETEU7CgoJCQlhdG9taWNfY29tcGFyZV9leGNoYW5nZV9zdHJvbmcoJnN0LT5waGFz
ZSwgJmlkbGUsIFBIQVNFX1dJTkRPVyk7CgkJfQoKCQlpZiAoKG91cnMgJiYgc3Ryc3RyKG1z
ZywgImV4aXRfbm9uemVybyIpKSB8fAoJCSAgICAoYXRvbWljX2xvYWQoJnN0LT5waGFzZSkg
Pj0gUEhBU0VfV0lORE9XICYmCgkJICAgICBzdHJzdHIobXNnLCAiV0FSTklORzogbW0vdm1z
Y2FuLmMiKSkpCgkJCWF0b21pY19zdG9yZSgmc3QtPnBoYXNlLCBQSEFTRV9ET05FKTsKCX0K
CgljbG9zZShmZCk7CglyZXR1cm4gTlVMTDsKfQoKLyogUnVuSXRlcmF0aW9uIGNyZWF0ZXMg
b25lIGNoaWxkIG1lbWNnIGFuZCByYWNlcyBpdHMgdGVhcmRvd24gYWdhaW5zdCBhZ2luZy4g
Ki8Kc3RhdGljIGJvb2wgcnVuX2l0ZXJhdGlvbihjb25zdCBjaGFyICpiYXNlLCBpbnQgaXRl
ciwgc2l6ZV90IGZpbGVfbWliKQp7CglzdHJ1Y3QgcmFjZV9zdGF0ZSBzdDsKCWludCBzdGFy
dF9waXBlWzJdOwoJaW50IHJlYWR5X3BpcGVbMl07CglwdGhyZWFkX3QgYWdlcjsKCXB0aHJl
YWRfdCBrbXNnOwoJYm9vbCBnb3Rfd2luZG93OwoJYm9vbCBjb25maXJtZWQgPSBmYWxzZTsK
CgltZW1zZXQoJnN0LCAwLCBzaXplb2Yoc3QpKTsKCXN0Lml0ZXIgPSBpdGVyOwoJc25wcmlu
dGYoc3QubGVhZiwgc2l6ZW9mKHN0LmxlYWYpLCAiJXMvbGVhZl8lMDNkIiwgYmFzZSwgaXRl
cik7CglzbnByaW50ZihzdC5sZWFmX3JlbCwgc2l6ZW9mKHN0LmxlYWZfcmVsKSwgIiVzL2xl
YWZfJTAzZCIsCgkJIGJhc2UgKyBzdHJsZW4oQ0dST1VQX1JPT1QpLCBpdGVyKTsKCXNucHJp
bnRmKHN0LmZpbGVfcGF0aCwgc2l6ZW9mKHN0LmZpbGVfcGF0aCksICIvcm9vdC9scnVfcmFj
ZV8lZF8lMDNkLmRhdCIsCgkJIGdldHBpZCgpLCBpdGVyKTsKCWF0b21pY19zdG9yZSgmc3Qu
cGhhc2UsIFBIQVNFX0lETEUpOwoKCWlmIChta2Rpcl9pZl9taXNzaW5nKHN0LmxlYWYpKQoJ
CXJldHVybiBmYWxzZTsKCWlmIChwaXBlKHN0YXJ0X3BpcGUpIHx8IHBpcGUocmVhZHlfcGlw
ZSkpCgkJZGllKCJwaXBlIik7CgoJc3QudmljdGltID0gZm9yaygpOwoJaWYgKCFzdC52aWN0
aW0pIHsKCQljbG9zZShzdGFydF9waXBlWzFdKTsKCQljbG9zZShyZWFkeV9waXBlWzBdKTsK
CQl2aWN0aW1fbWFpbihzdGFydF9waXBlWzBdLCByZWFkeV9waXBlWzFdLCBzdC5maWxlX3Bh
dGgsCgkJCSAgICBmaWxlX21pYiA8PCAyMCk7CgkJX2V4aXQoMCk7Cgl9CgoJY2xvc2Uoc3Rh
cnRfcGlwZVswXSk7CgljbG9zZShyZWFkeV9waXBlWzFdKTsKCglpZiAobW92ZV9waWQoc3Qu
bGVhZiwgc3QudmljdGltKSkgewoJCXNzaXplX3Qgc3RhcnRfcmV0ID0gd3JpdGUoc3RhcnRf
cGlwZVsxXSwgImciLCAxKTsKCgkJKHZvaWQpc3RhcnRfcmV0OwoJCWNsb3NlKHN0YXJ0X3Bp
cGVbMV0pOwoJCWtpbGwoc3QudmljdGltLCBTSUdLSUxMKTsKCQl3YWl0cGlkKHN0LnZpY3Rp
bSwgTlVMTCwgMCk7CgkJcm1kaXJfcmV0cnkoc3QubGVhZik7CgkJcmV0dXJuIGZhbHNlOwoJ
fQoKCXNzaXplX3Qgc3RhcnRfcmV0ID0gd3JpdGUoc3RhcnRfcGlwZVsxXSwgImciLCAxKTsK
Cgkodm9pZClzdGFydF9yZXQ7CgljbG9zZShzdGFydF9waXBlWzFdKTsKCgljaGFyIHJlYWR5
OwoJc3NpemVfdCByZWFkeV9yZXQgPSByZWFkKHJlYWR5X3BpcGVbMF0sICZyZWFkeSwgMSk7
CgoJKHZvaWQpcmVhZHlfcmV0OwoJY2xvc2UocmVhZHlfcGlwZVswXSk7CgoJZm9yIChpbnQg
cmV0cnkgPSAwOyByZXRyeSA8IDQwMDsgcmV0cnkrKykgewoJCXN0cnVjdCBscnVfaW5mbyBp
bmZvOwoKCQlpZiAoIXJlYWRfbHJ1X2luZm8oc3QubGVhZl9yZWwsICZpbmZvKSAmJiBpbmZv
Lm1lbWNnX2lkICYmCgkJICAgIGluZm8ubnJfbm9kZXMgPiAwKQoJCQlicmVhazsKCQl1c2xl
ZXAoNTAwMCk7Cgl9CgoJcHRocmVhZF9jcmVhdGUoJmttc2csIE5VTEwsIGttc2dfdGhyZWFk
LCAmc3QpOwoJcHRocmVhZF9jcmVhdGUoJmFnZXIsIE5VTEwsIGFnZXJfdGhyZWFkLCAmc3Qp
OwoKCWdvdF93aW5kb3cgPSB3YWl0X3BoYXNlKCZzdCwgUEhBU0VfV0lORE9XLCBXSU5ET1df
VElNRU9VVF9NUyk7CglpZiAoZ290X3dpbmRvdykgewoJCWtpbGwoc3QudmljdGltLCBTSUdL
SUxMKTsKCQl3YWl0cGlkKHN0LnZpY3RpbSwgTlVMTCwgMCk7CgkJc3QudmljdGltID0gMDsK
CQlybWRpcl9yZXRyeShzdC5sZWFmKTsKCQljb25maXJtZWQgPSB3YWl0X3BoYXNlKCZzdCwg
UEhBU0VfRE9ORSwgQ09ORklSTV9USU1FT1VUX01TKTsKCX0KCglhdG9taWNfc3RvcmUoJnN0
LnBoYXNlLCBQSEFTRV9ET05FKTsKCXB0aHJlYWRfam9pbihhZ2VyLCBOVUxMKTsKCXB0aHJl
YWRfam9pbihrbXNnLCBOVUxMKTsKCglpZiAoc3QudmljdGltKSB7CgkJa2lsbChzdC52aWN0
aW0sIFNJR0tJTEwpOwoJCXdhaXRwaWQoc3QudmljdGltLCBOVUxMLCAwKTsKCX0KCXJtZGly
X3JldHJ5KHN0LmxlYWYpOwoJdW5saW5rKHN0LmZpbGVfcGF0aCk7CgoJcHJpbnRmKCJpdGVy
ICVkOiAlc1xuIiwgaXRlciwgY29uZmlybWVkID8gImNvbmZpcm1lZCIgOgoJICAgICAgIGdv
dF93aW5kb3cgPyAid2luZG93LW9ubHkiIDogIm1pc3MiKTsKCXJldHVybiBjb25maXJtZWQ7
Cn0KCi8qIE1haW4gcHJlcGFyZXMgY2dyb3VwL2RlYnVnZnMgc3RhdGUgYW5kIHJ1bnMgYm91
bmRlZCByYWNlIGF0dGVtcHRzLiAqLwppbnQgbWFpbihpbnQgYXJnYywgY2hhciAqKmFyZ3Yp
CnsKCWludCBpdGVycyA9IGFyZ2MgPiAxID8gYXRvaShhcmd2WzFdKSA6IERFRkFVTFRfSVRF
UlM7CglzaXplX3QgZmlsZV9taWIgPSBhcmdjID4gMiA/IHN0cnRvdWwoYXJndlsyXSwgTlVM
TCwgMCkgOiBERUZBVUxUX0ZJTEVfTUlCOwoJY2hhciBiYXNlWzUxMl07CglpbnQgY29uZmly
bWVkID0gMDsKCglpZiAoZ2V0ZXVpZCgpKSB7CgkJZnByaW50ZihzdGRlcnIsICJtdXN0IHJ1
biBhcyByb290XG4iKTsKCQlyZXR1cm4gMTsKCX0KCglpZiAobW91bnQoImRlYnVnZnMiLCAi
L3N5cy9rZXJuZWwvZGVidWciLCAiZGVidWdmcyIsIDAsIE5VTEwpICYmIGVycm5vICE9IEVC
VVNZKQoJCXBlcnJvcigibW91bnQgZGVidWdmcyIpOwoKCWVuYWJsZV9tZW1vcnlfY29udHJv
bGxlcihDR1JPVVBfUk9PVCk7CglzbnByaW50ZihiYXNlLCBzaXplb2YoYmFzZSksIENHUk9V
UF9ST09UICIvbHJ1X2dlbl9yYWNlXyVkIiwgZ2V0cGlkKCkpOwoJaWYgKG1rZGlyX2lmX21p
c3NpbmcoYmFzZSkpCgkJZGllKCJta2RpciBiYXNlIGNncm91cCIpOwoJZW5hYmxlX21lbW9y
eV9jb250cm9sbGVyKGJhc2UpOwoKCWZvciAoaW50IGkgPSAwOyBpIDwgaXRlcnM7IGkrKykg
ewoJCWlmIChydW5faXRlcmF0aW9uKGJhc2UsIGksIGZpbGVfbWliKSkKCQkJY29uZmlybWVk
Kys7Cgl9CgoJcm1kaXJfcmV0cnkoYmFzZSk7CglwcmludGYoImNvbmZpcm1lZD0lZC8lZFxu
IiwgY29uZmlybWVkLCBpdGVycyk7CglyZXR1cm4gY29uZmlybWVkID8gMCA6IDE7Cn0K
--------------4exgc87OP1BHmbzgeiNkZl3w
Content-Type: text/plain; charset=UTF-8; name="lru_gen_exit_memcg.patch"
Content-Disposition: attachment; filename="lru_gen_exit_memcg.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL21tL3Ztc2Nhbi5jIGIvbW0vdm1zY2FuLmMKaW5kZXggYmQxYjFhYTEy
NTgxLi42MjA2Y2U0MWRlM2IgMTAwNjQ0Ci0tLSBhL21tL3Ztc2Nhbi5jCisrKyBiL21tL3Zt
c2Nhbi5jCkBAIC0zMjY1LDI0ICszMjY1LDk2IEBAIHN0YXRpYyB2b2lkIHVwZGF0ZV9iYXRj
aF9zaXplKHN0cnVjdCBscnVfZ2VuX21tX3dhbGsgKndhbGssIHN0cnVjdCBmb2xpbyAqZm9s
aW8sCiAJd2Fsay0+bnJfcGFnZXNbbmV3X2dlbl1bdHlwZV1bem9uZV0gKz0gZGVsdGE7CiB9
CiAKKy8qIFJldHVybiB3aGV0aGVyIGFueSBNR0xSVSBzaXplIHNsb3QgaXMgc3RpbGwgY2hh
cmdlZC4gKi8KK3N0YXRpYyBib29sIGxydV9nZW5faGFzX25yX3BhZ2VzKHN0cnVjdCBscnV2
ZWMgKmxydXZlYykKK3sKKwlpbnQgZ2VuLCB0eXBlLCB6b25lOworCXN0cnVjdCBscnVfZ2Vu
X2ZvbGlvICpscnVnZW4gPSAmbHJ1dmVjLT5scnVnZW47CisKKwlmb3JfZWFjaF9nZW5fdHlw
ZV96b25lKGdlbiwgdHlwZSwgem9uZSkgeworCQlpZiAoUkVBRF9PTkNFKGxydWdlbi0+bnJf
cGFnZXNbZ2VuXVt0eXBlXVt6b25lXSkpCisJCQlyZXR1cm4gdHJ1ZTsKKwl9CisKKwlyZXR1
cm4gZmFsc2U7Cit9CisKKy8qIER1bXAgbm9uemVybyBNR0xSVSBzaXplIHNsb3RzIGZvciB0
aGUgdGFyZ2V0IG1lbWNnLiAqLworc3RhdGljIHZvaWQgbHJ1X2dlbl9kdW1wX25yX3BhZ2Vz
KGNvbnN0IGNoYXIgKnRhZywgc3RydWN0IG1lbV9jZ3JvdXAgKm1lbWNnLAorCQkJCSAgaW50
IG5pZCwgc3RydWN0IGxydXZlYyAqbHJ1dmVjLCBib29sIHNob3dfcGF0aCkKK3sKKwlpbnQg
Z2VuLCB0eXBlLCB6b25lOworCWNoYXIgcGF0aFsyNTZdID0gIiI7CisJc3RydWN0IGxydV9n
ZW5fZm9saW8gKmxydWdlbiA9ICZscnV2ZWMtPmxydWdlbjsKKworCWlmIChzaG93X3BhdGgg
JiYgbWVtY2cpCisJCWNncm91cF9wYXRoKG1lbWNnLT5jc3MuY2dyb3VwLCBwYXRoLCBzaXpl
b2YocGF0aCkpOworCisJcHJfd2FybigibHJ1X2dlbl9kZWJ1ZzogJXMgdGFzaz0lcy8lZCBt
ZW1jZz0lbGx1IG9ubGluZT0lZCBkeWluZz0lZCBuaWQ9JWQgcGF0aD0lc1xuIiwKKwkJdGFn
LCBjdXJyZW50LT5jb21tLCB0YXNrX3BpZF9ucihjdXJyZW50KSwgbWVtX2Nncm91cF9pZCht
ZW1jZyksCisJCW1lbWNnID8gbWVtX2Nncm91cF9vbmxpbmUobWVtY2cpIDogMSwgbWVtY2df
aXNfZHlpbmcobWVtY2cpLAorCQluaWQsIHBhdGgpOworCisJZm9yX2VhY2hfZ2VuX3R5cGVf
em9uZShnZW4sIHR5cGUsIHpvbmUpIHsKKwkJbG9uZyBucl9wYWdlcyA9IFJFQURfT05DRShs
cnVnZW4tPm5yX3BhZ2VzW2dlbl1bdHlwZV1bem9uZV0pOworCisJCWlmICghbnJfcGFnZXMp
CisJCQljb250aW51ZTsKKworCQlwcl93YXJuKCJscnVfZ2VuX2RlYnVnOiAlcyBzbG90IG1l
bWNnPSVsbHUgbmlkPSVkIGdlbj0lZCB0eXBlPSVkIHpvbmU9JWQgbnI9JWxkIGxpc3RfZW1w
dHk9JWRcbiIsCisJCQl0YWcsIG1lbV9jZ3JvdXBfaWQobWVtY2cpLCBuaWQsIGdlbiwgdHlw
ZSwgem9uZSwKKwkJCW5yX3BhZ2VzLCBsaXN0X2VtcHR5KCZscnVnZW4tPmZvbGlvc1tnZW5d
W3R5cGVdW3pvbmVdKSk7CisJfQorfQorCisvKiBEZWxheSB0aGUgUG9DIGFnaW5nIHRhc2sg
c28gbWVtY2cgb2ZmbGluZSBjYW4gcmFjZSB3aXRoIGJhdGNoIHJlc2V0LiAqLworc3RhdGlj
IHZvaWQgbHJ1X2dlbl9kZWxheV90ZXN0X3Jlc2V0KHN0cnVjdCBscnV2ZWMgKmxydXZlYykK
K3sKKwljaGFyIHBhdGhbMTI4XSA9ICIiOworCXN0cnVjdCBtZW1fY2dyb3VwICptZW1jZyA9
IGxydXZlY19tZW1jZyhscnV2ZWMpOworCisJaWYgKCFtZW1jZyB8fCBzdHJjbXAoY3VycmVu
dC0+Y29tbSwgImxydV9hZ2VyIikpCisJCXJldHVybjsKKworCWNncm91cF9wYXRoKG1lbWNn
LT5jc3MuY2dyb3VwLCBwYXRoLCBzaXplb2YocGF0aCkpOworCWlmICghc3RyX2hhc19wcmVm
aXgocGF0aCwgIi9scnVfZ2VuX3JhY2VfIikpCisJCXJldHVybjsKKworCXByX3dhcm4oImxy
dV9nZW5fZGVidWc6IGRlbGF5X2JlZm9yZV9yZXNldCB0YXNrPSVzLyVkIG1lbWNnPSVsbHUg
b25saW5lPSVkIGR5aW5nPSVkIHBhdGg9JXNcbiIsCisJCWN1cnJlbnQtPmNvbW0sIHRhc2tf
cGlkX25yKGN1cnJlbnQpLCBtZW1fY2dyb3VwX2lkKG1lbWNnKSwKKwkJbWVtX2Nncm91cF9v
bmxpbmUobWVtY2cpLCBtZW1jZ19pc19keWluZyhtZW1jZyksIHBhdGgpOworCW1zbGVlcCgz
MDAwKTsKK30KKwogc3RhdGljIHZvaWQgcmVzZXRfYmF0Y2hfc2l6ZShzdHJ1Y3QgbHJ1X2dl
bl9tbV93YWxrICp3YWxrKQogewogCWludCBnZW4sIHR5cGUsIHpvbmU7CiAJc3RydWN0IGxy
dXZlYyAqbHJ1dmVjID0gd2Fsay0+bHJ1dmVjOwogCXN0cnVjdCBscnVfZ2VuX2ZvbGlvICps
cnVnZW4gPSAmbHJ1dmVjLT5scnVnZW47CisJc3RydWN0IG1lbV9jZ3JvdXAgKm1lbWNnID0g
bHJ1dmVjX21lbWNnKGxydXZlYyk7CisJYm9vbCBvZmZsaW5lID0gbWVtY2cgJiYgKCFtZW1f
Y2dyb3VwX29ubGluZShtZW1jZykgfHwgbWVtY2dfaXNfZHlpbmcobWVtY2cpKTsKKwlib29s
IHplcm9lZCA9IG9mZmxpbmUgJiYgIWxydV9nZW5faGFzX25yX3BhZ2VzKGxydXZlYyk7CiAK
IAl3YWxrLT5iYXRjaGVkID0gMDsKIAogCWZvcl9lYWNoX2dlbl90eXBlX3pvbmUoZ2VuLCB0
eXBlLCB6b25lKSB7CiAJCWVudW0gbHJ1X2xpc3QgbHJ1ID0gdHlwZSAqIExSVV9JTkFDVElW
RV9GSUxFOwogCQlpbnQgZGVsdGEgPSB3YWxrLT5ucl9wYWdlc1tnZW5dW3R5cGVdW3pvbmVd
OworCQlsb25nIG9sZDsKIAogCQlpZiAoIWRlbHRhKQogCQkJY29udGludWU7CiAKIAkJd2Fs
ay0+bnJfcGFnZXNbZ2VuXVt0eXBlXVt6b25lXSA9IDA7Ci0JCVdSSVRFX09OQ0UobHJ1Z2Vu
LT5ucl9wYWdlc1tnZW5dW3R5cGVdW3pvbmVdLAotCQkJICAgbHJ1Z2VuLT5ucl9wYWdlc1tn
ZW5dW3R5cGVdW3pvbmVdICsgZGVsdGEpOworCQlvbGQgPSBSRUFEX09OQ0UobHJ1Z2VuLT5u
cl9wYWdlc1tnZW5dW3R5cGVdW3pvbmVdKTsKKwkJV1JJVEVfT05DRShscnVnZW4tPm5yX3Bh
Z2VzW2dlbl1bdHlwZV1bem9uZV0sIG9sZCArIGRlbHRhKTsKKworCQlpZiAoemVyb2VkKQor
CQkJcHJfd2FybigibHJ1X2dlbl9kZWJ1ZzogcmVzZXRfYmF0Y2hfdG9femVyb2VkX29mZmxp
bmUgdGFzaz0lcy8lZCBtZW1jZz0lbGx1IG9ubGluZT0lZCBkeWluZz0lZCBuaWQ9JWQgc2Vx
PSVsdSBnZW49JWQgdHlwZT0lZCB6b25lPSVkIGRlbHRhPSVkIG9sZD0lbGQgbmV3PSVsZFxu
IiwKKwkJCQljdXJyZW50LT5jb21tLCB0YXNrX3BpZF9ucihjdXJyZW50KSwgbWVtX2Nncm91
cF9pZChtZW1jZyksCisJCQkJbWVtX2Nncm91cF9vbmxpbmUobWVtY2cpLCBtZW1jZ19pc19k
eWluZyhtZW1jZyksCisJCQkJbHJ1dmVjX3BnZGF0KGxydXZlYyktPm5vZGVfaWQsIHdhbGst
PnNlcSwgZ2VuLCB0eXBlLAorCQkJCXpvbmUsIGRlbHRhLCBvbGQsIG9sZCArIGRlbHRhKTsK
IAogCQlpZiAobHJ1X2dlbl9pc19hY3RpdmUobHJ1dmVjLCBnZW4pKQogCQkJbHJ1ICs9IExS
VV9BQ1RJVkU7CkBAIC0zNzgzLDYgKzM4NTUsNyBAQCBzdGF0aWMgdm9pZCB3YWxrX21tKHN0
cnVjdCBtbV9zdHJ1Y3QgKm1tLCBzdHJ1Y3QgbHJ1X2dlbl9tbV93YWxrICp3YWxrKQogCQl9
CiAKIAkJaWYgKHdhbGstPmJhdGNoZWQpIHsKKwkJCWxydV9nZW5fZGVsYXlfdGVzdF9yZXNl
dChscnV2ZWMpOwogCQkJbHJ1dmVjX2xvY2tfaXJxKGxydXZlYyk7CiAJCQlyZXNldF9iYXRj
aF9zaXplKHdhbGspOwogCQkJbHJ1dmVjX3VubG9ja19pcnEobHJ1dmVjKTsKQEAgLTU4NjQs
NiArNTkzNyw5IEBAIHZvaWQgbHJ1X2dlbl9leGl0X21lbWNnKHN0cnVjdCBtZW1fY2dyb3Vw
ICptZW1jZykKIAkJc3RydWN0IGxydXZlYyAqbHJ1dmVjID0gZ2V0X2xydXZlYyhtZW1jZywg
bmlkKTsKIAkJc3RydWN0IGxydV9nZW5fbW1fc3RhdGUgKm1tX3N0YXRlID0gZ2V0X21tX3N0
YXRlKGxydXZlYyk7CiAKKwkJaWYgKGxydV9nZW5faGFzX25yX3BhZ2VzKGxydXZlYykpCisJ
CQlscnVfZ2VuX2R1bXBfbnJfcGFnZXMoImV4aXRfbm9uemVybyIsIG1lbWNnLCBuaWQsIGxy
dXZlYywgdHJ1ZSk7CisKIAkJVk1fV0FSTl9PTl9PTkNFKG1lbWNocl9pbnYobHJ1dmVjLT5s
cnVnZW4ubnJfcGFnZXMsIDAsCiAJCQkJCSAgIHNpemVvZihscnV2ZWMtPmxydWdlbi5ucl9w
YWdlcykpKTsKIAo=
--------------4exgc87OP1BHmbzgeiNkZl3w
Content-Type: application/x-sh; name="run_poc_qemu.sh"
Content-Disposition: attachment; filename="run_poc_qemu.sh"
Content-Transfer-Encoding: 7bit

#!/bin/sh
# Build and run the minimal MGLRU memcg race PoC in QEMU.

set -eu

out_dir="${1:-/tmp/lru_gen_poc_qemu}"
port="${2:-10450}"
iters="${3:-20}"
file_mib="${4:-32}"

script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
src="$script_dir/poc_lru_race.c"
binary="$out_dir/poc_lru_race"

kernel="${KERNEL:-/mnt/data/linux-kasan-lru-instr/arch/x86/boot/bzImage}"
image="${IMAGE:-/home/ubuntu/trixie-image/trixie.img}"
ssh_key="${SSH_KEY:-/home/ubuntu/trixie-image/trixie.id_rsa}"

overlay="$out_dir/overlay.qcow2"
console="$out_dir/console.log"
events="$out_dir/events.txt"
guest_log="$out_dir/guest.log"
pidfile="$out_dir/qemu.pid"

key_pattern="delay_before_reset|reset_batch_to_zeroed_offline|exit_nonzero|WARNING: mm/vmscan.c|Kernel panic"

mkdir -p "$out_dir"
rm -f "$overlay" "$console" "$events" "$guest_log" "$pidfile" "$binary"

gcc -O2 -Wall -Wextra -pthread -o "$binary" "$src"
qemu-img create -f qcow2 -F raw -b "$image" "$overlay" >/dev/null

cleanup()
{
	if [ -f "$pidfile" ]; then
		kill "$(cat "$pidfile")" 2>/dev/null || true
	fi
}
trap cleanup EXIT INT TERM

qemu-system-x86_64 \
	-m 2048 \
	-smp 2 \
	-enable-kvm \
	-cpu host,migratable=off \
	-no-reboot \
	-display none \
	-serial "file:$console" \
	-pidfile "$pidfile" \
	-device virtio-rng-pci \
	-device e1000,netdev=net0 \
	-netdev "user,id=net0,restrict=on,hostfwd=tcp:127.0.0.1:${port}-:22" \
	-hda "$overlay" \
	-kernel "$kernel" \
	-append 'root=/dev/sda console=ttyS0 panic_on_warn=0 numa=fake=2 net.ifnames=0 biosdevname=0 earlyprintk=serial rcupdate.rcu_expedited=1' \
	-daemonize

ssh_opts="-o BatchMode=yes -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o ConnectTimeout=2 -i $ssh_key -p $port"
scp_opts="-o BatchMode=yes -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o ConnectTimeout=2 -i $ssh_key -P $port"

status="boot_timeout"
for _ in $(seq 1 150); do
	if ssh $ssh_opts root@127.0.0.1 'echo ready' 2>/dev/null | grep -q ready; then
		status="ready"
		break
	fi
	sleep 2
done

if [ "$status" = "ready" ]; then
	scp -q -O $scp_opts "$binary" root@127.0.0.1:/root/poc_lru_race

	timeout_sec=$((iters * 120 + 60))
	ssh $ssh_opts root@127.0.0.1 \
		"chmod +x /root/poc_lru_race; timeout $timeout_sec /root/poc_lru_race $iters $file_mib" \
		>"$guest_log" 2>&1 &
	guest_pid=$!

	status="repro_timeout"
	for _ in $(seq 1 $((timeout_sec + 30))); do
		if grep -Eq 'WARNING: mm/vmscan.c|Kernel panic|exit_nonzero' "$console" 2>/dev/null; then
			status="repro_triggered"
			break
		fi
		if ! kill -0 "$guest_pid" 2>/dev/null; then
			if wait "$guest_pid"; then
				status="guest_done"
			else
				status="guest_failed"
			fi
			break
		fi
		sleep 1
	done

	if kill -0 "$guest_pid" 2>/dev/null; then
		kill "$guest_pid" 2>/dev/null || true
		wait "$guest_pid" 2>/dev/null || true
	fi
fi

grep -En "$key_pattern" "$console" >"$events" 2>/dev/null || true

printf 'status=%s\nconsole=%s\nevents=%s\nguest_log=%s\n' \
	"$status" "$console" "$events" "$guest_log"
printf '%s\n' '--- guest log ---'
tail -40 "$guest_log" 2>/dev/null || true
printf '%s\n' '--- kernel events ---'
cat "$events" 2>/dev/null || true

[ "$status" = "repro_triggered" ]



--------------4exgc87OP1BHmbzgeiNkZl3w--

