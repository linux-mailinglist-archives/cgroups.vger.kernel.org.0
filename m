Return-Path: <cgroups+bounces-10569-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F11FDBBF31E
	for <lists+cgroups@lfdr.de>; Mon, 06 Oct 2025 22:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 940F84E376A
	for <lists+cgroups@lfdr.de>; Mon,  6 Oct 2025 20:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA96244685;
	Mon,  6 Oct 2025 20:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uKjbHzCh"
X-Original-To: cgroups@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A3817DFE7
	for <cgroups@vger.kernel.org>; Mon,  6 Oct 2025 20:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759782789; cv=none; b=FwSMAeuZEO1kANe7aB3H/vIUmVgq7UkqA/nnDLDC/svJBzIiMmDqLwxRmWgcrMZxAaovAg5C+8OjoVtj8XZl6A/6QcMTMnvjBtcD13igSPHcvTzcbrRAM0B16KoFbGcGnHQTwF009huaeUwo6BWA3dbra7qXJphfvARIdCALt3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759782789; c=relaxed/simple;
	bh=LhWazHeSgl/2OumXm4GVNbbgKcVFqn2w2hSeAUjf9eg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fL0ekN95TKafNn09Gl19by1kI9dRWwanVN2QilKxjWbusL7+gMpJ0YQ07DkxRgGRtcVC0S+XSpzCSkQNRYQsKxrHYIsNUsXb8VOaBo6JSKm2xYW5xGHcR0kHtWPDQcQADqpv7Wr22/tCm7Jgeq0swZIhDzwWk1KD7r1G7CE7hSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uKjbHzCh; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 6 Oct 2025 13:32:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759782781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JHH+4bf3hlBlZ1LmstUIJffws4jWpMP8V0lgu/gJTUg=;
	b=uKjbHzChnzx2wm6WdKX0G2O+LfEbF03GVh9A/3b/TBEuOow+68ow8vPjH+P53r8tVxfIYY
	Xy3oB/BjxBm/7ZPUpEhPclJ5X/SBvU6wHFNuj3oRMrkCbsVeg6scn9Vmaf+j15PBbZiWt8
	JoZsT/ZOhVwDT9f/n4F61TteGGFb/OA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: JP Kobryn <inwardvessel@gmail.com>, 
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, Yosry Ahmed <yosryahmed@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, 
	"open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, bpf <bpf@vger.kernel.org>, 
	Kernel Team <kernel-team@meta.com>
Subject: Re: [PATCH] memcg: introduce kfuncs for fetching memcg stats
Message-ID: <galnconmnd4uoupb5dfa7nbfmpeovpjnov6fnxa56sslejl5em@fmhbdnn5v25e>
References: <20251001045456.313750-1-inwardvessel@gmail.com>
 <CAADnVQKQpEsgoR5xw0_32deMqT4Pc7ZOo8jwJWkarcOrZijPzw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQKQpEsgoR5xw0_32deMqT4Pc7ZOo8jwJWkarcOrZijPzw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Oct 01, 2025 at 03:25:22PM -0700, Alexei Starovoitov wrote:
> On Tue, Sep 30, 2025 at 9:57 PM JP Kobryn <inwardvessel@gmail.com> wrote:
> >
> > When reading cgroup memory.stat files there is significant work the kernel
> > has to perform in string formatting the numeric data to text. Once a user
> > mode program gets this text further work has to be done, converting the
> > text back to numeric data. This work can be expensive for programs that
> > periodically sample this data over a large enough fleet.
> >
> > As an alternative to reading memory.stat, introduce new kfuncs to allow
> > fetching specific memcg stats from within bpf cgroup iterator programs.
> > This approach eliminates the conversion work done by both the kernel and
> > user mode programs. Previously a program could open memory.stat and
> > repeatedly read from the associated file descriptor (while seeking back to
> > zero before each subsequent read). That action can now be replaced by
> > setting up a link to the bpf program once in advance and then reusing it to
> > invoke the cgroup iterator program each time a read is desired. An example
> > program can be found here [0].
> >
> > There is a significant perf benefit when using this approach. In terms of
> > elapsed time, the kfuncs allow a bpf cgroup iterator program to outperform
> > the traditional file reading method, saving almost 80% of the time spent in
> > kernel.
> >
> > control: elapsed time
> > real    0m14.421s
> > user    0m0.183s
> > sys     0m14.184s
> >
> > experiment: elapsed time
> > real    0m3.250s
> > user    0m0.225s
> > sys     0m2.916s
> 
> Nice, but github repo somewhere doesn't guarantee that
> the work is equivalent.
> Please add it as a selftest/bpf instead.
> Like was done in commit
> https://lore.kernel.org/bpf/20200509175921.2477493-1-yhs@fb.com/
> to demonstrate equivalence of 'cat /proc' vs iterator approach.

+1.

