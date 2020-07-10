Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4D421BE12
	for <lists+cgroups@lfdr.de>; Fri, 10 Jul 2020 21:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbgGJTr6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 10 Jul 2020 15:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbgGJTr6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 10 Jul 2020 15:47:58 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 317B6C08C5DC
        for <cgroups@vger.kernel.org>; Fri, 10 Jul 2020 12:47:58 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id q17so2971258pfu.8
        for <cgroups@vger.kernel.org>; Fri, 10 Jul 2020 12:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=X/bhJVH4Z/Kjvby2GJi4o7Q1aq6zY54gp6tbOmIrn+w=;
        b=KOmBxNYKEcz1INauW1pGspVS0AvuJ/0+83NMJtWdupzDG7UlNSLxFR2N7EWRFOWs8l
         2VsNtXAmzvqJeR4zwCjr3z6dGfGynkQyJ+Qb3Fv7p3YAWlQMV4fklY7UYuuke8fau/sS
         cnVFgeFRpO8wZADUIiPsIJw4+vpiW2qlZF29QfP0ESU3ylBcq1roMULt4IYbYV5nVWhS
         StDOZNDjfghavZGUQuqLqlLFvNcoErz6EWw+yifquReYkwx1dxXgT0YTRRT+SiOXC5QR
         V3qEhpHWoFLoLZrNSUwcHbuxfOivxsGLhc/tso5hxRI7oPfTnWg7QhCUOu+E0gRPGsT/
         uMFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=X/bhJVH4Z/Kjvby2GJi4o7Q1aq6zY54gp6tbOmIrn+w=;
        b=UNk06Cqs9YqLrHnj+G+I3U7FPr5HXmuOaAFinK1eeJ6pYCg/pvNy6BhIg9ZaKpGR0N
         kJObnyq6Dch5buChCJVWazPvTXYX8ZOJJiHm/rF4Zg2GehPY+syVUG1A7nXkKySXGvJi
         HzZgUMPy5LH1iJiQGFW4g5Va8Q5tnPO18szKidU+P/se+IDIlTIKurHqiHW4qaB+unYn
         Ucj6RuyZJRx8XeA+VB4hWdHcjsxFmhSVFV2I7qX8pSD5/uaKPU73lI91JUrnSuDOAl31
         bH7VT0AmYfaT7fak1Xts6BWM5o90NF5R2rght5t5km3ihKfTUjAvdWVXVjVfbVL+tzhl
         OUCw==
X-Gm-Message-State: AOAM531a6QDlHyPqRBK/a7tuZ7uvzjWDg9r3PG7rzwhtNaL86y7UNyu/
        Jq7HqNJqhxns/EB8vad7x6oKiQ==
X-Google-Smtp-Source: ABdhPJz/YYUHWn+Wqs/Ff7DdxfueFSUCzEJ0TmyJa26+0Xa2wcUUZFn64NUHLVMVt2ZzQSKTUlzpBw==
X-Received: by 2002:a65:67d9:: with SMTP id b25mr60926739pgs.311.1594410477408;
        Fri, 10 Jul 2020 12:47:57 -0700 (PDT)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id nk22sm6346203pjb.51.2020.07.10.12.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 12:47:56 -0700 (PDT)
Date:   Fri, 10 Jul 2020 12:47:55 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Michal Hocko <mhocko@kernel.org>
cc:     Shakeel Butt <shakeelb@google.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Roman Gushchin <guro@fb.com>, Greg Thelen <gthelen@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>
Subject: Re: Memcg stat for available memory
In-Reply-To: <alpine.DEB.2.23.453.2007071210410.396729@chino.kir.corp.google.com>
Message-ID: <alpine.DEB.2.23.453.2007101223470.1178541@chino.kir.corp.google.com>
References: <alpine.DEB.2.22.394.2006281445210.855265@chino.kir.corp.google.com> <CALvZod5Zv33oNLxS_8TyGV_QT4CsBjiEuocxpt2+U-XDMaFDPw@mail.gmail.com> <20200703081538.GO18446@dhcp22.suse.cz>
 <alpine.DEB.2.23.453.2007071210410.396729@chino.kir.corp.google.com>
