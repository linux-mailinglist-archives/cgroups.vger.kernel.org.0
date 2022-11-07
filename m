Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB8461ECA6
	for <lists+cgroups@lfdr.de>; Mon,  7 Nov 2022 09:10:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbiKGIKw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 7 Nov 2022 03:10:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiKGIKu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 7 Nov 2022 03:10:50 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C47813F4E;
        Mon,  7 Nov 2022 00:10:49 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0197E1F88F;
        Mon,  7 Nov 2022 08:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667808648; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wn3C4j2tq7Ric7uA1MiKmrtd6ucRBH8DGKc7HC5CU8o=;
        b=rDQ0tXHzYEcdlM3iWOS0EHADYuBi7DO5PHDgE5TyXP1fjjQNDPFBRe40t/zcDzPbLvqaPF
        2s6I7xtIEfoHIkCa5kAy7ZgQd3/FDdVOYSDEduOuOH0Fvg1I5oALqj608NhgfgLopujlTT
        /8jE+fvvInBhTN1O/i1aYp8wYC3J7Nw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D097813AC7;
        Mon,  7 Nov 2022 08:10:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FpPsL4e9aGNSIAAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 07 Nov 2022 08:10:47 +0000
Date:   Mon, 7 Nov 2022 09:10:47 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Leonardo =?iso-8859-1?Q?Br=E1s?= <leobras@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v1 0/3] Avoid scheduling cache draining to isolated cpus
Message-ID: <Y2i9h+TRdX9EOs0T@dhcp22.suse.cz>
References: <20221102020243.522358-1-leobras@redhat.com>
 <Y2IwHVdgAJ6wfOVH@dhcp22.suse.cz>
 <07810c49ef326b26c971008fb03adf9dc533a178.camel@redhat.com>
 <Y2Pe45LHANFxxD7B@dhcp22.suse.cz>
 <0183b60e79cda3a0f992d14b4db5a818cd096e33.camel@redhat.com>
 <Y2TQLavnLVd4qHMT@dhcp22.suse.cz>
 <3c4ae3bb70d92340d9aaaa1856928476641a8533.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3c4ae3bb70d92340d9aaaa1856928476641a8533.camel@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri 04-11-22 22:45:58, Leonardo Brás wrote:
