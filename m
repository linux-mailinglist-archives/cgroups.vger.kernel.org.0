Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B478630F416
	for <lists+cgroups@lfdr.de>; Thu,  4 Feb 2021 14:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236327AbhBDNoD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 4 Feb 2021 08:44:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236325AbhBDNnW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 4 Feb 2021 08:43:22 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF3C8C061786;
        Thu,  4 Feb 2021 05:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=esfcV78RrU8nXrE72X9LckMx7X5reL/P0pwhKEpoq3w=; b=EEFa99xE3ECGRhB28SI4ZjY4Yi
        2zi2lbL6t/w3MDJsqbSTTXxUCdkmZqMCffLyoGa4IXzIkJUDPq7rHzsGvE1/JYKmPObvd6XPxTjHK
        f+DJOdmlIuE9n6P33PTnV3QEg5Z3a+ZlgO1dCIsog9ISzdkaPbj7f0DfcTU4AooM6CflEI1pOZQAn
        J76NZlxMOEMnWAvW1L0hycrU6rlq+RaSYTZOBqJYv3/WVZ8mpCOpDuAO2yA58ifD+umhnRBTmNAc3
        leFwjnf15NZFu8n4wCvXpHg28KOKHhyARfSXOvPz6P1do77EDtYVz4dwaVqihgV7O6m3QUjbvepck
        KlC815Ug==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l7etV-000vze-JP; Thu, 04 Feb 2021 13:42:02 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5BBD83003D8;
        Thu,  4 Feb 2021 14:42:00 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1E4752C0034C0; Thu,  4 Feb 2021 14:42:00 +0100 (CET)
Date:   Thu, 4 Feb 2021 14:42:00 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexey Klimov <aklimov@redhat.com>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        yury.norov@gmail.com, Daniel Jordan <daniel.m.jordan@oracle.com>,
        tglx@linutronix.de, Joshua Baker <jobaker@redhat.com>,
        audralmitchel@gmail.com, arnd@arndb.de, gregkh@linuxfoundation.org,
        rafael@kernel.org, tj@kernel.org, lizefan@huawei.com,
        qais.yousef@arm.com, hannes@cmpxchg.org,
        Alexey Klimov <klimov.linux@gmail.com>
Subject: Re: [PATCH] cpu/hotplug: wait for cpuset_hotplug_work to finish on
 cpu onlining
Message-ID: <YBv5qDBdb/VAq0Vw@hirez.programming.kicks-ass.net>
References: <20210204010157.1823669-1-aklimov@redhat.com>
 <YBvCYhdPai+pb8u2@hirez.programming.kicks-ass.net>
 <CAFBcO+_Z1LKqPPwEKq-XGX+RnWQa+vFBVJ9D9y0MNHGUkM_4Jw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFBcO+_Z1LKqPPwEKq-XGX+RnWQa+vFBVJ9D9y0MNHGUkM_4Jw@mail.gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Feb 04, 2021 at 12:50:34PM +0000, Alexey Klimov wrote:
> On Thu, Feb 4, 2021 at 9:46 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Thu, Feb 04, 2021 at 01:01:57AM +0000, Alexey Klimov wrote:
> > > @@ -1281,6 +1282,11 @@ static int cpu_up(unsigned int cpu, enum cpuhp_state target)
> > >       err = _cpu_up(cpu, 0, target);
> > >  out:
> > >       cpu_maps_update_done();
> > > +
> > > +     /* To avoid out of line uevent */
> > > +     if (!err)
> > > +             cpuset_wait_for_hotplug();
> > > +
> > >       return err;
> > >  }
> > >
> >
> > > @@ -2071,14 +2075,18 @@ static void cpuhp_online_cpu_device(unsigned int cpu)
> > >       struct device *dev = get_cpu_device(cpu);
> > >
> > >       dev->offline = false;
> > > -     /* Tell user space about the state change */
> > > -     kobject_uevent(&dev->kobj, KOBJ_ONLINE);
> > >  }
> > >
> >
> > One concequence of this is that you'll now get a bunch of notifications
> > across things like suspend/hybernate.
> 
> The patch doesn't change the number of kobject_uevent()s. The
> userspace will get the same number of uevents as before the patch (at
> least if I can rely on my eyes).

bringup_hibernate_cpu() didn't used to generate an event, it does now.
Same for bringup_nonboot_cpus().

Also, looking again, you don't seem to be reinstating the OFFLINE event
you took out.


