Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6004830F378
	for <lists+cgroups@lfdr.de>; Thu,  4 Feb 2021 13:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236188AbhBDMwQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 4 Feb 2021 07:52:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37526 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236113AbhBDMwP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 4 Feb 2021 07:52:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612443048;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DKbKu0SnosOmRjiPUA+TXW/OuCr5IvZDTkGTyTOp94w=;
        b=RK/OQdu5xIBKLoMBp2fVjJTJhStDXtYNBdPvd9fqdr2vVf95w+60GluGeQXoK24XCDTfX9
        VJOAxFiiJR85PoDptAlnHfoJNatTkmooBCMfIjpgm+FbNiRKAr6qmLelg0PZBp9VwoDWBx
        AYt2ljqF8XxzEZ7ZmwHBtUAgBKqm/XI=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-491-Zt989t3DNuWVKKZyQsQgbA-1; Thu, 04 Feb 2021 07:50:46 -0500
X-MC-Unique: Zt989t3DNuWVKKZyQsQgbA-1
Received: by mail-lj1-f198.google.com with SMTP id p6so2550325ljg.12
        for <cgroups@vger.kernel.org>; Thu, 04 Feb 2021 04:50:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DKbKu0SnosOmRjiPUA+TXW/OuCr5IvZDTkGTyTOp94w=;
        b=PNZdG40UHbAQ6DoFjDvW8zxNQRjo0Tm5GauXrn8G4+3PLiT9SEZxOqPUs3aL28I49A
         4rxPf5B+6H2Nulug/RpAP1sNAiQaYbl7/5EIAfsxxykmkN3G3RkZ5CXHi/rAre44uEBT
         QvaDsYR4qERcaS9TSO7nkt6gHhIBpMhtmS1B5P0vyjgvWX9zGQMKubdmqauL2u2rcWou
         VNvHeoDdFFZSbOJujFRKC0xrPxplhvOo5tCqLHAnGPdOSgmlTgiMuynME/4L/l/Q0Hus
         6gDdWsmHnQ33qWwOAI5VKp2PrFYWKhhscPqEtSSgzNeT0H7sNfQmw1th5beHnukxeboV
         AcNA==
X-Gm-Message-State: AOAM533A6Q6mEydtkvYzydkgp0GIDSlkQ98k2Zr2iugXUAj00VPPyUAq
        r5XYhrwjoPxgU774WrJYwU2GA54tkG/SNd+BEzOCucrDbzU8DOTz3ZUgYbK4L3rwRb4xwf9e9/e
        2TSt5cSpxSspLBTGVzIKLNATYIRVBTuyejA==
X-Received: by 2002:a05:651c:1211:: with SMTP id i17mr4722306lja.12.1612443045215;
        Thu, 04 Feb 2021 04:50:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyHOKX7YPZDTcB8kVmsl+35+Wrszff6VDC/FDIqf7q2OzNxeFCKfC/HQWWx3bOgZ7G4RAjv3iIt2oes6DrPj2g=
X-Received: by 2002:a05:651c:1211:: with SMTP id i17mr4722292lja.12.1612443045056;
 Thu, 04 Feb 2021 04:50:45 -0800 (PST)
MIME-Version: 1.0
References: <20210204010157.1823669-1-aklimov@redhat.com> <YBvCYhdPai+pb8u2@hirez.programming.kicks-ass.net>
In-Reply-To: <YBvCYhdPai+pb8u2@hirez.programming.kicks-ass.net>
From:   Alexey Klimov <aklimov@redhat.com>
Date:   Thu, 4 Feb 2021 12:50:34 +0000
Message-ID: <CAFBcO+_Z1LKqPPwEKq-XGX+RnWQa+vFBVJ9D9y0MNHGUkM_4Jw@mail.gmail.com>
Subject: Re: [PATCH] cpu/hotplug: wait for cpuset_hotplug_work to finish on
 cpu onlining
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        yury.norov@gmail.com, Daniel Jordan <daniel.m.jordan@oracle.com>,
        tglx@linutronix.de, Joshua Baker <jobaker@redhat.com>,
        audralmitchel@gmail.com, arnd@arndb.de, gregkh@linuxfoundation.org,
        rafael@kernel.org, tj@kernel.org, lizefan@huawei.com,
        qais.yousef@arm.com, hannes@cmpxchg.org,
        Alexey Klimov <klimov.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Feb 4, 2021 at 9:46 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Feb 04, 2021 at 01:01:57AM +0000, Alexey Klimov wrote:
> > @@ -1281,6 +1282,11 @@ static int cpu_up(unsigned int cpu, enum cpuhp_state target)
> >       err = _cpu_up(cpu, 0, target);
> >  out:
> >       cpu_maps_update_done();
> > +
> > +     /* To avoid out of line uevent */
> > +     if (!err)
> > +             cpuset_wait_for_hotplug();
> > +
> >       return err;
> >  }
> >
>
> > @@ -2071,14 +2075,18 @@ static void cpuhp_online_cpu_device(unsigned int cpu)
> >       struct device *dev = get_cpu_device(cpu);
> >
> >       dev->offline = false;
> > -     /* Tell user space about the state change */
> > -     kobject_uevent(&dev->kobj, KOBJ_ONLINE);
> >  }
> >
>
> One concequence of this is that you'll now get a bunch of notifications
> across things like suspend/hybernate.

The patch doesn't change the number of kobject_uevent()s. The
userspace will get the same number of uevents as before the patch (at
least if I can rely on my eyes).
Or is there a concern that now the uevents are sent in a row
sequentially which might abuse userspace uevents handling machinery?

Best regards,
Alexey

