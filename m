Return-Path: <cgroups+bounces-11538-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30585C2DC61
	for <lists+cgroups@lfdr.de>; Mon, 03 Nov 2025 20:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 797211898FD7
	for <lists+cgroups@lfdr.de>; Mon,  3 Nov 2025 19:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D87208961;
	Mon,  3 Nov 2025 19:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GiQwvqaH"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8A329A307
	for <cgroups@vger.kernel.org>; Mon,  3 Nov 2025 19:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762196428; cv=none; b=TllPNjy6vsTJw5NBxBtyzBmoDRUxoQ3TymlJDvPITZ+U367dPGXXx4SWFQ3QcI4G5r10IRdYYamVyWnk3vmjelTUx2ZTJk6Gg7dO1bP7WUmhiR/kQwuzcVp0Y6GwtX+JhpKZL7VTXzf8/dIokFZaK8cHP0VuZhs2XIvSYoUfnqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762196428; c=relaxed/simple;
	bh=5Kc76iaR2aicGpXWI2CwVtoEWluQcseYpAvOTgc83Jw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FoLD6GCEld9r6f/ZJN/riKsUZvaLdu9jvoWpoju5pX73AUCTSyheGsG534jMeEnVMD6J5mFGe6tXx0jJrEX29qFc6Qkx61RG4XfR/CRDEmszYjxcOATwnXI+PB7uQ6Drt/GLIr9b/IWxjPDP/nqob7SUQgwXNeTWNeTYFm79f8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GiQwvqaH; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-640741cdda7so6020561a12.2
        for <cgroups@vger.kernel.org>; Mon, 03 Nov 2025 11:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762196411; x=1762801211; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QJ3N2WUq/UZ5e0T22UvDFgeGGC9bQkna+j2RgD0j4rQ=;
        b=GiQwvqaHr9wEq6132VYfm8iKRI4FGC+8x496Pvg6dWe9zodE9zoozX/wrcUk/ZKHgq
         5ckO9Z4C5FLWzUDAZ8UjroZRrOXlsvMiOtLxGNo4qZeeW4NH50rdjHPh6bIxQy8odj9M
         wbYZ0cWgsjHgTpxwRdWBCK8KaMUzIJ4ImKPOjHDYUQz1EhFOU09gRENbb87s8jpfXGUF
         2C3wHSy00Fqm3dbESN3krnSW6XEQ05WgtRYNgMOQ0KIx5MzAXk6AqUqSKN3wubDHrhNd
         Bhiu5HfFItPP8ebDYvCmtsJOCCPKLQmKGeSyHAtWnU9ey465/YJNfL7I/XIJwFxu1Xch
         9Drg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762196411; x=1762801211;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QJ3N2WUq/UZ5e0T22UvDFgeGGC9bQkna+j2RgD0j4rQ=;
        b=ZjwI9QBwJgdrF2jodPNfYSK9ISYzpI3NwLHFiN20yu2KF3bd9GFhPvV43E6YdkVFh6
         GjyPVf6jd/hOOLXQ0LsXvO5otQ9C4ZfSraYjBH0a6MhNfA6brDkeuHu12Y5IMvZ5hEc9
         uAgLWt5aQPPDPGitNY2Rq2RjyDvsHejEWUdK3IkJMSf8mHMAGSITNsHNglndsflvRRxa
         n5G9CaF1sdtTAvdG+j8SSHGl3iJVOb3pk9LmPNaiMpFw05rWq/JNz0TNJ/7AKRSbVxbI
         lSoUrR4/E2e86qBv/iexUrN7EBGcJ3P/CTfSks/F/O6xU3HNA7o6YcPKsreBxynpOm5W
         RiFA==
X-Forwarded-Encrypted: i=1; AJvYcCWt1aJFUj+a32BsXHdrnZE377VwkcVIiqp0zKDoCjNG4nt2Q/S/Yfde8+b5tThYw9HO8anPGAUO@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6IyizS3L7bG3Co5BdvAipkjdB3FkizwEZEsZ+ONsC8UFFcWqM
	p4RdmIIjWSRAAhQTtK1chII168SjnKY/LgesMqsX8iq9gLj7PcdMg7Dq/qXxHEVQJuw=
X-Gm-Gg: ASbGncuTPUaSa2ts+XlSHXwIfmmpPWKQ9ZhxDPAkzprh6LBQHc2JZsxD2Ix9PvKRfrq
	0Y1RrQZEHtSuuWO8MZrD0ViJ/h5CgF+sLIYlIC4d6fqmltn5yMK1nbVFEwB13aNu2GUhPRSY+9b
	QEFB3v9xkLgGtY+Ev80uPmdlfWH7KO4iOFelVh513LmD67cb6WzzIMcNHbADmT+mPDxGOsg4wp0
	Ijq2RldhzLBoWxb7lk2R9SHbLY+eWvlv3Jpp0xqkbxlLGm2yj75p+70M4JSb1WZflScIPDjx6TE
	jxyZjKrH60dRPznDxcSpmAb6hr72wx0shrkf8iMOniwVQSzA7tB3NuiyzJhTc9RZFh7qGR9Ai3e
	Fm/FK7qRJ+M5L4vn2kuADBqSpJyI2LIjCashINvk442DX+c/AKgPlffyUZ6vWW1la+2u/0RcevT
	tk8kVH8chwhzerLCndy9IO5NsC
