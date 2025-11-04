Return-Path: <cgroups+bounces-11570-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A47EC32C29
	for <lists+cgroups@lfdr.de>; Tue, 04 Nov 2025 20:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAB6C18C0550
	for <lists+cgroups@lfdr.de>; Tue,  4 Nov 2025 19:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE842D3A6A;
	Tue,  4 Nov 2025 19:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="et7KA9Nj"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78442949E0
	for <cgroups@vger.kernel.org>; Tue,  4 Nov 2025 19:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762284136; cv=none; b=Jlk49G2Ys+D5op5q/V6WZGL7TZhNwtVw9H2PNEvjSDKnTtAHLIEUphE2xhFa1bSQDihGmxCBOv4crLbkZ71YYex3d22TP+DkMCekAF0pajfPWunpZ1upVNjcsQVpgYNl4ZFjjadTDvyysM4Ps3wlzVYRFSVcxVFcfySFFGNUp18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762284136; c=relaxed/simple;
	bh=WbhMZPXHui4/68TSc/Fw9kwjHb3ZGo9L4Ezoe48x7ZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OsNmeVG1xv4C28TJUsUF1b2rwZxY5RuUOTgC4XEw+qoJfIqWj6svsFmdE3Mi2OdHE0R4kLoWXlLD1SvCC8hTBgkIX7G8yye1aZnqjTuSgeZ33fm7CPNR7fH4E47tjVeaxf7/X+K3Wxe8UkafwrdouMom6Brmb2AoptU8sH6GY+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=et7KA9Nj; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b70fb7b54cdso260839566b.1
        for <cgroups@vger.kernel.org>; Tue, 04 Nov 2025 11:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762284133; x=1762888933; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+Ekbw2JAUHQcxMukPAtOc9LSVhS6WclBdtt7KL4LfcQ=;
        b=et7KA9Nj65dv1MgQqmoM+bKuQryuUn3xss6RS8d7RwbO9+dc21CuHCv6iHuaEYPQYR
         hLkIIgQ4a48bhi9EnuKUtm4BA5OKOilVtpwrq7LeA4HMyfDNs5EpwM9oVYJtkNgL5uXp
         YKfEJONmr+h604CSj/FhxEb9WkDgMvMZm0os/YsKEjStc0fLrHiBjYH9BcZjnmUO2+pq
         2OQch7LFSQzt+GfTtLa989ISTwJajZmvY3WdXwQSAqZRYqRGcGjbiIVp5TLMatgD0URx
         8Jh81kT0Xx1/iYs3R/JzDWZCVfFPhKaJWvJZkPHiAoloDxtAmGjToGGAlrNSScVH1QqC
         i+bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762284133; x=1762888933;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Ekbw2JAUHQcxMukPAtOc9LSVhS6WclBdtt7KL4LfcQ=;
        b=VeyPREzj0jZ5ixkWdv25dHDdEjYigml/gWn0IBLRWNkfhwEG0SPYyHSt1WjW8AmB00
         WIEBjPKtPXLUcPN882Vuk1TtaRAhEN2bzgcXkkqQ3T579WSRoA7EkNPaLqQkxWQdMJ7T
         A0UZDlt3IPMgRl6m14p9fcrvVbWBw+rD5oYgz8bup8IvmIXDrOtlIFWHjSHWP8MzIprY
         NPLzrAqsAJgTVH13OU2ukxNc8O5mfD7uXKVSbVTFcX6sHaTnehQiZuaKS9IDM3JGXYLp
         McsSsJh7EQXmWGnJchatxKxYGk8McvgnGKxrifEgqta6cxX4NWNHoD54HKkEJiSr6NdA
         viaw==
X-Forwarded-Encrypted: i=1; AJvYcCXmgdqRZBWxoYEDVwdWC9jaek/eybfHlt8Of69+CkKcKxnxH/GKKkf+TLDmwR4oakl8kK9BoW8/@vger.kernel.org
X-Gm-Message-State: AOJu0YwGU+dXqfEdmZNum3cUZ2xbEiRfg5mDdGoMRE6Wzzhbe7iLge7I
	zdNEKrdGU9P+Y66H0aQ5FRc16XP3+rsSnJ3NpjjyzXIP+94VsnsWazObNKNslTKm0Rc=
X-Gm-Gg: ASbGncsX6fhJmsoSVM+XMGesiDGSzeqAyUj2f1H1KKMfdVVal5dF+BeSkMkkBOceSxz
	kSlNhHIuxyfeO1XdonCY30qtPbznFGTqHJ2WMkY+dsTtC5oW4fCTdSyjYB+3MD6FCEDVrDx5azl
	Uzmo555r4AoS8b54Wrroew5mIOLGGX+2xaJQu+V694Z+cDGC9MJNBlKeKizCFAOCoTcySi1khrB
	W1o7ak3lNN/a0PcoclKMLRNAhgPtoi8qpdNCHDHB5DU+aedSAY/ztRG9JXRGYoL1yMWsl3Xdfhw
	GW1kFy94u19r0y/nJS5RoGsZVuxJXHW3Fbi1rNV8BuUjQmHK96yNGVFkK18KUM8ThGtLAobnjQO
	vqMTbjRrKlIphcLabRHEiGbaaLYkinwwVEHZYpUBn65Dl7CoqMJiutvwdpbicoLEjuXbjIJjRm4
	PfgIfQImPw6DHH2A==
