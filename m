Return-Path: <cgroups+bounces-12326-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D02FCB37D5
	for <lists+cgroups@lfdr.de>; Wed, 10 Dec 2025 17:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B9FA830141C6
	for <lists+cgroups@lfdr.de>; Wed, 10 Dec 2025 16:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE47C296BC3;
	Wed, 10 Dec 2025 16:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="lMNhi+7X"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944EE26ED31
	for <cgroups@vger.kernel.org>; Wed, 10 Dec 2025 16:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765384599; cv=none; b=QC7NZELRYoaV6Ewnsr9xB0adPnIMbmqy30ygLb3hMFtXYz0QxpKpcYWx+wT1rfE5LY2/q8oVz8jcdzIYcULM3awaChkWp49Xwx9HJmozW0SzrgOXRUVpeKe5lviK6mWjaAOUYITwKSlLMTUNn2WWSBjWj18NxVIPmr9w+/N2K1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765384599; c=relaxed/simple;
	bh=jJ1w8aiXZ2sC5XEOtzK057fJgKCo9eY/bTmp3pryYuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X8zJuyOf3GxaBb25xjqOgZtSzKXlZSYVvJGxeNW8YT2JicGfv2ry5Er9zTNu3JnI21wL0DTwk7O+Cyzyg4wdKywYuQxssQ/iEUUhfs3TVKh12rFUqijwykWrTzWnJIjpXyshcrFeXYnsrZDHKnaga+m1w0avBZFndDrFiFk/bmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=lMNhi+7X; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-88859a63001so298826d6.0
        for <cgroups@vger.kernel.org>; Wed, 10 Dec 2025 08:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1765384596; x=1765989396; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p8agRBKmWPH4WtPmE+5IIMo3OzvlggOYwQwERk0higo=;
        b=lMNhi+7XJo2GSnCnIBqCmOa1lgK7cGsw8rxZ/X23oJYYm1ufhHAJPjxkC97RLefAcz
         JUI4htTEedroUXgw0n7oEDRnx+b7NChGEYpb5fnk+cRqpUtA6rkX63N0GJoWsKuQpFWR
         yQ+CL54I0ctb/259k8iqiZNmhcvSUNp2Z7IFTp9P4Bbm9YvR/A7OadmNSgO5ov5zEX7X
         385cGGlltlBYQzDkRm3yyzjCzeVcC6p1s2QtwJ2S0vubEZGcVeAJLvAl/RZHAkviJQ8I
         ujO/vyCsYKNNmylyKORe0Y7nH+eQjAe0+SpA8uVv/iTRMDKHlJiGWEni4MfQU6U6t5ns
         25UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765384596; x=1765989396;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p8agRBKmWPH4WtPmE+5IIMo3OzvlggOYwQwERk0higo=;
        b=Gzg4tiArm9aVYsu4zHCGl3hBbMS6DkZtdMo5h+f7XmLdQOWM+A7DNbUgjDFmM5Hc7Z
         /xSyCKFrpO+NWjavH4cwx6i4LUMaDatTsEDwJXDNUu+RQWX0YoNHiBRvEMDMIAMlW2zL
         e3P0gnbuVHEy/ceApoJ7JoJ385as8Z3XIjao66jpFRTSvyNGko2+ozBd6IenyRVfR6rQ
         CTR4O/eHgAjGSTtG3+B1VhwmD7MmPZ7haZ8zoncH9llQ7/2mJY1s7/3jd0f8+NAjk5h2
         si1JQKgrE4+A+HJdXxZz2Ur+SFzpvyZsFGC7dml2qpRwtsB9XCIDQvTjigMqcmiWHzTQ
         3Q/w==
X-Forwarded-Encrypted: i=1; AJvYcCVo3mJi1vGSB3yYOHO2H/1vOEbmpvrwEe8hRudQe7LQS3lkADRw9ZFfHOOqFDexe0ZEWJOj0jYr@vger.kernel.org
X-Gm-Message-State: AOJu0YyoES5z3nvyEPNiJ/Rq3/bQ8W26WrHwwuAbH5A5ubhKsvJIc4KC
	4awawKsGnSvCkt7Vtm7HMn68ox+cQRtJ5w6qjPJLqKiy1cIT1z3yKNZmLgOh2u7F1AY=
