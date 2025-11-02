Return-Path: <cgroups+bounces-11473-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BA6B0C2973F
	for <lists+cgroups@lfdr.de>; Sun, 02 Nov 2025 22:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 812654E3FF5
	for <lists+cgroups@lfdr.de>; Sun,  2 Nov 2025 21:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6481DE4FB;
	Sun,  2 Nov 2025 21:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uWjkOvIW"
X-Original-To: cgroups@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5602BCF5
	for <cgroups@vger.kernel.org>; Sun,  2 Nov 2025 21:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762119399; cv=none; b=AH2BotFnEc9WkBDNhSzxIMkZA0sn9JICoeN70dZXJ/o1d3VBl1xJ7yLk+N/nX8ZoYVsfYM1VoeJe3YxTB0mufkP5+ZvxYXw+HyrrhJc6v94RSG6B30WbxPa+ndzOwat0N3yhC07JuyvECkad7et+vfek0h2OdwdiP2pO46oiQ9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762119399; c=relaxed/simple;
	bh=i3EklB5KO1R4QxKOcGYeVk40OcIAul9sYhoKiHZt5NM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kpHnBfQO/dea5S0dkivYvaFpid9Ojj3C5tLRju7Fvg2YChuJCh4BV8UqJYCa4dXfLmXgKRzxrIxI3dH+uvvMhgrFJgDbRk6t1TS7Z2dNIIjQMkFIMqjRVx1VHjS04AIx3a6+KcfPz9CzPTmcR/T/OafP/PxEQBWc72kRim6ZwPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uWjkOvIW; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762119394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qcGx6i/+++ufNscO90BKEs/b8++kUKzaqmiZ//H9ISU=;
	b=uWjkOvIWS/CmQ5V4hKpdOf06Eo4ZAkvv91DlTySCJ+m53/jNAeeaZdCBfaDTh6/k+AtkyR
	OVFVRg96tGQ0GJMt7tJOycDaK3A5j0R8batwvzteEfJiSGDHZ8F1jonFIuRsADZ6tdXsD3
	F1obi2np1FqjXVQ+3cEKvINCpn4xOk4=
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
In-Reply-To: <aQR7HIiQ82Ye2UfA@tiehlicka> (Michal Hocko's message of "Fri, 31
	Oct 2025 10:02:20 +0100")
References: <20251027231727.472628-1-roman.gushchin@linux.dev>
	<20251027231727.472628-7-roman.gushchin@linux.dev>
	<aQR7HIiQ82Ye2UfA@tiehlicka>
Date: Sun, 02 Nov 2025 13:36:25 -0800
Message-ID: <875xbsglra.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Michal Hocko <mhocko@suse.com> writes:

> On Mon 27-10-25 16:17:09, Roman Gushchin wrote:
>> Introduce a bpf struct ops for implementing custom OOM handling
>> policies.
>> 
>> It's possible to load one bpf_oom_ops for the system and one
>> bpf_oom_ops for every memory cgroup. In case of a memcg OOM, the
>> cgroup tree is traversed from the OOM'ing memcg up to the root and
>> corresponding BPF OOM handlers are executed until some memory is
>> freed. If no memory is freed, the kernel OOM killer is invoked.
>
> Do you have any usecase in mind where parent memcg oom handler decides
> to not kill or cannot kill anything and hand over upwards in the
> hierarchy?

I believe that in most cases bpf handlers will handle ooms themselves,
but because strictly speaking I don't have control over what bpf
programs do or do not, the kernel should provide the fallback mechanism.
This is a common practice with bpf, e.g. sched_ext falls back to
CFS/EEVDF in case something is wrong.

Specifically to OOM case, I believe someone might want to use bpf
programs just for monitoring/collecting some information, without
trying to actually free some memory.

>> The struct ops provides the bpf_handle_out_of_memory() callback,
>> which expected to return 1 if it was able to free some memory and 0
>> otherwise. If 1 is returned, the kernel also checks the bpf_memory_freed
>> field of the oom_control structure, which is expected to be set by
>> kfuncs suitable for releasing memory. If both are set, OOM is
>> considered handled, otherwise the next OOM handler in the chain
>> (e.g. BPF OOM attached to the parent cgroup or the in-kernel OOM
>> killer) is executed.
>
> Could you explain why do we need both? Why is not bpf_memory_freed
> return value sufficient?

Strictly speaking, bpf_memory_freed should be enough, but because
bpf programs have to return an int and there is no additional cost
to add this option (pass to next or in-kernel oom handler), I thought
it's not a bad idea. If you feel strongly otherwise, I can ignore
the return value on rely on bpf_memory_freed only.

>
>> The bpf_handle_out_of_memory() callback program is sleepable to enable
>> using iterators, e.g. cgroup iterators. The callback receives struct
>> oom_control as an argument, so it can determine the scope of the OOM
>> event: if this is a memcg-wide or system-wide OOM.
>
> This could be tricky because it might introduce a subtle and hard to
> debug lock dependency chain. lock(a); allocation() -> oom -> lock(a).
> Sleepable locks should be only allowed in trylock mode.

Agree, but it's achieved by controlling the context where oom can be
declared (e.g. in bpf_psi case it's done from a work context).

>
>> The callback is executed just before the kernel victim task selection
>> algorithm, so all heuristics and sysctls like panic on oom,
>> sysctl_oom_kill_allocating_task and sysctl_oom_kill_allocating_task
>> are respected.
>
> I guess you meant to say and sysctl_panic_on_oom.

Yep, fixed.
>
>> BPF OOM struct ops provides the handle_cgroup_offline() callback
>> which is good for releasing struct ops if the corresponding cgroup
>> is gone.
>
> What kind of synchronization is expected between handle_cgroup_offline
> and bpf_handle_out_of_memory?

You mean from a user's perspective? E.g. can these two callbacks run in
parallel? Currently yes, but it's a good question, I haven't thought
about it, maybe it's better to synchronize them.
Internally both rely on srcu to pin bpf_oom_ops in memory.

>  
>> The struct ops also has the name field, which allows to define a
>> custom name for the implemented policy. It's printed in the OOM report
>> in the oom_policy=<policy> format. "default" is printed if bpf is not
>> used or policy name is not specified.
>
> oom_handler seems like a better fit but nothing I would insist on. Also
> I would just print it if there is an actual handler so that existing
> users who do not use bpf oom killers do not need to change their
> parsers.

Sure, works for me too.

>
> Other than that this looks reasonable to me.

Sound great, thank you for taking a look!

