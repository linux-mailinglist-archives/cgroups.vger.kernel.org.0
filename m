Return-Path: <cgroups+bounces-13476-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJwYOCuQeGmarAEAu9opvQ
	(envelope-from <cgroups+bounces-13476-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 27 Jan 2026 11:15:07 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB6692951
	for <lists+cgroups@lfdr.de>; Tue, 27 Jan 2026 11:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2130630901ED
	for <lists+cgroups@lfdr.de>; Tue, 27 Jan 2026 10:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D998D337BAA;
	Tue, 27 Jan 2026 10:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NV3uG0II"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954813358CA;
	Tue, 27 Jan 2026 10:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769508517; cv=none; b=dFzdED9D7VUKK7j/y6dCxCLTfWDTBuL2pyiB9EGSziHJhfy0VM4JvtPHB59Ep1HYIruloU179K/fHXXQaWm6kKpLiWMH4W7a812aOjY6l+Xmjx8EQp572A+zH4ly+kI+EAQhq6p9CE1KT3tBh1MXnrfF7nP/7ialKRSTjEgtoNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769508517; c=relaxed/simple;
	bh=5stgSFPOFTFIULArixFeHkYV56tWc18IJxdLX0dDglY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=RPvwNuFyQPHA2NI9T4WnIMNI8lCEInCa8fkbTXmSSCl+2K3h4woM8AnEnsd/Mx1mjQSUxxOQoRZ9hQdG/bY4iGPKbDzk+IFSHYpyyuwZ1PKiC1/S7oBxwsE5HcMrdLf4aBYWPytywZi0SWw9XznEIXx9+59LKx0wDffkZ1e0czw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NV3uG0II; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88634C116C6;
	Tue, 27 Jan 2026 10:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769508517;
	bh=5stgSFPOFTFIULArixFeHkYV56tWc18IJxdLX0dDglY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=NV3uG0IIJ6oSlguw1ZOHGTXtX0nknoen7oyTS8zTEgfLxcLcEXtD4qakjZdS+GRDN
	 m/iMbO0lg+p37/K4dLa4XKE/hjJWpm7tTOpi+ndk9g64uAZDiw7gXbWFhKVHyvI7fO
	 N9Dd9ZbQbIMC5rO1zWbIt3ZFZ1ARRxKSqZdp/SejHNvFxXCWHQl0v9TgiD9otDZ388
	 ypdzcpuHPEWW1mOZF60Aan+OvKkWE0pYm4UcReG1RH+fTqE9qxWp611DJfQBcShTs6
	 MlaGeAKzvdLhhZwxWiiTXlvTt8fD+2pcZncfLOhT9+en3swcxHqgm4KxDgl8rYJqPd
	 6SrdFZVC+e2Yg==
Content-Type: multipart/mixed; boundary="===============4752217963743545921=="
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6173f32708a0a1401350ac03dfeb0c3a6b212331b233b3269ff708dfc74dcffe@mail.kernel.org>
In-Reply-To: <f14f1ad53f742f993a7ac5cb5ba6eaee26bebd91.1769506741.git.zhuhui@kylinos.cn>
References: <f14f1ad53f742f993a7ac5cb5ba6eaee26bebd91.1769506741.git.zhuhui@kylinos.cn>
Subject: Re: [RFC PATCH bpf-next v5 08/12] mm: memcontrol: Add BPF struct_ops for memory controller
From: bot+bpf-ci@kernel.org
To: hui.zhu@linux.dev,akpm@linux-foundation.org,hannes@cmpxchg.org,mhocko@kernel.org,roman.gushchin@linux.dev,shakeel.butt@linux.dev,muchun.song@linux.dev,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,shuah@kernel.org,peterz@infradead.org,ojeda@kernel.org,nathan@kernel.org,kees@kernel.org,tj@kernel.org,jeffxu@chromium.org,mkoutny@suse.com,kernel@jfarr.cc,brauner@kernel.org,rdunlap@infradead.org,brgerst@gmail.com,masahiroy@kernel.org,davem@davemloft.net,kuba@kernel.org,hawk@kernel.org,inwardvessel@gmail.com,willemb@google.com,kerneljasonxing@gmail.com,paul.chaignon@gmail.com,a.s.protopopov@gmail.com,ameryhung@gmail.com,chenridong@huaweicloud.com,lance.yang@linux.dev,jiayuan.chen@linux.dev,linux-kernel@vger.kernel.org,linux-mm@kvack.org,cgroups@vger.kernel.org,bpf@vger.kernel.org,netdev@vger.kernel.org,linu
 x-kselftest@vger.kernel.org
Cc: zhuhui@kylinos.cn,geliang@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 27 Jan 2026 10:08:36 +0000 (UTC)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_REJECT(1.00)[signature check failed: fail, {[1] = sig:subspace.kernel.org:reject}];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kylinos.cn,kernel.org,iogearbox.net,gmail.com,linux.dev,meta.com];
	R_DKIM_REJECT(0.00)[kernel.org:s=k20201202];
	TAGGED_FROM(0.00)[bounces-13476-lists,cgroups=lfdr.de,bpf-ci];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FREEMAIL_TO(0.00)[linux.dev,linux-foundation.org,cmpxchg.org,kernel.org,iogearbox.net,gmail.com,fomichev.me,google.com,infradead.org,chromium.org,suse.com,jfarr.cc,davemloft.net,huaweicloud.com,vger.kernel.org,kvack.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:-];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+];
	RCPT_COUNT_GT_50(0.00)[60];
	NEURAL_HAM(-0.00)[-0.993];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.kernel.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5BB6692951
X-Rspamd-Action: no action

--===============4752217963743545921==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 1f74fce27677..8d90575aa77d 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c

[ ... ]

> @@ -2530,10 +2537,14 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  	 * kernel. If this is successful, the return path will see it
>  	 * when it rechecks the overage and simply bail out.
>  	 */
> -	if (current->memcg_nr_pages_over_high > MEMCG_CHARGE_BATCH &&
> -	    !(current->flags & PF_MEMALLOC) &&
> -	    gfpflags_allow_blocking(gfp_mask))
> -		__mem_cgroup_handle_over_high(gfp_mask);
> +	if (gfpflags_allow_blocking(gfp_mask)) {
> +		unsigned long bpf_high_delay;
> +
> +		bpf_high_delay = bpf_memcg_get_high_delay(orig_memcg);
> +		if (bpf_high_delay ||
> +		    current->memcg_nr_pages_over_high > MEMCG_CHARGE_BATCH)
> +			__mem_cgroup_handle_over_high(gfp_mask, bpf_high_delay);
> +	}

The old code checked !(current->flags & PF_MEMALLOC) before calling
__mem_cgroup_handle_over_high(). This check appears to be missing in the
new code.

When PF_MEMALLOC is set, the task is already in the memory reclaim context.
Calling __mem_cgroup_handle_over_high() from such a context would invoke
reclaim_high() -> try_to_free_mem_cgroup_pages(), potentially causing
reclaim recursion.

Was the removal of the PF_MEMALLOC check intentional? If a BPF program
returns a non-zero delay from get_high_delay_ms while the task is in a
reclaim context, could this lead to recursive reclaim or deadlock?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21392729810

AI-authorship-score: low
AI-authorship-explanation: The code shows typical human characteristics including a refactoring oversight that AI would likely not make; the commit follows standard kernel conventions and has multiple human authors.
issues-found: 1
issue-severity-score: medium
issue-severity-explanation: Missing PF_MEMALLOC check could cause memory reclaim recursion when BPF programs are attached, potentially leading to system instability.

--===============4752217963743545921==--

