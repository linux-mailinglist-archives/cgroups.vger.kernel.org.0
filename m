Return-Path: <cgroups+bounces-16923-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gjUSIfBcL2pl/AQAu9opvQ
	(envelope-from <cgroups+bounces-16923-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 04:01:20 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DF289682CD6
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 04:01:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b="dHHqREO/";
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16923-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-16923-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC80F3006942
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 02:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329DC1F91F6;
	Mon, 15 Jun 2026 02:01:01 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43E82CCC5
	for <cgroups@vger.kernel.org>; Mon, 15 Jun 2026 02:00:59 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781488861; cv=pass; b=uGrw0GvkdVHwgmzdAN0MCn1ri/QwIEsk8/fKviJgRm8of4O9bDmPhP57/WXv1gXbm0pXiEE/s+1sxvPgC5eMVT3DbZuFj8qDregvEP0C/9qT+vH/4nOVtEC/e7pBXNPu8LADjqrfIUAtQ3gQBcDWIciSoyXJ7nLEIi+nO3vnApI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781488861; c=relaxed/simple;
	bh=YV4ABaGU36AUsGc4VJ0A3r+5UPPchYWDZya8U2LFpH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TIjoG0rwkTKf2ejUkeU99eF1nf5762s+9tSajmmGFQ/f96tR5Q9GalDp3XKmNnjs97JcdvCjJTu3/nJE4iEPJBNADU0zkRaeV5Xhd2QU/ROplwCGTd6Sj/PwNmRTr5TvgYudr/H88tLTeGojjVXTyKiR4gvL6Zdg7lb4dLzrm9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dHHqREO/; arc=pass smtp.client-ip=209.85.160.180
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-5177d1ff061so668111cf.1
        for <cgroups@vger.kernel.org>; Sun, 14 Jun 2026 19:00:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781488859; cv=none;
        d=google.com; s=arc-20240605;
        b=OTPs3BoGo6E4yQQ3UHaIqH8GX7JicmVTPaf/Fs9QSpWYDcomF0cnJ7c5elXWhWxikx
         S4SHTlhboth56F+f1/0V/Zxc3OtvZMiWBT9mMyGjEaNPuIPdlObOdpXpg9KUqxhWpH8/
         p8+V/8/XY+E0LHCImVQwItbc7kjRwkyndG+DOk0shKUjcs9cJigTEYns5GdyQOnBDeVE
         FCORdSWaYZiLKtctj/oLQMAmMmQUz26PWD6QnmOLvsDy9eOTDQKCF21NKLMnh98iiTi8
         wIfVAJFGvII2xdzPaJGd5o3MCP4nv2HjtRtK9VUCGVGm8yM2bcJQEpnYJSDhLZo/yTI3
         vMJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YV4ABaGU36AUsGc4VJ0A3r+5UPPchYWDZya8U2LFpH0=;
        fh=IkHFXLesqtjVULzkUj/5rBCimtcGU2jeorrH7GY2yZA=;
        b=ApOjNfGZDzO2eqmIDAyLsVN4NM3n4hpBbAzMhEcqikH0bhnM79EtidVCzDxy9QomZt
         BiiHUCXEqH9+G5T2CtViVUPpbiY2ZMt9KhOuWg+Y5pZjOh4lGrArCYqpDCshHGIfNQh0
         NyXOdDZOvv8gdUFzONXtaKdGyeuKEI17yAPs+u2TmGg9TxWcjQAn/4vR4LXdiofdXHnV
         ovW3qOOJyo5Ye6btJ4iX73UxNxwdghkjVIX+tbCsXCOpR+74jkJHLpCi3Cs55RTInHoY
         z/DK6sdJ+CWNPkXHThD01m3jT0bAhav6Ui+Iby2rB6Ulczc7cchTKH3u6lyK1Utz4PNo
         JEvA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781488859; x=1782093659; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YV4ABaGU36AUsGc4VJ0A3r+5UPPchYWDZya8U2LFpH0=;
        b=dHHqREO/uF0E07nILv1MttM9AWHSeukHLU3MuoxA20ZklS5p2CNPgc4R9oJZ1jwqY9
         nO/QGg6hfCQTmXBaPw7zeFg+HJlS8Fi8ORJo8mRg5W4uUWybCAyIhr2VAHhhOuuXw6gb
         B9pgVW9So4rx6C8rubWJlFLHB8EICTemWj+UX0MjQCSt5H67lECtL+6WJnrhlM767zHa
         6kPi/PVT4Wo5ySWxzVR7wJVTcDUUssGfaIXvklt+JrhJaf5iQnVwZgZJbNPLyPIJhhJk
         C0lGI8lb8QZSuVwepJGuF9MwgIxtUrHkaNJOYR4xt4YY53PDlX2LEaUIYJApw9iM6APK
         Sb/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781488859; x=1782093659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YV4ABaGU36AUsGc4VJ0A3r+5UPPchYWDZya8U2LFpH0=;
        b=GltoXu5FiexDJmalMWgHScxBPYTJGvjhBk3vEzPUnvrKaHY2j5849VICsowjuyCZzB
         CdorD/3/Eydm8F4oy0ArS+c0UrVw+TjASnj5obSIdXrfG90bY39b4VmsGHi+zNTA9rdy
         qM0m/MfVzzicMLGd46NbWZ4s/VnKC6IO9UNHLGlt47VaJ387WA7BdN2XHYQxjXd4CgRt
         Z05JO3on9OffKUvw73EK+hFSrXvINvS/xgIu+Q0GzCrsW/XKdZ77p8NZ0Yr1cmZ4pm4Q
         3fhhN57VQqK3UiuyyoSI4hbfH0pBWSZ4U7ZNVCz/psqJaAF6jH5RglU9cdZVMdrUSeiq
         lDWA==
X-Forwarded-Encrypted: i=1; AFNElJ9Nb2wKt9cag6LkAC+hHVhL+RaHYz5HN3x7jlS5NMofqA0k/AxzGG1To5Em+ov/Bhz09mUqzAPq@vger.kernel.org
X-Gm-Message-State: AOJu0YwJLulKl+l4BbqlJu4u9kGh52TcdT6l+JayZEMnj3Jwx2Ypawe/
	qPBDrNVpn3o/yd5od3OIhhQOZSv/nCBBrBjX1W+zdmOTOYtZII3d4kiWDvwhJB+676Yth0s1kAB
	Ad3jJtwdFH0U2039Ndj/W/hdnQKHS6EZt9L97tH6s
X-Gm-Gg: Acq92OEFIqyZmZVTSyi36QL0KX1HBPMfiKlKGxSPJwUHswGDCMYAmW+9TfbTSoFAaMH
	D/D7jPIU9yjalbXb/WfpnGLxtw8lh0/dbhKR6IRVBBajwiUFSVCSQwcPhlrYrESW6klnBlI4Ac0
	C0YdG/9qkZTtDS3DGXISr/qWXKw/ADALHKqkKLixBJfbosYWX4DdGiHtH58BnU474krKX+46YsN
	Osr5DM+c//Y5m0c+pEF7mx2Tk6OcLvuyO/ByBt1VJhJGvp2AUFVb07eTWH7Z1UlZVlDa3coYMR1
	oRTqHw==
X-Received: by 2002:a05:622a:4a06:b0:517:5c70:46bd with SMTP id
 d75a77b69052e-51955e9528bmr12464811cf.11.1781488858160; Sun, 14 Jun 2026
 19:00:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610-slab_alloc_flags-v2-0-7190909db118@kernel.org>
 <20260610-slab_alloc_flags-v2-5-7190909db118@kernel.org> <aiuBoDbQc0N-l7e-@fedora>
In-Reply-To: <aiuBoDbQc0N-l7e-@fedora>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sun, 14 Jun 2026 19:00:46 -0700
X-Gm-Features: AVVi8CeUw0W_EslN4JUfmO-ybZYKHjgOAgJIjaWoAT60L70xQw7t8VlC106Tfg4
Message-ID: <CAJuCfpGSHfNUvL9AzbftSg=uGRW4cJLbO6iB15keyN6A_eSWEw@mail.gmail.com>
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
	TAGGED_FROM(0.00)[bounces-16923-lists,cgroups=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DF289682CD6

On Thu, Jun 11, 2026 at 8:50=E2=80=AFPM Hao Li <hao.li@linux.dev> wrote:
>
> On Wed, Jun 10, 2026 at 05:40:07PM +0200, Vlastimil Babka (SUSE) wrote:
> > Similarly to the page allocators, introduce slab-allocator specific
> > alloc flags that internally control allocation behavior in addition to
> > gfp_flags, without occupying the limited gfp flags space.
> >
> > Introduce the first flag SLAB_ALLOC_TRYLOCK that behaves similarly to
> > page allocator's ALLOC_TRYLOCK and will be used to reimplement
> > kmalloc_nolock()'s "!allow_spin" behavior. That currently relies on
> > gfpflags_allow_spinning() and thus the lack of both __GFP_RECLAIM flags=
,
> > importantly __GFP_KSWAPD_RECLAIM. This can give false-positive results
> > e.g. in early boot with a restricted gfp_allowed_mask.
> >
> > Also introduce alloc_flags_allow_spinning() to replace the usage of
> > gfpflags_allow_spinning().
> >
> > Start using alloc_flags and the new check first in alloc_from_pcs() and
> > __pcs_replace_empty_main(). This means some slab allocations that were
> > falsely treated as kmalloc_nolock() due to their gfp flags will now hav=
e
> > higher chances of succeed, and this will further increase with followup

nit: I think it should be either "higher chances of succeess" or
"higher chances to succeed".

> > changes.
> >
> > Remove a WARN_ON_ONCE() from refill_objects() as it's now legitimate to
> > reach it from a slab allocation that's not _nolock() and yet lacks
> > __GFP_KSWAPD_RECLAIM for other reasons.
> >
> > Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> > ---
>
> Reviewed-by: Hao Li <hao.li@linux.dev>

I would call SLAB_ALLOC_TRYLOCK something like SLAB_ALLOC_NOSPIN or
SLAB_ALLOC_NOLOCK but naming is hard and I don't claim myself to be
good at it. So, feel free to adopt my suggestion if you like it or
ignore it otherwise.

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

>
> --
> Thanks,
> Hao

