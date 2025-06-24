Return-Path: <cgroups+bounces-8626-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21925AE5E48
	for <lists+cgroups@lfdr.de>; Tue, 24 Jun 2025 09:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96D383A66E0
	for <lists+cgroups@lfdr.de>; Tue, 24 Jun 2025 07:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74342571A1;
	Tue, 24 Jun 2025 07:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="VEj+Yyi/"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CC12522A2
	for <cgroups@vger.kernel.org>; Tue, 24 Jun 2025 07:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750751097; cv=none; b=jDO3gbfYAepTTBXtTovpQZHQ2vI3CKNlSDSa5pQHgWTkDNhhNkMmm8Z0o6khCkv4AHH8FpXOoqgiWJstDliCoZ6dkyeLERBS/6YHUuF+I+kJqfSTkyWdSiwELS964wXSoa1M3oFnDIqK40JJtSsBm6IiqAqdRIy4NO4ghzLbDgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750751097; c=relaxed/simple;
	bh=2Gos8N7U7eI6lMS55grsNeC/vu4aARhZvYGC5YE7scM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qfwR6f21JExRUODwy0iF4SnC1jWFoP5ug/s2MvkXxcA0jAM/W/btuMIICbWQNGh1m9C+5ZFvczML6qEUbt1gKT+nbs8pOvpDKlW6mZoIPiR2K2D94qGh60fdZ5ZoGRrTFbGlFQ3sNLPsPkZhbOhImebyDQkarHxmY9mRzwIYUm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=VEj+Yyi/; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-553b165c80cso109526e87.2
        for <cgroups@vger.kernel.org>; Tue, 24 Jun 2025 00:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1750751093; x=1751355893; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NQ2zvUmTF85vAASXhu7tdr9oFH3zCkNUtz3N25jGoPw=;
        b=VEj+Yyi/QnPsO8IlnpjcFsOMyCknglTJeUrcwKE3SRu7GONYXgZWnMB75fOmRvxfQA
         kKbj6JsshfjhyiIKLS/iWUG+Gzs4DOfn3Wk7LPynSmRlQGt8fjWIEApXkL/e1JRTvKhy
         nGA5xkCmhzP+sKj5mZFt+fD4jNko7a24K07NUwe+CPJuGnkLHMf6nmWb/j0gZkdAwQyA
         fQCSkqsV3zkUmzQ3eVopNP0t7FSrVvqinONQsrPcaf//XbJIqJKE49YZp28hkIanNJlC
         5N7OaXVn/WahNS2TQST9uvVU4m7qKVp4Ka1bkg+UD49byw5KZdR5P5W1WebCXbB54Z2/
         7zeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750751093; x=1751355893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NQ2zvUmTF85vAASXhu7tdr9oFH3zCkNUtz3N25jGoPw=;
        b=ODBpfUa3wRgJ4U1EJ+RCvK2RUANzFWTq51Wciza4Kqm8L4C4qiRDYf/XrEi922wk80
         gGd7TsHdnSjDgr4WCvFT4TVyLU/wdItgQgRzIOHT/14lqniB29aulYO8/z+AXDb/rn3Z
         1fCeRev8t4gaszw4RmxQ6+5OS6xFDKE9BPorZCwVREWp7PBdM154182paT/PxUj5jVCZ
         +xd/J3imcL8hRPCrFG4VpFAla1sC4XE5FV5VebnECg8B5Vuhexpq1L4AA/h2MZ/0X6CK
         q4BrW37D8biQifZADWx0gxJyzmxTsFJSJvYzb8JQlx14jshUamsxwsX6r1xug8vf+awy
         bwkA==
