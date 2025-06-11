Return-Path: <cgroups+bounces-8488-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D6DAD5E04
	for <lists+cgroups@lfdr.de>; Wed, 11 Jun 2025 20:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA6161749E9
	for <lists+cgroups@lfdr.de>; Wed, 11 Jun 2025 18:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4932221732;
	Wed, 11 Jun 2025 18:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aaxAcd/7"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41DB1B21AD;
	Wed, 11 Jun 2025 18:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749666031; cv=none; b=Gqq3n/6SP7VdjtsZTqMqhJf+ST/v/1i7VC+8uauGsBqr/TAF6o0Zn+o2qLhQPzg8Xn0cTTDzqdsIdrNX+EHQq1D9tw5u4GkSN0U3GTgnLmtm4PrdQ4aDxfx17eOm3NZyD8G8UJgGdShGqqFde8cJbREBaWXdCUV7wE5zZ0S/bLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749666031; c=relaxed/simple;
	bh=2r7YwymDfWP+8W7dG/+AS2Ig2LS3QJ6Pp9duBEHILUg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GHyZzVBchIIIhS0WL1RGZIpjtbuSi76ybDfTlofnlgurq/iLN9l4ayxg7NSL1ZrGPSCA4xcusgiqTPYw7/E0Cesb/YAPwcMU+s0WN4ncUCQatrdwJx0Cs2Gz2oOHtA6eSTQudIIipv0tM2NZZ3SIyx03wWHIYhUNP/TRmBAp3eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aaxAcd/7; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-450cf0120cdso564045e9.2;
        Wed, 11 Jun 2025 11:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749666028; x=1750270828; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R5m97eh9RunBN0cr6x3LBcZ++dHF9GYD/OWjDrsIV8A=;
        b=aaxAcd/7nAyFeH6Z3mqhkIAkO7AxzkNb37YyM8GB4bAdCNAat6JIH2F7GzVq6pCcn7
         N2ESk0OpHAWlZCQYLdigkABs7oghvfK9NMgVIyNJqM+eSwdvRrBiT/7vjDPIrIJcLyzD
         PHo1qbGHa5u8lJEXLbIyV34ZeKxh/hvR8/g15dpa1lAhSdQDiBi2tMRJUGF74KElj7Bo
         b27Q07asH+42bbUblF1Lt/txq2kldmFWA+x0Qz9y8+7nWgkOR/svnP9fj7Smev1KjVkh
         TMDq7tJkAu55nSsaCT4Kf1wyKrTBHaawkNZhtgVzsgYFUoojBpwzpVzVhb45qN6lleHR
         z0HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749666028; x=1750270828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R5m97eh9RunBN0cr6x3LBcZ++dHF9GYD/OWjDrsIV8A=;
        b=byKPAVvKmxfqiNawbrZGJT4nJc55qsxN70mZBIbMDjxfd1dDuWKkI+pssuLYhkwCFT
         RbOWb0qV6MSXLTfGkc0cbeooC35wJz7QGZy3sKjAS8LGrODTFHFvV9WmvY0EmhDZ58G4
         vRpjvQsRF2ADcrNTlJ+mPQdryDBB9VECRZ0a//1Dv62Gj0xXhHW1tRu1TKJDlkqMFu3x
         2xHQ10T35LWFOIg75QRZhbzNxKKYzjp3znhzTSEl0z5H8iht7trNKV7oCtsOq/kfPnDh
         5smQfhZLcRB3FbDq4IChi//RE7osqfbxndoRb3a1LP4qqzUlImHeEKwAQgupdyo2jlAo
         N2aQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3JY6w/fNgmskaDhvDPO+8bkyp0IuYZjNPAP+1FjlVJ/nHFRmu5c2Ur9Zp+i0fWnvS+SiNcO7V@vger.kernel.org, AJvYcCVTCV/F0KFd0Wr/vP1lLS8toLUDtPUqFm9h1zdOsSe1paGcSmFLj1+p8rtscyi4UBrUa5q8cfjIy1twX05Y@vger.kernel.org
