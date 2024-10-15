Return-Path: <cgroups+bounces-5121-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F1499DAA3
	for <lists+cgroups@lfdr.de>; Tue, 15 Oct 2024 02:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5158282E1F
	for <lists+cgroups@lfdr.de>; Tue, 15 Oct 2024 00:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1A98493;
	Tue, 15 Oct 2024 00:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="JccNm6SA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hVn0E9s0"
X-Original-To: cgroups@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B894A23;
	Tue, 15 Oct 2024 00:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728951813; cv=none; b=IcYgXRFk2zYT3R25NRW4kfi5zMbKmaLM7mn6J+sB6cTt60yJEGB7PiV57DODjXtJiY3daiO/7vy4v3k6obFghyexpcq44I29WZ06MWh4yKMS9gqOWi2Mt8QbrVRrijVofpmZtl/v/DBzmizu+H0Gv7UrcACSdxlha2+EVuOB3C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728951813; c=relaxed/simple;
	bh=PF0KkkK2Y6NVAaJwG+aFaCpP/xJFhm856cQjQhdpIHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zg7uuyHd8f0Mr80AZvLGyDJmnC24V2OHL5rui5BN7BcbdiUpgWnF2ybXjCh7hsi7751eb0Sa0D5YB4AUmlVz/UP/MB6PuGf29jKhYNBJ3Vq4NMMQB2uXT6dgoIFOKjRq0N96XXWFDkxCVa+xpB5Y4tFAlfMyn5sDuKxQEt5C9wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=JccNm6SA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hVn0E9s0; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id D06DC1380A24;
	Mon, 14 Oct 2024 20:23:29 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 14 Oct 2024 20:23:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1728951809;
	 x=1729038209; bh=K9W7oqJeeKfbnZ6btzb5m3NnYSN+RzoG8W7iPIj6DY0=; b=
	JccNm6SAPEc+aE0VymV2qgK4+K9z9jtbQTFdHZBixsQANoexLXQuymkbKvxCLUE+
	53Ac4/ZOtjqTXFczpRA5SG8hqzg4GYnRVktWCkAxpmKIeo3x7d6R3lMmPgPAiHwq
	RivK+/3/rfDxRXqAArKOdvVolmZ3whdfy9WMR7RTMzjegRgTurG+l9xco+qziB1w
	Rt+em/zm10ok45un/Q6meYQUFDQotLb0uAcrZlzoBLYaJqnuJdN9a9Y+P52TuFp7
	pszkfPa3Go30D43rLR9ovk5SUyqQNZlnS3WsmRlvmmTJf5hI/sXYKpqRRvWKpxD8
	o6DYIHXcAGY+9C2pMYlkVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728951809; x=
	1729038209; bh=K9W7oqJeeKfbnZ6btzb5m3NnYSN+RzoG8W7iPIj6DY0=; b=h
	Vn0E9s0ov4tkRFfLkn1PK+uqaQSG4q+a+fnBo43W8pkdDRWpUDVmgdmrSe9tZrcD
	GzTXTq4Ve+qCoabdoTeTwKqGWfUz0fpu5JXeIFGa0wj4JBq2Lx4XGenry60dvDZs
	yZWWeMHd13V08HH80i/4tUKTWGWzP1w3pBFCSpfncYeWF/nfVhsvoyTT0mSg7zoL
	ZKD7/md3Ium9nKFREgX+LXdwHtp7cdTVAhRcX8xlcDk42vkkYCXHdhFdPJopDMO/
	K0k0vbvnyQLwIuG4WHXz1Ioq+ElUWp2Y2u3p2hXDnka+suvYwQ7oCEUWYvziYJkk
	nnkpLbWhorQ+y10fC8msg==
X-ME-Sender: <xms:AbYNZ-JlEo-z49KSg7-L0eRwD_8KPoKP0sHDUX0AS3V2PuNbfnmCGA>
    <xme:AbYNZ2KJrKKG95ylRMMwzTModft8-n_9KBDGvaMBNN4v_CNrcSYLThZbdCxcLhVW3
    940sLmKXbnBs2RHow>
