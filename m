Return-Path: <cgroups+bounces-3341-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B788915F4D
	for <lists+cgroups@lfdr.de>; Tue, 25 Jun 2024 09:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F01B3281487
	for <lists+cgroups@lfdr.de>; Tue, 25 Jun 2024 07:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C00E1465A3;
	Tue, 25 Jun 2024 07:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="U8iNDRT4"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3298514659E
	for <cgroups@vger.kernel.org>; Tue, 25 Jun 2024 07:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719299134; cv=none; b=huFJBWfdzrxxp8LHHAflAimU15HdXr/CNnDg/+CotatgceH8T55usFoBLndWOhZY1sN0rYKbsic32rDqqXQAE4DwuW7/J5hR+06E8+hvnOGpH7C1r1/WDMjHDkUq+0Yyq33XMy8QG3S8qXG9lB2v/s/b5rK61Fgg6Y5w7jA+A00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719299134; c=relaxed/simple;
	bh=5wHPKnBN4N13ssl6pFwaMGesK3D0vPy/TFPtbLfiIlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f91o98UVXWP7Y+RefBEgyn8dHtQDNoATRgF/mK5dw2LlWvkPZ2D+0UsHRk/QaQVfJYHWzdYq97QvjLh4rt+95QchJbGJMAVYPAddRdX9J849Jz5CNgLCkUSZrwql9dxevySk59jFks5wJmeeRz3UYy8GnSUDA0FYZ4KzHB/8K4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=U8iNDRT4; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-57d251b5fccso4657974a12.0
        for <cgroups@vger.kernel.org>; Tue, 25 Jun 2024 00:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1719299130; x=1719903930; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dRU5D6TfCbGDRiZmBlg8+VtjEI6bshTmmOYL3XFdx+8=;
        b=U8iNDRT4P4ncpmdaMFXItboWjDv/lyapk7NAxqZ8Ra4Q6t3ksuo3EdwBAD7WP2GADE
         rEr7ACOoAAD5RTxD80y6BTAxGkuX1AW/9LxfZqfnqLquC3tBgwY/tAYfgnxryfvRwCMe
         MNGHcwthkYkvGLFa9Fjz/R8yf0Lovv+hdXC/eaRxTQ+G2XL7UnU8FRAoW/YDzLF8n+n0
         n+XKKrdtt2udDU8J7pbmsMlLLck9s2V5xkTHnpk5jfQs1JDTX/RLJQlflZXhQpJj6h1n
         ngVDQsCOR1bn8jd7ZheAqxGpBV8NJxma59JG/alMgksfqmR1ZUA48G7Pm8YVmTeRgqpD
         xoGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719299130; x=1719903930;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dRU5D6TfCbGDRiZmBlg8+VtjEI6bshTmmOYL3XFdx+8=;
        b=UCJ6UwnUOULW/dIwA7xfCMjjybrIEpoNhfXZukcSljGJXajqPpt60+2vsR7mMfQO/L
         lo4GxMrhkae+Qh1Rp+rchXFFrFYx1YhlrP16iIYF5joadX/b7HAFmxtUaDcofp1U8PTk
         IAmjWybjGzAMTn7kxFB1boCR6sSAjcQPjmB3NtsWl/AGg4M9KKX9WqcK7XbXSmfacBZf
         GnhPL9rlwxKGRE2xs/9n0aOGHvtQZ0c2xUhVPwDf3vYLXE24Umk8lh4r6wrEguD2oFOd
         +1cCte6urNn+SIU4W/qfzqTd5fqV2SyfHpLjEZBcnoQdX5VSY5OEYNWG+llfPNF2GUGp
         J19w==
X-Forwarded-Encrypted: i=1; AJvYcCXgwRLT6YXMdVlupEyztX7utF9o7c7WbMg56/m+rCA3diQXjOBUrwEyECeqYtbwWOSdvQ4DzboUe7ZFmPtCUgsostz4siQ+0Q==
X-Gm-Message-State: AOJu0YydV2Io7RXGE1+npDGhWcJyyhZOcJgucOfr3JE53kPhqQkPYeSw
	4ZiZvf2OoSbx+bPTYbfR4D/TkxSxxTcjULV+/EbNVWVfa+yuVPjUFUb3AypOwEM=
