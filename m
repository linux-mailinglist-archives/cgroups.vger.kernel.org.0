Return-Path: <cgroups+bounces-17745-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id A8hVDYtdVWq3nQAAu9opvQ
	(envelope-from <cgroups+bounces-17745-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 23:50:03 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 708A674F59B
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 23:50:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=X8nWQ7y5;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17745-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17745-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1DDC303205C
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 21:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23E335E943;
	Mon, 13 Jul 2026 21:49:58 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9ED33242B2
	for <cgroups@vger.kernel.org>; Mon, 13 Jul 2026 21:49:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783979398; cv=none; b=nPzllKmx0MlRO3TCO2xaRFjmb2h3WOxtv+97SqDy6RjiJ8aA1fwH7fzPWVzAFitbLayNFbb4UFN9OGjGGFUIXEYMgQR3Fz7OaBURymWdt5DGlfLQjWtgPcwncCXG0txCdiU6momtnURDbmNuwfzFpzGj+na/iNqfNfb2o6o1DtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783979398; c=relaxed/simple;
	bh=f1LxEGkWwF9grkI8B8e3VnBbGRWm0GD+OzdbQnvtfqI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p6rsK8ziVmwaf9kX9XXyztDPpXkMhIY+kVkqibNUdkYRGy6dCF8Rjau6uLY1jXk6ymUQaAGlPLUfvoJKKNf3PDJseeRAm/RfLCjTVzmgLEqBTNkJbbAhaKKGh8+y4alpMHwKGfutwrRbNaj7BIv60FaIEU4Sked5fOaPn0E9X+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X8nWQ7y5; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 406731F00ADE
	for <cgroups@vger.kernel.org>; Mon, 13 Jul 2026 21:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783979397;
	bh=f1LxEGkWwF9grkI8B8e3VnBbGRWm0GD+OzdbQnvtfqI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=X8nWQ7y51HrTb42UThg5sBmCbyDPvW2uM17JjqpIzQAPLLo9RkBnqo2/nkqEOwGkX
	 /drhjE0T7HZSQKyMq3GZpvck76THY27FIivyQNmqfBnWQTPZnJeIFumaNo5W9pqwMn
	 vKIrQPxYjH8uV10B/jGtubq64HVCq6bpnoFtlnLke/6aQzRNxCaS4+fS5Tvv0vx9SJ
	 TsHpEbboml+XLb5VJ2dGRsLOgs4SiNYpKYBI7wcon2myV7wZDme6lpF0P0FHF+M8RM
	 +WLQVH4qzMaFUSi0qr9nKXH4GYL46+FZjbq4sctjl/OkeMR1BENj3q3MENbxeJwi76
	 Y2tGcOMrgo4Xw==
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-664d4478a64so4716396d50.3
        for <cgroups@vger.kernel.org>; Mon, 13 Jul 2026 14:49:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Ro29uB2ZMt5/FznHt77Hf1RPUz393orabda4M64SpirqdlOfbkasOLxc5G9Lzs4A6xwXZYeo54l@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq3xJtqT+a6lMbeneJEVYy7Z3wTb6gyOsFqpLadZjgVxXH+yY8
	3yq4cu7Z3k6KAj2HpHhkbtzkyqD/GwZkOSGAD0idtcD/AH/29rJCIv7cvOhFysuRuNM4KJ2ZGWm
	o8+cY7LjUkC0NXDXjqRgHfTH4i2S+IozLfGRq3FHVVg==
X-Received: by 2002:a05:690e:4803:b0:667:83ad:b3e6 with SMTP id
 956f58d0204a3-667d7a949e5mr5088170d50.16.1783979396512; Mon, 13 Jul 2026
 14:49:56 -0700 (PDT)
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
 <CAO9r8zO4uW=SX7se154Z6+DrxfawZfAiRO6Ar5rUm3T78x5HUw@mail.gmail.com>
 <CACePvbX5oWcTRpQeBCQsod5C5KEhd-0vA4B1PGYddNfgTW2tvA@mail.gmail.com> <CAO9r8zNjouSvVABM4WhsXu8Uzcbd53gLEK0SXLeDMKJm1PeLJQ@mail.gmail.com>
In-Reply-To: <CAO9r8zNjouSvVABM4WhsXu8Uzcbd53gLEK0SXLeDMKJm1PeLJQ@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Mon, 13 Jul 2026 14:49:45 -0700
X-Gmail-Original-Message-ID: <CACePvbXt+6R3BcTZWnU=xgqUx0Jmhv8tOKASwhmBSYR_qHYgcA@mail.gmail.com>
X-Gm-Features: AVVi8Cdmy5FSejRgCuCwudbpOr1s_-ZdmoYi1-fyB3Ixs9dQBg7EENWp7B5cyCU
Message-ID: <CACePvbXt+6R3BcTZWnU=xgqUx0Jmhv8tOKASwhmBSYR_qHYgcA@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17745-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 708A674F59B

On Mon, Jul 13, 2026 at 12:57=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wro=
te:
>
> On Mon, Jul 13, 2026 at 12:39=E2=80=AFPM Chris Li <chrisl@kernel.org> wro=
te:
> >
> > On Mon, Jul 13, 2026 at 11:38=E2=80=AFAM Yosry Ahmed <yosry@kernel.org>=
 wrote:
> > >
> > > > > > Zswap will not be introduced as a tier. The existing user inter=
face
> > > > > > makes zswap not exactly compatible with the tier ordering becau=
se it
> > > > > > sits in front of every swapfile. If we change that, we break th=
e user
> > > > > > interface. I suggest we keep zswap working as it is now.
> > > > >
> > > > > The goal from making zswap a swap tier is to have a single framew=
ork
> > > > > to configure swapping for a cgroup, instead of configuring zswap
> > > > > separately. Yes, zswap currently sits in front of all swap
> > > > > devices/tiers, but we are heading in the direction of changing th=
at
> > > > > such that zswap is standalone, at which point it becomes more
> > > > > obviously a swap tier. If you want us to wait until that happens
> > > > > before adding zswap as a tier, I don't necessarily object, but I =
want
> > > > > to make sure that nothing will break if we add zswap as a tier la=
ter.
> > > >
> > > > I'm afraid your zswap user interface will have to break. I don't se=
e a
> > > > way around breaking your zswap user interface to fit the swap tieri=
ng.
> > > > Once we move to the swap tier world, I don't think we should contin=
ue
> > > > using zswap.writeback to control the tier write back behavior. We w=
ill
> > > > need to rethink this new world.
> > >
> > > I wasn't talking about the existing zswap interfaces. I want to make
> > > sure that if we introduce tiering initially without zswap as a tier,
> > > then add zswap as a tier, the semantics of tiering and user-visible
> > > zswap behavior doesn't break.
> >
> > No, the user visible part of zswap must break because zswap currently
> > sits in front of every swapfile.
> > I don't see any other way around it.
>
> If zswap becomes usable independent from a swapfile, it's mostly
> transparent to current users.
>
> > If you do know how zswap can interact with swap.tiers without breaking
> > the user interface, make a formal proposal and lay out all the
> > details. I did that exercise myself and I my conclusion is that it is
> > better to accept zswap is the classic behavior without burdening the
> > unified swap tier too much.
>
> Today pages go to zswap, and when the limit is hit they get written
> back to a swap device. If zswap is a separate tier, pages will still
> go to zswap and then when the limit is hit they get written back to a
> swap device. In both cases, zswap writeback can be disabled.
>
> Can you share the findings from your exercise, and why zswap being a
> tier is a burden? Any specific examples?

It is all good when you have only zswap and just one other tier of swap dev=
ice.
As soon as you add one more, e.g. zswap -> SSD -> HDD will make things
complicate when zswap using the HDD slot write back direclty to HDD.
Anyway, I find that this kind of highlevel hand waving discussion of
pros and cons usually doesn't produce the useful outcome. If you have
a detailed solution for how zswap works with multiple layers of swap
tiers, Laying out all the details and even better, providing some
incremental patches, is the better way to proceed.

> > > That being said, the existing zswap interfaces don't have to break
> > > with tiering, why do they? We may end up with redundant interfaces,
> >
> > Because zswap does not have its own swap device, it borrows the swap
> > slot from the underlying swap device. That behavior is unique to zswap
> > and none of the other swap tiers have that.
>
> Yes, but we are heading in the direction of removing that restriction.
> But I also don't see the connection between that and the current
> interfaces breaking. Do you have any concrete examples?

See above. This topic has already seen a lot of heated discussion.
Show me an incrementally mergeable patch; that would be a better way
to move forward.

Chris