X-ME-Received: <xmr:AbYNZ-vinOAdFVfJVs2YiyzgH4DDA5J8siQZdCYmHYycFLUCtwSJ8nlIkLJRx448SXM6KdbJgmN2NMT1gi4k8I4yuIH2FMYO8W3CL0Ro9-OIPA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegiedgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnegfrhhlucfvnfffucdlfeehmdenucfjughrpeffhffvvefukfhf
    gggtugfgjgestheksfdttddtjeenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihuse
    gugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpeffffeggeekjedvjeegheetkedu
    hffgfeegveeklefhgeeuleejhfeljedtkeevffenucffohhmrghinhepghhithhhuhgsrd
    gtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    ugiguhesugiguhhuuhdrgiihiidpnhgspghrtghpthhtohepudehpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopeihohhsrhihrghhmhgvugesghhoohhglhgvrdgtohhmpdhr
    tghpthhtohepshhhrghkvggvlhdrsghuthhtsehlihhnuhigrdguvghvpdhrtghpthhtoh
    eprhhoshhtvgguthesghhoohgumhhishdrohhrghdprhgtphhtthhopegrkhhpmheslhhi
    nhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohephhgrnhhnvghssegtmh
    hpgigthhhgrdhorhhgpdhrtghpthhtohepmhhhohgtkhhosehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehrohhmrghnrdhguhhshhgthhhinheslhhinhhugidruggvvhdprhgtph
    htthhopehmuhgthhhunhdrshhonhhgsehlihhnuhigrdguvghvpdhrtghpthhtohepihhn
    figrrhguvhgvshhsvghlsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:AbYNZzYsM9ZqWHffBcKfA_66k7uRUE8wuPxpdJEP5QK-YO2byGB_1Q>
    <xmx:AbYNZ1Ybjv-yWAHWnFwhJ3VEv-rri-yyPbjXsKhvhWK3132AYELBVQ>
    <xmx:AbYNZ_CDP8S2_nYHZGUSZJTzgiByq9VbYdW-_jhTKFzbwyo3Uff23Q>
    <xmx:AbYNZ7ZectNomQ4ne38VZ8IboUgN28JQgZd1ZJPP7HTcXJGsoRwpug>
    <xmx:AbYNZ-LhL7l5Kl1jx6dl-Q0QXniSQTG5QxA_LcVhuhTrqE52QsP3bF7j>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Oct 2024 20:23:27 -0400 (EDT)
Date: Mon, 14 Oct 2024 18:23:26 -0600
From: Daniel Xu <dxu@dxuuu.xyz>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, 
	Steven Rostedt <rostedt@goodmis.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	JP Kobryn <inwardvessel@gmail.com>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>, bpf@vger.kernel.org, 
	Martin KaFai Lau <martin.lau@linux.dev>
Subject: Re: [PATCH] memcg: add tracing for memcg stat updates
Message-ID: <cwibnvqnbtfc7sgpkidh24dcnj2xdb462rf6hndgynqezbzbaf@qog4zl25sqry>
References: <20241010003550.3695245-1-shakeel.butt@linux.dev>
 <CAJD7tkYq+dduc7+M=9TkR6ZAiBYrVyUsF_AuwPqaQNrsfH_qfg@mail.gmail.com>
 <20241009210848.43adb0c3@gandalf.local.home>
 <CAJD7tkaLQwVphoLiwh8-NTyav36_gAVdzB=gC_qXzv7ti9TzmA@mail.gmail.com>
 <mt474r4yn346in5akhyziwxrh4ip5wukh4fjbhwzfl26wq64nf@xgbv4dtfs3ak>
 <CAJD7tkYzo_K9uF7GOO3yoKzTSbFWuNTUG3O6w1VrGCQvgWhsoQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkYzo_K9uF7GOO3yoKzTSbFWuNTUG3O6w1VrGCQvgWhsoQ@mail.gmail.com>

Hi Yosry,

