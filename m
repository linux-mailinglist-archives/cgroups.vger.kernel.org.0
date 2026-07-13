Return-Path: <cgroups+bounces-17742-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WsMSLuI+VWr5lwAAu9opvQ
	(envelope-from <cgroups+bounces-17742-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 21:39:14 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 489B274EC81
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 21:39:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="g/PuvFj3";
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17742-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17742-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B9C333011EBA
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 19:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E20D357CF9;
	Mon, 13 Jul 2026 19:39:12 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F72357D13
	for <cgroups@vger.kernel.org>; Mon, 13 Jul 2026 19:39:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783971552; cv=none; b=XngjqAf2d7HTDXnRWIPvTbMv7CFJnfGJCf/xuV8iTVBg75c6KSmXcBtjBDRo58QaKKN8dvkExGzuyBFpopeyqd4nFR/vorIFPtE66d3daJHaGTOu51rcm9k/s1ISYyxePZbKG8/6GJK8wxyx6Q30S9gfgxMgCu1HYJ7yo0P6D+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783971552; c=relaxed/simple;
	bh=Qg6ZVGkGjyzsXwLwsor5+2jsXCyFbMN9y/cRQoYhLtY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dKVjq1+LHrcHKpHMIvGPE33nLApPe4MLg4xbchLbHjMcW9i9LtOJjcHvQOtjSpMYoacKBe/LGXzHdR1Fz3toCjUg0Xa9ZG9CYNMMdX6l5PP6sFt3xWS3PKgVDa+NcsRd09+aQZVVS0uCAXQWThVout5PFgcLFqvt7b4dI+z7ZSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g/PuvFj3; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CAA51F00ADB
	for <cgroups@vger.kernel.org>; Mon, 13 Jul 2026 19:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783971551;
	bh=Qg6ZVGkGjyzsXwLwsor5+2jsXCyFbMN9y/cRQoYhLtY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=g/PuvFj3WZN7SPxlaHiWKlnfQ34UKeItcZxTaK6qVuNhqKbTNxCBiShOJrEttmUbn
	 eZxdia9ZVKdnmKze/ul6I59Plp9kOdzkNDOy/wWI92DF+EIrCZC2+hLe+mn3IYQdHp
	 PdKC/nPNbxt0aQAyMJWLaZi+0WP8+W0B8qbiEqO+5Z7B1JWfBS1Lm9nPfronv6GKDc
	 dSOX/OqeRhPNiLL3EzGhyL40ZwhMFL/XeZuVDBztrK/+izCcGWzuPCh22uqoOrVp9B
	 PYihbGK7+x9mC1O+T0pqOYb9s8a9Zz/AZJdHKfhTaEOikT9MiFplOK8ylVtsR9Eqq1
	 GIZCMAtMr5sRg==
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-6626b5ace23so375012d50.0
        for <cgroups@vger.kernel.org>; Mon, 13 Jul 2026 12:39:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrSrLRDgwgBZIv+XAG1LDqMrbQBVs2NbdOGsn4EWPhMMraXeK2yD8R841mcBzWskAnwtCnbU43Y@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi/zRVJ//1KpWi08wOOW3KkR95OSSogQpG4bN80M3wCQnICK71
	P2o/LSXc/TThXdHMJKcuCwjBu8otljCTw7crS4xtKr+/MhrLQazMq3ObcIyIS3PHXmBoWKj5bbo
	edZ2OzYgyatQ9TxMBAgCyy3UF/HuNxKc5nHVcNG320A==
X-Received: by 2002:a05:690e:108a:20b0:667:538a:ddeb with SMTP id
 956f58d0204a3-667d98ec4b4mr5287705d50.31.1783971550390; Mon, 13 Jul 2026
 12:39:10 -0700 (PDT)
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
 <CAO9r8zPtcne97wQKZFsNoMS-4zpTFvaA3EU8ghnEHPfwD28zoQ@mail.gmail.com>
 <CACePvbWOm3EL6Ph+A_NgAp80GcQt2N-qW1qbyxOVDL3EZSAh8g@mail.gmail.com> <CAO9r8zO4uW=SX7se154Z6+DrxfawZfAiRO6Ar5rUm3T78x5HUw@mail.gmail.com>
In-Reply-To: <CAO9r8zO4uW=SX7se154Z6+DrxfawZfAiRO6Ar5rUm3T78x5HUw@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Mon, 13 Jul 2026 12:38:57 -0700
X-Gmail-Original-Message-ID: <CACePvbX5oWcTRpQeBCQsod5C5KEhd-0vA4B1PGYddNfgTW2tvA@mail.gmail.com>
X-Gm-Features: AVVi8Cfs2jnetf2lNr53IOa2b-MdHz_D4--892kNI-Xqp57Fk6NyE7rf5COXhGg
Message-ID: <CACePvbX5oWcTRpQeBCQsod5C5KEhd-0vA4B1PGYddNfgTW2tvA@mail.gmail.com>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-17742-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[chrisl@kernel.org,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lge.com,linux-foundation.org,kvack.org,vger.kernel.org,tencent.com,cmpxchg.org,kernel.org,linux.dev,huaweicloud.com,gmail.com];
	FORGED_RECIPIENTS(0.00)[m:yosry@kernel.org,m:youngjun.park@lge.com,m:akpm@linux-foundation.org,m:linux-mm@kvack.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:kasong@tencent.com,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:shikemeng@huaweicloud.com,m:baoquan.he@linux.dev,m:baohua@kernel.org,m:joshua.hahnjy@gmail.com,m:gunho.lee@lge.com,m:taejoon.song@lge.com,m:hyungjun.cho@lge.com,m:baver.bae@lge.com,m:her0gyugyu@gmail.com,m:joshuahahnjy@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chrisl@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 489B274EC81

On Mon, Jul 13, 2026 at 11:38=E2=80=AFAM Yosry Ahmed <yosry@kernel.org> wro=
te:
>
> > > > Zswap will not be introduced as a tier. The existing user interface
> > > > makes zswap not exactly compatible with the tier ordering because i=
t
> > > > sits in front of every swapfile. If we change that, we break the us=
er
> > > > interface. I suggest we keep zswap working as it is now.
> > >
> > > The goal from making zswap a swap tier is to have a single framework
> > > to configure swapping for a cgroup, instead of configuring zswap
> > > separately. Yes, zswap currently sits in front of all swap
> > > devices/tiers, but we are heading in the direction of changing that
> > > such that zswap is standalone, at which point it becomes more
> > > obviously a swap tier. If you want us to wait until that happens
> > > before adding zswap as a tier, I don't necessarily object, but I want
> > > to make sure that nothing will break if we add zswap as a tier later.
> >
> > I'm afraid your zswap user interface will have to break. I don't see a
> > way around breaking your zswap user interface to fit the swap tiering.
> > Once we move to the swap tier world, I don't think we should continue
> > using zswap.writeback to control the tier write back behavior. We will
> > need to rethink this new world.
>
> I wasn't talking about the existing zswap interfaces. I want to make
> sure that if we introduce tiering initially without zswap as a tier,
> then add zswap as a tier, the semantics of tiering and user-visible
> zswap behavior doesn't break.

No, the user visible part of zswap must break because zswap currently
sits in front of every swapfile.
I don't see any other way around it.

If you do know how zswap can interact with swap.tiers without breaking
the user interface, make a formal proposal and lay out all the
details. I did that exercise myself and I my conclusion is that it is
better to accept zswap is the classic behavior without burdening the
unified swap tier too much.

> That being said, the existing zswap interfaces don't have to break
> with tiering, why do they? We may end up with redundant interfaces,

Because zswap does not have its own swap device, it borrows the swap
slot from the underlying swap device. That behavior is unique to zswap
and none of the other swap tiers have that.

> which is unfortunate, and we can work to deprecate some of them over
> time. But I don't see why we have to break them?

I don't want to special case the zswap for from the swap tiers.

> > > An advantage of adding zswap as a tier right away is the proactive
> > > writeback use case. It naturally fits in the tiering framework as
> > > proactive demotion between swap tiers, which I expect may be useful i=
n
> > > non-zswap use cases as well. Without zswap as a tier, we'll have to
> > > use a different interface for proactive writeback, and then if/when
> > > zswap becomes a tier, we'll have multiple ways to do proactive
> > > writeback which isn't ideal.
> >
> > I am looking forward to abstracting a more common write back behavior
> > in the swap tier world. The classic zswap behavior will be preserved.
>
> Right, but this requires zswap being a tier, which you seem to be opposed=
 to :)

It does not need to as far as I can tell. People who want classic
zswap can use zswap as it is. I am thinking the swap ops provide some
interface for classic zswap to use, but zswap itself is not a tier
because it does not own swap devices.

Chris

