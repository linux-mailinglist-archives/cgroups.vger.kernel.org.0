Return-Path: <cgroups+bounces-7831-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F37A9BD73
	for <lists+cgroups@lfdr.de>; Fri, 25 Apr 2025 06:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F1E544484B
	for <lists+cgroups@lfdr.de>; Fri, 25 Apr 2025 04:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE347215F42;
	Fri, 25 Apr 2025 04:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ggwyIA8A"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25A91531D5;
	Fri, 25 Apr 2025 04:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745554390; cv=none; b=nOStfkjgDStBSov2XVd9uvhIgKpO+GoZGow2pQr5/E+f6pRR/AQCyd+XKRUGgZsmZ+O7aBVK8SK9o/0Cd96hhG4XAZ7rk3i5PRUaUm6JSrSdfX/yS76DpBVeDIPMwtMFHlV0cqw1FYD7GfcDymFN50diLRX8g7JTz7ILYx8JOAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745554390; c=relaxed/simple;
	bh=Y0kzncZaCIV2dzCgkXJOemy9p4yP17WMIDPqhmmi06I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vg/lw/nJN57x3ImWk4rBNKpucbX9YToyY27jMoY1eZ4+HjmfIsd0n6qcur0GUkHCcYd3yr+d4VBZNVvKsiguNKAepnVi54wCC1eCb57oO9heuSrRU/e/KUcG1duD7ccBfT3nGxfa5Roqg/ux9xJEf4VrrjYMRKAaUOVwjDsZSSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ggwyIA8A; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-8777084a3c0so1559637241.0;
        Thu, 24 Apr 2025 21:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745554388; x=1746159188; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lty8ry8uAFKJsDTmzS1l3iWQ4joiwK7gSjoYFFd8YcY=;
        b=ggwyIA8AZBugi6tEyDL0PV8VGKSK1o4GMXfYwE2V7QJgVjdGu9HcXjhnMHIq8YzPPf
         kqaQcJW0hxImgTRU/eB6zRS0b70lmiaISDpDFNBFj2xsNHBl9vrQFlrShPhgy8WolWI1
         BKivG+gvOLtPJqFM+EXSIeeiM8NLlpLzQW8MrTOZ8HRCbnG+j9KpXuSUVrnakKLsOnnH
         Ct5sS1YvQVhR6kgm1PJlxhycX+8ui4gNfemOYwtupiB2af4vciw70C7owJf9FwbOsh6s
         GOFGIovuLIHv/jc6cx1ZR7IKjdP/RIVxRmV+nogLi5f7EOiYkzGSvfZZEYxnTwRL2TMA
         u/HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745554388; x=1746159188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lty8ry8uAFKJsDTmzS1l3iWQ4joiwK7gSjoYFFd8YcY=;
        b=uuFcpuTIcp6FQEnikM3uZn/MndVH/D2QrY8X6H5SBlxoRIC40uraKSnDBxCzwKlG6m
         4YDRI5l3WjyEk7fyGKHdi2drVMKGOB+N6rmyxPX8qvBOkTyGVphShHlzFVqOxL2lK+WB
         BwM7YzHV2CbTpb1nK7yu1UiEwIiz1GIaOzc4MFkGV+Fpw8M9Vo2MKzoY643kHosaZQQH
         C4rOM/hJ1+GyM/icPCsc9apbZsdJO4jJr3oUkVcJjzV8UG5lg8Pmoy1ttgYthGPt6zjn
         x4idUDnp7D6LqwME2wO3ZhllgXMfGN4OVodg1ZVgw0oMVzsIZoRvqS4ayZRw9q6ZPYSr
         wXiw==
X-Forwarded-Encrypted: i=1; AJvYcCVsNDIr/0NRnxk+eeCbWMYO3ooPcvADIW5WyfI7vSzF624McWY+YD+xKH2r7DEevYXYZ/vye6LY@vger.kernel.org, AJvYcCXNI+iC3WsIQThsf5a3u4xrS35a+jL4YPYw6RKi3bceEZCxSFu6Zd30oIGMy3cRjpcpe2fsao4BzPMT6diX@vger.kernel.org
X-Gm-Message-State: AOJu0YybuFSDzQvTz8f9Bf8Pvj7MMhewULokpObJ5+su5jXA2QwdOcw/
	pZ63FM06sEV+j/BRTOV/22pnZUVVgtdCBHW40M969qABeDUO+ACVn6rpnthYFaYSE17PNx56G3F
	War07I5QAnQLzFxCdGPNZwWcmJ/c=