On Mon, Oct 14, 2024 at 05:15:39PM GMT, Yosry Ahmed wrote:
> On Thu, Oct 10, 2024 at 10:26 AM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> >
> > On Wed, Oct 09, 2024 at 06:24:55PM GMT, Yosry Ahmed wrote:
> > > On Wed, Oct 9, 2024 at 6:08 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> > > >
> > > > On Wed, 9 Oct 2024 17:46:22 -0700
> > > > Yosry Ahmed <yosryahmed@google.com> wrote:
> > > >
> > > > > > +++ b/mm/memcontrol.c
> > > > > > @@ -71,6 +71,10 @@
> > > > > >
> > > > > >  #include <linux/uaccess.h>
> > > > > >
> > > > > > +#define CREATE_TRACE_POINTS
> > > > > > +#include <trace/events/memcg.h>
> > > > > > +#undef CREATE_TRACE_POINTS
> > > > > > +
> > > > > >  #include <trace/events/vmscan.h>
> > > > > >
> > > > > >  struct cgroup_subsys memory_cgrp_subsys __read_mostly;
> > > > > > @@ -682,7 +686,9 @@ void __mod_memcg_state(struct mem_cgroup *memcg, enum memcg_stat_item idx,
> > > > > >                 return;
> > > > > >
> > > > > >         __this_cpu_add(memcg->vmstats_percpu->state[i], val);
> > > > > > -       memcg_rstat_updated(memcg, memcg_state_val_in_pages(idx, val));
> > > > > > +       val = memcg_state_val_in_pages(idx, val);
> > > > > > +       memcg_rstat_updated(memcg, val);
> > > > > > +       trace_mod_memcg_state(memcg, idx, val);
> > > > >
> > > > > Is it too unreasonable to include the stat name?
> > > > >
> > > > > The index has to be correlated with the kernel config and perhaps even
> > > > > version. It's not a big deal, but if performance is not a concern when
> > > > > tracing is enabled anyway, maybe we can lookup the name here (or in
> > > > > TP_fast_assign()).
> > > >
> > > > What name? Is it looked up from idx? If so, you can do it on the reading of
> >
> > Does reading side mean the one reading /sys/kernel/tracing/trace will do
> > the translation from enums to string?
> >
> > > > the trace event where performance is not an issue. See the __print_symbolic()
> > > > and friends in samples/trace_events/trace-events-sample.h
> > >
> > > Yeah they can be found using idx. Thanks for referring us to
> > > __print_symbolic(), I suppose for this to work we need to construct an
> > > array of {idx, name}. I think we can replace the existing memory_stats
> > > and memcg1_stats/memcg1_stat_names arrays with something that we can
> > > reuse for tracing, so we wouldn't need to consume extra space.
> > >
> > > Shakeel, what do you think?
> >
> > Cc Daniel & Martin
> >
> > I was planning to use bpftrace which can use dwarf/btf to convert the
> > raw int to its enum string. Martin provided the following command to
> > extract the translation from the kernel.
> >
> > $ bpftool btf dump file /sys/kernel/btf/vmlinux | grep -A10 node_stat_item
> > [2264] ENUM 'node_stat_item' encoding=UNSIGNED size=4 vlen=46
> >         'NR_LRU_BASE' val=0
> >         'NR_INACTIVE_ANON' val=0
> >         'NR_ACTIVE_ANON' val=1
> >         'NR_INACTIVE_FILE' val=2
> >         'NR_ACTIVE_FILE' val=3
> >         'NR_UNEVICTABLE' val=4
> >         'NR_SLAB_RECLAIMABLE_B' val=5
> >         'NR_SLAB_UNRECLAIMABLE_B' val=6
> >         'NR_ISOLATED_ANON' val=7
> >         'NR_ISOLATED_FILE' val=8
> > ...
> >
> > My point is userspace tools can use existing infra to extract this
> > information.
> >
> > However I am not against adding __print_symbolic() (but without any
> > duplication), so users reading /sys/kernel/tracing/trace directly can
> > see more useful information as well. Please post a follow up patch after
> > this one.
> 
> I briefly looked into this and I think it would be annoying to have
> this, unfortunately. Even if we rework the existing arrays with memcg
> stat names to be in a format conforming to tracing, we would need to
> move them out to a separate header to avoid a circular dependency.
> 
> Additionally, for __count_memcg_events() things will be more
> complicated because the names are not in an array in memcontrol.c, but
> we use vm_event_name() and the relevant names are part of a larger
> array, vmstat_text, which we would need to rework similarly.
> 
> I think this would be easier to implement if we can somehow provide a
> callback that returns the name based on the index, rather than an
> array. But even then, we would need to specify a different callback
> for each event, so it won't be as simple as specifying the callback in
> the event class.
> 
> All in all, unless we realize there is something that is fundamentally
> more difficult to do in userspace, I think it's not worth adding this
> unfortunately :/

Turned out to be quite straightforward to do in userspace:
https://github.com/bpftrace/bpftrace/pull/3515 .

A nice property is the resolution occurs out of line and saves the
kernel some cycles in the fast path.

Thanks,
Daniel

