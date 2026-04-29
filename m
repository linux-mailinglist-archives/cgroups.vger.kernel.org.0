Return-Path: <cgroups+bounces-15554-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFLpHO348WmElwEAu9opvQ
	(envelope-from <cgroups+bounces-15554-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 29 Apr 2026 14:26:21 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E66494064
	for <lists+cgroups@lfdr.de>; Wed, 29 Apr 2026 14:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 61AFD301AF5D
	for <lists+cgroups@lfdr.de>; Wed, 29 Apr 2026 12:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91DC43BAD88;
	Wed, 29 Apr 2026 12:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="X+H1I/qj"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521333B0ACD;
	Wed, 29 Apr 2026 12:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777465570; cv=none; b=oTzWAA1bpVF8/xItGQEqGYJsTXTNS8LN0In5txwykTNbZzePCH9tKz810Wf1X7zkWklezXD5sJ463KZyB2ZFWiMz6x/D70JmUechwQYBV31w3ujKE2vuFlYuJgRmfDBYg2fHbsFVWIHouSwHxSlG9G0c84WCv7hLAri5Eb2IXA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777465570; c=relaxed/simple;
	bh=XZdLG7NrTLr1gkaO2uQpheM8UanKy4xE7H3oI6Nz0L4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=oKfW/lO8NC5tWagcVIOz8nknk09GjRUytwY5Kz4SlwG5AaSyjDqf/R263lqLvN1MlKFkqiP9AyUPEacXo1qdxYrfZi2lfOlPoKJ/5xYLmqV/vtoLaPogcUDTP7Gsvo+HK6FEsoKQAENWT+ZWG/E0RWWJ2Tmh4ruUPq99R2STVNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=X+H1I/qj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25A87C19425;
	Wed, 29 Apr 2026 12:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1777465569;
	bh=XZdLG7NrTLr1gkaO2uQpheM8UanKy4xE7H3oI6Nz0L4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=X+H1I/qj8goOLZtdjEVIxjRbAfxP0QCXilX+8kzOu/cnPJPFV/my/xCymwQHxhXlJ
	 CkDLkdcssxPd70q/xWhX+8Vl9ijCfqVav6swEqy72PMZ6WcuEKd0f0qT63TDr7cZdC
	 Yk74rfl80yWYBRWsPAfvA4ZBW2T+/caQmH8gE1Bg=
Date: Wed, 29 Apr 2026 05:26:08 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Hui Zhu <hui.zhu@linux.dev>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt
 <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Hui Zhu <zhuhui@kylinos.cn>
Subject: Re: [PATCH] mm/memcontrol: hoist pstatc_pcpu assignment out of CPU
 loop
Message-Id: <20260429052608.b4787b75f11889919ff631ad@linux-foundation.org>
In-Reply-To: <20260429084216.186238-1-hui.zhu@linux.dev>
References: <20260429084216.186238-1-hui.zhu@linux.dev>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 04E66494064
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15554-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,cgroups@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email,linux-foundation.org:dkim,linux-foundation.org:mid,kylinos.cn:email]

On Wed, 29 Apr 2026 16:42:16 +0800 Hui Zhu <hui.zhu@linux.dev> wrote:

> From: Hui Zhu <zhuhui@kylinos.cn>
> 
> In mem_cgroup_alloc(), the assignment of pstatc_pcpu is invariant
> with respect to the for_each_possible_cpu() loop: both the 'parent'
> pointer and 'parent->vmstats_percpu' remain constant throughout all
> iterations.
> 
> The original code redundantly re-evaluated the 'if (parent)'
> condition and reassigned pstatc_pcpu on every CPU iteration, then
> repeated the same ternary check 'parent ? pstatc_pcpu : NULL' when
> storing into statc->parent_pcpu.
> 
> Move the single conditional assignment of pstatc_pcpu to before the
> loop, resolving both the loop-invariant placement issue and the
> duplicated null check. On systems with a large number of possible
> CPUs, this eliminates repeated branch evaluation with no functional
> change.
> 
> No functional change intended.
> 
> ...
>
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3993,11 +3993,10 @@ static struct mem_cgroup *mem_cgroup_alloc(struct mem_cgroup *parent)
>  	if (!memcg1_alloc_events(memcg))
>  		goto fail;
>  
> +	pstatc_pcpu = parent ? parent->vmstats_percpu : NULL;
>  	for_each_possible_cpu(cpu) {
> -		if (parent)
> -			pstatc_pcpu = parent->vmstats_percpu;
>  		statc = per_cpu_ptr(memcg->vmstats_percpu, cpu);
> -		statc->parent_pcpu = parent ? pstatc_pcpu : NULL;
> +		statc->parent_pcpu = pstatc_pcpu;
>  		statc->vmstats = memcg->vmstats;
>  	}

lgtm.

I expected this to make no change to generated code but it actually
reduces memcontrol.o text by nearly 300 bytes (x86_64 allmodconfig).

