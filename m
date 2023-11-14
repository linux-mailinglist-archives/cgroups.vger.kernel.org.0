Return-Path: <cgroups+bounces-380-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A1D47EA967
	for <lists+cgroups@lfdr.de>; Tue, 14 Nov 2023 05:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE6AC281034
	for <lists+cgroups@lfdr.de>; Tue, 14 Nov 2023 04:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C30A947E;
	Tue, 14 Nov 2023 04:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MCQioEW6"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F258B650
	for <cgroups@vger.kernel.org>; Tue, 14 Nov 2023 04:14:41 +0000 (UTC)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45308D56
	for <cgroups@vger.kernel.org>; Mon, 13 Nov 2023 20:14:40 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6c4884521f6so4371170b3a.0
        for <cgroups@vger.kernel.org>; Mon, 13 Nov 2023 20:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699935280; x=1700540080; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z2Esu3+YQCIX73TjWrtGheLocNwWakeCmjYailfwoZQ=;
        b=MCQioEW6V+eCI/33aqtY9Xe2THUUbr5HS3sieh7gOarPyZ02Qw/J2PvtMGq8WiA5JX
         9SzWrqyNNtFReBa4z3YQ3JlBMl6to2BfG701cf2wnwrYY10518kFpjtQpg2Au4Tl+A3s
         uZe4obsE2x1BKhpaaEcCXI2SC1Dv5w7uhsp3k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699935280; x=1700540080;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z2Esu3+YQCIX73TjWrtGheLocNwWakeCmjYailfwoZQ=;
        b=GPGpUzEpFoU+/3zLmiV8nh2vaAuXalz0LETNAWLJF1aomH6uQIf7jBvRM+UJvyL2z2
         HsOYyNzOydtmLGaPbxOZvZfn9mt7nVEGFL2cbP3tebcbhn3FwKGwUC55tO3Y5L++8RdW
         eDRpQRUd4YWtcm9KOLHvM7DwVn398D3VRpBzDON/25gqMcSGDcQYaDdXfhhPSn/0bhqH
         0CvNGIqIkgbn8aoa1BaDpuYzFtNjwX1qdRq4rJSH/n36otz64ruKmcJ3PugIr8MgkF74
         7Y/RO9NHEu3LmzUMY06cNPPYxwGHj/GOk2c5R1OKjTvFtPZ8Xe2zLylO9hG610dMGcJs
         wHRQ==
X-Gm-Message-State: AOJu0YyRufxqkVhwHdChF3CG2PdAfTlwYnr5Yay8fbHuumUKSq/mZ1Wx
	gefvRw3BU938EhaUA268ErWIZw==
X-Google-Smtp-Source: AGHT+IGCneV7PtQMzCmZ88wslaQb+x3DXpaYJcES4QpU4Zi4tRF8aU2Wpu3C/XhsasN/dPCLeWXBbQ==
X-Received: by 2002:a05:6a21:a598:b0:186:7842:ad0f with SMTP id gd24-20020a056a21a59800b001867842ad0fmr5685978pzc.31.1699935279698;
        Mon, 13 Nov 2023 20:14:39 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id o9-20020a170902778900b001ccb81e851bsm4739949pll.103.2023.11.13.20.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 20:14:38 -0800 (PST)
Date: Mon, 13 Nov 2023 20:14:38 -0800
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
Subject: Re: [PATCH 03/20] KFENCE: cleanup kfence_guarded_alloc() after
 CONFIG_SLAB removal
Message-ID: <202311132014.809B164D@keescook>
References: <20231113191340.17482-22-vbabka@suse.cz>
 <20231113191340.17482-25-vbabka@suse.cz>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113191340.17482-25-vbabka@suse.cz>

On Mon, Nov 13, 2023 at 08:13:44PM +0100, Vlastimil Babka wrote:
> Some struct slab fields are initialized differently for SLAB and SLUB so
> we can simplify with SLUB being the only remaining allocator.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

