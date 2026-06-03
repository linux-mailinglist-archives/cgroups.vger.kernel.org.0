Return-Path: <cgroups+bounces-16624-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3CtBFRd5IGoE4AAAu9opvQ
	(envelope-from <cgroups+bounces-16624-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 03 Jun 2026 20:57:27 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F67463AB04
	for <lists+cgroups@lfdr.de>; Wed, 03 Jun 2026 20:57:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ZMAR7LXF;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16624-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16624-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C2A81308B7DD
	for <lists+cgroups@lfdr.de>; Wed,  3 Jun 2026 18:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C853B480953;
	Wed,  3 Jun 2026 18:52:02 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2BE480DC0
	for <cgroups@vger.kernel.org>; Wed,  3 Jun 2026 18:52:01 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780512722; cv=pass; b=K7ggxOsE6BtPEblZIK7EkC/7RPOVb1xqeuM/a6U+qEPdVxNlNZj60e2OiL+f4Pju48l3K7/Q4kgVUqf4XjkDBxHJhJyq89SLssWhq+oxRYkrOmPj/8rXBwIsRWmWaS4myqDbg9FNiJUrZ9MT/u4ppUIdLeCLMw/Ye4FrOxJot/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780512722; c=relaxed/simple;
	bh=jkn/4x7mPiUSlevt03tEoGxtXMPLrS0T6VHBMKvffzU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rpc/dPz6kRcqaZRaJExygOeCAbQmXCrEtTOUswolc1aV5rXtpi7iXUa3LHRYoKZbpnebSPvqVOOfa3ikm76Dzm8H688wcxrlYyiRpIiLAXneen9SzO4GMf5drZ3AcE73M44KgoueySFW9EdFUy48nBStUKiiB6vPru24bZiDczg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZMAR7LXF; arc=pass smtp.client-ip=209.85.128.50
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-490b12270b3so16217235e9.1
        for <cgroups@vger.kernel.org>; Wed, 03 Jun 2026 11:52:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780512720; cv=none;
        d=google.com; s=arc-20240605;
        b=YIUO63N+vguEyEVjSUSvg51pZQZ+oT0f4/H19oS88totK+Mj2e5uu/dSjmwXUbjhSy
         980ahj/orF6IwMs+Up0RQuFuauUi9m6VwQJJMZjYFSsC7G2i8GGm0B7qfvJsZZ10IxDF
         AqeDZ0V3L0ZCUZS0ug/SxZju9hW646y8nGxO9VzRLOOq+sLHT+Ml1lo3xCTi5TIo3VZw
         VMlPRM9HR4iPmzeLyHNfUK56T/hmrFPkJMJpBPwkk+6qASYPINl+p1etdKw4pTFb4x6P
         ygxPlhIv+aqTT+sM8qc/BC8PN07pS4PUN/kRDu5O8o6Yvqhh57uKcmrDIfMWt6QmAl9Y
         Kw3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=e5vL3r211abayjz91d4jpb2IiE8lVazmF4WtAPu6R18=;
        fh=zOIzcaeCysq54BJ1wBzu4uEJrQsLq708V9aVPYbX07Y=;
        b=Y6GQAgXZO6yIFnI2MGv3Eu7VvojXb9IqAq04VFbXFUROE9ovE2mxnnlAYLaYmAUHem
         3QPq5smk7IOG8faolC8Fx6QHj0kbtnMFmBog7arSz/KdRWIv+JcahDaNy59QE/OMzjb9
         s4Vm3tQ1g4pWI2xSaAuFeRWoE/k0jHIuSs7vd6WvJ0JxZMgsZaTBsDAWU/TwVtFW31Le
         hzs5YmjAO6Jo3SWxSwt5RSZeuBxQCOUXmCa2einuvpvh+USVOzNacYXcfCFgQ2r41i5u
         dJR+zRmjVfDY574OOgj02Qev7f3aW0G0D+36opmkoz+iqgeQvLLSXY+BxckCcoXuHJ4G
         xYxA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780512720; x=1781117520; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e5vL3r211abayjz91d4jpb2IiE8lVazmF4WtAPu6R18=;
        b=ZMAR7LXFTwtK9KxK2QDF+yNmuITR8QjM/E05E5Hxu1qFC7L9At2BtnZIRl+Tuh8xTc
         mMlmWmdAiXi5FlEsAR6MjSHYCP+Nz8ZfJ2vS25FIZyFmG39lgXQmwMSpob+IIVGmtbkb
         L9/OXyd1f8lsRO5Jr2ZO50cdJYW8CSXg2RzOZzRUYEAA2BQ/i6HfXCwxLgg9Q0zi1A/p
         x1SBpDZz6e33kXxx18ksya062Ii8YVZFrWYTAeK+3P95AY/Bh0Y9G73/s++qo5bCrMrM
         mdYOXRDe/VpNKuRDxSOUrX7/cDduEszNAB3RFx+SsvAgEWkEQJtBfLFtuqB7McyuwMpK
         +DBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780512720; x=1781117520;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e5vL3r211abayjz91d4jpb2IiE8lVazmF4WtAPu6R18=;
        b=WzzIFQQ+OK945rSGzSs072za+sRiV+E7iSbXrmHJpsDAjmeBOkdWaWOCMzV0ZhA/Nb
         UXneNRMJ5ZdrIDpZeWTofCXQr6Qmt0Bbn8yNvNXHLDKEL0vxfr6pd4qgtu0jezmX3NLp
         QiXCV3UmX/OOUEKLe5Li8mlmbLLKv0qrCV2NnG562u/iYQmx53be6uCIHJBLF/83JeSv
         QfBSw2k1olKG++qik6F7NapH7MoWCRPXKfeUAqaDJWWQtYyQk5KIGVgkAn21O8bWm/+L
         YEYzn6SEr0gg3hYSwmL2abUOq7YsnnCOf2fbl1l+Z57fjBRGi6zi8KdpNMHEmcr9Ig8y
         Sy2w==
X-Forwarded-Encrypted: i=1; AFNElJ85ug7DEhgGYIFs/dehtHW7fj68LC/Oz9p24LHlYr7pqmvYo18765bCEkhEPwqia8m0BTCXx9wP@vger.kernel.org
X-Gm-Message-State: AOJu0YxCwyVB5kZ+NXaE6K7b6xQ+2t2QzroKmp1TjmbwCXMuyAEov6RJ
	jMLt0uCcMzfqb7RWTNGYRvaCAGUEX0sG6NHUryBIy9emci7Y1cjt71Fq3jbGXwTRCedQyPwlAFT
	F0WxbHjzINju6Ab057z/+Oba2NaG9zB8=
X-Gm-Gg: Acq92OE+tJaKDp8wXMuspdyT2AH3eJFf/nQxqJn2wrPSGncLdBpXgbEmnNSJWzjnzyp
	67nx7loULwVPXzYolz03NAp8gxGb4nLyRPPEUNYFWf7ruGvo3/UBCz39xcIx7IdwaiR3ZQt/Au1
	c6oQ0vnXoMf7ujcPs3KYNi4NQez5YIZHLK92LgWsInsfcOzV539bxd0fMyRs1vVrnupauh6iEYC
	rUD8BL1a4rRBVHHbict9NPGyWSw7hxDMuaQHK+5dRba0LAbyaDIQF6zEDAikMpU4xSNlAOqz/kO
	DybBAAyr06RRWn1iD3qp2mw+0anK+N/I+3tl/xda6VGLlDJ4uA==
X-Received: by 2002:adf:f8c4:0:b0:460:e0f:8d19 with SMTP id
 ffacd0b85a97d-4602179121cmr5600969f8f.9.1780512719668; Wed, 03 Jun 2026
 11:51:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526114601.67041-1-jiahao.kernel@gmail.com>
 <20260526114601.67041-3-jiahao.kernel@gmail.com> <aho-Z6wshceTAYd9@google.com>
 <ea2c1323-1440-e927-f14a-0eac54a245bf@gmail.com> <CAKEwX=PoBZ4ci30tKHQXs1o9=NDpPrtbe7RxxZTbnzVJf74ZYQ@mail.gmail.com>
 <CAO9r8zMBUMXy_bkeT8z+M=dXayU=6VGEw+-HmfDWR2fyJy=z+A@mail.gmail.com>
 <CAKEwX=NQUqqrM9vdYE2KhWEZx-YwPc7YPhfz7xaBrGVDf824bA@mail.gmail.com> <CAO9r8zO0GjTeY2+j_AjfTQ8qYOmHezZAV44f=aPgrjJcdtO9rQ@mail.gmail.com>
In-Reply-To: <CAO9r8zO0GjTeY2+j_AjfTQ8qYOmHezZAV44f=aPgrjJcdtO9rQ@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 3 Jun 2026 11:51:48 -0700
X-Gm-Features: AVHnY4KKCfMou4Ez8iKWPLzU7z8Pcq_wTI6Zo3Ilq6vW5_DwwK6THGlhJPcI_cw
Message-ID: <CAKEwX=OeFsFPdazWFf0tsKTOi3DneX3fCcreEkzwb=BOR_37hA@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] mm/zswap: Implement proactive writeback
To: Yosry Ahmed <yosry@kernel.org>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:yosry@kernel.org,m:jiahao.kernel@gmail.com,m:akpm@linux-foundation.org,m:tj@kernel.org,m:hannes@cmpxchg.org,m:shakeel.butt@linux.dev,m:mhocko@kernel.org,m:mkoutny@suse.com,m:chengming.zhou@linux.dev,m:muchun.song@linux.dev,m:roman.gushchin@linux.dev,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:jiahao1@lixiang.com,m:jiahaokernel@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-16624-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,linux-foundation.org,kernel.org,cmpxchg.org,linux.dev,suse.com,vger.kernel.org,kvack.org,lixiang.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0F67463AB04

