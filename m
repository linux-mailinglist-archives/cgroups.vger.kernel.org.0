Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF69F35FF8D
	for <lists+cgroups@lfdr.de>; Thu, 15 Apr 2021 03:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbhDOBak (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 14 Apr 2021 21:30:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31557 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229449AbhDOBak (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 14 Apr 2021 21:30:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618450217;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NuT37Vpiz4KczvJjbLuhVhLsnc1sKQ6bWyp9Fysxc0M=;
        b=SKhq/xnRzymw3OROtwY8Am/xi4wnDKFx6mlhKxf3ulA5LZ0UsKhsYL0ilIA/HsK7JbMUFM
        FfWHcbHQL1OtIZV1bfto5mYPQr+DUpRAxiBQXwK+lhCTMrVGyP275AyoSnogh9+QFPs1uK
        C5yPAWVNvZHCOLh9hrAryxbpT7ASXVM=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-520-84JluCp3O-quJ0TioY_paA-1; Wed, 14 Apr 2021 21:30:16 -0400
X-MC-Unique: 84JluCp3O-quJ0TioY_paA-1
Received: by mail-lf1-f70.google.com with SMTP id n128-20020a1940860000b0290171d50a7ecbso1755377lfa.11
        for <cgroups@vger.kernel.org>; Wed, 14 Apr 2021 18:30:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NuT37Vpiz4KczvJjbLuhVhLsnc1sKQ6bWyp9Fysxc0M=;
        b=epmyEpKYUd40v+rBTkBtu8ruP03MRz/WDCSj+pietDeCeHchWaZCLyJEcWLkv7mqLw
         72+M3TWmxsKoS8FmPuYqtE6m3lUrylEFD8sp7LC9mX+C/ykPeJW0NYkIQXLWfv6GX0xP
         /ZNDpeJv6t2ZBjfpkogFt039KHohxp9VgR3zCRrkOx05h5djcL37t5l1NP8K5/ZEIrHF
         06LOEe6WuWDFtqcvXoC11mfha2LRrReYl9q08w8ylVugIFb1+B72JOQHWsvGx4m4wq8a
         rGi1IHzHWScyvAAl4VdEqxoNmc/8LfVuhQsZQnVznKxVu5ckqNj8dGuKDSMPg3gNrscg
         Uurg==
X-Gm-Message-State: AOAM532WxrRoKWpRHtxqqD2NCvYhJDmSdzUVacNpaud/LxVTUM+CqV+m
        /M5B/IyAJeaY8WekU3DHIPM3xK1D45/zz0DIeG2N+fKB4g6RmN+wkPRr8vaPlMliw6T5fSWZg8g
        9A6uXm/AJqb5sN9Del/eJ0eSO5wQ6Lzdc4Q==
X-Received: by 2002:a05:6512:b0d:: with SMTP id w13mr690483lfu.16.1618450214565;
        Wed, 14 Apr 2021 18:30:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwDYMlj20wS7v+deB0HVHfODTSDiKREGfFpV6FOtv9WxbYz6e2VspZKd9MIhgzZuDHdRBE8GCKZun9GcIddnGk=
X-Received: by 2002:a05:6512:b0d:: with SMTP id w13mr690469lfu.16.1618450214403;
 Wed, 14 Apr 2021 18:30:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210317003616.2817418-1-aklimov@redhat.com> <87tuowcnv3.ffs@nanos.tec.linutronix.de>
 <CALW4P+L9_tYgfOPv0riWWnv54HPhKPDJ4EK4yYaWsz0MdDGqfw@mail.gmail.com>
In-Reply-To: <CALW4P+L9_tYgfOPv0riWWnv54HPhKPDJ4EK4yYaWsz0MdDGqfw@mail.gmail.com>
From:   Alexey Klimov <aklimov@redhat.com>
Date:   Thu, 15 Apr 2021 02:30:03 +0100
Message-ID: <CAFBcO+8NBZxNdXtVuTXt9_m9gWTq7kxrcDcdFntvVjR_0rM13A@mail.gmail.com>
Subject: Re: [PATCH v3] cpu/hotplug: wait for cpuset_hotplug_work to finish on
 cpu onlining
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        cgroups@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Yury Norov <yury.norov@gmail.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Joshua Baker <jobaker@redhat.com>, audralmitchel@gmail.com,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rafael@kernel.org, tj@kernel.org,
        Qais Yousef <qais.yousef@arm.com>, hannes@cmpxchg.org,
        Alexey Klimov <klimov.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sun, Apr 4, 2021 at 3:32 AM Alexey Klimov <klimov.linux@gmail.com> wrote:
>
> On Sat, Mar 27, 2021 at 9:01 PM Thomas Gleixner <tglx@linutronix.de> wrote:

[...]

Now, the patch:

>> Subject: cpu/hotplug: Cure the cpusets trainwreck
>> From: Thomas Gleixner <tglx@linutronix.de>
>> Date: Sat, 27 Mar 2021 15:57:29 +0100
>>
>> Alexey and Joshua tried to solve a cpusets related hotplug problem which is
>> user space visible and results in unexpected behaviour for some time after
>> a CPU has been plugged in and the corresponding uevent was delivered.
>>
>> cpusets delegate the hotplug work (rebuilding cpumasks etc.) to a
>> workqueue. This is done because the cpusets code has already a lock
>> nesting of cgroups_mutex -> cpu_hotplug_lock. A synchronous callback or
>> waiting for the work to finish with cpu_hotplug_lock held can and will
>> deadlock because that results in the reverse lock order.
>>
>> As a consequence the uevent can be delivered before cpusets have consistent
>> state which means that a user space invocation of sched_setaffinity() to
>> move a task to the plugged CPU fails up to the point where the scheduled
>> work has been processed.
>>
>> The same is true for CPU unplug, but that does not create user observable
>> failure (yet).
>>
>> It's still inconsistent to claim that an operation is finished before it
>> actually is and that's the real issue at hand. uevents just make it
>> reliably observable.
>>
>> Obviously the problem should be fixed in cpusets/cgroups, but untangling
>> that is pretty much impossible because according to the changelog of the
>> commit which introduced this 8 years ago:
>>
>>  3a5a6d0c2b03("cpuset: don't nest cgroup_mutex inside get_online_cpus()")
>>
>> the lock order cgroups_mutex -> cpu_hotplug_lock is a design decision and
>> the whole code is built around that.
>>
>> So bite the bullet and invoke the relevant cpuset function, which waits for
>> the work to finish, in _cpu_up/down() after dropping cpu_hotplug_lock and
>> only when tasks are not frozen by suspend/hibernate because that would
>> obviously wait forever.
>>
>> Waiting there with cpu_add_remove_lock, which is protecting the present
>> and possible CPU maps, held is not a problem at all because neither work
>> queues nor cpusets/cgroups have any lockchains related to that lock.
>>
>> Waiting in the hotplug machinery is not problematic either because there
>> are already state callbacks which wait for hardware queues to drain. It
>> makes the operations slightly slower, but hotplug is slow anyway.
>>
>> This ensures that state is consistent before returning from a hotplug
>> up/down operation. It's still inconsistent during the operation, but that's
>> a different story.
>>
>> Add a large comment which explains why this is done and why this is not a
>> dump ground for the hack of the day to work around half thought out locking
>> schemes. Document also the implications vs. hotplug operations and
>> serialization or the lack of it.
>>
>> Thanks to Alexy and Joshua for analyzing why this temporary
>> sched_setaffinity() failure happened.
>>
>> Reported-by: Alexey Klimov <aklimov@redhat.com>
>> Reported-by: Joshua Baker <jobaker@redhat.com>
>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Daniel Jordan <daniel.m.jordan@oracle.com>
>> Cc: Qais Yousef <qais.yousef@arm.com>

Feel free to use:
Tested-by: Alexey Klimov <aklimov@redhat.com>

The bug doesn't reproduce with this change, I had the testcase running
for ~25 hrs without failing under different workloads.

Are you going to submit the patch? Or I can do it on your behalf if you like.

[...]

Best regards,
Alexey

