Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7E9E48BFEC
	for <lists+cgroups@lfdr.de>; Wed, 12 Jan 2022 09:30:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349435AbiALIat (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 12 Jan 2022 03:30:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349393AbiALIas (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 12 Jan 2022 03:30:48 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3EBC06173F;
        Wed, 12 Jan 2022 00:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=13bfDwC4Q9dgAZpU/RAeEl2vEaor8KDQuawgF7gUxzo=; b=u4J/qAfmQnxgC0O1RunRdY0Voc
        hgGawk8rMe8I6Z8rdGysGN3Ulzh2Culzl7aB2cSzmp3/sc4Szea2bwv14BiDsqBPtUPHgaGV1JlLY
        L44pdHm06jhzUq14uktN/t+5PHqUiUisq0PNllMY2ZQz7k4Ku+FzQvkxQOzrA6TzYsW05NZMXn+24
        DzRlKhW0CkAU8vAU3QzWP7s+bwzXP57mG/KATB+CmnKNUP/CkdKJJuBejUX/9GINss86dy0PmKrtO
        87gu3XffXlZBy4jPwBjm0QGNQBuAoKj0Z6xVLFzqyw959q5XaCYiehWYitGzI7ig0WbFVQojsAyP2
        N1IAEzjQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n7Z1X-003wtl-NJ; Wed, 12 Jan 2022 08:30:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B3F5B3001FD;
        Wed, 12 Jan 2022 09:30:23 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8E8562B34C7D3; Wed, 12 Jan 2022 09:30:23 +0100 (CET)
Date:   Wed, 12 Jan 2022 09:30:23 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Don <joshdon@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        cgroups@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] cgroup: add cpu.stat_percpu
Message-ID: <Yd6Rn63Rha5NDd1I@hirez.programming.kicks-ass.net>
References: <20220107234138.1765668-1-joshdon@google.com>
 <Yd189wHB2LJcK1Pv@hirez.programming.kicks-ass.net>
 <CABk29NuGs_9uxgbv678W=BGGinZNiUHO5T57FHGbOG+HP-FT2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABk29NuGs_9uxgbv678W=BGGinZNiUHO5T57FHGbOG+HP-FT2g@mail.gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jan 11, 2022 at 03:38:20PM -0800, Josh Don wrote:
> On Tue, Jan 11, 2022 at 4:50 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Fri, Jan 07, 2022 at 03:41:37PM -0800, Josh Don wrote:
> >
> > > +     seq_puts(seq, "usage_usec");
> > > +     for_each_possible_cpu(cpu) {
> > > +             cached_bstat = per_cpu_ptr(&cached_percpu_stats, cpu);
> > > +             val = cached_bstat->cputime.sum_exec_runtime;
> > > +             do_div(val, NSEC_PER_USEC);
> > > +             seq_printf(seq, " %llu", val);
> > > +     }
> > > +     seq_puts(seq, "\n");
> > > +
> > > +     seq_puts(seq, "user_usec");
> > > +     for_each_possible_cpu(cpu) {
> > > +             cached_bstat = per_cpu_ptr(&cached_percpu_stats, cpu);
> > > +             val = cached_bstat->cputime.utime;
> > > +             do_div(val, NSEC_PER_USEC);
> > > +             seq_printf(seq, " %llu", val);
> > > +     }
> > > +     seq_puts(seq, "\n");
> > > +
> > > +     seq_puts(seq, "system_usec");
> > > +     for_each_possible_cpu(cpu) {
> > > +             cached_bstat = per_cpu_ptr(&cached_percpu_stats, cpu);
> > > +             val = cached_bstat->cputime.stime;
> > > +             do_div(val, NSEC_PER_USEC);
> > > +             seq_printf(seq, " %llu", val);
> > > +     }
> > > +     seq_puts(seq, "\n");
> >
> > This is an anti-pattern; given enough CPUs (easy) this will trivially
> > overflow the 1 page seq buffer.
> >
> > People are already struggling to fix existing ABI, lets not make the
> > problem worse.
> 
> Is the concern there just the extra overhead from making multiple
> trips into this handler and re-allocating the buffer until it is large
> enough to take all the output? In that case, we could pre-allocate
> with a size of the right order of magnitude, similar to /proc/stat.
> 
> Lack of per-cpu stats is a gap between cgroup v1 and v2, for which v2
> can easily support this interface given that it already tracks the
> stats percpu internally. I opted to dump them all in a single file
> here, to match the consolidation that occurred from cpuacct->cpu.stat.

Hmm.. fancy new stuff there :-) Yes, I think that would aleviate the
immediate problem. I suppose /proc/interrupts ought to get some of that
too.

Still, I'm not sure having so much data in a single file is wise. But
I've not really kept up with the discussions around this problem much.
