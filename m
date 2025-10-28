Return-Path: <cgroups+bounces-11298-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A89C16816
	for <lists+cgroups@lfdr.de>; Tue, 28 Oct 2025 19:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 82F714E73BB
	for <lists+cgroups@lfdr.de>; Tue, 28 Oct 2025 18:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D2E2853FD;
	Tue, 28 Oct 2025 18:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dSTQ7fLp"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A6B34887B;
	Tue, 28 Oct 2025 18:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761676317; cv=none; b=hGWGNvbkuCrjEX1EsO62foU2tmmFzxj54Og8LqvRHodTZeBRQen9WMIaHSrMrfXcpa2uVvVlIo35grqSPnoJ27NXUmiO6rZY7f+Kpx9PgKOUFcizgwpY+7Sf/BaCDqjgGj5uiDhba5AlI7bV3ByTaffrNtgV98ti5tHCcE0tAFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761676317; c=relaxed/simple;
	bh=Jz+xbsYpIW+XRlp07m9hjFj4lzFgfq3vzbi6oujtiOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HZJ97ghy0ZTrHh9e24GDQCLSSs94ltF5sfneMIyCZzIMtp+RUQFxMH2QJgCKaYV+9F+BOuDZui5C74mubiYNsOfjPtP9PwiNlBL1E03oC0hY3/PiCgFgPNZ5X0jx/HpL4So2xTJJpm5HKspUjZF1/qD616wBdzTt+ajGDkf1/bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dSTQ7fLp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6875EC4CEE7;
	Tue, 28 Oct 2025 18:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761676316;
	bh=Jz+xbsYpIW+XRlp07m9hjFj4lzFgfq3vzbi6oujtiOg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dSTQ7fLpUEgaQWMm3JM9x2uJw2teY3OFi61nzuGcSC/ofmmQ4UUNKJFKwIzyzeJS0
	 o13aHsL5FHta5P7B7VftG1sj2/BhBPaKCqolUUi5NUXMEoT368Gb4Cq15IyN8NYome
	 1uIWQA5X0apRwJQPgUSoIl5K3q1GbuAGJHDPgcjwYSl+ct5Qb5SZcZC8tdhWbtgmoH
	 ydA1FRB5VQ/1yl0dauTiEMWJnNV0uKGzpxAopHKgnLPhlsxZj+Vqi2CMfarQCfe+LO
	 p/HfLi7jFpBX5eX3pIVLc90evL+Npo9KZQtz16HvE5k6LWE6GkZlGdZrAUQggXrhIn
	 WOQnwjho4g7oQ==
Date: Tue, 28 Oct 2025 08:31:55 -1000
From: Tejun Heo <tj@kernel.org>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	JP Kobryn <inwardvessel@gmail.com>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Song Liu <song@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: Re: [PATCH v2 15/23] mm: introduce bpf_task_is_oom_victim() kfunc
Message-ID: <aQEMG508sUQWDGrn@slm.duckdns.org>
References: <20251027232206.473085-1-roman.gushchin@linux.dev>
 <20251027232206.473085-5-roman.gushchin@linux.dev>
 <aQD-RvxrX8_7QtxT@slm.duckdns.org>
 <877bwevqxz.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877bwevqxz.fsf@linux.dev>

Hello,

On Tue, Oct 28, 2025 at 11:09:28AM -0700, Roman Gushchin wrote:
> > In general, I'm not sure it's a good idea to add kfuncs for things which are
> > trivially accessible. Why can't things like this be provided as BPF
> > helpers?
> 
> I agree that this one might be too trivial, but I added it based on the
> request from Michal Hocko. But with other helpers (e.g. for accessing
> memcg stats) the idea is to provide a relatively stable interface for
> bpf programs, which is not dependent on the implementation details. This
> will simplify the maintenance of bpf programs across multiple kernel
> versions.

This is an abstract subject and thus a bit difficult to argue concretely.
I'll just share my take on it based on my experience w/ sched_ext.

The main problem with "I'll add enough interfaces to keep the BPF programs
stable" is that it's really difficult to foresee how BPF programs will
actually use them. You may have certain ideas on what information they would
consume and how but other people may have completely different ideas. After
all, that's why we want this to be BPF defined.

Projecting to the future, there's a pretty good chance that some programs
will be using mix of these hard coded interfaces and other generic BPF hooks
and mechanisms. At that point, when you want to add access to something new,
the decision becomes awakward. Adding a new hard coded interface doesn't
really enable anything that isn't possible otherwise while creating
compatibility problems for older kernels.

The other side of that coin is that BPF has a lot of mechanisms that support
backward and forward binary compatibility such as CO-RE relocations,
polymorhpic struct_ops and kfunc matching, type-aware symbol existence
testing and so on. It really is not that difficult to maintain a pretty
large sliding window of compatibility using these mechanisms and I believe
concerns over interface stability is overblown.

So, my take is that trying to bolster interface stability doesn't really
solve serious enough problems that justify the downsides of adding those
hard coded interface. There are just better and more flexible ways to deal
with them.

Thanks.

-- 
tejun

