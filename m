Return-Path: <cgroups+bounces-12450-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A5159CC9AC3
	for <lists+cgroups@lfdr.de>; Wed, 17 Dec 2025 23:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 726D13032A85
	for <lists+cgroups@lfdr.de>; Wed, 17 Dec 2025 22:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6F330F957;
	Wed, 17 Dec 2025 22:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="LGEiboFX"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB02279792
	for <cgroups@vger.kernel.org>; Wed, 17 Dec 2025 22:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766009477; cv=none; b=Qm1FiPjQvkNAFB6BT6dpwbPQjh6KQLPH6zLlY1NYGkwtb7NNtz/rkTSZvC5wB7j1XREv676ju7AKsxnxgmY59f/+svFCMSV0cBbBJiMr8CG3g7XTrcllArw5F/6KgEgFw5ymuNT5uzkl6PbwNaSg6dU4BhjZRu2sOR/oCfmj26A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766009477; c=relaxed/simple;
	bh=iV8MRcfwNmAkjrVMn47Mzn8C5NE2rw/1NmrRo0Y9RJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UyKYiwRQz8RY1QDizFcCDXT+CwjJKOiHpEQRbbmbwNLhSmBBex0FKQScLVrVTenq5D+p7fXKCOcN0I4qt2WH7+sc9PeWRGyJQ0i09rnVXqRXOK603TCxW8uTgaANKwhXRjs+Z5kUFe/PmNsi3ASl++j4ghUIZKz9VJbOEcAQx14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=LGEiboFX; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8b602811a01so897685a.2
        for <cgroups@vger.kernel.org>; Wed, 17 Dec 2025 14:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1766009475; x=1766614275; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9EioNTCwqG6qzkEs2QnInVjKzgqwIpqmQRuJzuIdBCA=;
        b=LGEiboFX2HCE/Ut3ieVjzKqtuYQIsQGWrzts0OHkRHJnvZGDqcM1EwH8JoIIQkEkS0
         2mBvYVYYVzNHdR99cpmXtahjXP6pHf/jASXLWpCOEeTYqJ7kawfyHs6brGt+FyqIwr5/
         WfOJFVWYJpqiWl1dxlNfTleHpsRzG42/rOQQPc1EC3sX2ytq/UgBG9fS9Rn9dhDAxVMb
         cUGAAV3W2m0bcjFKUNSI3m/hLG1UMZDCIGNTQXQtLzHs0YUOKgt+A2zHA2apDWt2w2Dq
         HzMq9fPwAZWomkRFe56wDssrNCGWrqhnvVvwWKeh38V+l8FPlryRCpHwTyJ2h1FD9JPz
         PRNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766009475; x=1766614275;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9EioNTCwqG6qzkEs2QnInVjKzgqwIpqmQRuJzuIdBCA=;
        b=WK+FFcxzxY+6xYQNolLgpORuWcWe/5wdrAeiuYYdSrIgTls+t1HnKwV5SRrkUVuaLp
         FUglQ2nVzSSxXmWDzN4gl9LJRC6VTqlWx1ZuJhideok4CwAypWSI7arJ+HZnE6TS/e/a
         g3l2WtXNz2syNXHEgcBubS5wYVWBL2hKu7UIth79DOe8Jd6TTKLHeNA3TF+HRyZicUgU
         lhQyRVdlhusY8YxRNao2bRUkRZZpkZjBRxL8z1sS7zOF/8iPIYly28MMRii6g2sGABWq
         n//tySFV2p8XxrAblweja3DL/Q4vwrFFZInKSP/Qgx1Z7y4cprUzPA9J088b2nYWQdaT
         kXZw==
X-Forwarded-Encrypted: i=1; AJvYcCXqkMSEsjdQPtrQNvtKO3xFqiGwtb03Py6ia0APwVISLxm71GceZL5anANVCAw0AO6NohUCRe4M@vger.kernel.org
X-Gm-Message-State: AOJu0YwUpCsXAeSq2ELuyz/NI5mSAdPiVkYvizkP5qoVpP6bVJOXI22L
	QsC2w0PeUuHFt6EJxVSh1vYHpVgvf/cx7pM6tzfYFEW8u93aGjH1QZmghgtLeTWDTAA=
X-Gm-Gg: AY/fxX6v8Dsq39tk0YkDjjWzsv5B62tMxdP2fcbMkPiRIOCoz/0QRvDj4XXvK5NNUVq
	YZGk0T9MjS6RSRKBtD/MPYXyK3qczCmtokXyzOoWXBlX2y9LO2+XeVP5B1aT/2eMCOUi4rL7UML
	NsdWYtQAAGwWDlQ4oRGp8NXGZClCvnly2Oe8pgX8ZwsaWmUo2jpmiFO+xW4/hlQcK8BdaCCzBET
	RuSzKgtm7EFQ1kYWz2N55btIE4a9ko9nsA9GHL0mJsO4jW5599OxHIh3pUVa2iFyCekIT9hb50p
	9bUIWmR2dck3+aaX1iJFY3ZMOPAvXg1QoxjxX/03yKNQE4njVd/fq05K031Lx7RunXqiZ4g1kuK
	bacD+20pVUq4hBVqA6AabDf/iQ7baFVaqaWf9/5uMvuG4Hjt2vTgMMwyBCyYlebauUZqbNDRHvo
	RMTcsi2LMhpQ==
X-Google-Smtp-Source: AGHT+IGgyeULS2yL1kyDxa/tHi9+lstEdnmTR5Uj0x0lP635FqQGB11Q0kiBfEr2i4WUd1NmFkRAWw==
X-Received: by 2002:a05:620a:28d5:b0:8b2:ef5e:d27e with SMTP id af79cd13be357-8bb3a2776c0mr2800428385a.51.1766009475409;
        Wed, 17 Dec 2025 14:11:15 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:929a:4aff:fe16:c778])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8beeba3c1aesm34819685a.46.2025.12.17.14.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 14:11:14 -0800 (PST)
Date: Wed, 17 Dec 2025 17:11:13 -0500
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
Subject: Re: [PATCH v2 11/28] mm: memcontrol: prevent memory cgroup release
 in count_memcg_folio_events()
Message-ID: <aUMqgeBerdUChV86@cmpxchg.org>
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
 <5f8032bc300b7c12e61446ba4f3d28fba5a7d9d5.1765956025.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f8032bc300b7c12e61446ba4f3d28fba5a7d9d5.1765956025.git.zhengqi.arch@bytedance.com>

On Wed, Dec 17, 2025 at 03:27:35PM +0800, Qi Zheng wrote:
> From: Muchun Song <songmuchun@bytedance.com>
> 
> In the near future, a folio will no longer pin its corresponding
> memory cgroup. To ensure safety, it will only be appropriate to
> hold the rcu read lock or acquire a reference to the memory cgroup
> returned by folio_memcg(), thereby preventing it from being released.
> 
> In the current patch, the rcu read lock is employed to safeguard
> against the release of the memory cgroup in count_memcg_folio_events().
> 
> This serves as a preparatory measure for the reparenting of the
> LRU pages.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

