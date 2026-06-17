Return-Path: <cgroups+bounces-17051-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FL7QN3G+Mmof5AUAu9opvQ
	(envelope-from <cgroups+bounces-17051-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 17 Jun 2026 17:34:09 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4343869B091
	for <lists+cgroups@lfdr.de>; Wed, 17 Jun 2026 17:34:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=vFR7EjS3;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17051-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17051-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2088A317B6F3
	for <lists+cgroups@lfdr.de>; Wed, 17 Jun 2026 15:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE52B47ECFF;
	Wed, 17 Jun 2026 15:10:55 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E70A47279D
	for <cgroups@vger.kernel.org>; Wed, 17 Jun 2026 15:10:54 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781709055; cv=pass; b=VGgA19YGNW4cvEO3Q4aRgMd8IpGsl/wNunBGIc9EjpLG5pGza7LC7qh4j6wwWyFZLPjhAzog7dkj+nJzhRneYuQAszn+QjLA7KbM7yaoQL2Ov9BRXvkhmRv0iau5Qh66WUv9v/DaEoCgO033EJVziByPofxgCEmRKf6Yibc86VI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781709055; c=relaxed/simple;
	bh=gryElRlaESvdlunLHhbnDO0S8K7V3X495hJBbeeGh9U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rkUSO6CX+ZMA0hNNHdaXE6JX2U30D9zuMVjauBeKZObYuDaeRaPKKBL8nKDlHRoIwndAdm7tk3WowjyjHfSgGOENCyAiAUMs4qJDHHRUX5MM5UFm2+IQW+lmF6lDxzvDVbqdP+ywy8ZSQCu9Qe/CLiGjLNSZVky1dk67APzBNcg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vFR7EjS3; arc=pass smtp.client-ip=209.85.160.175
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-5175d339e8bso294841cf.0
        for <cgroups@vger.kernel.org>; Wed, 17 Jun 2026 08:10:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781709053; cv=none;
        d=google.com; s=arc-20240605;
        b=W6gEhC0zweQEaEMY//T5b66Nu2HeQJna6i7QmEw5jU0pofOjr10CY2zkpMYK+2Wu3Y
         iCoMnsvOSSEwLqfW8IsXCq1b+TnX8WmYsVd7pdMqHornBN3VadojbG4qilRTD3QF2qRD
         uFsD93BFd8jL3uv/GGDZnrY6MeoLyoHDX5bDxn42mD4l0QK0kNnoCu7knbqR9FkadiR0
         fAOhyfw1QQdmwb4ejxlBz9x9n2edkxO0Ei3Nyqj/zlfYztfv3Q+rpIE1gYz+9wTX81NP
         ju56TISzcjkSR6u/+RHFfIPDX5NqocSI0f/9dU8EebB7hiowTQYQ2WCEXGzqB/9br0X2
         XNNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gryElRlaESvdlunLHhbnDO0S8K7V3X495hJBbeeGh9U=;
        fh=g2l4nEyGqlONc8MoBz7aLV4Z8mY4icqIqPEGpbiNdmE=;
        b=bqZdrG0so32Xy1hn6goqxDHHa4mPklzSCcAXLd4ZPAAzGf0C8cd5UERtuYnPbecS1A
         V5ATzswijPqxZWgxQxROJspA9omf1Tbb3iloSwysRF8zORJIU7uAP8nL5v69bYAaHZ+t
         i+P4/WDYFWQtF8RxNRcj9OpPXp0HeniMhh6SXkpDtFA7i658vJHL0vDdo/J+ETQj4qrP
         g9lpZFHPAtXOs79Bx0mdK1tCw/LOOFa/5hCF6nLzuzau6dTiXtMg+h0KXLdLM7p5F/Zk
         dg4zSC+KO3hIUcGoJIBzuSeXIN1tpqj/3RduaZKJRUr/oMRgrcfGzG6lgRDhpRsporbX
         a/yw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781709053; x=1782313853; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gryElRlaESvdlunLHhbnDO0S8K7V3X495hJBbeeGh9U=;
        b=vFR7EjS3rUIl/jHWGvs0n3g3U1U5wbyhFsckHDN6ULf5kh8BpRED1dyLNXlY40l7vU
         JBHvu20zLkmt8HxtrmeYLhUCK+Cg1+hwTe1kbh5byndn2qVYsAG5x5+5bqoCehCxK8lZ
         5YrSJ+aIPtotiTjhLQeSa9Xx/MGtWqEiCzHfHidLMPTr+l81b0Nf+dVI7WAK1d+RkrNV
         lB31Ixx2qI0tu2UyUnSTWbbBJic4cG8JKJprzcq9p65J3p6jFy9FydwcSY1wukr5sFp8
         XSXtOw0Giqe6/Nuqg4lQmne/PAI+OhegkVn/LcoYjrppXi9pPsy7qKgQAYgoXfRltyxA
         /zjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781709053; x=1782313853;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gryElRlaESvdlunLHhbnDO0S8K7V3X495hJBbeeGh9U=;
        b=LaPQiNxWXq2Q6d0ehQPPFAynHqwiigJVPasTIDU/xEdrV5c0tEyoaw4kXwF82dFDwv
         JfdJPrlyNV2R3jXcCgwCPFy0Nr6tZNMqyeC8IcDL9KYikvxUqEbtQMshwtTihpZAsYX+
         T2XKHcLW18hCSuM5lvk+5I6LsF1aHmLDCW5Ftsf8JemVvVtHKslt8yk753BPysa/6yUO
         4rmTQtAXfK3AlCTgtSYxQ0vrXjWwJ2OcXf5SvzCVh9OqsUbHTBmyat8vSlr1ilMVCC2k
         qGjMqAw+yNrfBG3oqBULXQMmbbN0Pzp/q0MyfLqgAiKHbflarhFetNTZ0P5835lwgQL3
         JwhQ==
X-Forwarded-Encrypted: i=1; AFNElJ8S64qcdJVRk2303l+pg160bT51CGn0i/oquW7BXR03w8Hx8bUbO/OXjr53A94f6gH80+FEOzcW@vger.kernel.org
X-Gm-Message-State: AOJu0YzYgAlavBytKbfPUyTtnSaVhvkWm9ouKRPPbf3HeMf+y2gcYgVr
	s7h2zHKT5JBNVHQgejeJAjKT3cAStWOfddshnnwzWD5f1vsQHnFNDzn0WcP9+PYOLyznRJO2dW3
	MZKvKPe8k7k8GIuT6hKVkzs/WmuE57whxFUt/O8Zg
X-Gm-Gg: Acq92OHelkg0u7KVxzI+eNmK5GZtdH78XrGyV1RoDtHbtmQ7dkPnQuvYb98OuKricaq
	7zacMwhOQkRW1xVYEBuRe5NCG1n0BJIVjOpdgwjeXiIkn0srbDwznfNOW/rdrjqCpyRUM+FJ6aB
	Pi/crJ6emXf/PUyXX/pDtwIgrCgpqV2Vyok7AEbg1Gqbm3/cnFTx1khfh8xCdV3uRTmK7U1u8ZO
	cnSyip/YyyiuCbecXCYVIapAwd3kb/TZrA7RjHoLsefZhoCOHC80QjdEMQgpzRz9fdhVH5i2NYG
	YB66Buv8RlCRdZ0DZKAcNUI/Igk=
X-Received: by 2002:a05:622a:4d9b:b0:514:b17e:86f3 with SMTP id
 d75a77b69052e-519aab877d9mr10980831cf.12.1781709052609; Wed, 17 Jun 2026
 08:10:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260615-slab_alloc_flags-v3-0-ce1146d140fb@kernel.org>
 <20260615-slab_alloc_flags-v3-15-ce1146d140fb@kernel.org> <918fae64-1323-46ea-a86e-3c847a52f174@kernel.org>
In-Reply-To: <918fae64-1323-46ea-a86e-3c847a52f174@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 17 Jun 2026 08:10:40 -0700
X-Gm-Features: AVVi8CecK8kUk7k580xJVGlwOxJX_MOMS1WZV6CQSJDW2f1pPxADvDgMBq8GS-Y
Message-ID: <CAJuCfpGXf-DLFTnV3T-o-9COo51EFg2MV8M0QbZEoJBCKNwoCw@mail.gmail.com>
Subject: Re: [PATCH v3 15/15] mm/slab: replace __GFP_NO_OBJ_EXT with
 SLAB_ALLOC_NO_RECURSE for sheaves
To: Harry Yoo <harry@kernel.org>
Cc: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, Hao Li <hao.li@linux.dev>, 
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:harry@kernel.org,m:vbabka@kernel.org,m:hao.li@linux.dev,m:cl@gentwo.org,m:rientjes@google.com,m:roman.gushchin@linux.dev,m:ast@kernel.org,m:akpm@linux-foundation.org,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:shakeel.butt@linux.dev,m:glider@google.com,m:elver@google.com,m:dvyukov@google.com,m:kasan-dev@googlegroups.com,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[surenb@google.com,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-17051-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4343869B091

On Wed, Jun 17, 2026 at 7:37=E2=80=AFAM Harry Yoo <harry@kernel.org> wrote:
>
>
>
> On 6/15/26 8:54 PM, Vlastimil Babka (SUSE) wrote:
> > Finish the switch away from __GFP_NO_OBJ_EXT by replacing it with
> > SLAB_ALLOC_NO_RECURSE when allocating empty sheaves. Pass alloc_flags t=
o
> > [__]alloc_empty_sheaf(). Callers that can't be part of a recursive
> > kmalloc() chain simply pass SLAB_ALLOC_DEFAULT. Use kmalloc_flags()
> > instead of kzalloc() for allocating the sheaf.
> >
> > With that we can finalize the removal the __GFP_NO_OBJ_EXT handling fro=
m
> > obj_ext allocations as well, leaving only SLAB_ALLOC_NO_RECURSE in
> > place.
> >
> > This leaves __GFP_NO_OBJ_EXT with no users in slab, so stop allowing th=
e
> > flag in kmalloc_nolock().
> >
> > Link: https://patch.msgid.link/20260610-slab_alloc_flags-v2-16-7190909d=
b118@kernel.org
> > Reviewed-by: Hao Li <hao.li@linux.dev>
> > Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> > ---
>
> Looks good to me,
> Reviewed-by: Harry Yoo (Oracle) <harry@kernel.org>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

>
> --
> Cheers,
> Harry / Hyeonggon

