Return-Path: <cgroups+bounces-17076-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OErMIaPmM2psHwYAu9opvQ
	(envelope-from <cgroups+bounces-17076-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 18 Jun 2026 14:37:55 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D2CC86A01DD
	for <lists+cgroups@lfdr.de>; Thu, 18 Jun 2026 14:37:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=LfeNhmFG;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17076-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17076-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B2BFE304E424
	for <lists+cgroups@lfdr.de>; Thu, 18 Jun 2026 12:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336003F4DC3;
	Thu, 18 Jun 2026 12:37:07 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528183F44EB
	for <cgroups@vger.kernel.org>; Thu, 18 Jun 2026 12:37:05 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781786227; cv=pass; b=i17Le0fuO7vBWXefsDIqiBTGYB13Sk0NSAcUc0pK996MwyS9GE12dL9976QxE1MsbJVYRXpE/hwKc8k6VuxpnBA8PkDQeP5wweV/gNRtjJ+o1KHBGKYnhMqj8XBxUc+VPzsi4kbqgxgvQenykAxAEW3RKCYm6yLA+R88KjDeKBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781786227; c=relaxed/simple;
	bh=wMeHQN377E9cd+yK3WkmUXDzTwImDdGDm/oCakzWLgc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uoeItMbUNvt/ze6pv4ksSiqh66ntpwCLvcYr9QM8tcC32nsdllkfe57MW5yj+hBC5ynuhrM2V+K9gawsEEdpZhN5EhJymGWuI7h2pBiI3BqlSm3god4AM0otj6sARMHrPABUsI1eSEEEjOmE6mTFVYfkz10oj+Mw2PyKKOgT/Gs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LfeNhmFG; arc=pass smtp.client-ip=209.85.221.46
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-45f3cf907ceso468171f8f.2
        for <cgroups@vger.kernel.org>; Thu, 18 Jun 2026 05:37:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781786224; cv=none;
        d=google.com; s=arc-20240605;
        b=bJI8ndAGd8MEV+c/o7bwLw3nryzj9iTKurz7GJ0F80SUIT9YgK4DTyqEc98O0RnC7W
         3ObaExn8yJ0i/E84uv2csj/zCGBUUIpdq3RxZDs0wLV9GIY+EhxY7M5kZVSPLlV5CWEL
         abdO7/a+K5EwVhau90l4Mx5x18XiG828OPcnwNF2cFxcwF+bYvhzQR46OghRKgtNh/J7
         l+Mr08SSX1Sjg8Phd5ihO+JcfzzkMlPFlcueM5vY/1xJXKJM9+dIkb43fcAaOS9QJIaC
         QCoEsCdC1vw/oyfw23NPY2G3+vJEc4HrbQGTKFcOphMH6j9Hg4wk3p51dfgMBox7RCbo
         kL3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XkSHVItH7tnbR0yMDRD7muLBdT/xCNKdF8GS+tUHV+Y=;
        fh=E4u0TdaI/cUMm4wlb3yRMDEfCbUmEmn68KqyH5E7kMo=;
        b=T5VHxWnb70zkdfBk6AyInt4j5jM1EA5Vzl3dCirnjz2RH7CWgfuf3aiZP5YkUTzAaw
         H3K6NsU7o0j7gQGb8Yq7cmEpH3R61yFZPH41EMG4DjoLW2IJLYPwacx/8TjQl3i99OKN
         QxGVICdr2NPohDXlsHtqwtgtOm+0e/UalQgbDuZRSN+nSqrL8Kns3hCJO33ZdXPYLGvn
         BAu1lJDzUs3as5llae30JUvCnBlP8HJ05Ta3ewzSmBt4bBG+//h5dk9zhkH49viO9xaz
         pbS8Tbvl9GPHa6PgaZhqxBy2VfpRUsvX+LSxpEUU1LLj4lRaAot/XIX5YGOJWZJ99MSP
         AD3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781786224; x=1782391024; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XkSHVItH7tnbR0yMDRD7muLBdT/xCNKdF8GS+tUHV+Y=;
        b=LfeNhmFGdcpd8bcDsqXzhg3moXaKf2tKyVsGDjttBktmRmr2C/fzNskrQj9rUWOLbM
         beySELE3TLMpV4ZBN2cW/DM46rSO+zACRH3gNnUWpHoS0KrmGhUCY6IO8m5q8x5dOqG9
         8XF2OtEEdkMElbqcrUzK3BDUiMIxqjmAMTyiI2ljJ7WUGTIhraxNfLeymhpZLcgxJM2G
         CeD8Cq1GxCgFpfg9UV8Df+5of+dPYtuO245HN7OQ6gWCALwRs+UhaYkaivSVA7gl6upt
         L4o8i0RqpFnmnhT8Ok06mgW3hctTho6RCduSWbiWnWGsI+3cnI7WEBE+wmtD2Qmv+ZH8
         muSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781786224; x=1782391024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XkSHVItH7tnbR0yMDRD7muLBdT/xCNKdF8GS+tUHV+Y=;
        b=g+VeCaDUrMEVyK8odN+0QmW72iV+M6K9X/EbZQ3gH3dT4v1wWVg7HjSJFh9IGTswV3
         qpJVFWAP4C0BEDnwu6QN67jn4phrwGi6rRXxNLMogb00wKDQAqq0L+EwxiEN41nD6MMd
         Ve+9AOgD+QZi36cbLwvTgXdbdNpL3o3C6/SISwbyETdjpxYt8RcjHfYumAAIzqnUgZwD
         oZm0HaFNbEECKV9tBmz5oMKav8RqA6XFbtsSPsATpUZeSYJK/rbTWikZy8VvJPAjrkwX
         tyrXSe0/KXEtrliwQnGbG9Zdg/7yknk/ynT5BSx3WfU6J1S4ym9rDu0qnB1+EklowrN3
         AqYg==
X-Forwarded-Encrypted: i=1; AFNElJ9ocPoL6PnYqCeTvgX8q1B8RzEtOxorTwCDkkscH9YBaLqa9wUuiw7P7SE9uUaos3ingSHhx3cH@vger.kernel.org
X-Gm-Message-State: AOJu0YyUrcEZaW9Qoh79lTWhejJJmpojROIqgN5oL+1Fo4/Ssy47/z42
	Vgoimyg2TQezag8VenpqTsNwmWXHI7Dtcze1gjW8zVv2zz7XAp+nTZ62AEAo6fjShpVEc76czm0
	+lY81t5XsFMzvqfBm5MMgwJDIq8OxklI=
X-Gm-Gg: AfdE7clqx6SchzxUIeTksJzPj739OhnmChuL5rbxYUZOj2AO1UR0v4FG/+v58darpha
	TgzKXEAi1PAldFG4d2faDWHvOgRrZpD2m/MW1UWLB02HQPdZ+Nscug8VtwBk7nghf3sa8+un80t
	bM9hWaomcXPd9T0B3o49IcHSlAhBsA381qL1qPTdJL8jX12WOeyIL7TrFU9+jXwr+5gGf2j3UUZ
	F1jsqnot/VsQmS5FPRbS+y6MyJyPPTS4p858LtuYwCaUloySBjTNuwM7TM2ug8IfVA2b3F4KK9/
	jphl8wVdEiNMhSq3T8DI7j1Hxqc=
X-Received: by 2002:a05:600c:1550:b0:48f:e26a:1744 with SMTP id
 5b1f17b1804b1-492381eba37mr57093805e9.9.1781786223384; Thu, 18 Jun 2026
 05:37:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260617053447.2831896-1-youngjun.park@lge.com>
 <CAKEwX=NfSy0XiD_UMsDOHGCwpE7sYmBmhV4Y9vk_cbnnr6J6PQ@mail.gmail.com> <ajNOSesjwTyZc8EX@yjaykim-PowerEdge-T330>
In-Reply-To: <ajNOSesjwTyZc8EX@yjaykim-PowerEdge-T330>
From: Nhat Pham <nphamcs@gmail.com>
Date: Thu, 18 Jun 2026 08:36:52 -0400
X-Gm-Features: AVVi8CfzuQSfKHh9oPwDJSuQShydMBfDCnnVhDZx9e0tsjDeRE3g_0kv6j5DVww
Message-ID: <CAKEwX=NDM9ohO36wSE-vVpVkpM=UBhhgBqDzSZdo6gW2BgWDVA@mail.gmail.com>
Subject: Re: [PATCH v8 0/4] mm/swap, memcg: Introduce swap tiers for cgroup
 based swap control
To: YoungJun Park <youngjun.park@lge.com>
Cc: akpm@linux-foundation.org, chrisl@kernel.org, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, kasong@tencent.com, 
	hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	shakeel.butt@linux.dev, muchun.song@linux.dev, shikemeng@huaweicloud.com, 
	baoquan.he@linux.dev, baohua@kernel.org, yosry@kernel.org, gunho.lee@lge.com, 
	taejoon.song@lge.com, hyungjun.cho@lge.com, mkoutny@suse.com, 
	baver.bae@lge.com, matia.kim@lge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:youngjun.park@lge.com,m:akpm@linux-foundation.org,m:chrisl@kernel.org,m:linux-mm@kvack.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:kasong@tencent.com,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:shikemeng@huaweicloud.com,m:baoquan.he@linux.dev,m:baohua@kernel.org,m:yosry@kernel.org,m:gunho.lee@lge.com,m:taejoon.song@lge.com,m:hyungjun.cho@lge.com,m:mkoutny@suse.com,m:baver.bae@lge.com,m:matia.kim@lge.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17076-lists,cgroups=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,lge.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D2CC86A01DD

On Wed, Jun 17, 2026 at 9:47=E2=80=AFPM YoungJun Park <youngjun.park@lge.co=
m> wrote:
>
> On Wed, Jun 17, 2026 at 01:50:49PM -0400, Nhat Pham wrote:
>
> > On Wed, Jun 17, 2026 at 1:34=E2=80=AFAM Youngjun Park <youngjun.park@lg=
e.com> wrote:
> > >
> > > This is the v8 series of the swap tier patchset.
> > >
> > > Great thanks to Shakeel Butt and Yosry for the reviews and discussion=
s [1].
> > > The main change in this version is the interface change to use
> > > memory.swap.tiers.max with '0' (disable) and 'max' (enable) values.
> > > This mechanism was suggested by Shakeel and Yosry
> >
> > I like this interface too :)
>
> > I think Yosry wants zswap as a tier, right?
> >
> > Just that without vswap, maybe don't allow it to be an tier of itself?
>
> With the current architecture, users cannot dynamically specify zswap as
> a tier, and zswap is a separate layer, so it is not tiered by itself.
>
> Once your vswap work lands, I think we can make the zswap
> become the default, top-level tier.
>
> After that, we can also look into cleaning up the zswap.writeback
> interface together.

