Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA6EF3928E9
	for <lists+cgroups@lfdr.de>; Thu, 27 May 2021 09:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232896AbhE0Hw7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 27 May 2021 03:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbhE0Hw6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 27 May 2021 03:52:58 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D49DAC061760
        for <cgroups@vger.kernel.org>; Thu, 27 May 2021 00:51:22 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id t20so2854625qtx.8
        for <cgroups@vger.kernel.org>; Thu, 27 May 2021 00:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uged.al; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H1K+CltDkIifzJ1ZXQpzAw36adTVLXU/8cQQG6X9chM=;
        b=NeJDPoxQd8SETUNL2LwQdTKnsSIT2U11WXjT8ZX3IfqzKuKNBMlb8lHBZ552GiYKVu
         4o+M09n6CdFkV1VvnJ4Ve2YOpyyK1/W4JL8tOhdePDo1TXf94GQWD2iueoPSJs829opU
         iFkBKFWX82u/YQTFBumNdsKCK121GG8b0rXJtuLYd5GoMdww0Zm2dA6bOTCu+O2IfJDn
         RL+oROPUCe9vKQgeY8nXME6sW9DTlMk8MPE6J0u+FsN91doUHZmG4TQ9RlNQmNqQeKMX
         HYqWYDhfXhN/CtFI52cbOkioxVvJC/xqcfWCs952N/Jc7e4m2anpul5wp+mQuRljXfcg
         77fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H1K+CltDkIifzJ1ZXQpzAw36adTVLXU/8cQQG6X9chM=;
        b=fliHksD1GnYSQOp96Omv1OWDKetYhJY0RBHJrVcMv9wPBvDPs0A11jV96o30fkpWbn
         QCYqHiU9l83a4b36A7AxzcAjORpVSdhKwUYWDJ/IxIKj3sDJWKE3UyJzvQJVT27fDW6e
         BjULYvj15azzjI+eJCineqLsIUFYDdmvU8hjSh4T6chq4UTt61EYJct/QiKoKH5Ik9hz
         XCfADtN24lsddvzo27W9i+bRhqGfI/2hLfmYis8AA2pc9Dpv1uIEUqbGU5Y9qWS9ViRK
         znHpQ1zSN/c3eN8gKCHOTu0A+xoYDwAggDH5GEZZUlJ+cRxaeuOvHWbL7zez+P/Ih9EJ
         XdPw==
X-Gm-Message-State: AOAM531WGRRUM9X/QwBEsMKB/OzYdUQfen+vi/7004cUuvxe6WXAIQSQ
        RW++bmoSfeO+oInqdsHndTS0XqvUA8hEIv5aJbg6Zw==
X-Google-Smtp-Source: ABdhPJzp6z18DQ/0ZwLnYtBiAuBxAAbcDrlZQwXZTVIYRe5Gwo0aj9DS4V8OQiAs49soRiN3XszTvrRkiIHd0W/LRy0=
X-Received: by 2002:ac8:45c2:: with SMTP id e2mr2080986qto.138.1622101881977;
 Thu, 27 May 2021 00:51:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210518125202.78658-1-odin@uged.al> <20210518125202.78658-2-odin@uged.al>
 <CAKfTPtCCZhjOCZR6DMSxb9qffG2KceWONP_MzoY6TpYBmWp+hg@mail.gmail.com>
 <CAFpoUr0f50hKUtWvpTy221xT+pUocY7LXCMCo3cPJupjgMtotg@mail.gmail.com>
 <CAKfTPtCaZOSEzRXVN9fTR2vTxGiANEARo6iDNMFiQV5=qAA4Tw@mail.gmail.com> <CAKfTPtAFn3=anfTCxKTDXF0wpttpEiAhksLvcEPdSiYZTj38_A@mail.gmail.com>
In-Reply-To: <CAKfTPtAFn3=anfTCxKTDXF0wpttpEiAhksLvcEPdSiYZTj38_A@mail.gmail.com>
From:   Odin Ugedal <odin@uged.al>
Date:   Thu, 27 May 2021 09:50:42 +0200
Message-ID: <CAFpoUr1zGNf9vTbWjwsfY9E8YBjyE5xJ0SwzLebPiS7b=xz_Zw@mail.gmail.com>
Subject: Re: [PATCH 1/3] sched/fair: Add tg_load_contrib cfs_rq decay checking
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Odin Ugedal <odin@uged.al>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,

Did some quick testing with bpftrace, and it looks like it is
"update_tg_cfs_load" that does this;

 kretfunc:attach_entity_load_avg: cfs_rq: 0xffff8a3e6773e400,
se.load_sum: 0, se.load_avg: 0, se->load.weight: 1048576 diff.sum: 0,
diff.load: 0, new_sum: 0, new_load: 0, period_contrib: 821

 // quite some time passes

 kretfunc:update_tg_cfs_load: cfs_rq: 0xffff8a3e6773e400, old load_sum
