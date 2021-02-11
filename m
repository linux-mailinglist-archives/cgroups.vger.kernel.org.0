Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00B3D318C50
	for <lists+cgroups@lfdr.de>; Thu, 11 Feb 2021 14:44:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbhBKNnC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 11 Feb 2021 08:43:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27186 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231484AbhBKNkf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 11 Feb 2021 08:40:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613050746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JGimXPuqcoE+a6jS2uYizeEDGioIlqVcs0oa7fVjFEs=;
        b=eoOKuVQuUlbULVHDfyhDPJGOLDvCYnOKY+bibZBgGRcTJRW9HgZUZv4FVW8JoJAFOqKs1T
        Ymw/lREW35uPn5ivZxr2v5ky1drRaxx+AEAVxD+Jdmz7hk+rV2zbRn2zxPGaMROophzM5D
        ZAwwHtZydPWvM0HEtb7cScGiZNE0Hbs=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-516-k_Bi1eU_PxKYJpi1XGEWoA-1; Thu, 11 Feb 2021 08:39:04 -0500
X-MC-Unique: k_Bi1eU_PxKYJpi1XGEWoA-1
Received: by mail-lf1-f69.google.com with SMTP id x10so1514446lfu.22
        for <cgroups@vger.kernel.org>; Thu, 11 Feb 2021 05:39:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JGimXPuqcoE+a6jS2uYizeEDGioIlqVcs0oa7fVjFEs=;
        b=DrYSgUNBcdDzjKqBhSBKAcjYjNfJjSa5Dz2SyEVEPwmHAqlGmvH4HCVytYiNelAU5n
         1xxj/KBd5SBwF9+SQG4Y74Zu+vk1Qj1IMNAJSzGhTeVWaT45FXoL8noLCHBJ0PQcQxyc
         0YqgfLA2wvwRXglR6YzsCmz1pnGfhqssCABZrwxNhkgQ1f0uEXEJA56b6HOcMgc7wprr
         LZui0RQB5yVLgdnnT22EoGma3UKIZejHPqxwonqqugPWK3n/SjPPLeCEbFlEPplZToQj
         OGSBIJX3HRhBzpjsoLKgygpMeX/5ptcTYkT0xykQeJd6J/fNota/4TR8D0sc/rk13gtS
         n++A==
X-Gm-Message-State: AOAM5311Z1sYETUWkw+ZKwajmXThhRgxh+NnxFPR1q2saPjKMaeL7+wt
        AY7E7hhpAWQolonPZpeRUHOqfYhDchMKcqiCrPjMlFb64nqK4fO+RqfEJo7uWE9oAFv2ycJ8e/0
        C920pCsWM9FcLCgJRURYLDK3OEJL6AcLnEQ==
X-Received: by 2002:a05:6512:613:: with SMTP id b19mr4621144lfe.220.1613050742884;
        Thu, 11 Feb 2021 05:39:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyafdC4oQ79x7WQSko3/Od0YIHV05+67+o7ZE7cQPjfzaYfD75xXBj87fVYcrtLlGrUvyKomtWkrFvsHjf63dM=
X-Received: by 2002:a05:6512:613:: with SMTP id b19mr4621135lfe.220.1613050742707;
 Thu, 11 Feb 2021 05:39:02 -0800 (PST)
MIME-Version: 1.0
References: <20210204010157.1823669-1-aklimov@redhat.com> <YBvCYhdPai+pb8u2@hirez.programming.kicks-ass.net>
 <20210205112219.kxdjpvjykrv6fi3x@e107158-lin>
In-Reply-To: <20210205112219.kxdjpvjykrv6fi3x@e107158-lin>
From:   Alexey Klimov <aklimov@redhat.com>
Date:   Thu, 11 Feb 2021 13:38:51 +0000
Message-ID: <CAFBcO+81bFBUuR=MrLttBEs8gKh0hx+EcJA2MCbqMzu=CUoybg@mail.gmail.com>
Subject: Re: [PATCH] cpu/hotplug: wait for cpuset_hotplug_work to finish on
 cpu onlining
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        yury.norov@gmail.com, Daniel Jordan <daniel.m.jordan@oracle.com>,
        tglx@linutronix.de, Joshua Baker <jobaker@redhat.com>,
        audralmitchel@gmail.com, arnd@arndb.de, gregkh@linuxfoundation.org,
        rafael@kernel.org, tj@kernel.org, lizefan@huawei.com,
        hannes@cmpxchg.org, Alexey Klimov <klimov.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Feb 5, 2021 at 11:22 AM Qais Yousef <qais.yousef@arm.com> wrote:
>
> On 02/04/21 10:46, Peter Zijlstra wrote:
> > On Thu, Feb 04, 2021 at 01:01:57AM +0000, Alexey Klimov wrote:
> > > @@ -1281,6 +1282,11 @@ static int cpu_up(unsigned int cpu, enum cpuhp_state target)
> > >     err = _cpu_up(cpu, 0, target);
> > >  out:
> > >     cpu_maps_update_done();
> > > +
> > > +   /* To avoid out of line uevent */
> > > +   if (!err)
> > > +           cpuset_wait_for_hotplug();
> > > +
> > >     return err;
> > >  }
> > >
> >
> > > @@ -2071,14 +2075,18 @@ static void cpuhp_online_cpu_device(unsigned int cpu)
> > >     struct device *dev = get_cpu_device(cpu);
> > >
> > >     dev->offline = false;
> > > -   /* Tell user space about the state change */
> > > -   kobject_uevent(&dev->kobj, KOBJ_ONLINE);
> > >  }
> > >
> >
> > One concequence of this is that you'll now get a bunch of notifications
> > across things like suspend/hybernate.
>
> And the resume latency will incur 5-30ms * nr_cpu_ids.
>
> Since you just care about device_online(), isn't cpu_device_up() a better place
> for the wait? This function is special helper for device_online(), leaving
> suspend/resume and kexec paths free from having to do this unnecessary wait.

Yup, the same idea here once Peter mentioned bringup_nonboot_cpus()
and bringup_hibernate_cpu().

Best regards,
Alexey

