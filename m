Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 026CEFDB2
	for <lists+cgroups@lfdr.de>; Tue, 30 Apr 2019 18:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbfD3QVB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 30 Apr 2019 12:21:01 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45580 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbfD3QVA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 30 Apr 2019 12:21:00 -0400
Received: by mail-lf1-f65.google.com with SMTP id t11so11197660lfl.12
        for <cgroups@vger.kernel.org>; Tue, 30 Apr 2019 09:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7LFX4m6Lt3Fkpbl5tbdO/OCAW/j54g5f6sgRiV7eIds=;
        b=PlflccedOJwtsDcIZGqT2n6aDF1/5ZVOTQ2Xi1/qXc2hCdqTWY6ATSZn01TGmx3NYX
         d9eYGo11mf3Fvgc+ryS5hZ2vdU2eh6hENLQXatdcLr3wkvNVhqF6ysiEZBdlS9S632Z2
         ikpDdN57shcZTvPxpk175ctfhZ7f99+2fnhiBTIAMDy/ftfOY01E21PyBKbMn3m3/iSE
         ICHn/tVb6l5PrQujWHs09VQJVmXKfeBWrPSTU06X85T7UUNILvnVblVeER7akFJlZAsP
         6HSmrCjF6z/dkwXWXN0QAwQ85g4E/danUjkPNm6tE5mQGzS9YrRu4JOn2ISTioIk7ObY
         1mDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7LFX4m6Lt3Fkpbl5tbdO/OCAW/j54g5f6sgRiV7eIds=;
        b=cgchS63g8V8HXXGwC/LNcFmGhq4bvgCJRIUk6xXWB5xm/EX97HjVJX/Lj2nSan2jHr
         Ifd1/AKbURWYAw245imaOI2fE+EqZmQWmumIWFSZ/2/Tip71bA4x5YhyV0LJQK9AQnWL
         8DJT479GM+2PfpRdggKdH7eZX2BjNTz59WLjNwYeqIoueaMbKhC+1Oz9EQuXhHMfBVZP
         mypEtCJBwCkZcsjOemfbFBlOPsyCf7ozjZ8Ea+TEHlRmLy8sf6PPtc6P/mcy6d+lkX5G
         J5dbKyYolixo9mDPXp+YZJVf5mvsjjgCLon5GoMRh2q6nevYj4ap4Wvy2qWJOMLzlnit
         lJtQ==
X-Gm-Message-State: APjAAAV/AD0o1Kwdlcv2ozy4mckTd+YoGL9BlUXbWBM13VFPsFYe1jxQ
        eqclm6lMuOYNSjrAqRWe2ctF8maUi9SDTTsznc7biw==
X-Google-Smtp-Source: APXvYqwrbF5g3W+Lo2P1gvUFBtaVpkJNclSwI4AdhLaUElIUvqJDcP52COWBkS1vL/vehNKKQfMHhcZUeYaQTA6OXR4=
X-Received: by 2002:a19:7005:: with SMTP id h5mr10850848lfc.143.1556641258150;
 Tue, 30 Apr 2019 09:20:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190408214539.2705660-1-songliubraving@fb.com>
 <20190410115907.GE19434@e105550-lin.cambridge.arm.com> <A2E9A149-9EAA-478D-A096-1D4D4BA442B3@fb.com>
 <CAKfTPtAFB3gSZYJN1BcjU_XoY=Pfu2xtea+2MEw7FkVc3mwTSA@mail.gmail.com>
 <E97E73F4-CE8C-4CD7-B6B6-5F63A4E881B1@fb.com> <F0A127DD-F9B6-4FBE-B9AD-8E8B00A7D676@fb.com>
 <CAKfTPtA_ouYCes9LnYn0quAKm273mi3vP-++GTBtYcQn07xc6Q@mail.gmail.com> <A62E5068-4A1E-44E3-99BB-02E98229C1E2@fb.com>
In-Reply-To: <A62E5068-4A1E-44E3-99BB-02E98229C1E2@fb.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 30 Apr 2019 18:20:46 +0200
Message-ID: <CAKfTPtAG3v=37wyLjzkNNK_6HdoMK6WO7AMYfa+G24rq2iyAfg@mail.gmail.com>
Subject: Re: [PATCH 0/7] introduce cpu.headroom knob to cpu controller
To:     Song Liu <songliubraving@fb.com>
Cc:     Morten Rasmussen <morten.rasmussen@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        Kernel Team <Kernel-team@fb.com>,
        viresh kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Song,

