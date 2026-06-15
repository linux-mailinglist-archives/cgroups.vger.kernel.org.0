Return-Path: <cgroups+bounces-16979-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Z1JQLhZZMGrWRwUAu9opvQ
	(envelope-from <cgroups+bounces-16979-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 21:57:10 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E207689A10
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 21:57:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=lXq66cZo;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16979-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="cgroups+bounces-16979-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2ED7A306C9A6
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 19:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C40B3B530D;
	Mon, 15 Jun 2026 19:55:24 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD963AA4E1
	for <cgroups@vger.kernel.org>; Mon, 15 Jun 2026 19:55:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781553324; cv=none; b=tpZ5D070Y4h/jyW9I07rFCWy8yE5b28eKj53TM2sPm2fdVwEaw9VO7V/bZuvo8KJsmU+FfMN/E9Y3Fuvo4AunHT8IPE6J+85lNtXYHCqgc78oU/b315OPRGHk0cSF7SnMWu44zTZdyR2hilJK1s1qIT9rHBdo+koJGoFfHAk6D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781553324; c=relaxed/simple;
	bh=QqAYeF+pErrNOT7tRLf0EltAfjeQSXOO0tjYp7IOxa0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mIfW3NxDjv7qFkmyrPVo5Zs8OF/z9+RO21TBNI8cbmrIEWxdyZ7HCrsLJTZ4JUTdX7YI/l66dZpKPaRqNHLXkJTdyWD0HAXx/eRnJkgqz+WMx6/XlDlajd31Cbjlqq0CfQC+DzSvTRSpq7f59y0QMnf04hrFNaJe/k6kd/Ji8NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lXq66cZo; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA45E1F00AC4
	for <cgroups@vger.kernel.org>; Mon, 15 Jun 2026 19:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781553322;
	bh=DziV4AWXXV0/vXK0E8RzC2XjH+8nBwvIpECBlyE0DW0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=lXq66cZoW11dKjBugv0z9UTGVtZhT5oHri7tXO0eAgBteeKMl/XMp+E93EUb1VMEp
	 FXXKVIYAxA0Ilt/tIdwF3H72HSfKBf+2eA6jTy8D5EaX+XVwm2jnSE39PBSuECcr5K
	 zSopnecW9hTeDebjibU8deVrvk0EofIg9Fi1pvDo44p8UrWmgGGAvmX3DT/Tnbvu3C
	 lOnSTDJZuqx0kjBBmvEDdTgi1NdFh2IQ/cGNmXR/gnmDQjkHp7dk6nZhqWos3U8DsY
	 D3aGrOMdU4luV3n8Agp1oo4NIVPXmjZxJ0ED255DN7qD7VqGbbC/ocx6Fc5+T5XE+V
	 EPEb4MAX2hxyw==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-68bac6e24fdso5324235a12.1
        for <cgroups@vger.kernel.org>; Mon, 15 Jun 2026 12:55:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9I5uWqV+4B1JfKLxHd9r1C3ubn1EIJoauJAHS7eV0uZQnOdjRzw1U4LPzuNGv4UWtSv+BQKjj9@vger.kernel.org
X-Gm-Message-State: AOJu0YyQSOLGuxMxde5h4y/EJFDj5vR/NAW3AcUc71dMGaTn7Bw29kp9
	JY0Jd94DIOXhy+jCHKz8CqrXDps7RmaNP6MLVUVjIcxqyxXadf6Sjji57tfqfy3ZJaoM2JYd/jM
	snz+PlywhhgtAeso4yQhTOSHYTLXtcU4=
X-Received: by 2002:a17:907:1c82:b0:c03:ed93:6e0f with SMTP id
 a640c23a62f3a-c03ed936e8emr99025966b.35.1781553321486; Mon, 15 Jun 2026
 12:55:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aicJBVT4pBvmyooT@linux.dev> <aicZ-5GX9De3MAU7@linux.dev>
 <CAO9r8zNBJ-BsXyKFveA92jbwMu63uFVTY5CuT4fRHTBVcOjhPw@mail.gmail.com>
 <aictKA0XWMWbxFdN@linux.dev> <CAO9r8zPvCaCqvoUhPdAN5Oi_Sj0mK-t7DJhOOz3Xf1DT-Wrgcw@mail.gmail.com>
 <aieUQUBHI+E3uNPW@yjaykim-PowerEdge-T330> <airzE7jD9UtyR17J@google.com>
 <aisEWnb3pzmVC4dl@linux.dev> <aiu06fbV7rWqY0Bm@yjaykim-PowerEdge-T330>
 <aiw2p5ANjsQUCIHA@linux.dev> <ai5y923elCSZp41j@yjaykim-PowerEdge-T330>
In-Reply-To: <ai5y923elCSZp41j@yjaykim-PowerEdge-T330>
From: Yosry Ahmed <yosry@kernel.org>
Date: Mon, 15 Jun 2026 12:55:09 -0700
X-Gmail-Original-Message-ID: <CAO9r8zOVqbJEaBqTHw=r2bYw7Lm1tO0TU9QuG+eH1rfqcTAJJQ@mail.gmail.com>
X-Gm-Features: AVVi8CcAKcF3r9QvkNN-vPtWkfo808TWYLqIzLjO2syU-3fTyvshBGT_GznO24w
Message-ID: <CAO9r8zOVqbJEaBqTHw=r2bYw7Lm1tO0TU9QuG+eH1rfqcTAJJQ@mail.gmail.com>
Subject: Re: [swap tier discussion] Re: [PATCH v3 2/4] mm/zswap: Implement
 proactive writeback
To: YoungJun Park <youngjun.park@lge.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, Hao Jia <jiahao.kernel@gmail.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, mhocko@kernel.org, tj@kernel.org, mkoutny@suse.com, 
	roman.gushchin@linux.dev, Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org, 
	chengming.zhou@linux.dev, muchun.song@linux.dev, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	Hao Jia <jiahao1@lixiang.com>, chrisl@kernel.org, kasong@tencent.com, 
	baoquan.he@linux.dev, joshua.hahnjy@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16979-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:youngjun.park@lge.com,m:shakeel.butt@linux.dev,m:jiahao.kernel@gmail.com,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:tj@kernel.org,m:mkoutny@suse.com,m:roman.gushchin@linux.dev,m:nphamcs@gmail.com,m:akpm@linux-foundation.org,m:chengming.zhou@linux.dev,m:muchun.song@linux.dev,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:jiahao1@lixiang.com,m:chrisl@kernel.org,m:kasong@tencent.com,m:baoquan.he@linux.dev,m:joshua.hahnjy@gmail.com,m:jiahaokernel@gmail.com,m:joshuahahnjy@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[yosry@kernel.org,cgroups@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com,cmpxchg.org,kernel.org,suse.com,linux-foundation.org,vger.kernel.org,kvack.org,lixiang.com,tencent.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yosry@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,lge.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,writeback.it:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4E207689A10

> In that case, the internal logic could stay roughly the same rather
> than counting via a page counter. Something like:
>
> 1. Change the interface shell: tier.*.max =E2=80=94 allow only 0 ~ max.

What about a single interface as I suggested to remain consistent with
memory tiering?

> 2. Keep the internal logic as is: 0 disables the mask (child memcgs
>    off too), max enables it (child memcgs on too).

I think a child should be able to disable a swap tier enabled by the
parent, but not vice versa.

> 3. memory.zswap.max integrates naturally (it's memory."tier_name".max).

Not really. memory.zswap.max is in terms of memory usage (compressed
size), not swap usage (uncompressed size).

[..]
> Let me clarify a part I wrote confusingly. Handling
> memory.zswap.writeback via tiers is possible, but I don't think the
> interface itself would be replaced even if memory.swap.tiers is adopted.
>
> Selecting only zswap in memory.swap.tiers would not just disable
> writeback.it would also block regular swap entirely, which differs
> slightly from the current semantic. (... "Per the cgroup v2 docs: a
> zswap-only tier setting is subtly different from setting
> memory.swap.max to 0, since it still allows pages to be written to the
> zswap pool; this has no effect if zswap is disabled, and swapping is
> allowed unless memory.swap.max is set to 0.")

I don't understand. How is disabling zswap writeback not equivalent to
only enabling zswap as a tier?

Do you just mean the fact that disabling zswap writeback is a noop of
zswap is disabled? It's a different interface so I think a small
semantic difference is okay. In practice, I doubt that zswap is being
disabled at runtime.

>
> So the interface itself needs to be retained, and it could be extended
> toward selective writeback =E2=80=94 e.g., passing a desired tier into
> memory.zswap.writeback so writeback targets only that tier. Currently
> it only controls on/off. Other tiers probably don't need this. demotion
> based on the selected tier should be enough.
>
> Thanks,
> Youngjun Park
>

On Sun, Jun 14, 2026 at 2:23=E2=80=AFAM YoungJun Park <youngjun.park@lge.co=
m> wrote:
>
> ....
> > >Based on the memcg interface currently proposed in swap_tier
> > > (memory.swap.tiers, memory.swap.tiers.effective), I think it aligns w=
ell
> > > with the current direction. It provides a foundation for selectively
> > > targeting devices in tier order.
> >
> > Here instead of cpuset like interface, we may want more zswap like inte=
rface
> > where you can put limit on the usage i.e. memory.swap.tier*.max. We can=
 start
> > with allowing only two values i.e. 0 and max which effectively will be =
the
> > same as what you need.
> >
>
> Good idea, and it's certainly feasible. When I considered this a while
> ago, the reasons I didn't take this direction were:
>
> 1. There's no real-world usage for adjusting the swap tier amount (it's
>    either 0 or MAX). That said, your suggestion to initially allow only
>    0 and max is the killing point, and it's making me reconsider.
>
> 2. The implementation cost seems high. The current implementation
>    handles this at runtime via simple masking.
>
> 3. Relationship with swap.max:
>    - If we tie it to the current interface, wouldn't limiting the swap
>      amount within a selected tier already be possible? I wonder if
>      that alone is enough.
>    - If we add tier.max, it would need to be a subset of swap.max.
>      (Any other complexities here?)
>
> 4. vswap enable/disable: vswap doesn't seem to have an amount-control
>    aspect, so an on/off semantic would be clearer.
>    https://lore.kernel.org/linux-mm/ai5kOOmR1LPTWs1J@yjaykim-PowerEdge-T3=
30/T/#m8831ec057bf9387978d3bd698f51920600e09a04
>
> In that case, the internal logic could stay roughly the same rather
> than counting via a page counter. Something like:
>
> 1. Change the interface shell: tier.*.max =E2=80=94 allow only 0 ~ max.
> 2. Keep the internal logic as is: 0 disables the mask (child memcgs
>    off too), max enables it (child memcgs on too).
> 3. memory.zswap.max integrates naturally (it's memory."tier_name".max).
> 4. Extend later if use cases arise.
>
> On balance I still lean toward the current interface, but if a per-tier
> max is the better fit for memcg's direction and others feel the same,
> I'm happy to switch. I'd like to hear Shakeel's thoughts again, and I'm
> curious about others' opinions too.
>
> A few more perspectives on the points below.
>
> > I will respond to your other points later when I have time.
>
> > >
> > > To summarize the discussions so far, the following points align well.
> > >
> > > - Per-cgroup swap control, as I suggested.
> > > - Proactive zswap writeback (Hao's usecase)
> > > - Swap device target demotion(if it wants selective, then it is more =
better), as you mentioned:
> > >   https://lore.kernel.org/linux-mm/aicZ-5GX9De3MAU7@linux.dev/
> > > - Virtual Swap on/off in the future, as Nhat mentioned:
> > >   https://lore.kernel.org/linux-mm/20260528212955.1912856-1-nphamcs@g=
mail.com/
> > > - The memory.zswap.writeback alternative (no hierarchy model conflict=
)
> > > - zswap is first swap tier.
> > > - Promotion. (Also better for selectve usage)
> > > - tier based swap policy (e.g round-robin...)
> > >
> > > To accelerate this work, I believe we should reach a consensus and
> > > merge the currently proposed swap_tier interface :)
> > >
> > > If the above approach is difficult, I would like to suggest an
> > > alternative for progress with the memcg interfaces removed:
> > >
> > > 1) We could make zswap the first tier and create
> > > a use case where memory.zswap.writeback internally is handled by tier=
 logic.
> > >
> > > 2) Or simply merge the swap_tier infrastructure itself first.
> > >
> > > This would allow the swap_tier infrastructure to be merged and discus=
sed
> > > more easily.
> > >
> > > If it takes longer to adopt swap_tier anyway, by doing so we progress=
 next step
> > > as a experimental feature.
> > >
> > > - Apply per-cgroup swap as an experimental (debugfs) feature.
> > > - Apply Hao's use case experimentally or as it is as Yosry suggested.
> > > (future migration to swap tier)
> > >
> > > How do you think?
> > >
> > > (FYI: My emails to kernel.org are failing due to internal server issu=
es.)
> > >
> > > Thank you
> > > Youngjun Park
>
> Let me clarify a part I wrote confusingly. Handling
> memory.zswap.writeback via tiers is possible, but I don't think the
> interface itself would be replaced even if memory.swap.tiers is adopted.
>
> Selecting only zswap in memory.swap.tiers would not just disable
> writeback.it would also block regular swap entirely, which differs
> slightly from the current semantic. (... "Per the cgroup v2 docs: a
> zswap-only tier setting is subtly different from setting
> memory.swap.max to 0, since it still allows pages to be written to the
> zswap pool; this has no effect if zswap is disabled, and swapping is
> allowed unless memory.swap.max is set to 0.")
>
> So the interface itself needs to be retained, and it could be extended
> toward selective writeback =E2=80=94 e.g., passing a desired tier into
> memory.zswap.writeback so writeback targets only that tier. Currently
> it only controls on/off. Other tiers probably don't need this. demotion
> based on the selected tier should be enough.
>
> Thanks,
> Youngjun Park
>

