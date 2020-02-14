Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D41F015F634
	for <lists+cgroups@lfdr.de>; Fri, 14 Feb 2020 19:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729577AbgBNSzb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 14 Feb 2020 13:55:31 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42375 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728859AbgBNSzb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 14 Feb 2020 13:55:31 -0500
Received: by mail-pl1-f193.google.com with SMTP id e8so4045320plt.9
        for <cgroups@vger.kernel.org>; Fri, 14 Feb 2020 10:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=N5mJwRVM7fV7U1L+8IEzdcgxN+R5zfGAOZeQcK9YsIo=;
        b=IiF97q+loSxxQER85qTwEXbkVqh1t0bf9563sVJjghWsxitRD7AmlPyuKmQjb42DeQ
         w+Sk0aFBVOZZiCst42XZvWlTFFa+d/dwyXMu6RSaImfccRlUiVu/poOUqcrn2XOK+LTQ
         8h1Qjotpx9b++2ZGxZGGh7RUMnDD5Ns8zjO5Oo2kTAle6LcsOx34EUrhlixD/PRXViYw
         hu4FBa6SOHxg1v9qPPPsdESl5IGaDFJez9NV1Bg6woROuK7K5VAEg6VWlbjRbYyFTE41
         XTWCKoQ7bNpV/8tNzzEwY65tK4fTzCZO3pJ3aiLOn5qcFvzhaPEF1+4eK7xPSY8VHvS2
         4pXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=N5mJwRVM7fV7U1L+8IEzdcgxN+R5zfGAOZeQcK9YsIo=;
        b=h6SPY0Y+08YdmMPnlwYKSTfqHP1cgARKeP7mPDEGeKL3iMLQi5yppIbCrjCElF2//7
         0ZZULRAOm6PADSWq19DfdydUk/msnL+8yn2jfDj1bn60r6edrNR8EZFZmdAHKT/Cycfq
         jCy1p7B91zdXfW3YF4KjCNDKlPe4SSwP5JGf6FPXVhL7NUnFYwCznKoq9KQs2JH8avHz
         g9lwSZV1/eEts1LgsK0vNVp63HZ69UxiVh3yVLXgXV0H8l97b0SsQH0L4PVNjHI9cUGO
         OtgwqaGYzWZd+rldetprQqXHejdyO7HxPKt8zxxPnF8U2AkLj59mZidf9yi555HWpiur
         WNxg==
X-Gm-Message-State: APjAAAW1Gd6yL9Imr7a5sErRgqW8e/LXjKECThGUHT5wNAc5WkrwZO0E
        4I18PxSOjcx8fymynvYpn8Q7RA==
X-Google-Smtp-Source: APXvYqxn7k+ha9ICZN6ZFVtlnbPTys8L7osTI3fg1f25KNNw/VvdndRuO7t2xq728CEK/5v/pcHR2A==
X-Received: by 2002:a17:902:8b89:: with SMTP id ay9mr4590333plb.309.1581706530065;
        Fri, 14 Feb 2020 10:55:30 -0800 (PST)
Received: from bsegall-linux.svl.corp.google.com.localhost ([2620:15c:2cd:202:39d7:98b3:2536:e93f])
        by smtp.gmail.com with ESMTPSA id a21sm7933083pgd.12.2020.02.14.10.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 10:55:29 -0800 (PST)
From:   bsegall@google.com
To:     Dave Chiluk <chiluk+linux@indeed.com>
Cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Peter Zijlstra <peterz@infradead.org>, cgroups@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH v2] sched/fair: add burst to cgroup cpu bandwidth controller
References: <157476581065.5793.4518979877345136813.stgit@buzz>
        <CAC=E7cU8TeNHDRnrHiFxmiHUKviVU9KaDvMq-U16VRgcohg6-w@mail.gmail.com>
