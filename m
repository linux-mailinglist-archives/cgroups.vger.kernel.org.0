Return-Path: <cgroups+bounces-7846-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F1EA9E2E8
	for <lists+cgroups@lfdr.de>; Sun, 27 Apr 2025 14:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 109273AC950
	for <lists+cgroups@lfdr.de>; Sun, 27 Apr 2025 12:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456B52036FF;
	Sun, 27 Apr 2025 12:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="B5yA2iL/"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BC9256D
	for <cgroups@vger.kernel.org>; Sun, 27 Apr 2025 12:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745755241; cv=none; b=M1gzn3ISgRiWmIqF7smXBmCm+Z8XnogXM/9Obx15I5ccJrtIrYnTShIcFlEpKa9RSw6OeJg2YZJ2BYBt7IflBZ4MB8GAsVjHIWLwaHJAOAdvAAHtt0kBcFMUOwux1eDMd+uBA+sK0t4UBMqhHuPSt+z21Hw6FjRL6BaTtUaWSQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745755241; c=relaxed/simple;
	bh=vjKNVaBnwosmkT5BpsGBh7zV8V9cGcBGgi5D7xz0xtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gGXwMGFZORlqGG6eI6GpTLUGOA7F5ImnjFrjOot0yIC6dN48dfxv/buCxZXOapSFsZS1DYjPgIqqGdzMsDjsftwRFMG/M00bzuW2qDCB33KqrDvblJ0Jn+/MpOFCwjz+S6LEmqKUnLI+ToqAPTIGxw9bYkritdVyG0yF32ZFka4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=B5yA2iL/; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6f2c45ecaffso42406496d6.2
        for <cgroups@vger.kernel.org>; Sun, 27 Apr 2025 05:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1745755238; x=1746360038; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=idxqq/A2oTSdkkSRkt+wEJC8bkXWvT6a+WYUMvQqbyM=;
        b=B5yA2iL/yssB7EC5snX6mNqszBqocLDMfLVcHBmWbyuK44opjtVWFIlsQhhxVTHoTE
         Haf0Ir6Miiqg3Mwp5KhnRwZqzaV0AieQeFVBu0ANrurOLaBFX/QYxr9h6+cXjZJf7cSI
         Ecwou2i5zckyKaoPFZQzX2uyLioU8/eXW2aR+m13OufbqYvjCGllgmgcN2OWOj1VHZe0
         8N0OuM4Y1vMCZBWNa6LrUPuXsVCrSXQTQ1iHD+BlHK04/UobCfAqNyStpkH4/MLLb55s
         qt79vSf5FTV0GuUY9t+xNUU986/IMr9er8oMnjPlsK0otUKyQU+aiuqe/AptK7CtgqDD
         yZMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745755238; x=1746360038;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=idxqq/A2oTSdkkSRkt+wEJC8bkXWvT6a+WYUMvQqbyM=;
        b=SX3qU2Bfppe/AmRYd+6qZNWHiHyCnpSOMpsxCZhjSe6fvNpGLS/r3yyFQctj/kINCh
         dIwZ4Hfn09dwH625xcQBf75GOxd9g8PWPRxTcqoV1Vt2471Wo/NJ2FOc9wsZRosq/6px
         1o9SEqszgIp6tjIDtBwOoaDzBTwNInJXW+g6nxyux8prqvQqpo9Qw6LRKFAzCWcVB321
         O8Wv8VOie5bJaSOjx4ShAxxwCBPSHOMuZkHi0uzXXHr1Fk7TyziNQe2WhfyuHMj/y2em
         Y6GRQEKdUCDgAHGvh2lKED4Fpqf9lVkAnO0dqKiThRrIya9uPDqb/aK6+OEVifx3zirB
         VIog==
