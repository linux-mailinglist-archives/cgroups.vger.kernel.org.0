Return-Path: <cgroups+bounces-8216-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38226AB8AA4
	for <lists+cgroups@lfdr.de>; Thu, 15 May 2025 17:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D292CA03FCE
	for <lists+cgroups@lfdr.de>; Thu, 15 May 2025 15:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F7C21578D;
	Thu, 15 May 2025 15:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="f2RhhZz5"
X-Original-To: cgroups@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F9C18FC91
	for <cgroups@vger.kernel.org>; Thu, 15 May 2025 15:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747322505; cv=none; b=sL20k1Tf97fQMpTcBCHG7hlFTWCz5jAfStiPwmDwK6BtfC4tXvOe1YpL769jBKRpifSz+xLOxV/lg446gL0YgGH3APNVI4tFLVxEImAo4fSkaHorgSIp0mRfiX4ZikbqOI1sVnm0rWNalR+Mp8pdM0IAvlwoWMWB0I8Xz/B34lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747322505; c=relaxed/simple;
	bh=iWSX4Lju/uclKKCH3oy7b2JkRHS8v7CmRHmmEd3vadc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KX5l+bt7tbGmfAxDzp8e7EMhYyKPr8UXb0THIVZjSF1KXWnorboV+iy+0Ow7HsVYi1qrzNmkIJ4w66bHLnfjrXiVe2PwHOSs0GEaYIp1jjA1i9hwfccjRNeVNYRkVvdmyDJLK/6wOQJmlvLNALmh1ek0b4Iu0GV64yDuvisCIXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=f2RhhZz5; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 15 May 2025 08:21:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747322491;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vNQ362kPh2DAdnB+ckUbQSAnkMVDAHgeooSh5BHonV0=;
	b=f2RhhZz5GTNImie0TBvWXUh6tKuxj+d+dSQyeRxcyIxUPzyeYz3yGUoWQ+dZ6nCKrLcmST
	rKyfkemIxryRt9zwqMVYyPc9lGs4Cc1HptTDtwbsUARhkCBUBNcogHcn1i9ydwJ8FuCXym
	m+rJ4+jr/48NgW11U0/p/AEjp79HL9Q=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Harry Yoo <harry.yoo@oracle.com>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, bpf@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH v2 1/7] memcg: memcg_rstat_updated re-entrant safe
 against irqs
Message-ID: <oqw3rhbai4zzr3g7mpjbq7zosatifn5lpbuqu4w732ksnfxxn2@hhut62hpdl2h>
References: <20250514184158.3471331-1-shakeel.butt@linux.dev>
 <20250514184158.3471331-2-shakeel.butt@linux.dev>
 <22f69e6e-7908-4e92-96ca-5c70d535c439@lucifer.local>
 <CAGj-7pUJQZD59Sx7E69Uvi1++dB59R8wWkDYvSTGYhU-18AHXg@mail.gmail.com>
 <2d517f89-3bb4-4de2-8c14-8bb1e4235c7a@suse.cz>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2d517f89-3bb4-4de2-8c14-8bb1e4235c7a@suse.cz>
X-Migadu-Flow: FLOW_OUT

On Thu, May 15, 2025 at 04:57:10PM +0200, Vlastimil Babka wrote:
> On 5/15/25 16:31, Shakeel Butt wrote:
> > On Thu, May 15, 2025 at 5:47 AM Lorenzo Stoakes
> > <lorenzo.stoakes@oracle.com> wrote:
> >>
> >> Shakeel - This breaks the build in mm-new for me:
> >>
> >>   CC      mm/pt_reclaim.o
> >> In file included from ./arch/x86/include/asm/rmwcc.h:5,
> >>                  from ./arch/x86/include/asm/bitops.h:18,
> >>                  from ./include/linux/bitops.h:68,
> >>                  from ./include/linux/radix-tree.h:11,
> >>                  from ./include/linux/idr.h:15,
> >>                  from ./include/linux/cgroup-defs.h:13,
> >>                  from mm/memcontrol.c:28:
> >> mm/memcontrol.c: In function ‘mem_cgroup_alloc’:
> >> ./arch/x86/include/asm/percpu.h:39:45: error: expected identifier or ‘(’ before ‘__seg_gs’
> >>    39 | #define __percpu_seg_override   CONCATENATE(__seg_, __percpu_seg)
> >>       |                                             ^~~~~~
> >> ./include/linux/args.h:25:24: note: in definition of macro ‘__CONCAT’
> >>    25 | #define __CONCAT(a, b) a ## b
> >>       |                        ^
> >> ./arch/x86/include/asm/percpu.h:39:33: note: in expansion of macro ‘CONCATENATE’
> >>    39 | #define __percpu_seg_override   CONCATENATE(__seg_, __percpu_seg)
> >>       |                                 ^~~~~~~~~~~
> >> ./arch/x86/include/asm/percpu.h:93:33: note: in expansion of macro ‘__percpu_seg_override’
> >>    93 | # define __percpu_qual          __percpu_seg_override
> >>       |                                 ^~~~~~~~~~~~~~~~~~~~~
> >> ././include/linux/compiler_types.h:60:25: note: in expansion of macro ‘__percpu_qual’
> >>    60 | # define __percpu       __percpu_qual BTF_TYPE_TAG(percpu)
> >>       |                         ^~~~~~~~~~~~~
> >> mm/memcontrol.c:3700:45: note: in expansion of macro ‘__percpu’
> >>  3700 |         struct memcg_vmstats_percpu *statc, __percpu *pstatc_pcpu;
> >>       |                                             ^~~~~~~~
> >> mm/memcontrol.c:3731:25: error: ‘pstatc_pcpu’ undeclared (first use in this function); did you mean ‘kstat_cpu’?
> >>  3731 |                         pstatc_pcpu = parent->vmstats_percpu;
> >>       |                         ^~~~~~~~~~~
> >>       |                         kstat_cpu
> >> mm/memcontrol.c:3731:25: note: each undeclared identifier is reported only once for each function it appears in
> >>
> >> The __percpu macro seems to be a bit screwy with comma-delimited decls, as it
> >> seems that putting this on its own line fixes this problem:
> >>
> > 
> > Which compiler (and version) is this? Thanks for the fix.
> 
> Hm right I see the same errors with gcc 7, 13, 14, 15 but not with clang.

It seems to work with gcc 11.5.0, so weird.

