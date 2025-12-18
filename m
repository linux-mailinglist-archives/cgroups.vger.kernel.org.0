Return-Path: <cgroups+bounces-12504-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3690BCCBE9C
	for <lists+cgroups@lfdr.de>; Thu, 18 Dec 2025 14:06:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A86B530D21E0
	for <lists+cgroups@lfdr.de>; Thu, 18 Dec 2025 13:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C8B335568;
	Thu, 18 Dec 2025 13:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="j9gsOaft"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9845334C20
	for <cgroups@vger.kernel.org>; Thu, 18 Dec 2025 13:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766062939; cv=none; b=bpxzOGFT0ijQ6UE11AJoLhWYMPQJeIS13l2Y1oZ6E7JfbtwKS2ZGLacQB3OcOdxSWSUTkMxdy2YiF4xletohNRkHsL2s8nOIcvVudex86ApZqKgnYvdfHfKhZTIzD1eSzOUguTI5TqoGBDeh4Y+uoaYaBOTP8cwE4gJnvugQyxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766062939; c=relaxed/simple;
	bh=xbOBVQ86yHg6Sin/KsmT4bgAd9KDR20J3UX8UzDsL+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KpbvMuRL1AtRsfMswDPapeATg9QvtsMaCViIZCLkwQ+H3InEeZe04dFYhlAKuWKQ3HLzjE7c4wlxj6rZPS/bfPSoXO0A1DexJznuCRW+QWqGdySNCmLv8Jva2vXLVjR8aWzyvA+FYpK8KC4biQOUKrK56uiga1J0Z7lxphH72wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=j9gsOaft; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-88a2d21427dso5865556d6.3
        for <cgroups@vger.kernel.org>; Thu, 18 Dec 2025 05:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1766062936; x=1766667736; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eoMgDKwUqiYQLz/exZipbw/eWEAMXUec9gMtKJ9jU2U=;
        b=j9gsOaftEUeYRDFefqXzAHNmcjwF5qt39985j3iSSuicnTQpHPkvZFg2qq4q0uvaiK
         o+yg8UQ/4q4h0NLaa8faOnLbrXnNTLHGZxk0FB56riq/hEMK+0sOOU6sNGPzXJj7f9iv
         daoC0incAEkBA3LnHl5UvZzSl1CDYJ8Ea676t7rU+zJHVdt2XV0MqsNRNCx464VDUFqF
         YRi/PWOu24wukZWksBvLVFDEqMQqEN2CSVAqbHE0ovWeVUbhRpH4sVLJvktlwbWkK6Ry
         cj8GNH6LeuBdbCudRcw3opPHCoqP5z37Mn+XGzRWF3JdyO878Cyaxu2EhSmVUp5iqMFz
         1p0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766062937; x=1766667737;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eoMgDKwUqiYQLz/exZipbw/eWEAMXUec9gMtKJ9jU2U=;
        b=NWeVzH+dSFuLLjJk6iL0FKdHCqtagQzMr8Uwc4KlWsnnhasPx0SXLOOwqdOA4vydTB
         orjv1zRCTKOQ61v1b/mgfnum5YEIJ93/bqnZdhYpwgR78FMtz51PN8fk3GIZSOS7QlvJ
         WHBZiw+YQR5sn0VkUuWnqt9WqDcV5Uo7LamrBM49En3SmdH+PEBKZ/6/+reWQjzsRNyo
         JIP67dhoa1HuOP+pYNsxLEWJg/lNqzNf6OWVMuPkHkpYluSUmBEkjsT4CbumV3sVve9U
         eKLaI3dToG8Sq9fc0/Yz3zkF8VqXZI4FvlcG+80kDVk8GDV0pRMBJ4M1sjBHE6qn0iqV
         r5Ow==
X-Forwarded-Encrypted: i=1; AJvYcCUCpQamLhSalmu51J2EwcbCBsklpvHahpN3slkctJevl/6Ah4uzWNyXEOenq4jDKzML1CX6kPtp@vger.kernel.org
X-Gm-Message-State: AOJu0YxJzGSES5UQ5VYdZ1Mf1jBYan9Z3l0oEcs/GlLcYVjWXWu86eOq
	FKTXUtqOXO6nWXz1Kson4VNT961lbDDE3N+Wfxkje7QbZVTuDhthmSbkLLwe0Dw1J/o=
