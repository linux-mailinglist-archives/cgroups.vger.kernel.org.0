Return-Path: <cgroups+bounces-8074-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1BAAAE835
	for <lists+cgroups@lfdr.de>; Wed,  7 May 2025 19:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7F91521B78
	for <lists+cgroups@lfdr.de>; Wed,  7 May 2025 17:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077E428DB4B;
	Wed,  7 May 2025 17:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="AYXpFoH6"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A94289835
	for <cgroups@vger.kernel.org>; Wed,  7 May 2025 17:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746640367; cv=none; b=ebiFypjzDhXzNhW/q3fplO8xpj60P1cNtwIeeaC8NqofobyHJlVY1hLGKTCGbkXEG9hXkfRl//iVj4C/zD8WoqBTIcxM0zrofn6ewYtSIcbkC1sLJeGDYKWVTRBakChN/NB2kXnefxi9bQimoW4LrQePQcNMc0fawYeUTUxCinw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746640367; c=relaxed/simple;
	bh=L8cxWwxhIES4Y5AFNofFv0Y2ywMA2lAf7ex9vXB6q30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XBYtEGSkDxsi0Mr7ImYCUeIiq7eeUakVljNv5Pjv0TsCNS/R3ERE9nV57Q01FKNo5MV75vDe7E5nVZ9mrUCmrYYBQOhHpseZ80zQoD0BnrFSUrhjFIHeFzCytDzwNGjkt3GFM+eioCpl9+5JVLobpqy8BP5swgOLbhzkjytz7hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=AYXpFoH6; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4774d68c670so1837421cf.0
        for <cgroups@vger.kernel.org>; Wed, 07 May 2025 10:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1746640363; x=1747245163; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uwbbKB2TGYLFE4veY3gGLDIpfEXqZNhneox5iaSq2IE=;
        b=AYXpFoH6LD4v9EMDMgWs/J8oLMI/jcTA/5tx+sFruKGhg7ibl0qszmzLk5CUxJd1ng
         lJ/EYjOOfuWNRpAS+saf1JsVYvGrqqP272+YTZuoFir2+hKln1fK028zY0KoRlaDzZcp
         q2sZKYVxleDq5Z8xp1gPnw6FSae+y7WYPd6g9R8Jd3Nyzly8LVLPsqrfwp7+o6c5MuIi
         4nnX082KqJSus0rEhn4wOdY/pDGPDCVOj9xToWhWwDC1WhEYdmY65KzZRPwF92qxr+cP
         6U8gMcckcFcuV8CS2EKa214jbiITQHxGg6m3xEJlPHqayJ32tYLphoTmXoEQtDJt2Yg5
         rSqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746640363; x=1747245163;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uwbbKB2TGYLFE4veY3gGLDIpfEXqZNhneox5iaSq2IE=;
        b=GcdMV9FqtX8Exehqgkn1MHcXLdCBEwM8HDK5qT8dPKZH7OfkC0WnJTJJGwIV8DZ7Zx
         JMJLX7ugKisolitrByhuDNJSw5owE5cPq38hH0cL9fWNm8Qb+CUJPkn/FszKA/vMX0IC
         eJPCwDXjWncI2igyN7UNCES+ezYBFeBFUFpLmQIO0vm9sfw310mLcRGcWBVIGOmUiQw6
         PIaQCjt3S35O+I+Zs4GZFqC39yLvvsBxosRVfpb+Q120VQUafTIeZ87glw+DS18asYsK
         cJfdJZz48Z5ZQQzz/Qxddz2x2mpYjNZdN06CZANveai7kes0YKx7EjtMeU058NZKCtTS
         2DVw==
X-Forwarded-Encrypted: i=1; AJvYcCUiL1ce6i3d4fs2CSN55QZWNnE3RU4MuRK+YGGnHcatcPiIRCxDqmhuJs0xcFRBuAap1EnmKggs@vger.kernel.org
X-Gm-Message-State: AOJu0YxUnCEDOBRNr6C0qV8sqNBr1h3i7qukB7l3JPdm0hThdeSQQ/cM
	dudxOpxY+uIjMQCA271sB4q0lQWVaZAUi3VnuDFVJPN4M0nvNFJ578co4NY//PM=
X-Gm-Gg: ASbGncvOZ1dAPMJMfaK47y8Fex8V5J2HD5w1nLbk1Hx78oYoUgGMhazMOeVBPt5ULYl
	jW+NJp39lEWdh2TkAQdRtbLMEqtSpaBV4oOInLQ9uqAhORFNUu0RZBZYn+5FA0DD56ZEI+b2YUZ
	ohF7zX5U4qr7AerlC9O+WwOHqjN5kCjr9jciAIbjZkD0gTAnVooeNsJCJoDI2f7sHhGmwUw8V2w
	uaJKkiWemhcECn3aOJB1UuFrdROAXHc/VDPQmXWqzgEA/hEQe0xsdXvsME6NwJytaZFKNb9OuY1
	UEtvY7wYiaO7q0yKiN7+VY7dcYHSIN7o/hcDYzU=
X-Google-Smtp-Source: AGHT+IHH43mAJ6j8NHoQHgd5dHvkco+AvBLpBXk7z7HjmDWyyxQSxP0kD/YiwHsD4miO14w1gFKHwg==
X-Received: by 2002:ad4:5ca5:0:b0:6d8:99cf:d2e3 with SMTP id 6a1803df08f44-6f542a55c59mr57521136d6.22.1746640363017;
        Wed, 07 May 2025 10:52:43 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:365a:60ff:fe62:ff29])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f542647e0esm17019576d6.30.2025.05.07.10.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 10:52:42 -0700 (PDT)
Date: Wed, 7 May 2025 13:52:38 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Dave Airlie <airlied@gmail.com>
Cc: dri-devel@lists.freedesktop.org, tj@kernel.org,
	christian.koenig@amd.com, Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
	Waiman Long <longman@redhat.com>, simona@ffwll.ch
Subject: Re: [rfc] drm/ttm/memcg: simplest initial memcg/ttm integration (v2)
Message-ID: <20250507175238.GB276050@cmpxchg.org>
References: <20250502034046.1625896-1-airlied@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250502034046.1625896-1-airlied@gmail.com>

Hello Dave,

On Fri, May 02, 2025 at 01:35:59PM +1000, Dave Airlie wrote:
> Hey all,
> 
> This is my second attempt at adding the initial simple memcg/ttm
> integration.
> 
> This varies from the first attempt in two major ways:
> 
> 1. Instead of using __GFP_ACCOUNT and direct calling kmem charges
> for pool memory, and directly hitting the GPU statistic, Waiman
> suggested I just do what the network socket stuff did, which looks
> simpler. So this adds two new memcg apis that wrap accounting.
> The pages no longer get assigned the memcg, it's owned by the
> larger BO object which makes more sense.

Unfortunately, this was bad advice :(

Naked-charging like this is quite awkward from the memcg side. It
requires consumer-specific charge paths in the memcg code, adds stat
counters that are memcg-only with no system-wide equivalent, and it's
difficult for the memcg maintainers to keep track of the link between
what's in the counter and the actual physical memory that is supposed
to be tracked.

The network and a few others like it are rather begrudging exceptions
because they do not have a suitable page context or otherwise didn't
fit the charging scheme. They're not good examples to follow if it can
at all be avoided.

__GFP_ACCOUNT and an enum node_stat_item is the much preferred way. I
have no objections to exports if you need to charge and account memory
from a module.

