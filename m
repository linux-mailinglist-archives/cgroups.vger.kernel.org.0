Return-Path: <cgroups+bounces-16980-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OiAyOAdZMGrTRwUAu9opvQ
	(envelope-from <cgroups+bounces-16980-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 21:56:55 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC42689A03
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 21:56:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=OxpYzLl0;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16980-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16980-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B57DC30CBB89
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 19:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1363B5841;
	Mon, 15 Jun 2026 19:56:41 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADAE3B4EBF
	for <cgroups@vger.kernel.org>; Mon, 15 Jun 2026 19:56:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781553401; cv=none; b=pu1+RpFvQKFLkfTADKmxA9HfPPY9g8fEMhnlJRLnRtsAB8RuUAd4ON4OCxtcnAyipZXwMkaF66ODdJFaHLTzYkfieXg/YMTREFB9AVI+kvJ27VNIv98oMd8njfVVXXN7hUBYJgU+lw0XE6EgRnK/XonVBZiREFtoZsbvrIjGN3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781553401; c=relaxed/simple;
	bh=j8E1JQSy0OnyDawt9VTWj5df7AZ9FLaOsGx4hbRUG4A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R8FPSsn7QUwM+yaPz0FAkX1pglKmpBU1A2G59Pg7Kc/viww67DO32lVfEckanCtnl1uhIQ6A1K9HQovozRJe1+ZY4drLhy3THUn8qHZLu5z9btkrye2sttzWZCpD26BHD2GEkZiPR1+TitKcmw80Caw4vVMhTfIovFhkun7AF84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OxpYzLl0; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 098051F0155A
	for <cgroups@vger.kernel.org>; Mon, 15 Jun 2026 19:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781553400;
	bh=CHDHQyzQEzNQZw7jpnsFwMbOx5QuxkQ3GkNZlUm2IF0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=OxpYzLl0RkwxRVVGLiIsMiyVVMkHknFaKpGyhfvr64XRPkBbpp7cqfmWkHCvyUd2s
	 kwci5JaRXRnFXDJOTaQZeaNUuUafs/MbrgnqOfpvm3AYavdrHOeWqSOIpkcbZ+RN1i
	 MMchS+0Wwgeb3hv/CMGarbJEeUojpX4IbmL/JVmG+RE3OHgB12PdOpsAG9wj9LnxDs
	 zMFHXP8vWy8qPiVWRoZ1X6B+fQu9NioezlsN6i/V8EKtHqhWJpd4S0Rm8UpD56iu3N
	 wZCXtnUHrcahl5x5dTlr0QWrTk48fk0zRlXiFWb9IPu/yLItirK1y00Z4f0tpxDXNO
	 UYs5S6QatCocg==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6912f4acca4so6604643a12.1
        for <cgroups@vger.kernel.org>; Mon, 15 Jun 2026 12:56:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+nFdd5c/9/ccv6KimAX8jXSR0nuSWtVXVCEZ7iKatxSpLPXOl/oe/U1ff55aV1VNxavegh2WSc@vger.kernel.org
X-Gm-Message-State: AOJu0YyncLZEuSnUA7oDBTkRKa4SNfMM0MknHi7xbuZWNic0L2MOTEmU
	3QryWijXsq2Uf/P9GKjwI1gP5tZa7W+dFw3KNbDgswCI2N5Jp8B6FypvIrfVYlVn5qHWngMvFuK
	N2v7ng86F6FwXRH6509risDNcvetVspA=
X-Received: by 2002:a17:907:c48a:b0:bed:87c:b24e with SMTP id
 a640c23a62f3a-bff4c6f91c1mr510035466b.29.1781553398899; Mon, 15 Jun 2026
 12:56:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612193738.2183968-1-nphamcs@gmail.com> <ai5kOOmR1LPTWs1J@yjaykim-PowerEdge-T330>
 <CAKEwX=O23a4iWBZoewKVb8QqODte6r3Xijckw3_oCJNoiO9M5A@mail.gmail.com>
In-Reply-To: <CAKEwX=O23a4iWBZoewKVb8QqODte6r3Xijckw3_oCJNoiO9M5A@mail.gmail.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Mon, 15 Jun 2026 12:56:26 -0700
X-Gmail-Original-Message-ID: <CAO9r8zPj5EH8Mbpc6N+d1u2eEgoV33f+4s=v-84gaobAodPtUw@mail.gmail.com>
X-Gm-Features: AVVi8CeBXtPoqwEONKA1srrjcv1qzJONWTIgQJLaZhbQzcm8GrAo60prZifd-3c
Message-ID: <CAO9r8zPj5EH8Mbpc6N+d1u2eEgoV33f+4s=v-84gaobAodPtUw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/7] mm, swap: Virtual Swap Space (Swap Table Edition)
To: Nhat Pham <nphamcs@gmail.com>
Cc: YoungJun Park <youngjun.park@lge.com>, akpm@linux-foundation.org, chrisl@kernel.org, 
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
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16980-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:nphamcs@gmail.com,m:youngjun.park@lge.com,m:akpm@linux-foundation.org,m:chrisl@kernel.org,m:kasong@tencent.com,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:david@kernel.org,m:muchun.song@linux.dev,m:shikemeng@huaweicloud.com,m:baoquan.he@linux.dev,m:baohua@kernel.org,m:chengming.zhou@linux.dev,m:ljs@kernel.org,m:liam@infradead.org,m:vbabka@kernel.org,m:rppt@kernel.org,m:surenb@google.com,m:qi.zheng@linux.dev,m:axelrasmussen@google.com,m:yuanchu@google.com,m:weixugc@google.com,m:riel@surriel.com,m:gourry@gourry.net,m:haowenchao22@gmail.com,m:kernel-team@meta.com,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[lge.com,linux-foundation.org,kernel.org,tencent.com,cmpxchg.org,linux.dev,huaweicloud.com,infradead.org,google.com,surriel.com,gourry.net,gmail.com,meta.com,kvack.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[yosry@kernel.org,cgroups@vger.kernel.org];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,mail.gmail.com:mid,lge.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3FC42689A03

On Sun, Jun 14, 2026 at 7:39=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
> On Sun, Jun 14, 2026 at 4:20=E2=80=AFAM YoungJun Park <youngjun.park@lge.=
com> wrote:
> >
> > ...
> > > * Integration with swap.tier by Youngjun (see [12]). For now, I'm
> > >   leaning towards opting out the vswap device from swap.tier entirely=
, and
> > >   treat it as a special device. Integrating it with swap.tiers will
> > >   benefit the cases where you want some cgroups to skip vswap for fas=
t
> > >   swap devices (pmem), whereas other should go through zswap first. B=
ut
> > >   most other use cases, either the overhead of vswap will be acceptab=
le
> > >   (or not the bottleneck), or we can just disable CONFIG_VSWAP entire=
ly :)
> > >
> > >   Youngjun, may I ask for your thoughts on this?
> >
> > Hi Nhat,
> >
> > Tier 1: VSWAP, Tier 2: ZSWAP ...
> >
> > I don't see any problem applying the desired functionality with the
> > currently proposed mechanism and interface. With this, a user would be
> > assigned the default Virtual -> RAM swap tier, and the overall picture
> > becomes one where swap tiers are composed according to the priority
> > setting.
>
> It's more - is there a strong argument to let vswap be a tier (which
> is not supported by just turning of vswap altogether).
>
> Because right now I'm not exposing vswap device to userspace in any
> manner, pretty much. It's abstract and transparent, and minimizes
> complexity (no vswap and swap.tier interaction) and surfaces for
> issues.

I definitely think vswap should *not* be a tier. First of all, a vswap
entry can be backed by zswap or an actual swap device, which would be
two different tiers. How does that work?

I also think vswap should not be exposed to userspace in any way, at
least not now. I still think we should aim to just make the
redirection layer always on and eliminate "vswap devices".

