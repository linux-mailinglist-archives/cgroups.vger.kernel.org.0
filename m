Return-Path: <cgroups+bounces-16927-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8r0aNEVlL2rQ/gQAu9opvQ
	(envelope-from <cgroups+bounces-16927-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 04:36:53 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF8ED682E6C
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 04:36:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=r0afPnyS;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16927-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16927-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A1DD0300372E
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 02:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01873259C80;
	Mon, 15 Jun 2026 02:36:45 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3BB24E4AF
	for <cgroups@vger.kernel.org>; Mon, 15 Jun 2026 02:36:42 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781491004; cv=pass; b=q/WcNN+1zk+JtGaSv9S8YJ/RMktbhyDsIdlJgsxdJ28aTheioKLZghfUTlAZFlJpYipke/p8ua/otlK+xZhor3QqlYwqTyYE+RpEpgemk4FUX65/XBNg4wpa/jXnQpiBTo6Tq4vv8Tt6wSunfxH3SSYxZNFzDKJXXAggWz6FFOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781491004; c=relaxed/simple;
	bh=zJpiISLfF5OllrNNsWNRiDqnUU6n6kaAJcyx4pm15u8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EHPyFuC3dFy0QzVf51oMQ7d7CnCMhkKJg5PDE1E95lLPETJslQCFAZgK68zEC+adRUeEy8Dq0fBTAXWCI+hgzBxmtaaqftp/nLHJQzfgB0l3Daf+cm4K/8Nl6H8h9lc3fzhyxT4lcXJeNs4qiQ3gxsT5jPGGyJMFTLEN4QQEZik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r0afPnyS; arc=pass smtp.client-ip=209.85.160.176
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-5177d1ff061so678361cf.1
        for <cgroups@vger.kernel.org>; Sun, 14 Jun 2026 19:36:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781491001; cv=none;
        d=google.com; s=arc-20240605;
        b=ACcaOSlCb6zDM/LIXEYiqMbE+mSRVyPRFThdvLy7qtGNVj+BLR8SCFL8uAQFsSDdJM
         fWpg5f+4SVEW1we12WTsg6n2cj//TQ886c7yu9SsZxZCS4VWgOeC96btg3pf2yP+ezv8
         tfHygZLM436g31DS8glTAuaQjb964wEHe4bJaHukkOxnW7tp9sa4lG4Mp5T8X8CBLo43
         kzgx3sgz/bFomVEn2lc2LcsgI3co7JEXJcnED3xM90HM4yMaWHmLPHAfx04KCEqSnBMW
         9Dq9PYDV/rphY1tPNOZYmQ1gjsmuxPDxgrAUeFn/PERusMcFQFeUhrak9oKWynHNi04a
         2dmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zJpiISLfF5OllrNNsWNRiDqnUU6n6kaAJcyx4pm15u8=;
        fh=iA8vKjlYhsvnCI0tGV7KreOy62CNC5ytUN6tpoGKcqM=;
        b=dqYEqdo0L9PPTgLG0RErv2TVK0C7MvBLVKY7lmo5ByVBPXtn8AitMinWgpoPYZ8p9c
         G1e1w4eHs7/8p5d6LhoHGZEu60L/7cxZ5tWSK3nFtKfZHT0s66JIgjX1w7YRuB3rug2g
         pL8OwSEIsjSnmqXfbwunsV9EHrHgcd/+w5cbLy9ySdIMnTaoeOSLSy4zYkzTgFoT+GWt
         msXQ5J+9R+abMkEt2mxjG39saEDRBkkZpXZZy4SxXIzC2jMEf6KrlZJtOJbt8onJ3J0C
         g4Qi5CUmPh/htwPu/5MBafHgZ9uF/ChHvXYd+vE/sz5AbemGerTPpvczMkgonTXyWAJs
         UYKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781491001; x=1782095801; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zJpiISLfF5OllrNNsWNRiDqnUU6n6kaAJcyx4pm15u8=;
        b=r0afPnySFWf3QBFdiUg3nXf9wvWqASTPNcujh7CFqaOPvA9+CO0tS05U04iA0a1gMJ
         w7ogZujyX1GYkfG/6rMAu0RhG8r7u0kI3myBYOavc0myi8TNEYtl/++018SNlOG5NZFX
         xkFA1so7kVZQhJ58+pP4wgLtauOtOS4NSCrY+/OH8Dfq4TMubhg4pL5nK3m1veDWgiFr
         ClMYYpnhCfYrtXdqP64TB/jOIItRfI5ObOzqr3aUkiRbiQ8VwALBxEba1cffSuI5ohdS
         IcmDXcHixvVia31R6wpLivD8ocLm1QleNM2nppVwNNf3RuPrhS0kAf1WC9nHrzIkwU57
         81JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781491001; x=1782095801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zJpiISLfF5OllrNNsWNRiDqnUU6n6kaAJcyx4pm15u8=;
        b=rbHYtNDlKC2LgVRpZe32FjyQx2f5fdnnZNuKzi5j16KRz3xIlRowtkzl6G9vkTVfG5
         o8PBW0d0qgKGmoW5x8OccYG39Q3Zl4PV0veCcF4rbm3uArfIwU38QMsyekZQpTkh/ra6
         Lyu+FH13F8ClZhRd2+Mc2M7UhJO7YW3VAvCzm3ogZKil3qYzUnm1vyMrft4v/4R8uFQr
         K4IbEN88WT1tHE1KS+wjIkK7mJy6/oH5B7Ueh3uWxZmajtG5pkxcUYAVCKNE8Fdc7fxr
         QSTd+1lo8nlrolkBoRzIt6Ham7OfXqe05uMxP9AoudliCPvWmLL5QUPZUaDVFhYqVnyJ
         pM0w==
X-Forwarded-Encrypted: i=1; AFNElJ+CMnTnxv3+QiwU1kEYI+sz1N+ipAQSjoMA/pFWqs/halsKoturOlNcEALXxLzWzkq26A3rbp/S@vger.kernel.org
X-Gm-Message-State: AOJu0YxhbNEyZjsuNXUe6BweB2mVVBkcWpBFh1zKIUnqGy9iP2gbKYQ1
	AQgQ2cL2sYgRA49M1it3OtR6P15vEeIVMBLle/62qtlGYsdK3VyCTXShcGlGuGkLOg8MBAuaYdO
	jxJazTwM/qvUOCOaLCmPzQkTJOhGsl6h4++TWYqtu
X-Gm-Gg: Acq92OFC/sS/pTpj9CPF3CwcR2+rdkcSPXdPU7OMbtgJyjVhmMmCg+TxYd3GSWJTM9O
	1mJWi4rWJTB9ng02WndFZi+cv4gt6wnp+kQ1D5gHJMXsQ2MlZXs7vOTChn7jlPCnbI+yTKBdGOa
	mBn5BiCu2GsShlfN2KY0gTZ4X/WmqlUM9V4Ebac5vgBmqgH08GfNwwcFY0RaN684QiPTGVBqLBd
	oMa3um8q4bG8ZG6fMVd+ddIUwdHnJV//4XC2SvF8tz49RKZI//TnuZh5osqz4TUqo0xkrY6ig18
	fwtA0A==
X-Received: by 2002:a05:622a:5514:b0:517:64f6:3365 with SMTP id
 d75a77b69052e-519549b131emr13606831cf.4.1781491000974; Sun, 14 Jun 2026
 19:36:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610-slab_alloc_flags-v2-0-7190909db118@kernel.org>
 <20260610-slab_alloc_flags-v2-7-7190909db118@kernel.org> <f9b7935c-f5f0-496c-b55e-1f3feee5c87a@kernel.org>
In-Reply-To: <f9b7935c-f5f0-496c-b55e-1f3feee5c87a@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sun, 14 Jun 2026 19:36:30 -0700
X-Gm-Features: AVVi8CdV4PtT2_MsVUv9NaJhoTf5K03I_WYn_c2jFY2--uC0YvXIO7SM0baYEVk
Message-ID: <CAJuCfpE3XfxLmV-DzM5nLqYqGsFJThr-1i4bmEEqMpGZ28RLFQ@mail.gmail.com>
Subject: Re: [PATCH v2 07/16] mm/slab: replace struct partial_context with slab_alloc_context
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
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
	TAGGED_FROM(0.00)[bounces-16927-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CF8ED682E6C

On Wed, Jun 10, 2026 at 11:05=E2=80=AFPM Harry Yoo <harry@kernel.org> wrote=
:
>
>
>
> On 6/11/26 12:40 AM, Vlastimil Babka (SUSE) wrote:
> > Refactor get_from_partial_node(), get_from_any_partial(),
> > get_from_partial() and ___slab_alloc().
> >
> > Remove struct partial_context, which used to be more substantial but
> > shrank as part of the sheaves conversion. Instead pass gfp_flags and
> > pointer to the new slab_alloc_context, which together is a superset of
> > partial_context.
> >
> > This means alloc_flags are now available and we can use them to
> > determine if spinning is allowed, further reducing false positive "not
> > allowed" in the slow path due to gfp flags lacking __GFP_RECLAIM.
> >
> > Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> > ---
>
> Looks good to me,
> Reviewed-by: Harry Yoo (Oracle) <harry@kernel.org>

Ah, nice! The conversion I was anticipating in the previous patch...
I would do this removal of partial_context as patch 6 and then convert
___slab_alloc() and get_from_any_partial*() altogether in patch 7. I
think that would keep the behavior of the ___slab_alloc() more robust
throughout the patchset. But I would say it's nice to have, not a
must-have.

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

>
> --
> Cheers,
> Harry / Hyeonggon

