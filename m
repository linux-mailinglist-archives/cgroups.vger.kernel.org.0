Return-Path: <cgroups+bounces-11569-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F084C32986
	for <lists+cgroups@lfdr.de>; Tue, 04 Nov 2025 19:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 574014F4C85
	for <lists+cgroups@lfdr.de>; Tue,  4 Nov 2025 18:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F52A33EAFD;
	Tue,  4 Nov 2025 18:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CYncNzCz"
X-Original-To: cgroups@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42AE33DEFD
	for <cgroups@vger.kernel.org>; Tue,  4 Nov 2025 18:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762280068; cv=none; b=d5EQ2sQanwH0VMz1rvltto0X6pmv7NdDROJ6yr2Ee/o74wUE9PiDyADwGo+2hdPnCu09u+qisIjS6+cAcZMHeTqTts1tvqTR4bn83g8JD4JbjsuyjH5PKeNZI0hGhL0pZf+raMY4ggBa4q/DQHJRacQcUjXfgUisbbH2397M6yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762280068; c=relaxed/simple;
	bh=eW9gLOYQ4PO/YSLIAFmpY62Rr4JFZ49YbcwqvrnIPBU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TgcnZaYe30XYWhrGZMF3FTCCCOV5Z6xBER/2qIYuR5gMmxKXDEoOpSuRHf+EjiYndJlkjJRJoutsA/Vs65LkSXrYmKSrmqu97wl55alYGUY9am1eG8bUQvZsBmr8tP2+pJGqk2TgO8X38Qhd/FKRyGp6mmxoy3/3YfT2G1WfBLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CYncNzCz; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762280054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NAWdqQAMF5nun7wl28IZyFWxTMsXgZF6tpsdkVCFUVk=;
	b=CYncNzCzYkQqitwhPYqZZ2XB5M4zBBImGrmM8RswwHaI5fjYIChKwb+qJ+P6ev/4Y8jaEV
	UINgarZFhBJlyEkb3eGVjNfCyAerXhNhDDKh9POde27z+UNbv9dAnXxmOAcCOohdCIqP0I
	m20QJOx7Cz/kEmiqvkHdkwAZ8kL8w+w=
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
In-Reply-To: <aQm2zqmD9mHE1psg@tiehlicka> (Michal Hocko's message of "Tue, 4
	Nov 2025 09:18:22 +0100")
References: <20251027231727.472628-1-roman.gushchin@linux.dev>
	<20251027231727.472628-7-roman.gushchin@linux.dev>
	<aQR7HIiQ82Ye2UfA@tiehlicka> <875xbsglra.fsf@linux.dev>
	<aQj7uRjz668NNrm_@tiehlicka> <87a512muze.fsf@linux.dev>
	<aQm2zqmD9mHE1psg@tiehlicka>
Date: Tue, 04 Nov 2025 10:14:05 -0800
Message-ID: <87h5v93bte.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Michal Hocko <mhocko@suse.com> writes:

> On Mon 03-11-25 17:45:09, Roman Gushchin wrote:
>> Michal Hocko <mhocko@suse.com> writes:
>> 
>> > On Sun 02-11-25 13:36:25, Roman Gushchin wrote:
>> >> Michal Hocko <mhocko@suse.com> writes:
> [...]
>> > No, I do not feel strongly one way or the other but I would like to
>> > understand thinking behind that. My slight preference would be to have a
>> > single return status that clearly describe the intention. If you want to
>> > have more flexible chaining semantic then an enum { IGNORED, HANDLED,
>> > PASS_TO_PARENT, ...} would be both more flexible, extensible and easier
>> > to understand.
>> 
>> The thinking is simple:
>> 1) Most users will have a single global bpf oom policy, which basically
>> replaces the in-kernel oom killer.
>> 2) If there are standalone containers, they might want to do the same on
>> their level. And the "host" system doesn't directly control it.
>> 3) If for some reason the inner oom handler fails to free up some
>> memory, there are two potential fallback options: call the in-kernel oom
>> killer for that memory cgroup or call an upper level bpf oom killer, if
>> there is one.
>> 
>> I think the latter is more logical and less surprising. Imagine you're
>> running multiple containers and some of them implement their own bpf oom
>> logic and some don't. Why would we treat them differently if their bpf
>> logic fails?
>
> I think both approaches are valid and it should be the actual handler to
> tell what to do next. If the handler would prefer the in-kernel fallback
> it should be able to enforce that rather than a potentially unknown bpf
> handler up the chain.