X-Forwarded-Encrypted: i=1; AJvYcCUZQxXu+VQbYL9DTdyDw5EzaTNgP0Ak2WLhFK/dA2t8mVVB5mC5mdmeTB9LH90GdgdNlevN09Bg@vger.kernel.org
X-Gm-Message-State: AOJu0YytUDPg7LgBxK4ZtKyJVO88mK/2KmvJ1TevqX79E+O31ZPuaIRb
	D5AgivnQXLrwX1c/VNZOcEazLdm3NXNgg+IwU3qmcirAB/GH72yySNTtpFnBe7w=
X-Gm-Gg: ASbGncsTwulnw/gg4H8VABK9ERdmXFlvTL5bu1/CjnuOSqTjxt5vSV2QlJH4rra2TUs
	WLdquHvNVpC3PFZD8vq9o24Co62PF+LYsKOxWlqrGL8FGlNCJ8E9euWI1GMzJsa9Ev0e7Wy4YlH
	66EVodJE4vxtvyqLz32hEidYoo55qKDrUQesMLEmTvTJlOQ4XhadEx4Rlak6FjH9SYqyooNVSi8
	8o1SNA1wiSdbXX+QL7sGN6iD1C8QldVZkpnPUCzac2X214RKbZEhuycNzzxnblPu7pjLP/i1sup
	lnXNPL5RzmK46PowX4CGGjQuJ4LYm3asYMgVOWzV3Y1JSot17g==
X-Google-Smtp-Source: AGHT+IGtJaXq4IPT7rxUZP3lATTpBxPpUwKLTeijuMDfj5iSTz0S/zVyxdqV+dyZRXdtWU1698wUTg==
X-Received: by 2002:ad4:5d47:0:b0:6e6:683c:1e32 with SMTP id 6a1803df08f44-6f4cb9b8e9emr179935356d6.8.1745755238323;
        Sun, 27 Apr 2025 05:00:38 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:365a:60ff:fe62:ff29])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f4c09341c8sm44086486d6.31.2025.04.27.05.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Apr 2025 05:00:37 -0700 (PDT)
Date: Sun, 27 Apr 2025 08:00:36 -0400
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
	Hyeonggon Yoo <hyeonggon.yoo@sk.com>,
	Paul Moore <paul@paul-moore.com>, opensource.kernel@vivo.com
Subject: Re: [PATCH v3 3/3] mm/memcg: use kmem_cache when alloc memcg pernode
 info
Message-ID: <20250427120036.GC116315@cmpxchg.org>
References: <20250425031935.76411-1-link@vivo.com>
 <20250425031935.76411-4-link@vivo.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425031935.76411-4-link@vivo.com>

On Fri, Apr 25, 2025 at 11:19:25AM +0800, Huan Yang wrote:
> When tracing mem_cgroup_per_node allocations with kmalloc ftrace:
> 
> kmalloc: call_site=mem_cgroup_css_alloc+0x1d8/0x5b4 ptr=00000000d798700c
>     bytes_req=2896 bytes_alloc=4096 gfp_flags=GFP_KERNEL|__GFP_ZERO node=0
>     accounted=false
> 
> This reveals the slab allocator provides 4096B chunks for 2896B
> mem_cgroup_per_node due to:
> 
> 1. The slab allocator predefines bucket sizes from 64B to 8096B
> 2. The mem_cgroup allocation size (2312B) falls between the 2KB and 4KB
>    slabs
> 3. The allocator rounds up to the nearest larger slab (4KB), resulting in
>    ~1KB wasted memory per memcg alloc - per node.
> 
> This patch introduces a dedicated kmem_cache for mem_cgroup structs,
> achieving precise memory allocation. Post-patch ftrace verification shows:
> 
> kmem_cache_alloc: call_site=mem_cgroup_css_alloc+0x1b8/0x5d4
>     ptr=000000002989e63a bytes_req=2896 bytes_alloc=2944
>     gfp_flags=GFP_KERNEL|__GFP_ZERO node=0 accounted=false
> 
> Each mem_cgroup_per_node alloc 2944bytes(include hw cacheline align),
> compare to 4096, it avoid waste.
> 
> Signed-off-by: Huan Yang <link@vivo.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

