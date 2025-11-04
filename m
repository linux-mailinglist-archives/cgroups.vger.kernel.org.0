Return-Path: <cgroups+bounces-11561-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D4E0C2FDE6
	for <lists+cgroups@lfdr.de>; Tue, 04 Nov 2025 09:29:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DC89188B3AE
	for <lists+cgroups@lfdr.de>; Tue,  4 Nov 2025 08:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792C631195B;
	Tue,  4 Nov 2025 08:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="E1uEMldG"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E323D303C93
	for <cgroups@vger.kernel.org>; Tue,  4 Nov 2025 08:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762244309; cv=none; b=gZKf3iyg5uEApss8ZCnB51eVedOED2mABpH7x4aTr5NV1Ux7gBT84zZuL6lMBAFud8DYGwuLb9kLSmJCWNeh6ZBmZKMW/CxuqkFYhtk7HSSQTHvY/xpeT7vM8jMTJvYyY0FWrf3wFoz06Q7g8ZGdIQplG7bj2U63G0/qR3FVJ8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762244309; c=relaxed/simple;
	bh=y1H0J8xShtW8C86BhW+X8QqScD8LGdJ12xq4p3MILSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ieQqdi0zkdu76czk4tu+joOeHSFskZX4tslGq2bzL7kbVJ1ZwM8cZTIVoRBWC2Y8tdvYRM9NK99VmEDtKw8ixVcYWBbN/UFxl+AaOoFZq4a+wmKHmxTpQeYS5iU4JyAgQstDX/HmXAxpW5T3SdOBJWrLXqnFDSdrh4BsbxR5A2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=E1uEMldG; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-429c19b5de4so193389f8f.3
        for <cgroups@vger.kernel.org>; Tue, 04 Nov 2025 00:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762244304; x=1762849104; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HDGrwGIAe+HNiwkyvFhP/kp5qQx4Bemq/CCgC2+MOGE=;
        b=E1uEMldGmpryX7F87XkuxTRDtdwDgdHX1+Ghb8cr9Y+KDJ084RLi5KHRRsc9uMWuZ2
         si/J3mlAwe6fCyi35LOCST0p2smFYFBlJDjAdr3DuhcX08k0b0aNWmC0KtcLQyr4CPMU
         qEQJQUlI3YSd2twL/M9XEGogCnLBxCBkjm8MSRVhj1EDdA9P9/Zk3vcqEsial8zOaA1r
         iSoALBkdeI+ve9EVjjS63MNaxxeWZsQjamPCEn9CaW2QhkLMioynSBZd93yQg2NXqniq
         UhyqlI9cgPmXfJvXzCE6dNDBtyO64WoEaFZukUXORJGwCC4FdNVSjFDIBfVJozzpfI9X
         AvbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762244304; x=1762849104;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HDGrwGIAe+HNiwkyvFhP/kp5qQx4Bemq/CCgC2+MOGE=;
        b=mD4Xk9V9aHsSZlIMiEUqczbsxuk5rCIoYDFwCDBWYOm8SWC8I+Du6Xr71UPIg3BU49
         hcohR+vJkk8DwBuyQLj3sll92Wc+LkqU9cqBRC90kv1O0xXddEMRZjmROg/JZbGVVqqF
         ikj1pNCbF5KS+UCi/mCFCzeLfbJ4ArHLY9Z6G0r7rlxBLTq9l9XSHYOKLEhuzhvXmRVu
         8pFfGFM4n9ufjwzRO1tugqUhPZB15ID+C6QNcmaREi1GOIkTudpg5PvQM5Tvqarifd0g
         lh38ph2KzDePYNerxV+di9vIQmkiIYfClt0wXdsZUTGWT2xkxVZdyHsqOwIdEdVMR5Pu
         +ffQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfVNjTZ1GZMfzDJ3tsg2WR4q5mJNN8f7nUzQHoxP8cxzkQFlx954LDLCtDOfhN4/AOgoRx+Q0m@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3M6gtS+Mi9vAci2Ld69e9NmgTl1kh7JZK6omrm9FAJmjXYZAK
	VpW5OTfD/rMDWjqo6ymZXcfWa5fkvr/SmTZ/Ihcam1xk5lZCquwclQWgppqKauv3oxs=
X-Gm-Gg: ASbGnct3a1qzLpH8sqaPIVSY6synNF0x0oLCP6/R3jrgV/Rm1qUJ0V3JUKWgHUZ7Rz/
	tBKAiPnTpOSYs/+S3VTmyD//8eYfnKiN0a1cQ6vYGYVpDN+fGvKq76kM7/bhiZNWSYCJw/W36r/
	+nqWjYcqkSser98k8eTB0sLgP5E/U5VUc4O26Aa3KW2IhELrkpcXlg+btz4qJy62Kpk1m8ZDXNc
	4akAPw4PNme+euueUbgT9PuBX9NbRo75U5KW8wogHjPRNUotpVaWy1r9hRERHLd49kT3lpeO1O3
	TVVUoM1yraRe1sGZar6TBwpRqwY6T5HzyJR3gLuOCx4OitJHxtpbGuPuBkJVMjPgnMOe6hmtxXG
	AcKcmJXSjlXJEGcUQaSYRw9IEOAfxYLWbPgXyL5ZOBf3yad6b0IQTLuLy6dSDWePrtRo51H3V+Q
	nhEYFYQEv4luWYhHj7ztE=
