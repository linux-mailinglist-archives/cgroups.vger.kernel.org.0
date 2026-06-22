Return-Path: <cgroups+bounces-17116-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sdqLL1WoOGoYfQcAu9opvQ
	(envelope-from <cgroups+bounces-17116-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 22 Jun 2026 05:13:25 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA356AC45F
	for <lists+cgroups@lfdr.de>; Mon, 22 Jun 2026 05:13:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b="b/JPhVoR";
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17116-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="cgroups+bounces-17116-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B55A83011054
	for <lists+cgroups@lfdr.de>; Mon, 22 Jun 2026 03:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D78531F9A8;
	Mon, 22 Jun 2026 03:13:12 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DF513AF2
	for <cgroups@vger.kernel.org>; Mon, 22 Jun 2026 03:13:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782097992; cv=none; b=G4VA4b4D7enSPPd7Oz3tFUO1CogJbSFLZ4dtnfWSG6Qq3eaBIh2rqMbwIEqkNlDOG/xE5FJ/zuXLJCBrWT2tCRcit8hxOXzgNOFjcAM8iSFNRpDffZPchihaUMm5bRN4UbWn5hCNXPv7N44v2zmYJybjROf3+cMbvG1puCPTtkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782097992; c=relaxed/simple;
	bh=heprJgYjOZIimL4Lxu76yL2VZ/dESysA1lfHbXrc0NI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cQXtJqhHmYhO0FxvmQEKOKhMq77suh36FENwEpiEgpSyhJGy1jhD/Pz9myGl5Il2tcRrc9JxAUu1Ar2g/8oZF096hh+8QTRTmU4D3NZ66ZzgS2ebQ1OUOcH7x0u5QbGJEXbWQ4rCN63mAFGdCY17OOTTI8kiloPxezfD+4+s55w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=b/JPhVoR; arc=none smtp.client-ip=95.215.58.170
Message-ID: <6af11da2-affa-414c-8426-168224cd2f69@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782097977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EVDknkMPYHwtjP5EdM2HdKpVYJO996AavSVHwEl4Jgg=;
	b=b/JPhVoR4HIOdlvHluL12MOhVou49Gn84LSlMtzYCuWS6+mTapMbpQ1g++sabTlfvQkoXd
	Ez/c5VWCYsFwb34UBuCG1yZOZeOZZ7I01V9fsdduYPIynB9CSkwYENorv7+cSS4yNJ8CbI
	z6JsLHAjdHKBihRw+2XcrSFUGSetBbc=
Date: Mon, 22 Jun 2026 11:12:34 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [BUG] mm: mglru: stale aging batch triggers lru_gen_exit_memcg
 warning
To: Peiyang He <peiyang_he@smail.nju.edu.cn>, akpm@linux-foundation.org,
 hannes@cmpxchg.org, linux-mm@kvack.org
Cc: mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
 muchun.song@linux.dev, kasong@tencent.com, baohua@kernel.org,
 axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
 david@kernel.org, ljs@kernel.org, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzkaller@googlegroups.com
References: <5A9E929D82717101+12fcf643-efb8-4b9a-a53a-1e28cc894f0b@smail.nju.edu.cn>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <5A9E929D82717101+12fcf643-efb8-4b9a-a53a-1e28cc894f0b@smail.nju.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:peiyang_he@smail.nju.edu.cn,m:akpm@linux-foundation.org,m:hannes@cmpxchg.org,m:linux-mm@kvack.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:kasong@tencent.com,m:baohua@kernel.org,m:axelrasmussen@google.com,m:yuanchu@google.com,m:weixugc@google.com,m:david@kernel.org,m:ljs@kernel.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:syzkaller@googlegroups.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[qi.zheng@linux.dev,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-17116-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qi.zheng@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,linux.dev:dkim,linux.dev:mid,linux.dev:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2EA356AC45F

Hi Peiyang,

Thanks for reporting this issue!

On 6/21/26 9:50 PM, Peiyang He wrote:
> Hello,
> 
> I hit the following warning while fuzzing other kernel code with Syzkaller.
> 
> The original Syzkaller report:
> 
> WARNING: mm/vmscan.c:5867 at lru_gen_exit_memcg+0x26f/0x300 mm/ 
> vmscan.c:5867, CPU#0: kworker/0:0/9
> Modules linked in:
> CPU: 0 UID: 0 PID: 9 Comm: kworker/0:0 Not tainted 7.1.0 #2 PREEMPT(full)
> Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 
> 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> Workqueue: cgroup_free css_free_rwork_fn
> RIP: 0010:lru_gen_exit_memcg+0x26f/0x300 mm/vmscan.c:5867
> Code: 89 de e8 d4 62 ba ff 49 83 fd 3f 0f 86 9c fe ff ff 48 83 c4 08 5b 
> 5d 41 5c 41 5d 41 5e 41 5f e9 17 68 ba ff e8 12 68 ba ff 90 <0f> 0b 90 
> e9 b0 fe ff ff e8 04 68 ba ff 66 90 e8 fd 67 ba ff 90 0f
> RSP: 0018:ffffc900001afb78 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff82049e88
> RDX: ffff888016f35c40 RSI: ffffffff8204a02e RDI: ffff88801d4103b8
> RBP: dffffc0000000000 R08: 0000000000000005 R09: 0000000000000040
> R10: 0000000000000000 R11: 0000000000002ba4 R12: ffff8880481f1600
> R13: ffff88801d410650 R14: ffff88801d410040 R15: dead000000000100
> FS:  0000000000000000(0000) GS:ffff888098d91000(0000) 
> knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000055ac6490c1d8 CR3: 00000000249b0000 CR4: 0000000000350ef0
> Call Trace:
>   <TASK>
>   mem_cgroup_free mm/memcontrol.c:3972 [inline]
>   mem_cgroup_css_free+0x76/0xb0 mm/memcontrol.c:4241
>   css_free_rwork_fn+0x125/0x1260 kernel/cgroup/cgroup.c:5575
>   process_one_work+0xa0d/0x1c30 kernel/workqueue.c:3314
>   process_scheduled_works kernel/workqueue.c:3397 [inline]
>   worker_thread+0x645/0xe80 kernel/workqueue.c:3478
>   kthread+0x367/0x480 kernel/kthread.c:436
>   ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
>   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>   </TASK>
> 
> Kernel version: commit 8cd9520d35a6c38db6567e97dd93b1f11f185dc6 (tag v7.1)
> 
> Relevant kernel config:
> 
>    CONFIG_MEMCG=y
>    CONFIG_LRU_GEN=y
>    CONFIG_LRU_GEN_ENABLED=y
>    CONFIG_LRU_GEN_WALKS_MMU=y
>    CONFIG_NUMA=y
> 
> Root Cause:
> 
> The bug is a race between two code paths that each hold `lruvec- 
>  >lru_lock`, but at
> non-overlapping times.
> 
> Component 1 - `reset_batch_size()`:
> 
> During `walk_mm()`, `update_batch_size()` accumulates per-generation 
> page deltas into
> `walk->nr_pages` WITHOUT holding `lruvec_lock`.  After 
> `mmap_read_unlock(mm)`, the
> walker reacquires `lruvec_lock` and `reset_batch_size()` writes those 
> deltas
> UNCONDITIONALLY into `lrugen->nr_pages`.
> 
> Component 2 - `lru_gen_reparent_memcg()`:
> 
> When a memcg is offlined, `lru_gen_reparent_memcg()` moves all folios to 
> the parent
> lruvec and zeros the child's `lrugen->nr_pages`, all under `lruvec_lock`.
> 
> I have not bisected the issue.  Based on code inspection, the important 
> interaction
> appears to be the reparenting path that clears the child's `nr_pages` while
> `reset_batch_size()` can still commit a batch that was generated before 
> the memcg
> went offline.  This looks related to f304652609ea ("mm: vmscan: prepare for
> reparenting MGLRU folios").
> 
> Race sequence:
> 
>      1. The aging path enters walk_mm() for the child memcg lruvec.
> 
>      2. walk_page_range() scans PTEs and update_batch_size() stores 
> deltas in
>         walk->nr_pages.  At this point the deltas have not been 
> committed to
>         lruvec->lrugen.nr_pages yet.
> 
>      3. walk_mm() drops mmap_read_lock(mm).  Before it reaches
>         reset_batch_size(), the child memcg is killed and removed.
> 
>      4. The memcg offline path runs lru_gen_reparent_memcg().  Under
>         lruvec_lock, it moves the child folios to the parent and clears the
>         child's lrugen.nr_pages.
> 
>      5. The old aging walk resumes, takes lruvec_lock, and 
> reset_batch_size()
>         writes the stale walk->nr_pages deltas back into the original child
>         lruvec.
> 
>      6. Later, lru_gen_exit_memcg(child) checks the child's 
> lrugen.nr_pages with
>         memchr_inv(...).  Since the stale batch made some slots non-zero 
> again,
>         VM_WARN_ON_ONCE() triggers.

It seems this race can actually happen.

> 
> The two critical sections are serialized by `lruvec_lock`, but the batch 
> accumulation
> in `walk->nr_pages` happens outside that lock, so there is no ordering 
> between the
> accumulation and the reparenting zeroing.
> 
> The relevant code path:
> 
>    mm/vmscan.c:
>      run_cmd('+')              selects the target memcg and child lruvec
>      try_to_inc_max_seq()      stores the child lruvec in walk->lruvec
>      update_batch_size()       accumulates deltas in walk->nr_pages
>      walk_mm()                 calls walk_page_range(), then later 
> reset_batch_size()
>      reset_batch_size()        writes cached deltas into walk->lruvec- 
>  >lrugen.nr_pages
>      lru_gen_reparent_memcg()  reparents child MGLRU state and clears 
> child nr_pages
>      lru_gen_exit_memcg()      warns if the exiting memcg has non-zero 
> nr_pages
> 
>    mm/memcontrol.c:
>      mem_cgroup_css_offline()  calls memcg_reparent_objcgs() and 
> lru_gen_offline_memcg()
>      mem_cgroup_free()         calls lru_gen_exit_memcg()
> 
> Reproducer:
> 
> The C reproducer and the helper script for running it are provided in 
> the attachments.
> 
> The PoC creates a leaf memory cgroup, moves a victim process into it, 
> and makes the victim fault and continuously touch file-backed pages so 
> MGLRU aging can produce cached generation deltas for that memcg. A 
> separate `lru_ager` thread repeatedly writes aging commands to `/sys/ 
> kernel/debug/lru_gen`; when the instrumentation reports that the ager is 
> delayed just before `reset_batch_size()`, the PoC kills the victim and 
> removes the leaf cgroup, forcing memcg offline/reparenting before the 
> stale batch is committed.
> 
> The helper script builds the PoC, creates a temporary qcow2 overlay, 
> boots the instrumented kernel in QEMU with fake NUMA and SSH port 
> forwarding, copies the PoC into the guest, runs it, and scans the serial 
> console for `exit_nonzero`, `WARNING: mm/vmscan.c`, or `Kernel panic`. 
> It writes the full serial console, extracted kernel events, and guest 
> stdout/stderr under the chosen output directory.
> 
> The example command:
> 
>    ./repros/lru_gen_exit_memcg/run_poc_qemu.sh /tmp/lru_gen_poc_manual 
> 10450 20 32
> 
> The arguments are:
> 
>    /tmp/lru_gen_poc_manual  output directory for the overlay, console log,
>                             extracted events and guest log
>    10450                    host TCP port forwarded to guest SSH
>    20                       number of PoC iterations to run
>    32                       file-backed working-set size in MiB per 
> iteration
> 
> The script uses default `KERNEL`, `IMAGE` and `SSH_KEY` paths, or they 
> can be
> overridden with environment variables.
> 
> Since this bug requires a specific race window, kernel instrumentation 
> is needed
> to enlarge the race window in order to reproduce the bug more reliably.  
> The
> instrumentation patch is also included in the attachments.
> 
> The patch only instruments `mm/vmscan.c`: it delays the PoC aging task just
> before `reset_batch_size()`, logs when a stale batch is written into an 
> already
> offlined and zeroed memcg lruvec, and dumps the non-zero 
> `lrugen.nr_pages` slots
> before `lru_gen_exit_memcg()` triggers the warning.
> 
> A successful run reports `status=repro_triggered`, and the extracted events
> include a warning like:
> 
>    WARNING: mm/vmscan.c:5943 at lru_gen_exit_memcg+0x420/0x520
> 
> Proposed Fix:
> 
> One possible fix direction is to make `reset_batch_size()` skip writing 
> back the
> stale delta when the memcg is no longer online. `reset_batch_size()` is 
> called
> under `lruvec_lock`, the same lock that `lru_gen_reparent_memcg()` holds 
> when it
> zeroes `nr_pages`, so this should avoid committing a batch after 
> reparenting has
> completed.
> 
> Possible fix direction, not a tested patch:
> 
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -... reset_batch_size() ...
>   static void reset_batch_size(struct lru_gen_mm_walk *walk)
>   {
>       int gen, type, zone;
>       struct lruvec *lruvec = walk->lruvec;
>       struct lru_gen_folio *lrugen = &lruvec->lrugen;
> +    struct mem_cgroup *memcg = lruvec_memcg(lruvec);
> 
>       walk->batched = 0;
> 
>       for_each_gen_type_zone(gen, type, zone) {
>           enum lru_list lru = type * LRU_INACTIVE_FILE;
>           int delta = walk->nr_pages[gen][type][zone];
> 
>           if (!delta)
>               continue;
> 
>           walk->nr_pages[gen][type][zone] = 0;
> +
> +        /*
> +         * If the memcg went offline while we were walking page tables,
> +         * lru_gen_reparent_memcg() has already zeroed nr_pages and moved
> +         * all folios to the parent.  Writing our stale batch delta back
> +         * would corrupt the offline child and trigger WARN_ON in
> +         * lru_gen_exit_memcg().  Discard the delta; the parent lruvec
> +         * already owns the pages and accounts for them correctly.
> +         */
> +        if (memcg && !mem_cgroup_online(memcg))
> +            continue;

This check is insufficient, because offline_css() clears the CSS_ONLINE
after ss->css_offline(css). And we can not simple drop the delta.

Thanks,
Qi

> +
>           WRITE_ONCE(lrugen->nr_pages[gen][type][zone],
>                  lrugen->nr_pages[gen][type][zone] + delta);
> 
>           if (lru_gen_is_active(lruvec, gen))
>               lru += LRU_ACTIVE;
>           __update_lru_size(lruvec, lru, zone, delta);
>       }
>   }
> 
> Thanks


