Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAB28353632
	for <lists+cgroups@lfdr.de>; Sun,  4 Apr 2021 04:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236621AbhDDCcc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 3 Apr 2021 22:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236618AbhDDCcc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 3 Apr 2021 22:32:32 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4E2C061756;
        Sat,  3 Apr 2021 19:32:28 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id b7so12375921ejv.1;
        Sat, 03 Apr 2021 19:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mGIO7iIpzBw1oWn4ob5KXQ2omWEkooKBwstKijxEksQ=;
        b=dnBJ98Hp46aSMW13iq15r7Q5udtHpgq2+aCa6XFAPBB9dURclb7S64EdgJJJbb+mrl
         QsMptzHBxUaFaHp51Qgt3acPBAhU6M3dFh2au9mDWrG8kA51p5w924zo0nOzuhdxnjbB
         7b1KOz5Oe5MJXnrctseMc4L1/juNdiRqyz0BSxu0PeYDLRDuIs5xLn8HzXIg2lNaM2GD
         K2Q0jbw+shE04TJO8lA99MIg/iQdF92OZZ9nWmsymFsqMovOHNxx51TB7LFRTK3+Wg+1
         x2CLXnVm5RjePqVi0z/GXstcEybBUAcsf3R2nLIh2kqo9RoV0ktAhflhJhAg6K2BEF1h
         89JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mGIO7iIpzBw1oWn4ob5KXQ2omWEkooKBwstKijxEksQ=;
        b=smm/BSt5e6DQkUIBMCj+RHok/ESozIFxocakGDr+/va68FiFrh+aKb9YjUqSg3+/4t
         Xq5cmEQ/Qg7uPf4U0jbg5+S/IFZdTcLLTG3ZLjQSzNykIh5MznvqJ2pkU7xA9Ex0AHVL
         /4JEEJY06SqjWs2RSP8rUoofeRq6PdahtTDYjPT/skWJr+sjby9BciCUd+JDVereEzrA
         CwMTvzasIGnLS5kk5AuaVEowImVGS1vHpBAfCSAAvaGnskW4f1ta5mK5EvQ1H6/znoz8
         Ve2aYbtccyhkFMLoXjluqS51sppHcfrEh6jP0xhy4xVwbGDv4ckh6u8ljojnAqeYqmyM
         TpMA==
X-Gm-Message-State: AOAM531kXO/kVwOKWlrI7MK/N++s46nkYVeVqb+Y3VfOxb2BNnxGmaRl
        pFUSTFUMknTaS6XQHEJuZCACigElgq0q3I3VQPOMbuQHOyzv1w==
X-Google-Smtp-Source: ABdhPJwB8WlOwVHCSu2DqPIn7ciXmMx4dUgCfD78COqD1AVvLIyMPCXP+I+31dV1sXiLg02EHeQMNnQroeNACAnjJEE=
X-Received: by 2002:a17:906:7cc:: with SMTP id m12mr21000865ejc.171.1617503547171;
 Sat, 03 Apr 2021 19:32:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210317003616.2817418-1-aklimov@redhat.com> <87tuowcnv3.ffs@nanos.tec.linutronix.de>
In-Reply-To: <87tuowcnv3.ffs@nanos.tec.linutronix.de>
From:   Alexey Klimov <klimov.linux@gmail.com>
Date:   Sun, 4 Apr 2021 03:32:16 +0100
Message-ID: <CALW4P+L9_tYgfOPv0riWWnv54HPhKPDJ4EK4yYaWsz0MdDGqfw@mail.gmail.com>
Subject: Re: [PATCH v3] cpu/hotplug: wait for cpuset_hotplug_work to finish on
 cpu onlining
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Alexey Klimov <aklimov@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        cgroups@vger.kernel.org, peterz@infradead.org,
        Yury Norov <yury.norov@gmail.com>, daniel.m.jordan@oracle.com,
        jobaker@redhat.com, audralmitchel@gmail.com,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rafael@kernel.org, tj@kernel.org, qais.yousef@arm.com,
        hannes@cmpxchg.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Mar 27, 2021 at 9:01 PM Thomas Gleixner <tglx@linutronix.de> wrote:

Lovely that you eventually found time to take a look at this since
first RFC patch was sent.

> Alexey,
>
> On Wed, Mar 17 2021 at 00:36, Alexey Klimov wrote:
> > When a CPU offlined and onlined via device_offline() and device_online()
> > the userspace gets uevent notification. If, after receiving "online" uevent,
> > userspace executes sched_setaffinity() on some task trying to move it
> > to a recently onlined CPU, then it sometimes fails with -EINVAL. Userspace
> > needs to wait around 5..30 ms before sched_setaffinity() will succeed for
> > recently onlined CPU after receiving uevent.
> >
> > Cpusets used in guarantee_online_cpus() are updated using workqueue from
> > cpuset_update_active_cpus() which in its turn is called from cpu hotplug callback
> > sched_cpu_activate() hence it may not be observable by sched_setaffinity() if
> > it is called immediately after uevent.
>
> And because cpusets are using a workqueue just to deal with their
> backwards lock order we need to cure the symptom in the CPU hotplug
> code, right?

