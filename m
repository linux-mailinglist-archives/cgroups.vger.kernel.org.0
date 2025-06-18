Return-Path: <cgroups+bounces-8598-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6248ADF97C
	for <lists+cgroups@lfdr.de>; Thu, 19 Jun 2025 00:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B9721BC2E12
	for <lists+cgroups@lfdr.de>; Wed, 18 Jun 2025 22:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEFA427FB0E;
	Wed, 18 Jun 2025 22:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Nyx18AFE"
X-Original-To: cgroups@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA9627E053
	for <cgroups@vger.kernel.org>; Wed, 18 Jun 2025 22:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750286249; cv=none; b=jC2Lphic35+vNnpGblFYCRU103VBm3bJk74Lf1bPuQs2exXnCDaElJhStLy7cupjLG9qiBRMfAsYECQRbGQnU/uwKALps+2dWb4QR3KP6myzKmUgvN5MEOaQD4KYNwscM8t78Ca6W+jpEGqKW26eKEKw2QdMxkqF2y6wWynZJ0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750286249; c=relaxed/simple;
	bh=cIQoaZzK4DrOu/It0eXnzWZyLFiasX7S4zFw4wh1Qz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q9bLZjkgMsNLakD2fAea6dNx52SDaDvn5uiqbZlhtowHGlUZb5j0Tb4Ibk9G4o7ieE6hI4nS8Zfi1/25rGc1o9cwInLUOIN7FnMPrD92czlxJ4CV/dt12nJzSTv5/ohLrrHM6j/I8GU8iSHlM63TUIb7J+GhCN9SWJtmCm+NfQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Nyx18AFE; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 18 Jun 2025 15:37:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750286245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0PV4oFt202O2fPTh0r932mq+HQZlxfrd2y3tMHFlmp0=;
	b=Nyx18AFEfxQ633x19fQ6CdrijvFdGWCUfpL7tar+uZvlET7h68Vq9RLFpgM7d6CHfSZ3R9
	t0xUrZoT1TNiktdFmOHJQdOmJ0cko/X1O04S207bIJju9L+998Wh0sGWF9y2mBj+vgAtVe
	Y7o1nWwRjM6TirkNS/l2/Clfv7VoNLg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Zhongkun He <hezhongkun.hzk@bytedance.com>
Cc: akpm@linux-foundation.org, tytso@mit.edu, jack@suse.com, 
	hannes@cmpxchg.org, mhocko@kernel.org, muchun.song@linux.dev, 
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	cgroups@vger.kernel.org
Subject: Re: [PATCH 0/2] Postpone memcg reclaim to return-to-user path
Message-ID: <a57jjrtddjc4wjbrrjpyhfdx475zwpuetmkibeorboo7csc7aw@foqsmf5ipr73>
References: <cover.1750234270.git.hezhongkun.hzk@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1750234270.git.hezhongkun.hzk@bytedance.com>
X-Migadu-Flow: FLOW_OUT

Hi Zhongkun,

Thanks for a very detailed and awesome description of the problem. This
is a real issue and we at Meta face similar scenarios as well. However I
would not go for PF_MEMALLOC_ACFORCE approach as it is easy to abuse and
is very manual and requires detecting the code which can cause such
scenarios and then case-by-case opting them in. I would prefer a dynamic
or automated approach where the kernel detects such an issue is
happening and recover from it. Though a case can be made where we avoid
such scenarios from happening but that might not be possible everytime.

Also this is very memcg specific, I can clearly see the same scenario
can happen for global reclaim as well.

I have a couple of questions below:

On Wed, Jun 18, 2025 at 07:39:56PM +0800, Zhongkun He wrote:
> # Introduction
> 
> This patchset aims to introduce an approach to ensure that memory
> allocations are forced to be accounted to the memory cgroup, even if
> they exceed the cgroup's maximum limit. In such cases, the reclaim
> process is postponed until the task returns to the user.

This breaks memory.max semantics. Any reason memory.high is not used
here. Basically instead of memory.max, use memory.high as job limit. I
would like to know how memory.high is lacking for your use-case. Maybe
we can fix that or introduce a new form of limit. However this is memcg
specific and will not resolve the global reclaim case.

> This is
> beneficial for users who perform over-max reclaim while holding multiple
> locks or other resources (especially resources related to file system
> writeback). If a task needs any of these resources, it would otherwise
> have to wait until the other task completes reclaim and releases the
> resources. Postponing reclaim to the return-to-user path helps avoid this issue.
> 
> # Background
> 
> We have been encountering an hungtask issue for a long time. Specifically,
> when a task holds the jbd2 handler 

