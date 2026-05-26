Return-Path: <cgroups+bounces-16279-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNrnOYkOFWrYSQcAu9opvQ
	(envelope-from <cgroups+bounces-16279-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 05:07:53 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 873945D038A
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 05:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4EF4B3038789
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 03:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9563988FA;
	Tue, 26 May 2026 03:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OC5EvF4w"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE0F3955C0;
	Tue, 26 May 2026 03:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779764784; cv=none; b=oRJKspfygAC9XgkFjrlWWcRQe5tVzy2nSkG9qgUD5GvYNDQjzlis4E1MenzBC7ialz5SfVopSDobWPxH5NyIGnCFa2ZYBcjopZNhEV1J0M36MnYQ19HsksilBnnALwLEPlqvbx+fsb6ZETMY7mVyD4sqPAUaGkt83OzB4fzAw+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779764784; c=relaxed/simple;
	bh=jNwedSZc01G4PPLVZjvw7tG2uDXLEYYL1sTO8uf929w=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Sbmnv5fV9NLx4+9ldNGOww9aTsBMRNwMG8rL12SeQXNoUIh40GfNvPW+Drm54tAx7hMI58MjFPsnIhuYFFGDTMZNEetLVRMoDWR3r7+FprtCSwj/wSY8yfhiMWMOb75AAJL0/SM8Uy2b1phR+ZCAUB0YTDeSc7MgmNV0anOOggY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=fail (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OC5EvF4w reason="signature verification failed"; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77B591F000E9;
	Tue, 26 May 2026 03:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779764782;
	bh=RfDY2IiT45P+FJBgGvgzHm5+IszONppt2AHImYdZuBA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=OC5EvF4wBxmneLV7PaZ1qF+c+hH3vOkIXj4TsGtO2YqCAMk1GmrHrsknGPMUWCsdx
	 LPoad9Sb97LT05O2Ygzt+TGOkkZJ7VIKxB8PeMLMsFEbCT1qPvmNQ4OZbeB2Tr5nbg
	 cmRv4Ma5vYn6kPk109g7DLCOEjDWMuQ+oXjTN66SYz05eUJmVBvx227JVcK4HUEAlt
	 ntTkKfdS5t0f6E+Lq7/c3iy2nWKyznnnNSRPraSoKZZG9jf8B+OMjss9tEsaRmNZbZ
	 Mt8QbXe3+WrYv+ECtL/TBcWNlmX5+SYwnGAxCu5tRrEMCP20zgEB4Fpc+sk7tFj+ga
	 XNwBqleyGfAJQ==
Content-Type: multipart/mixed; boundary="===============6143565898584063114=="
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2da837791c9752c4a4db41a233bb631a8af042fa2fc900e3cdfff0c2a352de15@mail.kernel.org>
In-Reply-To: <13b10d91aff4307580d1a601f1592efe42a92b05.1779760876.git.zhuhui@kylinos.cn>
References: <13b10d91aff4307580d1a601f1592efe42a92b05.1779760876.git.zhuhui@kylinos.cn>
Subject: Re: [RFC PATCH bpf-next v7 07/11] mm/bpf: Add bpf_try_to_free_mem_cgroup_pages kfunc
From: bot+bpf-ci@kernel.org
To: hui.zhu@linux.dev, ast@kernel.org, daniel@iogearbox.net,
	john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
	eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
	yonghong.song@linux.dev, jolsa@kernel.org, hannes@cmpxchg.org,
	mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, inwardvessel@gmail.com,
	akpm@linux-foundation.org, shuah@kernel.org, davem@davemloft.net,
	kuba@kernel.org, hawk@kernel.org, sdf@fomichev.me,
	kpsingh@kernel.org, chen.dylane@linux.dev, yatsenko@meta.com,
	leon.hwang@linux.dev, a.s.protopopov@gmail.com, ameryhung@gmail.com,
	tklauser@distanz.ch, eyal.birger@gmail.com, rongtao@cestc.cn,
	haoluo@google.com, peterz@infradead.org, ojeda@kernel.org,
	nathan@kernel.org, kees@kernel.org, tj@kernel.org,
	jeffxu@chromium.org, mkoutny@suse.com, kernel@jfarr.cc,
	brauner@kernel.org, rdunlap@infradead.org, brgerst@gmail.com,
	masahiroy@kernel.org, willemb@google.com, kerneljasonxing@gmail.com,
	paul.chaignon@gmail.com, chenridong@huaweicloud.com,
	lance.yang@linux.dev, jiayu@web.codeaurora.org, an.chen@linux.dev,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	cgroups@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: geliang@kernel.org,baohua@kernel.org,zhuhui@kylinos.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 26 May 2026 03:06:21 +0000 (UTC)
X-Spamd-Result: default: False [2.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_REJECT(1.00)[signature check failed: fail, {[1] = sig:subspace.kernel.org:reject}];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,kylinos.cn,iogearbox.net,gmail.com,linux.dev,meta.com];
	R_DKIM_REJECT(0.00)[kernel.org:s=k20260515];
	TAGGED_FROM(0.00)[bounces-16279-lists,cgroups=lfdr.de,bpf-ci];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FREEMAIL_TO(0.00)[linux.dev,kernel.org,iogearbox.net,gmail.com,cmpxchg.org,linux-foundation.org,davemloft.net,fomichev.me,meta.com,distanz.ch,cestc.cn,google.com,infradead.org,chromium.org,suse.com,jfarr.cc,huaweicloud.com,web.codeaurora.org,vger.kernel.org,kvack.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:-];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+];
	RCPT_COUNT_GT_50(0.00)[69];
	NEURAL_HAM(-0.00)[-0.763];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.kernel.org:mid]
