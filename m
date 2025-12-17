Return-Path: <cgroups+bounces-12456-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E1D2CC9B41
	for <lists+cgroups@lfdr.de>; Wed, 17 Dec 2025 23:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 98FA1300D309
	for <lists+cgroups@lfdr.de>; Wed, 17 Dec 2025 22:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6D53101B5;
	Wed, 17 Dec 2025 22:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="ASN6odwP"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2D12ED860
	for <cgroups@vger.kernel.org>; Wed, 17 Dec 2025 22:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766010442; cv=none; b=JTRH5Gp261s+W+/IkVrT/0r8OuwPDLvfED3NcX5L8VVitBFYcoPxrOoB67xuVEyTbhlYhcDbYD0GrUk9bS40xup9jHJq83pTNuArdrkpD2afV/IWeCpCPkVTuVVU2OmKiD+5CziaZ/Hub9J0E0xolHhQ0/u2yCZRf2FAibZ4tg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766010442; c=relaxed/simple;
	bh=opSIu9kG6yPEOSlTwoji/Hc8ePvBdOjoFG8c0bzw8pc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yxr2nW3LP6KwS6IMiShfzgwup+uHtrroUzvBmcKgMaPTbL3PAFz0fm8crQXyzbJJQM6OSurhm7C7FsBKXXE5ScCBSH/mDKaNMys/pgc8CSk1kPBRco6BQ+5ZY4tOZkimFXaleRjuJopVkZQ72YmiRHVdod8Oe23tMmu8E7/5qUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=ASN6odwP; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8b9f73728e8so3620285a.0
        for <cgroups@vger.kernel.org>; Wed, 17 Dec 2025 14:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1766010439; x=1766615239; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cTCBZvRcuAym/h1xBJiWm3RRmoCS7sWaqtZ8qFwz41Y=;
        b=ASN6odwP0bmRdgTRE9rFSOE/yhIYYLrgX3jP0ZV/1c6jmFyMOrq9/ypQdfinz3bpkc
         9MFWcAEsz76FoXa8OMy/i/Q3CAHmpfkjCncHpkfUdbXf86XSxQmSXV6UPxr1R4Rf5xjY
         Qi6HSHZWXjmDhu0yiv6W3rId01nlrdWzSx8IwEA+eQN7Yz7ygwAsfgE0l9wBYTsQeJPi
         A+Z2J4X8CjelLGwk+5sv4KHvoygiFFxLu/TaLTZe9qKo7Dn6hMPSQ+yfdWzvGPJE0cwr
         hlXuqD4NH1RB5abCHDD/7iWAh9gnHBFwFWosK5v8MuSjM6KSXvrkQtTjgNVDMKzeje8T
         2uYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766010439; x=1766615239;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cTCBZvRcuAym/h1xBJiWm3RRmoCS7sWaqtZ8qFwz41Y=;
        b=COi4bWT82I2Jmgs3gklFiUnEWYih6Ur4B7uBu/XGcgYpndypEyxnhp0ANrLW90vsmz
         WcYaD6Pg5Bj5zTVQQHZuL4/OedkdqAw21VZcU1h6OtYDEV3uDur6WpXDixjWdb1dKVA3
         mjmvB+5WtSx2fmFOP1GzBB7fZlsf5ufejqLgTXWs8wI7coXTkTyZ7TelXFnnx1h8kAl9
         W3gBDVqDaIL/nMBJzboxxgbWwfyqHoyCz/2Ilg/sYWoYnnH9Hc9a62QoAVpQNI25IF1R
         /BZcSeSkzMHZLmpOyaL781z1OWzV36sey5fwvzdBr8uWMi+LTMv6dJjFYpyLgFNQMkMn
         tsLQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9LxfToSKQCdYJdmZk3xDpYkylxTmRDobydtvbidVWTWpIpMqsRpyi/BV1fNpYxkEo2SMg5F4h@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3054Olbr3Ar1sDq/i3OG8dMrlsgWmK5/sF9vpe2vcFL5bo8hD
	tYu9zf2gHGiHhASoq1VBYXw3zwgmxFr6ZiuCjJiD+ioMjo4ofTZEk6Bl5yG1mLYPw5M=
