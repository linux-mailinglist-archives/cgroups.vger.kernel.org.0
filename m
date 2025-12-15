Return-Path: <cgroups+bounces-12357-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D788CBDDD7
	for <lists+cgroups@lfdr.de>; Mon, 15 Dec 2025 13:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 748E6303D6A9
	for <lists+cgroups@lfdr.de>; Mon, 15 Dec 2025 12:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B9D2E8B9F;
	Mon, 15 Dec 2025 12:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="kOveW9b4"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BBB2E7F14
	for <cgroups@vger.kernel.org>; Mon, 15 Dec 2025 12:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765802418; cv=none; b=drLzn4dxWNk7xaIzU+iJq4LZAkE/9/JmVtEgnPZoMJxuVNVgyB8wWBPdfFliZRHpIIjWHx8EJ50JgxJLGwkL/8ldjUtVbz2GV9PtmMJJJN//n2/c/DT2i5RDvNKFOhYvG6oiiNQVeQhsRFJteUzb1AxuFp17Xkxai1kvU/COm8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765802418; c=relaxed/simple;
	bh=+PuE2tLBW1rXXQlqEJWcvvhfVKok2O1mj7zgRKhY0aM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MN0DYPyWANE4ytzrYYuHfSjYno0n24TBT/qH/n6gOUx2TLBmMksWg/eshz8i0VvTFbAT+KxUp4IQ6qJQ8r6NtUAFv8CHTHNvyeXV0gFjtd3yHUYP92ig9CzSLhwSjhQsJKDBIgrPLcOqyDHxSRn3Rw17EEV+2HlsVKqyWt1EyiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=kOveW9b4; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-29f2676bb21so34258725ad.0
        for <cgroups@vger.kernel.org>; Mon, 15 Dec 2025 04:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1765802416; x=1766407216; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XQ+e85/bUCohfI0SHpL3374mINgtvuKmw5p+42PCaQ0=;
        b=kOveW9b4AXg6kOAhCeUg6CqtwBZDeWCxfd1ra6DiRxiZ3SoTdccPJXq498u45xO3G9
         Wfn/mnRTQd/WuZqCOnNr0K/P3pFa99AoKuNAGyosCFYBvhhLZ+8WugWc6krKHQDRohMa
         go5jfElG2763BSNBUCIAE/etyWGPWZBk9icPuFqDE/AYW6r39SNi3E59gTDbpmcclysl
         R+E8oFV54Ou91W9JTqXg1oUsVRCE+NMMp0kmP1B6ozLMbopPAszenvZ0+nhpD3iERtpC
         ZUgkQBi12GBirC0XgHiAE/Ae8+mihWzELiZyucHnhWi5cjqdUz2HS1th5pWN9uEogorB
         R4PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765802416; x=1766407216;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XQ+e85/bUCohfI0SHpL3374mINgtvuKmw5p+42PCaQ0=;
        b=na5Co13LHwCgwD36xkctGDUW8iG8EQBcuwvlQFma7L+3FuxR60O18CxTNVUO90ChWo
         UBFVViRLNisD/64yEtt8N+XHsti5evmtgceuKN777FkDmU26a3msFnhfHkRyuRpzRI0o
         KLuvHHjhbY+wYJ14OnLjK3+yzbaadNg6JT7JaUciqsT+4bC2i554QOZkm5Bxocwllmlf
         iHfgxTSSO6lVRxpmfS5JTy8pkCpp1r7zx5PHacM9ICkcx8HJRV59n0Nd41NucmfBvMef
         zZCki1/yLpYVuHRD+j2aIZPj5LUfjPBMWVOwg55AtlUkRtvmJjREs6/2I1QpCdENahzj
         f0QA==
X-Forwarded-Encrypted: i=1; AJvYcCXJNH/4q/5vqtRmA9z79fe5BNn0V9zHz3H/3lWsfip+uKOMgeeNtQDolejs4qLwNucCZ1ZbkNBb@vger.kernel.org
X-Gm-Message-State: AOJu0YwGvnkTibjE/b0ZHBqp3NMx/2clXPC6D8mcK4eGkLJifHbiu3fD
	6vEer5qTkly7CiFhS63G4pBHSXtyiT71WhBNPU74aNzS/Ykbln0dmotK6JQ+VYEchmQ=
