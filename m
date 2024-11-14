Return-Path: <cgroups+bounces-5553-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C52239C87DB
	for <lists+cgroups@lfdr.de>; Thu, 14 Nov 2024 11:41:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 576A8B35B7B
	for <lists+cgroups@lfdr.de>; Thu, 14 Nov 2024 10:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7541F80D2;
	Thu, 14 Nov 2024 10:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AAs8zC3U"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EC81D9664
	for <cgroups@vger.kernel.org>; Thu, 14 Nov 2024 10:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731580430; cv=none; b=MflZgTyFZaZqQn+DSFfnHSuMsg6ALEMI7TnIRhi9fIC7YwQFbWj+0YH55IDVpDohXL6DInS8CYLgaF6Y121Srsg1edYFwvXRkhkwZNIY1pX04nJKENJvjLxUm+heDZoT6s/qQs7UQC3CPDWyJkV1hGD1UIbfJDjGq5uA/sqr+Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731580430; c=relaxed/simple;
	bh=X2NeQPMnpek12M1llh7mAvPwsYyUlv1ectRkJWKV740=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ghW8Szwn2jzB1Q8P/esuc9GYUmYConbIrNZ4iNqHM/PDAZrY7mRzSPfOzTZYZE4KPLTAsZCW6EoT+N7dcTsmcm+dF1SbbETgoDLj0Ou+UjhULl7HKtBB561CcdVQFiKTbqbnc/vEa3ro0fRFccjVXwjkyb6BY2+oqXLGKu4jieA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AAs8zC3U; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a9ec267b879so80123166b.2
        for <cgroups@vger.kernel.org>; Thu, 14 Nov 2024 02:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1731580427; x=1732185227; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VBPApLFtlaOK3f4z4ZSIcdYWTPe1i7pEMSXlEit2OcA=;
        b=AAs8zC3U9/6SbpbpwBiWKyWmA5quBsvv3R21SQIVM4IqoNuUexPs4u6B+7GWgEgm1s
         IPKRkiEqmTudD03Vfnjmqwvmn/c+HHa80J3/QtFabELuV7aEc0B33M89PTG7fVSFoSBf
         +xaNMgyJwhtH+dVTMJs5zJSVyAuwdl+6XZvzQQXYn8BPi7u0vOZ98JeIfFo05zLRe5T8
         hynahSv32BiDGxPlWMJohbRhUMXSZAwmEGL/eBp0cFrtwBVBhpZwhv1SC1UDyZ1ML3rD
         CrIHr0NRYBeK3nazVLE44MssbDKWpUFtxMmU7pRaR8Sa0QuJCX+MsJ9apn1CcFRB0ACM
         tn2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731580427; x=1732185227;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VBPApLFtlaOK3f4z4ZSIcdYWTPe1i7pEMSXlEit2OcA=;
        b=s7ucv/9gX1dmbvbCl0xt79y5v1lnnRV2T5zmdqKqJIFbuqFnrBPneuYBCJAcnIHo7A
         fDiNmS4zxoSicBIaF7bSQ2siVAqzh2h8VpMR5mdwW5PjOvoyaEiz0d1rgHgCkF4usOTf
         np4w6qoXKv+xU0DxpI2lmt5ZdOQsaThxzK63O3xPVdiZgITwdxwfnlP1k1GfpJ3vBxZa
         U5QFDNjzrXhM6pqvC9CQfJoAghoMxagqoC1M8rlXGnYno7TVlht1uyvqnexwFRw0vMXP
         qyhY1U4DDFMXVZVkSLaniF6k5gRXXZMie4HGIJiIfON3H7ljfjvUQm9bWsEQpd/PvEyQ
         TJJw==
X-Forwarded-Encrypted: i=1; AJvYcCW/RZPz6G9cKIM35pihXOOxmDt868kAOrKG+Puw1Sgp6J2NVDannkumQFK4IKZft5ccQBtHcEVg@vger.kernel.org
X-Gm-Message-State: AOJu0YxsmZyBPGpdDEw7rA5SYDxqrLEhoq5Sm/Kyq6XbHpBCeJSn4kME
	O8zv+1lcj2dQzhF92zSNfZzmm2BLzHLwVAGAmpcR/zIkwg/6ZTQHvqVYUdNitWo=
