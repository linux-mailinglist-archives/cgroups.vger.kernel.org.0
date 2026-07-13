Return-Path: <cgroups+bounces-17743-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ySatCUVDVWrqmAAAu9opvQ
	(envelope-from <cgroups+bounces-17743-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 21:57:57 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 177EC74EEC5
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 21:57:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=CZIKYpWk;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17743-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17743-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3DA36300A271
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 19:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F925359A6C;
	Mon, 13 Jul 2026 19:57:49 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CEB31283E
	for <cgroups@vger.kernel.org>; Mon, 13 Jul 2026 19:57:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783972669; cv=none; b=NbBYq7RQ8C4aA3qoSpJ9lFAj5u6OgOrD7QyLvTKsssYsRuSjElkmHW0UFxJYxyyx8fl3MJT3uQ6slq9o8JgICau8aQtS2HA2Hm0y078iZ8QpBMy4winzSUd7+9eiUiHTrYnuHsE6V74UTzEcgWoEjnsZrC5rEHltJlRhkGbbUWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783972669; c=relaxed/simple;
	bh=Lb0u9083uAGrWjVRQ9Qk+A8Z+iONhqOvEGQOCQR578I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gpmtBN6R99nmYxmhK1lGgBOO0SxF7Il3sAH9iKre6y/rWFhcobFupMyD8qKrEYikXlgYXCt0Bpab5S4B8Ca8YKZo4gJ/od2xqJuiBBnubpwIXCFBE7wXyz6b4n2RQHdRGIHIbOmZl6Q9At8GbLWSuhsg2nRamzNZlTm/8jW+3ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CZIKYpWk; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1576E1F01560
	for <cgroups@vger.kernel.org>; Mon, 13 Jul 2026 19:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783972668;
	bh=Lb0u9083uAGrWjVRQ9Qk+A8Z+iONhqOvEGQOCQR578I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=CZIKYpWkmwL7fBz0EYJI/nWVVRo8dIncc2EbkWJWCc7zPOWJBom6lr6vTsp2/8ZUf
	 WgtN82SoNrktYL/1fB3AW7AHfMED2SaWAWCOIJEZrY07ECr+wCuAd/QppjxLTCHEYt
	 /LTBWOE4ToV+91i3OPXdPhbPtEBUoFLuSJtl5nhV2oM9FQxYyL+lY35V2vHIpvXhzy
	 CdrK78U4870HwGn/Xb6Qw7bQOA3xOt5Zc7sF279cEpHvcisS1RvvqCX70/G5dlEvHX
	 MlrqgRtohaaiyj0G8a8eg4HZa4GqlaE/3kfYVnX53IFMfvq5FhnR1f5yYbIR2qIQhH
	 wb1AJLzkcB2HA==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c1601d552a8so365040566b.2
        for <cgroups@vger.kernel.org>; Mon, 13 Jul 2026 12:57:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rp6Y3dsTHI3pqySVvtS60UL3onuqjfB9nHauPWfJreQS2k39PKKlR34qW0uUdMfCgntJAlR64yD@vger.kernel.org
X-Gm-Message-State: AOJu0YzBMHn9C2wqA/E7yy5kd4VmC10Zi6PwRAosF0tKzivaLnpP0q18
	ZGoLixNdqImgLquRPLJau9tTB7ji8ttcN5y4JShfuX8Gdu5YlN6lqiQuxPYQWabT2VoWzyks3Tz
	Rf7k6tkUMbiqcevJjJ4SGEpz8s4Ybigg=
X-Received: by 2002:a17:907:c80f:b0:c16:f32:6ca3 with SMTP id
 a640c23a62f3a-c161f36ebb3mr490349366b.46.1783972666876; Mon, 13 Jul 2026
 12:57:46 -0700 (PDT)
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
 <CACePvbWOm3EL6Ph+A_NgAp80GcQt2N-qW1qbyxOVDL3EZSAh8g@mail.gmail.com>
 <CAO9r8zO4uW=SX7se154Z6+DrxfawZfAiRO6Ar5rUm3T78x5HUw@mail.gmail.com> <CACePvbX5oWcTRpQeBCQsod5C5KEhd-0vA4B1PGYddNfgTW2tvA@mail.gmail.com>
In-Reply-To: <CACePvbX5oWcTRpQeBCQsod5C5KEhd-0vA4B1PGYddNfgTW2tvA@mail.gmail.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Mon, 13 Jul 2026 12:57:35 -0700
X-Gmail-Original-Message-ID: <CAO9r8zNjouSvVABM4WhsXu8Uzcbd53gLEK0SXLeDMKJm1PeLJQ@mail.gmail.com>
X-Gm-Features: AVVi8Cc2d5Jy4K-zB3uOZEByCUGAsFCJAB8Scukxi2qhgJNF_HV08DJxXMaC9aw
Message-ID: <CAO9r8zNjouSvVABM4WhsXu8Uzcbd53gLEK0SXLeDMKJm1PeLJQ@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17743-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 177EC74EEC5

On Mon, Jul 13, 2026 at 12:39=E2=80=AFPM Chris Li <chrisl@kernel.org> wrote=
:
>
> On Mon, Jul 13, 2026 at 11:38=E2=80=AFAM Yosry Ahmed <yosry@kernel.org> w=
rote:
> >
> > > > > Zswap will not be introduced as a tier. The existing user interfa=
ce
> > > > > makes zswap not exactly compatible with the tier ordering because=
 it
> > > > > sits in front of every swapfile. If we change that, we break the =
user
> > > > > interface. I suggest we keep zswap working as it is now.
> > > >
> > > > The goal from making zswap a swap tier is to have a single framewor=
k
> > > > to configure swapping for a cgroup, instead of configuring zswap
> > > > separately. Yes, zswap currently sits in front of all swap
> > > > devices/tiers, but we are heading in the direction of changing that
> > > > such that zswap is standalone, at which point it becomes more
> > > > obviously a swap tier. If you want us to wait until that happens
> > > > before adding zswap as a tier, I don't necessarily object, but I wa=
nt
> > > > to make sure that nothing will break if we add zswap as a tier late=
r.
> > >
> > > I'm afraid your zswap user interface will have to break. I don't see =
a
> > > way around breaking your zswap user interface to fit the swap tiering=
.
> > > Once we move to the swap tier world, I don't think we should continue
> > > using zswap.writeback to control the tier write back behavior. We wil=
l
> > > need to rethink this new world.
> >
> > I wasn't talking about the existing zswap interfaces. I want to make
> > sure that if we introduce tiering initially without zswap as a tier,
> > then add zswap as a tier, the semantics of tiering and user-visible
> > zswap behavior doesn't break.
>
> No, the user visible part of zswap must break because zswap currently
> sits in front of every swapfile.
> I don't see any other way around it.

If zswap becomes usable independent from a swapfile, it's mostly
transparent to current users.

> If you do know how zswap can interact with swap.tiers without breaking
> the user interface, make a formal proposal and lay out all the
> details. I did that exercise myself and I my conclusion is that it is
> better to accept zswap is the classic behavior without burdening the
> unified swap tier too much.

Today pages go to zswap, and when the limit is hit they get written
back to a swap device. If zswap is a separate tier, pages will still
go to zswap and then when the limit is hit they get written back to a
swap device. In both cases, zswap writeback can be disabled.

Can you share the findings from your exercise, and why zswap being a
tier is a burden? Any specific examples?

>
> > That being said, the existing zswap interfaces don't have to break
> > with tiering, why do they? We may end up with redundant interfaces,
>
> Because zswap does not have its own swap device, it borrows the swap
> slot from the underlying swap device. That behavior is unique to zswap
> and none of the other swap tiers have that.

Yes, but we are heading in the direction of removing that restriction.
But I also don't see the connection between that and the current
interfaces breaking. Do you have any concrete examples?

>
> > which is unfortunate, and we can work to deprecate some of them over
> > time. But I don't see why we have to break them?
>
> I don't want to special case the zswap for from the swap tiers.

Neither do I, but I fail to see where the special casing is, beyond
the fact that zswap is not a swapfile but an in-memory swap.

> > > > An advantage of adding zswap as a tier right away is the proactive
> > > > writeback use case. It naturally fits in the tiering framework as
> > > > proactive demotion between swap tiers, which I expect may be useful=
 in
> > > > non-zswap use cases as well. Without zswap as a tier, we'll have to
> > > > use a different interface for proactive writeback, and then if/when
> > > > zswap becomes a tier, we'll have multiple ways to do proactive
> > > > writeback which isn't ideal.
> > >
> > > I am looking forward to abstracting a more common write back behavior
> > > in the swap tier world. The classic zswap behavior will be preserved.
> >
> > Right, but this requires zswap being a tier, which you seem to be oppos=
ed to :)
>
> It does not need to as far as I can tell. People who want classic
> zswap can use zswap as it is. I am thinking the swap ops provide some
> interface for classic zswap to use, but zswap itself is not a tier
> because it does not own swap devices.

A swap tier represents a class of swap devices or swap files with
specific characteristics. Zswap satisfies that, although it's not
really a swap device/file.

