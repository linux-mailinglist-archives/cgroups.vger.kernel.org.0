Return-Path: <cgroups+bounces-383-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF5FF7EA983
	for <lists+cgroups@lfdr.de>; Tue, 14 Nov 2023 05:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 773871F23E62
	for <lists+cgroups@lfdr.de>; Tue, 14 Nov 2023 04:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80F8BA40;
	Tue, 14 Nov 2023 04:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bjZQ8lop"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE65EBA2B
	for <cgroups@vger.kernel.org>; Tue, 14 Nov 2023 04:30:15 +0000 (UTC)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE621D42
	for <cgroups@vger.kernel.org>; Mon, 13 Nov 2023 20:30:14 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-27ddc1b1652so4698441a91.2
        for <cgroups@vger.kernel.org>; Mon, 13 Nov 2023 20:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699936214; x=1700541014; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BVR/Ivq5aw+9huCWfoclhyK6Cz1m1uGsfFPrSjVP+os=;
        b=bjZQ8lop7hyDfPrFFjrGsbb/lxu+tN8uQzWKwFNUL1DZNN61se9kYli2KfjrzCaRkx
         lkooQ4QJrb8g2cNYZibL2BZvLbELxY1oV8YROHIimtEFXSs7zAQkXbwzkkqCNiQP33pf
         EpgRAEE046QEgMq7b0/7Q3jTGBKKcXkRyxblA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699936214; x=1700541014;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BVR/Ivq5aw+9huCWfoclhyK6Cz1m1uGsfFPrSjVP+os=;
        b=If8Gl9KW0FapPUVN8tuBiA8v1CtwpjroOsKOT1vC6/weKlE0YhLqTpEbrwjFPdvYle
         MhT22ZMqnv7f65XksYztb+tnvCavhP6HKnDnuUpWm9Dk8xqPaENp1ds92g6IfwyKe6yB
         RDBy1h/0yaA+2P0u4YDm7SrpshWhPL4730nozXZ6Bv9WWPU8fu278rvvxqyMkuaygr2K
         tC1oA+odFu8FG088lVKvSyhrxyHrW7KvOQBXSMZKCTD5s0RfKHAaeJ2ETmh39XuyRqRy
         CWzRitiol9spCsvKvfH0Hv9/EhdbvKvLw/GyWtTmClGk/OOwoolN9GA7uLmScBXzIilZ
         mIWQ==
X-Gm-Message-State: AOJu0Yxf+vAmcZQ4C44y2ScfCFfUKPjhsrADKhRFUuv+yc4FvzqAnYaG
	kEMIoIgg79AOn2CbI/lgNgL6dw==
X-Google-Smtp-Source: AGHT+IGHpiRYqf1wnawSvDbbqcUpNVvAlWIHQjTAdYW+tyahOMwSwXjVkxNjFnslO/Q+Xg7jd3gPkg==
X-Received: by 2002:a17:90b:1d06:b0:280:2823:6615 with SMTP id on6-20020a17090b1d0600b0028028236615mr8237152pjb.36.1699936214292;
        Mon, 13 Nov 2023 20:30:14 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id l24-20020a17090aec1800b00280fcbbe774sm4405770pjy.10.2023.11.13.20.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 20:30:13 -0800 (PST)
Date: Mon, 13 Nov 2023 20:30:13 -0800
From: Kees Cook <keescook@chromium.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: David Rientjes <rientjes@google.com>, Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, patches@lists.linux.dev,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Marco Elver <elver@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeelb@google.com>,
	Muchun Song <muchun.song@linux.dev>, kasan-dev@googlegroups.com,
	cgroups@vger.kernel.org
Subject: Re: [PATCH 06/20] mm/slab: remove CONFIG_SLAB code from slab common
 code
Message-ID: <202311132024.80A0D5D58@keescook>
References: <20231113191340.17482-22-vbabka@suse.cz>
 <20231113191340.17482-28-vbabka@suse.cz>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113191340.17482-28-vbabka@suse.cz>

On Mon, Nov 13, 2023 at 08:13:47PM +0100, Vlastimil Babka wrote:
> In slab_common.c and slab.h headers, we can now remove all code behind
> CONFIG_SLAB and CONFIG_DEBUG_SLAB ifdefs, and remove all CONFIG_SLUB
> ifdefs.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  include/linux/slab.h | 13 +--------
>  mm/slab.h            | 69 ++++----------------------------------------
>  mm/slab_common.c     | 22 ++------------
>  3 files changed, 8 insertions(+), 96 deletions(-)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 34e43cddc520..90fb1f0d843a 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -24,7 +24,6 @@
>  
>  /*
>   * Flags to pass to kmem_cache_create().
> - * The ones marked DEBUG are only valid if CONFIG_DEBUG_SLAB is set.

I think this comment was wrong, yes? i.e. the "DEBUG" flags are also
used in SLUB?

Regardless:

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