The counter-argument is that cgroups are hierarchical and higher level
cgroups should be able to enforce the desired behavior for their
sub-trees. I'm not sure what's more important here and have to think
more about it.
Do you have an example when it might be important for container to not
pass to a higher level bpf handler?

>
>> Re a single return value: I can absolutely specify return values as an
>> enum, my point is that unlike the kernel code we can't fully trust the
>> value returned from a bpf program, this is why the second check is in
>> place.
>
> I do not understand this. Could you elaborate? Why we cannot trust the
> return value but we can trust a combination of the return value and a
> state stored in a helper structure?

Imagine bpf program which does nothing and simple returns 1. Imagine
it's loaded as a system-wide oom handler. This will effectively disable
the oom killer and lead to a potential deadlock on memory.
But it's a perfectly valid bpf program.
This is something I want to avoid (and it's a common practice with other
bpf programs).

What I do I also rely on the value of the oom control's field, which is
not accessible to the bpf program for write directly, but can be changed
by calling certain helper functions, e.g. bpf_oom_kill_process.

>> Can we just ignore the returned value and rely on the freed_memory flag?
>
> I do not think having a single freed_memory flag is more helpful. This
> is just a number that cannot say much more than a memory has been freed.
> It is not really important whether and how much memory bpf handler
> believes it has freed. It is much more important to note whether it
> believes it is done, it needs assistance from a different handler up the
> chain or just pass over to the in-kernel implementation.

Btw in general in a containerized environment a bpf handler knows
nothing about bpf programs up in the cgroup hierarchy... So it only
knows whether it was able to free some memory or not.

>
>> Sure, but I don't think it bus us anything.
>> 
>> Also, I have to admit that I don't have an immediate production use case
>> for nested oom handlers (I'm fine with a global one), but it was asked
>> by Alexei Starovoitov. And I agree with him that the containerized case
>> will come up soon, so it's better to think of it in advance.
>
> I agree it is good to be prepared for that.
>
>> >> >> The bpf_handle_out_of_memory() callback program is sleepable to enable
>> >> >> using iterators, e.g. cgroup iterators. The callback receives struct
>> >> >> oom_control as an argument, so it can determine the scope of the OOM
>> >> >> event: if this is a memcg-wide or system-wide OOM.
>> >> >
>> >> > This could be tricky because it might introduce a subtle and hard to
>> >> > debug lock dependency chain. lock(a); allocation() -> oom -> lock(a).
>> >> > Sleepable locks should be only allowed in trylock mode.
>> >> 
>> >> Agree, but it's achieved by controlling the context where oom can be
>> >> declared (e.g. in bpf_psi case it's done from a work context).
>> >
>> > but out_of_memory is any sleepable context. So this is a real problem.
>> 
>> We need to restrict both:
>> 1) where from bpf_out_of_memory() can be called (already done, as of now
>> only from bpf_psi callback, which is safe).
>> 2) which kfuncs are available to bpf oom handlers (only those, which are
>> not trying to grab unsafe locks) - I'll double check it in thenext version.
>
> OK. All I am trying to say is that only safe sleepable locks are
> trylocks and that should be documented because I do not think it can be
> enforced

It can! Not directly, but by controlling which kfuncs/helpers are
available to bpf programs.
I agree with you in principle re locks and necessary precaution here.

Thanks!

