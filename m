Return-Path: <cgroups+bounces-17738-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KiZZI8QbVWojkAAAu9opvQ
	(envelope-from <cgroups+bounces-17738-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 19:09:24 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8387B74DE05
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 19:09:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=kVUJIOBx;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17738-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17738-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6FC283016C69
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 17:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11920343D72;
	Mon, 13 Jul 2026 17:06:11 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A975E33D4E9
	for <cgroups@vger.kernel.org>; Mon, 13 Jul 2026 17:06:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783962370; cv=none; b=kPNEK8cqZm7iDnT+m/T1hkezIjXgjRSLPzqZkjAlZd4QrqbOhtu/vMRnMFirLSzv29UeduwneaDhT+4Zlf1BNqCHKKaiGI8Gg3cy/LTkMzoY+u2mLlY8NugWIwcYC0/BS5R3yUPtfMrK2u3uScfJg7kw1YGK0kw57k4IMRxrHfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783962370; c=relaxed/simple;
	bh=9ESMcNJrgY9tlig0D0q8kL9Faw/h5d3J/MxEMumv75I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gbo0TETHSrm9nyca929z9qF0kICUEF72YjuJwpQkBWZrjYMTOLBAUXw3DAZwgmrrD2UsIjDdcl9iL6+lrLkHfMVjg1VUjSErcpZG4a0fcaAEcVY0EXzNJmZGG+US7tseYxJwyLU7HqDERFbMTmtVPrndzehR/JB6HMeUn+ieQFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kVUJIOBx; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D6CC1F01558
	for <cgroups@vger.kernel.org>; Mon, 13 Jul 2026 17:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783962368;
	bh=PCg0ezVsWUDFwNJ5eXVgcKlvju87Zi05OO8sX5KoW+E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=kVUJIOBx8nWiyS5mBoa4y043g2Sakko4l0KdubLWqXmAzxfnju2HXHT9WLNNTnCNE
	 Sq5sBGovGV2/K7lLbq8b+pHs8pC/10PgHp9jQe7/CRR9cXyMwIiBcdAnF8NMHOWAig
	 YTqCQzYPE+nfs28gZTxsf+RlFT/GTHeayK2EN/WDxV1T06roXBvcM5odSImIm2tUoN
	 ZROhTWKr7tCiKuYkmX8DeNQqyCxhec3oJdsrtkzQFlylluLe+GmvjijgjDrigV0SRx
	 OoqsnNt5vnQd4+jJ/OjIJASM7ndPu16pWvkt3l4bxX0XGcWUu9GfDxIvLTQ+jqupge
	 GMcarSagf9WNQ==
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-667d8f7dc59so72222d50.1
        for <cgroups@vger.kernel.org>; Mon, 13 Jul 2026 10:06:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqEJ5svwPHeffugRqY/5SK19TfOecFvxqG4/vepq7bcOlxjgnRGr9tz1YoS0svwbk035KwKaZ7L@vger.kernel.org
X-Gm-Message-State: AOJu0YyXlySkPIpvwDG2vAFasmCSNybi07otGBAphWLhv2rZHQERSl5A
	uLZXYA5KdFoxWpXVqUGvgPjYhMWLHux+Lq/cE+rv6dj8pt0o3wtNuQfs2wemjBifNDX641b7UzR
	1LEbr7OMpNamOZ9XVAcPkPohAxxYv/Z+pClvhCAQhIg==
X-Received: by 2002:a53:e850:0:b0:667:a303:cd69 with SMTP id
 956f58d0204a3-667d7c2abe8mr4777415d50.76.1783962367515; Mon, 13 Jul 2026
 10:06:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260713025644.170839-1-youngjun.park@lge.com> <CAO9r8zNJfhirbzvJzDWRaBQOM7XZcf_Jk0Bz=Y4dB4QK4W-MwQ@mail.gmail.com>
In-Reply-To: <CAO9r8zNJfhirbzvJzDWRaBQOM7XZcf_Jk0Bz=Y4dB4QK4W-MwQ@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Mon, 13 Jul 2026 10:05:55 -0700
X-Gmail-Original-Message-ID: <CACePvbUC60sOEwAV6bbBowYe4J8Z9fDc8M=aRXSsXfKNJ5CYBw@mail.gmail.com>
X-Gm-Features: AVVi8Cea804-R-wCPM6hsanlgOS7u2XI_gmRPvx4pPBWwkOlZ6UvNGiEZK7yGZE
Message-ID: <CACePvbUC60sOEwAV6bbBowYe4J8Z9fDc8M=aRXSsXfKNJ5CYBw@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17738-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,lge.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8387B74DE05

On Mon, Jul 13, 2026 at 8:50=E2=80=AFAM Yosry Ahmed <yosry@kernel.org> wrot=
e:
>
> On Sun, Jul 12, 2026 at 7:57=E2=80=AFPM Youngjun Park <youngjun.park@lge.=
com> wrote:
> >
> > This is the v10 series of the swap tier patchset.
> >
> > v10 folds in the Sashiko review fixes for the selftests added in v9 and
> > rebases onto the current mm-new. There are no functional changes to the
> > core swap or memcg code since v9; see the changelog for details.
> >
> > For context, the bulk of the series is unchanged since v8, with great t=
hanks
> > to Shakeel Butt and Yosry for the reviews and discussions [1] that shap=
ed it.
> > The main change in v8 was the interface change to use memory.swap.tiers=
.max
> > with '0' (disable) and 'max' (enable) values. This mechanism was sugges=
ted
> > by Shakeel and Yosry.
> >
> > This change allows for future extensions to control swap between tiers =
and
> > aligns better with existing memcg interfaces. It is confined to patch #=
3's
> > user-facing interface; internally, patch #3 still uses the existing mas=
k
> > processing method, which is implementation-efficient.
> >
> > We also discussed tier extensions. Thanks to Yosry, Nhat and Shakeel fo=
r their
> > valuable feedback.
> >
> > Here is a brief summary of our tentative conclusions. Please correct me
> > if anything is misrepresented (details in references):
> >
> > * Zswap tiering [2]:
> >   Zswap can itself be a tier (typically the fastest one). But, until vs=
wap lands,
> >   zswap cannot be the only allowed tier,
> >   since it still needs a physical device for allocation;
> >   that restriction can be lifted once vswap is supported.
>
> Does this series support zswap being a tier? I cannot find any mention
> of zswap in the patches.

In case I wasn't clear. As it is, zswap is not part of the tier and will no=
t be.

Chris

