Return-Path: <cgroups+bounces-525-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA037F5130
	for <lists+cgroups@lfdr.de>; Wed, 22 Nov 2023 21:07:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 179261C20972
	for <lists+cgroups@lfdr.de>; Wed, 22 Nov 2023 20:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750475D8F0;
	Wed, 22 Nov 2023 20:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: cgroups@vger.kernel.org
Received: from gentwo.org (gentwo.org [IPv6:2a02:4780:10:3cd9::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB1A92;
	Wed, 22 Nov 2023 12:07:10 -0800 (PST)
Received: by gentwo.org (Postfix, from userid 1003)
	id 4D98A48F4A; Wed, 22 Nov 2023 12:07:10 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 4D06148F41;
	Wed, 22 Nov 2023 12:07:10 -0800 (PST)
Date: Wed, 22 Nov 2023 12:07:10 -0800 (PST)
From: Christoph Lameter <cl@linux.com>
To: Vlastimil Babka <vbabka@suse.cz>
cc: David Rientjes <rientjes@google.com>, Pekka Enberg <penberg@kernel.org>, 
    Joonsoo Kim <iamjoonsoo.kim@lge.com>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
    Roman Gushchin <roman.gushchin@linux.dev>, 
    Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
    Alexander Potapenko <glider@google.com>, 
    Andrey Konovalov <andreyknvl@gmail.com>, 
    Dmitry Vyukov <dvyukov@google.com>, 
    Vincenzo Frascino <vincenzo.frascino@arm.com>, 
    Marco Elver <elver@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
    Michal Hocko <mhocko@kernel.org>, Shakeel Butt <shakeelb@google.com>, 
    Muchun Song <muchun.song@linux.dev>, Kees Cook <keescook@chromium.org>, 
    linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
    kasan-dev@googlegroups.com, cgroups@vger.kernel.org, 
    linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 09/21] mm/slab: remove mm/slab.c and slab_def.h
In-Reply-To: <20231120-slab-remove-slab-v2-9-9c9c70177183@suse.cz>
Message-ID: <c1268fb3-691f-7e6f-4d63-1ecd281d66e0@linux.com>
References: <20231120-slab-remove-slab-v2-0-9c9c70177183@suse.cz> <20231120-slab-remove-slab-v2-9-9c9c70177183@suse.cz>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Mon, 20 Nov 2023, Vlastimil Babka wrote:

> Remove the SLAB implementation. Update CREDITS.
> Also update and properly sort the SLOB entry there.
>
> RIP SLAB allocator (1996 - 2024)
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Acked-by: Christoph Lameter <cl@linux.com>