On Tue, 30 Apr 2019 at 08:11, Song Liu <songliubraving@fb.com> wrote:
>
>
>
> > On Apr 29, 2019, at 8:24 AM, Vincent Guittot <vincent.guittot@linaro.org> wrote:
> >
> > Hi Song,
> >
> > On Sun, 28 Apr 2019 at 21:47, Song Liu <songliubraving@fb.com> wrote:
> >>
> >> Hi Morten and Vincent,
> >>
> >>> On Apr 22, 2019, at 6:22 PM, Song Liu <songliubraving@fb.com> wrote:
> >>>
> >>> Hi Vincent,
> >>>
> >>>> On Apr 17, 2019, at 5:56 AM, Vincent Guittot <vincent.guittot@linaro.org> wrote:
> >>>>
> >>>> On Wed, 10 Apr 2019 at 21:43, Song Liu <songliubraving@fb.com> wrote:
> >>>>>
> >>>>> Hi Morten,
> >>>>>
> >>>>>> On Apr 10, 2019, at 4:59 AM, Morten Rasmussen <morten.rasmussen@arm.com> wrote:
> >>>>>>
> >>>>
> >>>>>>
> >>>>>> The bit that isn't clear to me, is _why_ adding idle cycles helps your
> >>>>>> workload. I'm not convinced that adding headroom gives any latency
> >>>>>> improvements beyond watering down the impact of your side jobs. AFAIK,
> >>>>>
> >>>>> We think the latency improvements actually come from watering down the
> >>>>> impact of side jobs. It is not just statistically improving average
> >>>>> latency numbers, but also reduces resource contention caused by the side
> >>>>> workload. I don't know whether it is from reducing contention of ALUs,
> >>>>> memory bandwidth, CPU caches, or something else, but we saw reduced
> >>>>> latencies when headroom is used.
> >>>>>
> >>>>>> the throttling mechanism effectively removes the throttled tasks from
> >>>>>> the schedule according to a specific duty cycle. When the side job is
> >>>>>> not throttled the main workload is experiencing the same latency issues
> >>>>>> as before, but by dynamically tuning the side job throttling you can
> >>>>>> achieve a better average latency. Am I missing something?
> >>>>>>
> >>>>>> Have you looked at your distribution of main job latency and tried to
> >>>>>> compare with when throttling is active/not active?
> >>>>>
> >>>>> cfs_bandwidth adjusts allowed runtime for each task_group each period
> >>>>> (configurable, 100ms by default). cpu.headroom logic applies gentle
> >>>>> throttling, so that the side workload gets some runtime in every period.
> >>>>> Therefore, if we look at time window equal to or bigger than 100ms, we
> >>>>> don't really see "throttling active time" vs. "throttling inactive time".
> >>>>>
> >>>>>>
> >>>>>> I'm wondering if the headroom solution is really the right solution for
> >>>>>> your use-case or if what you are really after is something which is
> >>>>>> lower priority than just setting the weight to 1. Something that
> >>>>>
> >>>>> The experiments show that, cpu.weight does proper work for priority: the
> >>>>> main workload gets priority to use the CPU; while the side workload only
> >>>>> fill the idle CPU. However, this is not sufficient, as the side workload
> >>>>> creates big enough contention to impact the main workload.
> >>>>>
> >>>>>> (nearly) always gets pre-empted by your main job (SCHED_BATCH and
> >>>>>> SCHED_IDLE might not be enough). If your main job consist
> >>>>>> of lots of relatively short wake-ups things like the min_granularity
> >>>>>> could have significant latency impact.
> >>>>>
> >>>>> cpu.headroom gives benefits in addition to optimizations in pre-empt
> >>>>> side. By maintaining some idle time, fewer pre-empt actions are
> >>>>> necessary, thus the main workload will get better latency.
> >>>>
> >>>> I agree with Morten's proposal, SCHED_IDLE should help your latency
> >>>> problem because side job will be directly preempted unlike normal cfs
> >>>> task even lowest priority.
> >>>> In addition to min_granularity, sched_period also has an impact on the
> >>>> time that a task has to wait before preempting the running task. Also,
> >>>> some sched_feature like GENTLE_FAIR_SLEEPERS can also impact the
> >>>> latency of a task.
> >>>>
> >>>> It would be nice to know if the latency problem comes from contention
> >>>> on cache resources or if it's mainly because you main load waits
> >>>> before running on a CPU
> >>>>
> >>>> Regards,
> >>>> Vincent
> >>>
> >>> Thanks for these suggestions. Here are some more tests to show the impact
> >>> of scheduler knobs and cpu.headroom.
> >>>
> >>> side-load | cpu.headroom | side/cpu.weight | min_gran | cpu-idle | main/latency
> >>> --------------------------------------------------------------------------------
> >>> none    |      0       |     n/a         |    1 ms  |  45.20%  |   1.00
> >>> ffmpeg   |      0       |      1          |   10 ms  |   3.38%  |   1.46
> >>> ffmpeg   |      0       |   SCHED_IDLE    |    1 ms  |   5.69%  |   1.42
> >>> ffmpeg   |    20%       |   SCHED_IDLE    |    1 ms  |  19.00%  |   1.13
> >>> ffmpeg   |    30%       |   SCHED_IDLE    |    1 ms  |  27.60%  |   1.08
> >>>
> >>> In all these cases, the main workload is loaded with same level of
> >>> traffic (request per second). Main workload latency numbers are normalized
> >>> based on the baseline (first row).
> >>>
> >>> For the baseline, the main workload runs without any side workload, the
> >>> system has about 45.20% idle CPU.
> >>>
> >>> The next two rows compare the impact of scheduling knobs cpu.weight and
> >>> sched_min_granularity. With cpu.weight of 1 and min_granularity of 10ms,
> >>> we see a latency of 1.46; with SCHED_IDLE and min_granularity of 1ms, we
> >>> see a latency of 1.42. So SCHED_IDLE and min_granularity help protecting
> >>> the main workload. However, it is not sufficient, as the latency overhead
> >>> is high (>40%).
> >>>
> >>> The last two rows show the benefit of cpu.headroom. With 20% headroom,
> >>> the latency is 1.13; while with 30% headroom, the latency is 1.08.
> >>>
> >>> We can also see a clear correlation between latency and global idle CPU:
> >>> more idle CPU yields better lower latency.
> >>>
> >>> Over all, these results show that cpu.headroom provides effective
> >>> mechanism to control the latency impact of side workloads. Other knobs
> >>> could also help the latency, but they are not as effective and flexible
> >>> as cpu.headroom.
> >>>
> >>> Does this analysis address your concern?
> >
> > So, you results show that sched_idle class doesn't provide the
> > intended behavior because it still delay the scheduling of sched_other
> > tasks. In fact, the wakeup path of the scheduler doesn't make any
> > difference between a cpu running a sched_other and a cpu running a
> > sched_idle when looking for the idlest cpu and it can create some
> > contentions between sched_other tasks whereas a cpu runs sched_idle
> > task.
>
> I don't think scheduling delay is the only (or dominating) factor of
> extra latency. Here are some data to show it.
>
> I measured IPC (instructions per cycle) of the main workload under
> different scenarios:
>
> side-load | cpu.headroom | side/cpu.weight  | IPC
> ----------------------------------------------------
>  none     |     0%       |       N/A        | 0.66
>  ffmpeg   |     0%       |    SCHED_IDLE    | 0.53
>  ffmpeg   |    20%       |    SCHED_IDLE    | 0.58
>  ffmpeg   |    30%       |    SCHED_IDLE    | 0.62
>
> These data show that the side workload has a negative impact on the
> main workload's IPC. And cpu.headroom could help reduce this impact.
>
> Therefore, while optimizations in the wakeup path should help the
> latency; cpu.headroom would add _significant_ benefit on top of that.

It seems normal that side workload has a negative impact on IPC
because of resources sharing but your previous results showed a 42%
regression of latency with sched_idle which is can't be only linked to
resources access contention

>
> Does this assessment make sense?
>
>
> > Viresh (cced to this email) is working on improving such behavior at
> > wake up and has sent an patch related to the subject:
> > https://lkml.org/lkml/2019/4/25/251
> > I'm curious if this would improve the results.
>
> I could try it with our workload next week (I am at LSF/MM this
> week). Also, please keep in mind that this test sometimes takes
> multiple days to setup and run.

Yes. I understand. That would be good to have a simpler setup to
reproduce the behavior of your setup in order to do preliminary tests
and analyse the behavior

>
> Thanks,
> Song
>
> >
> > Regards,
> > Vincent
> >
> >>>
> >>> Thanks,
> >>> Song
> >>>
> >>
> >> Could you please share your comments and suggestions on this work? Did
> >> the results address your questions/concerns?
> >>
> >> Thanks again,
> >> Song
> >>
> >>>>
> >>>>>
> >>>>> Thanks,
> >>>>> Song
> >>>>>
> >>>>>>
> >>>>>> Morten
>
