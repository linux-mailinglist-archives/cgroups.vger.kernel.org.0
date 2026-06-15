Return-Path: <cgroups+bounces-16924-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lzf3MwtdL2ps/AQAu9opvQ
	(envelope-from <cgroups+bounces-16924-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 04:01:47 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C3B682CE5
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 04:01:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=Ttv+pflp;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16924-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-16924-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF3DF3005796
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 02:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5275921D3F5;
	Mon, 15 Jun 2026 02:01:43 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA04E17C220
	for <cgroups@vger.kernel.org>; Mon, 15 Jun 2026 02:01:41 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781488903; cv=pass; b=FNZzodQq7TieMViKPl6y0a4w8cgU1zv57NhgvIY2jkPMsom8XKk9k6+X7fLVLM/DdkEzAFtVhkscCbYC5b+fmrxXQRql/E8vU3PFQX2u/0m5NigKHvGe8wOi7qeggJLkw0OAcdyAS6axNMt6WyWG5LDCRDoDVh/LMZzkEColZuc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781488903; c=relaxed/simple;
	bh=N2Ow1sAoBe980wlQzlYNnDrqp2nFrA+gdxhrOQuTe0I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VeVscU1+DZlQDhBPkCQuIOXuvOBsRpuUgskTv2Te+GqNvdp5pQqJAxxex545KDs+401Xph6cfygYVTCdILL4yNjnHOTETQdprvYcN8Z5QRnbZ7HbyyV1AiyiyqTSMctk2XkQiv1giSRxdKx9sSq0hjCyYHPN+pIjG8OQAmWANbw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ttv+pflp; arc=pass smtp.client-ip=209.85.160.180
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-51765331535so705641cf.1
        for <cgroups@vger.kernel.org>; Sun, 14 Jun 2026 19:01:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781488901; cv=none;
        d=google.com; s=arc-20240605;
        b=lx1I88BWrybTriNNpRZjPrJdKQXEHb1SEz2t80dajPdtwdGxG6Ljf59aRWm4wN7LTy
         56702tIbWyiu+T0KKUlCRP8cDod4ELVxaLje/qZx9d/Du+4P3NyE0aSQGEKzmznnotvH
         hoI8/QelBtoaD6ZmeXAe7G6gRna1Zkq7pPlbbaDwFg4qusFryuuS9zHkJRqb+A0btCTr
         Eu8fLeSsbP2Za02ujzNLq0J6A9u9XcwR47JEWeV+dNrlIcdxx4bSO5YtP/9PcLCJD0OA
         /oXuZ9UuFn0snTmiZ+RsmPn5JvH6aAjiVDpSiMWZe9853Llp+o5lwW2eWrNC13GAhKmv
         0Z8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=N2Ow1sAoBe980wlQzlYNnDrqp2nFrA+gdxhrOQuTe0I=;
        fh=zIUclfNHIrOrcH2xeFGbWSHPMIf3yShCFRy3EBJ4LqY=;
        b=UMWDol2RFW+0LDfMLZf3JTJgUBFIpgrV8s1SKtQGEtXSZ5K2vII8xMNFuZ0uQP1zfk
         06hw8EwlbOsXg+eRBkSmXPtbzQtuwTtmnVlvDk4IFWDA/wUCyXtJdMo/AH8rl4VsKxnw
         yHrXo5MQFQV9CpWZfyd5qTom9HXQggLHVS03wpMus3s2285pG4rKE+yjvgnGfyIz4PWI
         mKPH9zx68nx3E6XPxgFNVWLq9eIXywKaYtyX8rl75SPI18TasHL/EEnfQ0nfw1cNy6H6
         ywSs27OU3YwP3ZjfQONw+wv++jGGJdGQenlAVogLmxdUtqeo+rLOHOj52R583Lwr3jU+
         o4Kg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781488901; x=1782093701; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N2Ow1sAoBe980wlQzlYNnDrqp2nFrA+gdxhrOQuTe0I=;
        b=Ttv+pflp/ZRTVxAqlfvdJHMQOGTRh6ueyv/u/ZSymCAWlk+C6A3RoEvSq0DSIqgLB3
         603m1mKyaBjkhDiV2JQJavb+hjqSxRz0Efcz4FSySOUI7rGQWD9pfXXJkzDHpjHXKuGv
         pk+IzAQWLYzr0adangqfcpkMSwSU4T/xVc1mvzpDZm9IPuLbJrXlJ9TxC6oiMRCovNRM
         J5NcOSbjCEvXzlfpRaHVYa/fm4jR8Z/hpysXNdeb7Ofv7uTgiLkrbdIdEtF1CSHSXfSv
         hQHQckrPzpuHm1Jb8pnJdMSsy/Bxi73IlYfrZZW9TKZK5xg+71jE6xljbc1YqX9mYI6h
         6HkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781488901; x=1782093701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N2Ow1sAoBe980wlQzlYNnDrqp2nFrA+gdxhrOQuTe0I=;
        b=c98JQ5/xsewUqsMn6WjuG/FRx5q0yPtV//1/kjDm9eyd1tH8MRfEuGQgA0OTqUBX8G
         H83Xhtw0Me6Kmp+FErdKQzkPxaKsCdiTDAaK6jLrcIOASB5fq5mzoXbSVEVIc/fUzpHW
         K4NDoeoCyqyIhUEboXgo6lGfOk0QT6Z7LXmqAqcfJT8PJW1k0MgG/5wbZJTOyFXrYb5/
         xUMbjE4FzuytmYrxXgFxarblDdBQo3rGQ8tYPGLjF0w3ys4VOuk7pgg8ma9xwJGOED78
         dd0SBNCUnL/yqbhQqbaeVdAWEaTlL3vfdP030KjXnuDXabxxVEzSV/xR3wcKvI+UvMkd
         a06g==
X-Forwarded-Encrypted: i=1; AFNElJ+H6UEtKcNBVbU0xIRybPMDROcMoaqZBhO8aDMyXkVVvcf3RIJk9UbmAuS+oCjVUXJGaV26RrJW@vger.kernel.org
X-Gm-Message-State: AOJu0YxxwyjMnabDRVkt3NBOCdR1KJWSj2bU5DEghOQhT2WzU8EfgKZZ
	OEkDYuDL6RYa7mKwILWww5cx4ZzfWoQac8PE+6plduEO1onBoAppj+xIs8SCO3YFO5tevC3E45h
	F+tC+IhWghTA1f0Y3sn9YE75wC0b7dlnMxS77cw78
X-Gm-Gg: Acq92OGuXC/s/aeIXm27GSDO9p0vEePCzEFybeYaDr+H03qrnIqK58nGa4Sh8zv4h7K
	jUjNYOvTl80OGT6kumKv40G5172+fWEmkktV7iuhAUZ1s0dtcvWUA6xvnFsuBpqpETprUCNtgpW
	LDV+ZkSKDHQUcos9tso4BgA9Aahqev1/C/exluME3vPQA3MVsgybEoEABikHeY+uMe/DOO/F4JP
	j+W+fs5AhPmtDLIsEKSJLPI5Wwt1+CKBiRAK3kOjLAD2GkLndsm8qNH3YgfHt0nMsK1Bfs/lcuw
	TKiNqg==
X-Received: by 2002:a05:622a:1195:b0:517:99ea:ab7d with SMTP id
 d75a77b69052e-51955ec344bmr11553371cf.23.1781488899532; Sun, 14 Jun 2026
 19:01:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610-slab_alloc_flags-v2-0-7190909db118@kernel.org>
 <20260610-slab_alloc_flags-v2-5-7190909db118@kernel.org> <aiuBoDbQc0N-l7e-@fedora>
 <CAJuCfpGSHfNUvL9AzbftSg=uGRW4cJLbO6iB15keyN6A_eSWEw@mail.gmail.com>
In-Reply-To: <CAJuCfpGSHfNUvL9AzbftSg=uGRW4cJLbO6iB15keyN6A_eSWEw@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sun, 14 Jun 2026 19:01:27 -0700
X-Gm-Features: AVVi8CcPpLFopscn0IxYxXYrQ4AGFOmrCZ1O8V-xF1QOAQJ5QpAuLPZGu2tne4U
Message-ID: <CAJuCfpH-zz3dnN+j2o3LQjYLpFZZkyA1x176nsPQ5_r3NbY27A@mail.gmail.com>
Subject: Re: [PATCH v2 05/16] mm/slab: introduce alloc_flags and SLAB_ALLOC_TRYLOCK
To: Hao Li <hao.li@linux.dev>
Cc: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	kasan-dev@googlegroups.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hao.li@linux.dev,m:vbabka@kernel.org,m:harry@kernel.org,m:cl@gentwo.org,m:rientjes@google.com,m:roman.gushchin@linux.dev,m:ast@kernel.org,m:akpm@linux-foundation.org,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:shakeel.butt@linux.dev,m:glider@google.com,m:elver@google.com,m:dvyukov@google.com,m:kasan-dev@googlegroups.com,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[surenb@google.com,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-16924-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[surenb@google.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 35C3B682CE5

On Sun, Jun 14, 2026 at 7:00=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Thu, Jun 11, 2026 at 8:50=E2=80=AFPM Hao Li <hao.li@linux.dev> wrote:
> >
> > On Wed, Jun 10, 2026 at 05:40:07PM +0200, Vlastimil Babka (SUSE) wrote:
> > > Similarly to the page allocators, introduce slab-allocator specific
> > > alloc flags that internally control allocation behavior in addition t=
o
> > > gfp_flags, without occupying the limited gfp flags space.
> > >
> > > Introduce the first flag SLAB_ALLOC_TRYLOCK that behaves similarly to
> > > page allocator's ALLOC_TRYLOCK and will be used to reimplement
> > > kmalloc_nolock()'s "!allow_spin" behavior. That currently relies on
> > > gfpflags_allow_spinning() and thus the lack of both __GFP_RECLAIM fla=
gs,
> > > importantly __GFP_KSWAPD_RECLAIM. This can give false-positive result=
s
> > > e.g. in early boot with a restricted gfp_allowed_mask.
> > >
> > > Also introduce alloc_flags_allow_spinning() to replace the usage of
> > > gfpflags_allow_spinning().
> > >
> > > Start using alloc_flags and the new check first in alloc_from_pcs() a=
nd
> > > __pcs_replace_empty_main(). This means some slab allocations that wer=
e
> > > falsely treated as kmalloc_nolock() due to their gfp flags will now h=
ave
> > > higher chances of succeed, and this will further increase with follow=
up
>
> nit: I think it should be either "higher chances of succeess" or
> "higher chances to succeed".

And of course I misspelled "success" :)

>
> > > changes.
> > >
> > > Remove a WARN_ON_ONCE() from refill_objects() as it's now legitimate =
to
> > > reach it from a slab allocation that's not _nolock() and yet lacks
> > > __GFP_KSWAPD_RECLAIM for other reasons.
> > >
> > > Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> > > ---
> >
> > Reviewed-by: Hao Li <hao.li@linux.dev>
>
> I would call SLAB_ALLOC_TRYLOCK something like SLAB_ALLOC_NOSPIN or
> SLAB_ALLOC_NOLOCK but naming is hard and I don't claim myself to be
> good at it. So, feel free to adopt my suggestion if you like it or
> ignore it otherwise.
>
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
>
> >
> > --
> > Thanks,
> > Hao

