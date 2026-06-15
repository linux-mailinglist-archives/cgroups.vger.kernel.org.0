Return-Path: <cgroups+bounces-16932-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CKeCJS+CL2rNBgUAu9opvQ
	(envelope-from <cgroups+bounces-16932-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 06:40:15 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A60F6834EB
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 06:40:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=q+tdCbz0;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16932-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16932-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9CDFB3003987
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 04:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5AB329898B;
	Mon, 15 Jun 2026 04:40:13 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F51C22B8AB
	for <cgroups@vger.kernel.org>; Mon, 15 Jun 2026 04:40:12 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781498413; cv=pass; b=PZ5di7Xx8/Win+zT/Qi/JipvDMv4dc12eqcK6VYNU8sgbBUjISVrrOZGdQbdoEXXRoRoffoAQgy3AmRpSUftAsn7SPfXukWNTjIU+2Pzvw2A9IES9NeXoqyU7XIeDevWeDvF8HzM7di2CorJ+uFm1XVed6SrdPCADNuOYMf3BJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781498413; c=relaxed/simple;
	bh=N8wL7Pot9TPYI6OkBDqQJP6r/aDUyNWYD85ZHyLvnQ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dfu8dek9GDEaQkptijaC6k9emuYJ1cbxMJ+2b/E9/LlZluoWxfrasmr8XwZv8CaGe6Gh9173ECPq6cmwxtNtUouXcrF4wmhmHXk8tDpDE0+vMOApwcYGcocJIa+K2Qdhzds/+0mP6o971QAqgwiZ8x57T4nvyqYE9aCl5Dd+HZk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q+tdCbz0; arc=pass smtp.client-ip=209.85.160.176
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-5177d1ff061so722771cf.1
        for <cgroups@vger.kernel.org>; Sun, 14 Jun 2026 21:40:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781498411; cv=none;
        d=google.com; s=arc-20240605;
        b=FtnM/HY1UPsB5R4UmUgcs5MbloJA4gQpNoI1u/laQkSQ3Bq9sPu0dA3hmxnMCisQTn
         fH7iV+d0Jty34zFPV9DaiY8L7nPigXTCjQ5GQgp7t/3iqjGPARPpzsGS5fGrDXivcUnQ
         p213ZojP8joPINYQZ0YX/f9LsWyKutWKOyO6Q7YijTpngcOblUfU3sYBKkALs+/FtmDG
         BweIIK6rpnPZNBXoC1TvN2Mri2+rb18jIuzX/ym6ewC77oBSwXBiPhoP0iVTcUowdHuS
         CQVpF9Ic0PvHrzutYa/HtsddgBf7z3WaLWEWc4e6gqUGI6Y3e+DIantZKxTKQngRjGPu
         HMeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=N8wL7Pot9TPYI6OkBDqQJP6r/aDUyNWYD85ZHyLvnQ0=;
        fh=YlvZWWHJDGf4Qx4b3s7nePxrVio+ypwsltDL8ARdk3M=;
        b=k4re4TkX1Gjh9aiGF492wwEs5GgSmUWtpo0JG4TWQ3WrQgMvL4t7uPrWFSkB9fIfq9
         ZuQFzF6qtiia8WubWDxKGl28PkK2Xq6IhL3BLnfNFir+SwqPOuNmF8xi+JeAXi+mNv9J
         /REr+SqCzvyq3y0YHSCbJSVuEvTRzxDPkIuyEf7WveZ1H3wDGIpgBCYTEUMXeTdYoEDj
         wdCk2KklTdK2WkM/UdzZzzIzfuN07QyzX1OEgEPLsUvrTMaFHPbb6kzHGN1hPNzKL0aa
         GdLvPj/HdY/GTSS0IinAP+y/j5dlCfLOFgXre3deV/cH1tw9TnBklbfOhLJIe63FPUgS
         7zjg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781498411; x=1782103211; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N8wL7Pot9TPYI6OkBDqQJP6r/aDUyNWYD85ZHyLvnQ0=;
        b=q+tdCbz0Lqlz0485KI8IwzWOQ5flKuGo4y8Yxk7gzIYsxP4nXsqr+D9i5byMxfEi2L
         W+fF9EguN6Jgt1/sEQHp6ySv3RIuYAgPUU/KQEPGzQEUG2nRNaoTQZmcQFeJsY00PVg0
         JVxMqbn3HyQtXVEQ5Ax5WpxJds3OjikS4S/V/p0su/VP1TfPfJOL5ldWem1qPOlhP8TJ
         u+QN0y5tHGn1WZKqWMoBLdNDKoovTYoXEWsO2dbXeqf5o5f/Gi4CUVABy39Rf3PsqbPL
         a5QDVmJfZnCpvmwVVU+VqsV8MxqK3iTt9+s22P1NWnOP3aFfdzLhmM3x+VYA8ot2YfPz
         0wLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781498411; x=1782103211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N8wL7Pot9TPYI6OkBDqQJP6r/aDUyNWYD85ZHyLvnQ0=;
        b=qjpTAbMWoBFeYHN0LEPM/LJLErnQq9Qyt9KJP8K+DCnk5ENFGlSn02SKoLWuYe5MkP
         QDaUg1WnS+GiegV0yljYpQjGHE6KeFV/l9Kk6BtkjJicGt56qbb1YXFDlJ+1YEpzMiwT
         y+0HfT8K7rpwuuX8D5KQWaIJAYBZ9+V9zCorInW7sNxs0KI6geIE6NwxezE9DSHft7UC
         6NQ2VPnYP8LRUek+2fLv0NHCLcpAaiv73Ocz0jmzlWCJlvydOMq0l8RzXVAvEcTDN84Z
         KCll6t5hvsgDRQis8Gn6Ls4XEHtfzdJVSCxUodYnwWkEZbvF+5IZkFQPLZgPlJV8O10I
         rgHQ==
X-Forwarded-Encrypted: i=1; AFNElJ/5uVV1zSGzXhV90qPKl4UhHJY9TZS1fOPguygzcJkc36izqy8jYMshLImE45/QiQMYOt1OYYZ1@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo55YxVlSzIG6Smien9mlG5FrG//fHLoptaYv2YQMJPX7lE5KT
	MMtxJCd8SQlrVEp+vK/TiUGdEAz/MrYXiRJfybo4UgmsSyHOrGpQ1n6vsrRWh+Nmzkj0Z+irNEo
	7an4F/jRrzfkaQNPUXJnVO4dIkg4fliD/ARDE3gXe
X-Gm-Gg: Acq92OFWPdqg91BKIpuyN3Y799vZQCIuFgsI3QZmUCpcK8/+ATkKu5XymFtifrS+IGl
	EwqTHQQx44wqKXM8dpYNJZVyCJI+g6U5MmccJOZnc5qmnTWUhwQhjjeZQUfC5QmxGx62zFdZEqK
	uP1zIrL+2cKJ6TWjqubGx90/LEl3jRpb0rYzo/mBTtyt/dzxLyEtGEvxpjeQdfJ1OjAxk+JNVhK
	VMtV7x130UakhB8i0PayCfplQz1HikgK28TRRzOklM/TVLDYqYxkbSMSedAt8XeIEmEHzZIEFgi
	GQHlkg==
X-Received: by 2002:ac8:5a14:0:b0:50f:be7b:923a with SMTP id
 d75a77b69052e-51955e93234mr11860351cf.9.1781498410717; Sun, 14 Jun 2026
 21:40:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610-slab_alloc_flags-v2-0-7190909db118@kernel.org>
 <20260610-slab_alloc_flags-v2-10-7190909db118@kernel.org> <aiuY1mDjpfCT94VY@fedora>
In-Reply-To: <aiuY1mDjpfCT94VY@fedora>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sun, 14 Jun 2026 21:39:59 -0700
X-Gm-Features: AVVi8Cf-uVQlgcYzn3DpB8ZEHMqqH72kWSMqcl7ovJhnnVzqopd4FHJddKgOOls
Message-ID: <CAJuCfpEKXTtfCFSx2kKN7T4dRNXg+7hMwQnrhSMey6DBH2fr7A@mail.gmail.com>
Subject: Re: [PATCH v2 10/16] mm/slab: replace slab_alloc_node() parameters
 with slab_alloc_context
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
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
	TAGGED_FROM(0.00)[bounces-16932-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,linux.dev:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2A60F6834EB

On Thu, Jun 11, 2026 at 10:29=E2=80=AFPM Hao Li <hao.li@linux.dev> wrote:
>
> On Wed, Jun 10, 2026 at 05:40:12PM +0200, Vlastimil Babka (SUSE) wrote:
> > The function takes all the parameters that exist as fields in
> > slab_alloc_context, except alloc_flags. Replace them with a single
> > pointer.
> >
> > This moves slab_alloc_context initialization to a number of callers,
> > which is more verbose, but arguably also more clear than a long list of
> > parameters, and most do not use the 'lru' field.
> >
> > This will also allow kmalloc_nolock() to call slab_alloc_node() and
> > reduce the special open-coding it currently has.
> >
> > Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> > ---
>
> Reviewed-by: Hao Li <hao.li@linux.dev>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

>
> --
> Thanks,
> Hao