Can you explain a bit more about jbd2 handler? Is it some global shared
lock or a workqueue which can only run single thread at a time.
Basically is there a way to get the current holder/owner of jbd2 handler
programmatically?

> and subsequently enters direct reclaim
> because it reaches the hard limit within a memory cgroup, the system may become
> blocked for a long time. The stack trace of waiting thread holding the jbd2
> handle is as follows (and so many other threads are waiting on the same jbd2
> handle):
> 
>  #0 __schedule at ffffffff97abc6c9
>  #1 preempt_schedule_common at ffffffff97abcdaa
>  #2 __cond_resched at ffffffff97abcddd
>  #3 shrink_active_list at ffffffff9744dca2
>  #4 shrink_lruvec at ffffffff97451407
>  #5 shrink_node at ffffffff974517c9
>  #6 do_try_to_free_pages at ffffffff97451dae
>  #7 try_to_free_mem_cgroup_pages at ffffffff974542b8
>  #8 try_charge_memcg at ffffffff974f0ede
>  #9 charge_memcg at ffffffff974f1d0e
> #10 __mem_cgroup_charge at ffffffff974f391c
> #11 __add_to_page_cache_locked at ffffffff974313e5
> #12 add_to_page_cache_lru at ffffffff974324b2
> #13 pagecache_get_page at ffffffff974338e3
> #14 __getblk_gfp at ffffffff97556798
> #15 __ext4_get_inode_loc at ffffffffc07a5518 [ext4]
> #16 ext4_get_inode_loc at ffffffffc07a7fec [ext4]
> #17 ext4_reserve_inode_write at ffffffffc07a9fb1 [ext4]
> #18 __ext4_mark_inode_dirty at ffffffffc07aa249 [ext4]
> #19 __ext4_new_inode at ffffffffc079cbae [ext4]
> #20 ext4_create at ffffffffc07c3e56 [ext4]
> #21 path_openat at ffffffff9751f471
> #22 do_filp_open at ffffffff97521384
> #23 do_sys_openat2 at ffffffff97508fd6
> #24 do_sys_open at ffffffff9750a65b
> #25 do_syscall_64 at ffffffff97aaed14
> 
> We've obtained a coredump and dumped struct scan_control from it by using crash tool.
> 
> struct scan_control {
>   nr_to_reclaim = 32,
>   order = 0 '\000',
>   priority = 1 '\001',
>   reclaim_idx = 4 '\004',
>   gfp_mask = 17861706, __GFP_NOFAIL
>   nr_scanned = 27810, 
>   nr_reclaimed = 0,
>   nr = {
>         dirty = 27797,
>         unqueued_dirty = 27797,
>         congested = 0,
>         writeback = 0,
>         immediate = 0,
>         file_taken = 27810,
>         taken = 27810
>   },
> }
> 

