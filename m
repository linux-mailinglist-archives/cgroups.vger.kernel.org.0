Return-Path: <cgroups+bounces-389-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA567EA9B8
	for <lists+cgroups@lfdr.de>; Tue, 14 Nov 2023 05:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CACC31C209DE
	for <lists+cgroups@lfdr.de>; Tue, 14 Nov 2023 04:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC0F8827;
	Tue, 14 Nov 2023 04:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PicbEKxJ"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D002BA31
	for <cgroups@vger.kernel.org>; Tue, 14 Nov 2023 04:42:53 +0000 (UTC)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F43D45
	for <cgroups@vger.kernel.org>; Mon, 13 Nov 2023 20:42:51 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1cc921a4632so47360895ad.1
        for <cgroups@vger.kernel.org>; Mon, 13 Nov 2023 20:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699936971; x=1700541771; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sCrSsxjAq1jCq+B2JpsAc9Scn9B6dHAemDj3eFlW1CE=;
        b=PicbEKxJg/UQGOrmAEEc1CFbYiPVXA4zgetGi1XaHRZx3T3vft9I8d4NKcB97Fj1NA
         GlwPWecS2g0DWpjuJ6UVfX3PqT36r/HU5aXZ7pOchbgI3v5UvJBB66mqNBsHogDhZEST
         yn4E/W7e3HCNnPfPWL4OA7JISg7xENXuYJTCs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699936971; x=1700541771;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sCrSsxjAq1jCq+B2JpsAc9Scn9B6dHAemDj3eFlW1CE=;
        b=IBYtbFaMyUNt5/Ln+60XXF3sROIhsnMOjYm6l1siJryo8+LGZWKA77b7PIsey6sn1r
         hTyQK8Nt8XRQsE0J92vm+/3UnFlAxVa1Vc7YNBUhJapntwoMaXBACNce4RwojyvzOhTl
         BwlJYfZYBvptkG30r2vmBMIODcGlm09N4qwqZZOQgqUE1s4fkVBQl3xDaomJ5tbWTg5q
         YdSDr1HQrohKdo9HlY6lbA7G1SL/ZSOLHcU5y1T1yzdKEZ5rOI3duezGiE//TS1njRZp
         PNkqgULHVHz5OkCGW+GSNLT6jVO9EMt7NkNsW7Bt2gVmfzZ29dNHXYWBVU8dR8lI1bP6
         FiHQ==
X-Gm-Message-State: AOJu0Yz29507J4s3ILNy2rlw4MUu0IjOMzbvxb7YyTFC1gbIonXljuxm
	OmXBT41lMEShYKTcrhChWdS5bg==
X-Google-Smtp-Source: AGHT+IGdwyQZzmA4/9nwfKzzB4u85s8j9BkjlV/hZKmIfu7UdDuaDJSnLL1zsdTxEYzRzIo24svtGQ==
X-Received: by 2002:a17:902:db0d:b0:1cc:4467:a563 with SMTP id m13-20020a170902db0d00b001cc4467a563mr1181743plx.3.1699936971495;
        Mon, 13 Nov 2023 20:42:51 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id z5-20020a1709027e8500b001b8622c1ad2sm4947830pla.130.2023.11.13.20.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 20:42:51 -0800 (PST)
Date: Mon, 13 Nov 2023 20:42:50 -0800
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
Subject: Re: [PATCH 12/20] mm/slab: move pre/post-alloc hooks from slab.h to
 slub.c
Message-ID: <202311132042.CA0081D@keescook>
References: <20231113191340.17482-22-vbabka@suse.cz>
 <20231113191340.17482-34-vbabka@suse.cz>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113191340.17482-34-vbabka@suse.cz>

On Mon, Nov 13, 2023 at 08:13:53PM +0100, Vlastimil Babka wrote:
> We don't share the hooks between two slab implementations anymore so
> they can be moved away from the header. As part of the move, also move
> should_failslab() from slab_common.c as the pre_alloc hook uses it.
> This means slab.h can stop including fault-inject.h and kmemleak.h.
> Fix up some files that were depending on the includes transitively.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

