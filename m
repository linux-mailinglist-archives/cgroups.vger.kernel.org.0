Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8C8170B8C
	for <lists+cgroups@lfdr.de>; Wed, 26 Feb 2020 23:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbgBZW0p (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 Feb 2020 17:26:45 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:42978 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727757AbgBZW0p (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 26 Feb 2020 17:26:45 -0500
Received: by mail-qv1-f68.google.com with SMTP id dc14so597700qvb.9
        for <cgroups@vger.kernel.org>; Wed, 26 Feb 2020 14:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1pUOCDo1xfpbB9eMKwX1WssgTio2peYBY4faFYcpXSE=;
        b=1QSlHaDUxgg2mgs9SMQl+bXQNUUVbnXcl/ljCp1zHziKIqL7ke61B1q5H5ZJs6zUFG
         XquHcPjSE5EI58XbhmobrTTTBDWvVyakNk66BSFINlEcDf3yXJ+n7C4oKlHlPPCmuVEA
         hkePiAzrmF2glb3j+OdYa5MOhpiLdbaUtEoOp3X2+s5clbSqBkY+C443tYDRAN4ZTpNd
         sw/MFTv2cPxz8FJ0vdZIWMjwAh0Wf4lrTIA0/hNYI7vdfUcA0p9nGpU122CzNoY/kk9j
         Gsxa3n94IUR+n4++WvWjtaCkIQSPYrHoKNLnl4c2L6ZFACP1oepYMzs/amMEUdQGgMU0
         IiPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1pUOCDo1xfpbB9eMKwX1WssgTio2peYBY4faFYcpXSE=;
        b=bH5bFMZd9AsOuQXx1phAOuvBnJoC/RNwl4jlU+Hy8h2f0VdBDEoqRnDsrd9ZkIi/im
         4lr44eFVWAX24BcxAgDnMgxIxzS8wWNoA+GZ5HLjFIZIOnWb92+Dlxnwc31QA33nxHZT
         DFc/+UxRS4n9GRyEcb2FR8G0mxkTpZmmvvWAw2Bj5su6YrYnwsQLYM9NtWlDzOT+svon
         ghNTGfdltkwBchYuhXlUoRGIqDsCUT6FFj2lgnbfByjoc05R59SLXJ5jB74m/HjTUZhW
         hL1KsemU0umR0tWI3HYtGIKhMzl3LETpDluV9tfx4PaWexevRmoi4sPUU1D1g0WlefuE
         DPkQ==
X-Gm-Message-State: APjAAAV3W6ry5CcguI9mMVyoDvYZuTu9PHxGp/aRnEM8ifxNQ3gJfodQ
        o4+l7P42ScABGguL7BCZKks5JmiCuVE=
X-Google-Smtp-Source: APXvYqwCd1yR7I6wXSDZIyJ030whgU3j4K7nuC3PjhdyAziyeXCk9056hRVJLBc35vasnMwlMJajnw==
X-Received: by 2002:a0c:c542:: with SMTP id y2mr1400834qvi.225.1582756003947;
        Wed, 26 Feb 2020 14:26:43 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::3:6048])
        by smtp.gmail.com with ESMTPSA id l4sm1938307qke.30.2020.02.26.14.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 14:26:43 -0800 (PST)
Date:   Wed, 26 Feb 2020 17:26:42 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Yang Shi <yang.shi@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Tejun Heo <tj@kernel.org>,
        Roman Gushchin <guro@fb.com>, Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH] mm: memcontrol: asynchronous reclaim for memory.high
Message-ID: <20200226222642.GB30206@cmpxchg.org>
References: <20200219181219.54356-1-hannes@cmpxchg.org>
 <CALvZod7fya+o8mO+qo=FXjk3WgNje=2P=sxM5StgdBoGNeXRMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod7fya+o8mO+qo=FXjk3WgNje=2P=sxM5StgdBoGNeXRMg@mail.gmail.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Feb 26, 2020 at 12:25:33PM -0800, Shakeel Butt wrote:
> On Wed, Feb 19, 2020 at 10:12 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > We have received regression reports from users whose workloads moved
> > into containers and subsequently encountered new latencies. For some
> > users these were a nuisance, but for some it meant missing their SLA
> > response times. We tracked those delays down to cgroup limits, which
> > inject direct reclaim stalls into the workload where previously all
> > reclaim was handled my kswapd.
> >
> > This patch adds asynchronous reclaim to the memory.high cgroup limit
> > while keeping direct reclaim as a fallback. In our testing, this
> > eliminated all direct reclaim from the affected workload.
> >
> > memory.high has a grace buffer of about 4% between when it becomes
> > exceeded and when allocating threads get throttled. We can use the
> > same buffer for the async reclaimer to operate in. If the worker
> > cannot keep up and the grace buffer is exceeded, allocating threads
> > will fall back to direct reclaim before getting throttled.
> >
> > For irq-context, there's already async memory.high enforcement. Re-use
> > that work item for all allocating contexts, but switch it to the
> > unbound workqueue so reclaim work doesn't compete with the workload.
> > The work item is per cgroup, which means the workqueue infrastructure
> > will create at maximum one worker thread per reclaiming cgroup.
> >
> > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> > ---
> >  mm/memcontrol.c | 60 +++++++++++++++++++++++++++++++++++++------------
> >  mm/vmscan.c     | 10 +++++++--
> 
> This reminds me of the per-memcg kswapd proposal from LSFMM 2018
> (https://lwn.net/Articles/753162/).

Ah yes, I remember those discussions. :)

One thing that has changed since we tried to implement this last was
the workqueue concurrency code. We don't have to worry about a single
thread or fixed threads per cgroup, because the workqueue code has
improved significantly to handle concurrency demands, and having one
work item per cgroup makes sure we have anywhere between 0 threads and
one thread per cgroup doing this reclaim work, completely on-demand.

Also, with cgroup2, memory and cpu always have overlapping control
domains, so the question who to account the work to becomes a much
easier one to answer.

> If I understand this correctly, the use-case is that the job instead
> of direct reclaiming (potentially in latency sensitive tasks), prefers
> a background non-latency sensitive task to do the reclaim. I am
> wondering if we can use the memory.high notification along with a new
> memcg interface (like memory.try_to_free_pages) to implement a user
> space background reclaimer. That would resolve the cpu accounting
> concerns as the user space background reclaimer can share the cpu cost
> with the task.

The idea is not necessarily that the background reclaimer is lower
priority work, but that it can execute in parallel on a separate CPU
instead of being forced into the execution stream of the main work.

So we should be able to fully resolve this problem inside the kernel,
without going through userspace, by accounting CPU cycles used by the
background reclaim worker to the cgroup that is being reclaimed.

> One concern with this approach will be that the memory.high
> notification is too late and the latency sensitive task has faced the
> stall. We can either introduce a threshold notification or another
> notification only limit like memory.near_high which can be set based
> on the job's rate of allocations and when the usage hits this limit
> just notify the user space.

Yeah, I think it would be a pretty drastic expansion of the memory
controller's interface.
