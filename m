Return-Path: <cgroups+bounces-12445-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0FFBCC9961
	for <lists+cgroups@lfdr.de>; Wed, 17 Dec 2025 22:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E67333006727
	for <lists+cgroups@lfdr.de>; Wed, 17 Dec 2025 21:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9C130DD0C;
	Wed, 17 Dec 2025 21:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="bLmP5yRi"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D584B30F922
	for <cgroups@vger.kernel.org>; Wed, 17 Dec 2025 21:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766006534; cv=none; b=YFoo7gVmgis55H+oAZ5vS794mQfKjdy3zsxwxoQ2FyMCj+8+fuE+NFfZX7dYF7JpcboU4UkNf3TQvXZSXHQMCg1BNl7YU0+L6SBO4GwMV6h6w0duCgKuaE9EuYI62g8Y0rf+SQTWInh24DBXq8e294jfkjI0ZOkGNqVj6PLirQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766006534; c=relaxed/simple;
	bh=Excu9vCoi/x7baNVQXP2DdLY1BHeq6L0CDw44UYt9NU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BWSiy1S6MJ2cnK6cpgwKYvylwPAxkYNxwzI5MLDO8hlrLPz269k9X02NyTHIFuZUyJdceL1pZGg+cBt/a7AVY3i+YjtaS4AqdvMRZrDL66cy9J86/kj5f0O7ZfSF6lL1UgO2P5zheRmMw8EcIdCbpoOqQRhN2ignE9WBNvXIokI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=bLmP5yRi; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-88a2f2e5445so47411676d6.1
        for <cgroups@vger.kernel.org>; Wed, 17 Dec 2025 13:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1766006530; x=1766611330; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bOOgnzCzdNQgnsHYyEnitX5C1ZN2cK+8ABaNl5MoIv8=;
        b=bLmP5yRiTnJes8j1VAqLBfuZbIDjQy9epgmH5diCtyzgmeJLPdfs1pZc/gHrCjVZcl
         huP+uddPAqW1udk5hzaTTR27xFp/rITIitBQ6jo5/CbHzDzt4oJdNMvZ79rzOpou5BON
         xpYf02ZPvPIZWp8KtA4hNOmKhnKDNfxFRSY/bBOkFzLUVFWlEjYfDZA1r1WyEXSS8aNw
         n7uzEZMUmTH1bL50QGy5JoJkUhJ6WI6yZs+gY3bGmJsBlXf1mDPIAET4zwxzGTXLbvAl
         ZUt9aBtPxQp+cFcx3OwTWkHEF8rBrltJ3oqSo6ASuTaYyBERiLaMrKeGYtCkFzeLPt2w
         0dYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766006530; x=1766611330;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bOOgnzCzdNQgnsHYyEnitX5C1ZN2cK+8ABaNl5MoIv8=;
        b=mJ3c6D2vC2wWyQZspPtbQHIwI6gkL8I1CRLeqsXJ6ULqdPBeZJ6MIdTrMx8vJrnnJS
         /uNIYwUwGQNoP1RrlcEfJxAdiNAADdxVNL3+uw5Z9FZjXqVcoklqEv136b8olzTkNT/6
         t0M1nJKCVyeLvLLnWH7zwiabHcvoollKoo/NOvy+mzBuQfoYyMnRqQ3DG14rbc+mjbf/
         2rtPUwggupB9mDeBMW6GziOtsq3JgQTEuGD4bxgY1zoWcvRmOqaz8ecLbI2gspfdDTsL
         B4DaV1Niq72L/CLzvc++ZtnG8wq68eudtihwRQwNki6V2w6ysHzGdCNM5ttB1AutY9av
         NzqA==
X-Forwarded-Encrypted: i=1; AJvYcCXNTQGzamslUGhuaE40tAgk366rnoULOoUSwLHqyaWA8AlV3Nd/9A8h/qRdLroJxvtF+A/5RmM8@vger.kernel.org
X-Gm-Message-State: AOJu0YzS3uXPvhel2THjzXMh11Ihs/HRTWF0cNITfvDHoYGb8g6lTk35
	YEXyWgPfBbCBfFwZ3khhPF5a+USJJXHDgvyDurLdBZj3+soY1bggx40vbSYyZXLbeFE=
