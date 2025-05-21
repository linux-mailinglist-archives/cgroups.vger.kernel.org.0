Return-Path: <cgroups+bounces-8287-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7213FABF817
	for <lists+cgroups@lfdr.de>; Wed, 21 May 2025 16:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36BF01BC3ED9
	for <lists+cgroups@lfdr.de>; Wed, 21 May 2025 14:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DBBC194A59;
	Wed, 21 May 2025 14:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="SL0K3G/i"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA661D63C2
	for <cgroups@vger.kernel.org>; Wed, 21 May 2025 14:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747838603; cv=none; b=AlcoAeiZOgRBCjThSv6ldjVRCe5sDIqePhtmjJYXs7m3V/tgOfZr6trzP84mKWsuaed7wDiwia7VyAsjp/lAXFkcRs5R8vc6Pt5Ml+O3EGIu90/bUjRCErl9Z5naOlRsh36zMm81ZRBTreosGwnWIiojE1Fo1Z2uOId3WPNHp9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747838603; c=relaxed/simple;
	bh=JJvx61FeAXZ1grZ60FxV672PTvRPiKP8AhdYp50uQHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FQKucMlQIpUr/yIWrdl3OpoVEaZFnbJaX+KtGMj9V82F+G91ODU77ggcdFFvh0inpsy6IKBbDIdcITCNY/x6z1S/18LvVgWTwfmR03Ig2sc/P9jzKODQjb0F2ET7TW86rDzq+bXaRI0STDXGBQFpXoiFm5VqIHfdZbaxjIw4dw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=SL0K3G/i; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6f8d96499e7so57607966d6.3
        for <cgroups@vger.kernel.org>; Wed, 21 May 2025 07:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1747838596; x=1748443396; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tm5t+Bgq7540ocHTCpxJRFMuSZJmOFrIbkmxzwr4YdE=;
        b=SL0K3G/iCEWAIx4s/DW0Scgx1GZPkVFowrHdCiM0SjKajmnFioZCABoiv4iig/3ylM
         c57tIUbdsY0MZoV5LvylvIKqlzoaICDmG7uNM1WPnJbR2p08x/htBAqDGfZWmlSX1fcs
         J5p5Fj3v12CQkyhcniR8rzjyMqT1eyxfnM9dWnZ1rIjumSJxAHYLOjfcJ+SVSuNgd05G
         J6UoyJXeKIRPjQ9LTpL5Rm/sEieWdg+U+KENF60vDDI4debP8EXqdSFRX8t6OwE/2c+x
         VC9r3CiFfN7Vl0t706wQeJ3M4U5tmNl3i9m/mSPlo6qzdnGV0aClMzow6d1E8ltpn2+z
         Zdqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747838596; x=1748443396;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tm5t+Bgq7540ocHTCpxJRFMuSZJmOFrIbkmxzwr4YdE=;
        b=b+D7vsdjynVANwRijpVyosvnMGVp9f5omLKOocYGEH9AgduDYOMCzuIQlcNQ6jKcMC
         gaGdVi7N9iU/M51LGggc6QYVVJuTbD7E1kJUiwnZ5HUAi0UPtxanZxVse/8I7aun4zFR
         9TfolH/+luJfWRD8Bs4opCmTycmtw3dBOqoCtzn4XTpcSB+U6/6k2rp+X+LkUKdOmDFR
         J86fmvhEo+9Wjjxp3ByO2abS99R8F85ySwcfM6FCGy9ubLEh0ZBROk0CunMwuTTrqOLp
         ulChJZYjZONfEaju4jtjVwbE3hKqk/Rs/R1a5Cmv+3Cq0MnT8y87FAqBlKG4FSgf99kj
         037g==
X-Forwarded-Encrypted: i=1; AJvYcCVVWA7CR2Jfr4SEcPhKUa9ji35DuC5eO9dc+nOhu23QfjsyLivRmSKqwDtiPv7hk66Bj11TMoZV@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf2p+VmvnOEC1DTqsJ4nAOM5I7e5/T7uL0CS/FRhFQNL+Mkf14
	qO377lHlru8pRcbIhZ0LXUPQj/qQ+r1IJJslQ2MZ4jdTxK29z5LKo+CzkHPNO7T1ekI=
