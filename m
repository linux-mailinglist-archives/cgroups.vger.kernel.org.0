Return-Path: <cgroups+bounces-1237-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A593183DD9D
	for <lists+cgroups@lfdr.de>; Fri, 26 Jan 2024 16:36:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 096F8B22D9C
	for <lists+cgroups@lfdr.de>; Fri, 26 Jan 2024 15:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66D41CF9A;
	Fri, 26 Jan 2024 15:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="RMa3qJcY"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487871C68A
	for <cgroups@vger.kernel.org>; Fri, 26 Jan 2024 15:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706283399; cv=none; b=m6Z9r5M7TLi39GPCYfp8sDzE7a6EXE4b0W1c4vRXGiLJVf5dWc3zkVT/3bhbC0EPvJn9oAwGpKi3AlYeuMDlZkubPk77HesJPgmf9AIzrSXosA4i7vTpLnlTDzDuycIigIBOCSsQ3D2wus2gy7+ueODvwhxQFfJ3crmUS4jX8TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706283399; c=relaxed/simple;
	bh=0y6Kdl6gERZbliqvotqbu3Jd+kehmkbJb5zBel8YvJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=heUajdEiA3zVTUvhqc19CojCoFT6i0w6faw0Heu0nL2A0GriaVqGS1VyoBIALapI+QPy5+ONqF8lcREFKD51CAsXF4Aq65DwhlH1ETBZ0uffhbFwKw2h4vVxY7+isqcGFKiqIPzvud+1SzxQ8uC/HtqsZTxdcUj/Hf2tEjc97HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=RMa3qJcY; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-68873473ce6so4387236d6.0
        for <cgroups@vger.kernel.org>; Fri, 26 Jan 2024 07:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1706283396; x=1706888196; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=40HIjsRE90WPdigsHQYMpGWAzm17UAtEILxbsGCcnt4=;
        b=RMa3qJcY4MBQxdlRe5JnlW7xg/XjkTh38AGL5bhe/QK8kyUy853rNWULD4KnbWkP62
         dMXuXx64ApYnvuw8O4VYscAK3HIHu1PvCel5WgABtMbtSIlr3/UoLR+SLaZK7smGJvh3
         zjIsIIeVYw8///hNqfvx9ZUBvlLanqc1fAOqJFEBsSAPElwqZyHlmYe5PJ2jBUxjiPEy
         ZT/F9Nhu67MRl/rOXr+EbGjXi/Aqo4COQrmkmTnF7GfXinTVxi6qbZx5JGxdh/xlQttc
         ZfHYcglbULRz/05yPJmTjujlZgNR459AyY7erKN6MojCx1dq4q7ie/dVl5ohWH8l4FXR
         qWiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706283396; x=1706888196;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=40HIjsRE90WPdigsHQYMpGWAzm17UAtEILxbsGCcnt4=;
        b=LPEjdW1OOgltkRbhbBG5001+OMzEPtlRfJtr1OLpXFo4f9AWFQVQCNzrR7SxpPD0kc
         +wvSejG5zEtPiBmmQAhQGR/BHMMP0WZKdl9WZgOIOUbA8Q/MF2lebGuwJoEjAL8Abw9M
         4Qr5AWGE8BCiKMs4ms/Rglk2YJLTDT88L+IAj9kR/wQC31Mzpo+xrni5ZxctsBfOyKbr
         C9jPKaxmR0zkFFCGEpRXdQRP6ZEQBlzfkcRLYcEPo3qEkHalXboiwemOHO34RLFYvFeE
         4OaLAxSE/NLnQouu6vAQaVWOZUpXFBBXIPnPCmXrDV41M16YPxtUsnqQpvevtcSRAwPC
         x9sA==
X-Gm-Message-State: AOJu0YwfyrvaAsGEmHrZK4oWWrasSqlCbwfEsNpfIb+0AefPBzS6GMOP
	0KX7AjTws4LYyMKRb7+pajoD2BhFV9OHSUzZJQSwcvRzLpi5thOXihesC0YFowY=
X-Google-Smtp-Source: AGHT+IE4l7qby0RiD2Bq+7xwdlqH0jPzUiOjKPdkjQnUm36zYubYHz3g3qI6S6OKcci/vdm7fr3J4w==
X-Received: by 2002:ad4:5ba5:0:b0:686:ac69:d0fa with SMTP id 5-20020ad45ba5000000b00686ac69d0famr8133qvq.126.1706283395970;
        Fri, 26 Jan 2024 07:36:35 -0800 (PST)
Received: from localhost ([2620:10d:c091:400::5:271e])
        by smtp.gmail.com with ESMTPSA id on6-20020a056214448600b006819a4354basm601263qvb.37.2024.01.26.07.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 07:36:35 -0800 (PST)
Date: Fri, 26 Jan 2024 10:36:34 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeelb@google.com>,
	Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH] mm: memcg: optimize parent iteration in
 memcg_rstat_updated()
Message-ID: <20240126153634.GH1567330@cmpxchg.org>
References: <20240124100023.660032-1-yosryahmed@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124100023.660032-1-yosryahmed@google.com>

On Wed, Jan 24, 2024 at 10:00:22AM +0000, Yosry Ahmed wrote:
> In memcg_rstat_updated(), we iterate the memcg being updated and its
> parents to update memcg->vmstats_percpu->stats_updates in the fast path
> (i.e. no atomic updates). According to my math, this is 3 memory loads
> (and potentially 3 cache misses) per memcg:
> - Load the address of memcg->vmstats_percpu.
> - Load vmstats_percpu->stats_updates (based on some percpu calculation).
> - Load the address of the parent memcg.
> 
> Avoid most of the cache misses by caching a pointer from each struct
> memcg_vmstats_percpu to its parent on the corresponding CPU. In this
> case, for the first memcg we have 2 memory loads (same as above):
> - Load the address of memcg->vmstats_percpu.
> - Load vmstats_percpu->stats_updates (based on some percpu calculation).
> 
> Then for each additional memcg, we need a single load to get the
> parent's stats_updates directly. This reduces the number of loads from
> O(3N) to O(2+N) -- where N is the number of memcgs we need to iterate.
> 
> Additionally, stash a pointer to memcg->vmstats in each struct
> memcg_vmstats_percpu such that we can access the atomic counter that all
> CPUs fold into, memcg->vmstats->stats_updates.
> memcg_should_flush_stats() is changed to memcg_vmstats_needs_flush() to
> accept a struct memcg_vmstats pointer accordingly.
> 
> In struct memcg_vmstats_percpu, make sure both pointers together with
> stats_updates live on the same cacheline. Finally, update
> mem_cgroup_alloc() to take in a parent pointer and initialize the new
> cache pointers on each CPU. The percpu loop in mem_cgroup_alloc() may
> look concerning, but there are multiple similar loops in the cgroup
> creation path (e.g. cgroup_rstat_init()), most of which are hidden
> within alloc_percpu().
> 
> According to Oliver's testing [1], this fixes multiple 30-38%
> regressions in vm-scalability, will-it-scale-tlb_flush2, and
> will-it-scale-fallocate1. This comes at a cost of 2 more pointers per
> CPU (<2KB on a machine with 128 CPUs).
> 
> [1] https://lore.kernel.org/lkml/ZbDJsfsZt2ITyo61@xsang-OptiPlex-9020/
> 
> Fixes: 8d59d2214c23 ("mm: memcg: make stats flushing threshold per-memcg")
> Tested-by: kernel test robot <oliver.sang@intel.com>
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202401221624.cb53a8ca-oliver.sang@intel.com
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

Nice!

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

