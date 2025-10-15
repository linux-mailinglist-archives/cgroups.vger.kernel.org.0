Return-Path: <cgroups+bounces-10792-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27987BE0AEF
	for <lists+cgroups@lfdr.de>; Wed, 15 Oct 2025 22:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CA441898722
	for <lists+cgroups@lfdr.de>; Wed, 15 Oct 2025 20:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB802C11F9;
	Wed, 15 Oct 2025 20:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Lc/RRzVh"
X-Original-To: cgroups@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A061A3254BB
	for <cgroups@vger.kernel.org>; Wed, 15 Oct 2025 20:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760561188; cv=none; b=hN+QoUd90NYX2q0NUfJzNt4p2wMJgvJyhFT8ui38v8UTzYgNPAlvVYtJTzSOAKgy51+QOm8KbkHilVZd1weoEDgCdoGBDfUYsmaglycJulA9bcbA89Q41l9f+kcxgYrG3QFVL6wHJQA41h7fU95q0/9J9zpHlk10p1/Dpp9Uwd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760561188; c=relaxed/simple;
	bh=Ejw/H1Qkf/Ij8udtsLD4+jTQjoLBNkVZ+VaR9c95Dug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CIX9HgIjsqmRLbz7dPpzXzxvWWIcyOCNgjEaXrOnMO36nxOuVsaaGFsrDIY0wzWATOrIlsjviawUKk2+uIjjVnMv4Hl+xnJ+ahQ61aoE75RjG/d8aiORaw6EtgLqVD5NnAWIJIH9ip3SGwq3cmTBQXm0cES70oEwTXCK8r6A5Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Lc/RRzVh; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 15 Oct 2025 13:46:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760561170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qLsontaXNMVQKPHfGbAAEY3guiak8DJs9osRf8Re/hc=;
	b=Lc/RRzVhCca2HURiHaH2zb+dCgSPEKV4/LU3ySTM6zRMTXik4BlvlJOQgpkx5pojkqUQG/
	Vj6JrSoHjsKYJJE5sJMq4B1LSX6kS0GBA/nd8e+3vAkHKUu7E7udLhUnGX8XjyG9N1xVTT
	MHgR6FS8Y2uD2FLBqZQYxc3OTdpbIiQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: JP Kobryn <inwardvessel@gmail.com>
Cc: andrii@kernel.org, ast@kernel.org, mkoutny@suse.com, 
	yosryahmed@google.com, hannes@cmpxchg.org, tj@kernel.org, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org, 
	kernel-team@meta.com, mhocko@kernel.org, roman.gushchin@linux.dev, 
	muchun.song@linux.dev
Subject: Re: [PATCH v2 0/2] memcg: reading memcg stats more efficiently
Message-ID: <uxpsukgoj5y4ex2sj57ujxxcnu7siez2hslf7ftoy6liifv6v5@jzehpby6h2ps>
References: <20251015190813.80163-1-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015190813.80163-1-inwardvessel@gmail.com>
X-Migadu-Flow: FLOW_OUT

Cc memcg maintainers.

On Wed, Oct 15, 2025 at 12:08:11PM -0700, JP Kobryn wrote:
> When reading cgroup memory.stat files there is significant kernel overhead
> in the formatting and encoding of numeric data into a string buffer. Beyond
> that, the given user mode program must decode this data and possibly
> perform filtering to obtain the desired stats. This process can be
> expensive for programs that periodically sample this data over a large
> enough fleet.
> 
> As an alternative to reading memory.stat, introduce new kfuncs that allow
> fetching specific memcg stats from within cgroup iterator based bpf
> programs. This approach allows for numeric values to be transferred
> directly from the kernel to user mode via the mapped memory of the bpf
> program's elf data section. Reading stats this way effectively eliminates
> the numeric conversion work needed to be performed in both kernel and user
> mode. It also eliminates the need for filtering in a user mode program.
> i.e. where reading memory.stat returns all stats, this new approach allows
> returning only select stats.
> 
> An experiment was setup to compare the performance of a program using these
> new kfuncs vs a program that uses the traditional method of reading
> memory.stat. On the experimental side, a libbpf based program was written
> which sets up a link to the bpf program once in advance and then reuses
> this link to create and read from a bpf iterator program for 1M iterations.

