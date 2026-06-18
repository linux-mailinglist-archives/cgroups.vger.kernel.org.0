Return-Path: <cgroups+bounces-17054-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /dkLI1JOM2pL/QUAu9opvQ
	(envelope-from <cgroups+bounces-17054-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 18 Jun 2026 03:48:02 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A75B169D0D2
	for <lists+cgroups@lfdr.de>; Thu, 18 Jun 2026 03:48:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=lge.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17054-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17054-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E5AD301C896
	for <lists+cgroups@lfdr.de>; Thu, 18 Jun 2026 01:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6386283C93;
	Thu, 18 Jun 2026 01:47:59 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from lgeamrelo03.lge.com (lgeamrelo03.lge.com [156.147.51.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A639140D57D
	for <cgroups@vger.kernel.org>; Thu, 18 Jun 2026 01:47:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781747279; cv=none; b=qMbSWge9qzU5T1e64ufRbGK6BLkgJxEG0QktthexsaO8zR4KoMqRuvZmw/A/KhjjCiHmS5G/unTxomOY6GZkMh61rfYV9c79cRvdk6CCvN2xBkLovUB1T1NDkFrpr990WydB53egPpNmsa3Aew2EftC9AtLszv43cU10yYaKlI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781747279; c=relaxed/simple;
	bh=u07Rjhs92v2/hAnRi8bFl9/RPwSNWpnMJVzUgvAFkxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HFHOBwHfEFj2DzoiTo+m+VYIGK9A+iz4Mw6U3YjpFdZL7RsujbvrOfFV1+cW9vFJ2vcz4uYIb2uGg/NCvfi3YDq826xBXV3mWY8NJyNPZoz5eKnaFuO+UQZySAJLq/4OlOJKamf3QpQV7lqlECiJL2rTqHsMc6q/9CBymqYwYbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.102
Received: from unknown (HELO yjaykim-PowerEdge-T330) (10.177.112.156)
	by 156.147.51.102 with ESMTP; 18 Jun 2026 10:47:53 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
Date: Thu, 18 Jun 2026 10:47:53 +0900
From: YoungJun Park <youngjun.park@lge.com>
To: Nhat Pham <nphamcs@gmail.com>
Cc: akpm@linux-foundation.org, chrisl@kernel.org, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	kasong@tencent.com, hannes@cmpxchg.org, mhocko@kernel.org,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, shikemeng@huaweicloud.com,
	baoquan.he@linux.dev, baohua@kernel.org, yosry@kernel.org,
	gunho.lee@lge.com, taejoon.song@lge.com, hyungjun.cho@lge.com,
	mkoutny@suse.com, baver.bae@lge.com, matia.kim@lge.com
Subject: Re: [PATCH v8 0/4] mm/swap, memcg: Introduce swap tiers for cgroup
 based swap control
Message-ID: <ajNOSesjwTyZc8EX@yjaykim-PowerEdge-T330>
References: <20260617053447.2831896-1-youngjun.park@lge.com>
 <CAKEwX=NfSy0XiD_UMsDOHGCwpE7sYmBmhV4Y9vk_cbnnr6J6PQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKEwX=NfSy0XiD_UMsDOHGCwpE7sYmBmhV4Y9vk_cbnnr6J6PQ@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.86 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lge.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:nphamcs@gmail.com,m:akpm@linux-foundation.org,m:chrisl@kernel.org,m:linux-mm@kvack.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:kasong@tencent.com,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:shikemeng@huaweicloud.com,m:baoquan.he@linux.dev,m:baohua@kernel.org,m:yosry@kernel.org,m:gunho.lee@lge.com,m:taejoon.song@lge.com,m:hyungjun.cho@lge.com,m:mkoutny@suse.com,m:baver.bae@lge.com,m:matia.kim@lge.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_SENDER(0.00)[youngjun.park@lge.com,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[youngjun.park@lge.com,cgroups@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-17054-lists,cgroups=lfdr.de];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lge.com:from_mime,lge.com:email,yjaykim-PowerEdge-T330:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A75B169D0D2

On Wed, Jun 17, 2026 at 01:50:49PM -0400, Nhat Pham wrote:

> On Wed, Jun 17, 2026 at 1:34 AM Youngjun Park <youngjun.park@lge.com> wrote:
> >
> > This is the v8 series of the swap tier patchset.
> >
> > Great thanks to Shakeel Butt and Yosry for the reviews and discussions [1].
> > The main change in this version is the interface change to use
> > memory.swap.tiers.max with '0' (disable) and 'max' (enable) values.
> > This mechanism was suggested by Shakeel and Yosry
> 
> I like this interface too :)

Good to hear. Now it looks like we have found a memcg interface that
aligns well with the existing memcg model.

I like this idea as well. Thanks again to Shakeel Butt and Yosry.

> > Here is a brief summary of our tentative conclusions. Please correct me
> > if anything is misrepresented (details in references):
> >
> > * Zswap tiering [2]:
> >   Tiering applies only to the vswap + zswap combo. Zswap itself will
> >   not be tiered, as the current architecture requires a physical device
> >   for zswap allocation.
> 
> I think Yosry wants zswap as a tier, right?
> 
> Just that without vswap, maybe don't allow it to be an tier of itself?

With the current architecture, users cannot dynamically specify zswap as
a tier, and zswap is a separate layer, so it is not tiered by itself.

Once your vswap work lands, I think we can make the zswap 
become the default, top-level tier.

After that, we can also look into cleaning up the zswap.writeback
interface together.

> #2: Inter-tier promotion and demotion:
>   Promotion and demotion apply between tiers, not within a single
>   tier. The current interface defines only tier assignment; it does
>   not yet define when or how pages move between tiers. Two triggering
>   models are possible:
>
> >   (a) User-triggered: userspace explicitly initiates migration between
> >       tiers (e.g. via a new interface or existing move_pages semantics).
> >   (b) Kernel-triggered: the kernel moves pages between tiers at
> >       appropriate points such as reclaim or refault.
> 
> We'll likely need some kernel-triggered mechanism, or we'd have LRU inversion :)
> 
> Cold pages will fill up fast tiers first, and more recent/warm pages
> will land on slow tiers...

Yeah, good point!

> We'll also need to enforce isolation/fairness to make sure no wordload
> hoard the fast tiers too (but that probably requires demotion
> support).

Right, that makes sense.

BTW, One thing I am curious about, though, is whether there are strong
real-world use cases that require demotion/promotion.
Theoretically, this looks useful but it would be helpful to better understand 
the requirements from such deployments.

> >
> > #3: Per-VMA, per-process swap and BPF:
> >   Not just for memcg based swap, possible to extend Per-VMA or per-process
> >   swap. Or we can use it as BPF program.
> >
> > #4: Zswap and vswap tiering:
> >   Tiering applies to the vswap + zswap combination.
> >
> > #5: Vswap on/off control:
> >   Currently not supported. If a strong use case arises where vswap needs
> >   to be controlled by memcg, the tier interface could be used for it.
> 
> +1.
> 
> Also, per-si/per-tier per-CPU allocation caching? :) Kairui already
> has a patch for it, IIUC, but if not it's pretty critical I'd say.

Yes, I missed it. Thank you for addressing it.
we need an implementation that integrates this with the per-CPU
allocation currently implemented on the vswap side.

If Kairui's patch lands, my patch #4 also can be optimized based on that.

> BTW, can we add some selftests, to make sure the new interface works
> as expected, and to have example programs for new users to model their
> scripts after? :)

Yes, I agree. I think selftests are necessary.

Do you want them to be introduced in this patchset, or would it be okay
to add them separately as follow-up work?

