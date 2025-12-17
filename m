Return-Path: <cgroups+bounces-12455-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF95CC9B1F
	for <lists+cgroups@lfdr.de>; Wed, 17 Dec 2025 23:23:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 677F2303E3F6
	for <lists+cgroups@lfdr.de>; Wed, 17 Dec 2025 22:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD52D3115B8;
	Wed, 17 Dec 2025 22:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="iSrhK6kM"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD454223DEA
	for <cgroups@vger.kernel.org>; Wed, 17 Dec 2025 22:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766010221; cv=none; b=L/HuN4xT+u7UcBxhjRmOWMN5LVjl3aOYKrrCGNRGWc4BkFUXFAbvYVD3TXIX7AHHBrtNpC/q84McpQT6Sbf5h81AmalUF7JeXojvJ0iaYlLoj43QzBWH8nixnZSR/mXfSrGhfwH8+o5XFSMHpdYsWa1ufrSd6TpBawDgbE7rU9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766010221; c=relaxed/simple;
	bh=7DkFJoF0G9hKw2J0EirtCFbMow8bVpd9GWrKH62O0NY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ja66pWJ+ulnXFZoPBanS5Ku3oxdOH9zlzMl0USFoTAuDPjK8nxOK/sN83j4Md+xR3pyLw+jeaYzKS6GPFvIB1ndao/e/ZiW/VmjmpEhwxKZtLX1Ay55e/ADjLhIHUkxIbW5etpzc9q5fr22tjJQk95Y0BrUeMq5tjrE0AadYJgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=iSrhK6kM; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8bb6a27d407so2212985a.0
        for <cgroups@vger.kernel.org>; Wed, 17 Dec 2025 14:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1766010218; x=1766615018; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ialel5HFQhh2Hs/dEsLq3bsC4I7cFx6qt8O4tFD/kZY=;
        b=iSrhK6kMi8Qs+JB5KoStqLqWx2OXj/zHDdfsdKAKjDBWviOwLKIFt6qVS5uj9+mMLf
         aLK03XFc9IdQkBJjtRiGwNxwbql8MxZTOFP+1zPwwwarz9zWkLPDg5GY83OXSn9L3xq7
         1KtzX43prmsKPFDCh6FlqH5rM+QqvPW5v2n5BNy911lgrUCqxcBbI9iG3wuFr+jdYy15
         7dpHslJCCNWTvxMwPkoa9CqMrHV4HFLKK9xg6xv+81kssqydH6vK0D7WKrRTCzRgnamg
         OSSMGq8iy5TnMKBWetoYRuSCDFf8KsIbDgPhlC17+b/SvgT73/XcrjnzKUeD5siVjoT0
         4OAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766010218; x=1766615018;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ialel5HFQhh2Hs/dEsLq3bsC4I7cFx6qt8O4tFD/kZY=;
        b=wdI/xzxHY4yxEGNmJHrcPDLnlAfob9i1OIJj7fubcsAgbW4Tn9H6o1tDsMpfcGIP3K
         pJzVrU97/jbV2SYuDjkMqAOdn9oBH/aDikCenQKnAIogIY5fFUj2J1wjDI2JGuRHfa4F
         hC4LljRcoTqnkHKkHiAUxEztwNvmwTCMbINoEGFLlGdRepo3/ZOR45xNgmIPdkga3IHa
         gYB0nAn3ZfMbLgyIpDKcvttZMI65Z79R4iHudCU7wCF/aStDkYUvq6xVK1BygfFe1MSR
         jynFHm/jdjkcs7XnpOAb0/3koohuOuxP9ljKeKZl56KdurAJB+5nQgtIhxbWxk84a1/h
         d4/A==
X-Forwarded-Encrypted: i=1; AJvYcCU/P/0tCV2QLYiFoWtPgEQmUwHC1l+avWBz0k1uBjSTrwaZzRpe1J1WLjwAK5k65l2n1D1zb7hZ@vger.kernel.org
X-Gm-Message-State: AOJu0YywVjANcXZ1iYrJU0XA8dHakeoRJ3u8+vHEmKrXFezq0KATrzf1
	SoEAOTqkwodG35gMQ5u6xfGau2hYgjifPaR48gT5nYOlghkT5aiyUZwzROKLf3lq7U0=
X-Gm-Gg: AY/fxX7Hke5nVR5V17wU8dhkNcUo9zYB92sD/eXXxd4Lt+HNTBPrr1uxQzMAGG+ecJv
	vNDm9Fkci8SHgVCMJnmwC1pbGWnj8pFFKnth3SygQiFALGmCK6G3kRJGkHm4U5c/Ddu3+Te3lhs
	1VAM+giJp+M7mP0mS59f02G1FO1vyy7VJ/9C9C/sVpRs1FApib1vuU0AL6oy9xmkSqiF7RoW/OB
	nrTdRvEbAoBc+J6J9TOnEvhqTaOu3W2mCExUKkXZN/wgVVHwipKYWa719pZw9DBlNi6OKD8gCg2
	8XLyz37OMmXgicwHw5QcMBShtl0FpLEXRrIhuWw7weQYEbW7pYGoGLRRGVKmP3Rn8NfOk7miyU3
	ps82SzN8fA1ZIPtHz+EwZ2YemND6IP9o94NSxJDnrCUsoYvAgGV4GzCR38OiCywQiJDo3VoKqDc
	SM1CFCKk33xw==
X-Google-Smtp-Source: AGHT+IFLj5zSyMWH1DU+HU4kh5upIQXL7c073Q7ukSm1uBP6f4OKMTG1DoPUCq8OYLFaEqdy3dOhPA==
X-Received: by 2002:a05:620a:414b:b0:892:90f8:b59d with SMTP id af79cd13be357-8bb397db77bmr2800409185a.7.1766010217662;
        Wed, 17 Dec 2025 14:23:37 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:929a:4aff:fe16:c778])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88c6117f54bsm4237146d6.45.2025.12.17.14.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 14:23:37 -0800 (PST)
Date: Wed, 17 Dec 2025 17:23:36 -0500
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
Subject: Re: [PATCH v2 16/28] mm: workingset: prevent memory cgroup release
 in lru_gen_eviction()
Message-ID: <aUMtaNfU7jd-kIV4@cmpxchg.org>
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
 <86b0573753db20e40315c61f5d6e01bdc6a8313a.1765956025.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86b0573753db20e40315c61f5d6e01bdc6a8313a.1765956025.git.zhengqi.arch@bytedance.com>

On Wed, Dec 17, 2025 at 03:27:40PM +0800, Qi Zheng wrote:
> From: Muchun Song <songmuchun@bytedance.com>
> 
> In the near future, a folio will no longer pin its corresponding
> memory cgroup. To ensure safety, it will only be appropriate to
> hold the rcu read lock or acquire a reference to the memory cgroup
> returned by folio_memcg(), thereby preventing it from being released.
> 
> In the current patch, the rcu read lock is employed to safeguard
> against the release of the memory cgroup in lru_gen_eviction().
> 
> This serves as a preparatory measure for the reparenting of the
> LRU pages.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

