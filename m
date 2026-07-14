Return-Path: <cgroups+bounces-17751-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oIbqCECUVWpwqQAAu9opvQ
	(envelope-from <cgroups+bounces-17751-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 14 Jul 2026 03:43:28 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF30750208
	for <lists+cgroups@lfdr.de>; Tue, 14 Jul 2026 03:43:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=SpkxnFaW;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17751-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17751-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E69CB303980B
	for <lists+cgroups@lfdr.de>; Tue, 14 Jul 2026 01:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A630D36BCE8;
	Tue, 14 Jul 2026 01:43:24 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BEE36828B
	for <cgroups@vger.kernel.org>; Tue, 14 Jul 2026 01:43:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783993403; cv=none; b=uqRuRp3q4Oorzcx17/jaJngzYdYW+Gv/v7BDYKSBgMqr9au4y/L0yeHM+H4YEU5muqkR4Tu4d0o8g2B4+hybpvh1TDNmqzlunbQYyFHUiFCAysyaEaUZqOLbuwonp1RNDHnH0ghZiGHBxhAe6cPuiUld9k9ivWwq5kAu5KpE3+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783993403; c=relaxed/simple;
	bh=9frZZjn6HN/GEg3932N1dcr6ge1qlUqvTomYjquedVM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=juTgiQulDn3nJSWg40KoCgmuHE7TiY1pHv4xZgIj8Vz19B22nBs8HoYOHGI94Pgt5KZtWtREV5up80WdM9yAKGromu4WVj5/OUDlf4tfgJjwCXFlmxROkN4vGj+FfS5Ibl1MQSCVZze6bO/7mkRQlgHJ2yOBw4WrWz5CELZmriE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SpkxnFaW; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28C431F00ADB
	for <cgroups@vger.kernel.org>; Tue, 14 Jul 2026 01:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783993400;
	bh=ZNMroDnaFepYZc/4huUd7Zc+6s2smxbRPSRvFEcecJg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=SpkxnFaWHOTlnomiAK5xhXSnZQ7KgvpHNeMNEbrRTVh/9P+b2IcN0g/0wbTIo3uiE
	 V3B19G27nYJawbYLWHSTZtS6yocGcVRgLWfXDAr5mJU59zV+Rdi5O9jjFmSSfen1g+
	 UHwggVK/mIKkQuCJ/V8Ftn8M2yxngNXv2vPI+Rbdykoof9qCtUTXFnK9sxTF2ejHjF
	 40xwUodA3Vl2flw0AZTiEfkZCYv8sjTQzOcXG8Lz3ldFQ9K/wh7aGMT/aeTIjdvQhX
	 IFy2ZYWgLwVMBFnc5mQV+y6ECr7CslOiIMjfT0jsQF8A3/Z+h+DSnqDXzmFMp/NKBK
	 6QBGGBemgdRxA==
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-51c15bf5000so22485771cf.3
        for <cgroups@vger.kernel.org>; Mon, 13 Jul 2026 18:43:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrV2igzrd5UPcnJjfDmK+oFpMPiQuts/SSEB8AvY0astgKbxigHpUpT9xm1unqmSG3eqGuxdkO7@vger.kernel.org
X-Gm-Message-State: AOJu0YzyYLTs/qpddb8ZtoZaG144piOa7SMXTZC2K5ZQWMhbSh2z2ttX
	K2ou5VAHN5+xEwKBUcSolPEMfzOi2SY/zrJePKwllXATzSiFg3+K1hG44049kbRqxfwx5tCVqsA
	+5u+05u9l7IC2rvzEwy1fnFIGiWNPJIE=
X-Received: by 2002:a05:622a:5513:b0:516:ea30:8756 with SMTP id
 d75a77b69052e-51cbf1426d9mr108072891cf.36.1783993399516; Mon, 13 Jul 2026
 18:43:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260711091157.306070-1-ridong.chen@linux.dev>
 <20260711091157.306070-2-ridong.chen@linux.dev> <CAGsJ_4y39eSYqYwSPzqcZPk1wcJEYN3HZr83MPv8pMgN8Nct5A@mail.gmail.com>
 <87dc4105-b98b-4541-bafe-c0adfbf58836@linux.dev>
In-Reply-To: <87dc4105-b98b-4541-bafe-c0adfbf58836@linux.dev>
From: Barry Song <baohua@kernel.org>
Date: Tue, 14 Jul 2026 09:43:07 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4wDMrdvGksTJ1SMGE=aHY3CMY529ceKDD68cXLsHQCjtQ@mail.gmail.com>
X-Gm-Features: AVVi8Ccz7OC-clOMQQnSoiYTuyEXEArtL6roBTyfk92e5g9qCCo-JodquNZChkw
Message-ID: <CAGsJ_4wDMrdvGksTJ1SMGE=aHY3CMY529ceKDD68cXLsHQCjtQ@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17751-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email,mail.gmail.com:mid,vger.kernel.org:from_smtp,xiaomi.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6CF30750208

On Tue, Jul 14, 2026 at 9:20=E2=80=AFAM Ridong Chen <ridong.chen@linux.dev>=
 wrote:
>
>
>
> On 7/13/2026 11:08 PM, Barry Song wrote:
> > On Sat, Jul 11, 2026 at 5:12=E2=80=AFPM Ridong Chen <ridong.chen@linux.=
dev> wrote:
> >>
> >> From: Ridong Chen <chenridong@xiaomi.com>
> >>
> >> The per-memcg swappiness knob is v1-only; v2 always uses global
> >> vm_swappiness and ignores the per-cgroup field.
> >>
> >> Guard memcg->swappiness with CONFIG_MEMCG_V1, and move the helper
> >> to memcontrol.h where it belongs.
> >>
> >> No functional change for v1; v2-only kernels drop the unused field.
> >>
> >> Signed-off-by: Ridong Chen <chenridong@xiaomi.com>
> >> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> >
> > Reviewed-by: Barry Song <baohua@kernel.org>
> >
> > With some nits.
> >
> >> ---
> > [...]
> >>          struct mem_cgroup_per_node *nodeinfo[];
> >> @@ -365,6 +366,9 @@ enum objext_flags {
> >>
> >>   #define OBJEXTS_FLAGS_MASK (__NR_OBJEXTS_FLAGS - 1)
> >>
> >> +/* Defined in mm/vmscan.c; used by mem_cgroup_swappiness(). */
> >> +extern int vm_swappiness;
> >
> > This is a bit unusual. I'm not sure whether mm/swap.h would be
> > a more appropriate place for this.
> >
> Thank you for your reply.
>
> The vm_swappiness variable is not utilized within mm/swap.c.
> Furthermore, since memcontrol.h does not include swap.h, retaining the
> extern int vm_swappiness declaration in mm/swap.h will result in a
> compilation failure.

If this is the case, it still seems better to keep
extern int vm_swappiness in include/linux/swap.h.

Then we don't need the comment:
/* Defined in mm/vmscan.c; used by mem_cgroup_swappiness(). */

It also makes it clearer that vm_swappiness is an extern variable
belonging to the swap module, rather than the memcontrol module.

Thanks
Barry

