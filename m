Return-Path: <cgroups+bounces-14476-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJEKEBPgoWlcwgQAu9opvQ
	(envelope-from <cgroups+bounces-14476-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 27 Feb 2026 19:18:59 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E871BBE80
	for <lists+cgroups@lfdr.de>; Fri, 27 Feb 2026 19:18:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 245A33070661
	for <lists+cgroups@lfdr.de>; Fri, 27 Feb 2026 18:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CDAC376BE5;
	Fri, 27 Feb 2026 18:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KFLIycYl"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF3837472E
	for <cgroups@vger.kernel.org>; Fri, 27 Feb 2026 18:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772216314; cv=none; b=Domg3i9egdv2TYOycHZOSJg3pWop3CfSimcJ1TWtRPxvaKwZJ+zWJ+5FU0AuK4gQIOTqgrHNUabZQd4rjd6EizR5njeIv7S0VPrWXuTkCuvwT5q3wmabUEWMRxccDHqh624EFYxiJGMqnCDZi7qHMy7Ip/wAB+yhHRuhJIjjhro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772216314; c=relaxed/simple;
	bh=5zMV4Pw0vsBGtqEjrHtCXDgQOjiFZK53QZufpFdphx8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ghmqOXQT2feYqmY6bO3Tsujv4Srg0oYGboGT0BWPwVVx9Mx3wvY8wkG8llSaSModwWsjbe9+KaWwO/8V/V0hZ6b5ugIXEqA2W7LanMEdghi/AQyPiQ9WIydDjJrXZC7PqKAKB+Kn44BktuLCo3frkzc3pJ8xVfCAZ7MS3nRuRTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KFLIycYl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFB75C2BCB3
	for <cgroups@vger.kernel.org>; Fri, 27 Feb 2026 18:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772216313;
	bh=5zMV4Pw0vsBGtqEjrHtCXDgQOjiFZK53QZufpFdphx8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KFLIycYleDqFqiPTvzcuWrEnQKh2Pb50OV9U0Zi5AXqeSMrmz6u2vtVmM/SzZQGvx
	 Tharxb/y5DzlXbkOUihqC6pTa9UnX5G1Zwzynh785MP0voCVZJnOQqNvpoqxurdQw5
	 JgKXSHrlSuKE37knqmDuZlQnZwmJvCAbQd6i2ACIFt0FRvTHP9K0S4hdWL7+ZJKEvq
	 kYHqa963FYR1h5Rb3E5NSf9zAKKbiAe5i8dRh3+NkT3k+Y1EBFRirXLClB+WOJZ9Vf
	 idkCZnBb+c87k1LoZVVVntapTvP4wJqZctSNwno24WoR5KTWMw/pMfRpuWgoHGkw4l
	 LnO0OkRJR4J1g==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b90bc00578cso357665166b.0
        for <cgroups@vger.kernel.org>; Fri, 27 Feb 2026 10:18:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXvAmCODc6xpbTucvN5KlXFuU9QE7AXedNqdXAwb/2SWnT/LLy2i6VsiqmsXdM20jdA6IJVtDev@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4XY/owS8/PdnOo74+28pvMm4LZhSh+64tAnw7dPyTDJ8TQJuA
	YDkXFZz+SDiC0ypCEKMvuOzykTCMjqkNQJqmW3SmwzbYU0TCOlMt9c6yWklQBbrO0sLB0z42H1W
	ktpOT3rg5TIFKaF7wotsA5XORFsKB7L8=
X-Received: by 2002:a17:907:847:b0:b70:b700:df98 with SMTP id
 a640c23a62f3a-b937636ceaemr277939266b.5.1772216312497; Fri, 27 Feb 2026
 10:18:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1772005110.git.zhengqi.arch@bytedance.com>
 <ef13e5974343b37ae2a0e28aff03ea2d033cb888.1772005110.git.zhengqi.arch@bytedance.com>
 <CAO9r8zOhZgrym6oSrtg7b+HmNHEfWuAzZ0i8eYhm5-OEnfFLdw@mail.gmail.com>
 <aZ-R87JfacQ2gGq1@linux.dev> <CAO9r8zPmgytmGHAbueFKXcZWY5SJaEwD3Pqk99ws4XeO2_hnKw@mail.gmail.com>
 <97e296ed-ef73-44b7-ab68-3d79749caa47@linux.dev> <e15c2304-4874-4adc-bbe5-58ba78b3b84f@linux.dev>
In-Reply-To: <e15c2304-4874-4adc-bbe5-58ba78b3b84f@linux.dev>
From: Yosry Ahmed <yosry@kernel.org>
Date: Fri, 27 Feb 2026 10:18:21 -0800
X-Gmail-Original-Message-ID: <CAO9r8zP-peywvtq-3HF2-PjCx9X_ABHEQF2vMO3OFoGfVOHTAg@mail.gmail.com>
X-Gm-Features: AaiRm50TLXHVX5j7xS88WvrO4MStBAuGwnOEEW7p2oMKLrYDnofUaDeqDh7Zhl0
Message-ID: <CAO9r8zP-peywvtq-3HF2-PjCx9X_ABHEQF2vMO3OFoGfVOHTAg@mail.gmail.com>
Subject: Re: [PATCH v5 29/32] mm: memcontrol: prepare for reparenting
 non-hierarchical stats
To: Qi Zheng <qi.zheng@linux.dev>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, hannes@cmpxchg.org, hughd@google.com, 
	mhocko@suse.com, roman.gushchin@linux.dev, muchun.song@linux.dev, 
	david@kernel.org, lorenzo.stoakes@oracle.com, ziy@nvidia.com, 
	harry.yoo@oracle.com, yosry.ahmed@linux.dev, imran.f.khan@oracle.com, 
	kamalesh.babulal@oracle.com, axelrasmussen@google.com, yuanchu@google.com, 
	weixugc@google.com, chenridong@huaweicloud.com, mkoutny@suse.com, 
	akpm@linux-foundation.org, hamzamahfooz@linux.microsoft.com, 
	apais@linux.microsoft.com, lance.yang@linux.dev, bhe@redhat.com, 
	usamaarif642@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14476-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[linux.dev,cmpxchg.org,google.com,suse.com,kernel.org,oracle.com,nvidia.com,huaweicloud.com,linux-foundation.org,linux.microsoft.com,redhat.com,gmail.com,kvack.org,vger.kernel.org,bytedance.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yosry@kernel.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D6E871BBE80
X-Rspamd-Action: no action

[..]
> >> @@ -506,12 +517,10 @@ void reparent_memcg_lruvec_state_local(struct
> >> mem_cgroup *memcg,
> >>          for_each_node(nid) {
> >>                  struct lruvec *child_lruvec = mem_cgroup_lruvec(memcg,
> >> NODE_DATA(nid));
> >>                  struct lruvec *parent_lruvec =
> >> mem_cgroup_lruvec(parent, NODE_DATA(nid));
> >> -               struct mem_cgroup_per_node *parent_pn;
> >>                  unsigned long value =
> >> lruvec_page_state_local(child_lruvec, idx);
> >>
> >> -               parent_pn = container_of(parent_lruvec, struct
> >> mem_cgroup_per_node, lruvec);
> >> -
> >> -               atomic_long_add(value,
> >> &(parent_pn->lruvec_stats->state_local[i]));
> >> +               mod_memcg_lruvec_state(child_lruvec, idx, -value);
> >
> > We can't use mod_memcg_lruvec_state() here, because child memcg has
> > already been set CSS_DYING. So in mod_memcg_lruvec_state(), we will
> > get parent memcg.
> >
> > It seems we need to reimplement a function or add a parameter to
> > mod_memcg_lruvec_state() to solve the problem. What do you think?
>
> Since child memcg is about to disappear, perhaps we can just add value
> to parent memcg without handling the child memcg. Make sense?

Ugh yes, I missed that, thanks.

I don't think we can just leave the child's memcg wrong. Aside from
the fact that I would be nervous if access to those stats is still
possible after it's offlined (e.g. can userspace already have the
stats file open, or maybe some in-kernel code uses it), there's a
bigger issue.

When the child cgroup is released, css_release_work_fn() will flush
its stats and then it will be double counted at the parent.

Maybe refactor the part sof mod_memcg_lruvec_state() and
mod_memcg_state () without get_non_dying_memcg_{start/end}() into
helpers, and call that directly from the reparenting functions? Adding
a boolean argument to mod_memcg_lruvec_state() and mod_memcg_state()
will add a lot of churn, and naked boolean arguments are not ideal.

