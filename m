Return-Path: <cgroups+bounces-12321-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 93198CB2701
	for <lists+cgroups@lfdr.de>; Wed, 10 Dec 2025 09:37:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E2F303007217
	for <lists+cgroups@lfdr.de>; Wed, 10 Dec 2025 08:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4442FF16F;
	Wed, 10 Dec 2025 08:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dBFMpPJg"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FB578F3E
	for <cgroups@vger.kernel.org>; Wed, 10 Dec 2025 08:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765355838; cv=none; b=dnGdN8mXBYtbpPXiGaU/DY+z/WAjrzLqvk/CheV4JlmRJt4mZTAjSjt37tsSrht9Jm34XbIl5qYQRuXTWVAjevafj0mfjQjGEAKaOKFcV1F8FbSoMgRuAKMPkkV6mn7T1qcKdEH/jm2ZTwuYiDno2A2KyPBAwFzc7Yko9bnJFCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765355838; c=relaxed/simple;
	bh=UiksL5X31OochykprES8SawsDASoBn+VsyzBoyxYv9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jWgfO+DF3qj3q9gSLuWFtZUK2pDvo28T8hzIBuKhOL5e8HE9VpQTuIxrgRcsUJCoZCF1JmIXIJ7Q+HHhcv/oXIQLmFbZetIRxarrxkFWifOfRuHbiN5cMh2FglZu8D2WEpdF1I43DvaxaUOzTL+9d5ezTrMbV63P31ptLJVP+kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dBFMpPJg; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-42e2ba54a6fso2277133f8f.3
        for <cgroups@vger.kernel.org>; Wed, 10 Dec 2025 00:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1765355834; x=1765960634; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q5Z7LqtWX++TrZQXqb+j50GbpVJl0TfbDa+cwgx1VsI=;
        b=dBFMpPJgwnUmrTl5mB3MavB2KixZ/NOsZtP3Y2NQvIIcesgCbMwwOhpTXv+3QuC1yA
         fV9/sU6iFqDHgJRQq10/H8rvZVm/yBXQTHT26Lg/BZzDBS3SMvYNa7+TtjbEH9KC2gyq
         qfp7Ab6qO/a86bHy9DOL2akHUp7QE1+oLwAMAgag15c1GhVrbP63wq+fy/Wc26B+ONkT
         8QCZXxtY7dXeBliI1+0GquTM5CD3huoFl2WY52YIrL3sKvvTiLAQ5ki1n1F16cJyiuuV
         jK9su5Pw0Dovb9QINX7J1aN9a5ZnXrW5HAr2YQRGJtL2IStzPgvRVzk7b6zUP/0HNtuG
         DCyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765355834; x=1765960634;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q5Z7LqtWX++TrZQXqb+j50GbpVJl0TfbDa+cwgx1VsI=;
        b=UqIc5qog3yZxixF2HhteYLlNRhBCpUVOdDj/dEH5vO6/4dl68FHE268jlDh0Khom5p
         KfuKTZ+U2jjpjIedd7N2DoBEOzpNmpgchvycTWVGAR/Bqg4dKVYwfWkT28v2pEsKIVlR
         6kZBDcnrc/Msbz8iE8lpC5LJZhVxztJgSrmHcvJJd9Jy3XSV+l66QlRpBdOmPLWZWWOw
         T5u1M0QHJqTa1fNZDkiwPcDHqk1B3AY8PaGS2ze2wTA2aUKtl4JdOAkkYusjtt3p76mI
         7SoYsPD79DyBwAvT/NPF2nmdM/szFvDYJyatQSzk7Jze1xXWOu96DnMYhETRygVwkjoP
         Fo6w==
X-Forwarded-Encrypted: i=1; AJvYcCXkBKqqmbWAXaGIUNq13PZaNLu0Sfh+jY6+b7XKXk3lw90xzzWPUJVYkfZB81Ijz0QDSJzfTPyY@vger.kernel.org
X-Gm-Message-State: AOJu0YwsbAPR9I+AedTSgjJFTy8x7ERQJ5KKhMmYlJ8754dKwljHylpT
	heKkZvHTU5OtcBS/PgNqjozJ2M9cYwyMevxnywApv4XmihtMwyrQOZV3u7O+Vq3cFwQ=
