Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60EF2164EAD
	for <lists+cgroups@lfdr.de>; Wed, 19 Feb 2020 20:16:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgBSTQV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 19 Feb 2020 14:16:21 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39050 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbgBSTQV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 19 Feb 2020 14:16:21 -0500
Received: by mail-qk1-f193.google.com with SMTP id a141so1201675qkg.6
        for <cgroups@vger.kernel.org>; Wed, 19 Feb 2020 11:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mZCRvJUEd0aeZMSM2KiDRl8M85Gpn4sTqFj3MDhSdPs=;
        b=ZICvLtBj1Wsb4nDHlvOkhJNjp3TK0gM17yFa9MWXljGt5qzSyWPJyOsQ2sFarzK7fo
         BUjh3r6byLkmeK3UhKrBX+McO538JJpggApObSaFa7bl67ekDkGK29iwsMiq41gfPvMX
         4UHHiWljqNjxb1OKPRXzIXh8ymNLCJGtes2Zcn12WpgyyO+0SUmRejsSms4mxW7hSzgU
         nKjNF019p2KE9fxskrQvcbZt5XkL0ZWaIaAcdZtK7/I/2r4+s7VR/gLAVBzZknuwqgPw
         s7kQMRNLecMpnp/YU05mEVI/pqk3i00TvTx+a7189OODFLRBJcRg3laDJqIQubVaU+LO
         924w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mZCRvJUEd0aeZMSM2KiDRl8M85Gpn4sTqFj3MDhSdPs=;
        b=VaGAgfCPTQzXxhewO8cMiKpcHnCxprww0+cmEu1r5qanGrogn7lavDaKHQVjJxwekn
         9yfXKPwht/yXMRsBlO+K/EwVyQPWbtKrq5MZNWWqrGsthVt34YXABpSOtsjyE5rWfaIZ
         RBdtK03xr9YHlibJ+gyVNdu//lumc9rXytWtp8qIL82DpV0eWNRN2GldmHDpepiSBi6P
         Cpjat69w39Hl1BwmJhJNb0Q13nPxCap4VqQ4yKIyVFsbPaSuj9FG6BeWNDhqN4RLkpYx
         13JsL13paMC+dRKqG72iu26284TBx46lWKmWegIvFQUD6zU0Lp8HjZBSKZapKdDcAs3R
         lh/w==
X-Gm-Message-State: APjAAAV+ySMD0uMrUfH1ZlffKrQNMi3WWCPCXhrSxsI3RP6olWgC+1st
        z3343cPBc4YCBtH4W/BfCI6MdQ==
X-Google-Smtp-Source: APXvYqz9amEfdzGX4zShoEWYftKfNorEjDz56/h4hIyjAMq7P48d1ZPghHUVh4aopdc5sI0lKx4huw==
X-Received: by 2002:ae9:e207:: with SMTP id c7mr24017223qkc.128.1582139780194;
        Wed, 19 Feb 2020 11:16:20 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::2:3bde])
        by smtp.gmail.com with ESMTPSA id b84sm310728qkg.90.2020.02.19.11.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 11:16:19 -0800 (PST)
Date:   Wed, 19 Feb 2020 14:16:18 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] mm: memcontrol: asynchronous reclaim for memory.high
Message-ID: <20200219191618.GB54486@cmpxchg.org>
References: <20200219181219.54356-1-hannes@cmpxchg.org>
 <20200219183731.GC11847@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219183731.GC11847@dhcp22.suse.cz>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Feb 19, 2020 at 07:37:31PM +0100, Michal Hocko wrote:
> On Wed 19-02-20 13:12:19, Johannes Weiner wrote:
> > We have received regression reports from users whose workloads moved
> > into containers and subsequently encountered new latencies. For some
> > users these were a nuisance, but for some it meant missing their SLA
> > response times. We tracked those delays down to cgroup limits, which
> > inject direct reclaim stalls into the workload where previously all
> > reclaim was handled my kswapd.
> 
> I am curious why is this unexpected when the high limit is explicitly
> documented as a throttling mechanism.

Memory.high is supposed to curb aggressive growth using throttling
instead of OOM killing. However, if the workload has plenty of easily
reclaimable memory and just needs to recycle a couple of cache pages
to permit an allocation, there is no need to throttle the workload -
just as there wouldn't be any need to trigger the OOM killer.

So it's not unexpected, but it's unnecessarily heavy-handed: since
memory.high allows some flexibility around the target size, we can
move the routine reclaim activity (cache recycling) out of the main
execution stream of the workload, just like we do with kswapd. If that
cannot keep up, we can throttle and do direct reclaim.

It doesn't change the memory.high semantics, but it allows exploiting
the fact that we have SMP systems and can parallize the book keeping.

> > This patch adds asynchronous reclaim to the memory.high cgroup limit
> > while keeping direct reclaim as a fallback. In our testing, this
> > eliminated all direct reclaim from the affected workload.
> 
> Who is accounted for all the work? Unless I am missing something this
> just gets hidden in the system activity and that might hurt the
> isolation. I do see how moving the work to a different context is
> desirable but this work has to be accounted properly when it is going to
> become a normal mode of operation (rather than a rare exception like the
> existing irq context handling).

Yes, the plan is to account it to the cgroup on whose behalf we're
doing the work.

The problem is that we have a general lack of usable CPU control right
now - see Rik's work on this: https://lkml.org/lkml/2019/8/21/1208.
For workloads that are contended on CPU, we cannot enable the CPU
controller because the scheduling latencies are too high. And for
workloads that aren't CPU contended, well, it doesn't really matter
where the reclaim cycles are accounted to.

Once we have the CPU controller up to speed, we can add annotations
like these to account stretches of execution to specific
cgroups. There just isn't much point to do it before we can actually
enable CPU control on the real workloads where it would matter.

[ This is generally work in process: for example, if you isolate
  workloads with memory.low, kswapd cpu time isn't accounted to the
  cgroup that causes it. Swap IO issued by kswapd isn't accounted to
  the group that is getting swapped. The memory consumed by struct
  cgroup itself, the percpu allocations for the vmstat arrays etc.,
  which is sizable, are not accounted to the cgroup that creates
  subgroups, and so forth. ]
