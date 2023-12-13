Return-Path: <cgroups+bounces-947-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8134C811FDD
	for <lists+cgroups@lfdr.de>; Wed, 13 Dec 2023 21:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EA1F282660
	for <lists+cgroups@lfdr.de>; Wed, 13 Dec 2023 20:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064CA7E565;
	Wed, 13 Dec 2023 20:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pEe0PUB4"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDEBEE8
	for <cgroups@vger.kernel.org>; Wed, 13 Dec 2023 12:23:27 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5e2f0e7e17dso10187927b3.3
        for <cgroups@vger.kernel.org>; Wed, 13 Dec 2023 12:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702499007; x=1703103807; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yCsGgZ1cCSSEwPDaPjL1FRAH1M+CTFrDqXrFCAjHeZg=;
        b=pEe0PUB4q/tH4auP6jXqccAscilI1XRF5fF5M0nTlHMvm2VWf4FXnY/GNFEqYySWeD
         W4XRDTshwkBg9GNtq/cGV0AI+QKYROLfFzLCOq4IHETEQNldpBZnKRNKB3wxlZVyGtUJ
         Q0gS0i2MSYTJjBw3UHH1lbrCL82yAajz2AV+VEQ94bWbwuwdoSWs/EHbjvIkQ6KrkcGq
         zOaH2ppkWPmMa/qij4HExHA+ke5RGt3pvzaVZz174Hqj3XC9Ugh0+1KOQ0SUntBaYbBI
         fUKGm86QytMPJla+eWHJtl7KTMhAqJ6g5pP7+jldy19CWO2B86w8sesqt0fplcg2tEkE
         JQaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702499007; x=1703103807;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yCsGgZ1cCSSEwPDaPjL1FRAH1M+CTFrDqXrFCAjHeZg=;
        b=O5QAG6ykwVopBcsrhNChKH+v+PWRv1t5vmStxkI355blbFGksgrJuOU7ntQmC9t7x9
         X5g92P7VN0jyG19+keQliZcyb72DpOG34oWvJvB1Uw92Ipgtniqzay/utU6l3ZC3q6R9
         MEG3QRjgJRmG7GnzCWkLofhj+X/mm0fvZbY27DLVhaaVRpzsnsiMxbgCaY3wgjVmjefi
         MIpmBejlfvq+ba6LQVXnaxmKbfSleX8ubq5ZQ03CtuP5Z4hLGvReV0nYk9asorQnye4Y
         H3k4/KDL2A7d9Yxywl9De6aKDfAKB3IJTDeGUDcRJloPzD8z5k+zOqE9JsxH778skGx3
         7yEw==
X-Gm-Message-State: AOJu0Yx+gkYOG6T84OtJH+zrsvXV/yv9nHmdeDaJVWs9eb5Su+FSVbR4
	XGI8fdnwY5bB1z60Y1lLsSxVdor1ihVl2Q==
X-Google-Smtp-Source: AGHT+IEsuT+mndDIu/hnS+8BjBfrI28PLp84NhOBaSahuFiq39O67QKKoF3EcWARg74Sfpb5t/M0wANZ9JO3fw==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a25:ca92:0:b0:dbc:cb73:15c8 with SMTP id
 a140-20020a25ca92000000b00dbccb7315c8mr27743ybg.5.1702499007165; Wed, 13 Dec
 2023 12:23:27 -0800 (PST)
Date: Wed, 13 Dec 2023 20:23:25 +0000
In-Reply-To: <CAJD7tkbjNZ=16vj4uR3BVeTzaJUR2_PCMs+zF_uT+z+DYpaDZw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231213130414.353244-1-yosryahmed@google.com>
 <ZXnHSPuaVW913iVZ@casper.infradead.org> <CAJD7tkbuyyGNjhLcZfzBYBX+BSUCvBbMpUPyzgHcRPTM4jL9Gg@mail.gmail.com>
 <ZXnQCaficsZC2bN4@casper.infradead.org> <CAJD7tkY8xxfYFuP=4vFm7A+p7LqUEzdcFdPjhogccGPTjqsSKg@mail.gmail.com>
 <ZXnabMOjwASD+RO9@casper.infradead.org> <CAJD7tkaUGw9mo88xSiTNhVC6EKkzvaJOh=nOwY6WYcG+skQynQ@mail.gmail.com>
 <ZXnbZlrOmrapIpb4@casper.infradead.org> <CAJD7tkbjNZ=16vj4uR3BVeTzaJUR2_PCMs+zF_uT+z+DYpaDZw@mail.gmail.com>
Message-ID: <20231213202325.2cq3hwpycsvxcote@google.com>
Subject: Re: [PATCH] mm: memcg: remove direct use of __memcg_kmem_uncharge_page
From: Shakeel Butt <shakeelb@google.com>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Matthew Wilcox <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 08:31:00AM -0800, Yosry Ahmed wrote:
> On Wed, Dec 13, 2023 at 8:27=E2=80=AFAM Matthew Wilcox <willy@infradead.o=
rg> wrote:
> >
> > On Wed, Dec 13, 2023 at 08:24:04AM -0800, Yosry Ahmed wrote:
> > > I doubt an extra compound_head() will matter in that path, but if you
> > > feel strongly about it that's okay. It's a nice cleanup that's all.
> >
> > i don't even understand why you think it's a nice cleanup.
>=20
> free_pages_prepare() is directly calling __memcg_kmem_uncharge_page()
> instead of memcg_kmem_uncharge_page(), and open-coding checks that
> already exist in both of them to avoid the unnecessary function call
> if possible. I think this should be the job of
> memcg_kmem_uncharge_page(), but it's currently missing the
> PageMemcgKmem() check (which is in __memcg_kmem_uncharge_page()).
>=20
> So I think moving that check to the wrapper allows
> free_pages_prepare() to call memcg_kmem_uncharge_page() and without
> worrying about those memcg-specific checks.

There is a (performance) reason these open coded check are present in
page_alloc.c and that is very clear for __memcg_kmem_charge_page() but
not so much for __memcg_kmem_uncharge_page(). So, for uncharge path,
this seems ok. Now to resolve Willy's concern for the fork() path, I
think we can open code the checks there.

Willy, any concern with that approach?

