Return-Path: <cgroups+bounces-14858-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGhdGQvmuWmGPQIAu9opvQ
	(envelope-from <cgroups+bounces-14858-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 00:38:51 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D171B2B467F
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 00:38:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 687D4303E76B
	for <lists+cgroups@lfdr.de>; Tue, 17 Mar 2026 23:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6638E3A2559;
	Tue, 17 Mar 2026 23:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L/MPvfbd"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2923A36404D
	for <cgroups@vger.kernel.org>; Tue, 17 Mar 2026 23:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773790720; cv=none; b=YSpmretWDUraLO+U2/7mRLowXZFss5aOX1WdYq6lF6NA6qMbx/y+7nGHZEBsZln0OZIRzUakAqgVfyQEO9VIw0DKulM09AMYk73NhvLXVPu20afyu9y7PzVce1n12pCru53tdSKi8sGMMtOMekygPRvJGt7YJEy9MCSqqIt8qtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773790720; c=relaxed/simple;
	bh=z9IH9OKJr5RtRPTjR6nTyEd3nuoW0Qtcmuy6u9T3pDI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pmw+3DgaZu8uPIqCMr456sd+fhJ3FgvKS5Q8ijpH3HWAqTcNjAo8kHtBWWC+NazhgfjQjd/Tjasb34xMJfaLuAQlv1d2/HmlFD8ucnW/LU1t8AMoZi7XmGom00g72FNUNp1b3t//9nueCsYggs69Zdm8EezTk5qlVux0ef/dYEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L/MPvfbd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C072DC4CEF7
	for <cgroups@vger.kernel.org>; Tue, 17 Mar 2026 23:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773790719;
	bh=z9IH9OKJr5RtRPTjR6nTyEd3nuoW0Qtcmuy6u9T3pDI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=L/MPvfbde1VDvQq87fln4fs0qU856NjFg9MDlH+jQ60+1MG0vtSltd41Shop7Xxjs
	 QXGM+hPuiVTIl9sZFzhhsdWgJyi2v+cGpcleLgkvcP4onrKJonu42TJKW2zygNxzGL
	 c4yo5ezgunWE+dBLRsU/dz9d1iA7ipNLsWGqhNhuk4co6B7dzQVKMMfVDXFM/Yve8B
	 QAthOTuu803mTm8+yAHiQbk/qxr+Ks4lt97mm74aE8DUHcej0gIrKFoycqXbDl1KaK
	 un4T3PFbbZW87kVzs8jn5jwyLNy2hECJboY5a2KJRo8nYYcMMrEbQgMY5a0yi6XbLI
	 LS4xPBY03Qtrg==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b97a0f18a3aso467862066b.1
        for <cgroups@vger.kernel.org>; Tue, 17 Mar 2026 16:38:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX29zEqfZVE2owLgucuVxOyURvAd94+ke78QcL01Mf3zsRQ+zMUfrRv90AElUKK3vYaj8+cpM2Q@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8o3GxhVtkYrDrhMZR5X93kUnWkzFAM3JzegVkIV05R7h2lRB4
	ajGzvuV9wHhSsuCwlbeINtH0XwNbaMpGbLv5BGqNxFm2jN1ulj5WIRDnxn2uGYsPIJqE4jyn/LS
	cMN+dAQNKmr1mDzFTrM+1dELBfN5kJv0=
X-Received: by 2002:a17:907:e101:b0:b93:5612:a57 with SMTP id
 a640c23a62f3a-b97f4ab77a4mr41074966b.52.1773790718620; Tue, 17 Mar 2026
 16:38:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317230720.990329-1-bingjiao@google.com> <20260317230720.990329-2-bingjiao@google.com>
In-Reply-To: <20260317230720.990329-2-bingjiao@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Tue, 17 Mar 2026 16:38:27 -0700
X-Gmail-Original-Message-ID: <CAO9r8zPwxGX1jtRuwRk1ZZGX7nwEkFemz=qU44jsK4DUS4TyfA@mail.gmail.com>
X-Gm-Features: AaiRm5188bu_ZClF-T2AbXUIUyVUuMZFFN-LnGzmxGVywCM-tnHOmmkoh_z1ZLo
Message-ID: <CAO9r8zPwxGX1jtRuwRk1ZZGX7nwEkFemz=qU44jsK4DUS4TyfA@mail.gmail.com>
Subject: Re: [PATCH 1/3] mm/memcontrol: fix reclaim_options leak in try_charge_memcg()
To: Bing Jiao <bingjiao@google.com>
Cc: linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, David Rientjes <rientjes@google.com>, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	Youngjun Park <youngjun.park@lge.com>, David Hildenbrand <david@kernel.org>, 
	Qi Zheng <zhengqi.arch@bytedance.com>, Lorenzo Stoakes <ljs@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Joshua Hahn <joshua.hahnjy@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14858-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[kvack.org,cmpxchg.org,kernel.org,linux.dev,linux-foundation.org,google.com,vger.kernel.org,tencent.com,huaweicloud.com,gmail.com,redhat.com,lge.com,bytedance.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yosry@kernel.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: D171B2B467F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 4:07=E2=80=AFPM Bing Jiao <bingjiao@google.com> wro=
te:
>
> In try_charge_memcg(), the 'reclaim_options' variable is initialized
> once at the start of the function. However, the function contains a
> retry loop. If reclaim_options were modified during an iteration
> (e.g., by encountering a memsw limit), the modified state would
> persist into subsequent retries.
>
> This could lead to incorrect reclaim behavior, such as anon pages
> cannot be reclaimed if memsw has quotas after retries.
>
> Fix by moving the initialization of 'reclaim_options' inside the
> retry loop, ensuring a clean state for every reclaim attempt.
>
> Fixes: 73b73bac90d9 ("mm: vmpressure: don't count proactive reclaim in vm=
pressure")

Before this commit, we had the same logic with 'may_swap' being
initialized to true and set to false in the retry loop. Before that,
it was 'flags' and 'MEM_CGROUP_RECLAIM_NOSWAP'.

I think initializing whether to swap or not outside the retry loop
started by commit 6539cc053869 ("mm: memcontrol: fold
mem_cgroup_do_charge()") 12 years ago, so I don't think it's a problem
in practice.

Practically speaking, we clear MEMCG_RECLAIM_MAY_SWAP if we hit the
combined memcg->memsw limit. I guess it's theoretically possible (but
probably unlikely) that we try to charge memcg->memsw, fail, reclaim
and/or OOM, then try again, succeed in charging memcg->memsw, but fail
charging memcg->memory. In this case, we should indeed attempt to
swap.

All that being said, this looks correct with the right 'Fixes' tag:

Reviewed-by: Yosry Ahmed <yosry@kernel.org>

> Signed-off-by: Bing Jiao <bingjiao@google.com>
> ---
>  mm/memcontrol.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index a47fb68dd65f..303ac622d22d 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2558,7 +2558,7 @@ static int try_charge_memcg(struct mem_cgroup *memc=
g, gfp_t gfp_mask,
>         struct page_counter *counter;
>         unsigned long nr_reclaimed;
>         bool passed_oom =3D false;
> -       unsigned int reclaim_options =3D MEMCG_RECLAIM_MAY_SWAP;
> +       unsigned int reclaim_options;
>         bool drained =3D false;
>         bool raised_max_event =3D false;
>         unsigned long pflags;
> @@ -2572,6 +2572,7 @@ static int try_charge_memcg(struct mem_cgroup *memc=
g, gfp_t gfp_mask,
>                 /* Avoid the refill and flush of the older stock */
>                 batch =3D nr_pages;
>
> +       reclaim_options =3D MEMCG_RECLAIM_MAY_SWAP;
>         if (!do_memsw_account() ||
>             page_counter_try_charge(&memcg->memsw, batch, &counter)) {
>                 if (page_counter_try_charge(&memcg->memory, batch, &count=
er))
> --
> 2.53.0.851.ga537e3e6e9-goog
>

