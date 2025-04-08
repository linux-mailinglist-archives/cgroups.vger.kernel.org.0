Return-Path: <cgroups+bounces-7430-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64CEEA810C0
	for <lists+cgroups@lfdr.de>; Tue,  8 Apr 2025 17:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F4653BB44F
	for <lists+cgroups@lfdr.de>; Tue,  8 Apr 2025 15:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B956822E011;
	Tue,  8 Apr 2025 15:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="mdOBOdHW"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8132922ACF1
	for <cgroups@vger.kernel.org>; Tue,  8 Apr 2025 15:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744127155; cv=none; b=pPyJeJNk2aQnfBlwQPQILQptJWkh7oJWvPU3Jn0lzwLDifVLFpbQwO28WlSbtLoUzReGU5Ef2Hbd86eLSKeKnedpHX5AAyal79L7cfgvMXXqKvNorYgwRpBk1l4HQceqpMYK30NncSoOa9lN2/ljvBbOg3I+n7u2PUAn0F96nuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744127155; c=relaxed/simple;
	bh=0Vk4Q/tbcxmqoPdlz6UIUsDuIxw5cq/UVJKCtm5vkU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FshRrz8B0nx+21hdj7yzbBAYB+s0Yu7g+Dl9ktCys/5ekLQTiseK1VkymFmRBC+y9wicmcZULRaT0T8oLs4HS9CZBBU+10Dd0tiKy3Iae8O4i+WNJHmpbWbUCjzYbYtN2ea7f1aNyoiMVN/xRgR59GIfdFknJ3Zr4Fx0/iLp4ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=mdOBOdHW; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6ed16ce246bso28115176d6.3
        for <cgroups@vger.kernel.org>; Tue, 08 Apr 2025 08:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1744127152; x=1744731952; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z4ws45xegNtEo3hyX9VLFGRAMSTn7tItQyk+TYKn5LE=;
        b=mdOBOdHWh/fvGknv0gXu1ly70YBcK/mlc6XLthNm42wAwihn0QSyGIrZdMyIhEwsLh
         eU17LAnpgdsRIv9EXQDRcveignOVir9nOnkym0VA36Ss96poFdxYd86RyMQj7Yy66kgn
         2wAGdrb2POQMbO3dAKlqGaf9vzCW0TkpRvtxgIBjkuubY4c5ANKbz4wL8TMuQ18sjEDT
         BiiLma7vLVSjuBK5JODSdopgmEHTap9QdOpNnlFyhURNmc4ZFZ3JZ0Q3qUV2C4OvkGL3
         rODWUQx1Mn3xlKBAFW+vYt4XL+x3KkWlqSnX8fJsduQJqTobQAy0NLKDj/feuyRHC5ZX
         JwdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744127152; x=1744731952;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z4ws45xegNtEo3hyX9VLFGRAMSTn7tItQyk+TYKn5LE=;
        b=F3Qzo2sFdjYq3kZbNrt1dMcRzBAAdn1mk1vBaQC3WRominZyB8q6Ho5G8ABk9UjH8v
         PFO6jDLgD+H83F8ELTnrYUfNVSm6NxKxx65FwLAKIQgxBaMgBEgJI8m8VrpL3zYMj7C3
         rjw+c261za4Xr6nykiBa2b0US3TzTwxOjuXjYWqqAcKxv1iLdDtIRMUxaS5lMX0+g4qs
         eeTpUni8gAKJH7dFWw8+6FcAXPEHoZeqXi0NUla5vcfTjCpgWfC8nSd/Ocsj1kt3EbTf
         T+bQvfKUMvYXzUuYQnKySZQ/XFgcECCoSE1px82uvHkOapsEVLuCdakUcRD+VePFrxEG
         C9+A==
X-Forwarded-Encrypted: i=1; AJvYcCVuApXmzCpg1n0v2c+dbKaCwraSSIB3iySrF84EykjXUbFwh+2K+n7aIZue6L07DsAwc9xja2Xu@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf+IoCuxfKeh//m22gvPodVv768yjFIY8/FXaYCeotfk2C3I7+
	KvgfGNip5U0RbthxpZqTuvkOqjQyKJnIfuohJ/dfGbnTG7lERHAXA1QM0zstp50=
X-Gm-Gg: ASbGncsYS3jPoi7kHhP9LRaYOpK0N7mYDR4JC19IPQ+ECYV2NtpvSAZbCikWBngLbqq
	1PcdpKQGXeJrJPK1IkXFZGCvLhg36eRjbimcK39o1v9pFKwj7Pdp0kyjBVoqAdppcT9Dm6bSCP/
	zAQYDWXgVhbc/GLsxA/OKwHmr2Q0Rxm8C6hIMTW3HeXDI8DKd12WK3AOuPs1P0ajy3/YFiE2H+B
	fp7wOSc7zdqHsdsZT+JiynLNfJktpaKvb+8X63J2hskO90fRlt3s/qQBK2RDGgANRRXobNOvP/g
	VdaDEEFHZEyRXuK38jjjoGGxE45k98BXwpiwQAU+6TI=
