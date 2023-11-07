Return-Path: <cgroups+bounces-215-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D610F7E4814
	for <lists+cgroups@lfdr.de>; Tue,  7 Nov 2023 19:19:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C14B1F216A5
	for <lists+cgroups@lfdr.de>; Tue,  7 Nov 2023 18:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379B5358A9;
	Tue,  7 Nov 2023 18:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NKYXbqag"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E0D2E3E8
	for <cgroups@vger.kernel.org>; Tue,  7 Nov 2023 18:19:08 +0000 (UTC)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 164F495
	for <cgroups@vger.kernel.org>; Tue,  7 Nov 2023 10:19:08 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1cc411be7e5so8925ad.1
        for <cgroups@vger.kernel.org>; Tue, 07 Nov 2023 10:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699381147; x=1699985947; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u4/j39UfKajKlpqWroZ/BEjZObIZrH45V7V6jm2YWw4=;
        b=NKYXbqaguYtt1F8/mX6uGkYghp4VuhObC10MLliAGaszxqAq2OhYCnW2OtxLUGGD/X
         1uqscOJjUanYDIuglrS1rbqd436CVySBvIvL5NEHGpWltV5AdgCtlBo7xsEpQjO9c+Dl
         m504fWvLHdsedWvkXwC5tFqwiZWLK7oWgZpx7L8TYKiLovwOYmTOicpKvTXeUa9WUWwQ
         CaI5aP4AZvaEwxzgzCQw7es9lLGlOQQ7RQJujbo6xLRy50mfyMKVtSv3Ubl4X6KFDDeU
         kuQ+ccyHnKvJuwK7kpvt6fHpxXvGmvhrDDwMbJawWRPqipSxoUhTyGLk1sGguXrNzHDk
         ueSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699381147; x=1699985947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u4/j39UfKajKlpqWroZ/BEjZObIZrH45V7V6jm2YWw4=;
        b=QrweVvvU89iH/1KgjYDCxdXC9EcWU/LOyJDnbtszZXHLc4jz0D1EQ9a1lHkKfQfVrm
         GsaAC1pXUFoyqc69BUeODM2y3smOnYmlqhu2/P9e2KtHF6XSM5GapKjg6xwLbS5oTqlD
         tIS3NQ8y8t135PuBQPuVbML7q1hs2Ipt4LAUHD/WJ619Gzi/RbwL6xoNGFPUZPuRw3Wp
         tCgZTaBzcBIGfmIrknpcapRDk2BPEn15VobQ589Uv8Ts51MVm9v45ywfqNh9Z1gjdDRG
         pobW8oXX3bXvGU/9o6xyaApk0lul+dqlcf/abVD4478sfC2SXJkTFNUjyPy2bua6l3tu
         M8BA==
X-Gm-Message-State: AOJu0YzaCjr6LvaaRNlbWwAnR61DnOUL9dNb8yJ1nriksea1lSNFAUE2
	fYDMUoXO+0eE+gpnURfm9Z2TW3JNE2F44kozHgFlIBLP1TiwwzAavdk=
X-Google-Smtp-Source: AGHT+IEIOlmRzYsnwMGgspg0jnKqplPYDta4kTiHJrISmeoAjbnmxJSUTBCI9/EYOKsDX9OTUesJbZ0LJ6UOJ7Zv0JI=
X-Received: by 2002:a17:902:8bcb:b0:1b8:b564:b528 with SMTP id
 r11-20020a1709028bcb00b001b8b564b528mr242144plo.7.1699381146878; Tue, 07 Nov
 2023 10:19:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6b42243e-f197-600a-5d22-56bd728a5ad8@gentwo.org>
 <ZUIHk+PzpOLIKJZN@casper.infradead.org> <8f6d3d89-3632-01a8-80b8-6a788a4ba7a8@linux.com>
 <ZUp8ZFGxwmCx4ZFr@P9FQF9L96D.corp.robot.car>
In-Reply-To: <ZUp8ZFGxwmCx4ZFr@P9FQF9L96D.corp.robot.car>
From: Shakeel Butt <shakeelb@google.com>
Date: Tue, 7 Nov 2023 10:18:55 -0800
Message-ID: <CALvZod60YWyrwJ+PuGd2pUwiX+UpFXWKe7JuSW96tExofwhF2g@mail.gmail.com>
Subject: Re: cgroups: warning for metadata allocation with GFP_NOFAIL (was Re:
 folio_alloc_buffers() doing allocations > order 1 with GFP_NOFAIL)
To: Roman Gushchin <roman.gushchin@linux.dev>, Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Lameter <cl@linux.com>, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+Andrew

On Tue, Nov 7, 2023 at 10:05=E2=80=AFAM Roman Gushchin <roman.gushchin@linu=
x.dev> wrote:
>
> On Mon, Nov 06, 2023 at 06:57:05PM -0800, Christoph Lameter wrote:
> > Right.. Well lets add the cgoup folks to this.
>
> Hello!
>
> I think it's the best thing we can do now. Thoughts?
>
> From 5ed3e88f4f052b6ce8dbec0545dfc80eb7534a1a Mon Sep 17 00:00:00 2001
> From: Roman Gushchin <roman.gushchin@linux.dev>
> Date: Tue, 7 Nov 2023 09:18:02 -0800
> Subject: [PATCH] mm: kmem: drop __GFP_NOFAIL when allocating objcg vector=
s
>
> Objcg vectors attached to slab pages to store slab object ownership
> information are allocated using gfp flags for the original slab
> allocation. Depending on slab page order and the size of slab objects,
> objcg vector can take several pages.
>
> If the original allocation was done with the __GFP_NOFAIL flag, it
> triggered a warning in the page allocation code. Indeed, order > 1
> pages should not been allocated with the __GFP_NOFAIL flag.
>
> Fix this by simple dropping the __GFP_NOFAIL flag when allocating

*simply

> the objcg vector. It effectively allows to skip the accounting of a
> single slab object under a heavy memory pressure.
>
> An alternative would be to implement the mechanism to fallback to
> order-0 allocations for accounting metadata, which is also not perfect
> because it will increase performance penalty and memory footprint
> of the kernel memory accounting under memory pressure.
>
> Reported-by: Christoph Lameter <cl@linux.com>
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: Matthew Wilcox <willy@infradead.org>

I think we should CC stable too.

Acked-by: Shakeel Butt <shakeelb@google.com>


> ---
>  mm/memcontrol.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 774bd6e21e27..1c1061df9cd1 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2936,7 +2936,8 @@ void mem_cgroup_commit_charge(struct folio *folio, =
struct mem_cgroup *memcg)
>   * Moreover, it should not come from DMA buffer and is not readily
>   * reclaimable. So those GFP bits should be masked off.
>   */
> -#define OBJCGS_CLEAR_MASK      (__GFP_DMA | __GFP_RECLAIMABLE | __GFP_AC=
COUNT)
> +#define OBJCGS_CLEAR_MASK      (__GFP_DMA | __GFP_RECLAIMABLE | \
> +                                __GFP_ACCOUNT | __GFP_NOFAIL)
>
>  /*
>   * mod_objcg_mlstate() may be called with irq enabled, so
> --
> 2.42.0
>