SGTM if Yosry is happy with it :) FWIW, zswap is a conceptual tier,
whether we want it to express with your interface or not. This is just
interface clean-up work.

>
> > #2: Inter-tier promotion and demotion:
> >   Promotion and demotion apply between tiers, not within a single
> >   tier. The current interface defines only tier assignment; it does
> >   not yet define when or how pages move between tiers. Two triggering
> >   models are possible:
> >
> > >   (a) User-triggered: userspace explicitly initiates migration betwee=
n
> > >       tiers (e.g. via a new interface or existing move_pages semantic=
s).
> > >   (b) Kernel-triggered: the kernel moves pages between tiers at
> > >       appropriate points such as reclaim or refault.
> >
> > We'll likely need some kernel-triggered mechanism, or we'd have LRU inv=
ersion :)
> >
> > Cold pages will fill up fast tiers first, and more recent/warm pages
> > will land on slow tiers...
>
> Yeah, good point!
>
> > We'll also need to enforce isolation/fairness to make sure no wordload
> > hoard the fast tiers too (but that probably requires demotion
> > support).
>
> Right, that makes sense.
>
> BTW, One thing I am curious about, though, is whether there are strong
> real-world use cases that require demotion/promotion.
> Theoretically, this looks useful but it would be helpful to better unders=
tand
> the requirements from such deployments.