X-Gm-Gg: AY/fxX6A1CLpS14JflKSVZJwh9++qGgK+ulJCoY79UJEKZnSf3+Ehg57mqRyDl2DGu5
	lvKH5Hgsfnh+hVwD/s1941NKXUO7A0dt/SrvNPBHSbZlCYkyTvSIe6v3A7lle7rkCdu7n37ACzg
	2TptMiVK+TqjEDFoqzIdDwe5LHmvKz3lb/gVQ0q8k0gDjiCB7y0ICIrAtvy/mnU/rf1qrZXlhQP
	9T0+Jg1+rQmNmWc9vgO2Lc9ne+ET2yuB+Gu55CqKj8qN76vmK7cwJ1feRpVNwoW3EPHNPfc2Nnd
	iSSOCZrbU2eZBoPcJuJJpQlXl/hQNwdB5JCVemsiRp+ckZQliYnSC4vOV2NoqtkE0drkwT3zvMZ
	JPrU9uJvZ3ThRoC4OK8sYyf+Iwv/Og+t34PyVVX8+/atmCvuY08N6RHIADgton5yQDKGtdnF3W/
	HI5jk9HsSjyyd/MXquBY0RJ7/G
X-Google-Smtp-Source: AGHT+IF+0BsDMsiyluvJipcU5buTJ9BVa+hpm1ai1joNB4UB0lSIVLHG9K4VLv9sZg2snNuLroWy6A==
X-Received: by 2002:a5d:5f45:0:b0:42b:39ee:2889 with SMTP id ffacd0b85a97d-42fa3b05eb8mr1389247f8f.48.1765355834307;
        Wed, 10 Dec 2025 00:37:14 -0800 (PST)
Received: from localhost (109-81-30-110.rct.o2.cz. [109.81.30.110])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7cbe9070sm35533483f8f.7.2025.12.10.00.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 00:37:13 -0800 (PST)
Date: Wed, 10 Dec 2025 09:37:12 +0100
From: Michal Hocko <mhocko@suse.com>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: hannes@cmpxchg.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, akpm@linux-foundation.org,
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
	david@kernel.org, zhengqi.arch@bytedance.com,
	lorenzo.stoakes@oracle.com, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	lujialin4@huawei.com
Subject: Re: [PATCH -next v2 2/2] memcg: remove mem_cgroup_size()
Message-ID: <aTkxOJtONChaM8o5@tiehlicka>
References: <20251210071142.2043478-1-chenridong@huaweicloud.com>
 <20251210071142.2043478-3-chenridong@huaweicloud.com>
 <aTkp1tIIiw8Nti10@tiehlicka>
 <9a9abc04-8915-40ac-ad40-2ae67d429ddb@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a9abc04-8915-40ac-ad40-2ae67d429ddb@huaweicloud.com>

On Wed 10-12-25 16:31:37, Chen Ridong wrote:
> 
> 
> On 2025/12/10 16:05, Michal Hocko wrote:
[...]
> >> diff --git a/mm/vmscan.c b/mm/vmscan.c
> >> index 670fe9fae5ba..fe48d0376e7c 100644
> >> --- a/mm/vmscan.c
> >> +++ b/mm/vmscan.c
> >> @@ -2451,6 +2451,7 @@ static inline void calculate_pressure_balance(struct scan_control *sc,
> >>  static unsigned long apply_proportional_protection(struct mem_cgroup *memcg,
> >>  		struct scan_control *sc, unsigned long scan)
> >>  {
> >> +#ifdef CONFIG_MEMCG
> >>  	unsigned long min, low;
> >>  
> >>  	mem_cgroup_protection(sc->target_mem_cgroup, memcg, &min, &low);
> > [...]
> >> @@ -2508,6 +2509,7 @@ static unsigned long apply_proportional_protection(struct mem_cgroup *memcg,
> >>  		 */
> >>  		scan = max(scan, SWAP_CLUSTER_MAX);
> >>  	}
> >> +#endif
> >>  	return scan;
> >>  }
> > 
> > This returns a random garbage for !CONFIG_MEMCG, doesn't it?
> > 
> 
> This returns what was passed as input. This means the scan behavior remains unchanged when memcg is
> disabled. When memcg is enabled, the scan amount may be proportionally scaled.

Right you are. My bad. Sorry for the confusion.
-- 
Michal Hocko
SUSE Labs