X-Gm-Gg: AY/fxX6G2qsO0LR5oc5lQnKZpsxhfuVkUhTRyohL9qkIOPCXSv0Q0yOrOqJHUHyQyPm
	MCJrie67SVE2tSZ6MN8TUamtbJSBFeWTmG0qAKL5r5PPEHfcVVWhDWuBYxl0VzS+T+oTSrHEQmk
	HjwmRT/YRQZyel7h9gZePwp3Gtm6UoBx+ThJ0Zcjl25bbxugldmzdJweYnNe0JkIZDilJD8fBxb
	U/wvMOj/hGRuESvltP1CzIFRSV4YpUSYllFyOebmSO+eAVSho3U6M+BBaG9weGRPNpL1NOD24KS
	uHv/hR/NejKArw9izGfR8jYwixebR7UY5/LWy8Zv8H/T4Obe41ZazY4mMS1xRZMo4p2x4r0mzEE
	d2Mx2KEVPT+atljy2wyhukZuquniVG4GkCCMkWptJA1RUxeV2hsg5O4YiSs1HE14QlfyaBzDPYJ
	I4s5H259oj9w==
X-Google-Smtp-Source: AGHT+IHCmTOM62jrKF5e0i3ecD3lTx7BUsHXoHpv+YPi0JwtT9sblxf5OQ9g95krK7LMiJWfCtz3PQ==
X-Received: by 2002:a05:6214:2b87:b0:86b:9167:b0e9 with SMTP id 6a1803df08f44-8887feff208mr316576036d6.4.1766062936323;
        Thu, 18 Dec 2025 05:02:16 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:929a:4aff:fe16:c778])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88c5e15be44sm16360706d6.20.2025.12.18.05.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 05:02:15 -0800 (PST)
Date: Thu, 18 Dec 2025 08:02:14 -0500
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
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v2 20/28] mm: zswap: prevent lruvec release in
 zswap_folio_swapin()
Message-ID: <aUP7VkCmTVSoMdBN@cmpxchg.org>
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
 <bd929a89469bff4f1f77dbe6508b06e386b73595.1765956026.git.zhengqi.arch@bytedance.com>
 <aUMvp5WzDp6dZCVr@cmpxchg.org>
 <8aee44f5-11ec-410a-9b45-5cb224e9e23a@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8aee44f5-11ec-410a-9b45-5cb224e9e23a@linux.dev>

On Thu, Dec 18, 2025 at 03:09:04PM +0800, Qi Zheng wrote:
> 
> 
> On 12/18/25 6:33 AM, Johannes Weiner wrote:
> > On Wed, Dec 17, 2025 at 03:27:44PM +0800, Qi Zheng wrote:
> >> From: Muchun Song <songmuchun@bytedance.com>
> >>
> >> In the near future, a folio will no longer pin its corresponding
> >> memory cgroup. So an lruvec returned by folio_lruvec() could be
> >> released without the rcu read lock or a reference to its memory
> >> cgroup.
> >>
> >> In the current patch, the rcu read lock is employed to safeguard
> >> against the release of the lruvec in zswap_folio_swapin().
> >>
> >> This serves as a preparatory measure for the reparenting of the
> >> LRU pages.
> >>
> >> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> >> Acked-by: Nhat Pham <nphamcs@gmail.com>
> >> Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>
> >> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> >> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
> > 
> > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> 
> Thanks!
> 
> > 
> > Btw, it would make the series shorter if you combined the changes to
> > workingset.c, zswap.c etc. It should still be easy to review as long
> > as you just stick to making folio_memcg(), folio_lruvec() calls safe.
> 
> I prefer to separate them. For example, as you pointed out, in some
> places, it would be more appropriate to switch to use
> get_mem_cgroup_from_folio() to handle it. Separating them also makes
> subsequent updates and iterations easier.

Ok, that works for me!