X-Gm-Gg: AY/fxX43xnNJBdw3q1Fpu4l1UA0rin/MeUS5BFG0AVbUTc/FRrDXacvO7zGhnRT4wSE
	rpWytLNKszSf6eocGQpDZ8X0phrIrDvAEP9khC88EPha+yn1QFGp0PCkcRR4MRU9qEhnWpOkbxt
	f8xDauatRZ6hPrGWUS/DE1ejO7fYBVPGjmXBDpIg4tKP5xQD/3W6kREydv1qQy3mzxLjppflGyn
	1h26pCfRZ2ykeBrSH2lr2yF7E1Ek4WqhKb+DVW3eyM129x1dIAIENoSyD2qlrrBlVwLi4zC51qL
	rmwTugb2hG5w7jPQVJtuCzITkHFfbBuEVL4AQwzCUSqsLeAPN1PXXiBGhuAuiWSryXHkJNYdn1c
	fbt7e2ewYqhpuIiMvqwkIbEni2kJqULRrdRNP2LWXKNqTNyx8glpg8PMmjgDteUxyYsHmbWaISl
	DsuvGpecpZcLiAUc9PXDV0cgW3Sk3bHw==
X-Google-Smtp-Source: AGHT+IGs9Ux4WT36PFE81Ye+THAzlPoeoI649XuOQnWr/+KqI/OdcXZ3NL6DeXTGnqp6jXKC8WolKA==
X-Received: by 2002:a05:701a:c965:b0:11a:2f10:fa46 with SMTP id a92af1059eb24-11f3484e8cemr6230501c88.0.1765802416021;
        Mon, 15 Dec 2025 04:40:16 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F ([205.220.129.38])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11f446460c8sm8475705c88.10.2025.12.15.04.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 04:40:15 -0800 (PST)
Date: Mon, 15 Dec 2025 05:38:47 -0700
From: Gregory Price <gourry@gourry.net>
To: Balbir Singh <balbirs@nvidia.com>
Cc: linux-mm@kvack.org, kernel-team@meta.com, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org,
	dave@stgolabs.net, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, longman@redhat.com,
	akpm@linux-foundation.org, david@redhat.com,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com,
	osalvador@suse.de, ziy@nvidia.com, matthew.brost@intel.com,
	joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com,
	ying.huang@linux.alibaba.com, apopple@nvidia.com, mingo@redhat.com,
	peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, tj@kernel.org, hannes@cmpxchg.org,
	mkoutny@suse.com, kees@kernel.org, muchun.song@linux.dev,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	rientjes@google.com, jackmanb@google.com, cl@gentwo.org,
	harry.yoo@oracle.com, axelrasmussen@google.com, yuanchu@google.com,
	weixugc@google.com, zhengqi.arch@bytedance.com,
	yosry.ahmed@linux.dev, nphamcs@gmail.com, chengming.zhou@linux.dev,
	fabio.m.de.francesco@linux.intel.com, rrichter@amd.com,
	ming.li@zohomail.com, usamaarif642@gmail.com, brauner@kernel.org,
	oleg@redhat.com, namcao@linutronix.de, escape@linux.alibaba.com,
	dongjoo.seo1@samsung.com
Subject: Re: [RFC PATCH v2 02/11] mm: change callers of __cpuset_zone_allowed
 to cpuset_zone_allowed
Message-ID: <aUABV3sQyaTksz54@gourry-fedora-PF4VCD3F>
References: <20251112192936.2574429-1-gourry@gourry.net>
 <20251112192936.2574429-3-gourry@gourry.net>
 <dda1fab7-5cb9-4d83-8b60-f4ed75a03aa8@nvidia.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dda1fab7-5cb9-4d83-8b60-f4ed75a03aa8@nvidia.com>

On Mon, Dec 15, 2025 at 05:14:07PM +1100, Balbir Singh wrote:
> On 11/13/25 06:29, Gregory Price wrote:
> > @@ -2829,10 +2829,9 @@ enum compact_result try_to_compact_pages(gfp_t gfp_mask, unsigned int order,
> >  					ac->highest_zoneidx, ac->nodemask) {
> >  		enum compact_result status;
> >  
> > -		if (cpusets_enabled() &&
> > -			(alloc_flags & ALLOC_CPUSET) &&
> > -			!__cpuset_zone_allowed(zone, gfp_mask))
> > -				continue;
> > +		if ((alloc_flags & ALLOC_CPUSET) &&
> > +		    !cpuset_zone_allowed(zone, gfp_mask))
> > +			continue;
> >  
> 
> Shouldn't this become one inline helper -- alloc_flags and cpuset_zone_allowed.
>

I actually went back and took a look at this code and I think there was
a corner case I missed by re-ordering cpusets_enabled and ALLOC_CPUSET
when the GFP flag was added.

I will take another look here and see if it can't be fully abstracted
into a helper, but i remember thinking to myself "Damn, i have to open
code this to deal with the cpusets_disabled case".

Will double check on next version.

> Balbir
> <snip>