X-Google-Smtp-Source: AGHT+IFhQXFPVDqHyarWQQ7R2subtRafoxgNsFUzIvYeodwBNh8qSwx6VEdKXz8J8S7jSfx/fTTE1Q==
X-Received: by 2002:a17:906:ad0:b0:b70:a982:ad71 with SMTP id a640c23a62f3a-b70a982f501mr457990366b.33.1762196410649;
        Mon, 03 Nov 2025 11:00:10 -0800 (PST)
Received: from localhost (109-81-31-109.rct.o2.cz. [109.81.31.109])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7077ce927csm1117305366b.63.2025.11.03.11.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 11:00:10 -0800 (PST)
Date: Mon, 3 Nov 2025 20:00:09 +0100
From: Michal Hocko <mhocko@suse.com>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	JP Kobryn <inwardvessel@gmail.com>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Song Liu <song@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 06/23] mm: introduce BPF struct ops for OOM handling
Message-ID: <aQj7uRjz668NNrm_@tiehlicka>
References: <20251027231727.472628-1-roman.gushchin@linux.dev>
 <20251027231727.472628-7-roman.gushchin@linux.dev>
 <aQR7HIiQ82Ye2UfA@tiehlicka>
 <875xbsglra.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875xbsglra.fsf@linux.dev>

On Sun 02-11-25 13:36:25, Roman Gushchin wrote:
> Michal Hocko <mhocko@suse.com> writes:
> 
> > On Mon 27-10-25 16:17:09, Roman Gushchin wrote:
> >> Introduce a bpf struct ops for implementing custom OOM handling
> >> policies.
> >> 
> >> It's possible to load one bpf_oom_ops for the system and one
> >> bpf_oom_ops for every memory cgroup. In case of a memcg OOM, the
> >> cgroup tree is traversed from the OOM'ing memcg up to the root and
> >> corresponding BPF OOM handlers are executed until some memory is
> >> freed. If no memory is freed, the kernel OOM killer is invoked.
> >
> > Do you have any usecase in mind where parent memcg oom handler decides
> > to not kill or cannot kill anything and hand over upwards in the
> > hierarchy?
> 
> I believe that in most cases bpf handlers will handle ooms themselves,
> but because strictly speaking I don't have control over what bpf
> programs do or do not, the kernel should provide the fallback mechanism.
> This is a common practice with bpf, e.g. sched_ext falls back to
> CFS/EEVDF in case something is wrong.

We do have fallback mechanism - the kernel oom handling. For that we do
not need to pass to parent handler. Please not that I am not opposing
this but I would like to understand thinking behind and hopefully start
with a simpler model and then extend it later than go with a more
complex one initially and then corner ourselves with weird side
effects.
 
> Specifically to OOM case, I believe someone might want to use bpf
> programs just for monitoring/collecting some information, without
> trying to actually free some memory.
> 
> >> The struct ops provides the bpf_handle_out_of_memory() callback,
> >> which expected to return 1 if it was able to free some memory and 0
> >> otherwise. If 1 is returned, the kernel also checks the bpf_memory_freed
> >> field of the oom_control structure, which is expected to be set by
> >> kfuncs suitable for releasing memory. If both are set, OOM is
> >> considered handled, otherwise the next OOM handler in the chain
> >> (e.g. BPF OOM attached to the parent cgroup or the in-kernel OOM
> >> killer) is executed.
> >
> > Could you explain why do we need both? Why is not bpf_memory_freed
> > return value sufficient?
> 
> Strictly speaking, bpf_memory_freed should be enough, but because
> bpf programs have to return an int and there is no additional cost
> to add this option (pass to next or in-kernel oom handler), I thought
> it's not a bad idea. If you feel strongly otherwise, I can ignore
> the return value on rely on bpf_memory_freed only.

No, I do not feel strongly one way or the other but I would like to
understand thinking behind that. My slight preference would be to have a
single return status that clearly describe the intention. If you want to
have more flexible chaining semantic then an enum { IGNORED, HANDLED,
PASS_TO_PARENT, ...} would be both more flexible, extensible and easier
to understand.

> >> The bpf_handle_out_of_memory() callback program is sleepable to enable
> >> using iterators, e.g. cgroup iterators. The callback receives struct
> >> oom_control as an argument, so it can determine the scope of the OOM
> >> event: if this is a memcg-wide or system-wide OOM.
> >
> > This could be tricky because it might introduce a subtle and hard to
> > debug lock dependency chain. lock(a); allocation() -> oom -> lock(a).
> > Sleepable locks should be only allowed in trylock mode.
> 
> Agree, but it's achieved by controlling the context where oom can be
> declared (e.g. in bpf_psi case it's done from a work context).

but out_of_memory is any sleepable context. So this is a real problem.
 
> >> The callback is executed just before the kernel victim task selection
> >> algorithm, so all heuristics and sysctls like panic on oom,
> >> sysctl_oom_kill_allocating_task and sysctl_oom_kill_allocating_task
> >> are respected.
> >
> > I guess you meant to say and sysctl_panic_on_oom.
> 
> Yep, fixed.
> >
> >> BPF OOM struct ops provides the handle_cgroup_offline() callback
> >> which is good for releasing struct ops if the corresponding cgroup
> >> is gone.
> >
> > What kind of synchronization is expected between handle_cgroup_offline
> > and bpf_handle_out_of_memory?
> 
> You mean from a user's perspective?

I mean from bpf handler writer POV

> E.g. can these two callbacks run in
> parallel? Currently yes, but it's a good question, I haven't thought
> about it, maybe it's better to synchronize them.
> Internally both rely on srcu to pin bpf_oom_ops in memory.

This should be really documented.
-- 
Michal Hocko
SUSE Labs

