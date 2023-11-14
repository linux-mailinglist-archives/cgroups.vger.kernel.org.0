Return-Path: <cgroups+bounces-396-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1897EAB52
	for <lists+cgroups@lfdr.de>; Tue, 14 Nov 2023 09:06:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54FA4B20AE1
	for <lists+cgroups@lfdr.de>; Tue, 14 Nov 2023 08:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C3912B86;
	Tue, 14 Nov 2023 08:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IiRdUCYQ"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EBC134B7
	for <cgroups@vger.kernel.org>; Tue, 14 Nov 2023 08:06:39 +0000 (UTC)
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 841041A7
	for <cgroups@vger.kernel.org>; Tue, 14 Nov 2023 00:06:38 -0800 (PST)
Received: by mail-ua1-x92a.google.com with SMTP id a1e0cc1a2514c-7b6cd2afaf2so2154306241.0
        for <cgroups@vger.kernel.org>; Tue, 14 Nov 2023 00:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699949197; x=1700553997; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7LGBUC9KsVeG0zIgCHu5xE4QSpLiIpSfaSXOL0b9rF8=;
        b=IiRdUCYQbFjr9/sDs8KQqqCO7B89W/F35GafT+ceeahygeU2k1rtibLo8VFlGItvza
         7WPGYcsLL7FFCGNuYbgD+0QgJRNC8hsR6zqym+9nISZPW+W1rhAvaoM5k4fyNEsx8KUl
         nG8TeEfzmnbSg1J4j7GOP8+39QCf57Fqe4qhX9iSJrNwXqjrRuzJ5BUGn3wW2CkmEwY6
         09WASEZQG6qam3P+ZxY8JeBRIFP/stwyMrPG1Fuu8xeuSoo/3dORugqFgPBBrbdBLU0r
         0UFwRtMkjCHOzGMGzg2W+WdeAw2vljA06mOuL2PJvD+aeftZ3JTu/UKFbyOr4qWwSWvF
         mfOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699949197; x=1700553997;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7LGBUC9KsVeG0zIgCHu5xE4QSpLiIpSfaSXOL0b9rF8=;
        b=D1Tx1SeFnSsH8cvS00/+f1UhHbtKuH5MvUB9qBGc7FlTTh/5jVUJ2pFiAJdOM2e1Dn
         jHB4GXUF3z1+toZXQ0/aJgcwE4BOlSf4udwEJYeL8xzO1qBv4ooE63nlaD/YW+PhSCH7
         FmzZ3/WBiFRWrIGU59Bj00jaS/O7HUFj2dI+eiyrO72TwyaLhXPa5t0YvKxUhv6M06QZ
         eeX0BuxTteVzd+ad1QaP6xM9+xh+pyYuxAm53NAJbdpSeZylH/W3IW7dw7YfRWQT1v0z
         9jAS0lfqJ2Px1L2mBH2v4eugVTJSKQKcUxyjuj2PSDZE+uj29AhE1cbzPLwBK3njJbzW
         ZvFQ==
X-Gm-Message-State: AOJu0Yxs8scvDuYvja891mEmy0Kx/WHz+ZIEWTyrQyPX9mWcEMg/LkQn
	RsC2kYnbw8dKQD3t2FmNNE6O4dbxYjcDTcFxOHNtbQ==
X-Google-Smtp-Source: AGHT+IHRIIJ2otFiB28Ipx0WgE1WaXBMqJrx1/oRb4fjPk7Cj1iPewjxrE+pVnHo7BMp6gIpNsFRoZRKbs2enis0SEY=
X-Received: by 2002:a05:6102:474e:b0:452:6178:642c with SMTP id
 ej14-20020a056102474e00b004526178642cmr8315473vsb.1.1699949197540; Tue, 14
 Nov 2023 00:06:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231113191340.17482-22-vbabka@suse.cz> <20231113191340.17482-30-vbabka@suse.cz>
In-Reply-To: <20231113191340.17482-30-vbabka@suse.cz>
From: Marco Elver <elver@google.com>
Date: Tue, 14 Nov 2023 09:06:01 +0100
Message-ID: <CANpmjNNkojcku+2-Lh=LX=_TXq3+x0M0twYQG2dBWA0Aeqr=Xw@mail.gmail.com>
Subject: Re: [PATCH 08/20] mm/slab: remove mm/slab.c and slab_def.h
To: Vlastimil Babka <vbabka@suse.cz>
Cc: David Rientjes <rientjes@google.com>, Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Shakeel Butt <shakeelb@google.com>, 
	Muchun Song <muchun.song@linux.dev>, Kees Cook <keescook@chromium.org>, 
	kasan-dev@googlegroups.com, cgroups@vger.kernel.org, 
	Mark Hemment <markhe@nextd.demon.co.uk>
Content-Type: text/plain; charset="UTF-8"

On Mon, 13 Nov 2023 at 20:14, Vlastimil Babka <vbabka@suse.cz> wrote:
>
> Remove the SLAB implementation. Update CREDITS (also sort the SLOB entry
> properly).
>
> RIP SLAB allocator (1996 - 2024)
>
> Cc: Mark Hemment <markhe@nextd.demon.co.uk>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  CREDITS                  |   12 +-
>  include/linux/slab_def.h |  124 --
>  mm/slab.c                | 4026 --------------------------------------

There are still some references to it left (git grep mm/slab.c). It
breaks documentation in Documentation/core-api/mm-api.rst

