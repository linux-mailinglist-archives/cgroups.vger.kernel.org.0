Return-Path: <cgroups+bounces-379-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1FDD7EA962
	for <lists+cgroups@lfdr.de>; Tue, 14 Nov 2023 05:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76BDA28108A
	for <lists+cgroups@lfdr.de>; Tue, 14 Nov 2023 04:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A58946E;
	Tue, 14 Nov 2023 04:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HMroAsQe"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD100BA2B
	for <cgroups@vger.kernel.org>; Tue, 14 Nov 2023 04:13:07 +0000 (UTC)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B27135
	for <cgroups@vger.kernel.org>; Mon, 13 Nov 2023 20:13:06 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6bb4abb8100so4302854b3a.2
        for <cgroups@vger.kernel.org>; Mon, 13 Nov 2023 20:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699935186; x=1700539986; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+59LbEu2KNUEAvaciP4no1NYqRz3c5xA76P/RF2+jHM=;
        b=HMroAsQeUbhDkG3TvWHxJdmh3JQsX3xPQv/9ohE6D2fBIK/q7zR2HoL6ZqPZDmPQCI
         RACizT8YbH9y2TJEzLlbIIK7KVWjq8Q+UHeQPfs+imyp09RUA2/ylYYCF7HIjgHJmv01
         ARGG9WBdC7RslTqwXx3kFSYxY6iMoKHbLWJ4w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699935186; x=1700539986;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+59LbEu2KNUEAvaciP4no1NYqRz3c5xA76P/RF2+jHM=;
        b=wdIQXcY9ceHKeFBdLFrbh0WG61EO7AA4vzDA/w8XFs/Fm3jA0yOxMYkqKtLpohLpfG
         ZZkyErG4BNAdKGuUnsyN5JqlrZiHNVFtXPofVuPDG2525L9JoUDwCPMAarNgDkXOkVlV
         jx712Upa/u6mPH0q0cE3lHFyDGw6X1iGtTarc4KPt+oPMT5Sz2Qe43+hwQgdpJHgRoXj
         fN9HKQs7Kd3MoAwHxRCr+4c0eMNe4dJsyVuheZDGWd7xI6KAHYSj8rVZORgQqhktc/Js
         j+JPMT4GJhTwPYnlf+7bKc9x7yjd88xU3t/x1G7g2Y1WDQQhDOGnrMcvRUfS8xFngMLi
         HY5g==
X-Gm-Message-State: AOJu0YyOf6jRXyIfu2kPK9bruMCY4Jrkbe1gMuHI2oXsQzXK1vDkqI8j
	x8UhA2YnpdMZcCBiNIA3Ge5wzA==
X-Google-Smtp-Source: AGHT+IFnyRA9Bn0/Hw8sxY38vdUYS60UHoNlHsJm70MG0sel5PqsKgmyNC3i7GG3PlPRUovMdSf9XQ==
X-Received: by 2002:a05:6a00:2d82:b0:6c3:45bc:41f8 with SMTP id fb2-20020a056a002d8200b006c345bc41f8mr7440255pfb.33.1699935185790;
        Mon, 13 Nov 2023 20:13:05 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p28-20020a056a000a1c00b006933e71956dsm353045pfh.9.2023.11.13.20.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 20:13:05 -0800 (PST)
Date: Mon, 13 Nov 2023 20:13:04 -0800
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
Subject: Re: [PATCH 02/20] KASAN: remove code paths guarded by CONFIG_SLAB
Message-ID: <202311132012.142AC3618@keescook>
References: <20231113191340.17482-22-vbabka@suse.cz>
 <20231113191340.17482-24-vbabka@suse.cz>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113191340.17482-24-vbabka@suse.cz>

On Mon, Nov 13, 2023 at 08:13:43PM +0100, Vlastimil Babka wrote:
> With SLAB removed and SLUB the only remaining allocator, we can clean up
> some code that was depending on the choice.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

