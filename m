Return-Path: <cgroups+bounces-16999-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cAy/MSA/MWrQfAUAu9opvQ
	(envelope-from <cgroups+bounces-16999-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 16 Jun 2026 14:18:40 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFDB68F3A2
	for <lists+cgroups@lfdr.de>; Tue, 16 Jun 2026 14:18:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ehK3Zm+d;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16999-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16999-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C6C9330104BE
	for <lists+cgroups@lfdr.de>; Tue, 16 Jun 2026 12:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A592F745E;
	Tue, 16 Jun 2026 12:15:51 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578E01E8320
	for <cgroups@vger.kernel.org>; Tue, 16 Jun 2026 12:15:49 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781612150; cv=pass; b=n0girIGERe7VVDLjkhLGzuYgsd0ETsgDd0J6B5jcAXqlvj46yZgnojSnSfls6VOrIrX4Cm/pzNi8iKr97vQZ+2LVPSTOa40+wJuDa8RvMtd2FJN/4yBIjCfOSNkm3SV98Oqc0AMfv4E1NuSkAX2D6xiiKtO8AddKD5oCYi9FXKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781612150; c=relaxed/simple;
	bh=0Sxr9nHRTMlxWC+/vtlKL1AgOLRnk+j4roZHiJzJV9w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D48t53do6JjcuOER8Rxos+v+fjYRc2/qPZR4HHIPzRnroHxj+6k2pNOJ1hn/BaDOyfJZdR/Bimz6BEewavbWATW98SBauqJKPd+rYMmfZ/IyAlhtQGsB/dpvQPvjfQBT479DM/UhKnhXcs43LXdqTiF4gke23fTUTLz0VTGQlKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ehK3Zm+d; arc=pass smtp.client-ip=209.85.128.47
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-490c1915793so38108935e9.2
        for <cgroups@vger.kernel.org>; Tue, 16 Jun 2026 05:15:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781612148; cv=none;
        d=google.com; s=arc-20240605;
        b=HMnabozsIIQegBrsCL0eT0KXDCoAD5+efdxKbrYgB43C5hGYkJk76WAGXp2DkmNJ1i
         bqlprG98GHI94MpQpgSa54YxaAfdNAlTqr1kjT+T9kzv/YoJbJPUF5s/kpA7KJTGxdHJ
         FVRRTXEOijiPl6WGbdsB9NgP+p//Sn8moZRQipLqWXGy0cQp0xVwZJ3YA6lFOgN1ZPTP
         RwfQpaPpI1rPIFy3E1VuufaUHk/HDrvfcB7RrAS9+DKiyrN3LtQDq45YUMOcb26Cqh1a
         XXPFIaVYwrV68kxTjgwNZJxie6aHKH47e+Yk/+fuP36prpurLa9Cip+bwL3t6h+DV17f
         bqNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=K5foDtgqeTQXrOWV48GNDC5TnV9fQo3PaQ7iDDwN1xA=;
        fh=imQto0kzY7GdeZlyF0+ku9I0cwjYsI1yGSlTsFmnpVY=;
        b=UQXXywawNeNXzbpVUq+ulMlPCaKDsdeucUJrskSdJ0Y8hK25jHGmadMgRM4WjC0Rux
         ARwnto0B0VlBeDoArDaAQS7xTFCbcVQtg/kcBafRSVVxitq/vP2WwS6hfs955PumkS3B
         4mEzm37DQExhmJ6E8Pq9uy7jAuNHge/9J0nb7gBInzrjGCdzW84ee5lBh+2HdHPhWEa7
         GOEPzy6tPTcNOFRG2BdGUtZrgTEgXdlhhDtqK/0y7mqy6hFNx6fe54dAlz7DtqIEk1nN
         IHf30Iwr7PAIit61ZaJ3cuk77V01muexWBtzL6gisvPWRpZ8idgJDFTr0dxw+6yL6ZHO
         T1MQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781612148; x=1782216948; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K5foDtgqeTQXrOWV48GNDC5TnV9fQo3PaQ7iDDwN1xA=;
        b=ehK3Zm+dX1n/qk0QbSFI8+80ONdm+yIDzI5nS6kcBqmfamtKjfX9o6OO8p8aID0psx
         p/nUvSqd5vf2Gux4yhq5Z1RHJT8gf7w+1sy2GACmbGYd2HwzgZJgcgUy0GcXVtQH8E+/
         5689ag3G2kT9Mvs/mBCf3x2rgwIFkGL4mDgXbQ4z8oBtqHzXDm2EF2HNgbfQ2YBrBAUS
         LDHRj2Obk1oh3k86ozB8ytHG3Hm+j5ZN4n2HB7RnCx9n6IxFCoggMnUXNfuW3agMFo+a
         WPaSGJAVJUwr1trYdlhWt5kIqJRlARinvCye0EXsOtR0w+BQ5NNs1FBx/wyRDwPtNCgL
         fS6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781612148; x=1782216948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K5foDtgqeTQXrOWV48GNDC5TnV9fQo3PaQ7iDDwN1xA=;
        b=JMib+O3Zq1iqyteJUPeSNt3xAUu/zzdYi4/8bZX/dkttDcOGp39cbV9CF6g7DajUlf
         HE7xE3jGoE3ZfQxSe9H1kdFwsWch1vT/mK4vjcAF3wC7UhOc2wpnFCzdcOugLFJSRv98
         ko7sUhICrhGwySdZ4xygI5CoONald/uc7KRQLpNbNMkyMJGlw7qArSoeWSoZTQNah+Le
         a5vjOPBqBg9EKmTnEDx9hCXkljn8H4F98U2bMLyTbtN/d4ZSAvCztEoOBY/qvgo4O72R
         x2B7l68dveeg1DICT9OuOeaeGhHdT8EKH3TeZjseMFcKC83X4rV1TwHrxFG8yOUXwmUa
         /aPg==
X-Forwarded-Encrypted: i=1; AFNElJ/hr2oNSNULq0hlo1Z8py6GojtVKWMl6SLDOLPyQr2y2jA9OOQ5eerFEyZegj1U4UagxD/serGV@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5oVb9nkHEDpBwOShXkQKZCUMoDcnAUPHthNI/NtnYeKC5teVF
	2pfE+wwYr9awMM4GzGFXFgrYQyUMuXYRpn9AxEcNtS/sO/UttbcojUUR6LTUxCDpH6UgWsi1UIy
	PY3UWbuBJb/i6y17NwPWfZMYGLJPY+/I=
X-Gm-Gg: Acq92OHXJrHRQO7brdj36U1BDAxYarrqtdlQJjSE4SbAajLj76Vp16iPXz2Rx8dgRP1
	3jIQ2IHpWTBDid0z6I5XLMFiVosGpdyS2zJNEoFvUfHXgYClBsAlzd8gMLnin8HvcBYyebazJL8
	nG1k+d636JLmVP1n9rLXPZQ+95sKXWYGREX1F8ESf1q2Ld6yRgqOZczgoMAxrgco73PdQtZ2aZC
	yzvTTjMGovlFXB++eDmxuZ66gRjduqwqUTEkhNV1pIYKJFa3bzMP+zoIWOT3Lba+8fLsO8OqRuL
	Ikt2x6nOPwh4PlbeC/ODcbY06ULLlPOksDeIKQ==
X-Received: by 2002:a05:600c:820c:b0:490:c2a3:3302 with SMTP id
 5b1f17b1804b1-490ec526f4fmr251514085e9.35.1781612147341; Tue, 16 Jun 2026
 05:15:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612193738.2183968-1-nphamcs@gmail.com> <ai5kOOmR1LPTWs1J@yjaykim-PowerEdge-T330>
 <CAKEwX=O23a4iWBZoewKVb8QqODte6r3Xijckw3_oCJNoiO9M5A@mail.gmail.com>
 <CAO9r8zPj5EH8Mbpc6N+d1u2eEgoV33f+4s=v-84gaobAodPtUw@mail.gmail.com> <ajCm44rYpLOKCQ43@yjaykim-PowerEdge-T330>
In-Reply-To: <ajCm44rYpLOKCQ43@yjaykim-PowerEdge-T330>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 16 Jun 2026 08:15:34 -0400
X-Gm-Features: AVVi8Cf1GupVHqkNcZhtYoOUz9DU0zT_2oeWtf5qDBtNiWLRx6q_yt7muoLsCPw
Message-ID: <CAKEwX=OPaUputOYJrJDvcNGn7WWoXOp-GzztA5MPbynj-4cPWQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/7] mm, swap: Virtual Swap Space (Swap Table Edition)
To: YoungJun Park <youngjun.park@lge.com>
Cc: Yosry Ahmed <yosry@kernel.org>, akpm@linux-foundation.org, chrisl@kernel.org, 
	kasong@tencent.com, hannes@cmpxchg.org, mhocko@kernel.org, 
	roman.gushchin@linux.dev, shakeel.butt@linux.dev, david@kernel.org, 
	muchun.song@linux.dev, shikemeng@huaweicloud.com, baoquan.he@linux.dev, 
	baohua@kernel.org, chengming.zhou@linux.dev, ljs@kernel.org, 
	liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, surenb@google.com, 
	qi.zheng@linux.dev, axelrasmussen@google.com, yuanchu@google.com, 
	weixugc@google.com, riel@surriel.com, gourry@gourry.net, 
	haowenchao22@gmail.com, kernel-team@meta.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16999-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:youngjun.park@lge.com,m:yosry@kernel.org,m:akpm@linux-foundation.org,m:chrisl@kernel.org,m:kasong@tencent.com,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:david@kernel.org,m:muchun.song@linux.dev,m:shikemeng@huaweicloud.com,m:baoquan.he@linux.dev,m:baohua@kernel.org,m:chengming.zhou@linux.dev,m:ljs@kernel.org,m:liam@infradead.org,m:vbabka@kernel.org,m:rppt@kernel.org,m:surenb@google.com,m:qi.zheng@linux.dev,m:axelrasmussen@google.com,m:yuanchu@google.com,m:weixugc@google.com,m:riel@surriel.com,m:gourry@gourry.net,m:haowenchao22@gmail.com,m:kernel-team@meta.com,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,linux-foundation.org,tencent.com,cmpxchg.org,linux.dev,huaweicloud.com,infradead.org,google.com,surriel.com,gourry.net,gmail.com,meta.com,kvack.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3CFDB68F3A2