I think so, yeah. The LRU inversion problem above is one :) Hard to
make proper tiering without demotion.

Say I have a workload that have a SLO - for example a PSI target - but
don't particularly care about exact memory placement. To optimize
resource, we want to place the warmer stuff in fast tier, and the
coldest stuff in slow tier, etc. Having the ability to do demotion
derisk the initial placement - we can place things in the fast tier
initially (and rather aggressively), then as pages age and prove their
coldness, we can move them to slower and slower tier, etc.

Otherwise, what we end up with is really a placement preference
interface more than true tiering. Which is still useful especially
when co-tenant workloads have strict latency requirements, but perhaps
we don't need a full hierarchy-style interface for it? :)

The other use case is for fairness enforcement. We can (and probably
should) start with strict limits, but setting memory.swap.tier.max for
each cgroup is a bit of a drag, and it might leave stranded capacity
in cgroups that are allocated but not utilized their fast swap tier
capacity. If demotion is possible, we can let workloads use more than
what is fair, but then demote swap pages from swap tier to enforce
fairness when necessary...

Obviously, it's a moot point if there is no good mechanism to transfer
data one tier to another. The data might also be so cold that all of
this has diminishing returns, and moving things around cost more than
it's worth :) So I'm happy to start with something simple, then we can
figure out the next steps.


>
> > >
> > > #3: Per-VMA, per-process swap and BPF:
> > >   Not just for memcg based swap, possible to extend Per-VMA or per-pr=
ocess
> > >   swap. Or we can use it as BPF program.
> > >
> > > #4: Zswap and vswap tiering:
> > >   Tiering applies to the vswap + zswap combination.
> > >
> > > #5: Vswap on/off control:
> > >   Currently not supported. If a strong use case arises where vswap ne=
eds
> > >   to be controlled by memcg, the tier interface could be used for it.
> >
> > +1.
> >
> > Also, per-si/per-tier per-CPU allocation caching? :) Kairui already
> > has a patch for it, IIUC, but if not it's pretty critical I'd say.
>
> Yes, I missed it. Thank you for addressing it.
> we need an implementation that integrates this with the per-CPU
> allocation currently implemented on the vswap side.
>
> If Kairui's patch lands, my patch #4 also can be optimized based on that.

Yup!!

>
> > BTW, can we add some selftests, to make sure the new interface works
> > as expected, and to have example programs for new users to model their
> > scripts after? :)
>
> Yes, I agree. I think selftests are necessary.
>
> Do you want them to be introduced in this patchset, or would it be okay
> to add them separately as follow-up work?

If you have to send another version, might as well include them :)

Otherwise a follow-up is good. Thanks in advance for keeping our
codebase tested!

I'll take a look at the exact implementation on the swap side later,
but I suspect nothing much will have changed :)

