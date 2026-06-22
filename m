Return-Path: <cgroups+bounces-17156-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BXqCAZy2OWpEwgcAu9opvQ
	(envelope-from <cgroups+bounces-17156-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 00:26:36 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB166B29B6
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 00:26:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=H69N20hX;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17156-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17156-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F0577301ABBC
	for <lists+cgroups@lfdr.de>; Mon, 22 Jun 2026 22:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFBDB37882E;
	Mon, 22 Jun 2026 22:26:31 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD4535E93B
	for <cgroups@vger.kernel.org>; Mon, 22 Jun 2026 22:26:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782167191; cv=none; b=NGnPsNDOdciAOH5Y1dLOyIkIisMdcWmDMApkx79NF2VKgL5vCq3Sgv86/w2bRtscplZrLgediOrwsvw5k91+P0ZflGBN10SJR6uYMdrRYJkYtQLRfcWfyzX3bwUHs6uxXKoEr+es7tSSIlmsXa4Dbkb5R4xge4rtzVvv5afczFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782167191; c=relaxed/simple;
	bh=6yDiehfkMGjQL3bmFpDC8m2hyRZivqMknrzcXo75kvE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tIEEFeQEd2zh0psUUXZjKTSdYGyST/6FLCiQCl8r9B1NQDTaHKv/yTU31IOpTtSeNlsFbuwmK/d+pWMNmbviaS4EGz2X6OmH6zyXA4t/7OgEPYLwo/HUfJ6juGOzFSoRNBndhZ7Bnip85wsRpJxsN/t+1UXeK+YMCMZ+oi6Hbbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H69N20hX; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 084FF1F01561
	for <cgroups@vger.kernel.org>; Mon, 22 Jun 2026 22:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782167190;
	bh=LGHFR3otSoYMVHIMKTx92Qc2dyqLTWvcbb+UcCOAzWk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=H69N20hXCx2EFg2GRY1BYm2M3GBmBAqcjbIX2TUFlx3VlSneU8Dy4Q8JA/OQj4tEn
	 /LW0VMDEn/LlfsGBKL8Bj/qN10Jt4Xpdbmgkh0s1JA9B2mcTES4r+WcmN1VOI/tQrk
	 HYv23c3F3vSaMUWgPGT46FgU6T/N8yiV7GelXqRk4yn68vUbnVHwloCMJyp+B631bq
	 yqYQWKNnhUg0pdr4uVKGGkNiKVUM5fx09BM3FlhrRQch64Pj2wYKvdIeM5CBr+XjOr
	 WMwie2OyfWQbNazRk6UhG7pgLf9aZ5+s2LmzrRipsEihZqclUPgE+vVTfCU8J37mYP
	 csJUXTDuChaMw==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6977dc206afso5003352a12.1
        for <cgroups@vger.kernel.org>; Mon, 22 Jun 2026 15:26:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ++rHqh4Ce9mAv38HGLOYssspMWmzp5HyIfNPa5X/FPI3Pj/h+sMnk9Pnby3mMS0Ry4XA/85CMD@vger.kernel.org
X-Gm-Message-State: AOJu0YwB7W+6Gul1dRn/goKo58o7GnceEr7wurMkIpsN1896A3M+7Kwe
	Et1CTvRePym/dtZLt9nZkA4K2UtBMg2w6/nUysmHTkqqQ7ztxtNtPlDPVt+QMerxVdW32Yg5YGt
	GBjgpDgb7DMO3g5iBCf2tz68SK2PXte8=
X-Received: by 2002:a17:907:3d4d:b0:bfe:ed06:5a20 with SMTP id
 a640c23a62f3a-c098ed16f00mr822557666b.53.1782167188897; Mon, 22 Jun 2026
 15:26:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAO9r8zNjyW1rh26vv2vavCM_2-r70EuynU+-7XdEmrBdLL=TkQ@mail.gmail.com>
 <20260622221037.255359-1-joshua.hahnjy@gmail.com>
In-Reply-To: <20260622221037.255359-1-joshua.hahnjy@gmail.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Mon, 22 Jun 2026 15:26:17 -0700
X-Gmail-Original-Message-ID: <CAO9r8zP6zDshSGU4chaHiPocahQZpiK5Z-eP9VKH+2_xjNM+4g@mail.gmail.com>
X-Gm-Features: AVVi8CcPvB6x8GnlUC9ZSP0DpmmufpwngYWRm_3G-i9cXpRnV9FIWkWhZqkPsUg
Message-ID: <CAO9r8zP6zDshSGU4chaHiPocahQZpiK5Z-eP9VKH+2_xjNM+4g@mail.gmail.com>
Subject: Re: [PATCH v9 3/6] mm: memcontrol: add interface for swap tier selection
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Youngjun Park <her0gyugyu@gmail.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	akpm@linux-foundation.org, chrisl@kernel.org, youngjun.park@lge.com, 
	linux-mm@kvack.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kasong@tencent.com, hannes@cmpxchg.org, mhocko@kernel.org, 
	roman.gushchin@linux.dev, muchun.song@linux.dev, shikemeng@huaweicloud.com, 
	nphamcs@gmail.com, baoquan.he@linux.dev, baohua@kernel.org, gunho.lee@lge.com, 
	taejoon.song@lge.com, hyungjun.cho@lge.com, mkoutny@suse.com, 
	baver.bae@lge.com, matia.kim@lge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17156-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:joshua.hahnjy@gmail.com,m:her0gyugyu@gmail.com,m:shakeel.butt@linux.dev,m:akpm@linux-foundation.org,m:chrisl@kernel.org,m:youngjun.park@lge.com,m:linux-mm@kvack.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:kasong@tencent.com,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:muchun.song@linux.dev,m:shikemeng@huaweicloud.com,m:nphamcs@gmail.com,m:baoquan.he@linux.dev,m:baohua@kernel.org,m:gunho.lee@lge.com,m:taejoon.song@lge.com,m:hyungjun.cho@lge.com,m:mkoutny@suse.com,m:baver.bae@lge.com,m:matia.kim@lge.com,m:joshuahahnjy@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[yosry@kernel.org,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[24];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,linux.dev,linux-foundation.org,kernel.org,lge.com,kvack.org,vger.kernel.org,tencent.com,cmpxchg.org,huaweicloud.com,suse.com];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lge.com:email,mail.gmail.com:mid,vger.kernel.org:from_smtp,linux.dev:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4CB166B29B6

On Mon, Jun 22, 2026 at 3:10=E2=80=AFPM Joshua Hahn <joshua.hahnjy@gmail.co=
m> wrote:
>
> On Mon, 22 Jun 2026 14:21:30 -0700 Yosry Ahmed <yosry@kernel.org> wrote:
>
> > On Sat, Jun 20, 2026 at 11:17=E2=80=AFAM Youngjun Park <her0gyugyu@gmai=
l.com> wrote:
> > >
> > > Introduce memory.swap.tiers.max, a flat-keyed file listing each
> > > tier defined in /sys/kernel/mm/swap/tiers with its state, "max"
> > > (allowed, the default) or "0" (disabled).  A tier is one bit in the
> > > cgroup's tier mask, so writing "<tier> max" or "<tier> 0" sets or
> > > clears that bit.
> > >
> > > Since the current use case lacks amount control, it only supports
> > > "max" (on) and "0" (off). Therefore, it does not track per-tier swap
> > > usage, relying instead on a fast runtime bitmask check.
> > >
> > > We maintain both `mask` and `effective_mask`. The `effective_mask` is
> > > strictly bounded by the parent (e.g., if a parent is "0", the child's
> > > effective state is "0" even if its `mask` is "max"). Maintaining this
> > > separately avoids costly cgroup tree traversals to check ancestors at
> > > runtime.
> > >
> > > Suggested-by: Shakeel Butt <shakeel.butt@linux.dev>
> > > Suggested-by: Yosry Ahmed <yosry@kernel.org>
> > > Signed-off-by: Youngjun Park <youngjun.park@lge.com>
> > > ---
> > >  Documentation/admin-guide/cgroup-v2.rst |  20 +++++
> > >  Documentation/mm/swap-tier.rst          |   9 +++
> > >  include/linux/memcontrol.h              |   5 ++
> > >  mm/memcontrol.c                         |  67 ++++++++++++++++
> > >  mm/swap_state.c                         |   5 +-
> > >  mm/swap_tier.c                          | 102 ++++++++++++++++++++++=
+-
> > >  mm/swap_tier.h                          |  57 +++++++++++--
> > >  7 files changed, 255 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/=
admin-guide/cgroup-v2.rst
> > > index 6efd0095ed99..4843ffcfd110 100644
> > > --- a/Documentation/admin-guide/cgroup-v2.rst
> > > +++ b/Documentation/admin-guide/cgroup-v2.rst
> > > @@ -1850,6 +1850,26 @@ The following nested keys are defined.
> > >         Swap usage hard limit.  If a cgroup's swap usage reaches this
> > >         limit, anonymous memory of the cgroup will not be swapped out=
.
> > >
> > > +  memory.swap.tiers.max
> > > +       A read-write flat-keyed file which exists on non-root
> > > +       cgroups.  The default is "max" for every tier.
>
> Hi Yosry,
>
> Sorry, I feel like I'm joining the party late. Apologies if I'm missing
> some context or repeating a discussion that's already been had.
> Please let me know if that is the case.
>
> One quick tangent:
> I was chatting with Nhat last week about swap tiers and its relation to
> memory tiering. Nhat brought up a good point, which is that while both
> swap tiers and memory tiers provide a clear hierarchy of performance,
> only memory tiering allows for movement between the tiers.
> AFAICT, swap tiering does not allow for direct migration from a higher
> tier swap backend to a lower tier swap backend if the higher tier
> backend runs out of memory.
>
> In that sense, I'm not entirely sure if we need to enforce similar
> semantics across swap tiering and memory tiering; it seems like there
> are some fundamental differences anyways to how we treat these tiers.
>
> > I wonder what should the default behavior be if memory.swap.max is set
> > to a value other than "max". Should the limits in
> > memory.swap.tiers.max auto-scale or remain as "max"? We probably want
> > to keep the behavior consistent with memory tiering.
> >
> > Shakeel/Joshua, WDYT?
>
> I think that the motivation behind these tiers is different for swap
> and memory. Tiered memory limits is motivated by preventing one
> workload from conusming all of a valuable resource, while swap tiers
> seems more to do with excluding certain workloads from using performant
> tiers and ensuring other workloads stay on those performant tiers.
>
> IOW memory tiers exist for fairness, but it seems like swap tiers exist
> for workload performance tiering. But maybe there's a usecase out there
> that would want fairness to apply in the swap tiers as well that I am
> not seeing.

I am not sure what use cases exist, but I think it's possible we end
up wanting to enforce fairness for swap tiers as well. Maybe not as
aggressively as memory (e.g. to avoid wearing out SSDs), but maybe at
least proactively through userspace?

At the end of the day, faster swap tiers are also valuable resources
that we probably don't want a few workloads to hog. I also think the
interfaces being consistent makes everyone's lives easier, even if
it's a bit of an overkill for swap tiers.

>
> If that is the case, I think auto-scaling makes sense but can be a bit
> tricky, since there is no universal tiered ratio; each workload will
> have different tiers it can swap to, so they will all have to calculate
> their own ratios. Tiered memory limits escapes this difficulty since we
> assume all memory can be placed on all tiers, so we have a system-wide
> ratio : -)

Hmm I don't follow. It's also possible (maybe not initially) that a
memcg cannot use specific memory tiers, right? I am not sure what the
difference is.

>
> Let me know what you think! Have a great day :D
> Joshua

