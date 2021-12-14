Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69093474516
	for <lists+cgroups@lfdr.de>; Tue, 14 Dec 2021 15:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbhLNObV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 14 Dec 2021 09:31:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbhLNObV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 14 Dec 2021 09:31:21 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14A1C06173E
        for <cgroups@vger.kernel.org>; Tue, 14 Dec 2021 06:31:20 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id p4so16850479qkm.7
        for <cgroups@vger.kernel.org>; Tue, 14 Dec 2021 06:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PnyBX2cL3sw5aLNMKdlSdA2yt3vqpypZzbVoHtQrrVM=;
        b=wZQgz4iU8dcVuhq+qYq/G7JuK2OMB/oVTHlwJL/bGG8B1tlSX7/4hh4ix6KV0qclCe
         i0p8A7YvgdoSpgXZ/SxRZlPpizsWJShi6R94vn29FY7VRmBOcMDDxHeSIA1NnYhxyNuc
         d9SPlqd44LLK+PovtTV3viokDxrETGdMx0CFnL6zi4frZMiAmHmjHjVTcG+xzpIL83UH
         QPOoFB9Qsoc13xmJdPxzR1/IbsYCdSMaxQ4Z+h1pdkhF7y0wmIKTliqukN6tM1HwBG1v
         9+KC78lRYmxL23WMEmFgQvThoJ+vPtAVEQr6sUPuT8Ewb3OCafsexZCaYI7y5UahftT+
         qZZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PnyBX2cL3sw5aLNMKdlSdA2yt3vqpypZzbVoHtQrrVM=;
        b=2bpXiDS5DjP9YXusQ6TdUt24H0O+fyZfAujFIrbIg8etNYz54QGeyPb0B7gExePIGA
         x1sKKHnY97QwtEBdsDMKNerTE2ccdnr1kjRpYw+WQGJWQYkNzxDNoNHAmX2F3rxouxuv
         Ou8TfENnWapdn5ygFXWApvV6SuBwLG6YE51sc4qnCWYc3hnuzYt4hvE27Txm68q1EIP8
         ESGCts2REC/gEW+U1hRaUcMBIxVYwFlJEBrfmbBthQ1GhM71EaTbqULLXjWrcv8ZJMiN
         g0rrFgKA8dDiRnqKp8+V66ibMhXxqAevIhKad34Mm48aKShHwb3qRRxaJtWObukYfWs+
         y/EA==
X-Gm-Message-State: AOAM530gfO6CJonfZMiB7aBkgdBychLy43KO0/Lsxc511ewxW80CCjPQ
        eMp1HMXvy+2ousx+/Ou/opzO8g==
X-Google-Smtp-Source: ABdhPJx1zMmj8YSzdBlLGI6WhQ1M3/Q/BXQaLxrVp2mIQvcX/oOglXcHZT24vk553GZmjeLW1YQ7JA==
X-Received: by 2002:a37:654f:: with SMTP id z76mr4207368qkb.224.1639492276068;
        Tue, 14 Dec 2021 06:31:16 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:e1e4])
        by smtp.gmail.com with ESMTPSA id o9sm16361qtk.81.2021.12.14.06.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 06:31:15 -0800 (PST)
Date:   Tue, 14 Dec 2021 15:31:13 +0100
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        patches@lists.linux.dev, Julia Lawall <julia.lawall@inria.fr>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        kasan-dev@googlegroups.com, cgroups@vger.kernel.org
Subject: Re: [PATCH v2 22/33] mm: Convert struct page to struct slab in
 functions used by other subsystems
Message-ID: <YbiqseeMBeqbn5CR@cmpxchg.org>
References: <20211201181510.18784-1-vbabka@suse.cz>
 <20211201181510.18784-23-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211201181510.18784-23-vbabka@suse.cz>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Dec 01, 2021 at 07:14:59PM +0100, Vlastimil Babka wrote:
> KASAN, KFENCE and memcg interact with SLAB or SLUB internals through functions
> nearest_obj(), obj_to_index() and objs_per_slab() that use struct page as
> parameter. This patch converts it to struct slab including all callers, through
> a coccinelle semantic patch.
> 
> // Options: --include-headers --no-includes --smpl-spacing include/linux/slab_def.h include/linux/slub_def.h mm/slab.h mm/kasan/*.c mm/kfence/kfence_test.c mm/memcontrol.c mm/slab.c mm/slub.c
> // Note: needs coccinelle 1.1.1 to avoid breaking whitespace
> 
> @@
> @@
> 
> -objs_per_slab_page(
> +objs_per_slab(
>  ...
>  )
>  { ... }
> 
> @@
> @@
> 
> -objs_per_slab_page(
> +objs_per_slab(
>  ...
>  )
> 
> @@
> identifier fn =~ "obj_to_index|objs_per_slab";
> @@
> 
>  fn(...,
> -   const struct page *page
> +   const struct slab *slab
>     ,...)
>  {
> <...
> (
> - page_address(page)
> + slab_address(slab)
> |
> - page
> + slab
> )
> ...>
>  }
> 
> @@
> identifier fn =~ "nearest_obj";
> @@
> 
>  fn(...,
> -   struct page *page
> +   const struct slab *slab
>     ,...)
>  {
> <...
> (
> - page_address(page)
> + slab_address(slab)
> |
> - page
> + slab
> )
> ...>
>  }
> 
> @@
> identifier fn =~ "nearest_obj|obj_to_index|objs_per_slab";
> expression E;
> @@
> 
>  fn(...,
> (
> - slab_page(E)
> + E
> |
> - virt_to_page(E)
> + virt_to_slab(E)
> |
> - virt_to_head_page(E)
> + virt_to_slab(E)
> |
> - page
> + page_slab(page)
> )
>   ,...)
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> Cc: Julia Lawall <julia.lawall@inria.fr>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Andrey Konovalov <andreyknvl@gmail.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Marco Elver <elver@google.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
> Cc: <kasan-dev@googlegroups.com>
> Cc: <cgroups@vger.kernel.org>

LGTM.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
