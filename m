Return-Path: <cgroups+bounces-11552-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E5EC2EDD7
	for <lists+cgroups@lfdr.de>; Tue, 04 Nov 2025 02:45:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 434363A99D6
	for <lists+cgroups@lfdr.de>; Tue,  4 Nov 2025 01:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE4020E00B;
	Tue,  4 Nov 2025 01:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eej7SG6K"
X-Original-To: cgroups@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5931A9F9B
	for <cgroups@vger.kernel.org>; Tue,  4 Nov 2025 01:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762220721; cv=none; b=ghfpGG02fmPWMJOWkbawZ5qi+P9uLL12HleN28SDFjop8pVt56a+ckTKT2wmlUkh52RyQPI6BKdVDgx3XGD8ScKAM5UZBl0OOstlIk8iq1h+r4zUOSgmOgWnT2lq584q1fLZPy1uIUdCSA6eprlYJ+TEamxzBs6DvMSZwSfZXhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762220721; c=relaxed/simple;
	bh=eE0Sksc1E8tASsNmX0nfCalfYGhh0r9ceygIkOqmHvg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hOyZAyiIbYlXLKfMbd1rAldXzOIWQB1TI0ZjRyA3bgrv4BXk3NhTuI10vBTiab6zvgfmRUTLNqaLF2RvuTtUm6FKMbXYNYFCyO0PpTKuza+XQi/CFRuieNqGLBs39EVx3Ku2VfQw8yjHZoV1FvmPUVDUYOhcQlvjdR3K3HOsQhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eej7SG6K; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762220716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P2r2L9mfw9r+buciI9SKXnid4aHeJcUG8hdz1itgchw=;
	b=eej7SG6KYOyP3W/QXNmOQHfVG0rj2NyX9HRwoKpg+FWmsW7ArMfA2C/rXKHxlOZYdKzghs
	oqCvSSke2vPfqgIIicBVX3ygA8Fsiz0AOAIbO9KSQKL9jyicSmHTjkv1WG0pn5uuQu8j6t
	Ib+R2BY04rXYyG9jZXzc/7qccoD5dzg=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Michal Hocko <mhocko@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
  linux-kernel@vger.kernel.org,  Alexei Starovoitov <ast@kernel.org>,
  Suren Baghdasaryan <surenb@google.com>,  Shakeel Butt
 <shakeel.butt@linux.dev>,  Johannes Weiner <hannes@cmpxchg.org>,  Andrii
 Nakryiko <andrii@kernel.org>,  JP Kobryn <inwardvessel@gmail.com>,
  linux-mm@kvack.org,  cgroups@vger.kernel.org,  bpf@vger.kernel.org,
  Martin KaFai Lau <martin.lau@kernel.org>,  Song Liu <song@kernel.org>,
  Kumar Kartikeya Dwivedi <memxor@gmail.com>,  Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 06/23] mm: introduce BPF struct ops for OOM handling