X-Google-Smtp-Source: AGHT+IFRK+lk5imMJt5M29iwxHDdbQXMOuxaGyygqaPcLVPZB9z7Ln2YwJJbnA7lqq9jY9Vh78Xqug==
X-Received: by 2002:a50:a6c4:0:b0:57d:50e:d76b with SMTP id 4fb4d7f45d1cf-57d4bd53462mr3633602a12.7.1719299130392;
        Tue, 25 Jun 2024 00:05:30 -0700 (PDT)
Received: from localhost (109-81-95-13.rct.o2.cz. [109.81.95.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d303d7aaasm5548582a12.4.2024.06.25.00.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 00:05:30 -0700 (PDT)
Date: Tue, 25 Jun 2024 09:05:29 +0200
From: Michal Hocko <mhocko@suse.com>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 01/14] mm: memcg: introduce memcontrol-v1.c
Message-ID: <ZnpsOaMLI4Y-Ju50@tiehlicka>
References: <20240625005906.106920-1-roman.gushchin@linux.dev>
 <20240625005906.106920-2-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625005906.106920-2-roman.gushchin@linux.dev>

On Mon 24-06-24 17:58:53, Roman Gushchin wrote:
> This patch introduces the mm/memcontrol-v1.c source file which will be used for
> all legacy (cgroup v1) memory cgroup code. It also introduces mm/memcontrol-v1.h
> to keep declarations shared between mm/memcontrol.c and mm/memcontrol-v1.c.
> 
> As of now, let's compile it if CONFIG_MEMCG is set, similar to mm/memcontrol.c.
> Later on it can be switched to use a separate config option, so that the legacy
> code won't be compiled if not required.

I do not feel strongly about that but wouldn't having the new config
here already make it easier to test?

> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>

Anyway
Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/Makefile        | 3 ++-
>  mm/memcontrol-v1.c | 3 +++
>  mm/memcontrol-v1.h | 7 +++++++
>  3 files changed, 12 insertions(+), 1 deletion(-)
>  create mode 100644 mm/memcontrol-v1.c
>  create mode 100644 mm/memcontrol-v1.h
> 
> diff --git a/mm/Makefile b/mm/Makefile
> index 8fb85acda1b1..124d4dea2035 100644
> --- a/mm/Makefile
> +++ b/mm/Makefile
> @@ -26,6 +26,7 @@ KCOV_INSTRUMENT_page_alloc.o := n
>  KCOV_INSTRUMENT_debug-pagealloc.o := n
>  KCOV_INSTRUMENT_kmemleak.o := n
>  KCOV_INSTRUMENT_memcontrol.o := n
> +KCOV_INSTRUMENT_memcontrol-v1.o := n
>  KCOV_INSTRUMENT_mmzone.o := n
>  KCOV_INSTRUMENT_vmstat.o := n
>  KCOV_INSTRUMENT_failslab.o := n
> @@ -95,7 +96,7 @@ obj-$(CONFIG_NUMA) += memory-tiers.o
>  obj-$(CONFIG_DEVICE_MIGRATION) += migrate_device.o
>  obj-$(CONFIG_TRANSPARENT_HUGEPAGE) += huge_memory.o khugepaged.o
>  obj-$(CONFIG_PAGE_COUNTER) += page_counter.o
> -obj-$(CONFIG_MEMCG) += memcontrol.o vmpressure.o
> +obj-$(CONFIG_MEMCG) += memcontrol.o memcontrol-v1.o vmpressure.o
>  ifdef CONFIG_SWAP
>  obj-$(CONFIG_MEMCG) += swap_cgroup.o
>  endif
> diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
> new file mode 100644
> index 000000000000..a941446ba575
> --- /dev/null
> +++ b/mm/memcontrol-v1.c
> @@ -0,0 +1,3 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +#include "memcontrol-v1.h"
> diff --git a/mm/memcontrol-v1.h b/mm/memcontrol-v1.h
> new file mode 100644
> index 000000000000..7c5f094755ff
> --- /dev/null
> +++ b/mm/memcontrol-v1.h
> @@ -0,0 +1,7 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +#ifndef __MM_MEMCONTROL_V1_H
> +#define __MM_MEMCONTROL_V1_H
> +
> +
> +#endif	/* __MM_MEMCONTROL_V1_H */
> -- 
> 2.45.2

-- 
Michal Hocko
SUSE Labs

