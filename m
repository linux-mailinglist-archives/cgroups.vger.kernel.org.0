Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2C6C1AE3A3
	for <lists+cgroups@lfdr.de>; Fri, 17 Apr 2020 19:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728916AbgDQRSj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 17 Apr 2020 13:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728687AbgDQRS3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 17 Apr 2020 13:18:29 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44FBAC061A10
        for <cgroups@vger.kernel.org>; Fri, 17 Apr 2020 10:18:29 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id r17so2429413lff.2
        for <cgroups@vger.kernel.org>; Fri, 17 Apr 2020 10:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o4AxRTlVcgkXgmi2LH7FRSyDbtdJOdGOVjbxoP8py4E=;
        b=KN9L8a7H5um8chRLVRTdUiq5rDqyihp3g4hBvjZNc0rLhfvTvEUIR3bpd7TMO9YPh2
         DYhybPls3AOAIJuz2jJD64RiTxjWqpFqMpjJsf/IRALVWQmI/V51Xjv/LBHYwMADNnDD
         XGoYsVgvmvbxEQd94R6RjNSmKNtoj/BHwVCe5OE2kwdMzXWbkSJYVSmzwzZHr1If24JZ
         2CyUinq6W/uFHqjvQ756hZpIY6QMOqNIw3KRxW+AOe+SmoUc58AIPolI35skXhsCpazf
         Gwfc8LqFDsWpjZ7e5JpD1ZrLCRi2AwsyyUXqm8iTmYGXk5GdKBflHIfz7U0dB17m40AO
         SbzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o4AxRTlVcgkXgmi2LH7FRSyDbtdJOdGOVjbxoP8py4E=;
        b=UFukXLgTTYMmLZd342usPIKit6WOp7Y+3FTxWBJcKu24Iiv1BuuXDj+uda+T9D7iYg
         ZE3djKY/WB+okxvfc+TlFJoWXi21K9q0jWasYDadgBfradzH02t1uPmHk+3skKOP1BSk
         PpiRHKOari/kAaFIuMSqbw8vAQ0pNgjOnOfYILtn15gNX4JLUAAjiFsI7XIrX9fvJkkN
         vaUowpZ5N5Pw+JhP4q9xR/ea7GnKhkFlARfZI9j8Q66Jntux9gt1Sujc7VFT+6Ma7CVW
         C4p7WNl5A92t9EnmXx1BILrAlG3ZVDz76+leu0Trs0njbpti4ce01Mg+CmEM8UZfdz8w
         SM9w==
X-Gm-Message-State: AGi0PubqOitbu21jvXPwqIMm/58u+j0YBJQQHS1RYkKf4Zb0SovFsHuF
        IoQX0GWxJ/iVNS2X111yuaeFhpSOXjR2RxsfCon8rQ==
X-Google-Smtp-Source: APiQypLkRQHbdzhph7XVHw5ZeyHzUgxbYSRMTPvK6KeMnOLzAWUSiu4oqQ+yZMWVnEjMWtTb9H/RSvGHXBRgELHhtn4=
X-Received: by 2002:a19:5206:: with SMTP id m6mr2714469lfb.33.1587143907411;
 Fri, 17 Apr 2020 10:18:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200417010617.927266-1-kuba@kernel.org> <CALvZod78ZUhU+yr2x1h_gv+VgVGTPnSSGKh_+fd+MeiAKreJvg@mail.gmail.com>
 <20200417162355.GA43469@mtj.thefacebook.com>
In-Reply-To: <20200417162355.GA43469@mtj.thefacebook.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 17 Apr 2020 10:18:15 -0700
Message-ID: <CALvZod4ftvXCu8SbQUXwTGVvx5K2+at9h30r28chZLXEB1JdfQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] memcg: Slow down swap allocation as the available
 space gets depleted
To:     Tejun Heo <tj@kernel.org>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Kernel Team <kernel-team@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Chris Down <chris@chrisdown.name>,
        Cgroups <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Tejun,

On Fri, Apr 17, 2020 at 9:23 AM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Fri, Apr 17, 2020 at 09:11:33AM -0700, Shakeel Butt wrote:
> > On Thu, Apr 16, 2020 at 6:06 PM Jakub Kicinski <kuba@kernel.org> wrote:
> > >
> > > Tejun describes the problem as follows:
> > >
> > > When swap runs out, there's an abrupt change in system behavior -
> > > the anonymous memory suddenly becomes unmanageable which readily
> > > breaks any sort of memory isolation and can bring down the whole
> > > system.
> >
> > Can you please add more info on this abrupt change in system behavior
> > and what do you mean by anon memory becoming unmanageable?
>
> In the sense that anonymous memory becomes essentially memlocked.
>
> > Once the system is in global reclaim and doing swapping the memory
> > isolation is already broken. Here I am assuming you are talking about
>
> There currently are issues with anonymous memory management which makes them
> different / worse than page cache but I don't follow why swapping
> necessarily means that isolation is broken. Page refaults don't indicate
> that memory isolation is broken after all.
>

Sorry, I meant the performance isolation. Direct reclaim does not
really differentiate who to stall and whose CPU to use.

> > memcg limit reclaim and memcg limits are overcommitted. Shouldn't
> > running out of swap will trigger the OOM earlier which should be
> > better than impacting the whole system.
>
> The primary scenario which was being considered was undercommitted
> protections but I don't think that makes any relevant differences.
>

What is undercommitted protections? Does it mean there is still swap
available on the system but the memcg is hitting its swap limit?

> This is exactly similar to delay injection for memory.high. What's desired
> is slowing down the workload as the available resource is depleted so that
> the resource shortage presents as gradual degradation of performance and
> matching increase in resource PSI. This allows the situation to be detected
> and handled from userland while avoiding sudden and unpredictable behavior
> changes.
>

Let me try to understand this with an example. Memcg 'A' has
memory.high = 100 MiB, memory.max = 150 MiB and memory.swap.max = 50
MiB. When A's usage goes over 100 MiB, it will reclaim the anon, file
and kmem. The anon will go to swap and increase its swap usage until
it hits the limit. Now the 'A' reclaim_high has fewer things (file &
kmem) to reclaim but the mem_cgroup_handle_over_high() will keep A's
increase in usage in check.

So, my question is: should the slowdown by memory.high depends on the
reclaimable memory? If there is no reclaimable memory and the job hits
memory.high, should the kernel slow it down to crawl until the PSI
monitor comes and decides what to do. If I understand correctly, the
problem is the kernel slow down is not successful when reclaimable
memory is very low. Please correct me if I am wrong.

Shakeel
