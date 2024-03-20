Return-Path: <cgroups+bounces-2082-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9178881A37
	for <lists+cgroups@lfdr.de>; Thu, 21 Mar 2024 00:45:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 260E51C20FCB
	for <lists+cgroups@lfdr.de>; Wed, 20 Mar 2024 23:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3757F86244;
	Wed, 20 Mar 2024 23:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="NQrUIa00"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550B4381D1
	for <cgroups@vger.kernel.org>; Wed, 20 Mar 2024 23:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710978323; cv=none; b=Cw5M6HMCmOPo+Wb80LGPDZWSUuHJhFN8Kvwz1Osg2Jyaz3MQMtW5DZuPFRR3S/v6jj+VhhFN53CuIETOr1kyUXgxNWdOlgH+LdOjbv0g1ymQ6LPI5qXOFzvzjBkpk94uo2hsOce+arbLY0awdbZr80mu6p+RmTYyMhGoaOBXFxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710978323; c=relaxed/simple;
	bh=8tDjC9UtnvR6CB41JY1jXf3IwD8hZvVyzgVgCDUjlls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rtr/FlEtHxP70vli2vAvpF2J3R78ne1Gk92rtd4GQlsvCssfrCf6vnSmtSoju6M8B3prPy1D4crvevv+1Pwc9JQF/xTudTT4V8iihNBYhpHq+7zBAxsM16dV2eWkNFZ9Zsni5UVQO8ctzd0odSP1PNemTTGoa1j8RM7KLys568g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=NQrUIa00; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-78a2a97c296so27411885a.2
        for <cgroups@vger.kernel.org>; Wed, 20 Mar 2024 16:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1710978318; x=1711583118; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AXioFYbquIvXXAo9owl/PKnQvce3YPzjBFfKMVoD2Ro=;
        b=NQrUIa00QM6lGIZBbFhNKGwuvauo4dTYKgvdV/VYCrhyQ3hF75zWe/m7rJPAl/74JI
         fHwZcPgGW5nKVMnDg6L3pk+/Of0fD8tjauv0q+bme7ZgX2fM3tcOL4NNjf+6M02Za9Bg
         +QR75zmwgtsl+h67fqQdCDURWT+vXfppsE1zqAyLW4/fuAi2c1gyZvog4XgqvquBWO38
         974Yn5Vuh7nfR1kYKkkuAjhNpNrkxzg7nAHJO+LiHnaiYckWn9bS0FJoJ63j1tPAD0db
         dZDOYMwarbzzC9egni1ER0rv0RoDEj5F721zV+aW2Rf2exAhJDBQ/3mLP0HSsEhyD3jW
         ZdMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710978318; x=1711583118;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AXioFYbquIvXXAo9owl/PKnQvce3YPzjBFfKMVoD2Ro=;
        b=eGfluVCbvFu1b/ZVi6om76BhkED05w6FzRLsmZ1HLCvkk/orw5rXoc0aRBnMW1p/kn
         ZP0MbGCR0ep8z3lobryvngzVSplkizn6xuwWAWK6FkkBAF4iS2I0bVzvhW1tT3MPkgXp
         zMehVJcz+l6+xHx6U02ZfhmOV+BgpHsxvjAIgbrRYIgQj/tlt2skCcrstHBpuL2qM/U0
         JMZEKQQB/m4opUzr75rLliOLin0ENYISUPUq8C3pA40wOFAP2nrr4TV2BW6qyfL0vX6o
         /Kp0ZsV+IPxbWA8UOYpXnfiFynKZbJp9I2OmXiy04c1h2BLcbeUA+tm90r1YkeBx2nUl
         HJxw==
X-Forwarded-Encrypted: i=1; AJvYcCW2i02uUAOiBXQlLvqt7hA7JZ77lXVU+P/VDkIPlPtfeea5XjC9Wm4zindCG6tZms4Qt+dwgvzzaPlpNyPKyuAVbJbuglLB3w==
X-Gm-Message-State: AOJu0YxM2sa445mOL7OfuHbZqHYuQrwesIGVJ6yqZE+zaWRfDAAivfei
	Tn2TG3NqslJIgA9b5ExtGvi/WtzlOpO7W7pWuujZuXGWW1NLyziJ/aLCRdJmFBk=
X-Google-Smtp-Source: AGHT+IFKPEjwfmOFjIX+g2ga1vxv+5xqkzUDeuvdTBScQ+ysDjM/7ZelybMetyrobl2ORzIKlZmDsA==
X-Received: by 2002:a05:620a:578c:b0:789:f574:e511 with SMTP id wk12-20020a05620a578c00b00789f574e511mr7281092qkn.70.1710978318222;
        Wed, 20 Mar 2024 16:45:18 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id b10-20020a05620a126a00b00789ea123bd5sm4975476qkl.59.2024.03.20.16.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 16:45:17 -0700 (PDT)
Date: Wed, 20 Mar 2024 19:45:16 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: remove CONFIG_MEMCG_KMEM
Message-ID: <20240320234516.GJ294822@cmpxchg.org>
References: <20240320202745.740843-1-hannes@cmpxchg.org>
 <Zftk3tzC2btb3Ine@P9FQF9L96D>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zftk3tzC2btb3Ine@P9FQF9L96D>

On Wed, Mar 20, 2024 at 03:36:14PM -0700, Roman Gushchin wrote:
> On Wed, Mar 20, 2024 at 04:27:45PM -0400, Johannes Weiner wrote:
> > CONFIG_MEMCG_KMEM used to be a user-visible option for whether slab
> > tracking is enabled. It has been default-enabled and equivalent to
> > CONFIG_MEMCG for almost a decade. We've only grown more kernel memory
> > accounting sites since, and there is no imaginable cgroup usecase
> > going forward that wants to track user pages but not the multitude of
> > user-drivable kernel allocations.
> 
> I totally support it. I believe one of the reasons for it to exist
> was SLOB, which hasn't been supporting the slab memory accounting.
> No such reasons anymore.

Yeah. The funny thing is, if you had slob selected, it would also
disable all the other kernel memory accounting covered by that option
that had nothing to do with the slab allocator.

This patch certainly got a much more simpler without slob around.

> Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

Thanks :)