X-Gm-Gg: ASbGncu0yYrgNctRsKeEov0AJG1z1F1Ky9bNxBB8J+/WTGKHwuX6cORST7CyHwxj45y
	jDiR4qz0ZjdR8g/DTVtzgx7vAdWwS6cYxm9DKZFrKVZ5UkZZCT+dqD69gr/XI9zNg5238fF95Tb
	OMA2dE4sh4NVrIW8dG4naeTwHKSvkiWTF0tHMzAlTp0n70HUFJwbm7PRAH2Ppoux2/K2O+3SLD3
	i5bV/7FyTwLwoGSvX8wwIKzazPySCKcwuIO1lus87KyVq96BFthKuiEhmUnFuTnyqu9gcWVrgwu
	zjYT+qgDKh1BAT1GYdxVq6ReIo09XmsGhSOfrx+EAzmQAbLQ8Q==
X-Google-Smtp-Source: AGHT+IHEM+wvUcEaGmWTryHjewq8bJ6N/GLkNLp803DMsIdPw7rLGbMkCkeiFVtKhclLf9k4Ii/+7Q==
X-Received: by 2002:a05:6214:932:b0:6f8:b73e:8e65 with SMTP id 6a1803df08f44-6f8b73ea51bmr256380506d6.18.1747838596519;
        Wed, 21 May 2025 07:43:16 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:365a:60ff:fe62:ff29])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f986a86b90sm7541296d6.97.2025.05.21.07.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 07:43:15 -0700 (PDT)
Date: Wed, 21 May 2025 10:43:12 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Dave Airlie <airlied@gmail.com>
Cc: dri-devel@lists.freedesktop.org, tj@kernel.org,
	christian.koenig@amd.com, Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
	Waiman Long <longman@redhat.com>, simona@ffwll.ch
Subject: Re: [rfc] drm/ttm/memcg: simplest initial memcg/ttm integration (v2)
Message-ID: <20250521144312.GE773385@cmpxchg.org>
References: <20250502034046.1625896-1-airlied@gmail.com>
 <20250507175238.GB276050@cmpxchg.org>
 <CAPM=9tw0hn=doXVdH_hxQMvUhyAQvWOp+HT24RVGA7Hi=nhwRA@mail.gmail.com>
 <20250513075446.GA623911@cmpxchg.org>
 <CAPM=9tw+DE5-q2o6Di2POEPcXq2kgE4DXbn_uoN+LAXYKMp06g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPM=9tw+DE5-q2o6Di2POEPcXq2kgE4DXbn_uoN+LAXYKMp06g@mail.gmail.com>

On Wed, May 21, 2025 at 12:23:58PM +1000, Dave Airlie wrote:
> >
> > So in the GPU case, you'd charge on allocation, free objects into a
> > cgroup-specific pool, and shrink using a cgroup-specific LRU
> > list. Freed objects can be reused by this cgroup, but nobody else.
> > They're reclaimed through memory pressure inside the cgroup, not due
> > to the action of others. And all allocated memory is accounted for.
> >
> > I have to admit I'm pretty clueless about the gpu driver internals and
> > can't really judge how feasible this is. But from a cgroup POV, if you
> > want proper memory isolation between groups, it seems to me that's the
> > direction you'd have to take this in.
> 
> I've been digging into this a bit today, to try and work out what
> various paths forward might look like and run into a few impedance
> mismatches.
> 
> 1. TTM doesn't pool objects, it pools pages. TTM objects are varied in
> size, we don't need to keep any sort of special allocator that we
> would need if we cached sized objects (size buckets etc). list_lru
> doesn't work on pages, if we were pooling the ttm objects I can see
> being able to enable list_lru. But I'm seeing increased complexity for
> no major return, but I might dig a bit more into whether caching
> objects might help.
> 
> 2. list_lru isn't suitable for pages, AFAICS we have to stick the page
> into another object to store it in the list_lru, which would mean we'd
> be allocating yet another wrapper object. Currently TTM uses the page
> LRU pointer to add it to the shrinker_list, which is simple and low
> overhead.

Why wouldn't you be able to use the page LRU list_head with list_lru?

list_lru_add(&ttm_pool_lru, &page->lru, page_to_nid(page), page_memcg(page));