X-Google-Smtp-Source: AGHT+IFB93sjhMlD8Tc/Abwf4lsvbVA+UK3BQyylz33ogjZ0LPpUmiNISCzwhQcTDhyWWyzZaM2+Eg==
X-Received: by 2002:a05:6214:2588:b0:6e6:5d61:4f01 with SMTP id 6a1803df08f44-6f0584a4650mr233144056d6.8.1744127152257;
        Tue, 08 Apr 2025 08:45:52 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:365a:60ff:fe62:ff29])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6ef0efc0a6csm75867956d6.14.2025.04.08.08.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 08:45:51 -0700 (PDT)
Date: Tue, 8 Apr 2025 11:45:47 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Usama Arif <usamaarif642@gmail.com>
Cc: Nhat Pham <nphamcs@gmail.com>, linux-mm@kvack.org,
	akpm@linux-foundation.org, hughd@google.com, yosry.ahmed@linux.dev,
	mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, len.brown@intel.com,
	chengming.zhou@linux.dev, kasong@tencent.com, chrisl@kernel.org,
	huang.ying.caritas@gmail.com, ryan.roberts@arm.com,
	viro@zeniv.linux.org.uk, baohua@kernel.org, osalvador@suse.de,
	lorenzo.stoakes@oracle.com, christophe.leroy@csgroup.eu,
	pavel@kernel.org, kernel-team@meta.com,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [RFC PATCH 00/14] Virtual Swap Space
Message-ID: <20250408154547.GC816@cmpxchg.org>
References: <20250407234223.1059191-1-nphamcs@gmail.com>
 <983965b6-2262-4f72-a672-39085dcdaa3c@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <983965b6-2262-4f72-a672-39085dcdaa3c@gmail.com>

On Tue, Apr 08, 2025 at 02:04:06PM +0100, Usama Arif wrote:
> 
> 
> On 08/04/2025 00:42, Nhat Pham wrote:
> > 
> > V. Benchmarking
> > 
> > As a proof of concept, I run the prototype through some simple
> > benchmarks:
> > 
> > 1. usemem: 16 threads, 2G each, memory.max = 16G
> > 
> > I benchmarked the following usemem commands:
> > 
> > time usemem --init-time -w -O -s 10 -n 16 2g
> > 
> > Baseline:
> > real: 33.96s
> > user: 25.31s
> > sys: 341.09s
> > average throughput: 111295.45 KB/s
> > average free time: 2079258.68 usecs
> > 
> > New Design:
> > real: 35.87s
> > user: 25.15s
> > sys: 373.01s
> > average throughput: 106965.46 KB/s
> > average free time: 3192465.62 usecs
> > 
> > To root cause this regression, I ran perf on the usemem program, as
> > well as on the following stress-ng program:
> > 
> > perf record -ag -e cycles -G perf_cg -- ./stress-ng/stress-ng  --pageswap $(nproc) --pageswap-ops 100000
> > 
> > and observed the (predicted) increase in lock contention on swap cache
> > accesses. This regression is alleviated if I put together the
> > following hack: limit the virtual swap space to a sufficient size for
> > the benchmark, range partition the swap-related data structures (swap
> > cache, zswap tree, etc.) based on the limit, and distribute the
> > allocation of virtual swap slotss among these partitions (on a per-CPU
> > basis):
> > 
> > real: 34.94s
> > user: 25.28s
> > sys: 360.25s
> > average throughput: 108181.15 KB/s
> > average free time: 2680890.24 usecs
> > 
> > As mentioned above, I will implement proper dynamic swap range
> > partitioning in a follow up work.
> > 
> > 2. Kernel building: zswap enabled, 52 workers (one per processor),
> > memory.max = 3G.
> > 
> > Baseline:
> > real: 183.55s
> > user: 5119.01s
> > sys: 655.16s
> > 
> > New Design:
> > real: mean: 184.5s
> > user: mean: 5117.4s
> > sys: mean: 695.23s
> > 
> > New Design (Static Partition)
> > real: 183.95s
> > user: 5119.29s
> > sys: 664.24s
> > 
> 
> Hi Nhat,
> 
> Thanks for the patches! I have glanced over a couple of them, but this was the main question that came to my mind.
> 
> Just wanted to check if you had a look at the memory regression during these benchmarks?
> 
> Also what is sizeof(swp_desc)? Maybe we can calculate the memory overhead as sizeof(swp_desc) * swap size/PAGE_SIZE?
> 
> For a 64G swap that is filled with private anon pages, the overhead in MB might be (sizeof(swp_desc) in bytes * 16M) - 16M (zerobitmap) - 16M*8 (swap map)?
> 
> This looks like a sizeable memory regression?

One thing to keep in mind is that the swap descriptor is currently
blatantly explicit, and many conversions and optimizations have not
been done yet. There are some tradeoffs made here regarding code
reviewability, but I agree it makes it hard to see what this would
look like fully realized.

I think what's really missing is an analysis of what the goal is and
what the overhead will be then.

The swapin path currently consults the swapcache, then the zeromap,
then zswap, and finally the backend. The external swap_cgroup array is
consulted to determine who to charge for the new page.

With vswap, the descriptor is looked up and resolves to a type,
location, cgroup ownership, a refcount. This means it replaces the
swapcache, the zeromap, the cgroup map, and largely the swap_map.

Nhat was not quite sure yet if the swap_map can be a single bit per
entry or two bits to represent bad slots. In any case, it's a large
reduction in static swap space overhead, and eliminates the tricky
swap count continuation code.