X-Gm-Gg: AY/fxX689bQ51b5dv1SGxvjZ6qzTXGSwOOgesijmADtz5JA99zRxyv2/ZJuhmw0BemE
	VsRWW38YprA08WOUrc+a8+MGqwFCOfJ1MciIosZthsjsUTcy4U6IjK2TUrkJff7vo+9pPn8kIRq
	fiHT5ZmBrbreaGlCKqLL3ZftCUTmOH5lLosMWs3l9EdtbsesYlqEW2CR7mcz7ADhjHkaMHpXZuk
	/DsX0tcOTq3RX2T7EgIkxsGuwxz3B0eVVVSh1sPFAEouP5OOcIBUglpSVo/XsH4cDZjH4tAnGHo
	gC2m9CQaKl0xSWJbO/8lX1AaWJxWt43GPB/2Otu4jmlGkskpMjsH29AkLdh+R+mkN8uim99T8//
	8l9ReQCAV5GadkFkY2s61RhwcJ/qQSld+I1c0WpO6+eWhHjOClDDNVdIQFn2yzGJyl5SgpXh/H/
	2VN5j5h8PBSw==
X-Google-Smtp-Source: AGHT+IG+jLH00z7Nhn8Cp9IOuvagD88qekrzPMEFtka9A/qLSzJh8fiL2TmBI1HmFYajwZIa0SS4zg==
X-Received: by 2002:a05:620a:4412:b0:8b2:e6b1:a9a6 with SMTP id af79cd13be357-8bb399dc35emr2782868585a.17.1766010439394;
        Wed, 17 Dec 2025 14:27:19 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:929a:4aff:fe16:c778])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8beeba2cd7csm37904385a.29.2025.12.17.14.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 14:27:18 -0800 (PST)
Date: Wed, 17 Dec 2025 17:27:17 -0500
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
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v2 17/28] mm: thp: prevent memory cgroup release in
 folio_split_queue_lock{_irqsave}()
Message-ID: <aUMuRfPVxkfccdmp@cmpxchg.org>
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
 <4cb81ea06298a3b41873b7086bfc68f64b2ba8be.1765956025.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4cb81ea06298a3b41873b7086bfc68f64b2ba8be.1765956025.git.zhengqi.arch@bytedance.com>

On Wed, Dec 17, 2025 at 03:27:41PM +0800, Qi Zheng wrote:
> From: Qi Zheng <zhengqi.arch@bytedance.com>
> 
> In the near future, a folio will no longer pin its corresponding memory
> cgroup. To ensure safety, it will only be appropriate to hold the rcu read
> lock or acquire a reference to the memory cgroup returned by
> folio_memcg(), thereby preventing it from being released.
> 
> In the current patch, the rcu read lock is employed to safeguard against
> the release of the memory cgroup in folio_split_queue_lock{_irqsave}().
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
> ---
>  mm/huge_memory.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 12b46215b30c1..b9e6855ec0b6a 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1154,13 +1154,25 @@ split_queue_lock_irqsave(int nid, struct mem_cgroup *memcg, unsigned long *flags
>  
>  static struct deferred_split *folio_split_queue_lock(struct folio *folio)
>  {
> -	return split_queue_lock(folio_nid(folio), folio_memcg(folio));
> +	struct deferred_split *queue;
> +
> +	rcu_read_lock();
> +	queue = split_queue_lock(folio_nid(folio), folio_memcg(folio));
> +	rcu_read_unlock();

Ah, the memcg destruction path is acquiring the split queue lock for
reparenting. Once you have it locked, it's safe to drop the rcu lock.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