On Mon, Jun 15, 2026 at 9:29=E2=80=AFPM YoungJun Park <youngjun.park@lge.co=
m> wrote:
>
> On Mon, Jun 15, 2026 at 12:56:26PM -0700, Yosry Ahmed wrote:
> > On Sun, Jun 14, 2026 at 7:39=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> w=
rote:
> > >
> > > On Sun, Jun 14, 2026 at 4:20=E2=80=AFAM YoungJun Park <youngjun.park@=
lge.com> wrote:
> > > >
> > > > ...
> > > > > * Integration with swap.tier by Youngjun (see [12]). For now, I'm
> > > > >   leaning towards opting out the vswap device from swap.tier enti=
rely, and
> > > > >   treat it as a special device. Integrating it with swap.tiers wi=
ll
> > > > >   benefit the cases where you want some cgroups to skip vswap for=
 fast
> > > > >   swap devices (pmem), whereas other should go through zswap firs=
t. But
> > > > >   most other use cases, either the overhead of vswap will be acce=
ptable
> > > > >   (or not the bottleneck), or we can just disable CONFIG_VSWAP en=
tirely :)
> > > > >
> > > > >   Youngjun, may I ask for your thoughts on this?
> > > >
> > > > Hi Nhat,
> > > >
> > > > Tier 1: VSWAP, Tier 2: ZSWAP ...
> > > >
> > > > I don't see any problem applying the desired functionality with the
> > > > currently proposed mechanism and interface. With this, a user would=
 be
