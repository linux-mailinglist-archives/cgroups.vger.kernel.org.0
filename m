Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5120933CBCB
	for <lists+cgroups@lfdr.de>; Tue, 16 Mar 2021 04:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234783AbhCPDPr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 15 Mar 2021 23:15:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41030 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234787AbhCPDP1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 15 Mar 2021 23:15:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615864527;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PgTYgUrUjzuxenxAnT33mXHPaYITveEH9VmNhTwLT9M=;
        b=NqVT9RHENRggJAIjd3vRujEcQMIuz/MAv/1h4mRyWQEf93Axih9NS0m8UjIH4mJ78dx27U
        v2ShXygmlQxBerjozZI8rcoyUasoLTL13DV12OSTVQWxIBadNYepcDbqvYJvpG9NJ++Hff
        0OW4GKG7vsnIWBRKEOKbWEIk1N8poq4=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-Toi85VP-M_GGaNF_ld7niw-1; Mon, 15 Mar 2021 23:15:25 -0400
X-MC-Unique: Toi85VP-M_GGaNF_ld7niw-1
Received: by mail-lf1-f71.google.com with SMTP id k7so10993317lfu.6
        for <cgroups@vger.kernel.org>; Mon, 15 Mar 2021 20:15:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PgTYgUrUjzuxenxAnT33mXHPaYITveEH9VmNhTwLT9M=;
        b=prRENCHkUZLzqe+rwf0zZpd2QK/VNODkwcinyF+qL80jwXXmkNtnSiH4pZsTVDCYQU
         vnybsSCGe+gej7IPXrpHaMFaE6fBe5GezHwxiPjqvnow7yk0b3AlC4/KNy96hbiHLPqa
         b0xNVXZ6u2mkEVKDYcH3ymFdsQe3yD9EiOoMAiRIFAF+RiiEFyYzKwoux4MFHq4lTKas
         nSEeijAWtW+9Vn+ZJl7xavfUQukDyqBl9sJaspMYUNI8P4yb1A80+8u/tSJgImoQLEKT
         fAIqeQ6TNmCn/0uTSDDwhQ0qVNMlAb2SXG/nCrX6cloWaD4vdi/x9pRt5VCNKrlTtgKc
         Srow==
X-Gm-Message-State: AOAM533u9gCe3r/EVDGyNhOSYC6h9ZluLtaZ0ddfQegB+ZCJOcKKTS19
        6MzItylaXs/wVN4xLNczRL7dlORn+e+VnWH7+0ySzAeuWQUCsEAxHbpnoR3tFPlsZAIhvCDvD88
        /i3b3woaTRX1Qn6V/d1SFFSumFYnUhz9hyQ==
X-Received: by 2002:a2e:a589:: with SMTP id m9mr1310335ljp.220.1615864524179;
        Mon, 15 Mar 2021 20:15:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy8GVef0pvRwnjXlP4GVMVTLsoaiiwG+ahQbgzLn7YS1nkkz8+pVl94NB3DrYiAdcLeHC3d9+eF9e+rVjKvgLs=
X-Received: by 2002:a2e:a589:: with SMTP id m9mr1310315ljp.220.1615864523919;
 Mon, 15 Mar 2021 20:15:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210212003032.2037750-1-aklimov@redhat.com> <87tuqhrs3d.fsf@oracle.com>
In-Reply-To: <87tuqhrs3d.fsf@oracle.com>
From:   Alexey Klimov <aklimov@redhat.com>
Date:   Tue, 16 Mar 2021 03:15:13 +0000
Message-ID: <CAFBcO+99Ax5MuOtzNx=NrmnUN=+913Sc-DV83ObOi01A=kkN3w@mail.gmail.com>
Subject: Re: [PATCH v2] cpu/hotplug: wait for cpuset_hotplug_work to finish on
 cpu onlining
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>, yury.norov@gmail.com,
        tglx@linutronix.de, Joshua Baker <jobaker@redhat.com>,
        audralmitchel@gmail.com, arnd@arndb.de, gregkh@linuxfoundation.org,
        rafael@kernel.org, tj@kernel.org,
        Qais Yousef <qais.yousef@arm.com>, hannes@cmpxchg.org,
        Alexey Klimov <klimov.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Feb 12, 2021 at 7:42 PM Daniel Jordan
