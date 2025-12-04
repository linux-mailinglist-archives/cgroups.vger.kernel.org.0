Return-Path: <cgroups+bounces-12262-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 956BECA4F92
	for <lists+cgroups@lfdr.de>; Thu, 04 Dec 2025 19:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4AF4B30EA638
	for <lists+cgroups@lfdr.de>; Thu,  4 Dec 2025 18:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D9834B1B4;
	Thu,  4 Dec 2025 18:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="EQ0lGO+p"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B9D34A785
	for <cgroups@vger.kernel.org>; Thu,  4 Dec 2025 18:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764873282; cv=none; b=YpaAMaXks7xN9fj1CBanZf9goiLUbsx/dVUjqx3BaWymK5nEhH/41kKK4H22ojK5Ahdp282alQsRRHs6IC5eWdo2MWiqAN90+2HJlWqOim6d6ytBpl5IlLhA4V/DOhFJhset/57WuxsP1OC2CVIKwsrSFpN3ryTUj4MHGZ04kHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764873282; c=relaxed/simple;
	bh=Sl3JdT2I+g4d9oYDPIjAcBnvIjn3v6IZnl/P01qHFbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qjJLE2pUmiw2bGDzCAODPBqLeNgexjnptFrVOZQJ2W6dpA6NzSlkJ9uwl8iimDn3toCYsNRmbLMkNAVFy7hdTP6hXzxssJ/rguErwgs2OXZe8woVCnIiAcs/cYyeLWHJYV83TGXdZu3F/g54Ucb8tts+1vxd6+kjFF+mmeZZJxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=EQ0lGO+p; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4ee0ce50b95so21027761cf.0
        for <cgroups@vger.kernel.org>; Thu, 04 Dec 2025 10:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1764873279; x=1765478079; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WKYmIZsWojJAjggwNZPXMCAVL5haYWj0+8meBT5PJDs=;
        b=EQ0lGO+p6PlDkX9bKMhCV2jsK7w9FZLUwOXoM8nJjurmhR/EcxRBTFZXzMPSAZcNPg
         QEpVWRVepaGLh8w7qjOkUcA/Fc7s3QWJYBCZmyh6qb2Y1vnVRtO2jfm7ZGXo11QH20jt
         BGINML54HgdKUuic3foBYeluB/jbNPUDsK0bLpeUoyEEH58UyQCEUiNncf5qJft6024A
         4ig0uM17uhZevq4QsMAjLFB0Rd9i5oG4aYELqtAnHmPTgBbA++9Oh87eSLTDDK5QT8Cq
         d/fDTyPgCaRYw1W6Dajvysq2WTGb7tHOfuGb3phP7mIZxf1mGe1ELbDtiNqHdv5dOUzE
         AWKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764873279; x=1765478079;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WKYmIZsWojJAjggwNZPXMCAVL5haYWj0+8meBT5PJDs=;
        b=QxjmO9wlNhe1oP4DGHH2sDWGoKuvJxTB2mqlfrTuDDbbKgK7gSVWECiB21pkJot4eg
         B1Oh0l+2tMd05NZLUvQ2TkjWYCs5rsp5E9nM3iI0QXmr5TAaZ+TPP94jFVfF3g+lQb7T
         zkQ9FtoYZpEAXjzwjRIBnnwcGafjgsmCSW9rw3w00QBMfPfozzZ83Z5c8ICl9z4uOlCM
         9be4ZyNh/r+rpk3hmi3R5860nv3s1BUBTchJVNF9f8nCgx0BLZl3MlH+DDcNQhmmwQIS
         g0RSMIjwsg4669zXkPur6FPnBgD0RRpaKRqdmeH1YMKcaH+IgnuP4qEloi0Dct8mvJMW
         xqsg==
X-Forwarded-Encrypted: i=1; AJvYcCWWtVKa5GxKS/Pu7c7TDqtEymlHK/llXdGOGlCw6pDu5cQxv72Vos2NBQr3xjkdmNoN5fpPAlRt@vger.kernel.org
X-Gm-Message-State: AOJu0Yzbairm8OhHVN5zNfyLz77xbqaTzd6p4FEdd0kMlPuY2gBSM/WM
	Drg05dV2jofLyTMbzlL5Onrrg4H5Z/eFWweonCVacHy/Px6SgespuSsDO2KAyxj+Y/g=
X-Gm-Gg: ASbGncsah1z0WTS78AKip24HbOy2odCkQ43K3zKxexB3AewjMl/HfG68VbxNq/cPTUM
	YYH8Ej7mhePUDnSOQpuvQXyRcfOfAzswmOW7VEmrL+uyvOOMkBOaKKY6mx326LvDxGV/DsWr7An
	0E8K/WRR7TWWR/IDB3mL4vBM8k8nzxlPFgX3wzbO3AoSEPehs2SnVfWPGaiw7V8jOkFe0Xd42bu
	IUR3v9F965w+4OKCJckPZC9YWE42Nq//4HTeHKSa3O42Vvfxv9Ur+B5WOgrHlsjc1JGJveQjLlN
	nVTwkFXN0GzrlCdkHUkK5Xu4gdeaIHQBFVCCIc90n6hfBcX195H1THMekg27g9Is07dcbUCc70E
	j+bFXFdRKtb6No4nQYsieGiMef3NOUZWT9sdLJ1+0bzD3vl3+4h15WUA9Zk9f/6/nHkHkprMwol
	ZPpI/qU11YcQ==
X-Google-Smtp-Source: AGHT+IHGgi2DcmU0+uMFC7b7WSn6eF6QiweV4Jq/1vc1s9yTnvYaa7EwMPS8bTLYiza1IljUAqQW3Q==
X-Received: by 2002:a05:622a:1b89:b0:4ee:1bdb:a547 with SMTP id d75a77b69052e-4f023085cb0mr70058261cf.14.1764873278678;
        Thu, 04 Dec 2025 10:34:38 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:929a:4aff:fe16:c778])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4f027d58edbsm12673751cf.34.2025.12.04.10.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 10:34:38 -0800 (PST)
Date: Thu, 4 Dec 2025 13:34:37 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: akpm@linux-foundation.org, axelrasmussen@google.com, yuanchu@google.com,
	weixugc@google.com, david@kernel.org, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, corbet@lwn.net,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, yuzhao@google.com,
	zhengqi.arch@bytedance.com, linux-mm@kvack.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, lujialin4@huawei.com,
	chenridong@huawei.com
Subject: Re: [RFC PATCH -next 2/2] mm/mglru: remove memcg lru
Message-ID: <20251204183437.GB481418@cmpxchg.org>
References: <20251204123124.1822965-1-chenridong@huaweicloud.com>
 <20251204123124.1822965-3-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251204123124.1822965-3-chenridong@huaweicloud.com>

On Thu, Dec 04, 2025 at 12:31:24PM +0000, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
> 
> Now that the previous patch has switched global reclaim to use
> mem_cgroup_iter, the specialized memcg LRU infrastructure is no longer
> needed. This patch removes all related code:
> 
> Signed-off-by: Chen Ridong <chenridong@huawei.com>

Looks good to me!

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

> ---
>  Documentation/mm/multigen_lru.rst |  30 ------
>  include/linux/mmzone.h            |  89 -----------------
>  mm/memcontrol-v1.c                |   6 --
>  mm/memcontrol.c                   |   4 -
>  mm/mm_init.c                      |   1 -
>  mm/vmscan.c                       | 153 +-----------------------------
>  6 files changed, 1 insertion(+), 282 deletions(-)