Feel free to suggest a better place.

> > Out of line uevent can be avoided if we will ensure that cpuset_hotplug_work
> > has run to completion using cpuset_wait_for_hotplug() after onlining the
> > cpu in cpu_device_up() and in cpuhp_smt_enable().
>
> It can also be avoided by fixing the root cause which is _NOT_ in the
> CPU hotplug code at all.
>
> The fundamental assumption of CPU hotplug is that if the state machine
> reaches a given state, which might have user space visible effects or
> even just kernel visible effects, the overall state of the system has to
> be consistent.
>
> cpusets violate this assumption. And they do so since 2013 due to commit
> 3a5a6d0c2b03("cpuset: don't nest cgroup_mutex inside get_online_cpus()").
>
> If that cannot be fixed in cgroups/cpusets with out rewriting the whole
> cpusets/cgroups muck, then this want's to be explained and justified in the
> changelog.
>
> Looking at the changelog of 3a5a6d0c2b03 it's entirely clear that this
> is non trivial because that changelog clearly states that the lock order
> is a design decision and that design decision required that workqueue
> workaround....
>
> See? Now we suddenly have a proper root cause and not just a description
> of the symptom with some hidden hint about workqueues. And we have an
> argument why fixing the root cause is close to impossible.

Thank you for this educational scolding here and below. I see that
problem here is more fundamental than I thought before and my commit
messages standards are too low for you.
Good to see that bug that may exist since 2013 could be fixed finally.

> >  int cpu_device_up(struct device *dev)
> >  {
> > -     return cpu_up(dev->id, CPUHP_ONLINE);
> > +     int err;
> > +
> > +     err = cpu_up(dev->id, CPUHP_ONLINE);
> > +     /*
> > +      * Wait for cpuset updates to cpumasks to finish.  Later on this path
> > +      * may generate uevents whose consumers rely on the updates.
> > +      */
> > +     if (!err)
> > +             cpuset_wait_for_hotplug();
>
> No. Quite some people wasted^Wspent a considerable amount of time to get
> the hotplug trainwreck cleaned up and we are not sprinkling random
> workarounds all over the place again.
>
> >  int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval)
> >  {
> > -     int cpu, ret = 0;
> > +     cpumask_var_t mask;
> > +     int cpu, ret;
> >
> > +     if (!zalloc_cpumask_var(&mask, GFP_KERNEL))
> > +             return -ENOMEM;
> > +
> > +     ret = 0;
> >       cpu_maps_update_begin();
> >       for_each_online_cpu(cpu) {
> >               if (topology_is_primary_thread(cpu))
> > @@ -2093,31 +2109,42 @@ int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval)
> >               ret = cpu_down_maps_locked(cpu, CPUHP_OFFLINE);
> >               if (ret)
> >                       break;
> > -             /*
> > -              * As this needs to hold the cpu maps lock it's impossible
> > -              * to call device_offline() because that ends up calling
> > -              * cpu_down() which takes cpu maps lock. cpu maps lock
> > -              * needs to be held as this might race against in kernel
> > -              * abusers of the hotplug machinery (thermal management).
> > -              *
> > -              * So nothing would update device:offline state. That would
> > -              * leave the sysfs entry stale and prevent onlining after
> > -              * smt control has been changed to 'off' again. This is
> > -              * called under the sysfs hotplug lock, so it is properly
> > -              * serialized against the regular offline usage.
> > -              */
> > -             cpuhp_offline_cpu_device(cpu);
> > +
> > +             cpumask_set_cpu(cpu, mask);
> >       }
> >       if (!ret)
> >               cpu_smt_control = ctrlval;
> >       cpu_maps_update_done();
> > +
> > +     /*
> > +      * When the cpu maps lock was taken above it was impossible
> > +      * to call device_offline() because that ends up calling
> > +      * cpu_down() which takes cpu maps lock. cpu maps lock
> > +      * needed to be held as this might race against in-kernel
> > +      * abusers of the hotplug machinery (thermal management).
> > +      *
> > +      * So nothing would update device:offline state. That would
> > +      * leave the sysfs entry stale and prevent onlining after
> > +      * smt control has been changed to 'off' again. This is
> > +      * called under the sysfs hotplug lock, so it is properly
> > +      * serialized against the regular offline usage.
> > +      */
> > +     for_each_cpu(cpu, mask)
> > +             cpuhp_offline_cpu_device(cpu);
> > +
> > +     free_cpumask_var(mask);
> >       return ret;
>
> Brilliant stuff that. All this does is to move the uevent out of the cpu
> maps locked region. What for? There is no wait here? Why?

To match cpuhp_smt_enable().