User-Agent: Alpine 2.23 (DEB 453 2020-06-18)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, 7 Jul 2020, David Rientjes wrote:

> Another use case would be motivated by exactly the MemAvailable use case: 
> when bound to a memcg hierarchy, how much memory is available without 
> substantial swap or risk of oom for starting a new process or service?  
> This would not trigger any memory.low or PSI notification but is a 
> heuristic that can be used to determine what can and cannot be started 
> without incurring substantial memory reclaim.
> 
> I'm indifferent to whether this would be a "reclaimable" or "available" 
> metric, with a slight preference toward making it as similar in 
> calculation to MemAvailable as possible, so I think the question is 
> whether this is something the user should be deriving themselves based on 
> memcg stats that are exported or whether we should solidify this based on 
> how the kernel handles reclaim as a metric that will carry over across 
> kernel vesions?
> 

To try to get more discussion on the subject, consider a malloc 
implementation, like tcmalloc, that does MADV_DONTNEED to free memory back 
to the system and how this freed memory is then described to userspace 
depending on the kernel implementation.

 [ For the sake of this discussion, consider we have precise memcg stats 
   available to us although the actual implementation allows for some
   variance (MEMCG_CHARGE_BATCH). ]

With a 64MB heap backed by thp on x86, for example, the vma starts with an 
rss of 64MB, all of which is anon and backed by hugepages.  Imagine some 
aggressive MADV_DONTNEED freeing that ends up with only a single 4KB page 
mapped in each 2MB aligned range.  The rss is now 32 * 4KB = 128KB.

Before freeing, anon, anon_thp, and active_anon in memory.stat would all 
be the same for this vma (64MB).  64MB would also be charged to 
memory.current.  That's all working as intended and to the expectation of 
userspace.

After freeing, however, we have the kernel implementation specific detail 
of how huge pmd splitting is handled (rss) in comparison to the underlying 
split of the compound page (deferred split queue).  The huge pmd is always 
split synchronously after MADV_DONTNEED so, as mentioned, the rss is 128KB 
for this vma and none of it is backed by thp.

What is charged to the memcg (memory.current) and what is on active_anon 
is unchanged, however, because the underlying compound pages are still 
charged to the memcg.  The amount of anon and anon_thp are decreased 
in compliance with the splitting of the page tables, however.

So after freeing, for this vma: anon = 128KB, anon_thp = 0, 
active_anon = 64MB, memory.current = 64MB.

In this case, because of the deferred split queue, which is a kernel 
implementation detail, userspace may be unclear on what is actually 
reclaimable -- and this memory is reclaimable under memory pressure.  For 
the motivation of MemAvailable (what amount of memory is available for 
starting new work), userspace *could* determine this through the 
aforementioned active_anon - anon (or some combination of
memory.current - anon - file - slab), but I think it's a fair point that 
userspace's view of reclaimable memory as the kernel implementation 
changes is something that can and should remain consistent between 
versions.

Otherwise, an earlier implementation before deferred split queues could 
have safely assumed that active_anon was unreclaimable unless swap were 
enabled.  It doesn't have the foresight based on future kernel 
implementation detail to reconcile what the amount of reclaimable memory 
actually is.

Same discussion could happen for lazy free memory which is anon but now 
appears on the file lru stats and not the anon lru stats: it's easily 
reclaimable under memory pressure but you need to reconcile the difference 
between the anon metric and what is revealed in the anon lru stats.

That gave way to my original thought of a si_mem_available()-like 
calculation ("avail") by doing

	free = memory.high - memory.current
	lazyfree = file - (active_file + inactive_file)
	deferred = active_anon - anon

	avail = free + lazyfree + deferred +
		(active_file + inactive_file + slab_reclaimable) / 2

And we have the ability to change this formula based on kernel 
implementation details as they evolve.  Idea is to provide a consistent 
field that userspace can use to determine the rough amount of reclaimable 
memory in a MemAvailable-like way.