X-Gm-Gg: ASbGncvM4Ho5bdpQxdbX/VScc0DVmQbAEoqMnLK8fbXcpBi2U4EyW31HWGOpSqLrd2h
	EOXkAUGYTZU/Ztsrkb0VgHuvNsBURkTm6GZZhiZQ9exd3FAzfteN4g9f0YtCZc6a4IrEHMoQVQU
	A54Ox7XHXfwx1x+XufT8qU
X-Google-Smtp-Source: AGHT+IF8rrvX81ZA4LS0FaP9ddvBwR7ipWjHwOCqP8hXX6Wf4ksgSCwyvLc/OYtQVZVplftDFKmKajKbXPQ8Zn2UADI=
X-Received: by 2002:a05:6102:c15:b0:4c3:6979:2ef with SMTP id
 ada2fe7eead31-4d545a3673emr260314137.21.1745554387798; Thu, 24 Apr 2025
 21:13:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250425031935.76411-1-link@vivo.com> <20250425031935.76411-4-link@vivo.com>
In-Reply-To: <20250425031935.76411-4-link@vivo.com>
From: Shakeel Butt <shakeel.butt@gmail.com>
Date: Thu, 24 Apr 2025 21:12:57 -0700
X-Gm-Features: ATxdqUHsm7-kLT6DsZDy4hqNfl8dr9aDBoVNjGupMj6X_R22RUE03UBZQkfd4Rc
Message-ID: <CAGj-7pUatp1LmfMhTVda_6r0-4PavPDyYYpJs_aTL+g_MAux0Q@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] mm/memcg: use kmem_cache when alloc memcg pernode info
To: Huan Yang <link@vivo.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Francesco Valla <francesco@valla.it>, Raul E Rangel <rrangel@chromium.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Huang Shijie <shijie@os.amperecomputing.com>, 
	Guo Weikang <guoweikang.kernel@gmail.com>, "Uladzislau Rezki (Sony)" <urezki@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Hyeonggon Yoo <hyeonggon.yoo@sk.com>, 
	Paul Moore <paul@paul-moore.com>, opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2025 at 8:19=E2=80=AFPM Huan Yang <link@vivo.com> wrote:
>
> When tracing mem_cgroup_per_node allocations with kmalloc ftrace:
>
> kmalloc: call_site=3Dmem_cgroup_css_alloc+0x1d8/0x5b4 ptr=3D00000000d7987=
00c
>     bytes_req=3D2896 bytes_alloc=3D4096 gfp_flags=3DGFP_KERNEL|__GFP_ZERO=
 node=3D0
>     accounted=3Dfalse
>
> This reveals the slab allocator provides 4096B chunks for 2896B
> mem_cgroup_per_node due to:
>
> 1. The slab allocator predefines bucket sizes from 64B to 8096B
> 2. The mem_cgroup allocation size (2312B) falls between the 2KB and 4KB
>    slabs
> 3. The allocator rounds up to the nearest larger slab (4KB), resulting in
>    ~1KB wasted memory per memcg alloc - per node.
>
> This patch introduces a dedicated kmem_cache for mem_cgroup structs,
> achieving precise memory allocation. Post-patch ftrace verification shows=
:
>
> kmem_cache_alloc: call_site=3Dmem_cgroup_css_alloc+0x1b8/0x5d4
>     ptr=3D000000002989e63a bytes_req=3D2896 bytes_alloc=3D2944
>     gfp_flags=3DGFP_KERNEL|__GFP_ZERO node=3D0 accounted=3Dfalse
>
> Each mem_cgroup_per_node alloc 2944bytes(include hw cacheline align),
> compare to 4096, it avoid waste.
>
> Signed-off-by: Huan Yang <link@vivo.com>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