X-Rspamd-Queue-Id: 873945D038A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--===============6143565898584063114==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/mm/bpf_memcontrol.c b/mm/bpf_memcontrol.c
> index 1f726a7b22e3..0353c8736aa5 100644
> --- a/mm/bpf_memcontrol.c
> +++ b/mm/bpf_memcontrol.c

[ ... ]

> @@ -162,6 +163,60 @@ __bpf_kfunc void bpf_mem_cgroup_flush_stats(struct mem_cgroup *memcg)
>  	mem_cgroup_flush_stats(memcg);
>  }
>
> +/**
> + * bpf_try_to_free_mem_cgroup_pages - attempt to reclaim pages from
> + *                                    a memory cgroup
> + * @memcg:           the target memory cgroup to reclaim from
> + * @nr_pages:        the number of pages to reclaim
> + * @gfp_mask:        GFP flags controlling the reclaim behavior
> + * @reclaim_options: bitmask of MEMCG_RECLAIM_* flags to tune
> + *                   reclaim strategy
> + * @swappiness:      swappiness override value, or a sentinel to use
> + *                   the default
> + *
> + * BPF-facing wrapper around try_to_free_mem_cgroup_pages() that
> + * validates and translates the @swappiness argument before
> + * delegating to the core reclaim path.
> + *
> + * The @swappiness parameter follows these semantics:
> + *   - Values in [MIN_SWAPPINESS, SWAPPINESS_ANON_ONLY] are passed
> + *     through as an explicit swappiness override.
> + *   - Values below MIN_SWAPPINESS are treated as "use the system
> + *     default"; the override pointer is set to NULL and the cgroup's
> + *     own swappiness setting takes effect.
> + *   - Values above SWAPPINESS_ANON_ONLY are rejected as invalid.
> + *   - If @reclaim_options does not include MEMCG_RECLAIM_PROACTIVE,
> + *     the @swappiness override is ignored entirely by the core
> + *     reclaim path and the system default is used regardless.
> + *
> + * Swap usage during reclaim is gated on @reclaim_options: swap is
> + * considered only when MEMCG_RECLAIM_MAY_SWAP is set.  Without this
> + * flag, reclaim is restricted to file-backed pages regardless of the
> + * @swappiness value or the cgroup's swappiness setting.
> + *
> + * Return:
> + *   The number of pages actually reclaimed on success, or -%EINVAL
> + *   if @swappiness exceeds SWAPPINESS_ANON_ONLY.
> + */
> +unsigned long bpf_try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,

Should this function have the __bpf_kfunc annotation?  Every other kfunc
in this file (bpf_get_root_mem_cgroup, bpf_get_mem_cgroup,
bpf_put_mem_cgroup, bpf_mem_cgroup_vm_events, bpf_mem_cgroup_usage,
bpf_mem_cgroup_memory_events, bpf_mem_cgroup_page_state,
bpf_mem_cgroup_flush_stats) has it.

Documentation/bpf/kfuncs.rst section 2.5 states that kfunc definitions
should always be annotated with the __bpf_kfunc macro to prevent the
compiler from inlining the kfunc or the function being elided in an LTO
build as it's not used elsewhere in the kernel.

> +					       unsigned long nr_pages,
> +					       gfp_t gfp_mask,
> +					       unsigned int reclaim_options,
> +					       int swappiness)
> +{
> +	int *swapiness_ptr;
> +
> +	if (swappiness > SWAPPINESS_ANON_ONLY)
> +		return -EINVAL;

How can BPF callers detect this error?  The function returns
'unsigned long' (matching try_to_free_mem_cgroup_pages()'s page count),
but here it returns -EINVAL.

Implicit conversion of -EINVAL (int -22) to unsigned long produces
0xFFFFFFFFFFFFFFEA -- a very large positive value, not a negative error
code.  The kernel-doc above explicitly states "or -%EINVAL if
@swappiness exceeds SWAPPINESS_ANON_ONLY", which is impossible for an
unsigned return.

A BPF caller cannot distinguish the error from a real reclaim count via
'if (ret < 0)' because ret is unsigned.  The sample BPF program later
in the series (samples/bpf/memcg.bpf.c in commit 8dcfd8aa3316) checks
'bpf_try_to_free_mem_cgroup_pages(...) <= 0' which would only match 0
and would silently treat the giant 'error' value as 'many pages
reclaimed'.

Should this either return 'long' instead (so callers can branch on
negative), or use a clearly defined sentinel like (unsigned long)-1
(as the other kfuncs in this file do for errors)?

> +	else if (swappiness < MIN_SWAPPINESS)
> +		swapiness_ptr = NULL;
> +	else
> +		swapiness_ptr = &swappiness;
> +
> +	return try_to_free_mem_cgroup_pages(memcg, nr_pages, gfp_mask,
> +					    reclaim_options, swapiness_ptr);
> +}

[ ... ]

> @@ -175,6 +230,8 @@ BTF_ID_FLAGS(func, bpf_mem_cgroup_usage)
>  BTF_ID_FLAGS(func, bpf_mem_cgroup_page_state)
>  BTF_ID_FLAGS(func, bpf_mem_cgroup_flush_stats, KF_SLEEPABLE)
>
> +BTF_ID_FLAGS(func, bpf_try_to_free_mem_cgroup_pages, KF_SLEEPABLE)
> +
>  BTF_KFUNCS_END(bpf_memcontrol_kfuncs)


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26429228214
--===============6143565898584063114==--

