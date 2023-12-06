Return-Path: <cgroups+bounces-858-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62283806AB9
	for <lists+cgroups@lfdr.de>; Wed,  6 Dec 2023 10:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DAFA2819CF
	for <lists+cgroups@lfdr.de>; Wed,  6 Dec 2023 09:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C457F1A27C;
	Wed,  6 Dec 2023 09:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OYmJvRAt"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B412AA4;
	Wed,  6 Dec 2023 01:31:44 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-286867cac72so2090651a91.2;
        Wed, 06 Dec 2023 01:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701855104; x=1702459904; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2NfF/vadIJxiqQtkbCE9WfDn53uC8FiCtOLYYf2Xy1I=;
        b=OYmJvRAttszd0DUFROeAGFOcvSG6+iE4FlUAyNo8VGikFaNaYD46eA1QwpdHYBPEZY
         YY6MC3V5wMYouXJhi+/asjAPh1e9p3pFojx3tjbvmLtJPWInPWxTeKlanE5e97hLrUjq
         u4M43ahXGHxyzd+O3LRMXDobySVHl5dqqDQWU0R9XdFOPhQKSRnUWdSYpS96MsdCkYcG
         S5rrOSS9lxYpAKnc28mZ18BkgNz5U5RhGlHAIxvjy5IC1HKXxjblo2O44zTkhxL5DJfG
         bNfS+YFttaY+ogAQEtQ3rDM5Jqnpx/gqaVfhrsZTZJFj0fk9wcxcMw4Ex4LVXq/bH2Wf
         iwxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701855104; x=1702459904;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2NfF/vadIJxiqQtkbCE9WfDn53uC8FiCtOLYYf2Xy1I=;
        b=i4dcVQ70qkueRfJWZbXzpNJZ7Fj/4DOXDgjwoizwKWwmP7UVBH5u6mtvfcjyT0QzeI
         2czCa/S9IoyBrxjlJEX5kUIRm0rWoO+johDz6QybsDrpwFTnkAfi/ZVSLbNJY6u2Av1t
         5BwhGmf8W85yh1WpXjlHDRV4UA11kWarbBFsEuZ4z3fggXNiWhUB27IwH9yF9PFKNX+r
         m7hlKnVouvLjIHvYzEbTAIu4UTenPBstBwSl8UWWFo0HsmFREG6EpD1vvXWX++YWEkd6
         f/8yFGMCxj9zO8SJskvCCZv3MQ6X8VZ2COb32FGxL1KzL57X4Z81Xod0nzuL/iY+V16s
         zQFw==
X-Gm-Message-State: AOJu0YyiXBDktS6qWEXXVLDNyC6PSWH85eJ/3xhltLjypyPMmnIQ75IQ
	DNdOvCiiaLQi0dpB+VLVHc4=
X-Google-Smtp-Source: AGHT+IHWZraUS2fL1t578+dOE5+ZAg5+kiBEP0Z2wrhG0oFboAypDmBWWMm9Rea+ExbM5+j4C17AYg==
X-Received: by 2002:a17:90a:18e:b0:286:a501:26eb with SMTP id 14-20020a17090a018e00b00286a50126ebmr430755pjc.48.1701855103984;
        Wed, 06 Dec 2023 01:31:43 -0800 (PST)
Received: from localhost.localdomain ([1.245.180.67])
        by smtp.gmail.com with ESMTPSA id w5-20020a17090aea0500b00286d686b3d9sm2062111pjy.17.2023.12.06.01.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 01:31:42 -0800 (PST)
Date: Wed, 6 Dec 2023 18:31:24 +0900
From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: David Rientjes <rientjes@google.com>, Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Marco Elver <elver@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeelb@google.com>,
	Muchun Song <muchun.song@linux.dev>,
	Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
	cgroups@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 09/21] mm/slab: remove mm/slab.c and slab_def.h
Message-ID: <ZXA+Ur55OR1EU/5L@localhost.localdomain>
References: <20231120-slab-remove-slab-v2-0-9c9c70177183@suse.cz>
 <20231120-slab-remove-slab-v2-9-9c9c70177183@suse.cz>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120-slab-remove-slab-v2-9-9c9c70177183@suse.cz>

On Mon, Nov 20, 2023 at 07:34:20PM +0100, Vlastimil Babka wrote:
> Remove the SLAB implementation. Update CREDITS.
> Also update and properly sort the SLOB entry there.
> 
> RIP SLAB allocator (1996 - 2024)
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  CREDITS                  |   12 +-
>  include/linux/slab_def.h |  124 --
>  mm/slab.c                | 4005 ----------------------------------------------
>  3 files changed, 8 insertions(+), 4133 deletions(-)

Acked-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

> diff --git a/CREDITS b/CREDITS
> index f33a33fd2371..943a73e96149 100644
> --- a/CREDITS
> +++ b/CREDITS
> @@ -9,10 +9,6 @@
>  			Linus
>  ----------
>  
> -N: Matt Mackal
> -E: mpm@selenic.com
> -D: SLOB slab allocator

by the way I just realized that commit 16e943bf8db
("MAINTAINERS: SLAB maintainer update") incorrectly put her lastname
(Mackall is correct), maybe update that too?

>  N: Matti Aarnio
>  E: mea@nic.funet.fi
>  D: Alpha systems hacking, IPv6 and other network related stuff
> @@ -1572,6 +1568,10 @@ S: Ampferstr. 50 / 4
>  S: 6020 Innsbruck
>  S: Austria
>  
> +N: Mark Hemment
> +E: markhe@nextd.demon.co.uk
> +D: SLAB allocator implementation
> +
>  N: Richard Henderson
>  E: rth@twiddle.net
>  E: rth@cygnus.com
> @@ -2437,6 +2437,10 @@ D: work on suspend-to-ram/disk, killing duplicates from ioctl32,
>  D: Altera SoCFPGA and Nokia N900 support.
>  S: Czech Republic
>  
> +N: Olivia Mackal
> +E: olivia@selenic.com
> +D: SLOB slab allocator
> +
>  N: Paul Mackerras
>  E: paulus@samba.org
>  D: PPP driver
>
> -- 
> 2.42.1
> 
> 