> > > > assigned the default Virtual -> RAM swap tier, and the overall pict=
ure
> > > > becomes one where swap tiers are composed according to the priority
> > > > setting.
> > >
> > > It's more - is there a strong argument to let vswap be a tier (which
> > > is not supported by just turning of vswap altogether).
> > >
> > > Because right now I'm not exposing vswap device to userspace in any
> > > manner, pretty much. It's abstract and transparent, and minimizes
> > > complexity (no vswap and swap.tier interaction) and surfaces for
> > > issues.
> >
> > I definitely think vswap should *not* be a tier. First of all, a vswap
> > entry can be backed by zswap or an actual swap device, which would be
> > two different tiers. How does that work?
> >
> > I also think vswap should not be exposed to userspace in any way, at
> > least not now. I still think we should aim to just make the
> > redirection layer always on and eliminate "vswap devices".

Yeah I will just expose a pair of usage/failure for diagnostics purposes :)

>
> After following the answers and giving it some thought, I agree that
> vswap should be kept user-transparent. If there is a strict need to
> disable it, relying on CONFIG_VSWAP to remove it entirely seems like
> the right approach.
>
> If a strong use case for user interaction emerges in the future, we can
> revisit the design and figure out how to handle it at that time.

Yeah the only argument for adding vswap to swap tier is if we want it
to virtualize swap on a per-cgroup basis, assuming:

1. There's a setup where some cgroups benefit from vswap and some
don't, in the same deployment or host (so you can't just use
CONFIG_VSWAP).

2. We can't decide it with some heuristics purely based on kernel's
knowledge (so for e.g, if a cgroup enables zswap, then vswap probably
makes more sense than not, etc. etc.).

Maybe I'm missing something, and if so please let me know. But
otherwise I'll stick with transparent vswap for the next version.

With Youngjun's new interface, if we made a mistake here and
per-cgroup vswapping turned out to be necessary, fixing it is fairly
cheap. We don't need to add any new knob - just need to expose it to
memory.swap.tier somehow, and we're done. That can be done as
follow-up :)

