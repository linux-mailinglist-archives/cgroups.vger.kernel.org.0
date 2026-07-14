Return-Path: <cgroups+bounces-17781-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2KIjKOo9VmpU2AAAu9opvQ
	(envelope-from <cgroups+bounces-17781-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 14 Jul 2026 15:47:22 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A63E75551C
	for <lists+cgroups@lfdr.de>; Tue, 14 Jul 2026 15:47:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="LB/8CSbN";
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17781-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="cgroups+bounces-17781-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9EEEA300491F
	for <lists+cgroups@lfdr.de>; Tue, 14 Jul 2026 13:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C547477E33;
	Tue, 14 Jul 2026 13:47:13 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B132745BD6F
	for <cgroups@vger.kernel.org>; Tue, 14 Jul 2026 13:47:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784036832; cv=none; b=tkdCdQAgria0OWteNKAE3pCTN7ykslseb0ZsrGe7/v9CVtxnw6NyHUno3ex8fk2/LwHyXpuvCW5SnrvbdqgV82TRVo+ZmbHQVXxJRQUA75IqKAjiWf9ZJKgEQzMdSN+C+1qBV4AVhX7oU4WlAMGqpAinGQPb9pGROA96HN6gvfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784036832; c=relaxed/simple;
	bh=J/MgbCRpYdKveBwJQwaMNReigKbH5UDqXw3/34RUAMc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WGlaJR52Na1q09E2cRzU2DnA8IYKtv8cYjdaXqWTEtK60YCnDKOHYq2QKHS7uRUwL8C4qNySugTbedlaMBZf4vhrePnmGxAORBDxgOF9RYDupf7c3udqmlcMLgO9ngzaUJ5TtdIgDK+kSBIdMD0CAvZtFtecN6gQuGZyAl5Jcz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LB/8CSbN; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69F861F00AC4
	for <cgroups@vger.kernel.org>; Tue, 14 Jul 2026 13:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784036831;
	bh=LVXdaK2c8G8evNsHKw/C2JRPENt3K5Jpb3OpKjeLkUA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=LB/8CSbNgC0TdnmxsKyQrPpzOy7HzaXj6/F3Ax7OgH4RzmEEObjOVZTder8OBvXEV
	 8tePK/5pGDcD3kJW70FwgGZQZVHwsuIAoVor3mapUe9ypgEZNHpPn4WCxgQ8t/iyoi
	 4I0O/uih9TREsTxiL0Duh+RDatUe/xyYUK0M5T1VMWyG0wvh0yrD5x3MekJp+XCea2
	 Ac+pR/nzTlsVNdDilXaHxyLY4QGDTPPzVjEuXIzMpxG/4OV0aQaq/XHZDhbUIHry+w
	 pDhKwuX7VB/BxNPlOTfcXOfesziaxjVuO2YzUwWbb7PpMc6AYW30RV89P00FYgx7GX
	 b6WVxYPJD51jQ==
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-9217d13c276so277200085a.1
        for <cgroups@vger.kernel.org>; Tue, 14 Jul 2026 06:47:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rq3dBklCO6ShMXR4C4k3ipMmbAHIPOjTByT/u5YQjCWYoyW+qopHBbmPHgP0hIc/Z1swHEJpp7L@vger.kernel.org
X-Gm-Message-State: AOJu0YxtxeX3EEQPCXJ79Awx+aj3bmzRFzVZjLg1iJTH6Z2daCOD13wq
	yrw7/4PhZqoHnusACssaJ3LnjoGxfUugNhjpQTO5hZG3/oiPuvBhogyC+VF2A+2OGoyooNVsvT0
	vkdzIAs0hYna5/Ltqta/VSzsVhnK90l4=
X-Received: by 2002:a05:620a:27d2:b0:92e:efc8:cbcd with SMTP id
 af79cd13be357-93083c766c9mr310969485a.34.1784036830770; Tue, 14 Jul 2026
 06:47:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260711091157.306070-1-ridong.chen@linux.dev>
 <20260711091157.306070-2-ridong.chen@linux.dev> <CAGsJ_4y39eSYqYwSPzqcZPk1wcJEYN3HZr83MPv8pMgN8Nct5A@mail.gmail.com>
 <87dc4105-b98b-4541-bafe-c0adfbf58836@linux.dev> <CAGsJ_4wDMrdvGksTJ1SMGE=aHY3CMY529ceKDD68cXLsHQCjtQ@mail.gmail.com>
 <CAGsJ_4zcgURKZKBAc6i0Y5g7u2OXjENDE7A=nqYcQ9TTVuR=Hg@mail.gmail.com>
 <0545ee70-b0a0-4a93-ac2c-3e84ff504e5a@linux.dev> <CAGsJ_4x7cg-L_OzCdyZy+8zoKptVi-Jh18k1HRkvTBTbn-EQRA@mail.gmail.com>
 <bfb1cfa1-691a-4bac-beb6-caef9b3ac4e8@linux.dev>
In-Reply-To: <bfb1cfa1-691a-4bac-beb6-caef9b3ac4e8@linux.dev>
From: Barry Song <baohua@kernel.org>
Date: Tue, 14 Jul 2026 21:46:58 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4w8P8ERoXJY70wXf71MYEA16vX+JMAaE4sfB4=OqzN_Pg@mail.gmail.com>
X-Gm-Features: AUfX_my8Wy9WuK8pVudQOCevj6gZzWFIrCPc6vkC_rIS3KHDzSv4JuNzHZriO3A
Message-ID: <CAGsJ_4w8P8ERoXJY70wXf71MYEA16vX+JMAaE4sfB4=OqzN_Pg@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17781-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,mail.gmail.com:mid,linux.dev:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3A63E75551C

On Tue, Jul 14, 2026 at 7:31=E2=80=AFPM Ridong Chen <ridong.chen@linux.dev>=
 wrote:

[...]
> >>>>
> >>>> If this is the case, it still seems better to keep
> >>>> extern int vm_swappiness in include/linux/swap.h.
> >>>>
> >>>> Then we don't need the comment:
> >>>> /* Defined in mm/vmscan.c; used by mem_cgroup_swappiness(). */
> >>>>
> >>>> It also makes it clearer that vm_swappiness is an extern variable
> >>>> belonging to the swap module, rather than the memcontrol module.
> >>>
> >>> BTW, if mem_c_group_swappiness() and vm_swappiness are only used
> >>> within mm/, could all of these be moved to mm/swap.h and
> >>> mm/internal.h instead?
> >>>
> >>> We are making a big effort to move many unrelated things out of
> >>> include/linux/swap.h recently. Could you check?
> >>>
> >>> https://lore.kernel.org/linux-mm/20260708-ch-swap-series-plus-folio-l=
ru-cleanup-v9-0-2bc72b4f8730@gmail.com/
> >>
> >> Good suggestion. Moving them to mm/internal.h makes sense. Will update
> >> in the next version.
> >
> > Either mm/swap.h or mm/internal.h.
> > vm_swappiness probably belongs in mm/swap.h rather than
> > mm/internal.h, right?
> >
> > BTW, I am not particularly eager about this cleanup;
> > it could be done later as a separate patch.
> >
> > If you decide not to do the cleanup, I think it would be better to
> > leave "extern int vm_swappiness" in include/linux/swap.h rather than
> > declaring it in include/linux/memcontrol.h?
> I noticed that some swap-related macros are already defined in
> mm/internal.h, so I'm planning to place the code right after them for
> better grouping. Does that work for you?

We also have mm/swap.h, which is dedicated to exporting
swap-related things. Is it a better place than mm/internal.h?

>
> ```
> ...
> #define MEMCG_RECLAIM_MAY_SWAP (1 << 1)
> #define MEMCG_RECLAIM_PROACTIVE (1 << 2)
> #define MIN_SWAPPINESS 0
> #define MAX_SWAPPINESS 200
>
> /* Just reclaim from anon folios in proactive memory reclaim */
> #define SWAPPINESS_ANON_ONLY (MAX_SWAPPINESS + 1)
>
> extern int vm_swappiness;
>
> static inline int mem_cgroup_swappiness(struct mem_cgroup *memcg)
> {
> #ifdef CONFIG_MEMCG_V1
>         /* Cgroup2 doesn't have per-cgroup swappiness */
>         if (cgroup_subsys_on_dfl(memory_cgrp_subsys))
>                 return READ_ONCE(vm_swappiness);
>
>         /* root ? */
>         if (mem_cgroup_disabled() || mem_cgroup_is_root(memcg))
>                 return READ_ONCE(vm_swappiness);
>
>         return READ_ONCE(memcg->swappiness);
> #else
>         return READ_ONCE(vm_swappiness);
> #endif
> }
> ...
> ```

