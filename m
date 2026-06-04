Return-Path: <cgroups+bounces-16635-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AsYbL+oPIWoo+wAAu9opvQ
	(envelope-from <cgroups+bounces-16635-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 04 Jun 2026 07:40:58 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5FA63D0C2
	for <lists+cgroups@lfdr.de>; Thu, 04 Jun 2026 07:40:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=IxW4QK6l;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16635-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-16635-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD434304BD81
	for <lists+cgroups@lfdr.de>; Thu,  4 Jun 2026 05:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2381E3C09ED;
	Thu,  4 Jun 2026 05:34:32 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0175538886F
	for <cgroups@vger.kernel.org>; Thu,  4 Jun 2026 05:34:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780551271; cv=none; b=NiDsidR+mDCkyYh5JHY4AwY/nsTmPBJWJtue50L3OZwSL2b4G9NLVooubxeG+Vtc9yHzYsnEp2ZciHkUnPEQoCazGFCzyf2qeiKrRyejZnBL6TQo+UTnkIWYAXh3Z4WsJ/COtgEVVdTkDtE+A13MXguWJfd6ir7cklnV0jeFeMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780551271; c=relaxed/simple;
	bh=qCgaAA//Qi8esUuIw4UZ1rzbubx/43eTgcseHb0d6Bk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tqHkp29LwAxOkB29ulB9lHRkrvRAK+F0Hj6ACe0juAyHB2cqSTF+2HR5kZ8moqT5xRFb9z+JHDJZspHZtzAx4D2sunLyEIoOV7Lh/ZMHuyo9A6EH7gPoD4P2506Bpcd0bdWxjaqPXUKqvl2Xtwgl1U6m2tnR1P1t6fj4Nzs+Blw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IxW4QK6l; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA0A11F0089A
	for <cgroups@vger.kernel.org>; Thu,  4 Jun 2026 05:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780551270;
	bh=dBjgi3h65nFOda/5nltf0/WjlV3uis7HxPyve8TgC1A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=IxW4QK6ls26ShtfRGvRr2x2HcKcyVcz1DPWUOMq1tHyNNvLdnaBWG/e5h3c4wvy99
	 KSF+Sf1Z+1gfhGpMUHohUTifmkOUeu+bx/Fa17b+Gp0SbL2jCMde1RGLp1EOb6vkG/
	 yrca4otWvs1k3I9lBeifqV46S5F87O8j0GRzQjFJ5pp39tcAcxRhCRtI6xE/Vy7PfF
	 lJM04L/X7ll7kEf5wItZH82axyFQ/o6YeQ4RflDEkLzXfLuhQbk7paIBrPixNaC2Lb
	 ei2uav4+KTiqZs+xiWrzD2fC9p00Ch6ihJaa5FTiKcOb3mGC5f6sDiKwRty7Iqp7pU
	 epc8D2iBZwMyg==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-beb8a08a6c8so33062166b.2
        for <cgroups@vger.kernel.org>; Wed, 03 Jun 2026 22:34:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ91RilvV4tyF7Mh/jCnJirLk8+fK0+0QmQ58jt5I2KvTvJm7wLjRopUKqM2lgDiejk/amqLDpqG@vger.kernel.org
X-Gm-Message-State: AOJu0YzN+vJxytRKVMXpj/wcbrEHFaQXCNgxYNFiCC6u3S0nr7sUCla+
	wuGiTXflivD7q8VQM19K7Z/7t7toM0zNudOm3WaHW65jp9bYUFFRq4TSBqn7GO4wxZ59BnyZ54G
	Cs+EUZAIl8t5D/yupp1bNnjPTc5p7U44=
X-Received: by 2002:a17:907:7f9e:b0:bec:2d9f:2aa7 with SMTP id
 a640c23a62f3a-bf0b2bd07edmr353177466b.24.1780551269748; Wed, 03 Jun 2026
 22:34:29 -0700 (PDT)
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
 <9898f83d-fae9-e284-6b85-c7f4089840a0@gmail.com>
In-Reply-To: <9898f83d-fae9-e284-6b85-c7f4089840a0@gmail.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Wed, 3 Jun 2026 22:34:17 -0700
X-Gmail-Original-Message-ID: <CAO9r8zPBH6-0SQ6-_ZOhTQeyu=rz4F=ugikCrU-JR_skm6fEWA@mail.gmail.com>
X-Gm-Features: AVHnY4Ku_FxWJkBn8j4XFqE3NCwF4f-sPcyoSpNO4PUEnd9_caFmKAyU5mggsGc
Message-ID: <CAO9r8zPBH6-0SQ6-_ZOhTQeyu=rz4F=ugikCrU-JR_skm6fEWA@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] mm/zswap: Make shrink_worker writeback cursor per-memcg
To: Hao Jia <jiahao.kernel@gmail.com>
Cc: akpm@linux-foundation.org, tj@kernel.org, hannes@cmpxchg.org, 
	shakeel.butt@linux.dev, mhocko@kernel.org, mkoutny@suse.com, 
	nphamcs@gmail.com, chengming.zhou@linux.dev, muchun.song@linux.dev, 
	roman.gushchin@linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	Hao Jia <jiahao1@lixiang.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16635-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1F5FA63D0C2

> >> For instance, suppose a parent memcg has two children, memcg1 and memcg2,
> >> each with 200MB of zswap (100MB inactive). Triggering proactive writeback on
> >> the parent memcg will exhaust memcg1's inactive zswap pages. After that,
> >> even though memcg2 still has plenty of inactive zswap pages, it will
> >> continue to write back memcg1's active zswap pages. Writing back active
> >> zswap pages causes the user-space agent to prematurely abort the writeback
> >> because it detects that certain memcg metrics have exceeded predefined
> >> thresholds.
> >
> > This will only happen if the reclaim size is smaller than the batch
> > size, right? Otherwise the kernel should reclaim more or less equally
> > from both memcgs?
> >
>
> I gave it some thought. Not using a cursor could lead to unfairness
> issues with certain writeback sizes:
>
>   - If the writeback size is an odd multiple of WB_BATCH (e.g.,
> triggering a writeback of 3 * WB_BATCH), with 2 child cgroups, the
> writeback ratio might end up being 2:1.
>   - If a memcg has 5 child cgroups and a writeback of 2 * WB_BATCH is
> triggered, it might repeatedly write back from only the first 2 child
> cgroups.
>
> Although setting a smaller WB_BATCH might mitigate this unfairness, it
> could hurt writeback efficiency. Let's just use per-memcg cursors to
> completely fix these corner cases.

Exactly, the batch size should be small enough that any unfairness is
not a problem. I would honestly just do batching without a per-memcg
cursor, unless we have numbers to prove that the efficiency is
affected when we use a small batch size. Let's only introduce
complexity when needed please.

