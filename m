Return-Path: <cgroups+bounces-390-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF80E7EA9BB
	for <lists+cgroups@lfdr.de>; Tue, 14 Nov 2023 05:44:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B61CD1C209EE
	for <lists+cgroups@lfdr.de>; Tue, 14 Nov 2023 04:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249968BE3;
	Tue, 14 Nov 2023 04:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="G2/1J18V"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0608C01
	for <cgroups@vger.kernel.org>; Tue, 14 Nov 2023 04:44:13 +0000 (UTC)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91BEB11C
	for <cgroups@vger.kernel.org>; Mon, 13 Nov 2023 20:44:12 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6bd0e1b1890so4043701b3a.3
        for <cgroups@vger.kernel.org>; Mon, 13 Nov 2023 20:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699937052; x=1700541852; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6ONkBbb+HnFKyr5bwkUFFQAkj5jFzRIolELIrPxQNcw=;
        b=G2/1J18VoeNINnJJxXdPWwRQev9MzvoAyKfB5ahpNtbzkSu3gKkNMgOh/UmNYlxkMj
         LEFi7aE5u/qG2NRFsHcMt/bwWbVLrPCnpstIUAFvUDiarg7ieA5z9y+kPB06CfjacuS/
         UI0PHLnMTRu4X/DEEH8g7wAB97Kk9Pimhjxi8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699937052; x=1700541852;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ONkBbb+HnFKyr5bwkUFFQAkj5jFzRIolELIrPxQNcw=;
        b=qxblN5BSaWua+qu6Q64d0gI8zMHRxVk3otXKzyEvadjMY84RFZRnhnEIX6Xc0Oazvm
         yik4hF38UOxqJvKLREfoKtwAYWpN2UdT1M8GybAWgQepIufNhw6IpdrPEmZXQGXNN4lt
         y0ddVZwQRuuxyUnzQQjdH/Vvso/PDLFA3mJSV+vo5/H5TKxPRU0XoO0w5lPMyzUiZqn8
         5ikr7r/vuPyaaIWx3ZYuncQlU3hjIrBiRHe5EvcuezuqIGApMWWTwewhe9MUr18IlMu2
         gx0CWpbUHsP931ONZajEUI6bKtPBOq5S2A45lohRrYctQHirlGvc+Sr0abg46sF8949r
         ECRg==
X-Gm-Message-State: AOJu0Yx9EZeLmFQ/7DlJu3/2Grj0xTJARFy68MjDVyTD9c/rGJ7NF9Zk
	5mqfQcqSPsmIHuRn03K6qFswew==
X-Google-Smtp-Source: AGHT+IEvf5pYK6DfVdWq7oR/LeTR2EzKGTFOoIWwPF4qXeh10Ft7VrEO5A5ARaNGpev0/vRNIRBDhw==
X-Received: by 2002:a05:6a00:3a1f:b0:6c6:9b11:f718 with SMTP id fj31-20020a056a003a1f00b006c69b11f718mr6590354pfb.4.1699937052092;
        Mon, 13 Nov 2023 20:44:12 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id b22-20020aa78116000000b006be5e537b6csm389373pfi.63.2023.11.13.20.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 20:44:11 -0800 (PST)
Date: Mon, 13 Nov 2023 20:44:11 -0800
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
Subject: Re: [PATCH 13/20] mm/slab: move memcg related functions from slab.h
 to slub.c
Message-ID: <202311132044.C7D682723@keescook>
References: <20231113191340.17482-22-vbabka@suse.cz>
 <20231113191340.17482-35-vbabka@suse.cz>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113191340.17482-35-vbabka@suse.cz>

On Mon, Nov 13, 2023 at 08:13:54PM +0100, Vlastimil Babka wrote:
> We don't share those between SLAB and SLUB anymore, so most memcg
> related functions can be moved to slub.c proper.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

