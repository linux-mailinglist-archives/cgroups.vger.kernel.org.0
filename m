Return-Path: <cgroups+bounces-12460-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C36CC9B85
	for <lists+cgroups@lfdr.de>; Wed, 17 Dec 2025 23:34:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C645F303212B
	for <lists+cgroups@lfdr.de>; Wed, 17 Dec 2025 22:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D5732694F;
	Wed, 17 Dec 2025 22:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="oYkKwvSq"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E42308F2A
	for <cgroups@vger.kernel.org>; Wed, 17 Dec 2025 22:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766010892; cv=none; b=T1psHgdYeC/+sd6hD1yitiliQ2YFKAaJus3IygM+uGl94H4g6xe3cVMoIF3SHRtVR/cjYxEJvpv1MYoMTX4XQR3UxkVk1i83dJxL8RDBT0z0ud8cH9v2hJsWqzCqoJ2Uk3ucVg/9j6RSk2jlLhZKaPvm7q0A+ze9d57kq5c4Rs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766010892; c=relaxed/simple;
	bh=Ro5HEKGCAvU/Agf6fuC1Ax+MXVFF9pqpkb1oSERcBNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rv9gh2oDK3S1NJnW4VHTvb51AVJNDVGW3PGH4SYXoOnqkurVzSs9JFZmpAKD1/6ONXMSaWl4sNakbRmWm5ktob5zQOVSBDZxNqHyKW1lnH2GVwEVu4Y/ETneZpl4Lc//O0q2gRvbc0ZKVbjE/S5aS3Cy1wNMggaLzzmg649LmQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=oYkKwvSq; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8b22b1d3e7fso2190185a.3
        for <cgroups@vger.kernel.org>; Wed, 17 Dec 2025 14:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1766010890; x=1766615690; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hvYaWzPPdrJtfkJUMIbw9W2hBZKRUblNNmvifflj8gA=;
        b=oYkKwvSqSDYewZnA6hGdfwUU3B1uZ5kdOk9/rkO8pxW35IT3pZHnsd/UvbrzdoFJ4s
         Kia0r63ROLj+O3E2JtlPdTbe2DkizjPKMNwRsVALj1B+q0vmnihIL0J880KiOGIItFlw
         W/I/LJViZXfAXlKcAv5r9yugrINUF84hBs+8oZQJUB31SHYIGT+wv2ZlI6IBM3/VaTFd
         mTiMGk6DdtvF0y+5E+9JDKkfBX7n5+hIKRfLss5bGqvlmbJoPERT/TUtZROld3WFZQa8
         ZSVXRvkyZXOHV8xitsPqGy7sBnqxVW7VswqzQtgsZnzaSZ3ASOSJhKcKjSwX+FcDZkr7
         WIcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766010890; x=1766615690;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hvYaWzPPdrJtfkJUMIbw9W2hBZKRUblNNmvifflj8gA=;
        b=qfVC+Kw1EOlOaRHBSnYLszo2Q1W0hUvFf34hz2VrN0KjKg5goo7LIAJGTQA+WmQQuU
         wxLxHfY9FOYtVYORTVVDQNyQ5QeGeOGRtCP3a3+XeTmKtK9fSxPhE074L2tAs9rkzHTV
         T88oom4rHvw5hzjEGTeDY4f3raMx6g4XGrH3mj6CSk/tTE/dKXpPQUjRNL7EnztQJf2Z
         uNp9CMaI57ayI7Mj9SeYJ1CNedXxWQ+fY6soCEGP1BzabXP+y5iDIEGcuxH7DntphAB5
         cBIAWF7ERmKFpOS/lStMeOGisSrk51TmZN/5mp+l+MG2FnkW7Loz6bOr/GM8WVlRdRSC
         Nu8Q==
X-Forwarded-Encrypted: i=1; AJvYcCV+05ExFcjffaboVKP/xUf9dy76lMMc3LZ9fb89Bva5eiBVR7zjLmV4zeKxNIxbQePdts+CUDXV@vger.kernel.org
X-Gm-Message-State: AOJu0YxyJRgpGqU/mmc5+pyOLOJW7a7G7uhbHIbj5oj0Yw/9WwSquYAS
	G5r6f/hiBZDYPTr7AiI75fUvSF2qDBQb8abJxMMNlWWdjSBiAbGtbIu0gJPRAiJuhjA=
X-Gm-Gg: AY/fxX5HfQsE9TTRroYpXBgbBUWdJ1L8ApZfAT5/Z3/yuz4Q5DwFBvwxP9qar6Rl5MJ
	tDc1MFe299IPIhQYHQtQXJQ3jKiLhtcdRIekRmlSGQjvQtFJqQ1mVcK4yT8vJKZ5rGY4b3nX+Z/
	txRYBjI2aCbOjmfD1AKKCFrqCo8+vt3ZzFCF3It1NGve+CsBxtmUscz/Q3YU5rbF7c7X/JNeogt
	Ao74o59ior5RBORT17uFt3wZ6gAFbfhBjqtU3G9fcLJBpTI3qJ8mbJd7Wnwx2+uO7LOa8Wg11M9
	1xAZ+rCrLREjXEV8JWlbrYH4lWKQ7d3tX/noHWs9wxnR7sD8gBC9rwBY0Ri5sQVYlE40diolm5A
	BL4BkTS3enAqoUTPOA68RI69+Qze0Jxbs/yg8AR9jDcdqDdljccaEsNlC1Lxkp7ffW/EZkIpl1D
	HOvqM66BWl8g==
X-Google-Smtp-Source: AGHT+IGZsFVv6Cr36BxWCjVhDYrl4CGTwr9tOLKn/N9bxObB1v/vFjg3HVjrFrIuNreEatCVr4E83Q==
X-Received: by 2002:a05:620a:319f:b0:8b2:f145:7f28 with SMTP id af79cd13be357-8bb39dc4d2dmr2734359385a.33.1766010890047;
        Wed, 17 Dec 2025 14:34:50 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:929a:4aff:fe16:c778])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8beeb5f2974sm39870385a.19.2025.12.17.14.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 14:34:49 -0800 (PST)
Date: Wed, 17 Dec 2025 17:34:48 -0500
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
Subject: Re: [PATCH v2 21/28] mm: swap: prevent lruvec release in
 lru_gen_clear_refs()
Message-ID: <aUMwCOj5aDo5Jmxh@cmpxchg.org>
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
 <42682f81686e31019504a6e025fa08d2c9dea718.1765956026.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42682f81686e31019504a6e025fa08d2c9dea718.1765956026.git.zhengqi.arch@bytedance.com>

On Wed, Dec 17, 2025 at 03:27:45PM +0800, Qi Zheng wrote:
> From: Muchun Song <songmuchun@bytedance.com>
> 
> In the near future, a folio will no longer pin its corresponding
> memory cgroup. So an lruvec returned by folio_lruvec() could be
> released without the rcu read lock or a reference to its memory
> cgroup.
> 
> In the current patch, the rcu read lock is employed to safeguard
> against the release of the lruvec in lru_gen_clear_refs().
> 
> This serves as a preparatory measure for the reparenting of the
> LRU pages.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

