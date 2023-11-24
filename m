Return-Path: <cgroups+bounces-544-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B61867F69EF
	for <lists+cgroups@lfdr.de>; Fri, 24 Nov 2023 01:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 746CB281769
	for <lists+cgroups@lfdr.de>; Fri, 24 Nov 2023 00:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501AE394;
	Fri, 24 Nov 2023 00:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DBUVo17z"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EAACD44
	for <cgroups@vger.kernel.org>; Thu, 23 Nov 2023 16:46:15 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1cc79f73e58so217925ad.1
        for <cgroups@vger.kernel.org>; Thu, 23 Nov 2023 16:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700786775; x=1701391575; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dyESJhHP/pA7tKXWx5D4jkhxltBcaPXfc9yFdB3lYZU=;
        b=DBUVo17z86SRMOOBFdHp2cYmFZYNHdOjvB2rZUe66ncJqD+NhueRu2xLfhqStXg6p3
         WzXwV4J1F9Zj4qw5HrhYh1X8+dv6cPemftNkVkPo6eWGzt6tIE+c/5crxOV0PNDLv0aR
         70XVWtbs+FCrpInWFk6sr4YFUymi/anQZzBp61IO0ogo3MeYeiuN75kZ0aTmobav19ad
         uT60zBIfTdVNyH+Y7oU11PwUm01h/b1j+ZR2Mb0JGZsssY4oiXF0xtPS3OEWQc0gQiHp
         ZWUg3g1FzAkPF/XIBseq8baAc5PFvS/A6HRIKS+7n/zCby7gZz0PIdJ63SnvAAKZ6GiD
         KJhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700786775; x=1701391575;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dyESJhHP/pA7tKXWx5D4jkhxltBcaPXfc9yFdB3lYZU=;
        b=mTE5/PqyayGX1OFY0e2ju6XoK9OraCzS3u+9M1K2/oC0xIIUK3uOeKX3dOix+SS4k2
         2JSv67NM4jqtje8KlcxK8RwzK6aWGp3TZeEEsq9KSCoWi5zjggNz9IVxdIqrKDwE2u0d
         GxL8QAt26FjJb7qYHLCOGQtYMMMRuHHYcGzxsgkCIlS3mOGDr4cud4nGuWyiJP3Vs5dZ
         jsduI23WBSswweNoco2Wy4na38aVR61xnTF0lDR8LRDBKucwINC4MXs0zU5b3jMbw0xT
         gIQMNw7tIBLtpwb/8S/uQAQ9y7aMhAIb3D7IMFNl3Uvd1QQkztWb6cPUQQ5vccbb1xHw
         dfxg==
X-Gm-Message-State: AOJu0YwFF/pCeBT250kBQr/1E/fcxoHYx+03cUFxp/0gwjShD5cAWa90
	usQdo/LhQXoTaP2nzus9T6qbjw==
X-Google-Smtp-Source: AGHT+IG9L5wkvJ9LV55yMZVFmvH9BcaUHyRQbnf/LCI7b+GigUlq7H9pPPL4PRM5AdlOR0f0KUTRiw==
X-Received: by 2002:a17:903:1245:b0:1cf:6573:9fe0 with SMTP id u5-20020a170903124500b001cf65739fe0mr609687plh.16.1700786774750;
        Thu, 23 Nov 2023 16:46:14 -0800 (PST)
Received: from [2620:0:1008:15:ab09:50a5:ec6d:7b5c] ([2620:0:1008:15:ab09:50a5:ec6d:7b5c])
        by smtp.gmail.com with ESMTPSA id c1-20020a170902724100b001bde6fa0a39sm1951963pll.167.2023.11.23.16.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 16:46:13 -0800 (PST)
Date: Thu, 23 Nov 2023 16:46:13 -0800 (PST)
From: David Rientjes <rientjes@google.com>
To: Vlastimil Babka <vbabka@suse.cz>
cc: Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, 
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
Subject: Re: [PATCH v2 01/21] mm/slab, docs: switch mm-api docs generation
 from slab.c to slub.c
In-Reply-To: <20231120-slab-remove-slab-v2-1-9c9c70177183@suse.cz>
Message-ID: <ea6d3060-1517-6eac-8939-1f3d004cef1a@google.com>
References: <20231120-slab-remove-slab-v2-0-9c9c70177183@suse.cz> <20231120-slab-remove-slab-v2-1-9c9c70177183@suse.cz>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 20 Nov 2023, Vlastimil Babka wrote:

> The SLAB implementation is going to be removed, and mm-api.rst currently
> uses mm/slab.c to obtain kerneldocs for some API functions. Switch it to
> mm/slub.c and move the relevant kerneldocs of exported functions from
> one to the other. The rest of kerneldocs in slab.c is for static SLAB
> implementation-specific functions that don't have counterparts in slub.c
> and thus can be simply removed with the implementation.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

This is new to v2 so I didn't technically get to test it.  But no testing 
required on this one :)

Acked-by: David Rientjes <rientjes@google.com>

