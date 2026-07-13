Return-Path: <cgroups+bounces-17741-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iE2jGI4wVWqYlAAAu9opvQ
	(envelope-from <cgroups+bounces-17741-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 20:38:06 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB24674E885
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 20:38:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Z99g5SgR;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17741-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17741-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C1DAA30250A1
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 18:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54366353A72;
	Mon, 13 Jul 2026 18:38:01 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1509343D72
	for <cgroups@vger.kernel.org>; Mon, 13 Jul 2026 18:37:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783967881; cv=none; b=Zbch7gGq/VR66PiaMfnoqIq3hp0gmGp0tCBM6BaIjpjm4xb9x7aOMtFOoFyAgiSDSRcHds2KsCHNludjWlzgLKYBcPTUpj5gWYZftcs5Lu1PBFd/wJfwzQgRIPQZ+bpWyaxqlgRMA7b9pVUGZc0PjvIGqUDAWGwmdaGO1JHMQOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783967881; c=relaxed/simple;
	bh=zu8862SqZ538zojnz2dlrBi5N5x5yHiHFbkXnoXgzXI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o3sHh4KrvD/8dwpfP1GzX6EJk0jrKCvvJVh16Fo3s5ZMqgvCWOHnbzIIAzBEt2niXPueXjVshDNjlu7fVCUqb2uPFYmQtvUURe814/L1LPErq7X7cY3/h5/rekx9BpI+TM1EMXcXdYQEiRbvh/ip8z5Auzads+WBnFvD6SPXnzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z99g5SgR; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66F711F01558
	for <cgroups@vger.kernel.org>; Mon, 13 Jul 2026 18:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783967879;
	bh=zu8862SqZ538zojnz2dlrBi5N5x5yHiHFbkXnoXgzXI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Z99g5SgRQle79CAoNoJHX2Kgt8akKv59y6/jiTGr1vRTDX/Prf4rDu7NB+KQwqleA
	 zROsA1ERgSPivo30vlbtZ3dpf8dK7rVqqdX8VhahKUnL+dOEXn3DfngegAIFqMQWc5
	 KCPMrrLA/5xladWU6+Xm8L42Zktq1VC85nKbb2ENyxmkFF3NS3fnTGmr4afJORto3x
	 /h92bM97eqjwFve93Fo3CdMlOrLaPSSLcd4L7PB4vN0KJVQwagloXJPlk7ZMoUVjUC
	 nDSjT3r9IYAzibmRaOn2xZrLllYZqRIk25oykrsoee41ozJfsPmvdMk5i551HVe0j6
	 /mOAk3BXOvF3g==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c15b33f7b23so496027866b.3
        for <cgroups@vger.kernel.org>; Mon, 13 Jul 2026 11:37:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+hi5o3oj49zDu+9usr9+vayuHKKfLAtfwykxNFnsQ6OuOO8sDygezq9bmzLC4+5mJzmLPuWZzR@vger.kernel.org
X-Gm-Message-State: AOJu0YzwsrGRAOkoBMwaeteoq8RZAhqooTTZzJ4B1YE0b3tTmcba4DBC
	6CTHfjWH4dlvU4Nj8JiSKnUmGhXOkI/uoixQ8vJ1/N/xUl3L2YNSSfMmB37QBhfOnmTwrUduN93
	culb7UyR2qj9nyarIG9nM9+O09An2UvU=
X-Received: by 2002:a17:907:1b1d:b0:c12:8f7c:6157 with SMTP id
 a640c23a62f3a-c161e92de06mr409348166b.8.1783967878291; Mon, 13 Jul 2026
 11:37:58 -0700 (PDT)
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
 <CAO9r8zPtcne97wQKZFsNoMS-4zpTFvaA3EU8ghnEHPfwD28zoQ@mail.gmail.com> <CACePvbWOm3EL6Ph+A_NgAp80GcQt2N-qW1qbyxOVDL3EZSAh8g@mail.gmail.com>
In-Reply-To: <CACePvbWOm3EL6Ph+A_NgAp80GcQt2N-qW1qbyxOVDL3EZSAh8g@mail.gmail.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Mon, 13 Jul 2026 11:37:46 -0700
X-Gmail-Original-Message-ID: <CAO9r8zO4uW=SX7se154Z6+DrxfawZfAiRO6Ar5rUm3T78x5HUw@mail.gmail.com>
X-Gm-Features: AVVi8CcWv8EoLw-Em1Z7wx-Z6siyea0fJELbRRX7-n8iFKarKLOG60WzcrGFVms
Message-ID: <CAO9r8zO4uW=SX7se154Z6+DrxfawZfAiRO6Ar5rUm3T78x5HUw@mail.gmail.com>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17741-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BB24674E885

> > > Zswap will not be introduced as a tier. The existing user interface
> > > makes zswap not exactly compatible with the tier ordering because it
> > > sits in front of every swapfile. If we change that, we break the user
> > > interface. I suggest we keep zswap working as it is now.
> >
> > The goal from making zswap a swap tier is to have a single framework
> > to configure swapping for a cgroup, instead of configuring zswap
> > separately. Yes, zswap currently sits in front of all swap
> > devices/tiers, but we are heading in the direction of changing that
> > such that zswap is standalone, at which point it becomes more
> > obviously a swap tier. If you want us to wait until that happens
> > before adding zswap as a tier, I don't necessarily object, but I want
> > to make sure that nothing will break if we add zswap as a tier later.
>
> I'm afraid your zswap user interface will have to break. I don't see a
> way around breaking your zswap user interface to fit the swap tiering.
> Once we move to the swap tier world, I don't think we should continue
> using zswap.writeback to control the tier write back behavior. We will
> need to rethink this new world.

I wasn't talking about the existing zswap interfaces. I want to make
sure that if we introduce tiering initially without zswap as a tier,
then add zswap as a tier, the semantics of tiering and user-visible
zswap behavior doesn't break.

That being said, the existing zswap interfaces don't have to break
with tiering, why do they? We may end up with redundant interfaces,
which is unfortunate, and we can work to deprecate some of them over
time. But I don't see why we have to break them?

>
> > An advantage of adding zswap as a tier right away is the proactive
> > writeback use case. It naturally fits in the tiering framework as
> > proactive demotion between swap tiers, which I expect may be useful in
> > non-zswap use cases as well. Without zswap as a tier, we'll have to
> > use a different interface for proactive writeback, and then if/when
> > zswap becomes a tier, we'll have multiple ways to do proactive
> > writeback which isn't ideal.
>
> I am looking forward to abstracting a more common write back behavior
> in the swap tier world. The classic zswap behavior will be preserved.

Right, but this requires zswap being a tier, which you seem to be opposed to :)

