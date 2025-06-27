Return-Path: <cgroups+bounces-8636-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C20C4AEABA4
	for <lists+cgroups@lfdr.de>; Fri, 27 Jun 2025 02:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EC621C2330A
	for <lists+cgroups@lfdr.de>; Fri, 27 Jun 2025 00:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE244D2FB;
	Fri, 27 Jun 2025 00:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kr7Ib40r"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AF09460;
	Fri, 27 Jun 2025 00:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750983330; cv=none; b=qZkHJCiVOgajLCtyJR/s3qsEDJgYjPs3UkBWAF8X9Ue4BVBFW9bgm1lTdvvH5nz3ijlCk6UVYvat6g0DoykoPSGYPaElxCVLk33P2k1JspGGVCSitCLLtnzWLtA4uIse4qpyTiKnWfqhcHGJeSDrUvbFBzGDm5MnsU9JebrM4F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750983330; c=relaxed/simple;
	bh=m945KNlyWYf0qERzTab94sokctIlIGpySTIYEKVfQzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EGCnCFcHMub5aX6qa1lvIsv9J0AQcJoWGYIHjW0cGr1hRJGhClGW12ao3AsHsUhUZOZ1X5BMr0KnDEWah6I4wkNb07Ftaajqtl1+Gm5ye1u9Q86Wt9RHlefcC/KYn9+JZmSUScTl8N7NMuflw7W0rogKrKDjmoQTXDAVV8rYRBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kr7Ib40r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D17A3C4CEEB;
	Fri, 27 Jun 2025 00:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750983330;
	bh=m945KNlyWYf0qERzTab94sokctIlIGpySTIYEKVfQzw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kr7Ib40rXKzOfbtpOqTWk9H9JSFObuOi9Ec+z059VOSTkYmi1AivcRjSyMIaMdn66
	 +ZHuP9iKnzV+TSucZtWy7hdMSjaO+mxiDbliqh1SOYybiJyIR4xlHYdMHL0WCCizFA
	 wGthh9jhYPB9alBN0zhcKc6/NgEPfQ42pllSbve8U/nB/6zm+6bI2gMt8gXmK0P9dC
	 P7fT5E1cZgkmG+xa+SyLp9fRVgXyLwGw474Iqrx7nh9MGmZQSR0nZoqg5FXjDtHgKt
	 XmbP+ghaSoiILCroptjomvtLpiB7CoIqOlElo2r6jmdcSFV2NAau+TnBuzrXjxGbLL
	 D5sGuaEYbdQVw==
Date: Thu, 26 Jun 2025 14:15:28 -1000
From: Tejun Heo <tj@kernel.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: "Paul E . McKenney" <paulmck@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	JP Kobryn <inwardvessel@gmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Ying Huang <huang.ying.caritas@gmail.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Alexei Starovoitov <ast@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	bpf@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] llist: add [READ|WRITE]_ONCE tags for llist_node
Message-ID: <aF3ioBE_HX2_s-_o@slm.duckdns.org>
References: <20250626190550.4170599-1-shakeel.butt@linux.dev>
 <fyyks2xnzytr5hybzxeb4srrmrr64dxacwrcjd7v7anttjdy3s@hgp2s2th2t5m>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fyyks2xnzytr5hybzxeb4srrmrr64dxacwrcjd7v7anttjdy3s@hgp2s2th2t5m>

Hello,

On Thu, Jun 26, 2025 at 04:38:18PM -0700, Shakeel Butt wrote:
> diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
> index c8a48cf83878..02258b43abb3 100644
> --- a/kernel/cgroup/rstat.c
> +++ b/kernel/cgroup/rstat.c
> @@ -86,8 +86,12 @@ __bpf_kfunc void css_rstat_updated(struct cgroup_subsys_state *css, int cpu)
>  		return;
>  
>  	rstatc = css_rstat_cpu(css, cpu);
> -	/* If already on list return. */
> -	if (llist_on_list(&rstatc->lnode))
> +	/*
> +	 * If already on list return.
> +	 *
> +	 * TODO: add detailed comment on the potential race.
> +	 */
> +	if (data_race(llist_on_list(&rstatc->lnode)))
>  		return;

Yeah, also in the functdion comment, explain that if avoiding such races is
important enough to justify the overhead, the caller can put smp_mb() before
calling css_rstat_updated().

Thanks.

-- 
tejun