> On Fri, 2022-11-04 at 09:41 +0100, Michal Hocko wrote:
> > On Thu 03-11-22 13:53:41, Leonardo Brás wrote:
> > > On Thu, 2022-11-03 at 16:31 +0100, Michal Hocko wrote:
> > > > On Thu 03-11-22 11:59:20, Leonardo Brás wrote:
> > [...]
> > > > > I understand there will be a locking cost being paid in the isolated CPUs when:
> > > > > a) The isolated CPU is requesting the stock drain,
> > > > > b) When the isolated CPUs do a syscall and end up using the protected structure
> > > > > the first time after a remote drain.
> > > > 
> > > > And anytime the charging path (consume_stock resp. refill_stock)
> > > > contends with the remote draining which is out of control of the RT
> > > > task. It is true that the RT kernel will turn that spin lock into a
> > > > sleeping RT lock and that could help with potential priority inversions
> > > > but still quite costly thing I would expect.
> > > > 
> > > > > Both (a) and (b) should happen during a syscall, and IIUC the a rt workload
> > > > > should not expect the syscalls to be have a predictable time, so it should be
> > > > > fine.
> > > > 
> > > > Now I am not sure I understand. If you do not consider charging path to
> > > > be RT sensitive then why is this needed in the first place? What else
> > > > would be populating the pcp cache on the isolated cpu? IRQs?
> > > 
> > > I am mostly trying to deal with drain_all_stock() calling schedule_work_on() at
> > > isolated_cpus. Since the scheduled drain_local_stock() will be competing for cpu
> > > time with the RT workload, we can have preemption of the RT workload, which is a
> > > problem for meeting the deadlines.
> > 
> > Yes, this is understood. But it is not really clear to me why would any
> > draining be necessary for such an isolated CPU if no workload other than
> > the RT (which pressumably doesn't charge any memory?) is running on that
> > CPU? Is that the RT task during the initialization phase that leaves
> > that cache behind or something else?
> 
> (I am new to this part of the code, so please correct me when I miss something.)
> 
> IIUC, if a process belongs to a control group with memory control, the 'charge'
> will happen when a memory page starts getting used by it.

Yes, very broadly speaking.

> So, if we assume a RT load in a isolated CPU will not charge any memory, we are
> assuming it will never be part of a memory-controlled cgroup.

If the memory cgroup controler is enabled then each user space process
is a part of some memcg. If there is no specific memcg assigned then it
will be a root cgroup and that is skipped during most charges except for
kmem.

> I mean, can we just assume this? 
> 
> If I got that right, would not that be considered a limitation? like
> "If you don't want your workload to be interrupted by perCPU cache draining,
> don't put it in a cgroup with memory control".

We definitely do not want userspace make any assumptions on internal
implementation details like caches.

> > Sorry for being so focused on this
> > but I would like to understand on whether this is avoidable by a
> > different startup scheme or it really needs to be addressed in some way.
> 
> No worries, I am in fact happy you are giving it this much attention :)
> 
> I also understand this is a considerable change in the locking strategy, and
> avoiding that is the first thing that should be tried.
> 
> > 
> > > One way I thought to solve that was introducing a remote drain, which would
> > > require a different strategy for locking, since not all accesses to the pcp
> > > caches would happen on a local CPU. 
> > 
> > Yeah, I am not supper happy about additional spin lock TBH. One
> > potential way to go would be to completely avoid pcp cache for isolated
> > CPUs. That would have some performance impact of course but on the other
> > hand it would give a more predictable behavior for those CPUs which
> > sounds like a reasonable compromise to me. What do you think?
> 
> You mean not having a perCPU stock, then? 
> So consume_stock() for isolated CPUs would always return false, causing
> try_charge_memcg() always walking the slow path?

Exactly.

> IIUC, both my proposal and yours would degrade performance only when we use
> isolated CPUs + memcg. Is that correct?

Yes, with a notable difference that with your spin lock option there is
still a chance that the remote draining could influence the isolated CPU
workload throug that said spinlock. If there is no pcp cache for that
cpu being used then there is no potential interaction at all.

> If so, it looks like the impact would be even bigger without perCPU stock ,
> compared to introducing a spinlock.
> 
> Unless, we are counting to this case where a remote CPU is draining an isolated
> CPU, and the isolated CPU faults a page, and has to wait for the spinlock to be
> released in the remote CPU. Well, this seems possible to happen, but I would
> have to analyze how often would it happen, and how much would it impact the
> deadlines. I *guess* most of the RT workload's memory pages are pre-faulted
> before its starts, so it can avoid the faulting latency, but I need to confirm
> that.

Yes, that is a general practice and the reason why I was asking how real
of a problem that is in practice. It is true true that appart from user
space memory which can be under full control of the userspace there are
kernel allocations which can be done on behalf of the process and those
could be charged to memcg as well. So I can imagine the pcp cache could
be populated even if the process is not faulting anything in during RT
sensitive phase.

> On the other hand, compared to how it works now now, this should be a more
> controllable way of introducing latency than a scheduled cache drain.
> 
> Your suggestion on no-stocks/caches in isolated CPUs would be great for
> predictability, but I am almost sure the cost in overall performance would not
> be fine.

It is hard to estimate the overhead without measuring that. Do you think
you can give it a try? If the performance is not really acceptable
(which I would be really surprised) then we can think of a more complex
solution.

> With the possibility of prefaulting pages, do you see any scenario that would
> introduce some undesirable latency in the workload?

My primary concern would be spin lock contention which is hard to
predict with something like remote draining.
-- 
Michal Hocko
SUSE Labs