X-Gm-Message-State: AOJu0YxlIkv5nr3Y3L8hySAnfT56CNUz28Q5xFm1eQsIIWasPLVCj7yg
	8nvoJnT8fSAulFPbOAYZYbAd34WpklJgyeXsWv+ioVsr+fqtsMuDuoWn38BANT3BpUkBGcQh3KY
	UkkazrlQcXjVpDNpq7f3O4UUkVz5dWIA=
X-Gm-Gg: ASbGncvUumoTaW3LPyuty3k8gT+XPuZHTsoDTH3rw24y8r18UvX5pihiQ+iJdKnX5Rl
	m+DqrAmwJjDgtNL6Z/glc82qMlQH04gvi6aSL1zarGLsXZ8aQ5NZJx/YJziGGZDVX55b/PvQ8u4
	EjjooBClaVjUoHfE+aHsCNt7RS45MKnuwhxIBnXTPwF4rWo8rTGawhcqa/USDiWl1n9LIItRefK
	8Q8fY8fbG8=
X-Google-Smtp-Source: AGHT+IFN0T16+CM0BYm4xoqStxnMucus/ObcGvJIdxmQdqT+iYg1rQmwnW8O5aoGCWEdqgZ0XYfEOFl6qW4fzQQV/z4=
X-Received: by 2002:a05:600c:1c81:b0:43d:aed:f7d0 with SMTP id
 5b1f17b1804b1-453248e2bc2mr33035805e9.28.1749666027893; Wed, 11 Jun 2025
 11:20:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFGhKbwVyxCwYSNrPaQ-GkuP008+uvDg-wNA5syWLLzODCfpcA@mail.gmail.com>
 <68c0649d-d9b3-44f4-9a92-7f72c51a5013@suse.cz>
In-Reply-To: <68c0649d-d9b3-44f4-9a92-7f72c51a5013@suse.cz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 11 Jun 2025 11:20:16 -0700
X-Gm-Features: AX0GCFsJqwGB-2ewIU3-x1AGG_8a9PCLpm39qmLB1tesuN9NIztbtUp-6xrXsO4
Message-ID: <CAADnVQK+wjvxmBM7WJOGNK=AqeJ7UHBO4tUZR3Gjc4kfgux1sw@mail.gmail.com>
Subject: Re: locking/local_lock, mm: sparse warnings about shadowed variable
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Charlemagne Lasse <charlemagnelasse@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Alexei Starovoitov <ast@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Jakub Kicinski <kuba@kernel.org>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, 
	LKML <linux-kernel@vger.kernel.org>, 
	"open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, 
	linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 10:57=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> w=
rote:
>
> On 6/11/25 19:37, Charlemagne Lasse wrote:
> > HI,
> >
> > when I run `make C=3D2 mm/mlock.o CHECK=3D"sparse -Wshadow"`, I get a l=
ot of
> >
> > ./include/linux/local_lock.h:88:1: warning: symbol 'l' shadows an earli=
er one
> > ./include/linux/local_lock.h:88:1: originally declared here
> >
> > after commit
> >
> > 51339d99c0131bc0d16d378e9b05bc498d2967e2 is the first bad commit
> > commit 51339d99c0131bc0d16d378e9b05bc498d2967e2
> > Author: Alexei Starovoitov <ast@kernel.org>
> > Date:   2025-04-02 19:55:14 -0700
> >
> >    locking/local_lock, mm: replace localtry_ helpers with local_trylock=
_t type
>
> Looks like __DEFINE_LOCK_GUARD_1() has "_type *l" and __local_lock_acquir=
e()
> has "local_lock_t *l;". It can be fixed e.g. like this, although it's
> harmless? The _release() part is not necessary, just for symmetry.
>
> diff --git a/include/linux/local_lock_internal.h b/include/linux/local_lo=
ck_internal.h
> index 8d5ac16a9b17..075338f270d0 100644
> --- a/include/linux/local_lock_internal.h
> +++ b/include/linux/local_lock_internal.h
> @@ -97,17 +97,17 @@ do {                                                 =
               \
>  #define __local_lock_acquire(lock)                                     \
>         do {                                                            \
>                 local_trylock_t *tl;                                    \
> -               local_lock_t *l;                                        \
> +               local_lock_t *ll;                                       \

I wouldn't bother messing with the code because of sparse.
Compilers don't warn here.

