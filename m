Return-Path: <cgroups+bounces-17725-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Y0gGKvEBVWo8iwAAu9opvQ
	(envelope-from <cgroups+bounces-17725-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 17:19:13 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F3FF374CEF3
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 17:19:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="YLa/b/ra";
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17725-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17725-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C10BF347E480
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 15:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E84843802B;
	Mon, 13 Jul 2026 15:08:56 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124C4329C40
	for <cgroups@vger.kernel.org>; Mon, 13 Jul 2026 15:08:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783955335; cv=none; b=EUiugbsnat06VIvnt3V3Z2k7MRghqa/FQlb+FhMyk2yLZdHw0u89uB6TRDLoWLaTIUyHWw578skyQ2lCO7gMWt6Vk4lfasevCKiZeoXqE2+FRqhSfyN1uzlXfiNhADUfzSLjH4DTqjpR1ZZKbpj0NgDRoKXhG6mS4en7ycOPKjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783955335; c=relaxed/simple;
	bh=7imYk0fzRiTpdUI/pDv+vAry0Elduej49ekE2fB4Dfc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VlP2l1VQBhahzqzE1Aejbcj/N5G3kF+g29Bze0W7I6VR3peKUsJMq/GgQdmog3YPKBAjmWMcIATVjWMgRw/f8gQZ0J8IFe4hoTMOAhPzN2+oLKUpwISy/UJ4Oxl1OJAU4OUO3rdK+fewa8d9AKDIamyy8W+/1iQkrIva5Qppbi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YLa/b/ra; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8B421F00ADF
	for <cgroups@vger.kernel.org>; Mon, 13 Jul 2026 15:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783955330;
	bh=S2412bZGPWPZN/aE9c6H2BeupCTWZve94f17fgRu1LA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=YLa/b/raGv92tSdUv9UAWOao6aVFMj30Ug05SffbFSQtkpuRWwsvRajvBd5pu2xy5
	 WIVDnWlGAl/+hquRbDn5vIMhIPHRRXKZqAen1EhV6YpRGJBWW62T7DmypOZSNv9BBO
	 kipg7QzfVTX3Tx0np+AycgHjCdfOyP234p67vtwOBowb0bOUwyXvbsNlzVuTwlbj1S
	 /WMM3bcWWlzBzGLScvaYDdfVWgepFW+ffTKLZntpKQyTIinnig3TPdRVSfWDYVFCvg
	 V7zTr+v2+Qh9Dr3X1gFv2w6c/1q/wS+CnHZVB8e/JEvgf8Bhi3GnEMjD8NPc9Xej6X
	 yDnHw83VDkb5A==
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-92e7632b193so244407885a.2
        for <cgroups@vger.kernel.org>; Mon, 13 Jul 2026 08:08:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrPTN962mRvcHnKsXQDRlnmSMVKJYZwspEugaRnQ5slaUEHkbrZih1jSARcA8TyeGIa/ZMHisAM@vger.kernel.org
X-Gm-Message-State: AOJu0YzlkLp4fV9/X11z91tQmDjQEOLx+BaLCMm6WNar++KzhWGMNKTz
	uOL/nSKwcMdHniLuSnKlYWmV/0TAfuk5qLQ70ErroPopzvJzSL1/6y5jn5uPtMyo/WFilQF7R97
	9gb+UP07q2frvYVv9BA6TZ7nTDLEp4F0=
X-Received: by 2002:a05:620a:1787:b0:92e:c118:18c2 with SMTP id
 af79cd13be357-92ef2cb6546mr875536485a.77.1783955330036; Mon, 13 Jul 2026
 08:08:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260711091157.306070-1-ridong.chen@linux.dev> <20260711091157.306070-2-ridong.chen@linux.dev>
In-Reply-To: <20260711091157.306070-2-ridong.chen@linux.dev>
From: Barry Song <baohua@kernel.org>
Date: Mon, 13 Jul 2026 23:08:38 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4y39eSYqYwSPzqcZPk1wcJEYN3HZr83MPv8pMgN8Nct5A@mail.gmail.com>
X-Gm-Features: AUfX_mw4Br7J34oOX27RZ7iWI9pqul0zzHhz-BOIuYA7_p2QyaEZNYFv5_TepBo
Message-ID: <CAGsJ_4y39eSYqYwSPzqcZPk1wcJEYN3HZr83MPv8pMgN8Nct5A@mail.gmail.com>
Subject: Re: [PATCH 1/2] memcg: move mem_cgroup_swappiness to memcontrol.h
To: Ridong Chen <ridong.chen@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, 
	David Hildenbrand <david@kernel.org>, Yuanchu Xie <yuanchu@google.com>, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ridong Chen <chenridong@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17725-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ridong.chen@linux.dev,m:akpm@linux-foundation.org,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:chrisl@kernel.org,m:kasong@tencent.com,m:david@kernel.org,m:yuanchu@google.com,m:linux-mm@kvack.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:chenridong@xiaomi.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER(0.00)[baohua@kernel.org,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baohua@kernel.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email,xiaomi.com:email,cmpxchg.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F3FF374CEF3

On Sat, Jul 11, 2026 at 5:12=E2=80=AFPM Ridong Chen <ridong.chen@linux.dev>=
 wrote:
>
> From: Ridong Chen <chenridong@xiaomi.com>
>
> The per-memcg swappiness knob is v1-only; v2 always uses global
> vm_swappiness and ignores the per-cgroup field.
>
> Guard memcg->swappiness with CONFIG_MEMCG_V1, and move the helper
> to memcontrol.h where it belongs.
>
> No functional change for v1; v2-only kernels drop the unused field.
>
> Signed-off-by: Ridong Chen <chenridong@xiaomi.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Barry Song <baohua@kernel.org>

With some nits.

> ---
[...]
>         struct mem_cgroup_per_node *nodeinfo[];
> @@ -365,6 +366,9 @@ enum objext_flags {
>
>  #define OBJEXTS_FLAGS_MASK (__NR_OBJEXTS_FLAGS - 1)
>
> +/* Defined in mm/vmscan.c; used by mem_cgroup_swappiness(). */
> +extern int vm_swappiness;

This is a bit unusual. I'm not sure whether mm/swap.h would be
a more appropriate place for this.

Thanks
Barry