On Wed, Jun 3, 2026 at 11:43=E2=80=AFAM Yosry Ahmed <yosry@kernel.org> wrot=
e:
>
> On Wed, Jun 3, 2026 at 11:34=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wro=
te:
> >
> > On Wed, Jun 3, 2026 at 11:26=E2=80=AFAM Yosry Ahmed <yosry@kernel.org> =
wrote:
> > >
> > > > > > Is the main difference that we are scanning in batches here? I =
think we
> > > > > > can have shrink_memcg() do that too. If anything, it might make=
 the
> > > > > > shrinker more efficient. Over-reclaim is ofc a concern, and esp=
ecially
> > > > > > in the zswap_store() path as the overhead can be noticeable. Ma=
ybe we
> > > > > > can parameterize the batch size based on the code path.
> > > > > >
> > > > > > Nhat, what do you think?
> > > > >
> > > > > Nhat, since we now have the referenced-based second chance algori=
thm,
> > > > > should we consider doing batch writeback for shrink_memcg() as we=
ll?
> > > >
> > > > I just take a look at shrink_memcg() and realized it's reclaiming o=
ne
> > > > page at a time. Thanks for the reminder - I hated it.
> > > >
> > > > Please batchify it if it makes your life easier :) We don't reclaim
> > > > "just one page/object" anywhere else in the reclaim path, Sure, it
> > > > adds a bit of latency to zswap_store() if we reached cgroup limit, =
but
> > > > IMHO if we hit zswap.max limit at zswap_store() time, that is alrea=
dy
> > > > the slowest of slow path that you should have avoided with proactiv=
e
> > > > reclaim/zswap shrinker in the first place. And, setting zswap.max d=
oes
> > > > not make sense to me in the first place (I can write a whole essay
> > > > about it).
> > >
> > > Should we batchify shrink_memcg() from the shrinker and background
> > > writeback, but leave the synchronous zswap_store() path to reclaim on=
e
> > > page for this series at least to avoid potential regressions?
> > >
> > > I think this change specifically needs more intensive testing (vs the
> > > other code paths).
> >
> > I'm fine with having shrink_memcg() takes a batch_size argument for now=
 :)
> >
> > I suspect not a lot of people invokes the shrink_memcg() synchronous
> > path in zswap store though. Setting zswap.max is hard (as it involves
> > guessing compression ratio ahead of time) and induces quite a bit of
> > overhead (obj_cgroup_may_zswap() does a force flush for every store if
> > you set zswap.max to a value other than 0 and max).
>
> Yeah I agree, but I just wanna make sure we don't completely kill
> performance in case anyone is actually doing that.
>
> Regarding the force flush, it's unfortunate that we need to rely on a
> stat for internal limit checking. It might make sense to use page
> counters here, which already support hierarchical charging and
> whatnot. We'll need something similar to the objcg approach to charge
> sub-pages (or maybe just reuse that somehow?).

Conceptually, I've moved towards not capping zswap.max, and using it
only as a binary knob for enablement/disablement  :)

It's consuming the same resources it saves, so if we cap memory.max
(and swap.max until we have vswap), then we already have isolation.
The split between uncompressed/compressed should then be dynamically
determined by workload characteristics (working set size, access
pattern, compressibility) and service's SLO, and reclaimers
(preferably proactive reclaimers) will drive us towards the optimal
split/equilibrium.

