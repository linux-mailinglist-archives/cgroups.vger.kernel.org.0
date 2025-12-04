Return-Path: <cgroups+bounces-12261-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C68A9CA4F0E
	for <lists+cgroups@lfdr.de>; Thu, 04 Dec 2025 19:29:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 308233009636
	for <lists+cgroups@lfdr.de>; Thu,  4 Dec 2025 18:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595ED2D5C61;
	Thu,  4 Dec 2025 18:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="lxeQUoo0"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA308277C81
	for <cgroups@vger.kernel.org>; Thu,  4 Dec 2025 18:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764872940; cv=none; b=HmV06nn682DFVvlbVFOdrrJOZOGpHvePJUy1N1HflZ87vlFz8Mcq2b2K/dDHfl6mzmVTQHSQu8prQWc6wcgvy29cfr+u4RxcuFCLjh0hTMyerP55yJ6EwA2SR3G3wu9LFPv2QWd5x1hHr/mK2K7Md/jaIUxmKobWYNF6QSpu0Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764872940; c=relaxed/simple;
	bh=5GqhyZT6Rt3PfQ/6GKSyzDj33c7nIyXN6+SMU3m/DgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lhrmUltWMewMNEYCWIJgYscpu8uhE69SUPAMPThJoNM9Zoobv6maE3AvTzgVRQG+m8d9e3UnBAD1JnS8cJ6g6vXCczH0N5cr1ngRXG4TjZ9dFr6+aSogBydp/28T7reiaEEyX4EtTN6yoWleA6ZSDlNJJSDW3CNVVA5nbQCX+Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=lxeQUoo0; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4ee1fca7a16so10854311cf.3
        for <cgroups@vger.kernel.org>; Thu, 04 Dec 2025 10:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1764872935; x=1765477735; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EbYKo00Iv7GRqeuEurZ+VNuUOvRrRabNx4MSyyDcnsw=;
        b=lxeQUoo0LyPiKrmh97mRwEgczR4+misUTNkh0pxOPHRfbrK/EHBeZnNl0I6yN4X+47
         uJMn9LxJgIg22LlikYUugDNSvD9TjiboVdGeHZDTs++B7vx70ndQM4gSlQ5RIlpGaYI7
         T6Kc+AydSZF6QKn7kVcM1eEdgYukQp6THfVvCpq6Rs4zsqXzwa1t3LVhLAu7AunT3S+r
         m+gmiqnkAwSSmSc14eYRd2/pgcM0HlZ7QJV833wI1raGmVnCc2Z05q9aBcRJjDoL7OyY
         R/IDiZ0gO80Iq5TFfBo1oaU74bJPGnBfFY1vehLQTLCaCSGk6CxXW3fdvkrKyNVO/rn7
         noeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764872935; x=1765477735;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EbYKo00Iv7GRqeuEurZ+VNuUOvRrRabNx4MSyyDcnsw=;
        b=RSOnvhEke7POpx0PvxczpSKV64clnKtIJFvvT6BHRWuvblRq0/iQLF+SzWm6la7M/N
         pmlmI3JKwZknglPkgep4+qBDuiT05uNj0xU1EN9DLjCV9tLpf6OHC8SMHQztdvcdl8Q/
         H8fyVo81JXbFlYTXVNgi5E+NiZWkuo/FAG8SVMs883fHdQr6gLlW0GbVT+aWjo1khYe7
         LxrZZdFEG+5xZkxlh0vUc+Gyq5QhaPiDXJQA+5uKJJ3ZUMDONJDj/OLVyjaerQRl/O8D
         OLOTaJhHHnrZ1x8+tl246UCXvYF6Wq+guK0PHsar1PY7/u6k7aWf1ChIAeRD0Hdck1AK
         DsTA==
X-Forwarded-Encrypted: i=1; AJvYcCUxysM60fogB35SSBVUij+owircbBYD5oIVts37gl7pmGxHeJkcEUnH2fUKhtDsco1s70VpFSuO@vger.kernel.org
X-Gm-Message-State: AOJu0YxztB5jGdk5zjOFZRSPqlIEAn9yt1QFoYgakESJJ13RlAqj8sdc
	qcQblARQgIGwiZ3ROERQV1JrakRQbmCEDu4dY18PWzREOZQCgsHW7EgcJmmChEsjgUo=