0, old load_avg: 0, new load_sum: 47876096, new load_avg: 1022
tg_load_avg_contrib: 0, period_contrib: 82, on_list: 0, throttled: 0/0
stack:
         bpf_prog_a37cf01922e02958_update_tg_cfs_l+504
         bpf_get_stackid_raw_tp+115
         bpf_prog_a37cf01922e02958_update_tg_cfs_l+504
         bpf_trampoline_6442466486_1+144
         update_tg_cfs_load+5
         update_load_avg+450
         enqueue_entity+91
         enqueue_task_fair+134
         move_queued_task+172
         affine_move_task+1282
         __set_cpus_allowed_ptr+317
         update_tasks_cpumask+70
         update_cpumasks_hier+448
         update_cpumask+345
         cpuset_write_resmask+796
         cgroup_file_write+162
         kernfs_fop_write_iter+284
         new_sync_write+345
         vfs_write+511
         ksys_write+103
         do_syscall_64+51
         entry_SYSCALL_64_after_hwframe+68

 // There might be more stuff happening here
 // __update_load_avg_cfs_rq runs way too often to be able to
 // trace it without filtering, and didn't look into that.

 kretfunc:update_tg_cfs_load: cfs_rq: 0xffff8a3e6773e400, old load_sum
48117265, old load_avg: 1025, new load_sum: 0, new load_avg: 2
tg_load_avg_contrib: 1022, period_contrib: 223, on_list: 1, throttled:
1/1 stack:
         bpf_prog_a37cf01922e02958_update_tg_cfs_l+504
         bpf_get_stackid_raw_tp+115
         bpf_prog_a37cf01922e02958_update_tg_cfs_l+504
         bpf_trampoline_6442466486_1+144
         update_tg_cfs_load+5
         update_load_avg+450
         update_blocked_averages+723
         newidle_balance+533
         pick_next_task_fair+57
         __schedule+376
         schedule+91
         schedule_hrtimeout_range_clock+164
         do_sys_poll+1043
         __x64_sys_poll+179
         do_syscall_64+51
         entry_SYSCALL_64_after_hwframe+68

This particular example resulted in a 75/25 share of cpu time for the
two groups.

From this, it also looks like it doesn't matter if new load_avg is 0 or not
(when new load_sum is 0), since tg_load_avg_contrib will not be properly
removed either way (without this patch). There might be some other precision


> I have added a trace in cfs_rq_is_decayed() but I'm not able to
> reproduce a situation where load_sum == 0 but not load_avg  even with
> the script in the cover letter

Hmm, strange. I am able to reproduce on both v5.12 and v5.13. I am running on
a non SMT 4 core CPU (4670k), with CONFIG_HZ=250. Since this is timing
sensitive,
you might need to tweak the timings for either the CFS bw period/quota, or the
time waiting between changing what cpu it runs on. If you have more than 4 cpus,
you can also try to start on CPU 0 and move it through all cores and
then onto CPU n.
Maybe that makes it possible to reproduce.

Since bpftrace doesn't work properly in v5.13, this particular test was
on v1.12 with cherry-pick of 0258bdfaff5bd13c4d2383150b7097aecd6b6d82 and
the other patch in this patchset.

testscript.bt:

  kfunc:attach_entity_load_avg {@a_sum[tid] =
args->cfs_rq->avg.load_sum; @a_load[tid] =
args->cfs_rq->avg.load_avg;}
  kretfunc:attach_entity_load_avg{printf("%s: cfs_rq: %p, se.load_sum:
%llu, se.load_avg: %llu, se->load.weight: %llu diff.sum: %llu,
diff.load: %llu, new_sum: %llu, new_load: %llu, period_contrib:
%llu\n", probe, args->cfs_rq,args->se->avg.load_sum,
args->se->avg.load_avg,
args->se->load.weight,args->cfs_rq->avg.load_sum - @a_sum[tid],
args->cfs_rq->avg.load_avg - @a_load[tid], args->cfs_rq->avg.load_sum,
args->cfs_rq->avg.load_avg, args->cfs_rq->avg.period_contrib)}

  kfunc:update_tg_cfs_load {@beg_load_avg[tid] =
args->cfs_rq->avg.load_avg; @beg_load_sum[tid] =
args->cfs_rq->avg.load_sum}
  kretfunc:update_tg_cfs_load {printf("%s: cfs_rq: %p, old load_sum
%llu, old load_avg: %llu, new load_sum: %llu, new load_avg: %llu
tg_load_avg_contrib: %llu, period_contrib: %llu, on_list: %d,
throttled: %d/%d stack: %s\n",probe, args->cfs_rq, @beg_load_sum[tid],
@beg_load_avg[tid], args->cfs_rq->avg.load_sum,
args->cfs_rq->avg.load_avg, args->cfs_rq->tg_load_avg_contrib,
args->cfs_rq->avg.period_contrib,args->cfs_rq->on_list,
args->cfs_rq->throttled, args->cfs_rq->throttle_count,kstack)}

Thanks
Odin