X-Google-Smtp-Source: AGHT+IFik8SalFdLc/bnmoU3LnAmqT4cTwgJ3PvSTxEZQ+CS4V8zLsokvxKnUaET/LmVBxkwZrJpyw==
X-Received: by 2002:a17:907:9721:b0:b6d:5bc1:4859 with SMTP id a640c23a62f3a-b72653cb70amr25182666b.29.1762284133077;
        Tue, 04 Nov 2025 11:22:13 -0800 (PST)
Received: from localhost (109-81-31-109.rct.o2.cz. [109.81.31.109])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723fe3902bsm285399366b.63.2025.11.04.11.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 11:22:12 -0800 (PST)
Date: Tue, 4 Nov 2025 20:22:06 +0100
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
Message-ID: <aQpSXgUL1fUzRgyL@tiehlicka>
References: <20251027231727.472628-1-roman.gushchin@linux.dev>
 <20251027231727.472628-7-roman.gushchin@linux.dev>
 <aQR7HIiQ82Ye2UfA@tiehlicka>
 <875xbsglra.fsf@linux.dev>
 <aQj7uRjz668NNrm_@tiehlicka>
 <87a512muze.fsf@linux.dev>
 <aQm2zqmD9mHE1psg@tiehlicka>
 <87h5v93bte.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h5v93bte.fsf@linux.dev>

On Tue 04-11-25 10:14:05, Roman Gushchin wrote:
> Michal Hocko <mhocko@suse.com> writes:
> 
> > On Mon 03-11-25 17:45:09, Roman Gushchin wrote:
> >> Michal Hocko <mhocko@suse.com> writes:
> >> 
> >> > On Sun 02-11-25 13:36:25, Roman Gushchin wrote:
> >> >> Michal Hocko <mhocko@suse.com> writes:
> > [...]
> >> > No, I do not feel strongly one way or the other but I would like to
> >> > understand thinking behind that. My slight preference would be to have a
> >> > single return status that clearly describe the intention. If you want to
> >> > have more flexible chaining semantic then an enum { IGNORED, HANDLED,
> >> > PASS_TO_PARENT, ...} would be both more flexible, extensible and easier
> >> > to understand.
> >> 
> >> The thinking is simple:
> >> 1) Most users will have a single global bpf oom policy, which basically
> >> replaces the in-kernel oom killer.
> >> 2) If there are standalone containers, they might want to do the same on
> >> their level. And the "host" system doesn't directly control it.
> >> 3) If for some reason the inner oom handler fails to free up some
> >> memory, there are two potential fallback options: call the in-kernel oom
> >> killer for that memory cgroup or call an upper level bpf oom killer, if
> >> there is one.
> >> 
> >> I think the latter is more logical and less surprising. Imagine you're
> >> running multiple containers and some of them implement their own bpf oom
> >> logic and some don't. Why would we treat them differently if their bpf
> >> logic fails?
> >
> > I think both approaches are valid and it should be the actual handler to
> > tell what to do next. If the handler would prefer the in-kernel fallback
> > it should be able to enforce that rather than a potentially unknown bpf
> > handler up the chain.
> 
> The counter-argument is that cgroups are hierarchical and higher level
> cgroups should be able to enforce the desired behavior for their
> sub-trees. I'm not sure what's more important here and have to think
> more about it.

Right and they can enforce that through their limits - hence oom.

> Do you have an example when it might be important for container to not
> pass to a higher level bpf handler?

Nothing really specific. I still trying to wrap my head around what
level of flexibility is necessary here. My initial thoughts would be
just deal with it in the scope of the bpf handler and fallback to the
kernel implementation if it cannot deal with the situation. Since you
brought that up you made me think.

I know that we do not provide userspace like no-regression policy to BPF
programs but it would be still good to have a way to add new potential
fallback policies without breaking existing handlers.

> >> Re a single return value: I can absolutely specify return values as an
> >> enum, my point is that unlike the kernel code we can't fully trust the
> >> value returned from a bpf program, this is why the second check is in
> >> place.
> >
> > I do not understand this. Could you elaborate? Why we cannot trust the
> > return value but we can trust a combination of the return value and a
> > state stored in a helper structure?
> 
> Imagine bpf program which does nothing and simple returns 1. Imagine
> it's loaded as a system-wide oom handler. This will effectively disable
> the oom killer and lead to a potential deadlock on memory.
> But it's a perfectly valid bpf program.
> This is something I want to avoid (and it's a common practice with other
> bpf programs).
> 
> What I do I also rely on the value of the oom control's field, which is
> not accessible to the bpf program for write directly, but can be changed
> by calling certain helper functions, e.g. bpf_oom_kill_process.

OK, now I can see your point. You want to have a line of defense from
trusted BPF facing interface. This makes sense to me. Maybe it would be
good to call that out more explicitly. Something like 
The BPF OOM infrastructure only trusts BPF handlers which are using pre
selected functions to free up memory e.g. bpf_oom_kill_process. Those
will set an internal state not available to those handlers directly.
BPF handler return value is ignored if that state is not set.

I would rather call this differently to freed_memory as the actual
memory might be freed asynchronously (e.g. oom_reaper) and this is more
about conformity/trust than actual physical memory being freed. I do not
care much about naming as long as this is clearly document though.
Including set of functions that are forming that prescribed API.

[...]
> > OK. All I am trying to say is that only safe sleepable locks are
> > trylocks and that should be documented because I do not think it can be
> > enforced
> 
> It can! Not directly, but by controlling which kfuncs/helpers are
> available to bpf programs.

OK, I see. This is better than relying only on having this documented.

-- 
Michal Hocko
SUSE Labs