X-Gm-Gg: ASbGncsWRQ+YZj7V2Mhcy1dQkjXrRY7P05c3g0whjgP98kn77eMX9ErL6bFShvXIl95
	x2R97SE4AX3i79MSnw46Cd32eHgNgZdXqazlYAp6vpZkURQ86RAqoP2gckVL3CLmr0bKuy6XfGY
	Vu7bWyadVusPo4kX1dodh5hsviii89RwDG6/LgiZSTxup3t4dCBOxPlhbSP8PxgdjIvkAyUoXaG
	/G2qoVFCzkOu7sdcEBgeD0m8fv/nr7NQTXw196Wj6+cuIYy7I+tZ6Ph60/7i02sbGJS/dbB1UJr
	2lfFgeTI4B4q4/DBeJJ47Dqtb2PbuFckHKwKrb5m4cqp2WRIIaI8INVqDy3yLIcpovFbGBUgp7x
	9Qhih+6WGrvY88XwqZIlPDepi5GhMvGNHAh1EdOkKwjzp0EX9DrZL79yIV1Puj4Kh0ZEPMqwHoD
	R0RiNpyE7W82Eami61onu8
X-Google-Smtp-Source: AGHT+IGZlFZPSAeM4UXQLHs00EEi+GdYO84wd6mPsj8XuMELP7WRFAZg4UDdzJCd4HZJh7eQnkG5Jg==
X-Received: by 2002:ac8:59cf:0:b0:4ed:e5c1:798 with SMTP id d75a77b69052e-4f023a08b64mr52873691cf.35.1764872935525;
        Thu, 04 Dec 2025 10:28:55 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:929a:4aff:fe16:c778])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88827f49e51sm15291736d6.15.2025.12.04.10.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 10:28:54 -0800 (PST)
Date: Thu, 4 Dec 2025 13:28:50 -0500
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
Subject: Re: [RFC PATCH -next 1/2] mm/mglru: use mem_cgroup_iter for global
 reclaim
Message-ID: <20251204182850.GA481418@cmpxchg.org>
References: <20251204123124.1822965-1-chenridong@huaweicloud.com>
 <20251204123124.1822965-2-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251204123124.1822965-2-chenridong@huaweicloud.com>

On Thu, Dec 04, 2025 at 12:31:23PM +0000, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
> 
> The memcg LRU was originally introduced for global reclaim to enhance
> scalability. However, its implementation complexity has led to performance
> regressions when dealing with a large number of memory cgroups [1].
> 
> As suggested by Johannes [1], this patch adopts mem_cgroup_iter with
> cookie-based iteration for global reclaim, aligning with the approach
> already used in shrink_node_memcgs. This simplification removes the
> dedicated memcg LRU tracking while maintaining the core functionality.
> 
> It performed a stress test based on Zhao Yu's methodology [2] on a
> 1 TB, 4-node NUMA system. The results are summarized below:
> 
> 					memcg LRU    memcg iter
> stddev(pgsteal) / mean(pgsteal)            91.2%         75.7%
> sum(pgsteal) / sum(requested)             216.4%        230.5%
> 
> The new implementation demonstrates a significant improvement in
> fairness, reducing the standard deviation relative to the mean by
> 15.5 percentage points. While the reclaim accuracy shows a slight
> increase in overscan (from 85086871 to 90633890, 6.5%).
> 
> The primary benefits of this change are:
> 1. Simplified codebase by removing custom memcg LRU infrastructure
> 2. Improved fairness in memory reclaim across multiple cgroups
> 3. Better performance when creating many memory cgroups
> 
> [1] https://lore.kernel.org/r/20251126171513.GC135004@cmpxchg.org
> [2] https://lore.kernel.org/r/20221222041905.2431096-7-yuzhao@google.com
> Signed-off-by: Chen Ridong <chenridong@huawei.com>

Acked-by: Johannes Weiner <hannes@cmxpchg.org>

The diff and the test results look good to me. Comparing the resulting
shrink_many() with shrink_node_memcgs(), this also looks like a great
step towards maintainability and unification.

Thanks!


