Return-Path: <cgroups+bounces-17732-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qQfxGFcMVWqBjQAAu9opvQ
	(envelope-from <cgroups+bounces-17732-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 18:03:35 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD8774D633
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 18:03:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=gGsL6cm0;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17732-lists+cgroups=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="cgroups+bounces-17732-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1E4373007B3D
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 16:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830E83090C2;
	Mon, 13 Jul 2026 16:01:35 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4739F282F3F
	for <cgroups@vger.kernel.org>; Mon, 13 Jul 2026 16:01:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783958495; cv=none; b=AN4Bm6KhTyQ95v38swfhrlBJrXAg+7V/mbz7oyZq5XQyeJhhfyOYpvQAyCtoUEQrQg1OH1l4S+t3lCBlIfQFD8K7bdZKfiVbkvC1jH5utApHg/SAJ+x4s2i23VyVHU/+0iJZ0R4+L70ZuKhdyOouUsKxiNOmSAhFEHoWcCQ/rPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783958495; c=relaxed/simple;
	bh=PuufBzsSphx2WDdJKtlvYCa8XLTRbwpHm5YtWcfdF+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qez/8iRGGJhddzZFTQZl5Ea9S2Cpq8BfW8+e9z1wXRW1lnBmOXH7VrCSpNEKuNyBMst8flRmaFqnH1qKMg21e5L6BxH5c0O2TW8EHVRT3nqxgyaJb0RWiJAt7yJJr0Svm22+aNLAZrG0ZBk5umOoC87fVWQVcps7sAHAbkFUrQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gGsL6cm0; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5CA11F00ADE
	for <cgroups@vger.kernel.org>; Mon, 13 Jul 2026 16:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783958493;
	bh=A4p/iJEsuqLqZW98fp3Z/JwahVzSBhEWJQYLDi2b1wQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=gGsL6cm0oLM5uyJRZaD1106UP9rdBNxHJhYQNZjrgQ6XB2pWHuYXctdMjxlM5CRvu
	 gp342h57XlvjDZ6oK+w0AknYaOeGWmzFypilRTF5z3ZnSoE/F5Rrs7PZ17EBeZK8iN
	 iwJ+bCirr2gdw/Edb9/X/c4wKi9GhgqaYLw7m/ofBVvHPa4sXXiu7qhOseBR3V9SQy
	 /TP19s7x0o3mDGmGmNwb1pPz15B7zYYWqQBn2x6Bqb368p8jGp5MDXT4DpshZtFG86
	 o3I0To5oMcQxd+rnCkLkS/ql9KjwpuCT6jOpr9ZOkOMjQMAgCtHgKr/K12LQ4FEf+/
	 bxgE4x9rjaW7A==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c029505b389so3937066b.1
        for <cgroups@vger.kernel.org>; Mon, 13 Jul 2026 09:01:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rrx6vZmsRRpiEQngS75I+4hvLW7l3VO2uua0qaJx+kdvpZUfgJuyN8WrEH0U4xZojBdEpHFa80k@vger.kernel.org
X-Gm-Message-State: AOJu0Yy11DtYvYGn3oZJ9vegBp8zGrOoFCdIKFQqYsi+agjSYAceszbE
	ROdwQwWWnTS13/vrLCqcRM+kUvt4tot1Z06dvDrLWJjVhnasLKRo22fluaCFfGlXs+bMlDYyRP4
	pXpssI1XeLXAISHSc4MVOnhJ0Z4J9QUM=
X-Received: by 2002:a17:907:d50c:b0:c15:d08a:2cb1 with SMTP id
 a640c23a62f3a-c15fe271f91mr593752966b.0.1783958492729; Mon, 13 Jul 2026
 09:01:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260713025644.170839-1-youngjun.park@lge.com>
 <CAO9r8zNJfhirbzvJzDWRaBQOM7XZcf_Jk0Bz=Y4dB4QK4W-MwQ@mail.gmail.com> <alUK8DWRy4LPxTpY@yjaykim-PowerEdge-T330>
In-Reply-To: <alUK8DWRy4LPxTpY@yjaykim-PowerEdge-T330>
From: Yosry Ahmed <yosry@kernel.org>
Date: Mon, 13 Jul 2026 09:01:20 -0700
X-Gmail-Original-Message-ID: <CAO9r8zPvWKgQ8+ABxSnVnC452-enyMqCjBTA4pfNDVxsoJr25g@mail.gmail.com>
X-Gm-Features: AVVi8CemNk_BxeqQs2RK3JG4sK1gdF8qRv2pw_9fmYBGp6XJBiRqkijRIQCRLiw
Message-ID: <CAO9r8zPvWKgQ8+ABxSnVnC452-enyMqCjBTA4pfNDVxsoJr25g@mail.gmail.com>
Subject: Re: [PATCH v10 0/6] mm/swap, memcg: Introduce swap tiers for cgroup
 based swap control
To: Youngjun Park <youngjun.park@lge.com>
Cc: akpm@linux-foundation.org, chrisl@kernel.org, linux-mm@kvack.org, 
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17732-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:youngjun.park@lge.com,m:akpm@linux-foundation.org,m:chrisl@kernel.org,m:linux-mm@kvack.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:kasong@tencent.com,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:shikemeng@huaweicloud.com,m:baoquan.he@linux.dev,m:baohua@kernel.org,m:joshua.hahnjy@gmail.com,m:gunho.lee@lge.com,m:taejoon.song@lge.com,m:hyungjun.cho@lge.com,m:baver.bae@lge.com,m:her0gyugyu@gmail.com,m:joshuahahnjy@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[yosry@kernel.org,cgroups@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,kvack.org,vger.kernel.org,tencent.com,cmpxchg.org,linux.dev,huaweicloud.com,gmail.com,lge.com];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,lge.com:email,mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5BD8774D633

On Mon, Jul 13, 2026 at 8:57=E2=80=AFAM Youngjun Park <youngjun.park@lge.co=
m> wrote:
>
> On Mon, Jul 13, 2026 at 08:50:36AM -0700, Yosry Ahmed wrote:
> > On Sun, Jul 12, 2026 at 7:57=E2=80=AFPM Youngjun Park <youngjun.park@lg=
e.com> wrote:
> > >
> > > This is the v10 series of the swap tier patchset.
> > >
> > > v10 folds in the Sashiko review fixes for the selftests added in v9 a=
nd
> > > rebases onto the current mm-new. There are no functional changes to t=
he
> > > core swap or memcg code since v9; see the changelog for details.
> > >
> > > For context, the bulk of the series is unchanged since v8, with great=
 thanks
> > > to Shakeel Butt and Yosry for the reviews and discussions [1] that sh=
aped it.
> > > The main change in v8 was the interface change to use memory.swap.tie=
rs.max
> > > with '0' (disable) and 'max' (enable) values. This mechanism was sugg=
ested
> > > by Shakeel and Yosry.
> > >
> > > This change allows for future extensions to control swap between tier=
s and
> > > aligns better with existing memcg interfaces. It is confined to patch=
 #3's
> > > user-facing interface; internally, patch #3 still uses the existing m=
ask
> > > processing method, which is implementation-efficient.
> > >
> > > We also discussed tier extensions. Thanks to Yosry, Nhat and Shakeel =
for their
> > > valuable feedback.
> > >
> > > Here is a brief summary of our tentative conclusions. Please correct =
me
> > > if anything is misrepresented (details in references):
> > >
> > > * Zswap tiering [2]:
> > >   Zswap can itself be a tier (typically the fastest one). But, until =
vswap lands,
> > >   zswap cannot be the only allowed tier,
> > >   since it still needs a physical device for allocation;
> > >   that restriction can be lifted once vswap is supported.
> >
> > Does this series support zswap being a tier? I cannot find any mention
> > of zswap in the patches.
>
> Hello Yosry!
>
> This series does not cover zswap as a tier yet.
>
> My plan is to land the swap tier infrastructure together with the
> first use case (cgroup-based swap control) first, and then follow
> up with zswap tier support in a subsequent series, continuing the
> discussions we've had above.
> (I mentioned on cover letter, right above the overview section)
>
> Does that approach sound reasonable to you?

How does swap tiering work with zswap in the current series? I assume
zswap is just enabled for all devices in all tiers? I wonder if
introducing zswap as a tier after the fact changes user-visible
behavior. I guess if zswap will be introduced with a default "max"
value it will more-or-less be the same behavior, but I would check all
user-visible behaviors related to zswap (e.g. interaction with other
zswap interfaces) to make sure nothing breaks or changes in a
meaningful way when zswap is introduced as a tier later.

