Return-Path: <cgroups+bounces-17806-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +hhzHJGhVmpv/QAAu9opvQ
	(envelope-from <cgroups+bounces-17806-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 14 Jul 2026 22:52:33 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7F6758CD9
	for <lists+cgroups@lfdr.de>; Tue, 14 Jul 2026 22:52:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=XY7ZtdEA;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17806-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17806-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 44CEE3003987
	for <lists+cgroups@lfdr.de>; Tue, 14 Jul 2026 20:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0130423E9F;
	Tue, 14 Jul 2026 20:52:28 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A02941B8D5
	for <cgroups@vger.kernel.org>; Tue, 14 Jul 2026 20:52:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784062348; cv=none; b=KWvUMV53A+wC98qpk7zLzbss0ZviM0mWvu9qRyhrgmMBF+9Sr8iIajtpi6s72Vd4OUD0AFMl9CajABT/bbm7tKu1d3hpFTOoReZcpjCY6TyMxkrud5uaMwLMYM9EZg6VD/L57ufKvk2dSE+4d2cI2xVqiJ89691D1LBPDqEK3Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784062348; c=relaxed/simple;
	bh=iTqi3alAZsmClmkp2BKQHhwiYigUfhN2a2XtbcHcncw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uSC6l2CwIP6PIeMRqbfrAMvNz+UVHEZanCqUKvZrCiBd7gin5HYFRgAe7/HSSu+dccRffTBXNcHg09kK6EUbVcaJULCSmHWmxzAhKEgtjrBtYhlGqQWs+rlc1pSbgRGETL+ray/OTfh6qq7U9PEbqQwEJFiTT4SoDbz70x7cTj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XY7ZtdEA; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 198D31F00AC4
	for <cgroups@vger.kernel.org>; Tue, 14 Jul 2026 20:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784062347;
	bh=iTqi3alAZsmClmkp2BKQHhwiYigUfhN2a2XtbcHcncw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=XY7ZtdEAVFbxCI7QQAcbEjM7qqoP8kGq8QP9vyYXECk0bx0VkVcmSFGdFa3wlTCSy
	 pUOT0uNjaFtpuiqaEgzYypOwsRT4VtbgJhmZVFf3sUkdbOd6SiicfGMi6yykElsABi
	 HGBKH32DqwY+d+WVYC96wcFrF9OvTxg7dMQUQqMWzObnfTWeulJOKgnadupX/oz/wh
	 QpwTjikWAXvrtv9X0DgaqkqW7kpnvkB6ZEKV12wqVMo5vhLWhYlo0eP9ZXYBKaLpoZ
	 dDs11Glv5UgViTNR/JuP1lqEfbd3dmMxy2r9mMy+stNLrRYMhUY+c5ToASWHzxTWMe
	 Q6t6f4djJxPqA==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-69531108f25so7783425a12.2
        for <cgroups@vger.kernel.org>; Tue, 14 Jul 2026 13:52:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqBfVc+avujuzkGVu2LQ65KClwK3gahqPeJ/7GARDdkon4w+DaQVzbzCYOH9EGAeh5AxcQhVwYF@vger.kernel.org
X-Gm-Message-State: AOJu0YwC3iMwoKyfazuznDfLJ1ESTLW+QyTPLyIXfSJCTQWLaLCYAkD3
	bCx7+K8FBD04/rKPH933k5fZK2YnRmnLPqBRgPMuKybcEAme44lMKHHMYos/nLlra6CxUfhyQVE
	Xx5A6gcNxEHNJxNiDDyrJ3Kt9rCBRVE0=
X-Received: by 2002:a17:906:9fce:b0:c12:34ec:ad1c with SMTP id
 a640c23a62f3a-c1679367183mr21088566b.56.1784062345755; Tue, 14 Jul 2026
 13:52:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260713025644.170839-1-youngjun.park@lge.com>
 <CAO9r8zNJfhirbzvJzDWRaBQOM7XZcf_Jk0Bz=Y4dB4QK4W-MwQ@mail.gmail.com>
 <alUK8DWRy4LPxTpY@yjaykim-PowerEdge-T330> <CAO9r8zPvWKgQ8+ABxSnVnC452-enyMqCjBTA4pfNDVxsoJr25g@mail.gmail.com>
 <alUQ0ksPP00PVwew@yjaykim-PowerEdge-T330> <alae-LIRwEFUjgs1@linux.dev>
In-Reply-To: <alae-LIRwEFUjgs1@linux.dev>
From: Yosry Ahmed <yosry@kernel.org>
Date: Tue, 14 Jul 2026 13:52:14 -0700
X-Gmail-Original-Message-ID: <CAO9r8zNfp-T19cYyZxKHBY-FnmQ_9=fbP4JYPPFgYtUCo5fZyg@mail.gmail.com>
X-Gm-Features: AUfX_mzvYPO0I-kzUXbogAiHLzr_xtUWxhzL5KSspLm9Ule6jCBXezY4eupVLjk
Message-ID: <CAO9r8zNfp-T19cYyZxKHBY-FnmQ_9=fbP4JYPPFgYtUCo5fZyg@mail.gmail.com>
Subject: Re: [PATCH v10 0/6] mm/swap, memcg: Introduce swap tiers for cgroup
 based swap control
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Youngjun Park <youngjun.park@lge.com>, akpm@linux-foundation.org, chrisl@kernel.org, 
	linux-mm@kvack.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kasong@tencent.com, hannes@cmpxchg.org, mhocko@kernel.org, 
	roman.gushchin@linux.dev, muchun.song@linux.dev, shikemeng@huaweicloud.com, 
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17806-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:shakeel.butt@linux.dev,m:youngjun.park@lge.com,m:akpm@linux-foundation.org,m:chrisl@kernel.org,m:linux-mm@kvack.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:kasong@tencent.com,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:muchun.song@linux.dev,m:shikemeng@huaweicloud.com,m:baoquan.he@linux.dev,m:baohua@kernel.org,m:joshua.hahnjy@gmail.com,m:gunho.lee@lge.com,m:taejoon.song@lge.com,m:hyungjun.cho@lge.com,m:baver.bae@lge.com,m:her0gyugyu@gmail.com,m:joshuahahnjy@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[yosry@kernel.org,cgroups@vger.kernel.org];
	FREEMAIL_CC(0.00)[lge.com,linux-foundation.org,kernel.org,kvack.org,vger.kernel.org,tencent.com,cmpxchg.org,linux.dev,huaweicloud.com,gmail.com];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EF7F6758CD9

> > > >
> > > > Hello Yosry!
> > > >
> > > > This series does not cover zswap as a tier yet.
> > > >
> > > > My plan is to land the swap tier infrastructure together with the
> > > > first use case (cgroup-based swap control) first, and then follow
> > > > up with zswap tier support in a subsequent series, continuing the
> > > > discussions we've had above.
> > > > (I mentioned on cover letter, right above the overview section)
> > > >
> > > > Does that approach sound reasonable to you?
> > >
> > > How does swap tiering work with zswap in the current series? I assume
> > > zswap is just enabled for all devices in all tiers?
> >
> > Yes, that's correct.
> >
> > > I wonder if introducing zswap as a tier after the fact changes user-visible
> > > behavior. I guess if zswap will be introduced with a default "max"
> > > value it will more-or-less be the same behavior,
> >
> > Right, that's the plan.
> >
> > > but I would check all
> > > user-visible behaviors related to zswap (e.g. interaction with other
> > > zswap interfaces) to make sure nothing breaks or changes in a
> > > meaningful way when zswap is introduced as a tier later.
> >
> > Fair point. Let me review this more and get back to you!
>
> Please do report back what you find.
>
> Yosry, what is needed to enable zswap as a swap tier? What will be the minimum
> requirements for that?

From zswap's perspective, we just need to skip zswap is zswap as a
tier is disallowed. Could just be a check in zswap_store() similar to
the check if zswap is enabled. I am assuming that if a swap tier is
disabled, nothing happens to the existing swapped out pages in this
tier, but new pages do not get swapped out to it. This is the same
behavior that happens if zswap is disabled at runtime.

From the tiering perspective, we need to accept "zswap" as a possible
tier, or maybe creating it as a tier by default if zswap is configured
would be better to avoid handling the case where the user doesn't
create a tier for zswap. We also need to disallow zswap being the only
tier as that combination cannot work without vswap.

I think this should be enough to support "zswap" as a tier and allow
disabling/enabling zswap per-memcg (or globally?) through tiering.

In the future, if/when swap demotion is added, we need to figure out
how that would work with zswap. For example, if pages should go to
swap device A then swap device B, then an entry in zswap using a swap
slot in device B should not skip device A and be written back directly
to B. vswap would naturally give us a solution for this problem.

> If that is not too much, we can make that part of this series.

Yeah I think it's better if we agree on the design and zswap support
before landing partial support.

