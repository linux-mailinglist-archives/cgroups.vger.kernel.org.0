Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54230170E81
	for <lists+cgroups@lfdr.de>; Thu, 27 Feb 2020 03:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbgB0Cgr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 Feb 2020 21:36:47 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45791 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728164AbgB0Cgr (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 26 Feb 2020 21:36:47 -0500
Received: by mail-oi1-f196.google.com with SMTP id v19so1737479oic.12
        for <cgroups@vger.kernel.org>; Wed, 26 Feb 2020 18:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FgDRP53fhRc849hJWqV/+PwhPD91i+668jgIHMCfsLU=;
        b=NxVZZMPHkldyISQkt/j9q46fqdC/fTHYg2D8rxmu3JQ5FQTpEWAnsrfAW1INOGxpeL
         7h/DwX4EseSXzq8DPxsx7tT89LiU3NA/LHAN4Sx7xeCJY7jLlWu2wlI7PxFLojwfUju3
         XCXCv0GNC9Xz5gwwW7M6ZQvAHCRuijZey00McNQxQ9NVe7aC2WLqdpYWQ76fRU+M2TSD
         fCSLoyGAnvdSsxpdtTUIC1FBt0jEnZJWNiN/eJ1V1HI2R4d3LlFZziKBBFNxThGx34jE
         FKNM7vbPt25+yqO0LpSs/FWkruIUFSvFAow7Xv2uEwRevRGyVVEdbZ3TS4R6adpOe9Q4
         7e2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FgDRP53fhRc849hJWqV/+PwhPD91i+668jgIHMCfsLU=;
        b=ijBNFyIEgXxbdV+Cy5ab7YdHZ7iII+jVjTNyZDYUMI8E9MxsmFgwiSKV6W7bMa5ltz
         mPWn33JtxUd8TmetXn4xpJWdRO0avjBM961pv7FMmsDutWNSql0Hzu8cd5R1nCtwuAPR
         5Ah4ado0P8+PykDJt//wf2vsN/Btta2DyZv54s39MKqR5sO7Q5KCfbvG8QgJONTeeaRP
         IN5eldARB+mhWxFxuuibdDhQ3sGinIg3yMmXJ/Ni0C2Fwphodi1lJAAy0HZkuxyB7CQU
         4VPlJ//LZI1wbdk1myyaiNrtnU6mNxf2inogiwZnq2VE5AaoPln6KRafZIpUj+YWbBf8
         +6kg==
X-Gm-Message-State: APjAAAXf1ZjFUmUe9hoyajOy3SYkRAJ495G0MN1OobiN+ZDrBqKq4GIM
        /hE7NQNebMb6Grz3LcKVwsc2d2VaB9w2fO4hufJnOw==
X-Google-Smtp-Source: APXvYqxSTajCLv39pHIuIJCvAXLQ9cYdJjHOg6fBj1Fml1OToHYqpXa6HgimPFRGsX9+cCOOLCiKuAaOHamSjyEnxZA=
X-Received: by 2002:a05:6808:30d:: with SMTP id i13mr1610873oie.144.1582771005560;
 Wed, 26 Feb 2020 18:36:45 -0800 (PST)
MIME-Version: 1.0
References: <20200219181219.54356-1-hannes@cmpxchg.org> <CALvZod7fya+o8mO+qo=FXjk3WgNje=2P=sxM5StgdBoGNeXRMg@mail.gmail.com>
 <1bfd6ea4-f012-5778-64c6-36731e69b5ba@linux.alibaba.com>
In-Reply-To: <1bfd6ea4-f012-5778-64c6-36731e69b5ba@linux.alibaba.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 26 Feb 2020 18:36:34 -0800
Message-ID: <CALvZod7kFNV7_+3pWiG7=bo0nFai8Qi+Hr5Cqa94nwUCPpWgJg@mail.gmail.com>
Subject: Re: [PATCH] mm: memcontrol: asynchronous reclaim for memory.high
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Tejun Heo <tj@kernel.org>,
        Roman Gushchin <guro@fb.com>, Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Feb 26, 2020 at 3:59 PM Yang Shi <yang.shi@linux.alibaba.com> wrote:
>
>
>
> On 2/26/20 12:25 PM, Shakeel Butt wrote:
> > On Wed, Feb 19, 2020 at 10:12 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >> We have received regression reports from users whose workloads moved
> >> into containers and subsequently encountered new latencies. For some
> >> users these were a nuisance, but for some it meant missing their SLA
> >> response times. We tracked those delays down to cgroup limits, which
> >> inject direct reclaim stalls into the workload where previously all
> >> reclaim was handled my kswapd.
> >>
> >> This patch adds asynchronous reclaim to the memory.high cgroup limit
> >> while keeping direct reclaim as a fallback. In our testing, this
> >> eliminated all direct reclaim from the affected workload.
> >>
> >> memory.high has a grace buffer of about 4% between when it becomes
> >> exceeded and when allocating threads get throttled. We can use the
> >> same buffer for the async reclaimer to operate in. If the worker
> >> cannot keep up and the grace buffer is exceeded, allocating threads
> >> will fall back to direct reclaim before getting throttled.
> >>
> >> For irq-context, there's already async memory.high enforcement. Re-use
> >> that work item for all allocating contexts, but switch it to the
> >> unbound workqueue so reclaim work doesn't compete with the workload.
> >> The work item is per cgroup, which means the workqueue infrastructure
> >> will create at maximum one worker thread per reclaiming cgroup.
> >>
> >> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> >> ---
> >>   mm/memcontrol.c | 60 +++++++++++++++++++++++++++++++++++++------------
> >>   mm/vmscan.c     | 10 +++++++--
> > This reminds me of the per-memcg kswapd proposal from LSFMM 2018
> > (https://lwn.net/Articles/753162/).
>
> Thanks for bringing this up.
>
> >
> > If I understand this correctly, the use-case is that the job instead
> > of direct reclaiming (potentially in latency sensitive tasks), prefers
> > a background non-latency sensitive task to do the reclaim. I am
> > wondering if we can use the memory.high notification along with a new
> > memcg interface (like memory.try_to_free_pages) to implement a user
> > space background reclaimer. That would resolve the cpu accounting
> > concerns as the user space background reclaimer can share the cpu cost
> > with the task.
>
> Actually I'm interested how you implement userspace reclaimer. Via a new
> syscall or a variant of existing syscall?
>

We have a per-memcg interface memory.try_to_free_pages on which user
space can echo two numbers i.e. number of bytes to reclaim and a byte
representing flags (I/O allowed or just reclaim zombies e.t.c).
However nowadays we are just using it for zombie cleanup.

Shakeel
