Return-Path: <cgroups+bounces-17739-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BmgrDicdVWpnkAAAu9opvQ
	(envelope-from <cgroups+bounces-17739-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 19:15:19 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B1A74DEB4
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 19:15:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=DTAxNtRp;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17739-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17739-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 502BD304569F
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 17:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2053438BD;
	Mon, 13 Jul 2026 17:11:20 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2CC30DEA6
	for <cgroups@vger.kernel.org>; Mon, 13 Jul 2026 17:11:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783962680; cv=none; b=F35rYoKKbNlHE1SMmpcy01IHtNJ2PfTU2od69ai5PfgoO8tIBrZkd+GGy+1gGIZGDPi8AOJ87I+buxZjzYK4lWdlUCDwTp6Ian5Yf7SKpwMujfTXhLF+OBeUjLq/DCzErepV1p4BcC33xIwxe/jTxQDFVFpXRkotFdOO9EdhaWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783962680; c=relaxed/simple;
	bh=BQTumPEp3B0RtOhDCU3UTQhcVFGvQqZPO4jEe1rP18g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dn0JgP4xgsC2n0eigHn6tTWwLwpcB5o+/7+dX43iYcf15l69Z7E4lFX7Tk8VGeFOuqZHUz7zrrlBAX3lYiOn+eDCoUT/WG4pchYAac7dc00iA2m/UMWSx2DRpLmWaNRhvx5bXnuoYHJdr8aaNbo5+mbUqNwoVxSzPzgT1EGzktI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DTAxNtRp; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92A9A1F00A3F
	for <cgroups@vger.kernel.org>; Mon, 13 Jul 2026 17:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783962679;
	bh=BQTumPEp3B0RtOhDCU3UTQhcVFGvQqZPO4jEe1rP18g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=DTAxNtRpb76h9S+rgALQP2b3SFjAnlNDGGE/2/KHiNt77ON78wFh6jWgO4RGJ8niO
	 v32AJz7e6z9/Uam+m3OY7S2cWzQOmtRiqduWaXCZuv5N00QCr1vaaDFv3txENjjeGN
	 ZJWm1VIw2zaySLdQLSk+8u/RfF79mDGR8u5MD86vszYQFIZ4IUw7Lvw7deKAR2VpgD
	 bMUuX0pRlW+A5SPNqCP6nEeINSa0OfCe0S6sIY9yD5ryqfW8pC0d2FDmeJvOQenF2Z
	 LVJeagIKJW2w8Nuy8aRkauoS/5/nbjmJtjltWtoNMiAu4g/0N9uBFKlQPKu4uRY/rM
	 PPHV+N2Jwe4fA==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c15b1da6b82so19073066b.1
        for <cgroups@vger.kernel.org>; Mon, 13 Jul 2026 10:11:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqK5lpX/e2o9KIuq2l8/9/pFQo+wDNeatEFStQnM13sSuQyijavbpJAKTDA68us9JrHC1x3AB6B@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz+c74e1yt9kqg0zcRMCWXLR5t5vgQlEeMLWvpzjFQji+gS4lI
	pUzIC4szdX4nQ2S2umcg59U1Ua5f4MKJY3NPOopbnFw505eXi1jrk3UetOcLErPE4r0hCwJn+jy
	4TrufKZgrkmrfGybdIsz/Pe63waBfL2k=
X-Received: by 2002:a17:907:a785:b0:bed:9a7:5ed1 with SMTP id
 a640c23a62f3a-c161e956b92mr398059166b.5.1783962678493; Mon, 13 Jul 2026
 10:11:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260713025644.170839-1-youngjun.park@lge.com>
 <CAO9r8zNJfhirbzvJzDWRaBQOM7XZcf_Jk0Bz=Y4dB4QK4W-MwQ@mail.gmail.com>
 <alUK8DWRy4LPxTpY@yjaykim-PowerEdge-T330> <CAO9r8zPvWKgQ8+ABxSnVnC452-enyMqCjBTA4pfNDVxsoJr25g@mail.gmail.com>
 <CACePvbX1U3pLRqCP-k9x9bvbn+sXCexnbqXjwXcdvwbH+qD6sA@mail.gmail.com>
In-Reply-To: <CACePvbX1U3pLRqCP-k9x9bvbn+sXCexnbqXjwXcdvwbH+qD6sA@mail.gmail.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Mon, 13 Jul 2026 10:11:06 -0700
X-Gmail-Original-Message-ID: <CAO9r8zPtcne97wQKZFsNoMS-4zpTFvaA3EU8ghnEHPfwD28zoQ@mail.gmail.com>
X-Gm-Features: AVVi8CcAg9n2PdlNTHyoGC1oIxbThm2NtEI-8VIlrgHUzA8UGuYNTJ-1-2Xqom4
Message-ID: <CAO9r8zPtcne97wQKZFsNoMS-4zpTFvaA3EU8ghnEHPfwD28zoQ@mail.gmail.com>
Subject: Re: [PATCH v10 0/6] mm/swap, memcg: Introduce swap tiers for cgroup
 based swap control
To: Chris Li <chrisl@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17739-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:chrisl@kernel.org,m:youngjun.park@lge.com,m:akpm@linux-foundation.org,m:linux-mm@kvack.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:kasong@tencent.com,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:shikemeng@huaweicloud.com,m:baoquan.he@linux.dev,m:baohua@kernel.org,m:joshua.hahnjy@gmail.com,m:gunho.lee@lge.com,m:taejoon.song@lge.com,m:hyungjun.cho@lge.com,m:baver.bae@lge.com,m:her0gyugyu@gmail.com,m:joshuahahnjy@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[yosry@kernel.org,cgroups@vger.kernel.org];
	FREEMAIL_CC(0.00)[lge.com,linux-foundation.org,kvack.org,vger.kernel.org,tencent.com,cmpxchg.org,kernel.org,linux.dev,huaweicloud.com,gmail.com];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 81B1A74DEB4

On Mon, Jul 13, 2026 at 10:03=E2=80=AFAM Chris Li <chrisl@kernel.org> wrote=
:
>
> On Mon, Jul 13, 2026 at 9:01=E2=80=AFAM Yosry Ahmed <yosry@kernel.org> wr=
ote:
> > > My plan is to land the swap tier infrastructure together with the
> > > first use case (cgroup-based swap control) first, and then follow
> > > up with zswap tier support in a subsequent series, continuing the
> > > discussions we've had above.
> > > (I mentioned on cover letter, right above the overview section)
> > >
> > > Does that approach sound reasonable to you?
> >
> > How does swap tiering work with zswap in the current series? I assume
> > zswap is just enabled for all devices in all tiers? I wonder if
>
> Zswap is not part of the tiers exactly because it sits in front of all
> swap devices (tiers) and uses a different control to enable or disable
> it.
> Let's not combine these two; let zswap use its own existing cgroup
> control interface.
>
> > introducing zswap as a tier after the fact changes user-visible
> > behavior. I guess if zswap will be introduced with a default "max"
> > value it will more-or-less be the same behavior, but I would check all
> > user-visible behaviors related to zswap (e.g. interaction with other
> > zswap interfaces) to make sure nothing breaks or changes in a
> > meaningful way when zswap is introduced as a tier later.
>
> Zswap will not be introduced as a tier. The existing user interface
> makes zswap not exactly compatible with the tier ordering because it
> sits in front of every swapfile. If we change that, we break the user
> interface. I suggest we keep zswap working as it is now.

The goal from making zswap a swap tier is to have a single framework
to configure swapping for a cgroup, instead of configuring zswap
separately. Yes, zswap currently sits in front of all swap
devices/tiers, but we are heading in the direction of changing that
such that zswap is standalone, at which point it becomes more
obviously a swap tier. If you want us to wait until that happens
before adding zswap as a tier, I don't necessarily object, but I want
to make sure that nothing will break if we add zswap as a tier later.

An advantage of adding zswap as a tier right away is the proactive
writeback use case. It naturally fits in the tiering framework as
proactive demotion between swap tiers, which I expect may be useful in
non-zswap use cases as well. Without zswap as a tier, we'll have to
use a different interface for proactive writeback, and then if/when
zswap becomes a tier, we'll have multiple ways to do proactive
writeback which isn't ideal.