Date:   Fri, 14 Feb 2020 10:55:19 -0800
In-Reply-To: <CAC=E7cU8TeNHDRnrHiFxmiHUKviVU9KaDvMq-U16VRgcohg6-w@mail.gmail.com>
        (Dave Chiluk's message of "Fri, 14 Feb 2020 09:13:08 -0600")
Message-ID: <xm268sl5uhgo.fsf@bsegall-linux.svl.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Dave Chiluk <chiluk+linux@indeed.com> writes:

> @Ben Segall, @Ingo Molnar, @Peter Zijlstra : This would be really
> useful, can you please voice your concerns/frustrations so they can be
> addressed?  This should help increasing density of our bursty
> web-applications.

I seem to have missed this in my inbox.

>
> @Konstantin, please add a reviewed by by-line.  As I don't do this
> regularly, I need all the attribution I can get.
> Reviewed-by: Dave Chiluk <chiluk+linux@indeed.com>
>
> Thanks,
> Dave
>
>
> On Tue, Nov 26, 2019 at 4:56 AM Konstantin Khlebnikov
> <khlebnikov@yandex-team.ru> wrote:
>>
>> Currently CFS bandwidth controller assigns cpu.cfs_quota_us runtime into
>> global pool every cpu.cfs_period_us. All unused runtime is expired.
>>
>> Since commit de53fd7aedb1 ("sched/fair: Fix low cpu usage with high
>> throttling by removing expiration of cpu-local slices") slice assigned
>> to cpu does not expire. This allows to serve tiny bursts (upto 1ms),
>> but this runtime pool is cpu-bound and not transferred between cpus.
>>
>> Setup for interactive workload with irregular cpu consumption have to set
>> quota according to relatively short spikes of cpu usage. This eliminates
>> possibility of control for average cpu usage. Increasing period and quota
>> proportionally for getting bigger runtime chunks is not an option because
>> if even bigger spike deplete global pool then execution will stuck until
>> end of period and next refill.
>>
>> This patch adds limited accumulation of unused runtime from past periods.
>> Accumulated runtime does not expire. It stays in global pool and could be
>> used by any cpu. Average cpu usage stays limited with quota / period,
>> but spiky workload could use more cpu power for a short period of time.
>>
>> Size of pool for burst runtime is set in attribute cpu.cfs_burst_us.
>> Default is 0, which reflects current behavior.
>>
>> Statistics for used bust runtime is shown in cpu.stat as "burst_time".
>>
>> Example setup:
>>
>> cpu.cfs_period_us = 100000
>> cpu.cfs_quota_us = 200000
>> cpu.cfs_burst_us = 300000
>>
>> Average cpu usage stays limited with 2 cpus (quota / period), but cgroup
>> could accumulate runtime (burst) and for 100ms could utilize up to 5 cpus
>> (quota / period + burst / 100ms), or 3 cpus for 300ms, an so on.
>>
>> For example, in this cgroup sample workload with bursts:
>>
>> fio --name=test --ioengine=cpuio --time_based=1 --runtime=600 \
>>            --cpuload=10 --cpuchunks=100000 --numjobs=5
>>
>> has 50% average cpu usage without throttling. Without enabling bursts
>> same command can utilize only 25% cpu and 25% time will be throttled.
>>
>> Implementation is simple. All logic is in __refill_cfs_bandwidth_runtime().
>> Burst pool is kept in common pool thus runtime distribution is unchanged.
>> The rest changes are interface for cgroup and cgroup2.
>>
>> For cgroup2 burst is set as third number in attribute cpu.max:
>> cpu.max = $QUOTA $PERIOD $BURST
>>
>> At changing setup cgroup gets full charge of runtime and burst runtime.
>>
>> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
>> Cc: Dave Chiluk <chiluk+linux@indeed.com>
>> Cc: Cong Wang <xiyou.wangcong@gmail.com>

I'm not sure that starting with full burst runtime is best, though it
definitely seems likely to be one of those things where sometimes it's
what you want and sometimes it's not.

Reviewed-by: Ben Segall <bsegall@google.com>

>>
>> ---
>>
>> v2: fix spelling, add refilling burst runtime at changing setup per Dave Chiluk
>>
>> v1: https://lore.kernel.org/lkml/157312875706.707.12248531434112979828.stgit@buzz/
>>
>> Cong Wang proposed similar feature: https://lore.kernel.org/patchwork/patch/907450/
>> But with changing default behavior and without statistics.
>> ---
>>  Documentation/admin-guide/cgroup-v2.rst |   15 +++--
>>  Documentation/scheduler/sched-bwc.rst   |    8 ++-
>>  kernel/sched/core.c                     |   94 +++++++++++++++++++++++++------
>>  kernel/sched/fair.c                     |   34 +++++++++--
>>  kernel/sched/sched.h                    |    4 +
>>  5 files changed, 124 insertions(+), 31 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
>> index 5361ebec3361..8c3cc3d882ba 100644
>> --- a/Documentation/admin-guide/cgroup-v2.rst
>> +++ b/Documentation/admin-guide/cgroup-v2.rst
>> @@ -981,11 +981,12 @@ All time durations are in microseconds.
>>         - user_usec
>>         - system_usec
>>
>> -       and the following three when the controller is enabled:
>> +       and the following four when the controller is enabled:
>>
>>         - nr_periods
>>         - nr_throttled
>>         - throttled_usec
>> +       - burst_usec
>>
>>    cpu.weight
>>         A read-write single value file which exists on non-root
>> @@ -1006,16 +1007,18 @@ All time durations are in microseconds.
>>         the closest approximation of the current weight.
>>
>>    cpu.max
>> -       A read-write two value file which exists on non-root cgroups.
>> -       The default is "max 100000".
>> +       A read-write 1..3 values file which exists on non-root cgroups.
>> +       The default is "max 100000 0".
>>
>>         The maximum bandwidth limit.  It's in the following format::
>>
>> -         $MAX $PERIOD
>> +         $MAX $PERIOD $BURST
>>
>>         which indicates that the group may consume upto $MAX in each
>> -       $PERIOD duration.  "max" for $MAX indicates no limit.  If only
>> -       one number is written, $MAX is updated.
>> +       $PERIOD duration and accumulates upto $BURST time for bursts.
>> +
>> +       "max" for $MAX indicates no limit.
>> +       If only one number is written, $MAX is updated.

Might want to change this to "Fields that aren't provided are left with
the old values" or something.

>>
>>    cpu.pressure
>>         A read-only nested-key file which exists on non-root cgroups.
>> diff --git a/Documentation/scheduler/sched-bwc.rst b/Documentation/scheduler/sched-bwc.rst
>> index 9801d6b284b1..59de2ebe11b3 100644
>> --- a/Documentation/scheduler/sched-bwc.rst
>> +++ b/Documentation/scheduler/sched-bwc.rst
>> @@ -27,12 +27,14 @@ Quota and period are managed within the cpu subsystem via cgroupfs.
>>
>>  cpu.cfs_quota_us: the total available run-time within a period (in microseconds)
>>  cpu.cfs_period_us: the length of a period (in microseconds)
>> +cpu.cfs_burst_us: the maxumum size of burst run-time pool (in microseconds)
>>  cpu.stat: exports throttling statistics [explained further below]
>>
>>  The default values are::
>>
>>         cpu.cfs_period_us=100ms
>> -       cpu.cfs_quota=-1
>> +       cpu.cfs_quota_us=-1
>> +       cpu.cfs_burst_us=0
>>
>>  A value of -1 for cpu.cfs_quota_us indicates that the group does not have any
>>  bandwidth restriction in place, such a group is described as an unconstrained
>> @@ -51,6 +53,9 @@ and return the group to an unconstrained state once more.
>>  Any updates to a group's bandwidth specification will result in it becoming
>>  unthrottled if it is in a constrained state.
>>
>> +Writing positive value into cpu.cfs_burst_us allows unused quota to
>> +accumulate up to this value and be used later in addition to assigned quota.
>> +
>>  System wide settings
>>  --------------------
>>  For efficiency run-time is transferred between the global pool and CPU local
>> @@ -75,6 +80,7 @@ cpu.stat:
>>  - nr_throttled: Number of times the group has been throttled/limited.
>>  - throttled_time: The total time duration (in nanoseconds) for which entities
>>    of the group have been throttled.
>> +- burst_time: The total running time consumed from burst pool.
>>
>>  This interface is read-only.
>>
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index 44123b4d14e8..c4c8ef521e7c 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -7364,7 +7364,8 @@ static const u64 min_cfs_quota_period = 1 * NSEC_PER_MSEC; /* 1ms */
>>
>>  static int __cfs_schedulable(struct task_group *tg, u64 period, u64 runtime);
>>
>> -static int tg_set_cfs_bandwidth(struct task_group *tg, u64 period, u64 quota)
>> +static int tg_set_cfs_bandwidth(struct task_group *tg, u64 period, u64 quota,
>> +                               u64 burst)
>>  {
>>         int i, ret = 0, runtime_enabled, runtime_was_enabled;
>>         struct cfs_bandwidth *cfs_b = &tg->cfs_bandwidth;
>> @@ -7409,12 +7410,17 @@ static int tg_set_cfs_bandwidth(struct task_group *tg, u64 period, u64 quota)
>>         raw_spin_lock_irq(&cfs_b->lock);
>>         cfs_b->period = ns_to_ktime(period);
>>         cfs_b->quota = quota;
>> +       cfs_b->burst = burst;
>>
>> -       __refill_cfs_bandwidth_runtime(cfs_b);
>> -
>> -       /* Restart the period timer (if active) to handle new period expiry: */
>> -       if (runtime_enabled)
>> +       /*
>> +        * Restart the period timer (if active) to handle new period expiry.
>> +        * And refill runtime and burst-runtime to full charge.
>> +        */
>> +       if (runtime_enabled) {
>> +               cfs_b->burst_runtime = burst;
>> +               cfs_b->runtime = quota + burst;
>>                 start_cfs_bandwidth(cfs_b);
>> +       }
>>
>>         raw_spin_unlock_irq(&cfs_b->lock);
>>
>> @@ -7442,9 +7448,10 @@ static int tg_set_cfs_bandwidth(struct task_group *tg, u64 period, u64 quota)
>>
>>  static int tg_set_cfs_quota(struct task_group *tg, long cfs_quota_us)
>>  {
>> -       u64 quota, period;
>> +       u64 quota, period, burst;
>>
>>         period = ktime_to_ns(tg->cfs_bandwidth.period);
>> +       burst = tg->cfs_bandwidth.burst;
>>         if (cfs_quota_us < 0)
>>                 quota = RUNTIME_INF;
>>         else if ((u64)cfs_quota_us <= U64_MAX / NSEC_PER_USEC)
>> @@ -7452,7 +7459,7 @@ static int tg_set_cfs_quota(struct task_group *tg, long cfs_quota_us)
>>         else
>>                 return -EINVAL;
>>
>> -       return tg_set_cfs_bandwidth(tg, period, quota);
>> +       return tg_set_cfs_bandwidth(tg, period, quota, burst);
>>  }
>>
>>  static long tg_get_cfs_quota(struct task_group *tg)
>> @@ -7470,15 +7477,16 @@ static long tg_get_cfs_quota(struct task_group *tg)
>>
>>  static int tg_set_cfs_period(struct task_group *tg, long cfs_period_us)
>>  {
>> -       u64 quota, period;
>> +       u64 quota, period, burst;
>>
>>         if ((u64)cfs_period_us > U64_MAX / NSEC_PER_USEC)
>>                 return -EINVAL;
>>
>>         period = (u64)cfs_period_us * NSEC_PER_USEC;
>>         quota = tg->cfs_bandwidth.quota;
>> +       burst = tg->cfs_bandwidth.burst;
>>
>> -       return tg_set_cfs_bandwidth(tg, period, quota);
>> +       return tg_set_cfs_bandwidth(tg, period, quota, burst);
>>  }
>>
>>  static long tg_get_cfs_period(struct task_group *tg)
>> @@ -7491,6 +7499,28 @@ static long tg_get_cfs_period(struct task_group *tg)
>>         return cfs_period_us;
>>  }
>>
>> +static long tg_get_cfs_burst(struct task_group *tg)
>> +{
>> +       u64 cfs_burst_us = tg->cfs_bandwidth.burst;
>> +
>> +       do_div(cfs_burst_us, NSEC_PER_USEC);
>> +       return cfs_burst_us;
>> +}
>> +
>> +static int tg_set_cfs_burst(struct task_group *tg, long cfs_burst_us)
>> +{
>> +       u64 quota, period, burst;
>> +
>> +       if ((u64)cfs_burst_us > U64_MAX / NSEC_PER_USEC)
>> +               return -EINVAL;
>> +
>> +       period = ktime_to_ns(tg->cfs_bandwidth.period);
>> +       quota = tg->cfs_bandwidth.quota;
>> +       burst = (u64)cfs_burst_us * NSEC_PER_USEC;
>> +
>> +       return tg_set_cfs_bandwidth(tg, period, quota, burst);
>> +}
>> +
>>  static s64 cpu_cfs_quota_read_s64(struct cgroup_subsys_state *css,
>>                                   struct cftype *cft)
>>  {
>> @@ -7515,6 +7545,18 @@ static int cpu_cfs_period_write_u64(struct cgroup_subsys_state *css,
>>         return tg_set_cfs_period(css_tg(css), cfs_period_us);
>>  }
>>
>> +static u64 cpu_cfs_burst_read_u64(struct cgroup_subsys_state *css,
>> +                                 struct cftype *cft)
>> +{
>> +       return tg_get_cfs_burst(css_tg(css));
>> +}
>> +
>> +static int cpu_cfs_burst_write_u64(struct cgroup_subsys_state *css,
>> +                                  struct cftype *cftype, u64 cfs_burst_us)
>> +{
>> +       return tg_set_cfs_burst(css_tg(css), cfs_burst_us);
>> +}
>> +
>>  struct cfs_schedulable_data {
>>         struct task_group *tg;
>>         u64 period, quota;
>> @@ -7606,6 +7648,7 @@ static int cpu_cfs_stat_show(struct seq_file *sf, void *v)
>>         seq_printf(sf, "nr_periods %d\n", cfs_b->nr_periods);
>>         seq_printf(sf, "nr_throttled %d\n", cfs_b->nr_throttled);
>>         seq_printf(sf, "throttled_time %llu\n", cfs_b->throttled_time);
>> +       seq_printf(sf, "burst_time %llu\n", cfs_b->burst_time);
>>
>>         if (schedstat_enabled() && tg != &root_task_group) {
>>                 u64 ws = 0;
>> @@ -7667,6 +7710,11 @@ static struct cftype cpu_legacy_files[] = {
>>                 .read_u64 = cpu_cfs_period_read_u64,
>>                 .write_u64 = cpu_cfs_period_write_u64,
>>         },
>> +       {
>> +               .name = "cfs_burst_us",
>> +               .read_u64 = cpu_cfs_burst_read_u64,
>> +               .write_u64 = cpu_cfs_burst_write_u64,
>> +       },
>>         {
>>                 .name = "stat",
>>                 .seq_show = cpu_cfs_stat_show,
>> @@ -7709,15 +7757,20 @@ static int cpu_extra_stat_show(struct seq_file *sf,
>>                 struct task_group *tg = css_tg(css);
>>                 struct cfs_bandwidth *cfs_b = &tg->cfs_bandwidth;
>>                 u64 throttled_usec;
>> +               u64 burst_usec;
>>
>>                 throttled_usec = cfs_b->throttled_time;
>>                 do_div(throttled_usec, NSEC_PER_USEC);
>>
>> +               burst_usec = cfs_b->burst_time;
>> +               do_div(burst_usec, NSEC_PER_USEC);
>> +
>>                 seq_printf(sf, "nr_periods %d\n"
>>                            "nr_throttled %d\n"
>> -                          "throttled_usec %llu\n",
>> +                          "throttled_usec %llu\n"
>> +                          "burst_usec %llu\n",
>>                            cfs_b->nr_periods, cfs_b->nr_throttled,
>> -                          throttled_usec);
>> +                          throttled_usec, burst_usec);
>>         }
>>  #endif
>>         return 0;
>> @@ -7787,26 +7840,29 @@ static int cpu_weight_nice_write_s64(struct cgroup_subsys_state *css,
>>  #endif
>>
>>  static void __maybe_unused cpu_period_quota_print(struct seq_file *sf,
>> -                                                 long period, long quota)
>> +                                                 long period, long quota,
>> +                                                 long burst)
>>  {
>>         if (quota < 0)
>>                 seq_puts(sf, "max");
>>         else
>>                 seq_printf(sf, "%ld", quota);
>>
>> -       seq_printf(sf, " %ld\n", period);
>> +       seq_printf(sf, " %ld %ld\n", period, burst);
>>  }
>>
>>  /* caller should put the current value in *@periodp before calling */
>>  static int __maybe_unused cpu_period_quota_parse(char *buf,
>> -                                                u64 *periodp, u64 *quotap)
>> +                                                u64 *periodp, u64 *quotap,
>> +                                                s64 *burstp)
>>  {
>>         char tok[21];   /* U64_MAX */
>>
>> -       if (sscanf(buf, "%20s %llu", tok, periodp) < 1)
>> +       if (sscanf(buf, "%20s %llu %llu", tok, periodp, burstp) < 1)
>>                 return -EINVAL;
>>
>>         *periodp *= NSEC_PER_USEC;
>> +       *burstp *= NSEC_PER_USEC;
>>
>>         if (sscanf(tok, "%llu", quotap))
>>                 *quotap *= NSEC_PER_USEC;
>> @@ -7823,7 +7879,8 @@ static int cpu_max_show(struct seq_file *sf, void *v)
>>  {
>>         struct task_group *tg = css_tg(seq_css(sf));
>>
>> -       cpu_period_quota_print(sf, tg_get_cfs_period(tg), tg_get_cfs_quota(tg));
>> +       cpu_period_quota_print(sf, tg_get_cfs_period(tg), tg_get_cfs_quota(tg),
>> +                              tg_get_cfs_burst(tg));
>>         return 0;
>>  }
>>
>> @@ -7832,12 +7889,13 @@ static ssize_t cpu_max_write(struct kernfs_open_file *of,
>>  {
>>         struct task_group *tg = css_tg(of_css(of));
>>         u64 period = tg_get_cfs_period(tg);
>> +       s64 burst = tg_get_cfs_burst(tg);
>>         u64 quota;
>>         int ret;
>>
>> -       ret = cpu_period_quota_parse(buf, &period, &quota);
>> +       ret = cpu_period_quota_parse(buf, &period, &quota, &burst);
>>         if (!ret)
>> -               ret = tg_set_cfs_bandwidth(tg, period, quota);
>> +               ret = tg_set_cfs_bandwidth(tg, period, quota, burst);
>>         return ret ?: nbytes;
>>  }
>>  #endif
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 69a81a5709ff..f32b72496932 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -4353,16 +4353,26 @@ static inline u64 sched_cfs_bandwidth_slice(void)
>>  }
>>
>>  /*
>> - * Replenish runtime according to assigned quota. We use sched_clock_cpu
>> - * directly instead of rq->clock to avoid adding additional synchronization
>> - * around rq->lock.
>> + * Replenish runtime according to assigned quota.
>> + * Called only if quota != RUNTIME_INF.
>>   *
>>   * requires cfs_b->lock
>>   */
>>  void __refill_cfs_bandwidth_runtime(struct cfs_bandwidth *cfs_b)
>>  {
>> -       if (cfs_b->quota != RUNTIME_INF)
>> -               cfs_b->runtime = cfs_b->quota;
>> +       u64 runtime = cfs_b->runtime;
>> +
>> +       /*
>> +        * Preserve past runtime up to burst size. If remaining runtime lower
>> +        * than previous burst runtime then account delta as used burst time.
>> +        */
>> +       if (runtime > cfs_b->burst)
>> +               runtime = cfs_b->burst;
>> +       else if (runtime < cfs_b->burst_runtime)
>> +               cfs_b->burst_time += cfs_b->burst_runtime - runtime;
>> +
>> +       cfs_b->burst_runtime = runtime;
>> +       cfs_b->runtime = runtime + cfs_b->quota;
>>  }
>>
>>  static inline struct cfs_bandwidth *tg_cfs_bandwidth(struct task_group *tg)
>> @@ -4968,6 +4978,9 @@ void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
>>         cfs_b->runtime = 0;
>>         cfs_b->quota = RUNTIME_INF;
>>         cfs_b->period = ns_to_ktime(default_cfs_period());
>> +       cfs_b->burst = 0;
>> +       cfs_b->burst_runtime = 0;
>> +       cfs_b->burst_time = 0;
>>
>>         INIT_LIST_HEAD(&cfs_b->throttled_cfs_rq);
>>         hrtimer_init(&cfs_b->period_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED);
>> @@ -4986,14 +4999,23 @@ static void init_cfs_rq_runtime(struct cfs_rq *cfs_rq)
>>
>>  void start_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
>>  {
>> +       u64 overrun;
>> +
>>         lockdep_assert_held(&cfs_b->lock);
>>
>>         if (cfs_b->period_active)
>>                 return;
>>
>>         cfs_b->period_active = 1;
>> -       hrtimer_forward_now(&cfs_b->period_timer, cfs_b->period);
>> +       overrun = hrtimer_forward_now(&cfs_b->period_timer, cfs_b->period);
>>         hrtimer_start_expires(&cfs_b->period_timer, HRTIMER_MODE_ABS_PINNED);
>> +
>> +       /*
>> +        * Refill runtime for periods of inactivity and current.
>> +        * __refill_cfs_bandwidth_runtime() will cut excess.
>> +        */
>> +       cfs_b->runtime += cfs_b->quota * overrun;

Overflow in 584 years, even cpu-years, is probably fine. And we skip
refill on the period we stop the timer, so this isn't off by one, though
it might be worth mentioning that in the comment.

>> +       __refill_cfs_bandwidth_runtime(cfs_b);
>>  }
>>
>>  static void destroy_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
>> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
>> index c8870c5bd7df..6edf6155e4f6 100644
>> --- a/kernel/sched/sched.h
>> +++ b/kernel/sched/sched.h
>> @@ -344,10 +344,14 @@ struct cfs_bandwidth {
>>         struct hrtimer          slack_timer;
>>         struct list_head        throttled_cfs_rq;
>>
>> +       u64                     burst;
>> +       u64                     burst_runtime;
>> +
>>         /* Statistics: */
>>         int                     nr_periods;
>>         int                     nr_throttled;
>>         u64                     throttled_time;
>> +       u64                     burst_time;
>>  #endif
>>  };
>>
>>
