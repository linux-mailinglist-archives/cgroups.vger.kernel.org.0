Return-Path: <cgroups+bounces-16391-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4DOuEJJNGGomiwgAu9opvQ
	(envelope-from <cgroups+bounces-16391-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 28 May 2026 16:13:38 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9BE5F37C6
	for <lists+cgroups@lfdr.de>; Thu, 28 May 2026 16:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A585C30B5A5D
	for <lists+cgroups@lfdr.de>; Thu, 28 May 2026 14:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E202D97A6;
	Thu, 28 May 2026 14:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="AYJV2VuL"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3431129A9E9
	for <cgroups@vger.kernel.org>; Thu, 28 May 2026 14:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779976996; cv=none; b=IwZKwt6z7h52lhq48MIBlUyNymqWOpxZmSSg0c0IHG+oZMTiZOIWoykyB3yw9X1tXjjQ35Rwln7Af6aOClNT+mldauRt8mnEBxDhVznAVH/cCOc8IvE7aM/8E/q8GWd4nKnD5zrjgA7kPSaytyrWIM6P/Y+PVkBkhxfudAeaHYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779976996; c=relaxed/simple;
	bh=UhfW80sle2YKirikOWRjeTGOLnc1ebIamFxQXTh+pa4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ea4MpEFk9Pe1cud0VnxMC48oy9t3y6T1j/WxPm6KOZksSGWtHhWeInLCGvNq+qwNvZCYb9m6JL83yeb4uVehpDYMEDRmYrlixqmJor1XrSgLr6ORRD+kESbDGWZjDz7kB7DRRjGc1r7JKGOWnHOwAnWquejMW1XBSjrxLQBsM84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=AYJV2VuL; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-479fc1fc048so9254656b6e.1
        for <cgroups@vger.kernel.org>; Thu, 28 May 2026 07:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1779976994; x=1780581794; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rO+A7GjX2+2QgmOEjNdtI+NV3B5SN9zhDQg6nEMiyz4=;
        b=AYJV2VuLBt2oRyq60ozTe6w83zbY6Kfu90WUbXYBMYXJXMJ500FmKgufkgJi8lj4FR
         75liT9ysvV4TMjQ8m+ljyc7/ijIwnM04GprGLyVuXog4AadwXvNt1gljifkFN69sYFQi
         OLIUgpiZTmEB+0Qj6BZhdIN4j8pZ8KcNwLE8zN6juVmXSds8oC/OUqhtfjqTlyF8FDNx
         NAeopIOTdOMAOEYl0pFkXsQ3mVaVQG85Pc48L7A2Ww4tTD89kuz1B73OFuoOb56M+r76
         yeBIpPtLpfBs/8MSc6g+BP7IlDFrK1FqbpuMCWD/YMNfQVxn89NCmxG+8cMflXLqBmbT
         Lv+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779976994; x=1780581794;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rO+A7GjX2+2QgmOEjNdtI+NV3B5SN9zhDQg6nEMiyz4=;
        b=tWl+td86DJJALf3h1c/yif06tAxNg5h89Ak16IqtDaviBk2Uq5XhDYmMi4554rUOLX
         6C1R1D0B+IbhRFmYLOVqIFseL7BuXdmm5f/nqVBtVsQuBIc2fRyxOBeTrUFOUxc9rfAK
         ldz7RiY9irybmhoLpN2gmOXxaUHSnwKhr5Dx7KfP4UTLXy/T5a5QmHbcf+atm9aHsi0x
         qPIB/N/NeQa9CaZqpj3LmIpU8GAso68GnQJLTZ/kn2mnnd50qg6eBSGFgBJmmSlciHty
         zqjpXyBCiBYh+4e5AvqAcZpLcd5nejWWcI3pnYdgeVoH3L9sRmsd9QmLlBWO79Bnqola
         2MuA==
X-Forwarded-Encrypted: i=1; AFNElJ+FwH3WJcZU1YxBLSeNr+wY2kaqU3lgq6cGD+qOBABp7bAU2sTcP/AvPV0RNJ9BtpTCuDndqpQX@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz/FRcAoIPUpN85VPC5u5ZXkv+enjOq3i69r4ifRAd+8TpQUk8
	EwueJFuO7xtEhdCtllLKFHOLSBkbr0IyUlv+z8Q/ZLpollXw+5yVYxmjqRTAmgc5EZE=
X-Gm-Gg: Acq92OGWet40ar6xhNYleuIJiy6B8GQODtx59j62lsXgORJvZFFQMm+L33BwE6JyIOj
	X1IrNNttkcUlQ+5TjzfpDUiwm8cqsjJzhl72OOYbWR+amCEg7o9H/ReCCNuydtJe5PGvjZ7sNw6
	xvfhAnQ+AxNWLqNl1Gtaa93MnohRqqotSM0z2GA5ITUXfj1b2SO2o8g+0dgBkBFjO1wEOT6kVAt
	NXfX2Qjwv72i9M1cjPiQ3TdBeWnsxdruRKOOjivjaSQiKiYbjC4k2ug+JNn0zxM+ty2PAJQSB/8
	ic/cuEB52PML6Ey4wOhjE4Lxn+xG6wcDul9aG4aj/BqCMdkWd4jw629H7QEU23i8w35Ujwi2raO
	uUdTWUcnG8Qiq1CZO9LIoiUsOfvzTtJOoCx8NA6wO2ACBLPsN6v3DJiqei4fbbgrHtlDA24p6Ow
	lHzXVbrgKPBofoVVeFUlJY55AR8bg/xJBrdn9oeYOL7z8=
X-Received: by 2002:a05:6808:191a:b0:485:48da:132e with SMTP id 5614622812f47-4854a224419mr15508945b6e.27.1779976993865;
        Thu, 28 May 2026 07:03:13 -0700 (PDT)
Received: from localhost ([2603:7001:f100:500:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51706af4fd2sm73661071cf.25.2026.05.28.07.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 07:03:12 -0700 (PDT)
Date: Thu, 28 May 2026 10:03:12 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Michal Hocko <mhocko@kernel.org>,
	Dave Chinner <david@fromorbit.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, Qi Zheng <qi.zheng@linux.dev>,
	Yosry Ahmed <yosry.ahmed@linux.dev>, Zi Yan <ziy@nvidia.com>,
	"Liam R . Howlett" <liam@infradead.org>,
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>, Kairui Song <ryncsn@gmail.com>,
	Mikhail Zaslonko <zaslonko@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Barry Song <baohua@kernel.org>, Dev Jain <dev.jain@arm.com>,
	Lance Yang <lance.yang@linux.dev>, Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 9/9] mm: switch deferred split shrinker to list_lru
Message-ID: <ahhLIBSC7rxgXSEU@cmpxchg.org>
References: <20260527204757.2544958-10-hannes@cmpxchg.org>
 <20260528070807.144064-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260528070807.144064-1-sj@kernel.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cmpxchg.org,none];
	R_DKIM_ALLOW(-0.20)[cmpxchg.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,linux.dev,fromorbit.com,nvidia.com,infradead.org,gmail.com,linux.ibm.com,linux.alibaba.com,arm.com,redhat.com,vger.kernel.org,kvack.org];
	TAGGED_FROM(0.00)[bounces-16391-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[cmpxchg.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hannes@cmpxchg.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,cmpxchg.org:email,cmpxchg.org:mid,cmpxchg.org:dkim]
X-Rspamd-Queue-Id: AC9BE5F37C6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 28, 2026 at 12:08:05AM -0700, SeongJae Park wrote:
> From 23b5800dd49085707baee5774b74782c3e424f24 Mon Sep 17 00:00:00 2001
> From: SeongJae Park <sj@kernel.org>
> Date: Wed, 27 May 2026 23:58:07 -0700
> Subject: [PATCH] mm/huge_mm: define memcg_alloc_deferred() for
>  !CONFIG_TRANSPARENT_HUGEPPAGE
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> Without this, UM mode kunit fails like below.
> 
>     $ ./tools/testing/kunit/kunit.py run --kunitconfig mm/damon/tests/
>     [00:00:02] Configuring KUnit Kernel ...
>     [00:00:02] Building KUnit Kernel ...
>     Populating config with:
>     $ make ARCH=um O=.kunit olddefconfig
>     Building with:
>     $ make all compile_commands.json scripts_gdb ARCH=um O=.kunit --jobs=8
>     ERROR:root:../mm/swap_state.c: In function ‘__swap_cache_alloc’:
>     ../mm/swap_state.c:468:26: error: implicit declaration of function ‘folio_memcg_alloc_deferred’ [-Wimplicit-function-declaration]
>       468 |         if (order > 1 && folio_memcg_alloc_deferred(folio)) {
>           |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~
>     make[4]: *** [../scripts/Makefile.build:289: mm/swap_state.o] Error 1
>     make[4]: *** Waiting for unfinished jobs....
>     make[3]: *** [../scripts/Makefile.build:548: mm] Error 2
>     make[3]: *** Waiting for unfinished jobs....
>     make[2]: *** [/home/lkhack/linux/Makefile:2143: .] Error 2
>     make[1]: *** [/home/lkhack/linux/Makefile:248: __sub-make] Error 2
>     make: *** [Makefile:248: __sub-make] Error 2
> 
> Fix by implementing the function for CONFIG_TRANSPARENT_HUGEPPAGE unset
> case.
> 
> Fixes: https://lore.kernel.org/20260527204757.2544958-10-hannes@cmpxchg.org
> Signed-off-by: SeongJae Park <sj@kernel.org>

Whoops, thanks for the fix, SJ. I'll incorporate UM builds into my
final compile test before sending.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