<daniel.m.jordan@oracle.com> wrote:
>
> Alexey Klimov <aklimov@redhat.com> writes:
> > int cpu_device_up(struct device *dev)
>
> Yeah, definitely better to do the wait here.
>
> >  int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval)
> >  {
> > -     int cpu, ret = 0;
> > +     struct device *dev;
> > +     cpumask_var_t mask;
> > +     int cpu, ret;
> > +
> > +     if (!zalloc_cpumask_var(&mask, GFP_KERNEL))
> > +             return -ENOMEM;
> >
> > +     ret = 0;
> >       cpu_maps_update_begin();
> >       for_each_online_cpu(cpu) {
> >               if (topology_is_primary_thread(cpu))
> > @@ -2099,18 +2098,35 @@ int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval)
> >                * called under the sysfs hotplug lock, so it is properly
> >                * serialized against the regular offline usage.
> >                */
> > -             cpuhp_offline_cpu_device(cpu);
> > +             dev = get_cpu_device(cpu);
> > +             dev->offline = true;
> > +
> > +             cpumask_set_cpu(cpu, mask);
> >       }
> >       if (!ret)
> >               cpu_smt_control = ctrlval;
> >       cpu_maps_update_done();
> > +
> > +     /* Tell user space about the state changes */
> > +     for_each_cpu(cpu, mask) {
> > +             dev = get_cpu_device(cpu);
> > +             kobject_uevent(&dev->kobj, KOBJ_OFFLINE);
> > +     }
> > +
> > +     free_cpumask_var(mask);
> >       return ret;
> >  }
>
> Hrm, should the dev manipulation be kept in one place, something like
> this?

The first section of comment seems problematic to me with regards to such move:

                 * As this needs to hold the cpu maps lock it's impossible
                 * to call device_offline() because that ends up calling
                 * cpu_down() which takes cpu maps lock. cpu maps lock
                 * needs to be held as this might race against in kernel
                 * abusers of the hotplug machinery (thermal management).

Cpu maps lock is released in cpu_maps_update_done() hence we will move
dev->offline out of cpu maps lock. Maybe I misunderstood the comment
and it relates to calling cpu_down_maps_locked() under lock to avoid
race?
I failed to find the abusers of hotplug machinery in drivers/thermal/*
to track down the logic of potential race but I might have overlooked.
Anyway, if we move the update of dev->offline out, then it makes sense
to restore cpuhp_{offline,online}_cpu_device back and just use it.

I guess I'll update and re-send the patch and see how it goes.

> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index 8817ccdc8e112..aa21219a7b7c4 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -2085,11 +2085,20 @@ int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval)
>                 ret = cpu_down_maps_locked(cpu, CPUHP_OFFLINE);
>                 if (ret)
>                         break;
> +
> +               cpumask_set_cpu(cpu, mask);
> +       }
> +       if (!ret)
> +               cpu_smt_control = ctrlval;
> +       cpu_maps_update_done();
> +
> +       /* Tell user space about the state changes */
> +       for_each_cpu(cpu, mask) {
>                 /*
> -                * As this needs to hold the cpu maps lock it's impossible
> +                * When the cpu maps lock was taken above it was impossible
>                  * to call device_offline() because that ends up calling
>                  * cpu_down() which takes cpu maps lock. cpu maps lock
> -                * needs to be held as this might race against in kernel
> +                * needed to be held as this might race against in kernel
>                  * abusers of the hotplug machinery (thermal management).
>                  *
>                  * So nothing would update device:offline state. That would

Yeah, reading how you re-phrased it, this seems to be about
cpu_down_maps_locked()/device_offline() locks and race rather than
updating stale dev->offline.

Thank you,
Alexey