X-Google-Smtp-Source: AGHT+IER82dbwOAWSEGagB9JoBAQ4DFL/N85XJT6dQwU/F6NCVBuyJKblUAv95YkwnJ9rUbOTpPUNg==
X-Received: by 2002:a05:6000:40c7:b0:425:76e3:81c5 with SMTP id ffacd0b85a97d-429bd6827fcmr12672112f8f.17.1762244303953;
        Tue, 04 Nov 2025 00:18:23 -0800 (PST)
Received: from localhost (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc193e27sm3237804f8f.18.2025.11.04.00.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 00:18:23 -0800 (PST)
Date: Tue, 4 Nov 2025 09:18:22 +0100
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
Message-ID: <aQm2zqmD9mHE1psg@tiehlicka>
References: <20251027231727.472628-1-roman.gushchin@linux.dev>
 <20251027231727.472628-7-roman.gushchin@linux.dev>
 <aQR7HIiQ82Ye2UfA@tiehlicka>
 <875xbsglra.fsf@linux.dev>
 <aQj7uRjz668NNrm_@tiehlicka>
 <87a512muze.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a512muze.fsf@linux.dev>

On Mon 03-11-25 17:45:09, Roman Gushchin wrote:
> Michal Hocko <mhocko@suse.com> writes:
> 
> > On Sun 02-11-25 13:36:25, Roman Gushchin wrote:
> >> Michal Hocko <mhocko@suse.com> writes:
[...]
> > No, I do not feel strongly one way or the other but I would like to
> > understand thinking behind that. My slight preference would be to have a
> > single return status that clearly describe the intention. If you want to
> > have more flexible chaining semantic then an enum { IGNORED, HANDLED,
> > PASS_TO_PARENT, ...} would be both more flexible, extensible and easier
> > to understand.
> 
> The thinking is simple:
> 1) Most users will have a single global bpf oom policy, which basically
> replaces the in-kernel oom killer.
> 2) If there are standalone containers, they might want to do the same on
> their level. And the "host" system doesn't directly control it.
> 3) If for some reason the inner oom handler fails to free up some
> memory, there are two potential fallback options: call the in-kernel oom
> killer for that memory cgroup or call an upper level bpf oom killer, if
> there is one.
> 
> I think the latter is more logical and less surprising. Imagine you're
> running multiple containers and some of them implement their own bpf oom
> logic and some don't. Why would we treat them differently if their bpf
> logic fails?

I think both approaches are valid and it should be the actual handler to
tell what to do next. If the handler would prefer the in-kernel fallback
it should be able to enforce that rather than a potentially unknown bpf
handler up the chain.

> Re a single return value: I can absolutely specify return values as an
> enum, my point is that unlike the kernel code we can't fully trust the
> value returned from a bpf program, this is why the second check is in
> place.

I do not understand this. Could you elaborate? Why we cannot trust the
return value but we can trust a combination of the return value and a
state stored in a helper structure?

> Can we just ignore the returned value and rely on the freed_memory flag?

I do not think having a single freed_memory flag is more helpful. This
is just a number that cannot say much more than a memory has been freed.
It is not really important whether and how much memory bpf handler
believes it has freed. It is much more important to note whether it
believes it is done, it needs assistance from a different handler up the
chain or just pass over to the in-kernel implementation.

> Sure, but I don't think it bus us anything.
> 
> Also, I have to admit that I don't have an immediate production use case
> for nested oom handlers (I'm fine with a global one), but it was asked
> by Alexei Starovoitov. And I agree with him that the containerized case
> will come up soon, so it's better to think of it in advance.

I agree it is good to be prepared for that.

> >> >> The bpf_handle_out_of_memory() callback program is sleepable to enable
> >> >> using iterators, e.g. cgroup iterators. The callback receives struct
> >> >> oom_control as an argument, so it can determine the scope of the OOM
> >> >> event: if this is a memcg-wide or system-wide OOM.
> >> >
> >> > This could be tricky because it might introduce a subtle and hard to
> >> > debug lock dependency chain. lock(a); allocation() -> oom -> lock(a).
> >> > Sleepable locks should be only allowed in trylock mode.
> >> 
> >> Agree, but it's achieved by controlling the context where oom can be
> >> declared (e.g. in bpf_psi case it's done from a work context).
> >
> > but out_of_memory is any sleepable context. So this is a real problem.
> 
> We need to restrict both:
> 1) where from bpf_out_of_memory() can be called (already done, as of now
> only from bpf_psi callback, which is safe).
> 2) which kfuncs are available to bpf oom handlers (only those, which are
> not trying to grab unsafe locks) - I'll double check it in thenext version.

OK. All I am trying to say is that only safe sleepable locks are
trylocks and that should be documented because I do not think it can be
enforced

-- 
Michal Hocko
SUSE Labs

