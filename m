Return-Path: <cgroups+bounces-17740-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id l3USOMkvVWpalAAAu9opvQ
	(envelope-from <cgroups+bounces-17740-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 20:34:49 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 560C374E843
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 20:34:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=cECWHdp7;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17740-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="cgroups+bounces-17740-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 708F93023DBE
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 18:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F8A3537FF;
	Mon, 13 Jul 2026 18:34:44 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D802352025
	for <cgroups@vger.kernel.org>; Mon, 13 Jul 2026 18:34:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783967684; cv=none; b=SI/epcWE5XPh16ZJliNPYA2/5J4XvIC8V27M0P1f5+bPOu+p90WMg9fB0m7WrXng0OL4Kk3NZcCHwJ1/o43z0Qj49Wi9oPofALe2M+zeME/YL0iygYnERes41mE+6est5pYqCXMBJvPJMGlzXL0Ysh9zTVZn53n9UA5QEG73joU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783967684; c=relaxed/simple;
	bh=iJUFlkccjUuS4qFP6mqB53gOiHxnLKsqxQ1sG3XJ0eA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zp5rPtElKnC/bQnlmAxWkw4V+7TAFwzWmlszP4w+8XtXyG1KH/rfqqtrnT3TGhUjn6iN6KxvOXYnEWPIlJAzg4Uanu0U8Dzj0Oekk+njiajAOZyohWdFS3+qwlKkaYDIG8kUVV6I1wpa+iZ1K+KQoyH7SMurNqZiRam49EBZmQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cECWHdp7; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1A5B1F00A3F
	for <cgroups@vger.kernel.org>; Mon, 13 Jul 2026 18:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783967682;
	bh=iJUFlkccjUuS4qFP6mqB53gOiHxnLKsqxQ1sG3XJ0eA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=cECWHdp7lten2hk6CI+Xh2vNetW0oXjQIYCSMViZPio4BeUld1qEWik2mjlo27Sn0
	 MqWl0QZfG5h5291YbXhUhRwIOqxRamjy4FC+C46RrWM3BIirmvAVGAJGZnCbSZ63nx
	 iUr4BvXWNQpqYT8kUkHvkyihGJkKGX/ItcVQOvltCa8fE1MHCrSUHbk4GvOTcbbZTs
	 tV+kEWZztSAS2ZL1MeTM6c/9Sr1gXHkQTYevvnw4z2oJ+b3vLa2hFm7J9CphBKRgt+
	 uTNJOg/JQibI4jWgAzauneQ3HcunUayBK6t6kOnDD/Y+Cna5EqGUxZLLUKJ6XDDZ9R
	 4VkEj08EXjfGw==
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-664ce3000e6so213753d50.0
        for <cgroups@vger.kernel.org>; Mon, 13 Jul 2026 11:34:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rq+i1X9j9UFeS9FwlrSqimc6kblHr1McvPTj8luHJ/FodpRFVbzlbH0i4w9Cl4HLEu4S4GFdz8R@vger.kernel.org
X-Gm-Message-State: AOJu0YwvYLrLSW+fSRxGsjspoYx2lHj5CqLNRrFRnMxhfsLt/aQRN15k
	nKwq9v6fO1fWBFL5nQMaoyIvaHHvABr9pO7NKh5LYBDJsXrSwfuTAJa2CjG4u2dcSxVKZhNo0nD
	DTFY3FeeQmJ0rUdCVCa7yiinl6OrEjrLK8QJ90v9NcA==
X-Received: by 2002:a53:ac94:0:b0:667:e0f3:3229 with SMTP id
 956f58d0204a3-667e0f332b6mr5996729d50.105.1783967681919; Mon, 13 Jul 2026
 11:34:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260713025644.170839-1-youngjun.park@lge.com>
 <CAO9r8zNJfhirbzvJzDWRaBQOM7XZcf_Jk0Bz=Y4dB4QK4W-MwQ@mail.gmail.com>
 <alUK8DWRy4LPxTpY@yjaykim-PowerEdge-T330> <CAO9r8zPvWKgQ8+ABxSnVnC452-enyMqCjBTA4pfNDVxsoJr25g@mail.gmail.com>
 <CACePvbX1U3pLRqCP-k9x9bvbn+sXCexnbqXjwXcdvwbH+qD6sA@mail.gmail.com> <CAO9r8zPtcne97wQKZFsNoMS-4zpTFvaA3EU8ghnEHPfwD28zoQ@mail.gmail.com>
In-Reply-To: <CAO9r8zPtcne97wQKZFsNoMS-4zpTFvaA3EU8ghnEHPfwD28zoQ@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Mon, 13 Jul 2026 11:34:31 -0700
X-Gmail-Original-Message-ID: <CACePvbWOm3EL6Ph+A_NgAp80GcQt2N-qW1qbyxOVDL3EZSAh8g@mail.gmail.com>
X-Gm-Features: AVVi8CezeMcaD2E5KHpd5R8bV0jZbW0uSawnGnnjL02HdmwndEm4NxRU0MShMiU
Message-ID: <CACePvbWOm3EL6Ph+A_NgAp80GcQt2N-qW1qbyxOVDL3EZSAh8g@mail.gmail.com>
Subject: Re: [PATCH v10 0/6] mm/swap, memcg: Introduce swap tiers for cgroup
 based swap control
To: Yosry Ahmed <yosry@kernel.org>
Cc: Youngjun Park <youngjun.park@lge.com>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, kasong@tencent.com, 
	hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	shakeel.butt@linux.dev, muchun.song@linux.dev, shikemeng@huaweicloud.com, 
	baoquan.he@linux.dev, baohua@kernel.org, joshua.hahnjy@gmail.com, 
	gunho.lee@lge.com, taejoon.song@lge.com, hyungjun.cho@lge.com, 
	baver.bae@lge.com, her0gyugyu@gmail.com
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
	TAGGED_FROM(0.00)[bounces-17740-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:yosry@kernel.org,m:youngjun.park@lge.com,m:akpm@linux-foundation.org,m:linux-mm@kvack.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:kasong@tencent.com,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:shikemeng@huaweicloud.com,m:baoquan.he@linux.dev,m:baohua@kernel.org,m:joshua.hahnjy@gmail.com,m:gunho.lee@lge.com,m:taejoon.song@lge.com,m:hyungjun.cho@lge.com,m:baver.bae@lge.com,m:her0gyugyu@gmail.com,m:joshuahahnjy@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[chrisl@kernel.org,cgroups@vger.kernel.org];
	FREEMAIL_CC(0.00)[lge.com,linux-foundation.org,kvack.org,vger.kernel.org,tencent.com,cmpxchg.org,kernel.org,linux.dev,huaweicloud.com,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chrisl@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 560C374E843

On Mon, Jul 13, 2026 at 10:11=E2=80=AFAM Yosry Ahmed <yosry@kernel.org> wro=
te:
>
> On Mon, Jul 13, 2026 at 10:03=E2=80=AFAM Chris Li <chrisl@kernel.org> wro=
te:
> >
> > On Mon, Jul 13, 2026 at 9:01=E2=80=AFAM Yosry Ahmed <yosry@kernel.org> =
wrote:
> > > > My plan is to land the swap tier infrastructure together with the
> > > > first use case (cgroup-based swap control) first, and then follow
> > > > up with zswap tier support in a subsequent series, continuing the
> > > > discussions we've had above.
> > > > (I mentioned on cover letter, right above the overview section)
> > > >
> > > > Does that approach sound reasonable to you?
> > >
> > > How does swap tiering work with zswap in the current series? I assume
> > > zswap is just enabled for all devices in all tiers? I wonder if
> >
> > Zswap is not part of the tiers exactly because it sits in front of all
> > swap devices (tiers) and uses a different control to enable or disable
> > it.
> > Let's not combine these two; let zswap use its own existing cgroup
> > control interface.
> >
> > > introducing zswap as a tier after the fact changes user-visible
> > > behavior. I guess if zswap will be introduced with a default "max"
> > > value it will more-or-less be the same behavior, but I would check al=
l
> > > user-visible behaviors related to zswap (e.g. interaction with other
> > > zswap interfaces) to make sure nothing breaks or changes in a
> > > meaningful way when zswap is introduced as a tier later.
> >
> > Zswap will not be introduced as a tier. The existing user interface
> > makes zswap not exactly compatible with the tier ordering because it
> > sits in front of every swapfile. If we change that, we break the user
> > interface. I suggest we keep zswap working as it is now.
>
> The goal from making zswap a swap tier is to have a single framework
> to configure swapping for a cgroup, instead of configuring zswap
> separately. Yes, zswap currently sits in front of all swap
> devices/tiers, but we are heading in the direction of changing that
> such that zswap is standalone, at which point it becomes more
> obviously a swap tier. If you want us to wait until that happens
> before adding zswap as a tier, I don't necessarily object, but I want
> to make sure that nothing will break if we add zswap as a tier later.

I'm afraid your zswap user interface will have to break. I don't see a
way around breaking your zswap user interface to fit the swap tiering.
Once we move to the swap tier world, I don't think we should continue
using zswap.writeback to control the tier write back behavior. We will
need to rethink this new world.

> An advantage of adding zswap as a tier right away is the proactive
> writeback use case. It naturally fits in the tiering framework as
> proactive demotion between swap tiers, which I expect may be useful in
> non-zswap use cases as well. Without zswap as a tier, we'll have to
> use a different interface for proactive writeback, and then if/when
> zswap becomes a tier, we'll have multiple ways to do proactive
> writeback which isn't ideal.

I am looking forward to abstracting a more common write back behavior
in the swap tier world. The classic zswap behavior will be preserved.

Chris