X-Google-Smtp-Source: AGHT+IEmLsdovsIKeaEEvZwYSPZlHx1HJdNmxwuq2BlsvFnUk5lcIWWhA0cQDnKQAWDSm08XlzLyuw==
X-Received: by 2002:a17:906:c150:b0:a9a:f0e:cd4 with SMTP id a640c23a62f3a-aa1f813b746mr585216666b.55.1731580426995;
        Thu, 14 Nov 2024 02:33:46 -0800 (PST)
Received: from localhost (109-81-88-120.rct.o2.cz. [109.81.88.120])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20df1b642sm47126766b.40.2024.11.14.02.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 02:33:46 -0800 (PST)
Date: Thu, 14 Nov 2024 11:33:45 +0100
From: Michal Hocko <mhocko@suse.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: David Rientjes <rientjes@google.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, akpm@linux-foundation.org,
	nphamcs@gmail.com, shakeel.butt@linux.dev, roman.gushchin@linux.dev,
	muchun.song@linux.dev, chris@chrisdown.name, tj@kernel.org,
	lizefan.x@bytedance.com, mkoutny@suse.com, corbet@lwn.net,
	lnyng@meta.com, cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH v4 1/1] memcg/hugetlb: Add hugeTLB counters to memcg
Message-ID: <ZzXSCSBcPobCpmG8@tiehlicka>
References: <20241101204402.1885383-1-joshua.hahnjy@gmail.com>
 <72688d81-24db-70ba-e260-bd5c74066d27@google.com>
 <CAN+CAwPSCiAuyO2o7z20NmVUeAUHsNQacV1JvdoLeyNB4LADsw@mail.gmail.com>
 <eb4aada0-f519-02b5-c3c2-e6c26d468d7d@google.com>
 <c41adcce-473d-c1a7-57a1-0c44ea572679@google.com>
 <20241114052624.GD1564047@cmpxchg.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114052624.GD1564047@cmpxchg.org>

On Thu 14-11-24 00:26:24, Johannes Weiner wrote:
> On Wed, Nov 13, 2024 at 02:42:29PM -0800, David Rientjes wrote:
> > On Mon, 11 Nov 2024, David Rientjes wrote:
> > 
> > > > The reason that I opted not to include a breakdown of each hugetlb
> > > > size in memory.stat is only because I wanted to keep the addition that
> > > > this patch makes as minimal as possible, while still addressing
> > > > the goal of bridging the gap between memory.stat and memory.current.
> > > > Users who are curious about this breakdown can see how much memory
> > > > is used by each hugetlb size by enabling the hugetlb controller as well.
> > > > 
> > > 
> > > While the patch may be minimal, this is solidifying a kernel API that 
> > > users will start to count on.  Users who may be interested in their 
> > > hugetlb usage may not have control over the configuration of their kernel?
> > > 
> > > Does it make sense to provide a breakdown in memory.stat so that users can 
> > > differentiate between mapping one 1GB hugetlb page and 512 2MB hugetlb 
> > > pages, which are different global resources?
> > > 
> > > > It's true that this is the case as well for total hugeltb usage, but
> > > > I felt that not including hugetlb memory usage in memory.stat when it
> > > > is accounted by memory.current would cause confusion for the users
> > > > not being able to see that memory.current = sum of memory.stat. On the
> > > > other hand, seeing the breakdown of how much each hugetlb size felt more
> > > > like an optimization, and not a solution that bridges a confusion.
> > > > 
> > > 
> > > If broken down into hugetlb_2048kB and hugetlb_1048576kB on x86, for 
> > > example, users could still do sum of memory.stat, no?>
> > > 
> > 
> > Friendly ping on this, would there be any objections to splitting the 
> > memory.stat metrics out to be per hugepage size?
> 
> I don't think it has to be either/or. We can add the total here, and a
> per-size breakdown in a separate patch (with its own changelog)?
> 
> That said, a per-size breakdown might make more sense in the hugetlb
> cgroup controller. You're mentioning separate global resources, which
> suggests this is about more explicitly controlled hugetlb use.
> 
> >From a memcg POV, all hugetlb is the same. It's just (non-swappable)
> memory consumed by the cgroup.

Completely agreed. From the memcg POV there is no way to control hugetlb
pages or manage per size charging/pools. In a sense this is not much
different from slab accounting. We do print overall SLAB accounted
memory and do not break down each slab consumer in the stat file.
-- 
Michal Hocko
SUSE Labs