X-Forwarded-Encrypted: i=1; AJvYcCWlySRUQtav0mXsfOq/dNcHrQgBQz9u86+atn4SRvrsrteEM0yO/pLTMviB+PK2F5E5m4VLXYcf@vger.kernel.org
X-Gm-Message-State: AOJu0YyXHYUmoHTmI3rMNyjo6L+ElszQduYQDZTOE9uNCHlfhxM9oVar
	uCJlfEBYtgVIRiunu3B8gRFKdDDOzum0aumhG5jN5E9bgqelv9WVKUVbO7BGvzWwT6nx/Dqcgcr
	9skfk/h0zNLKRIH2rdnYHzSpMJndJBTWNbKAAfMEqpA==
X-Gm-Gg: ASbGnct7LnM5YosReB5i21sWeqsSBsHmqi04YMqETY0ZXHI3zuQVNKUux5KXMcvqMhY
	7O+B9xdOHXcLP0omDkW6o3PIFI6mC2J4mT6YXCdQAE5FQoGlBw/ygQTvAJ/XRRDd0TY4flDjP1o
	0u780G4SPBMpIDlgV8D01bYw81/2dvafXruVAho1gmEmUfKXzpE41YGL7TTr7gJYpwhv8=
X-Google-Smtp-Source: AGHT+IHuGVyTTobwFY1BlvknqGvpLeFrrR1bczDVqBKyOPULae3fTqXa+vIzqKtGdgWpndqn4a4uzU5Mzp70zeDiZIQ=
X-Received: by 2002:a05:6512:1104:b0:553:aa32:4106 with SMTP id
 2adb3069b0e04-553e3bdb2f0mr4350730e87.23.1750751093153; Tue, 24 Jun 2025
 00:44:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1750234270.git.hezhongkun.hzk@bytedance.com> <a57jjrtddjc4wjbrrjpyhfdx475zwpuetmkibeorboo7csc7aw@foqsmf5ipr73>
In-Reply-To: <a57jjrtddjc4wjbrrjpyhfdx475zwpuetmkibeorboo7csc7aw@foqsmf5ipr73>
From: Zhongkun He <hezhongkun.hzk@bytedance.com>
Date: Tue, 24 Jun 2025 15:44:16 +0800
X-Gm-Features: Ac12FXx4DweE5nEuNVlebPGSezJ2aOynsOY_jmkaW13eT6o26dRouTnjL5vacXk
Message-ID: <CACSyD1Pwzx62HTX9a45GW+droGXbfXeG2TGTB5M1p2qxG4vSCg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 0/2] Postpone memcg reclaim to
 return-to-user path
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: akpm@linux-foundation.org, tytso@mit.edu, jack@suse.com, 
	hannes@cmpxchg.org, mhocko@kernel.org, muchun.song@linux.dev, 
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shakeel,

Thank you for your detailed feedback and sorry for the late reply.
I need a bit more time to thoroughly review the case.

On Thu, Jun 19, 2025 at 6:37=E2=80=AFAM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> Hi Zhongkun,
>
> Thanks for a very detailed and awesome description of the problem. This
> is a real issue and we at Meta face similar scenarios as well. However I
> would not go for PF_MEMALLOC_ACFORCE approach as it is easy to abuse and
> is very manual and requires detecting the code which can cause such
> scenarios and then case-by-case opting them in. I would prefer a dynamic

