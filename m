Return-Path: <cgroups+bounces-17736-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BQyQJhsYVWqMjwAAu9opvQ
	(envelope-from <cgroups+bounces-17736-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 18:53:47 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4C074DC5F
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 18:53:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17736-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17736-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=lge.com (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2DECF3029633
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 16:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC19A43C05B;
	Mon, 13 Jul 2026 16:52:46 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from lgeamrelo11.lge.com (lgeamrelo11.lge.com [156.147.23.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6482F49F6
	for <cgroups@vger.kernel.org>; Mon, 13 Jul 2026 16:52:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783961566; cv=none; b=bEYtRSogXzuZWxNyWkw1KFLQJnLM954RkO+yFh0W7y8Pz6mxO6zJ/u0qWhrsrgORQmGbKyxRapF6ozxE/ytKlbtQISzPl1dt4j91utoivFaDAPw74KoTJxYxbOQe6diPvTYwTSIX/h4uu3BCafuOLWabBzssbSE3mZNtjldtWf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783961566; c=relaxed/simple;
	bh=Ixs7WUqcUQc0ApYnxxdwj4hoc3a/PRjKxlIW0AQMDRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gtflkuZsBN1ndYhSrsDFPyGqjLth4DRyUgjJDRf6vOIgEUJF8eqDDhy0WWAJ9yWT+69Cw/WLLQ7kggwYkkgiz/Fmiy0QNPCQWiCb07pX5lyU/uDXyeop5X+BM7GDF1kPWZ+2yY/g/e9g2+Ja3oNM8sq/ID/p4RbJrv3rszDUBtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.23.51
Received: from unknown (HELO lgemrelse7q.lge.com) (156.147.1.151)
	by 156.147.23.51 with ESMTP; 14 Jul 2026 01:22:42 +0900
X-Original-SENDERIP: 156.147.1.151
X-Original-MAILFROM: youngjun.park@lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330) (10.177.112.156)
	by 156.147.1.151 with ESMTP; 14 Jul 2026 01:22:42 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
Date: Tue, 14 Jul 2026 01:22:42 +0900
From: Youngjun Park <youngjun.park@lge.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: akpm@linux-foundation.org, chrisl@kernel.org, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	kasong@tencent.com, hannes@cmpxchg.org, mhocko@kernel.org,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, shikemeng@huaweicloud.com,
	baoquan.he@linux.dev, baohua@kernel.org, joshua.hahnjy@gmail.com,
	gunho.lee@lge.com, taejoon.song@lge.com, hyungjun.cho@lge.com,
	baver.bae@lge.com, her0gyugyu@gmail.com
Subject: Re: [PATCH v10 0/6] mm/swap, memcg: Introduce swap tiers for cgroup
 based swap control
Message-ID: <alUQ0ksPP00PVwew@yjaykim-PowerEdge-T330>
References: <20260713025644.170839-1-youngjun.park@lge.com>
 <CAO9r8zNJfhirbzvJzDWRaBQOM7XZcf_Jk0Bz=Y4dB4QK4W-MwQ@mail.gmail.com>
 <alUK8DWRy4LPxTpY@yjaykim-PowerEdge-T330>
 <CAO9r8zPvWKgQ8+ABxSnVnC452-enyMqCjBTA4pfNDVxsoJr25g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAO9r8zPvWKgQ8+ABxSnVnC452-enyMqCjBTA4pfNDVxsoJr25g@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lge.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17736-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:yosry@kernel.org,m:akpm@linux-foundation.org,m:chrisl@kernel.org,m:linux-mm@kvack.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:kasong@tencent.com,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:shikemeng@huaweicloud.com,m:baoquan.he@linux.dev,m:baohua@kernel.org,m:joshua.hahnjy@gmail.com,m:gunho.lee@lge.com,m:taejoon.song@lge.com,m:hyungjun.cho@lge.com,m:baver.bae@lge.com,m:her0gyugyu@gmail.com,m:joshuahahnjy@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_SENDER(0.00)[youngjun.park@lge.com,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,kvack.org,vger.kernel.org,tencent.com,cmpxchg.org,linux.dev,huaweicloud.com,gmail.com,lge.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[youngjun.park@lge.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	R_DKIM_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[yjaykim-PowerEdge-T330:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lge.com:email,lge.com:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0A4C074DC5F

On Mon, Jul 13, 2026 at 09:01:20AM -0700, Yosry Ahmed wrote:
> On Mon, Jul 13, 2026 at 8:57 AM Youngjun Park <youngjun.park@lge.com> wrote:
> >
> > On Mon, Jul 13, 2026 at 08:50:36AM -0700, Yosry Ahmed wrote:
> > > On Sun, Jul 12, 2026 at 7:57 PM Youngjun Park <youngjun.park@lge.com> wrote:
> > > >
> > > > This is the v10 series of the swap tier patchset.
> > > >
> > > > v10 folds in the Sashiko review fixes for the selftests added in v9 and
> > > > rebases onto the current mm-new. There are no functional changes to the
> > > > core swap or memcg code since v9; see the changelog for details.
> > > >
> > > > For context, the bulk of the series is unchanged since v8, with great thanks
> > > > to Shakeel Butt and Yosry for the reviews and discussions [1] that shaped it.
> > > > The main change in v8 was the interface change to use memory.swap.tiers.max
> > > > with '0' (disable) and 'max' (enable) values. This mechanism was suggested
> > > > by Shakeel and Yosry.
> > > >
> > > > This change allows for future extensions to control swap between tiers and
> > > > aligns better with existing memcg interfaces. It is confined to patch #3's
> > > > user-facing interface; internally, patch #3 still uses the existing mask
> > > > processing method, which is implementation-efficient.
> > > >
> > > > We also discussed tier extensions. Thanks to Yosry, Nhat and Shakeel for their
> > > > valuable feedback.
> > > >
> > > > Here is a brief summary of our tentative conclusions. Please correct me
> > > > if anything is misrepresented (details in references):
> > > >
> > > > * Zswap tiering [2]:
> > > >   Zswap can itself be a tier (typically the fastest one). But, until vswap lands,
> > > >   zswap cannot be the only allowed tier,
> > > >   since it still needs a physical device for allocation;
> > > >   that restriction can be lifted once vswap is supported.
> > >
> > > Does this series support zswap being a tier? I cannot find any mention
> > > of zswap in the patches.
> >
> > Hello Yosry!
> >
> > This series does not cover zswap as a tier yet.
> >
> > My plan is to land the swap tier infrastructure together with the
> > first use case (cgroup-based swap control) first, and then follow
> > up with zswap tier support in a subsequent series, continuing the
> > discussions we've had above.
> > (I mentioned on cover letter, right above the overview section)
> >
> > Does that approach sound reasonable to you?
> 
> How does swap tiering work with zswap in the current series? I assume
> zswap is just enabled for all devices in all tiers?

Yes, that's correct.

> I wonder if introducing zswap as a tier after the fact changes user-visible
> behavior. I guess if zswap will be introduced with a default "max"
> value it will more-or-less be the same behavior,

Right, that's the plan.

> but I would check all
> user-visible behaviors related to zswap (e.g. interaction with other
> zswap interfaces) to make sure nothing breaks or changes in a
> meaningful way when zswap is introduced as a tier later.

Fair point. Let me review this more and get back to you!

Thanks,
Youngjun

