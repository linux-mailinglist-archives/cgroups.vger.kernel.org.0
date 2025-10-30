Return-Path: <cgroups+bounces-11415-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7413C1DD89
	for <lists+cgroups@lfdr.de>; Thu, 30 Oct 2025 01:04:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9ECEB3B0BE5
	for <lists+cgroups@lfdr.de>; Thu, 30 Oct 2025 00:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF8F11CBA;
	Thu, 30 Oct 2025 00:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c2xwHM38"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359541C68F;
	Thu, 30 Oct 2025 00:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761782633; cv=none; b=XaIZNp8Uz8LH0oHItRPcvLa+6xBwuQAsNZGPPsXoCa0vf4dhrXKO9bdGrB0PDl68kvXNSW73ZF4USEeJmsP5QdTpMbbgQb5rksWl2sARx4TVH9YnEocLz+QyxSbqtVGre76ngJ5500N+22QIzGD485R48i6gfqOTSeEn081RIEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761782633; c=relaxed/simple;
	bh=1XnGr1V9M31iKuMKW3cadiXKYVM5ogphmXcmc2DRafs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IbzCYLn11duTD4shRR748QKIiwSOC91MpRuV20DVNyODMr+HjCHIonhta7uDzCSizhF8ErISdtICWXFZtynoEI0JQZC6POsF91Q7O0I1LE1LmDlYcTKFu4lyl8u2rUsM8SvmyiLerlNvVPxNnEwxrw5aAhF32/Jg+fCwixcpvZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c2xwHM38; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 842BCC4CEF7;
	Thu, 30 Oct 2025 00:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761782632;
	bh=1XnGr1V9M31iKuMKW3cadiXKYVM5ogphmXcmc2DRafs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c2xwHM38YkX0bt2FauUNoc+p8aNebX3OddEiZzpbnty76brkQojdA10bHHlhYJyoz
	 8Q0JOl4clPV7GExdOLx+2nQrAJ51ZiSOG+KsKDerEiWItE4827kdsS1ONn2VO4m4A6
	 OUH95kE6wD2yz1njEkr80MmZJ+zFV0u/jFHts1JjypsHf5fKSn3DG65xxeQBqQkQbf
	 NmIp/MWjz4cRe0I2mJ88CHgOdxMNZEPp0te5nIOHcD53vxTeYM9yurfxQIRCTFfvu3
	 38w+VTOCZP3ZPCgg/03pa3LcFGE7sRMdrnQQDyEuwhUeVdEykX3S4+H0HfwGrCjNNC
	 7OwjtmPn74xTA==
Date: Wed, 29 Oct 2025 14:03:51 -1000
From: Tejun Heo <tj@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, Song Liu <song@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	JP Kobryn <inwardvessel@gmail.com>, linux-mm <linux-mm@kvack.org>,
	"open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
	bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: Re: [PATCH v2 02/23] bpf: initial support for attaching struct ops
 to cgroups
Message-ID: <aQKrZ2bQan8PnAQA@slm.duckdns.org>
References: <20251027231727.472628-1-roman.gushchin@linux.dev>
 <20251027231727.472628-3-roman.gushchin@linux.dev>
 <aQJZgd8-xXpK-Af8@slm.duckdns.org>
 <87ldkte9pr.fsf@linux.dev>
 <aQJ61wC0mvzc7qIU@slm.duckdns.org>
 <CAHzjS_vhk6RM6pkfKNrDNeEC=eObofL=f9FZ51tyqrFFz9tn1w@mail.gmail.com>
 <871pmle5ng.fsf@linux.dev>
 <CAADnVQJ+4a97bp26BOpD5A9LOzfJ+XxyNt4bdG8n7jaO6+nV3Q@mail.gmail.com>
 <aQKa5L345s-vBJR1@slm.duckdns.org>
 <CAADnVQJp9FkPDA7oo-+yZ0SKFbE6w7FzARosLgzLmH74Vv+dow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQJp9FkPDA7oo-+yZ0SKFbE6w7FzARosLgzLmH74Vv+dow@mail.gmail.com>

Hello,

On Wed, Oct 29, 2025 at 04:53:07PM -0700, Alexei Starovoitov wrote:
...
> > - How would recursion work with private stacks? Aren't those attached to
> >   each BPF program?
> 
> yes. private stack is per prog, but why does it matter?
> I'm not suggesting that the same prog to be attached at different
> levels of the cgroup hierarchy, because such configuration
> will indeed trigger recursion prevention logic (with or without private
> stack).
> But having one logical sched-ext prog set to manage tasks
> in container A and in container B makes sense as a use case to me
> where A and B are different cgroups.
> DSQs can be cgroup scoped too.

I don't know. Maybe, but this is kinda specific and I don't see how this
would be useful in practical sense. Have nothing against using the
mechanism. I can still enforce the same rules from scx side. It just looks
unnecessarily over-designed. Maybe consistency with other BPF progs
justifies it.

> > If there is one struct_ops per cgroup, the oom kill kfunc can
> >   look that up and then verify that the struct_ops has authority over the
> >   target process. Multiple attachments can work too but that'd require
> >   iterating all attachments, right?
> 
> Are you talking about bpf_oom_kill_process() kfunc from these patch set?
> I don't think it needs any changes. oom context is passed into prog
> and passed along to kfunc. Doesn't matter the cgroup origin.

Oh, if there are other mechanisms to enforce boundaries, it's not a problem,
but I can almost guarantee as the framework grows, there will be needs for
kfuncs to identify and verify the callers and handlers communicating with
each other along the hierarchy requiring recursive calls.

Thanks.

-- 
tejun

