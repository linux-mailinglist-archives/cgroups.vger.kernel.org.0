Return-Path: <cgroups+bounces-7845-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6160FA9E2E3
	for <lists+cgroups@lfdr.de>; Sun, 27 Apr 2025 13:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA793189CF02
	for <lists+cgroups@lfdr.de>; Sun, 27 Apr 2025 11:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F641252287;
	Sun, 27 Apr 2025 11:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="W72OZ96j"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E641F8AC0
	for <cgroups@vger.kernel.org>; Sun, 27 Apr 2025 11:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745755016; cv=none; b=Prc+PxE95Rud0ccKXGH7qdYirKT9rhBj8qw3eeAsKyh2KGO5sVpLp0jqHkM1Q5kjZhiWac0u0B4Z04zFypvO6aHttSTtAW+Qp0Lgo/eszZTjInq/9cXXlA1mUIu4g0Kxc8bQAC8rzNe/0IVystYmu3s2HSd2K2c8Bu/fDBvx2DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745755016; c=relaxed/simple;
	bh=KkuM9J9srAIq0iB1EJ3En1a60/DwuR89aCnCUTZyRvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sZq4C3N/md6pHcdLOA5C9yTMR5rJFC4D+weUr4BWf048xGLMG7ACG6mD521xaQ4th62eSzd+Xua7zDNTRPhMTYuIMVyXTrdhFKIEdrUlAx9j/dLB5wg2WVx3dqGVZKS7/yjOO2rryp2w8ijW1AsiPGnfsbHxadXzwNaxQZoS8rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=W72OZ96j; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6e8f7019422so40904126d6.1
        for <cgroups@vger.kernel.org>; Sun, 27 Apr 2025 04:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1745755013; x=1746359813; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3aguYnD7Euw8idfB6uGeUk5hHv75Psmkn+8V49As6tk=;
        b=W72OZ96jwlqEREiWjDrLNbrF/uzXSIldIXQebSRqIcgiVRLh6crdRhT4yvOmsMKXAm
         W9zPJEoypdsV5PgX1nAKNjGV5L5vtczxe7CQJvpPSkPVB996unpNooSzKOFgeCh+w9Kk
         JgrKAYGbMUAq0Jt99k+oEH2bFDjnCF3oFLDxyqODtjnAlPY+82rOv5Uv6q5oKL1tjREA
         cl+VpSQhiS2EF3vBY0AG8dg45LjPqFYJ1RIAaKP15CCl6RF/qCEQ47Ns9YA+OvMlrUgj
         lPcK7uSr8v1yqsfE4uh/cLmvCF79g/YJEL2A/u1UeU0rIsTVge19Iq8ayYiYJDnosoIJ
         69gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745755013; x=1746359813;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3aguYnD7Euw8idfB6uGeUk5hHv75Psmkn+8V49As6tk=;
        b=T/YWf/V309QPTfcABahM4aMwzL7IZwS+QSpXUmyLiHUvHkb+exQYGHuhiuCd60aTRm
         NE2LHd9Dhs7zBvVoTWZ2OF6VG5rVKDkuj6qrJQaneWXGlkmaaFK9d3m2zXAtWcB83cD6
         bzbou/bZc9onaAkOj9rB20dY0OzyHgeDh759XrvEV/xg0YuHtvf9NFFSBAxFAVzGACtc
         0JjNP5HJp8+IkNw5J7cHu4C/SLmU5Hgg8gUQxttA0uSe1hND4/S4n/D0tN6aAr7oFSJq
         LUIXknzk6dRNXRIZ/hOWbWTP3Ko3TLnI0Ih92Z1vDjI3stHpuwRJXhX84F7lN/XytsKg
         NBZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHFvyJn9kxMoQpt77VBn3RQe9NaAXcDh7yVDfIntEfpWiFN7tsTnzevwhMT3S0mQXHI1pLNekV@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0ITRzF/yzC9cPpk73nb9RInk5aymE2zzggaRh3iF49rTqyi2b
	zAJlM1RhlMrtvmVhJhELXPfJjZQAjzrcpP8kmE15KJ5Mt5e49WIKne2vDvhiq/Q=
