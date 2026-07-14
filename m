Return-Path: <cgroups+bounces-17805-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /KPMHbufVmoR/QAAu9opvQ
	(envelope-from <cgroups+bounces-17805-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 14 Jul 2026 22:44:43 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DE859758C94
	for <lists+cgroups@lfdr.de>; Tue, 14 Jul 2026 22:44:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=VM14Fzrv;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17805-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="cgroups+bounces-17805-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 51AED3037CDB
	for <lists+cgroups@lfdr.de>; Tue, 14 Jul 2026 20:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A311742BC30;
	Tue, 14 Jul 2026 20:44:39 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D99D42BC26
	for <cgroups@vger.kernel.org>; Tue, 14 Jul 2026 20:44:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784061879; cv=none; b=DuVnXWjrpOj/VkeSeeIAct71SkrI/USXA710qE5gajpip9/L6VrZAmZB/EtakQfM31hwqOCIRamUqS8Dw1kFsEp2R3OvcYML/O9YnOrM7sRB4ygfXDLHchme8EtxBGHHy1JAqDAOc/nrDQB6adNM55lCD2GkF6c7wl/a6pt0TDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784061879; c=relaxed/simple;
	bh=0kOCOuq0Ii6yN/EB4U7zJGEKNQZC0Rzcmkr2WKY5wkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D5Q21GRNesmx+R+TWQ/RG1a8eS1dMLN5P1TagEmjQHnIjmsoGwvTap3olOh6NLN5+A8IIhxTn+IJ7TbR1+yJb9tjsMpyNBo9Er5d93+8P6F4+H0HwAJWIIIl3nuJcImYnmQ0g/yD/PbIRO7UwzggidczboiphgFIrc5HL+AU5Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VM14Fzrv; arc=none smtp.client-ip=91.218.175.183
Date: Tue, 14 Jul 2026 13:44:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784061874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6RkI2sO9yZj8cmAzvmTm/IbUcZKQV9FT/HcmLICp+GM=;
	b=VM14FzrvtM74reto72dbQHA46p1dBJffJFJ6TCnZFkbTix0p8Y8gDPUefUaspl77mI123m
	yj4e4kQ1hVDRknPqoNlSZQ2dTNC6zG6QUTibcPd/i9VGrTvVOwEW2DjFlAZiIqnaSNdTt+
	JYv+nsiZY4XeBaX93fc1jJvzoSRXz34=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Youngjun Park <youngjun.park@lge.com>
Cc: Yosry Ahmed <yosry@kernel.org>, akpm@linux-foundation.org, 
	chrisl@kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kasong@tencent.com, hannes@cmpxchg.org, mhocko@kernel.org, 
	roman.gushchin@linux.dev, muchun.song@linux.dev, shikemeng@huaweicloud.com, 
	baoquan.he@linux.dev, baohua@kernel.org, joshua.hahnjy@gmail.com, gunho.lee@lge.com, 
	taejoon.song@lge.com, hyungjun.cho@lge.com, baver.bae@lge.com, her0gyugyu@gmail.com
Subject: Re: [PATCH v10 0/6] mm/swap, memcg: Introduce swap tiers for cgroup
 based swap control
Message-ID: <alae-LIRwEFUjgs1@linux.dev>
References: <20260713025644.170839-1-youngjun.park@lge.com>
 <CAO9r8zNJfhirbzvJzDWRaBQOM7XZcf_Jk0Bz=Y4dB4QK4W-MwQ@mail.gmail.com>
 <alUK8DWRy4LPxTpY@yjaykim-PowerEdge-T330>
 <CAO9r8zPvWKgQ8+ABxSnVnC452-enyMqCjBTA4pfNDVxsoJr25g@mail.gmail.com>
 <alUQ0ksPP00PVwew@yjaykim-PowerEdge-T330>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alUQ0ksPP00PVwew@yjaykim-PowerEdge-T330>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17805-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:youngjun.park@lge.com,m:yosry@kernel.org,m:akpm@linux-foundation.org,m:chrisl@kernel.org,m:linux-mm@kvack.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:kasong@tencent.com,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:muchun.song@linux.dev,m:shikemeng@huaweicloud.com,m:baoquan.he@linux.dev,m:baohua@kernel.org,m:joshua.hahnjy@gmail.com,m:gunho.lee@lge.com,m:taejoon.song@lge.com,m:hyungjun.cho@lge.com,m:baver.bae@lge.com,m:her0gyugyu@gmail.com,m:joshuahahnjy@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[shakeel.butt@linux.dev,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,linux-foundation.org,kvack.org,vger.kernel.org,tencent.com,cmpxchg.org,linux.dev,huaweicloud.com,gmail.com,lge.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shakeel.butt@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lge.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DE859758C94

Hi Youngjun,

Thanks for keep pushing this effort.

On Tue, Jul 14, 2026 at 01:22:42AM +0900, Youngjun Park wrote:
> On Mon, Jul 13, 2026 at 09:01:20AM -0700, Yosry Ahmed wrote:
> > On Mon, Jul 13, 2026 at 8:57 AM Youngjun Park <youngjun.park@lge.com> wrote:
> > >
> > > On Mon, Jul 13, 2026 at 08:50:36AM -0700, Yosry Ahmed wrote:
> > > > On Sun, Jul 12, 2026 at 7:57 PM Youngjun Park <youngjun.park@lge.com> wrote:
> > > > >
> > > > > This is the v10 series of the swap tier patchset.
> > > > >
> > > > > v10 folds in the Sashiko review fixes for the selftests added in v9 and
> > > > > rebases onto the current mm-new. There are no functional changes to the
> > > > > core swap or memcg code since v9; see the changelog for details.
> > > > >
> > > > > For context, the bulk of the series is unchanged since v8, with great thanks
> > > > > to Shakeel Butt and Yosry for the reviews and discussions [1] that shaped it.
> > > > > The main change in v8 was the interface change to use memory.swap.tiers.max
> > > > > with '0' (disable) and 'max' (enable) values. This mechanism was suggested
> > > > > by Shakeel and Yosry.
> > > > >
> > > > > This change allows for future extensions to control swap between tiers and
> > > > > aligns better with existing memcg interfaces. It is confined to patch #3's
> > > > > user-facing interface; internally, patch #3 still uses the existing mask
> > > > > processing method, which is implementation-efficient.
> > > > >
> > > > > We also discussed tier extensions. Thanks to Yosry, Nhat and Shakeel for their
> > > > > valuable feedback.
> > > > >
> > > > > Here is a brief summary of our tentative conclusions. Please correct me
> > > > > if anything is misrepresented (details in references):
> > > > >
> > > > > * Zswap tiering [2]:
> > > > >   Zswap can itself be a tier (typically the fastest one). But, until vswap lands,
> > > > >   zswap cannot be the only allowed tier,
> > > > >   since it still needs a physical device for allocation;
> > > > >   that restriction can be lifted once vswap is supported.
> > > >
> > > > Does this series support zswap being a tier? I cannot find any mention
> > > > of zswap in the patches.
> > >
> > > Hello Yosry!
> > >
> > > This series does not cover zswap as a tier yet.
> > >
> > > My plan is to land the swap tier infrastructure together with the
> > > first use case (cgroup-based swap control) first, and then follow
> > > up with zswap tier support in a subsequent series, continuing the
> > > discussions we've had above.
> > > (I mentioned on cover letter, right above the overview section)
> > >
> > > Does that approach sound reasonable to you?
> > 
> > How does swap tiering work with zswap in the current series? I assume
> > zswap is just enabled for all devices in all tiers?
> 
> Yes, that's correct.
> 
> > I wonder if introducing zswap as a tier after the fact changes user-visible
> > behavior. I guess if zswap will be introduced with a default "max"
> > value it will more-or-less be the same behavior,
> 
> Right, that's the plan.
> 
> > but I would check all
> > user-visible behaviors related to zswap (e.g. interaction with other
> > zswap interfaces) to make sure nothing breaks or changes in a
> > meaningful way when zswap is introduced as a tier later.
> 
> Fair point. Let me review this more and get back to you!

Please do report back what you find.

Yosry, what is needed to enable zswap as a swap tier? What will be the minimum
requirements for that? If that is not too much, we can make that part of this
series.

Shakeel