Currently, our goal is to address the hung task issue caused by the
jbd2 handle which
has a high probability of occurring in our scenario and is more likely
to cause problems.
The patch only involves APIs used within the start/stop_this_handle()
context in jbd2,
such as memalloc_nofs_save() and can be used in other lock contexts.
Please refer to patch 2 for further details. It appears
that Btrfs employs a similar transactional mechanism via btrfs_trans_handle=
, and
makes use of memalloc_nofs_save() to safeguard metadata allocations.
For example,
see commit 84de76a2fb21 ("btrfs: protect space cache inode alloc with
GFP_NOFS").
But I'm not sure if the same problem exists.

> or automated approach where the kernel detects such an issue is
> happening and recover from it. Though a case can be made where we avoid
> such scenarios from happening but that might not be possible everytime.
>

Yes, you are right =E2=80=94 we need to identify and fix these issues case =
by
case. However,
we currently have a similar mechanism, like memalloc_nofs_save(), to
handle this.
An automated approach would definitely be better, or alternatively, we
could introduce
a new memory interface to delay memory reclaim until returning to userspace=
."

> Also this is very memcg specific, I can clearly see the same scenario
> can happen for global reclaim as well.

Yes, the same scenario can occur during global reclaim =E2=80=94 we have en=
countered it.
However, global memory shortages are difficult to resolve. Maybe we
can aggressively
trigger the OOM killer before tasks enter the uninterruptible (UN) state.
Or, a more aggressive approach would be to reduce the number of direct
reclaim retries,
allowing earlier access to memory reserves if the task holds the
global resource.
It is hard to balance.

>
> I have a couple of questions below:
>
> On Wed, Jun 18, 2025 at 07:39:56PM +0800, Zhongkun He wrote:
> > # Introduction
> >
> > This patchset aims to introduce an approach to ensure that memory
> > allocations are forced to be accounted to the memory cgroup, even if
> > they exceed the cgroup's maximum limit. In such cases, the reclaim
> > process is postponed until the task returns to the user.
>
> This breaks memory.max semantics. Any reason memory.high is not used
> here. Basically instead of memory.max, use memory.high as job limit. I
> would like to know how memory.high is lacking for your use-case. Maybe
> we can fix that or introduce a new form of limit. However this is memcg
> specific and will not resolve the global reclaim case.

The gpf_nofail is already breaking the memory.max semantics and this patchs=
et
is just breaking the limit in kernel context, and trying to reclaim or
oom on return
back to userspace. IIUC, memory.high will slow down the task, but we
would prefer
to kill the pod and let it be rescheduled on another machine, rather
than having it blocked.

>
> > This is
> > beneficial for users who perform over-max reclaim while holding multipl=
e
> > locks or other resources (especially resources related to file system
> > writeback). If a task needs any of these resources, it would otherwise
> > have to wait until the other task completes reclaim and releases the
> > resources. Postponing reclaim to the return-to-user path helps avoid th=
is issue.
> >
> > # Background
> >
> > We have been encountering an hungtask issue for a long time. Specifical=
ly,
> > when a task holds the jbd2 handler
>
> Can you explain a bit more about jbd2 handler? Is it some global shared
> lock or a workqueue which can only run single thread at a time.
> Basically is there a way to get the current holder/owner of jbd2 handler
> programmatically?

Thanks to Jan Kara for providing a detailed explanation in the letter
above. It is a shared global resource that's held by the process doing recl=
aim.


>
> > and subsequently enters direct reclaim
> > because it reaches the hard limit within a memory cgroup, the system ma=
y become
> > blocked for a long time. The stack trace of waiting thread holding the =
jbd2
> > handle is as follows (and so many other threads are waiting on the same=
 jbd2
> > handle):
> >
> >  #0 __schedule at ffffffff97abc6c9
> >  #1 preempt_schedule_common at ffffffff97abcdaa
> >  #2 __cond_resched at ffffffff97abcddd
> >  #3 shrink_active_list at ffffffff9744dca2
> >  #4 shrink_lruvec at ffffffff97451407
> >  #5 shrink_node at ffffffff974517c9
> >  #6 do_try_to_free_pages at ffffffff97451dae
> >  #7 try_to_free_mem_cgroup_pages at ffffffff974542b8
> >  #8 try_charge_memcg at ffffffff974f0ede
> >  #9 charge_memcg at ffffffff974f1d0e
> > #10 __mem_cgroup_charge at ffffffff974f391c
> > #11 __add_to_page_cache_locked at ffffffff974313e5
> > #12 add_to_page_cache_lru at ffffffff974324b2
> > #13 pagecache_get_page at ffffffff974338e3
> > #14 __getblk_gfp at ffffffff97556798
> > #15 __ext4_get_inode_loc at ffffffffc07a5518 [ext4]
> > #16 ext4_get_inode_loc at ffffffffc07a7fec [ext4]
> > #17 ext4_reserve_inode_write at ffffffffc07a9fb1 [ext4]
> > #18 __ext4_mark_inode_dirty at ffffffffc07aa249 [ext4]
> > #19 __ext4_new_inode at ffffffffc079cbae [ext4]
> > #20 ext4_create at ffffffffc07c3e56 [ext4]
> > #21 path_openat at ffffffff9751f471
> > #22 do_filp_open at ffffffff97521384
> > #23 do_sys_openat2 at ffffffff97508fd6
> > #24 do_sys_open at ffffffff9750a65b
> > #25 do_syscall_64 at ffffffff97aaed14
> >
> > We've obtained a coredump and dumped struct scan_control from it by usi=
ng crash tool.
> >
> > struct scan_control {
> >   nr_to_reclaim =3D 32,
> >   order =3D 0 '\000',
> >   priority =3D 1 '\001',
> >   reclaim_idx =3D 4 '\004',
> >   gfp_mask =3D 17861706, __GFP_NOFAIL
> >   nr_scanned =3D 27810,
> >   nr_reclaimed =3D 0,
> >   nr =3D {
> >         dirty =3D 27797,
> >         unqueued_dirty =3D 27797,
> >         congested =3D 0,
> >         writeback =3D 0,
> >         immediate =3D 0,
> >         file_taken =3D 27810,
> >         taken =3D 27810
> >   },
> > }
> >
>
> What is the kernel version? Can you run scripts/gfp-translate on the
> gfp_mask above? Does this kernel have a75ffa26122b ("memcg, oom: do not
> bypass oom killer for dying tasks")?

This kernel is 5.15+,  I think this problem is still here

Parsing: 17861706
#define ___GFP_HIGHMEM 0x02
#define ___GFP_MOVABLE 0x08
#define ___GFP_IO 0x40
#define ___GFP_DIRECT_RECLAIM 0x400
#define ___GFP_KSWAPD_RECLAIM 0x800
#define ___GFP_NOFAIL 0x8000
#define ___GFP_HARDWALL 0x100000
#define ___GFP_SKIP_KASAN_POISON 0x1000000
There is no such patch a75ffa26122b, and I think it is reasonable but
the task holding
the jbd2 handle is not a dying task.

>
> > The ->nr_reclaimed is zero meaning there is no memory we have reclaimed=
 because
> > most of the file pages are unqueued dirty. And ->priority is 1 also mea=
ning we
> > spent so much time on memory reclamation.
>
> Is there a way to get how many times this thread has looped within
> try_charge_memcg()?

The nr_retries is MAX_RECLAIM_RETRIES, and the mem_cgroup not in oom,
mem_cgroup 0xffff8c82a27c0800 | grep oom
  oom_group =3D false,
  oom_lock =3D false,
  under_oom =3D 0

Maybe we enter the try_charge_memcg in the first loop.
I will explain it later.

>
> > Since this thread has held the jbd2
> > handler, the jbd2 thread was waiting for the same jbd2 handler, which b=
locked
> > so many other threads from writing dirty pages as well.
> >
> > 0 [] __schedule at ffffffff97abc6c9
> > 1 [] schedule at ffffffff97abcd01
> > 2 [] jbd2_journal_wait_updates at ffffffffc05a522f [jbd2]
> > 3 [] jbd2_journal_commit_transaction at ffffffffc05a72c6 [jbd2]
> > 4 [] kjournald2 at ffffffffc05ad66d [jbd2]
> > 5 [] kthread at ffffffff972bc4c0
> > 6 [] ret_from_fork at ffffffff9720440f
> >
> > Furthermore, we observed that memory usage far exceeded the configured =
memory maximum,
> > reaching around 38GB.
> >
> > memory.max  : 134896020    514 GB
> > memory.usage: 144747169    552 GB
>
> This is unexpected and most probably our hacks to allow overcharge to
> avoid similar situations are causing this.

Yes.

>
> >
> > We investigated this issue and identified the root cause:
> >   try_charge_memcg:
> >     retry charge
> >      charge failed
> >        -> direct reclaim
> >         -> mem_cgroup_oom    return true=EF=BC=8Cbut selected task is i=
n an uninterruptible state
> >            -> retry charge
>
> Oh oom reaper didn't help?
>
> >
> > In which cases, we saw many tasks in the uninterruptible (D) state with=
 a pending
> > SIGKILL signal. The OOM killer selects a victim and returns success, al=
lowing the
> > current thread to retry the memory charge. However, the selected task c=
annot acknowledge
> > the SIGKILL signal because it is stuck in an uninterruptible state.
>
> OOM reaper usually helps in such cases but I see below why it didn't
> help.
>
> > As a result,
> > the charging task resets nr_retries and attempts to reclaim again, but =
the victim
> > task never exits. This causes the current thread to enter a prolonged r=
etry loop
> > during direct reclaim, holding the jbd2 handler for much more time and =
leading to
> > system-wide blocking. Why are there so many uninterruptible (D) state t=
asks?
> > Check the most common stack trace.
> >
> > crash> task_struct.__state ffff8c53a15b3080
> >   __state =3D 2,   #define TASK_UNINTERRUPTIBLE        0x0002
> >  0 [] __schedule at ffffffff97abc6c9
> >  1 [] schedule at ffffffff97abcd01
> >  2 [] schedule_preempt_disabled at ffffffff97abdf1a
> >  3 [] rwsem_down_read_slowpath at ffffffff97ac05bf
> >  4 [] down_read at ffffffff97ac06b1
> >  5 [] do_user_addr_fault at ffffffff9727f1e7
> >  6 [] exc_page_fault at ffffffff97ab286e
> >  7 [] asm_exc_page_fault at ffffffff97c00d42
> >
> > Check the owner of mm_struct.mmap_lock. The task below was entering mem=
ory reclaim
> > holding mmap lock and there are 68 tasks in this memory cgroup, with 23=
 of them in
> > the memory reclaim context.
> >
>
> The following thread has mmap_lock in write mode and thus oom-reaper is
> not helping. Do you see "oom_reaper: unable to reap pid..." messages in
> dmesg?
>
> >  7 [] shrink_active_list at ffffffff9744dd46
> >  8 [] shrink_lruvec at ffffffff97451407
> >  9 [] shrink_node at ffffffff974517c9
> > 10 [] do_try_to_free_pages at ffffffff97451dae
> > 11 [] try_to_free_mem_cgroup_pages at ffffffff974542b8
> > 12 [] try_charge_memcg at ffffffff974f0ede
> > 13 [] obj_cgroup_charge_pages at ffffffff974f1dae
> > 14 [] obj_cgroup_charge at ffffffff974f2fc2
> > 15 [] kmem_cache_alloc at ffffffff974d054c
> > 16 [] vm_area_dup at ffffffff972923f1
> > 17 [] __split_vma at ffffffff97486c16
> > 18 [] __do_munmap at ffffffff97486e78
> > 19 [] __vm_munmap at ffffffff97487307
> > 20 [] __x64_sys_munmap at ffffffff974873e7
> > 21 [] do_syscall_64 at ffffffff97aaed14
> >
> > Many threads was entering the memory reclaim in UN state, other threads=
 was blocking
> > on mmap_lock. Although the OOM killer selects a victim, it cannot termi=
nate it.
>
> Can you please confirm the above? Is the kernel able to oom-kill more
> processes or if it is returning early because the current thread is
> dying. However if the cgroup has just one big process, this doesn't
> matter.

Hi Shakeel

I'm a bit confused here because I don't see any "oom_reaper: unable
to reap pid..." or "Killed process %d (%s) total-vm:%lukB ..." messages
in the dmesg output. However, I did find many tasks with a pending
SIGKILL signal.

If these tasks weren't killed by the OOM killer, why do they have SIGKILL
pending in shrink context? That's why I'm unsure about this part.
Please have a look=EF=BC=9A

crash> task_struct.pending.signal.sig ffff8bc4c143e100
  pending.signal.sig =3D {256}
crash> task_struct.thread_info.flags ffff8bc4c143e100
  thread_info.flags =3D 16388,  bit 2 ; #defineTIF_SIGPENDING      2
crash> bt
PID: 1269110  TASK: ffff8bc4c143e100  CPU: 5    COMMAND: "xx"
 #0 [] __schedule at ffffffff97abc6c9
 #1 [] preempt_schedule_common at ffffffff97abcdaa
 #2 [] __cond_resched at ffffffff97abcddd
 #3 [] shrink_lruvec at ffffffff9745120a
 #4 [] shrink_node at ffffffff974517c9
 #5 [] do_try_to_free_pages at ffffffff97451dae
 #6 [] try_to_free_mem_cgroup_pages at ffffffff974542b8
 #7 [] try_charge_memcg at ffffffff974f0ede
 #8 [] charge_memcg at ffffffff974f1d0e
 #9 [] __mem_cgroup_charge at ffffffff974f391c
#10 [] __add_to_page_cache_locked at ffffffff974313e5
#11 [] add_to_page_cache_lru at ffffffff974324b2
#12 [] page_cache_ra_unbounded at ffffffff97442227
#13 [] filemap_fault at ffffffff97434b80
#14 [] __do_fault at ffffffff9747b870
#15 [] __handle_mm_fault at ffffffff97480329
#16 [] handle_mm_fault at ffffffff9748081e
#17 [] do_user_addr_fault at ffffffff9727f01b
#18 [] exc_page_fault at ffffffff97ab286e
#19 [] asm_exc_page_fault at ffffffff97c00d42

>
> > The
> > task holding the jbd2 handle retries memory charge, but it fails. Recla=
iming continues
> > while holding the jbd2 handler. write_pages also fails while waiting fo=
r the same jbd2
> > handler, causing repeated shrink failures and potentially leading to a =
system-wide block.
> >
> > ps | grep UN | wc -l
> > 1463
> >
> > While the system has 1463 UN state tasks, so the way to break this akin=
 to "deadlock" is
> > to let the thread holding jbd2 handler quickly exit the memory reclamat=
ion process.
> >
> > We found that a related issue was reported and partially fixed in previ=
ous patches [1][2].
> > However, those fixes only skip direct reclamation and return a failure =
for some cases such
> > as readahead requests. As sb_getblk() is called multiple times in __ext=
4_get_inode_loc()
> > with the NOFAIL flag, the problem still exists. And it is not feasible =
to simply remove
> > __GFP_RECLAIMABLE when holding jbd2 handle to avoid potential very long=
 memory reclaim
> > latency,  as __GFP_NOFAIL is not supported without __GFP_DIRECT_RECLAIM=
.
> >
> > # Fundamentals
> >
> > This patchset introduces a new task flag of PF_MEMALLOC_ACFORCE to indi=
cate that memory
> > allocations are forced to be accounted to the memory cgroup, even if th=
ey exceed the cgroup's
> > maximum limit. The reclaim process is deferred until the task returns t=
o the user without
> > holding any kernel resources for memory reclamation, thereby preventing=
 priority inversion
> > problems. Any users who might encounter potential similar issues can ut=
ilize this new flag
> > to allocate memory and prevent long-term latency for the entire system.
>
> I already explained upfront why this is not the approach we want.
>
> We do see similar situations/scenarios but due to global/shared locks in
> btrfs but I expect any global lock or global shared resource can cause
> such priority inversion situations.

I completely agree. Doesn=E2=80=99t this mean that we should have a mechani=
sm
or a flag to indicate when a task is holding global resources or locks, so
that appropriate decisions can be made in global and memcg memory
reclaim contexts, in order to avoid holding locks or resources for an exten=
ded
period of time?  It would be better if we can have an automated approach th=
at
solves all the problems.