I am getting a bit confused on the terminology. You mentioned libbpf
program, bpf program, link. Can you describe each of them? Think of
explaining this to someone with no bpf background.

(BTW Yonghong already explained to me these details but I wanted the
commit message to be self explanatory).

> Meanwhile on the control side, a program was written to open the root
> memory.stat file

How much activity was on the system? I imagine none because I don't see
flushing in the perf profile. This experiment focuses on the
non-flushing part of the memcg stats which is fine.

> and repeatedly read 1M times from the associated file
> descriptor (while seeking back to zero before each subsequent read). Note
> that the program does not bother to decode or filter any data in user mode.
> The reason for this is because the experimental program completely removes
> the need for this work.

Hmm in your experiment is the control program doing the decode and/or
filter or no? The last sentence in above para is confusing. Yes, the
experiment program does not need to do the parsing or decoding in
userspace but the control program needs to do that. If your control
program is not doing it then you are under-selling your work.

> 
> The results showed a significant perf benefit on the experimental side,
> outperforming the control side by a margin of 80% elapsed time in kernel
> mode. The kernel overhead of numeric conversion on the control side is
> eliminated on the experimental side since the values are read directly
> through mapped memory of the bpf program. The experiment data is shown
> here:
> 
> control: elapsed time
> real    0m13.062s
> user    0m0.147s
> sys     0m12.876s
> 
> experiment: elapsed time
> real    0m2.717s
> user    0m0.175s
> sys     0m2.451s

These numbers are really awesome.

> 
> control: perf data
> 22.23% a.out [kernel.kallsyms] [k] vsnprintf
> 18.83% a.out [kernel.kallsyms] [k] format_decode
> 12.05% a.out [kernel.kallsyms] [k] string
> 11.56% a.out [kernel.kallsyms] [k] number
>  7.71% a.out [kernel.kallsyms] [k] strlen
>  4.80% a.out [kernel.kallsyms] [k] memcpy_orig
>  4.67% a.out [kernel.kallsyms] [k] memory_stat_format
>  4.63% a.out [kernel.kallsyms] [k] seq_buf_printf
>  2.22% a.out [kernel.kallsyms] [k] widen_string
>  1.65% a.out [kernel.kallsyms] [k] put_dec_trunc8
>  0.95% a.out [kernel.kallsyms] [k] put_dec_full8
>  0.69% a.out [kernel.kallsyms] [k] put_dec
>  0.69% a.out [kernel.kallsyms] [k] memcpy
> 
> experiment: perf data
> 10.04% memcgstat bpf_prog_.._query [k] bpf_prog_527781c811d5b45c_query
>  7.85% memcgstat [kernel.kallsyms] [k] memcg_node_stat_fetch
>  4.03% memcgstat [kernel.kallsyms] [k] __memcg_slab_post_alloc_hook
>  3.47% memcgstat [kernel.kallsyms] [k] _raw_spin_lock
>  2.58% memcgstat [kernel.kallsyms] [k] memcg_vm_event_fetch
>  2.58% memcgstat [kernel.kallsyms] [k] entry_SYSRETQ_unsafe_stack
>  2.32% memcgstat [kernel.kallsyms] [k] kmem_cache_free
>  2.19% memcgstat [kernel.kallsyms] [k] __memcg_slab_free_hook
>  2.13% memcgstat [kernel.kallsyms] [k] mutex_lock
>  2.12% memcgstat [kernel.kallsyms] [k] get_page_from_freelist
> 
> Aside from the perf gain, the kfunc/bpf approach provides flexibility in
> how memcg data can be delivered to a user mode program. As seen in the
> second patch which contains the selftests, it is possible to use a struct
> with select memory stat fields. But it is completely up to the programmer
> on how to lay out the data.

I remember you plan to convert couple of open source program to use this
new feature. I think below [1] and oomd [2]. Adding that information
would further make your case strong. cAdvisor[3] is another open source
tool which can take benefit from this work.

[1] https://github.com/facebookincubator/below
[2] https://github.com/facebookincubator/oomd
[3] https://github.com/google/cadvisor