What is the kernel version? Can you run scripts/gfp-translate on the
gfp_mask above? Does this kernel have a75ffa26122b ("memcg, oom: do not
bypass oom killer for dying tasks")?

> The ->nr_reclaimed is zero meaning there is no memory we have reclaimed because
> most of the file pages are unqueued dirty. And ->priority is 1 also meaning we
> spent so much time on memory reclamation.

Is there a way to get how many times this thread has looped within
try_charge_memcg()?

> Since this thread has held the jbd2
> handler, the jbd2 thread was waiting for the same jbd2 handler, which blocked
> so many other threads from writing dirty pages as well.
> 
> 0 [] __schedule at ffffffff97abc6c9
> 1 [] schedule at ffffffff97abcd01
> 2 [] jbd2_journal_wait_updates at ffffffffc05a522f [jbd2]
> 3 [] jbd2_journal_commit_transaction at ffffffffc05a72c6 [jbd2]
> 4 [] kjournald2 at ffffffffc05ad66d [jbd2]
> 5 [] kthread at ffffffff972bc4c0
> 6 [] ret_from_fork at ffffffff9720440f
> 
> Furthermore, we observed that memory usage far exceeded the configured memory maximum,
> reaching around 38GB.
> 
> memory.max  : 134896020    514 GB
> memory.usage: 144747169    552 GB

This is unexpected and most probably our hacks to allow overcharge to
avoid similar situations are causing this. 

> 
> We investigated this issue and identified the root cause:
>   try_charge_memcg:
>     retry charge
>      charge failed
>        -> direct reclaim
>         -> mem_cgroup_oom    return true，but selected task is in an uninterruptible state
>            -> retry charge

Oh oom reaper didn't help?

> 
> In which cases, we saw many tasks in the uninterruptible (D) state with a pending
> SIGKILL signal. The OOM killer selects a victim and returns success, allowing the
> current thread to retry the memory charge. However, the selected task cannot acknowledge
> the SIGKILL signal because it is stuck in an uninterruptible state.

OOM reaper usually helps in such cases but I see below why it didn't
help.

> As a result,
> the charging task resets nr_retries and attempts to reclaim again, but the victim
> task never exits. This causes the current thread to enter a prolonged retry loop
> during direct reclaim, holding the jbd2 handler for much more time and leading to
> system-wide blocking. Why are there so many uninterruptible (D) state tasks?
> Check the most common stack trace.
> 
> crash> task_struct.__state ffff8c53a15b3080
>   __state = 2,   #define TASK_UNINTERRUPTIBLE        0x0002
>  0 [] __schedule at ffffffff97abc6c9
>  1 [] schedule at ffffffff97abcd01
>  2 [] schedule_preempt_disabled at ffffffff97abdf1a
>  3 [] rwsem_down_read_slowpath at ffffffff97ac05bf
>  4 [] down_read at ffffffff97ac06b1
>  5 [] do_user_addr_fault at ffffffff9727f1e7
>  6 [] exc_page_fault at ffffffff97ab286e
>  7 [] asm_exc_page_fault at ffffffff97c00d42
> 
> Check the owner of mm_struct.mmap_lock. The task below was entering memory reclaim
> holding mmap lock and there are 68 tasks in this memory cgroup, with 23 of them in
> the memory reclaim context.
> 

The following thread has mmap_lock in write mode and thus oom-reaper is
not helping. Do you see "oom_reaper: unable to reap pid..." messages in
dmesg?

>  7 [] shrink_active_list at ffffffff9744dd46
>  8 [] shrink_lruvec at ffffffff97451407
>  9 [] shrink_node at ffffffff974517c9
> 10 [] do_try_to_free_pages at ffffffff97451dae
> 11 [] try_to_free_mem_cgroup_pages at ffffffff974542b8
> 12 [] try_charge_memcg at ffffffff974f0ede
> 13 [] obj_cgroup_charge_pages at ffffffff974f1dae
> 14 [] obj_cgroup_charge at ffffffff974f2fc2
> 15 [] kmem_cache_alloc at ffffffff974d054c
> 16 [] vm_area_dup at ffffffff972923f1
> 17 [] __split_vma at ffffffff97486c16
> 18 [] __do_munmap at ffffffff97486e78
> 19 [] __vm_munmap at ffffffff97487307
> 20 [] __x64_sys_munmap at ffffffff974873e7
> 21 [] do_syscall_64 at ffffffff97aaed14
> 
> Many threads was entering the memory reclaim in UN state, other threads was blocking
> on mmap_lock. Although the OOM killer selects a victim, it cannot terminate it.

Can you please confirm the above? Is the kernel able to oom-kill more
processes or if it is returning early because the current thread is
dying. However if the cgroup has just one big process, this doesn't
matter.

> The
> task holding the jbd2 handle retries memory charge, but it fails. Reclaiming continues
> while holding the jbd2 handler. write_pages also fails while waiting for the same jbd2
> handler, causing repeated shrink failures and potentially leading to a system-wide block.
> 
> ps | grep UN | wc -l
> 1463
> 
> While the system has 1463 UN state tasks, so the way to break this akin to "deadlock" is
> to let the thread holding jbd2 handler quickly exit the memory reclamation process.
> 
> We found that a related issue was reported and partially fixed in previous patches [1][2].
> However, those fixes only skip direct reclamation and return a failure for some cases such
> as readahead requests. As sb_getblk() is called multiple times in __ext4_get_inode_loc()
> with the NOFAIL flag, the problem still exists. And it is not feasible to simply remove
> __GFP_RECLAIMABLE when holding jbd2 handle to avoid potential very long memory reclaim
> latency,  as __GFP_NOFAIL is not supported without __GFP_DIRECT_RECLAIM.
> 
> # Fundamentals
> 
> This patchset introduces a new task flag of PF_MEMALLOC_ACFORCE to indicate that memory
> allocations are forced to be accounted to the memory cgroup, even if they exceed the cgroup's
> maximum limit. The reclaim process is deferred until the task returns to the user without
> holding any kernel resources for memory reclamation, thereby preventing priority inversion
> problems. Any users who might encounter potential similar issues can utilize this new flag
> to allocate memory and prevent long-term latency for the entire system.

I already explained upfront why this is not the approach we want.

We do see similar situations/scenarios but due to global/shared locks in
btrfs but I expect any global lock or global shared resource can cause
such priority inversion situations.

