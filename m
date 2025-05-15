Return-Path: <cgroups+bounces-8217-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 001C6AB8A7C
	for <lists+cgroups@lfdr.de>; Thu, 15 May 2025 17:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B7577A8320
	for <lists+cgroups@lfdr.de>; Thu, 15 May 2025 15:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CCDB20C026;
	Thu, 15 May 2025 15:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QV9VfrW/"
X-Original-To: cgroups@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407B91FBC94
	for <cgroups@vger.kernel.org>; Thu, 15 May 2025 15:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747322548; cv=none; b=aYRDrfc+uYcH1xSMPBMxjEc5ZiC9OpdWpIdZyfmmTAlAOpIC8+v1mm/Rw93nB1sXeSs/Z09gujsKzX0m/nLIvBha1ivjGCdLfnBgZVoYzOK/e1xmZ3CgzfP389D7S2h4DyAEzHDt296sQM8VZRjgEt+hJzkp7qubMJJn4cwB23w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747322548; c=relaxed/simple;
	bh=DtbKoPm9LwKQqbxkLMiVq+Mp3S9/2W6TBx+7BgXsu8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FU1D+5ovqmLZDvjzHcmNwYh277ScPaMjjatKA5/ENZQvEk50ABh4p2e8MmZfX1KrHIvl+fS7e6UIzwk0O1+4cxZSsXd/nZLvyu5dJkiAc8ENTI7gFYsfJhVJ29Hw6IzsXcwUKfaGUFdobTU6R+maB87s0Xk0rjA8t/ep1F3/ptU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QV9VfrW/; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 15 May 2025 08:22:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747322543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BKemoW9RKBpGwi/CtDte4HwNTYROA1s2q7+99WZ3tcQ=;
	b=QV9VfrW/v0GXkrsEDb2xKJaIwT9NJMMpeAiHn2qBRFhlAFsJ3hSSQ/eK/C1SACdKPcYVNU
	0Ph/XJym8FNFThe6+h11oclXv3eWJA+edGYcPcJOMSk8TqElMpMRzLNNacQlaXTO/m/Fea
	xwVpLZ0LKR+3SukCodQnILPplzNYHbM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Vlastimil Babka <vbabka@suse.cz>, Alexei Starovoitov <ast@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Harry Yoo <harry.yoo@oracle.com>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, bpf@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH v2 1/7] memcg: memcg_rstat_updated re-entrant safe
 against irqs
Message-ID: <bdxkbztn63ey4pndh3hfzope2bnysw6yyqqzfu2sdjue2glujy@5eqev4hldzxq>
References: <20250514184158.3471331-1-shakeel.butt@linux.dev>
 <20250514184158.3471331-2-shakeel.butt@linux.dev>
 <22f69e6e-7908-4e92-96ca-5c70d535c439@lucifer.local>
 <CAGj-7pUJQZD59Sx7E69Uvi1++dB59R8wWkDYvSTGYhU-18AHXg@mail.gmail.com>
 <a0328dd3-db4a-430a-9018-db796d0cf76e@lucifer.local>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a0328dd3-db4a-430a-9018-db796d0cf76e@lucifer.local>
X-Migadu-Flow: FLOW_OUT

On Thu, May 15, 2025 at 03:53:17PM +0100, Lorenzo Stoakes wrote:
> On Thu, May 15, 2025 at 07:31:09AM -0700, Shakeel Butt wrote:
> > On Thu, May 15, 2025 at 5:47 AM Lorenzo Stoakes
> > <lorenzo.stoakes@oracle.com> wrote:
> > >
> > > Shakeel - This breaks the build in mm-new for me:
> > >
> > >   CC      mm/pt_reclaim.o
> > > In file included from ./arch/x86/include/asm/rmwcc.h:5,
> > >                  from ./arch/x86/include/asm/bitops.h:18,
> > >                  from ./include/linux/bitops.h:68,
> > >                  from ./include/linux/radix-tree.h:11,
> > >                  from ./include/linux/idr.h:15,
> > >                  from ./include/linux/cgroup-defs.h:13,
> > >                  from mm/memcontrol.c:28:
> > > mm/memcontrol.c: In function ‘mem_cgroup_alloc’:
> > > ./arch/x86/include/asm/percpu.h:39:45: error: expected identifier or ‘(’ before ‘__seg_gs’
> > >    39 | #define __percpu_seg_override   CONCATENATE(__seg_, __percpu_seg)
> > >       |                                             ^~~~~~
> > > ./include/linux/args.h:25:24: note: in definition of macro ‘__CONCAT’
> > >    25 | #define __CONCAT(a, b) a ## b
> > >       |                        ^
> > > ./arch/x86/include/asm/percpu.h:39:33: note: in expansion of macro ‘CONCATENATE’
> > >    39 | #define __percpu_seg_override   CONCATENATE(__seg_, __percpu_seg)
> > >       |                                 ^~~~~~~~~~~
> > > ./arch/x86/include/asm/percpu.h:93:33: note: in expansion of macro ‘__percpu_seg_override’
> > >    93 | # define __percpu_qual          __percpu_seg_override
> > >       |                                 ^~~~~~~~~~~~~~~~~~~~~
> > > ././include/linux/compiler_types.h:60:25: note: in expansion of macro ‘__percpu_qual’
> > >    60 | # define __percpu       __percpu_qual BTF_TYPE_TAG(percpu)
> > >       |                         ^~~~~~~~~~~~~
> > > mm/memcontrol.c:3700:45: note: in expansion of macro ‘__percpu’
> > >  3700 |         struct memcg_vmstats_percpu *statc, __percpu *pstatc_pcpu;
> > >       |                                             ^~~~~~~~
> > > mm/memcontrol.c:3731:25: error: ‘pstatc_pcpu’ undeclared (first use in this function); did you mean ‘kstat_cpu’?
> > >  3731 |                         pstatc_pcpu = parent->vmstats_percpu;
> > >       |                         ^~~~~~~~~~~
> > >       |                         kstat_cpu
> > > mm/memcontrol.c:3731:25: note: each undeclared identifier is reported only once for each function it appears in
> > >
> > > The __percpu macro seems to be a bit screwy with comma-delimited decls, as it
> > > seems that putting this on its own line fixes this problem:
> > >
> >
> > Which compiler (and version) is this? Thanks for the fix.
> 
> gcc 15, but apparently 13, 14 also fail. It seems independent of config.

Thanks, somehow it works with gcc 11.5.0.

