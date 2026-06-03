Return-Path: <cgroups+bounces-16622-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IB+TMfF1IGoP3wAAu9opvQ
	(envelope-from <cgroups+bounces-16622-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 03 Jun 2026 20:44:01 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D20FC63A9DF
	for <lists+cgroups@lfdr.de>; Wed, 03 Jun 2026 20:44:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="hcolFb/j";
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16622-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16622-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4B48D30136FD
	for <lists+cgroups@lfdr.de>; Wed,  3 Jun 2026 18:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813453F7893;
	Wed,  3 Jun 2026 18:43:35 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3AD390C9F
	for <cgroups@vger.kernel.org>; Wed,  3 Jun 2026 18:43:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780512215; cv=none; b=eTLuLpCP9yC3b0BRnR/VSoPM8+LJvD9+kGZ5uNS2FVkXCyls2Z0Yor8QLHNzxv2cIiTMUm5S1hxS1irOfqMQD88BJujdl25MAOwgK+81TIY5D7BETsYriuPo2Meg6TF2FNvp2Erz9c2FZD+GDHIOVBD/93dG9ru13kXDyqUefvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780512215; c=relaxed/simple;
	bh=hNMhTQc3uI5KUEB3GMgM5Dct8sn5Zh6rkUEqC1LLPWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ub2s9v+Or2JYrLbZxvhqKAANkXSMZErewX9lzJrcmASVWhkAsYr97O6uclU6xlRnFXJFyE3DyQghbkWT/+nWEvroIvwvJJwxR/vDIgORTp4ZVbzpDvGsGyW8p2+gs89HSijZI6nxC6zI50EnKtppFGNcqvkl+HcoOqVRgxKg52Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hcolFb/j; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 155D91F0089F
	for <cgroups@vger.kernel.org>; Wed,  3 Jun 2026 18:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780512214;
	bh=hNMhTQc3uI5KUEB3GMgM5Dct8sn5Zh6rkUEqC1LLPWo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=hcolFb/jr17Z2lfua37EKO2xRcordkRgNDFxnaaHzUYTF30dMKZHlXT2KnbuFTTg2
	 zQcFTeoQAgxoWPLR7xEa2UpS57fkaYYA2ZAnw9p5v2aALlFBnH3DCsv3X7yYETpZYY
	 49yIJrhaykvA1YoEI4cnblF2ktgzqjswHl5sEshek9WZP9wBAhdhBupjc1CpbRyXC4
	 aNFiSJLTNq/MpMkBqYYrzmW6kd5an08kvoMQHlhNvD61cCe35Hy+jdTmpahLq5BjJ4
	 16lVka8A7Fg6zfpzMqUMJAYBMCHko1GPpcIoL5GXMX0fBbHKDDtaMEz3QN68pUTM4k
	 Uvd7OHB6huhYQ==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-bf0170c80f7so337001366b.3
        for <cgroups@vger.kernel.org>; Wed, 03 Jun 2026 11:43:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+yJ1xEzgSHb5AoS9rv2dwbUNGdLRbEob1nG0TVCuuAhmaWWrQLIYt7km02ltMRmbG3EA1hrsDj@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4SsKlfuzrfFtTdY8wl8e4BG1KLqpaCBQ0OB5zefwHjl33HmXQ
	+DW0Xa+HcpVl69303PA7kWDMJ458tXff97qlgd2OCpM2opS1WSWqPmhL30FVS4iPjCwjBncmlfu
	jTMwX66RAHS+XbI2jIJYm+b7MtNLdB3c=
X-Received: by 2002:a17:907:7203:b0:bed:a7d7:82c8 with SMTP id
 a640c23a62f3a-bf0af002cd9mr261639966b.37.1780512213033; Wed, 03 Jun 2026
 11:43:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526114601.67041-1-jiahao.kernel@gmail.com>
 <20260526114601.67041-3-jiahao.kernel@gmail.com> <aho-Z6wshceTAYd9@google.com>
 <ea2c1323-1440-e927-f14a-0eac54a245bf@gmail.com> <CAKEwX=PoBZ4ci30tKHQXs1o9=NDpPrtbe7RxxZTbnzVJf74ZYQ@mail.gmail.com>
 <CAO9r8zMBUMXy_bkeT8z+M=dXayU=6VGEw+-HmfDWR2fyJy=z+A@mail.gmail.com> <CAKEwX=NQUqqrM9vdYE2KhWEZx-YwPc7YPhfz7xaBrGVDf824bA@mail.gmail.com>
In-Reply-To: <CAKEwX=NQUqqrM9vdYE2KhWEZx-YwPc7YPhfz7xaBrGVDf824bA@mail.gmail.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Wed, 3 Jun 2026 11:43:21 -0700
X-Gmail-Original-Message-ID: <CAO9r8zO0GjTeY2+j_AjfTQ8qYOmHezZAV44f=aPgrjJcdtO9rQ@mail.gmail.com>
X-Gm-Features: AVHnY4J_T8SUJQ7bZrxF3cMA-0m0a9pPaiFo49afplD4fl7V8MHhy2NRIiywKjM
Message-ID: <CAO9r8zO0GjTeY2+j_AjfTQ8qYOmHezZAV44f=aPgrjJcdtO9rQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] mm/zswap: Implement proactive writeback
To: Nhat Pham <nphamcs@gmail.com>
Cc: Hao Jia <jiahao.kernel@gmail.com>, akpm@linux-foundation.org, tj@kernel.org, 
	hannes@cmpxchg.org, shakeel.butt@linux.dev, mhocko@kernel.org, 
	mkoutny@suse.com, chengming.zhou@linux.dev, muchun.song@linux.dev, 
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-16622-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:nphamcs@gmail.com,m:jiahao.kernel@gmail.com,m:akpm@linux-foundation.org,m:tj@kernel.org,m:hannes@cmpxchg.org,m:shakeel.butt@linux.dev,m:mhocko@kernel.org,m:mkoutny@suse.com,m:chengming.zhou@linux.dev,m:muchun.song@linux.dev,m:roman.gushchin@linux.dev,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:jiahao1@lixiang.com,m:jiahaokernel@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[yosry@kernel.org,cgroups@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,linux-foundation.org,kernel.org,cmpxchg.org,linux.dev,suse.com,vger.kernel.org,kvack.org,lixiang.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yosry@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D20FC63A9DF

On Wed, Jun 3, 2026 at 11:34=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
> On Wed, Jun 3, 2026 at 11:26=E2=80=AFAM Yosry Ahmed <yosry@kernel.org> wr=
ote:
> >
> > > > > Is the main difference that we are scanning in batches here? I th=
ink we
> > > > > can have shrink_memcg() do that too. If anything, it might make t=
he
> > > > > shrinker more efficient. Over-reclaim is ofc a concern, and espec=
ially
> > > > > in the zswap_store() path as the overhead can be noticeable. Mayb=
e we
> > > > > can parameterize the batch size based on the code path.
> > > > >
> > > > > Nhat, what do you think?
> > > >
> > > > Nhat, since we now have the referenced-based second chance algorith=
m,
> > > > should we consider doing batch writeback for shrink_memcg() as well=
?
> > >
> > > I just take a look at shrink_memcg() and realized it's reclaiming one
> > > page at a time. Thanks for the reminder - I hated it.
> > >
> > > Please batchify it if it makes your life easier :) We don't reclaim
> > > "just one page/object" anywhere else in the reclaim path, Sure, it
> > > adds a bit of latency to zswap_store() if we reached cgroup limit, bu=
t
> > > IMHO if we hit zswap.max limit at zswap_store() time, that is already
> > > the slowest of slow path that you should have avoided with proactive
> > > reclaim/zswap shrinker in the first place. And, setting zswap.max doe=
s
> > > not make sense to me in the first place (I can write a whole essay
> > > about it).
> >
> > Should we batchify shrink_memcg() from the shrinker and background
> > writeback, but leave the synchronous zswap_store() path to reclaim one
> > page for this series at least to avoid potential regressions?
> >
> > I think this change specifically needs more intensive testing (vs the
> > other code paths).
>
> I'm fine with having shrink_memcg() takes a batch_size argument for now :=
)
>
> I suspect not a lot of people invokes the shrink_memcg() synchronous
> path in zswap store though. Setting zswap.max is hard (as it involves
> guessing compression ratio ahead of time) and induces quite a bit of
> overhead (obj_cgroup_may_zswap() does a force flush for every store if
> you set zswap.max to a value other than 0 and max).

Yeah I agree, but I just wanna make sure we don't completely kill
performance in case anyone is actually doing that.

Regarding the force flush, it's unfortunate that we need to rely on a
stat for internal limit checking. It might make sense to use page
counters here, which already support hierarchical charging and
whatnot. We'll need something similar to the objcg approach to charge
sub-pages (or maybe just reuse that somehow?).