> The work is scheduled whenever the active state of a CPU is changed. And
> just because on unplug it's not triggering any test program failure
> (yet) does not make it more correct. The uevent is again delivered
> before consistent state is reached.
>
> And to be clear, it's not about uevent at all. That's the observable
> side of it.
>
> The point is that the state is inconsistent when the hotplug functions
> return. That's the only really interesting statement here.
>
> And while you carefully reworded the comment, did you actually read what
> it said and what is says now?
>
> > -              * cpu_down() which takes cpu maps lock. cpu maps lock
> > -              * needs to be held as this might race against in kernel
> > -              * abusers of the hotplug machinery (thermal management).
>
> vs.
>
> > +      * cpu_down() which takes cpu maps lock. cpu maps lock
> > +      * needed to be held as this might race against in-kernel
> > +      * abusers of the hotplug machinery (thermal management).
>
> The big fat hint is: "cpu maps lock needs to be held as this ...." and
> it still needs to be held for the above loop to work correctly at
> all. See also below.
>
> So just moving comments blindly around and making them past tense is not
> cutting it. Quite the contrary the comments make no sense anymore. They
> became uncomprehensible word salad.

My bad.

Why while you're on this I need to ask one question about:
* ...cpu maps lock
* needs to be held as this might race against in kernel
* abusers of the hotplug machinery (thermal management).

Who are the abusers of hotplug from the thermal management side?
I spent (wasted) a considerable amount of time searching for them in
drivers/thermal/* but nothing seemed suspicious.

> Now for the second part of that comment:
>
> > +      *                                          ....  This is
> > +      * called under the sysfs hotplug lock, so it is properly
> > +      * serialized against the regular offline usage.
>
> So there are two layers of protection:
>
>    cpu_maps_lock and sysfs hotplug lock
>
> One protects surprisingly against concurrent sysfs writes and the other
> is required to serialize in kernel usage.
>
> Now lets look at the original protection:
>
>    lock(sysfs)
>      lock(cpu_maps)
>        hotplug
>         dev->offline = new_state
>         uevent()
>      unlock(cpu_maps)
>    unlock(sysfs)
>
> and the one you created:
>
>    lock(sysfs)
>      lock(cpu_maps)
>        hotplug
>      unlock(cpu_maps)
>      dev->offline = new_state
>      uevent()
>    unlock(sysfs)
>
> Where is that protection scope change mentioned in the change log and
> where is the analysis that it is correct?

It was not mentioned in commit messages. It was mentioned in the place
that describes changes between different versions of the patch.
There is already a place in device_online() and device_offline() where
uevent() is sent under lock(sysfs) lock only (in your notation) and
outside cpu_maps lock (the same goes for dev->offline status). IIRC
that's why I didn't explain it specifically.
Will do better in future.

> Now you also completely fail to explain _why_ the uevent and the
> wait_for() muck have to be done _outside_ of the cpu maps locked region.

That's correct: there is no explanation.
Before it became more fundamental and about consistency of hotplug
state, this was done to perform one cpusets_wait_for_hotplug() after
all hotplug calls rather than doing cpusets_wait_for_hotplug() for
each individual cpu_up/cpu_down.

> workqueues and cpusets/cgroups have exactly zero lock relationship to
> the map lock.
>
> The actual problematic lock nesting is
>
>     cgroup_mutex -> cpu_hotplug_lock
>
> and for the hotplug synchronous case this turns into
>
>     cpu_hotplug_lock -> cgroup_mutex
>
> which is an obvious deadlock.
>
> So the only requirement is to avoid _that_ particular lock nesting, but
> having:
>
>     cpu_add_remove_lock -> cpu_hotplug_lock
>
> and
>
>     cpu_add_remove_lock -> cgroup_mutex -> cpu_hotplug_lock
>
> which is built via waiting on the work to finish is perfectly fine.
>
> Waiting under cpu_add_remove_lock is also perfectly fine and there are
> other things in the hotplug callbacks which wait on stuff for way
> longer.
>
> Which in turn points to the obvious spots to add the required _two_ lines
> of code which solve this without creating an unholy mess and sprinkling
> that call all over the place.
>
>  _cpu_up()
>  {
>         ...
>         cpus_write_unlock(); <- Drops cpu_hotplug_lock
>         ...
> +       if (!tasks_frozen)
> +               cpusets_wait_for_hotplug();
>         return ret;
>
> And the same for _cpu_down(), which obviously begs for a helper
> function, which in turn needs tons of comments to explain why that place
> is not a dump ground for random hacks of the day and what might if at
> all be justified to be called there along with the implications of that
>
> But that's a documentation thing, which would also be necessary when the
> requirement would be to move it outside of cpu_add_remove_lock.
>
> And none of this has anything to do with uevents.
>
> Thanks,
>
>         tglx
> ---
> Subject: cpu/hotplug: Cure the cpusets trainwreck
> From: Thomas Gleixner <tglx@linutronix.de>
> Date: Sat, 27 Mar 2021 15:57:29 +0100
>
> Alexey and Joshua tried to solve a cpusets related hotplug problem which is
> user space visible and results in unexpected behaviour for some time after
> a CPU has been plugged in and the corresponding uevent was delivered.

I'll give it a go and get back to you. It seems this patch should work.

[...]

Best regards,
Alexey Klimov.