In-Reply-To: <aQj7uRjz668NNrm_@tiehlicka> (Michal Hocko's message of "Mon, 3
	Nov 2025 20:00:09 +0100")
References: <20251027231727.472628-1-roman.gushchin@linux.dev>
	<20251027231727.472628-7-roman.gushchin@linux.dev>
	<aQR7HIiQ82Ye2UfA@tiehlicka> <875xbsglra.fsf@linux.dev>
	<aQj7uRjz668NNrm_@tiehlicka>
Date: Mon, 03 Nov 2025 17:45:09 -0800
Message-ID: <87a512muze.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Michal Hocko <mhocko@suse.com> writes:

> On Sun 02-11-25 13:36:25, Roman Gushchin wrote:
>> Michal Hocko <mhocko@suse.com> writes:
>> 
>> > On Mon 27-10-25 16:17:09, Roman Gushchin wrote:
>> >> Introduce a bpf struct ops for implementing custom OOM handling
>> >> policies.
>> >> 
>> >> It's possible to load one bpf_oom_ops for the system and one
>> >> bpf_oom_ops for every memory cgroup. In case of a memcg OOM, the
>> >> cgroup tree is traversed from the OOM'ing memcg up to the root and
>> >> corresponding BPF OOM handlers are executed until some memory is
>> >> freed. If no memory is freed, the kernel OOM killer is invoked.
>> >
>> > Do you have any usecase in mind where parent memcg oom handler decides
>> > to not kill or cannot kill anything and hand over upwards in the
>> > hierarchy?
>> 
>> I believe that in most cases bpf handlers will handle ooms themselves,
>> but because strictly speaking I don't have control over what bpf
>> programs do or do not, the kernel should provide the fallback mechanism.
>> This is a common practice with bpf, e.g. sched_ext falls back to
>> CFS/EEVDF in case something is wrong.
>
> We do have fallback mechanism - the kernel oom handling. For that we do
> not need to pass to parent handler. Please not that I am not opposing
> this but I would like to understand thinking behind and hopefully start
> with a simpler model and then extend it later than go with a more
> complex one initially and then corner ourselves with weird side
> effects.
>  
>> Specifically to OOM case, I believe someone might want to use bpf
>> programs just for monitoring/collecting some information, without
>> trying to actually free some memory.
>> 
>> >> The struct ops provides the bpf_handle_out_of_memory() callback,
>> >> which expected to return 1 if it was able to free some memory and 0
>> >> otherwise. If 1 is returned, the kernel also checks the bpf_memory_freed
>> >> field of the oom_control structure, which is expected to be set by
>> >> kfuncs suitable for releasing memory. If both are set, OOM is
>> >> considered handled, otherwise the next OOM handler in the chain
>> >> (e.g. BPF OOM attached to the parent cgroup or the in-kernel OOM
>> >> killer) is executed.
>> >
>> > Could you explain why do we need both? Why is not bpf_memory_freed
>> > return value sufficient?
>> 
>> Strictly speaking, bpf_memory_freed should be enough, but because
>> bpf programs have to return an int and there is no additional cost
>> to add this option (pass to next or in-kernel oom handler), I thought
>> it's not a bad idea. If you feel strongly otherwise, I can ignore
>> the return value on rely on bpf_memory_freed only.
>
> No, I do not feel strongly one way or the other but I would like to
> understand thinking behind that. My slight preference would be to have a
> single return status that clearly describe the intention. If you want to
> have more flexible chaining semantic then an enum { IGNORED, HANDLED,
> PASS_TO_PARENT, ...} would be both more flexible, extensible and easier
> to understand.

The thinking is simple:
1) Most users will have a single global bpf oom policy, which basically
replaces the in-kernel oom killer.
2) If there are standalone containers, they might want to do the same on
their level. And the "host" system doesn't directly control it.
3) If for some reason the inner oom handler fails to free up some
memory, there are two potential fallback options: call the in-kernel oom
killer for that memory cgroup or call an upper level bpf oom killer, if
there is one.

I think the latter is more logical and less surprising. Imagine you're
running multiple containers and some of them implement their own bpf oom
logic and some don't. Why would we treat them differently if their bpf
logic fails?

Re a single return value: I can absolutely specify return values as an
enum, my point is that unlike the kernel code we can't fully trust the
value returned from a bpf program, this is why the second check is in
place.

Can we just ignore the returned value and rely on the freed_memory flag?
Sure, but I don't think it bus us anything.

Also, I have to admit that I don't have an immediate production use case
for nested oom handlers (I'm fine with a global one), but it was asked
by Alexei Starovoitov. And I agree with him that the containerized case
will come up soon, so it's better to think of it in advance.

>> >> The bpf_handle_out_of_memory() callback program is sleepable to enable
>> >> using iterators, e.g. cgroup iterators. The callback receives struct
>> >> oom_control as an argument, so it can determine the scope of the OOM
>> >> event: if this is a memcg-wide or system-wide OOM.
>> >
>> > This could be tricky because it might introduce a subtle and hard to
>> > debug lock dependency chain. lock(a); allocation() -> oom -> lock(a).
>> > Sleepable locks should be only allowed in trylock mode.
>> 
>> Agree, but it's achieved by controlling the context where oom can be
>> declared (e.g. in bpf_psi case it's done from a work context).
>
> but out_of_memory is any sleepable context. So this is a real problem.

We need to restrict both:
1) where from bpf_out_of_memory() can be called (already done, as of now
only from bpf_psi callback, which is safe).
2) which kfuncs are available to bpf oom handlers (only those, which are
not trying to grab unsafe locks) - I'll double check it in thenext version.

Thank you!