X-Gm-Gg: ASbGncsOjkB4LldGPTBJpT3IV9MAje+7SQ+6iT6kKSMxaDPo8aumrxSA5TW463DDFsZ
	CA8hOSFwxf3eg0T8t+knF4OFMImeo/bMMnv6zVkgtmvWxFKPiH+5Q+4Py97qB+Rr06uIioEZh9g
	vfU17ULU5rrabtVnZsseIZpJATLHKML5smS5QPNLv4fL2Yrzx6hGJkLMXbblS7viP5Of/Cm6fg8
	f4sQKdB7OispCeqy8qCZ6qXq4Fc02PELSf+sSqkOzBZmysvUcA2OE9m1osFDTwxMP4fg6zltyw5
	zZ+YtwbaTvyJ3wbAGQQoGxoj1jkSA6GdW/1w18o=
X-Google-Smtp-Source: AGHT+IEDgU2yzVXpkA7DFn1W4/QXxXBxTe6pwCbgIO5g9SsnH+5MeNqwj18r14AAziVsNIFTvvqe0w==
X-Received: by 2002:ad4:5c66:0:b0:6e4:2872:45f5 with SMTP id 6a1803df08f44-6f4d1f16818mr102027586d6.25.1745755012925;
        Sun, 27 Apr 2025 04:56:52 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:365a:60ff:fe62:ff29])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f4c0a7429asm43859846d6.69.2025.04.27.04.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Apr 2025 04:56:52 -0700 (PDT)
Date: Sun, 27 Apr 2025 07:56:47 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Huan Yang <link@vivo.com>
Cc: Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>, Vlastimil Babka <vbabka@suse.cz>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Francesco Valla <francesco@valla.it>,
	Raul E Rangel <rrangel@chromium.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Huang Shijie <shijie@os.amperecomputing.com>,
	Guo Weikang <guoweikang.kernel@gmail.com>,
	"Uladzislau Rezki (Sony)" <urezki@gmail.com>,
	KP Singh <kpsingh@kernel.org>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com
Subject: Re: [PATCH v3 2/3] mm/memcg: use kmem_cache when alloc memcg
Message-ID: <20250427115647.GB116315@cmpxchg.org>
References: <20250425031935.76411-1-link@vivo.com>
 <20250425031935.76411-3-link@vivo.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425031935.76411-3-link@vivo.com>

On Fri, Apr 25, 2025 at 11:19:24AM +0800, Huan Yang wrote:
> When tracing mem_cgroup_alloc() with kmalloc ftrace, we observe:
> 
> kmalloc: call_site=mem_cgroup_css_alloc+0xd8/0x5b4 ptr=000000003e4c3799
>     bytes_req=2312 bytes_alloc=4096 gfp_flags=GFP_KERNEL|__GFP_ZERO node=-1
>     accounted=false
> 
> The output indicates that while allocating mem_cgroup struct (2312 bytes),
> the slab allocator actually provides 4096-byte chunks. This occurs because:
> 
> 1. The slab allocator predefines bucket sizes from 64B to 8096B
> 2. The mem_cgroup allocation size (2312B) falls between the 2KB and 4KB
>    slabs
> 3. The allocator rounds up to the nearest larger slab (4KB), resulting in
>    ~1KB wasted memory per allocation
> 
> This patch introduces a dedicated kmem_cache for mem_cgroup structs,
> achieving precise memory allocation. Post-patch ftrace verification shows:
> 
> kmem_cache_alloc: call_site=mem_cgroup_css_alloc+0xbc/0x5d4
>     ptr=00000000695c1806 bytes_req=2312 bytes_alloc=2368
>     gfp_flags=GFP_KERNEL|__GFP_ZERO node=-1 accounted=false
> 
> Each memcg alloc offer 2368bytes(include hw cacheline align), compare to
> 4096, avoid waste.
> 
> Signed-off-by: Huan Yang <link@vivo.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

