Return-Path: <cgroups+bounces-5239-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FDBB9AF3B8
	for <lists+cgroups@lfdr.de>; Thu, 24 Oct 2024 22:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7C261F231E7
	for <lists+cgroups@lfdr.de>; Thu, 24 Oct 2024 20:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD97217902;
	Thu, 24 Oct 2024 20:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hWQguhp+"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F858156C74
	for <cgroups@vger.kernel.org>; Thu, 24 Oct 2024 20:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729802015; cv=none; b=hT4pJ6a3CzkgXrXdzJCKR/J3QKcE3ZLB5CoeUuMswShNqiZypP5DoYXcHhy+WyF6R6o4oojrCi7j8ZVa1OeVxwQZZNNID9tg8NPp0nkbzNLcLPwAdsbxSoj4wOU4TTFmObpqAsIc0ID6KT23Ty81Ip27zbyKEODfmGF/ZXFSA6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729802015; c=relaxed/simple;
	bh=fg6TiyFvbDY3F7rgtjpzzrWknbfNctLjVqZiyU7qibI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MG4Wi5jU5vNhIPmsi5HmG6qMdOIfa+qUbRlIN9OX538cFghSRBJyCDnhBa5QNjTtzs4R+b3DGtgVBWRtg1i2bpBH2sEROFuRXGo7tYLnfHjAfNzb7GiKnMZzpyi3kapXt+9/3WOAI3sighJ9o8uvS6zTx2ZACtZeNzjXfsAipSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hWQguhp+; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a9aa8895facso200475366b.2
        for <cgroups@vger.kernel.org>; Thu, 24 Oct 2024 13:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729802010; x=1730406810; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fg6TiyFvbDY3F7rgtjpzzrWknbfNctLjVqZiyU7qibI=;
        b=hWQguhp+CnbddhzmUsGG7rMNi+4y30dOGw59I4DeY4Uo6INaw/VbXaIb6kB63L8wzs
         b1LUD0ODxmE5RhIjPqjBNKnuDUlM/ELWpyX+t5l5fuQIHA4DA+vExwVUohyUKpWdGHhv
         19XvLkFRtWWgPtkSzEQ54Pedp1xTZaydzU8YcEm2yTzekk3K6egKyRdol78NS2wIbZvE
         qY+BuuMGMimOgBgZRVqZ5uxx2uXh+DKGvUNf8wAUSK3d9VRVQ5J3IrsgYC2C27IXqw3v
         By1376iItMEgftZH9EX7RruyuLe6XnU2HAQUOm4P3B23fyTtArX8WsDV6bKUukBEULuH
         mOow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729802010; x=1730406810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fg6TiyFvbDY3F7rgtjpzzrWknbfNctLjVqZiyU7qibI=;
        b=AO/y1eOFSFA0XZj/V9Jz7oujsVHhw2xnU5Z7c64YTqPO1bRG+N0guJTf8dyFOTAAux
         +a1LYDvl5SlbD6AVmHV1ZoRKF7zyNzzO3FogEReEzPguqMt1tAbaOnv2W0zg3nrf80iA
         TjIJAVvu6hJg5UWY5Jbr7m6Jh4vS9Smf+rUqVNFPIyqq84ZSkMUZojGVTd1uemhTBRK2
         Dma21h22mQDrS9CPrrDsU0k72nLNXS3TQrC4P/YRnuaUq9UsbmmpRkPa0ZE0zjwBNnGD
         UOODh+27hBISsw2MPKp1Jy5m6BtSXfQkpSfRfoQull0rrFU7EonIRrAAhmlWVEhH57uZ
         sAkw==
X-Forwarded-Encrypted: i=1; AJvYcCU2W58au6gKgjE8Yo/sHbxTWbsQZqv8RCvjvZM13KNC2HuvXVo2pU/3kf3ue0GWGjiauuCTqYix@vger.kernel.org
X-Gm-Message-State: AOJu0YzzWQXrnpTb0x113U7AEV3Rt+aoeWeO3/S65n11xHMT2Gch3Qy5
	x7bO/34UfWmdm5gvD+nOy5TwpzvgNWUg8fWJA7SBkly8L0ldjaT4gfkHfFgQqS+QIjp51TC3Rn4
	lWm6VhPYdoJXt5bhXZ/Hsj82Gx+P1T/dFGwKQ
X-Google-Smtp-Source: AGHT+IFUTfSFqD0LJ8fBf/qBjK9gkH3Z9YIIz4iHZrS73DoGiaBlQz65rZWWLT2VwceQlhDcqTGP7QpWRdHLEYK/iBw=
X-Received: by 2002:a17:907:6d29:b0:a8a:58c5:78f1 with SMTP id
 a640c23a62f3a-a9ad2711791mr278966966b.11.1729802009584; Thu, 24 Oct 2024
 13:33:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241024065712.1274481-1-shakeel.butt@linux.dev>
 <20241024065712.1274481-4-shakeel.butt@linux.dev> <Zxp63b9WlI4sTwWk@google.com>
 <7w4xusjyyobyvacm6ogc3q2l26r2vema5rxlb5oqlhs4hpqiu3@dfbde5arh3rg> <Zxqj7hw6Q6ak8aJf@tiehlicka>
In-Reply-To: <Zxqj7hw6Q6ak8aJf@tiehlicka>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 24 Oct 2024 13:32:53 -0700
Message-ID: <CAJD7tkYsCev299G=h2r_e6i34+ccdXJYphv-bQbROqOd7Lr1Uw@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] memcg-v1: remove memcg move locking code
To: Michal Hocko <mhocko@suse.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Muchun Song <muchun.song@linux.dev>, Hugh Dickins <hughd@google.com>, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024 at 12:45=E2=80=AFPM Michal Hocko <mhocko@suse.com> wro=
te:
>
> On Thu 24-10-24 10:26:15, Shakeel Butt wrote:
> > On Thu, Oct 24, 2024 at 04:50:37PM GMT, Roman Gushchin wrote:
> > > On Wed, Oct 23, 2024 at 11:57:12PM -0700, Shakeel Butt wrote:
> > > > The memcg v1's charge move feature has been deprecated. There is no=
 need
> > > > to have any locking or protection against the moving charge. Let's
> > > > proceed to remove all the locking code related to charge moving.
> > > >
> > > > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> > >
> > > Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
> >
> > Thanks Roman for the review. Based on Michal's question, I am planning
> > to keep the RCU locking in the next version of this patch and folowup
> > with clear understanding where we really need RCU and where we don't.
>
> I think it would be safer and easier to review if we drop each RCU
> separately or in smaller batches.

FWIW if we go with this route, I agree with Roman's idea about
replacing folio_memcg_lock()/unlock()
with an explicit rcu_read_lock()/rcu_read_unlock(), and then having
separate patches/series that remove the RCU annotations. If done in a
separate series, we should comment the explicit RCU calls
appropriately to reflect the fact that they should mostly be removed
(or at least re-evaluated).