X-Gm-Gg: AY/fxX7znu8bxGYqccrsncJvteMsStxeaDajejYHebImIl7jU3SzN4fsbjDijG2D0SD
	EE8uokrHjDJa04Pxqe/afb5opvi69DLuDiwAJesUv/xcHI2eiXo6pz2Ud/AsV5xPLjaY4aZWilG
	zaRbwoKMpPzkzSItv+X4l7LCTQrYIwj4SAB6BW9oZs+YMsLgdVDKw3jy0ewiSADkewLmJuC7mYm
	UWlPdNFGjupTomUiY21db/rx1dgW/ewQCaFrNR0AsYZ3vu+MuIR3KgmzD4UDXS44lDgTs1vgyRP
	Ebo6QC/ZEHTcvqnyjTzG5vtCdnr4Spx2YEdjhgCa30+wM3iZx7FrI0QdHRuTLSjm3sl1MkmUD3b
	FtcH4SjWlNZo91PdEbbPj79PlY4T2ACLdLAKNuat75v0ibiuNDaSzBM8nL69qzGhGdIKuSj9maD
	jUUcI9vVVZTA==
X-Google-Smtp-Source: AGHT+IFzXUkRHitQ6VNCbbPfCAE8rsPjnOnwE2wUVrJxtg3mT4weGRzR1Jq+HE4b4SUpjoKCvX7jUg==
X-Received: by 2002:ad4:5ba8:0:b0:888:4930:82aa with SMTP id 6a1803df08f44-8887e181613mr336351406d6.70.1766006530486;
        Wed, 17 Dec 2025 13:22:10 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:929a:4aff:fe16:c778])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88c5dc70a93sm3699666d6.4.2025.12.17.13.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 13:22:09 -0800 (PST)
Date: Wed, 17 Dec 2025 16:22:08 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: hughd@google.com, mhocko@suse.com, roman.gushchin@linux.dev,
	shakeel.butt@linux.dev, muchun.song@linux.dev, david@kernel.org,
	lorenzo.stoakes@oracle.com, ziy@nvidia.com, harry.yoo@oracle.com,
	imran.f.khan@oracle.com, kamalesh.babulal@oracle.com,
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
	chenridong@huaweicloud.com, mkoutny@suse.com,
	akpm@linux-foundation.org, hamzamahfooz@linux.microsoft.com,
	apais@linux.microsoft.com, lance.yang@linux.dev, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v2 06/28] mm: memcontrol: allocate object cgroup for
 non-kmem case
Message-ID: <aUMfALjD7Q1A3NU8@cmpxchg.org>
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
 <897be76398cb2027d08d1bcda05260ede54dc134.1765956025.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <897be76398cb2027d08d1bcda05260ede54dc134.1765956025.git.zhengqi.arch@bytedance.com>

On Wed, Dec 17, 2025 at 03:27:30PM +0800, Qi Zheng wrote:
> From: Muchun Song <songmuchun@bytedance.com>
> 
> Pagecache pages are charged at allocation time and hold a reference
> to the original memory cgroup until reclaimed. Depending on memory
> pressure, page sharing patterns between different cgroups and cgroup
> creation/destruction rates, many dying memory cgroups can be pinned
> by pagecache pages, reducing page reclaim efficiency and wasting
> memory. Converting LRU folios and most other raw memory cgroup pins
> to the object cgroup direction can fix this long-living problem.

Not a big deal, but since the coverletter will be preserved in git, I
don't think you need to repeat the full thesis.

> As a result, the objcg infrastructure is no longer solely applicable
> to the kmem case. In this patch, we extend the scope of the objcg
> infrastructure beyond the kmem case, enabling LRU folios to reuse
> it for folio charging purposes.

"To allow LRU page reparenting, the objcg infrastructure [...]"

> It should be noted that LRU folios are not accounted for at the root
> level, yet the folio->memcg_data points to the root_mem_cgroup. Hence,
> the folio->memcg_data of LRU folios always points to a valid pointer.
> However, the root_mem_cgroup does not possess an object cgroup.
> Therefore, we also allocate an object cgroup for the root_mem_cgroup.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

Looks good to me.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