X-Gm-Gg: AY/fxX4bGHySnpKoJ+cGvikQuyoycl4fI4byybHeWPotN3mQvjIr3tjG5nN4BpUvo3K
	GphBsLMlCj0ev6KUTaQQ1KVtSfQMFgQhd6Fm9N5fVZBkfaD+KY5wxEP5SmgOhsZV3nx9y+hiC2Z
	lrgb4omjIQqK3P+SgWV9nbGAQN+KKHVTmoRgNOY1ebjwKOzK7oOKtMVRSILpS+7XMIk4f4BWUnf
	7Sys9rlUUtNrkAKVctoTOUmAGPqGhoBuAIoxcwXvI/Vbr+JMb4DqOAuF5P94NjP7slLZwKvQNzB
	j2UeaCD+rzoOl5Ka4XykJ/0KHYxuwviPYslwUYIxBCcY8ieX2CSSoIW4CZvhPb7AxwpoSxnzpVT
	ROfnO94C/2RSsQeYV5aGJO2hzqZbkQAF/MtLgwZJjS2cRL8Hjxn4GDWKHQQonHCsaRENnLiBrYn
	7gcdjWtA5Gyw==
X-Google-Smtp-Source: AGHT+IFVI/xOKQYJhESjIuCfEpKQpuoNTM6MQ4mD11zbQuJPwB9HOkC9UT6xUK7xl7kYv/i4CQfBUA==
X-Received: by 2002:a05:6214:4385:b0:880:88fa:d742 with SMTP id 6a1803df08f44-88863ad4d22mr43775186d6.65.1765384596326;
        Wed, 10 Dec 2025 08:36:36 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:929a:4aff:fe16:c778])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8886ec54e4fsm993946d6.19.2025.12.10.08.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 08:36:35 -0800 (PST)
Date: Wed, 10 Dec 2025 11:36:34 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, akpm@linux-foundation.org,
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
	david@kernel.org, zhengqi.arch@bytedance.com,
	lorenzo.stoakes@oracle.com, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	lujialin4@huawei.com
Subject: Re: [PATCH -next v2 2/2] memcg: remove mem_cgroup_size()
Message-ID: <20251210163634.GB643576@cmpxchg.org>
References: <20251210071142.2043478-1-chenridong@huaweicloud.com>
 <20251210071142.2043478-3-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251210071142.2043478-3-chenridong@huaweicloud.com>

On Wed, Dec 10, 2025 at 07:11:42AM +0000, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
> 
> The mem_cgroup_size helper is used only in apply_proportional_protection
> to read the current memory usage. Its semantics are unclear and
> inconsistent with other sites, which directly call page_counter_read for
> the same purpose.
> 
> Remove this helper and replace its usage with page_counter_read for
> clarity. Additionally, rename the local variable 'cgroup_size' to 'usage'
> to better reflect its meaning.

+1

I don't think the helper adds much.

> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2451,6 +2451,7 @@ static inline void calculate_pressure_balance(struct scan_control *sc,
>  static unsigned long apply_proportional_protection(struct mem_cgroup *memcg,
>  		struct scan_control *sc, unsigned long scan)
>  {
> +#ifdef CONFIG_MEMCG
>  	unsigned long min, low;
>  
>  	mem_cgroup_protection(sc->target_mem_cgroup, memcg, &min, &low);
> @@ -2485,7 +2486,7 @@ static unsigned long apply_proportional_protection(struct mem_cgroup *memcg,
>  		 * again by how much of the total memory used is under
>  		 * hard protection.
>  		 */
> -		unsigned long cgroup_size = mem_cgroup_size(memcg);
> +		unsigned long usage = page_counter_read(&memcg->memory);
>  		unsigned long protection;
>  
>  		/* memory.low scaling, make sure we retry before OOM */
> @@ -2497,9 +2498,9 @@ static unsigned long apply_proportional_protection(struct mem_cgroup *memcg,
>  		}
>  
>  		/* Avoid TOCTOU with earlier protection check */
> -		cgroup_size = max(cgroup_size, protection);
> +		usage = max(usage, protection);
>  
> -		scan -= scan * protection / (cgroup_size + 1);
> +		scan -= scan * protection / (usage + 1);
>  
>  		/*
>  		 * Minimally target SWAP_CLUSTER_MAX pages to keep
> @@ -2508,6 +2509,7 @@ static unsigned long apply_proportional_protection(struct mem_cgroup *memcg,
>  		 */
>  		scan = max(scan, SWAP_CLUSTER_MAX);
>  	}
> +#endif

To avoid the ifdef, how about making it

	bool mem_cgroup_protection(root, memcg, &min, &low, &usage)

and branch the scaling on that return value. The compiler should be
able to eliminate the entire branch in the !CONFIG_MEMCG case. And it
keeps a cleaner split between memcg logic and reclaim logic.

