Return-Path: <cgroups+bounces-940-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F393811834
	for <lists+cgroups@lfdr.de>; Wed, 13 Dec 2023 16:49:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B718D1C21367
	for <lists+cgroups@lfdr.de>; Wed, 13 Dec 2023 15:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1627285350;
	Wed, 13 Dec 2023 15:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rr6wb9Wc"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6137A2729
	for <cgroups@vger.kernel.org>; Wed, 13 Dec 2023 07:43:24 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-50e0ba402b4so2592275e87.1
        for <cgroups@vger.kernel.org>; Wed, 13 Dec 2023 07:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702482202; x=1703087002; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uUG0bdIpAOo2SWXtdO34WuDhmq+7ZO8R3MnzbE7T8g4=;
        b=Rr6wb9WcGs+gHkLlVOGiFF1LWdWlqTW/qcaAAx/f3XHSCu7Fx/lCnEvU+GZHpJyXYk
         hA7osOowPbFcI/fS0xHkcFDytETVxcxFQyCmn5sWuG7RushqT0P1uUgpZLsjLLhpa4bB
         yLk/JDtITl3Gmil5UoBdQkkvABQI2zLDrLQ5HUPEX5g5DAcbNH1hV8ZzKqaxyg4c3WD7
         Hi2Y2YOCnnexGkXg89rXqeRh6xoG/j3Od7qhf1yGZeNhYUEYCdxk/6DLObAa8JWFtJc4
         lYLFndcmpX1i2t8jpXdQg8C3RCWOlSMMVeqLwtouPtsZHlTJQFV32DqcYBIH5SSQoxsy
         Paaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702482202; x=1703087002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uUG0bdIpAOo2SWXtdO34WuDhmq+7ZO8R3MnzbE7T8g4=;
        b=hG0u73dxnba8JuWGg60djj0/4K2/8khmJFBRJK7zDcn7f6ivNLwWOkDSS7wSx2spwH
         NzXCgJM2/BaKuEnvLkOsjrrGG51vwuJfLNLDAm9mqd0qGCRWlHDHbiA4VwDYMdK+7GT2
         gLBWUKemnp/ffS5YZYSADk9oYI6ziPAZj99i+XIcWx6kRfI6A+v25//hDgGMvw6ZnMdC
         9Vs+OBwhJlXZD5dCindlFj3XuubyZ2zs8lYBehPPzosIbk1zwwVHW18c8ODa22imAdXv
         pkCVCsxCz7CVr3c9N71P9/FgClcsbetTVs2I4+I0M5Wt6ym8ksQ5KLHuPn+nTI/QmvHT
         iEbA==
X-Gm-Message-State: AOJu0Yw3zv5IHDr36L+Jqu+hZrv9vJkhOd4fyMUGZlLjPRDMvTs8kXBk
	nyZVlvBQF1smHDvMD0GikP42x1hOeYcPZ29BQLca8g==
X-Google-Smtp-Source: AGHT+IEkzrWeqYjMDHaUBZtdxlMs3Onfd3PFx4pxMmAALWN81VFeXXNoYJgWggFsWLxa9u0IWGWdA12+/ZJSiFPknHk=
X-Received: by 2002:a05:6512:46d:b0:50b:f51a:299a with SMTP id
 x13-20020a056512046d00b0050bf51a299amr3692902lfd.32.1702482202295; Wed, 13
 Dec 2023 07:43:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213130414.353244-1-yosryahmed@google.com>
 <ZXnHSPuaVW913iVZ@casper.infradead.org> <CAJD7tkbuyyGNjhLcZfzBYBX+BSUCvBbMpUPyzgHcRPTM4jL9Gg@mail.gmail.com>
 <ZXnQCaficsZC2bN4@casper.infradead.org>
In-Reply-To: <ZXnQCaficsZC2bN4@casper.infradead.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 13 Dec 2023 07:42:44 -0800
Message-ID: <CAJD7tkY8xxfYFuP=4vFm7A+p7LqUEzdcFdPjhogccGPTjqsSKg@mail.gmail.com>
Subject: Re: [PATCH] mm: memcg: remove direct use of __memcg_kmem_uncharge_page
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeelb@google.com>, Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 7:38=E2=80=AFAM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Wed, Dec 13, 2023 at 07:08:52AM -0800, Yosry Ahmed wrote:
> > On Wed, Dec 13, 2023 at 7:01=E2=80=AFAM Matthew Wilcox <willy@infradead=
.org> wrote:
> > >
> > > On Wed, Dec 13, 2023 at 01:04:14PM +0000, Yosry Ahmed wrote:
> > > > memcg_kmem_uncharge_page() is an inline wrapper around
> > > > __memcg_kmem_uncharge_page() that checks memcg_kmem_online() before
> > > > making the function call. Internally, __memcg_kmem_uncharge_page() =
has a
> > > > folio_memcg_kmem() check.
> > > >
> > > > The only direct user of __memcg_kmem_uncharge_page(),
> > > > free_pages_prepare(), checks PageMemcgKmem() before calling it to a=
void
> > > > the function call if possible. Move the folio_memcg_kmem() check fr=
om
> > > > __memcg_kmem_uncharge_page() to memcg_kmem_uncharge_page() as
> > > > PageMemcgKmem() -- which does the same thing under the hood. Now
> > > > free_pages_prepare() can also use memcg_kmem_uncharge_page().
> > >
> > > I think you've just pessimised all the other places which call
> > > memcg_kmem_uncharge_page().  It's a matter of probabilities.  In
> > > free_pages_prepare(), most of the pages being freed are not accounted
> > > to memcg.  Whereas in fork() we are absolutely certain that the pages
> > > were accounted because we accounted them.
> >
> > The check was already there for other callers, but it was inside
> > __memcg_kmem_uncharge_page(). IIUC, the only change for other callers
> > is an extra call to compound_head(), and they are not hot paths AFAICT
> > so it shouldn't be noticeable.
>
> How can you seriously claim that fork() is not a hot path?

It's only called in fork() when an error happens. It's normally called
when a process is exiting.