> 
> >
> > control: perf data
> > 22.24% a.out [kernel.kallsyms] [k] vsnprintf
> > 17.35% a.out [kernel.kallsyms] [k] format_decode
> > 12.60% a.out [kernel.kallsyms] [k] string
> > 12.12% a.out [kernel.kallsyms] [k] number
> >  8.06% a.out [kernel.kallsyms] [k] strlen
> >  5.21% a.out [kernel.kallsyms] [k] memcpy_orig
> >  4.26% a.out [kernel.kallsyms] [k] seq_buf_printf
> >  4.19% a.out [kernel.kallsyms] [k] memory_stat_format
> >  2.53% a.out [kernel.kallsyms] [k] widen_string
> >  1.62% a.out [kernel.kallsyms] [k] put_dec_trunc8
> >  0.99% a.out [kernel.kallsyms] [k] put_dec_full8
> >  0.72% a.out [kernel.kallsyms] [k] put_dec
> >  0.70% a.out [kernel.kallsyms] [k] memcpy
> >  0.60% a.out [kernel.kallsyms] [k] mutex_lock
> >  0.59% a.out [kernel.kallsyms] [k] entry_SYSCALL_64
> >
> > experiment: perf data
> > 8.17% memcgstat bpf_prog_c6d320d8e5cfb560_query [k] bpf_prog_c6d320d8e5cfb560_query
> > 8.03% memcgstat [kernel.kallsyms] [k] memcg_node_stat_fetch
> > 5.21% memcgstat [kernel.kallsyms] [k] __memcg_slab_post_alloc_hook
> > 3.87% memcgstat [kernel.kallsyms] [k] _raw_spin_lock
> > 3.01% memcgstat [kernel.kallsyms] [k] entry_SYSRETQ_unsafe_stack
> > 2.49% memcgstat [kernel.kallsyms] [k] memcg_vm_event_fetch
> > 2.47% memcgstat [kernel.kallsyms] [k] __memcg_slab_free_hook
> > 2.34% memcgstat [kernel.kallsyms] [k] kmem_cache_free
> > 2.32% memcgstat [kernel.kallsyms] [k] entry_SYSCALL_64
> > 1.92% memcgstat [kernel.kallsyms] [k] mutex_lock
> >
> > The overhead of string formatting and text conversion on the control side
> > is eliminated on the experimental side since the values are read directly
> > through shared memory with the bpf program. The kfunc/bpf approach also
> > provides flexibility in how this numeric data could be delivered to a user
> > mode program. It is possible to use a struct for example, with select
> > memory stat fields instead of an array. This opens up opportunities for
> > custom serialization as well since it is totally up to the bpf programmer
> > on how to lay out the data.
> >
> > The patch also includes a kfunc for flushing stats. This is not required
> > for fetching stats, since the kernel periodically flushes memcg stats every
> > 2s. It is up to the programmer if they want the very latest stats or not.
> >
> > [0] https://gist.github.com/inwardvessel/416d629d6930e22954edb094b4e23347
> >     https://gist.github.com/inwardvessel/28e0a9c8bf51ba07fa8516bceeb25669
> >     https://gist.github.com/inwardvessel/b05e1b9ea0f766f4ad78dad178c49703
> >
> > Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
> > ---
> >  mm/memcontrol.c | 67 +++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 67 insertions(+)
> >
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 8dd7fbed5a94..aa8cbf883d71 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -870,6 +870,73 @@ unsigned long memcg_events_local(struct mem_cgroup *memcg, int event)
> >  }
> >  #endif
> >
> > +static inline struct mem_cgroup *memcg_from_cgroup(struct cgroup *cgrp)
> > +{
> > +       return cgrp ? mem_cgroup_from_css(cgrp->subsys[memory_cgrp_id]) : NULL;
> > +}
> > +
> > +__bpf_kfunc static void memcg_flush_stats(struct cgroup *cgrp)
> > +{
> > +       struct mem_cgroup *memcg = memcg_from_cgroup(cgrp);
> > +
> > +       if (!memcg)
> > +               return;
> > +
> > +       mem_cgroup_flush_stats(memcg);
> > +}
> 
> css_rstat_flush() is sleepable, so this kfunc must be sleepable too.
> Not sure about the rest.
> 
> > +
> > +__bpf_kfunc static unsigned long memcg_node_stat_fetch(struct cgroup *cgrp,
> > +               enum node_stat_item item)
> > +{
> > +       struct mem_cgroup *memcg = memcg_from_cgroup(cgrp);
> > +
> > +       if (!memcg)
> > +               return 0;
> > +
> > +       return memcg_page_state_output(memcg, item);
> > +}
> > +
> > +__bpf_kfunc static unsigned long memcg_stat_fetch(struct cgroup *cgrp,
> > +               enum memcg_stat_item item)
> > +{
> > +       struct mem_cgroup *memcg = memcg_from_cgroup(cgrp);
> > +
> > +       if (!memcg)
> > +               return 0;
> > +
> > +       return memcg_page_state_output(memcg, item);
> > +}
> > +
> > +__bpf_kfunc static unsigned long memcg_vm_event_fetch(struct cgroup *cgrp,
> > +               enum vm_event_item item)
> > +{
> > +       struct mem_cgroup *memcg = memcg_from_cgroup(cgrp);
> > +
> > +       if (!memcg)
> > +               return 0;
> > +
> > +       return memcg_events(memcg, item);
> > +}
> > +
> > +BTF_KFUNCS_START(bpf_memcontrol_kfunc_ids)
> > +BTF_ID_FLAGS(func, memcg_flush_stats)
> > +BTF_ID_FLAGS(func, memcg_node_stat_fetch)
> > +BTF_ID_FLAGS(func, memcg_stat_fetch)
> > +BTF_ID_FLAGS(func, memcg_vm_event_fetch)
> > +BTF_KFUNCS_END(bpf_memcontrol_kfunc_ids)
> 
> At least one of them must be sleepable and the rest probably too?
> All of them must be KF_TRUSTED_ARGS too.

The *_fetch ones don't need to be sleepable. Will marking them sleepable
here make them more restrictive?

> 
> > +
> > +static const struct btf_kfunc_id_set bpf_memcontrol_kfunc_set = {
> > +       .owner          = THIS_MODULE,
> > +       .set            = &bpf_memcontrol_kfunc_ids,
> > +};
> > +
> > +static int __init bpf_memcontrol_kfunc_init(void)
> > +{
> > +       return register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING,
> > +                                        &bpf_memcontrol_kfunc_set);
> > +}
> 
> Why tracing only?

I can see sched_ext using these to make fancy scheduling decisions and
definitely bpf oom-killer will need these.

