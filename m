Return-Path: <cgroups+bounces-5096-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B59998E4C
	for <lists+cgroups@lfdr.de>; Thu, 10 Oct 2024 19:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A2D91F252AF
	for <lists+cgroups@lfdr.de>; Thu, 10 Oct 2024 17:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9C319CCEA;
	Thu, 10 Oct 2024 17:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Dic41h+A"
X-Original-To: cgroups@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5388719C567
	for <cgroups@vger.kernel.org>; Thu, 10 Oct 2024 17:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728581215; cv=none; b=J5arsqyBjzI/kpo0C/Q9C3DSUpEBxvym8hbwjOJIjInctb3vqrQ+YlSZpTkNDD6XS0lnshVOPvHcAfLG4lQOVZT6dZvrUHXnzDeLsjMDOVKFPjGjkT45bBGi33LcNzNc7aVK9urioAMV1y+q63AvVc60xzTMez4kGERxQf5pSPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728581215; c=relaxed/simple;
	bh=VSwejWraDl+HuFTGO8vtSWlCvVIuL+5MpcBlUBbGQcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DJFPRc4pdnIOVL5l5DhPMRUWfcd/ZjBJn9G1Vwu/VN6Fw41aVDfQ0oc6jCBIu1Y/LUiKWxKboVye1b7rIq9EtLvb9L22t8u8k4VDBEP5Y2o7zVh8h+GMdjoimRw+ihXtNZiIA8YghqfGyqWEcqoPZ41F9pO3RdLqs15sznRf2fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Dic41h+A; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 10 Oct 2024 10:26:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728581211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T74j4BfBpF8MtvJMwEYG2DbO+zpXeVI3CcEFUfNAPFM=;
	b=Dic41h+AbX+RzAqWdAMNaEJikD2+y1U1sEX+56cJGZXBafhhQ2gfOqLMSq9P3REaA1v1st
	n8iqjSsfKysCfa2dtz/0HV4qjXztDK4hTlxWeVQW8PHL7JDwmPb89qvClg4lwNpZAaKOgn
	izA1d4jTrT6XeholR+OaDwgMg7nPJu0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, JP Kobryn <inwardvessel@gmail.com>, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>, Daniel Xu <dxu@dxuuu.xyz>, bpf@vger.kernel.org, 
	Martin KaFai Lau <martin.lau@linux.dev>
Subject: Re: [PATCH] memcg: add tracing for memcg stat updates
Message-ID: <mt474r4yn346in5akhyziwxrh4ip5wukh4fjbhwzfl26wq64nf@xgbv4dtfs3ak>
References: <20241010003550.3695245-1-shakeel.butt@linux.dev>
 <CAJD7tkYq+dduc7+M=9TkR6ZAiBYrVyUsF_AuwPqaQNrsfH_qfg@mail.gmail.com>
 <20241009210848.43adb0c3@gandalf.local.home>
 <CAJD7tkaLQwVphoLiwh8-NTyav36_gAVdzB=gC_qXzv7ti9TzmA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkaLQwVphoLiwh8-NTyav36_gAVdzB=gC_qXzv7ti9TzmA@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Oct 09, 2024 at 06:24:55PM GMT, Yosry Ahmed wrote:
> On Wed, Oct 9, 2024 at 6:08 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > On Wed, 9 Oct 2024 17:46:22 -0700
> > Yosry Ahmed <yosryahmed@google.com> wrote:
> >
> > > > +++ b/mm/memcontrol.c
> > > > @@ -71,6 +71,10 @@
> > > >
> > > >  #include <linux/uaccess.h>
> > > >
> > > > +#define CREATE_TRACE_POINTS
> > > > +#include <trace/events/memcg.h>
> > > > +#undef CREATE_TRACE_POINTS
> > > > +
> > > >  #include <trace/events/vmscan.h>
> > > >
> > > >  struct cgroup_subsys memory_cgrp_subsys __read_mostly;
> > > > @@ -682,7 +686,9 @@ void __mod_memcg_state(struct mem_cgroup *memcg, enum memcg_stat_item idx,
> > > >                 return;
> > > >
> > > >         __this_cpu_add(memcg->vmstats_percpu->state[i], val);
> > > > -       memcg_rstat_updated(memcg, memcg_state_val_in_pages(idx, val));
> > > > +       val = memcg_state_val_in_pages(idx, val);
> > > > +       memcg_rstat_updated(memcg, val);
> > > > +       trace_mod_memcg_state(memcg, idx, val);
> > >
> > > Is it too unreasonable to include the stat name?
> > >
> > > The index has to be correlated with the kernel config and perhaps even
> > > version. It's not a big deal, but if performance is not a concern when
> > > tracing is enabled anyway, maybe we can lookup the name here (or in
> > > TP_fast_assign()).
> >
> > What name? Is it looked up from idx? If so, you can do it on the reading of

Does reading side mean the one reading /sys/kernel/tracing/trace will do
the translation from enums to string?

> > the trace event where performance is not an issue. See the __print_symbolic()
> > and friends in samples/trace_events/trace-events-sample.h
> 
> Yeah they can be found using idx. Thanks for referring us to
> __print_symbolic(), I suppose for this to work we need to construct an
> array of {idx, name}. I think we can replace the existing memory_stats
> and memcg1_stats/memcg1_stat_names arrays with something that we can
> reuse for tracing, so we wouldn't need to consume extra space.
> 
> Shakeel, what do you think?

Cc Daniel & Martin

I was planning to use bpftrace which can use dwarf/btf to convert the
raw int to its enum string. Martin provided the following command to
extract the translation from the kernel.

$ bpftool btf dump file /sys/kernel/btf/vmlinux | grep -A10 node_stat_item
[2264] ENUM 'node_stat_item' encoding=UNSIGNED size=4 vlen=46
        'NR_LRU_BASE' val=0
        'NR_INACTIVE_ANON' val=0
        'NR_ACTIVE_ANON' val=1
        'NR_INACTIVE_FILE' val=2
        'NR_ACTIVE_FILE' val=3
        'NR_UNEVICTABLE' val=4
        'NR_SLAB_RECLAIMABLE_B' val=5
        'NR_SLAB_UNRECLAIMABLE_B' val=6
        'NR_ISOLATED_ANON' val=7
        'NR_ISOLATED_FILE' val=8
...

My point is userspace tools can use existing infra to extract this
information.

However I am not against adding __print_symbolic() (but without any
duplication), so users reading /sys/kernel/tracing/trace directly can
see more useful information as well. Please post a follow up patch after
this one.

thanks for the review,
Shakeel


