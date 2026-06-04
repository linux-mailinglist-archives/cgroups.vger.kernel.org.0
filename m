Return-Path: <cgroups+bounces-16649-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +PEUHZylIWpTKgEAu9opvQ
	(envelope-from <cgroups+bounces-16649-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 04 Jun 2026 18:19:40 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31860641C74
	for <lists+cgroups@lfdr.de>; Thu, 04 Jun 2026 18:19:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=MEq5dlFI;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16649-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16649-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 608EF30C7F35
	for <lists+cgroups@lfdr.de>; Thu,  4 Jun 2026 16:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE483EDACB;
	Thu,  4 Jun 2026 16:10:17 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B923CAA2F
	for <cgroups@vger.kernel.org>; Thu,  4 Jun 2026 16:10:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780589417; cv=none; b=m1SomFB09tPLG8EyWDNfTUtx0AkrLDcDK/zHjIHNNdCReml65zupE7WKXgGWGkB2u/oZL1MHyzbO3v6mhZrhzkq7OuGlgdxzrR8kYVa3W6aKdAWjm20GvSXyBlFBSSnbRSslBP3a9HaKOV8ra/lAPeBRfWe8B3Ui4/NHdrFHdwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780589417; c=relaxed/simple;
	bh=dkqfCMrLmXYKCpzoo4wiIUki7SDk/LrZwiKaXXZvcDw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k9qdPGWnIsehaZqdTcmYFOiUHmi4JfoahwsGD9EEBroP1zqAwIQs0fJ9bcfMaRGz+1KhIcFGd3S3LKEs7CcTrQIP5x8Zh6oEAs/+UU3Dc6SIoFuJoiVHIaAfaAqQkvTx+3YGC9zEJsEsUtLr+a0GigjKpqMbYR/l/vuq1eVV4w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MEq5dlFI; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C08031F0089F
	for <cgroups@vger.kernel.org>; Thu,  4 Jun 2026 16:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780589415;
	bh=YW7V6VQa29YjcMSrmd42lxjY3Q5BWm+8nU4PiEtSpss=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=MEq5dlFIJfV2cj25Gy5Iphar+8EB3Q+M++ma3ddkZ79VItR+ZvWCy5GquLxnOwLVT
	 J0TvzAcGjl7Z1/O41TXXKHBFelMg54n3BTGq2Q9EZgUNoAihogBT0qG+6UYmqVnx2H
	 Mu7raqFZSeIZhtTt2+xGRdXmofZV6p0dcICRAwft3WVZmbtnX+2V2U5eRc3gWEeD0u
	 Lg5SEKkRDUZMSEKAkIxpE3/03WJK7VloDAFzWaehmiYDKu9IZw5eqQFmuC9/jPXudl
	 Pqvz5HUrco5yx9+lUkOI41JCLlWsJ1Flg08a2vxZpM9oXrMH5s7EcHnoJFSDpt2rW1
	 X/t1zmDjUd3fg==
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-9159951f05aso109425485a.0
        for <cgroups@vger.kernel.org>; Thu, 04 Jun 2026 09:10:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9COYaNUX3QZZFqv9ZCeGXwJEGMnHcS1By0p6Q5m0N5JxciTjVgmTNLdyvNTGuKPTXy1BOa9kXp@vger.kernel.org
X-Gm-Message-State: AOJu0YwbLpmI6wRsp1R958IZDzaVBM9DUxHqy7boThymekmP1+1H+FsR
	DyCfgJWjs8Y5HQhGAskASa31eJluLu1iHQlHQikL/xfa8iFvY/Wq+z1UDVppqllbUCI+YojrnIC
	oGKa2WRhjyLZ4mWFaP9231JmjHS868f0=
X-Received: by 2002:a05:620a:a181:10b0:914:ca75:e8cb with SMTP id
 af79cd13be357-9158a7a7d31mr980372885a.39.1780589414974; Thu, 04 Jun 2026
 09:10:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526114601.67041-1-jiahao.kernel@gmail.com>
 <20260526114601.67041-2-jiahao.kernel@gmail.com> <aho7nepN5jZtKmef@google.com>
 <8c0e60e1-5713-69f0-a687-088c87e75764@gmail.com> <ah4ZZGl7GYJf54Wz@google.com>
 <ff344c9f-51da-8b3a-e7a9-c4a7f4702ef8@gmail.com> <ah9i3uhh3PFiS0Uk@google.com>
 <c7870fe2-3588-79db-cbfb-bd6a2b78f594@gmail.com> <aiBpibRNi0BcM1Zu@google.com>
 <9898f83d-fae9-e284-6b85-c7f4089840a0@gmail.com> <CAO9r8zPBH6-0SQ6-_ZOhTQeyu=rz4F=ugikCrU-JR_skm6fEWA@mail.gmail.com>
 <a60eedb6-f3fd-4092-b726-04a17a695ace@gmail.com>
In-Reply-To: <a60eedb6-f3fd-4092-b726-04a17a695ace@gmail.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Thu, 4 Jun 2026 09:10:01 -0700
X-Gmail-Original-Message-ID: <CAO9r8zMydJfQ+28OQkPYyH1yHngxYCNByo-4hu=D2eoJBtTX-Q@mail.gmail.com>
X-Gm-Features: AVHnY4JkU6wiALPrkeGY5YeF8-NFodHMhfIp-dzt841kR4__pG_M4xsJghd5PrI
Message-ID: <CAO9r8zMydJfQ+28OQkPYyH1yHngxYCNByo-4hu=D2eoJBtTX-Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] mm/zswap: Make shrink_worker writeback cursor per-memcg
To: Hao Jia <jiahao.kernel@gmail.com>
Cc: akpm@linux-foundation.org, tj@kernel.org, hannes@cmpxchg.org, 
	shakeel.butt@linux.dev, mhocko@kernel.org, mkoutny@suse.com, 
	nphamcs@gmail.com, chengming.zhou@linux.dev, muchun.song@linux.dev, 
	roman.gushchin@linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	Hao Jia <jiahao1@lixiang.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16649-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jiahao.kernel@gmail.com,m:akpm@linux-foundation.org,m:tj@kernel.org,m:hannes@cmpxchg.org,m:shakeel.butt@linux.dev,m:mhocko@kernel.org,m:mkoutny@suse.com,m:nphamcs@gmail.com,m:chengming.zhou@linux.dev,m:muchun.song@linux.dev,m:roman.gushchin@linux.dev,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:jiahao1@lixiang.com,m:jiahaokernel@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[yosry@kernel.org,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,cmpxchg.org,linux.dev,suse.com,gmail.com,vger.kernel.org,kvack.org,lixiang.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
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
X-Rspamd-Queue-Id: 31860641C74

On Thu, Jun 4, 2026 at 6:06=E2=80=AFAM Hao Jia <jiahao.kernel@gmail.com> wr=
ote:
>
>
>
> On 2026/6/4 13:34, Yosry Ahmed wrote:
> >>>> For instance, suppose a parent memcg has two children, memcg1 and me=
mcg2,
> >>>> each with 200MB of zswap (100MB inactive). Triggering proactive writ=
eback on
> >>>> the parent memcg will exhaust memcg1's inactive zswap pages. After t=
hat,
> >>>> even though memcg2 still has plenty of inactive zswap pages, it will
> >>>> continue to write back memcg1's active zswap pages. Writing back act=
ive
> >>>> zswap pages causes the user-space agent to prematurely abort the wri=
teback
> >>>> because it detects that certain memcg metrics have exceeded predefin=
ed
> >>>> thresholds.
> >>>
> >>> This will only happen if the reclaim size is smaller than the batch
> >>> size, right? Otherwise the kernel should reclaim more or less equally
> >>> from both memcgs?
> >>>
> >>
> >> I gave it some thought. Not using a cursor could lead to unfairness
> >> issues with certain writeback sizes:
> >>
> >>    - If the writeback size is an odd multiple of WB_BATCH (e.g.,
> >> triggering a writeback of 3 * WB_BATCH), with 2 child cgroups, the
> >> writeback ratio might end up being 2:1.
> >>    - If a memcg has 5 child cgroups and a writeback of 2 * WB_BATCH is
> >> triggered, it might repeatedly write back from only the first 2 child
> >> cgroups.
> >>
> >> Although setting a smaller WB_BATCH might mitigate this unfairness, it
> >> could hurt writeback efficiency. Let's just use per-memcg cursors to
> >> completely fix these corner cases.
> >
> > Exactly, the batch size should be small enough that any unfairness is
> > not a problem. I would honestly just do batching without a per-memcg
> > cursor, unless we have numbers to prove that the efficiency is
> > affected when we use a small batch size. Let's only introduce
> > complexity when needed please.
>
>
> If you prefer not to use per-cgroup cursors, do we still need to keep
> the global cursor (i.e., the root cgroup's cursor) zswap_next_shrink?
> I found this part to be quite tricky when trying to reuse the main logic
> of shrink_worker() in zswap_proactive_writeback().
>
> Of course, I think we could also keep zswap_next_shrink and write a
> small helper to check if it's the root cgroup, allowing us to use
> different memcg iteration methods.

I think we want to keep the global cursor, at least for now.

