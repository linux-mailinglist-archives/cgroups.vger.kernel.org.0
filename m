Return-Path: <cgroups+bounces-16936-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id z7y4DWCKL2qOCAUAu9opvQ
	(envelope-from <cgroups+bounces-16936-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 07:15:12 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E240068369D
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 07:15:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=pLy6TdSI;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16936-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16936-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 604B3300CFCF
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 05:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F160430C14B;
	Mon, 15 Jun 2026 05:15:05 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097363093D8
	for <cgroups@vger.kernel.org>; Mon, 15 Jun 2026 05:15:03 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781500505; cv=pass; b=qvZbs+uP9qLu1sIuo8mCRX4b1MVObAF3bttNgvXQeX4yatrrhHGvQNrB9R8FO3wnueiUJgSfPJk2HIOC/HFUekFKZmj3zSTlKPk9r7jCQXL2sOO8b7jBbdjYDZduvIDO9nbOk7mEVi5ne9UmhuQTnsX7FeRmDE3v52DqlpQHr4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781500505; c=relaxed/simple;
	bh=3gNBX5x2LhwOmIQQDlsDq2J8ZH2ZLBGWp0xwFaRLaiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qI+XsvkS+w4q2x2wSfnWTeTrih+Uu4JwO0KQa3gbyM97Ohu69avFyeJzf8O+vR06nvByDkjhvuDnDOJmDUFOxnhLYbgUMlm0t6fuudYM+0nZ6JjFuXyGpBKqgIT9fKYV4qffg96+1jTsKt2hudVu1wKRReyxANxrG4punF4xR+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pLy6TdSI; arc=pass smtp.client-ip=209.85.160.169
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-5175d339e8bso831001cf.0
        for <cgroups@vger.kernel.org>; Sun, 14 Jun 2026 22:15:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781500503; cv=none;
        d=google.com; s=arc-20240605;
        b=jpvx/mZIp9Mr0uljEGbcKXrCv1A77wKUmVmkgHKQktUYfWDyRScYwSMa1faJHB/upn
         5SGOcZSBuwLdOExT0qHAAb3MdI47+hbj824TaT1USc50VxjgzM+U5ti1FbXBEQybpN1w
         QD1QHUOdpTEjeyXBPXakm6ChEwIRlLaVW922bO3jxqa2+WRE5dHlNm1On9QsP0xcgKD0
         aWAOUZ7I+sY6ADhbeElTOiNyDpZEadgb3yXOcJy36cwTFirmkkO7OV06CdX+uHV1dxkD
         6j9xVAScbDxOaxn4es6MZNqwf1/lVr4c1HWnifJo163jq8ktc2mGbHcvQX6RR9e2t1hb
         99Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3gNBX5x2LhwOmIQQDlsDq2J8ZH2ZLBGWp0xwFaRLaiY=;
        fh=xvfiwGSBvJKY6wNZRaU9K2hBUGi4CQbaajmsu4RqTi4=;
        b=Cht6EkriKsP+yEeO3mvwBKk1ERu41Wme1vrMgnZUTElh88khzhug4sV6ExNKfllFeU
         WlLwT6LgBPde/lJiACPRtbst3Dm0U6kD3/s4y7fmlS9OAr9VUNGNGkBPtfBX6YK6YU1H
         DwEehI4VtSO82L1ne6hISFZjJ1h5HcazVvQUdYbL9812Ac2joCCpwzTZ8MWUVcsOl0sl
         kzDsP3XNdkYtBbA6UbT7DXG24CrRssMNvbrgPPx0gDk47mLYhiUDuAMOQFY4Ajbi0TeM
         0IdgvRGmf1OU0cf1t+cHypMhx0aZ3hAmqbtgSQNs9CpyPVB04P4ba8k0lqxhF8ktlqH5
         AtVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781500503; x=1782105303; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3gNBX5x2LhwOmIQQDlsDq2J8ZH2ZLBGWp0xwFaRLaiY=;
        b=pLy6TdSI4JPoaB3snk1yfJCQ7N+QnA/JGT1XmFep9GKA4ahACSSWHUkOEkQ7cACGiB
         +oVY0B5R3ehOqXodEGXXDj9xe2QFM2QiziCDXou3b05jfyWtby6dXLAUmKqANT118dDJ
         IotLziGWDANijLZEaZPnqRzyrfWfw7pSoPwddQq/dZcZTHhAcRv3ZfDW1ZSDtZDdaeLx
         cjP5LIlEEemfIqn5MlZNTQy0SAF/5fJmziF2HQTHNyTdaRRdg83Hbhk0bctKnLqYsu7P
         bY7J+ef0iDkC9m1uHEDeU+AlFLLIXbOQjN/fZTT8+X59dzoBx7/nYqf9kjonN1+iaXkg
         OcHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781500503; x=1782105303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3gNBX5x2LhwOmIQQDlsDq2J8ZH2ZLBGWp0xwFaRLaiY=;
        b=ZP/BjDLPe7ewYUyvI6+ApILfJxDWnELiTI2NxWQt8Za2mbIHkX91unJ+0rTA1ZkV5M
         GmToAdYNAAKcGjijKx7Wm+QLxWgK1Ax6bzATDDLQHQOobbRa7DBVQy6gaUEHkcrGISTI
         U157N4HjS4ZG0NWIJQdcOVqmOY9omWjTcB2RZthExeeOHAf3ydBwygb4nLBOvhcUAmgT
         d5JG26SYQW3DgbUDqg6DbfRI2Uf3Tb44F3ZASd+3vGBsPVL+A62ESnVSE+BATgLXBpgY
         88atfSavShErTeedGyussCtzCLyOYYze1i/M1Wj0/eFyk8+S8OXUJqqDtyXvIFsLKCuN
         7CmQ==
X-Forwarded-Encrypted: i=1; AFNElJ8qTy8DUxAE//O0yNY31gMrm8e01C6ocNP6regnnNWsMkb9TR4h1ySH94fE+abTtcBhN5reGGYN@vger.kernel.org
X-Gm-Message-State: AOJu0YzmcjL0ks/z4BTHUTxbFyLdJ7k/KVAdZHhVd+Uh37h7MTvX6BOR
	jZANWLCv4b2LYXbUt/mnKhDfe+myWpUAq4R+thIzBB8ybfCj1aFDGYyPCx9/NbGdZbCG1fO9/Fb
	1T4AaeKXp6MZcPR6T/jZTJQnJjmObt+UOP/v1Zy/2
X-Gm-Gg: Acq92OFicff4AXqt+X2JNHYX6T1j2g8R8zPLi4gi5b2h7jvgzEftqohyCMO04w77ozw
	4IO6H8/DnSQ799hLu45oMe+kuuvY8i5ogympG6jmW8XVd3RvJW4iVKqVi7WNUt5qGfHZCC+42j5
	SjymIedupB3E63rwgOsBP9SccLOlACL3AWNqzu+dUa+e5T8C0rmgrNZ2CMrG3ayyxkVMs7yMCAP
	dJuOzTAQExrfEgOA9ag9/SeFs9kgDPmEskxdbKQQwqMiQLoMSGbI/q/Qlu3rT/sH0TtdFxvWRaS
	LXheSw==
X-Received: by 2002:a05:622a:30e:b0:50f:ce97:3b84 with SMTP id
 d75a77b69052e-519549c5a9dmr13031241cf.6.1781500502356; Sun, 14 Jun 2026
 22:15:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610-slab_alloc_flags-v2-0-7190909db118@kernel.org>
 <20260610-slab_alloc_flags-v2-14-7190909db118@kernel.org> <aiu8W3EQhalCP9HW@fedora>
In-Reply-To: <aiu8W3EQhalCP9HW@fedora>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sun, 14 Jun 2026 22:14:49 -0700
X-Gm-Features: AVVi8Cc8iefsPrhDpy6jKSpZmymgWH6dzb08vFxAcF-2MAS_up0x9W_1CMPzClM
Message-ID: <CAJuCfpF4f5=e+y0di=skS3a8_e1e4Ymtk=hSsc_dTNpmLhywEg@mail.gmail.com>
Subject: Re: [PATCH v2 14/16] mm/slab: introduce kmalloc_flags()
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
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
	TAGGED_FROM(0.00)[bounces-16936-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.dev:email,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E240068369D

On Fri, Jun 12, 2026 at 1:03=E2=80=AFAM Hao Li <hao.li@linux.dev> wrote:
>
> On Wed, Jun 10, 2026 at 05:40:16PM +0200, Vlastimil Babka (SUSE) wrote:
> > With alloc_flags usage in slab, we can replace __GFP_NO_OBJ_EXT with an
> > alloc flag that prevents kmalloc recursion. For that we need a version
> > of kmalloc() that takes alloc_flags and use it in places that perform
> > these potentially recursive kmalloc allocations (of sheaves or obj_ext
> > arrays).
> >
> > Add this function, named kmalloc_flags(). Right now it's only useful fo=
r
> > these nested allocations, so it doesn't need to optimize build-time
> > constant sizes like kmalloc() or kmalloc_buckets.
> >
> > Since we need it to support both normal and non-spinning
> > kmalloc_nolock() context through the SLAB_ALLOC_TRYLOCK flag, split out
> > most of the special _kmalloc_nolock_noprof() implementation to
> > __kmalloc_nolock_noprof() that takes a slab_alloc_context, and make
> > _kmalloc_nolock_noprof() a simple tail calling wrapper with the proper
> > context.
> >
> > kmalloc_flags() can thus determine whether to call
> > __kmalloc_nolock_noprof() or __do_kmalloc_node(), based on the
> > given alloc_flags.
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

