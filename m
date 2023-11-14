Return-Path: <cgroups+bounces-386-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 135997EA998
	for <lists+cgroups@lfdr.de>; Tue, 14 Nov 2023 05:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B1191C209FA
	for <lists+cgroups@lfdr.de>; Tue, 14 Nov 2023 04:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB785688;
	Tue, 14 Nov 2023 04:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VxE/DCWN"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298F11857
	for <cgroups@vger.kernel.org>; Tue, 14 Nov 2023 04:35:23 +0000 (UTC)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8883CD48
	for <cgroups@vger.kernel.org>; Mon, 13 Nov 2023 20:35:21 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1cc0d0a0355so39058045ad.3
        for <cgroups@vger.kernel.org>; Mon, 13 Nov 2023 20:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699936520; x=1700541320; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2qJn7DbKeJdLYDJu5dncSAZYv48TYbHL51nKAxUFFOc=;
        b=VxE/DCWNcSFtXJqtMpC5QYzIGEDDTrbGj1yGBts3uz3R8d79LNFTfdbcA/dEm3oWmU
         TuQBe0HqbhQk6KF/7tJi49BEdYtBpNkJdvNV7ks7ATnuALZJZDtdrKXZVIOwdfPKiENH
         LfPv9Vqm5v/fj6z1faQR4T9fugFDwkGg8Iyi8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699936520; x=1700541320;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2qJn7DbKeJdLYDJu5dncSAZYv48TYbHL51nKAxUFFOc=;
        b=rHpA45k+oT+7KgSSrgz/RDiwMTwpdMho/cJfO74G+2DT2ODZUs0UG4WO6HInKmXICj
         m9u4KGwhTxeLttx6UGS9C58xR6Z8y0HULQBwGzHBO05FbQ3+B5mFpTr8R4wi5Ru7E6Am
         tn4oV2hDkdVXTYfCwzz8a492WSbPqaYkyAveaE/3w1rUIJWEADOPXdzEUqWEsIPXw9/R
         kAwvFw2ozhNWiaFVNfitHMGmUIOVbC03SqP7OMA4Ley7/bRPLDgiidmLX1txNlHAYoSL
         1HbveVrzlt8AfPSYmyVOBWbmS1k5HF4cIjlxOeEj2yfaSJ8IcwVGsR6W9UQOEP8YdtlU
         LxRA==
X-Gm-Message-State: AOJu0Yx8lQmr8LPSDlrIeVFcMU4Ay81Egl2QDUe59oD/trSwxoNY4oqU
	jbXcadkJfBymh82J0FVja7s8jw==
X-Google-Smtp-Source: AGHT+IE2Kxwisuvac82p84jaALXF4xxfKmYC9mDZ5biXrUMK+/x45Z1bswMrDeJnNGtZLpoEhO/6PA==
X-Received: by 2002:a17:903:11d1:b0:1cc:6cc7:e29f with SMTP id q17-20020a17090311d100b001cc6cc7e29fmr1410299plh.43.1699936520572;
        Mon, 13 Nov 2023 20:35:20 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id l18-20020a170903121200b001bf52834696sm4762331plh.207.2023.11.13.20.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 20:35:20 -0800 (PST)
Date: Mon, 13 Nov 2023 20:35:19 -0800
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
Subject: Re: [PATCH 09/20] mm/slab: move struct kmem_cache_cpu declaration to
 slub.c
Message-ID: <202311132035.A0F72C0F5@keescook>
References: <20231113191340.17482-22-vbabka@suse.cz>
 <20231113191340.17482-31-vbabka@suse.cz>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113191340.17482-31-vbabka@suse.cz>

On Mon, Nov 13, 2023 at 08:13:50PM +0100, Vlastimil Babka wrote:
> Nothing outside SLUB itself accesses the struct kmem_cache_cpu fields so
> it does not need to be declared in slub_def.h. This allows also to move
> enum stat_item.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

