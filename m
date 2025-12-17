Return-Path: <cgroups+bounces-12459-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 85926CC9B7C
	for <lists+cgroups@lfdr.de>; Wed, 17 Dec 2025 23:33:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C716F302A3A5
	for <lists+cgroups@lfdr.de>; Wed, 17 Dec 2025 22:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB673254A9;
	Wed, 17 Dec 2025 22:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="Tc7sw1Dg"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA0E296BBF
	for <cgroups@vger.kernel.org>; Wed, 17 Dec 2025 22:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766010795; cv=none; b=ZB6rBTQiiwPuVs2Mi1LRO112nOpQEkU56OFbYofrGswbrGPxRgM82erXImEc+93MUr5FdeydnG5N+rM4njM6SBv873Z/bv6ysfaGmz4U3zgeabd+ixkFqAUdEN3cD8bfSTUxsnWO7g60MackMG+qxdNeFr4mdAaAyngZ1KmQXHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766010795; c=relaxed/simple;
	bh=NKXQb+JqGtI2KGj6YMEHWWSmUwcGPTWm0sN1bx1o7eY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J3iy1sRhdOpA24WJTvacq2FAQlVnsFEjcjb+VQCWtyq3I5NPPoMhRirs9AZKXYUh9lTC9wSogUeJtofpeMc3Bd3pYIV1ntb5HE/8skTqLyLiqsxSO3vDL7WR3NbsZ+DJ66ryNwt79Z2sEMJnjlaMLbKgOhbW4SM02ndgS8bMWys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=Tc7sw1Dg; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4f34c5f2f98so22981561cf.1
        for <cgroups@vger.kernel.org>; Wed, 17 Dec 2025 14:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1766010792; x=1766615592; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X/0fSU7byX7H74M3pGZ6ch52/NJ8dJexMYfTnz06pjc=;
        b=Tc7sw1Dgk+ObHV2fFldcr3tOJgQZw4pSEo9CHkqGJceI1I6xQvYFQSmqA7zIl3FXI7
         nS9iwQWGyR/BcJvJUOuaoG9NYDFTpt6O59FW+PPXl8W9nKSRJahVxCnytX2Rq7seewD0
         s+roUoCmDuGfXUmpIl4dcJD3G00bRlp7mOJt2x/R9rGxbDCl1Vr9bkYceBtwkQdwIETt
         VyFvoNLI7RPfmzyd7Mpo/Ie2cYvjvmbBcBfKBPzQmqedYcx5r3BGK+oI5ymkjIv3j8kh
         OuVyoyUum6i1F2EdcilhRfal38WrQA+lqSICWGOsTlutXcUiLSa3n1SV4dzDBX0hJrPk
         6LNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766010792; x=1766615592;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X/0fSU7byX7H74M3pGZ6ch52/NJ8dJexMYfTnz06pjc=;
        b=nWW3kKKhDl7dr2SPpRBzBSVkJH74A3/ENb9AEa40SmdHu/FI2SCdk0CtBws/2ccFsJ
         UdBf1LfAacXtCfAzS4onsOkYa+NxFeOhP4Zhmv6yGBY6zi/KHx8kyIq6Bnfj+EaB1iAi
         jrLkc98JbRTxoHFpBdh2R6zzbtuc7JQ2OdMZXoQVkGovorcNOLZerWOTokBFNGtw+b/5
         4bQgP5lz11COZxcHdHX0HJR7xAWUHYizA8+jJ6C/Jq1oFsT7hAYdpYzJTDdF0N14Cws1
         3BaHQ+h8exNALgFJ7c9Rn6cIDCty555sNi5CoXzuRrpDgPqKVNzzddDOnMpAOvL+Ui0R
         kMSA==
X-Forwarded-Encrypted: i=1; AJvYcCWct2wS4L5TiOIxYW7CkkYJQt09H39jIhTIgPuLb1yJ96uEP6ZB3eRLGzC6XWZmTHtOjHp+/vAy@vger.kernel.org
X-Gm-Message-State: AOJu0YwFFjwPkS2e5ly7a2AKn2BEs6ApvsJg5sQZgsyqGKcK+Cp7hjAd
	wDP7pY5ojt3BHFUT7YirJJjTjALevjxzM8LSV0neZmhzwMUOMAsuzoHuwTDTFA1m4RQ=
X-Gm-Gg: AY/fxX5iM0KCF8F0G/Wdt2sFHKVpTGrcjMDfvweE9F0irV25bkfdwA7S4aSE/1EvCRJ
	aIDWXQNDFOlfs3lnU4K2P3FspY41GMN1LqaPPPaGLZGvXb27n5cWgd8QhzWB6f23fUPY7UWX65p
	UlvqNdJtYJTzTkgmFdbktcC7CjxRZwfB50qZbJKD84aTvc8skPL2EN9DU7CM8+lUcuvoW/QIbjo
	BS9V/a8yqz+17z+/v0Zi99D9kp/RUSFvVQrgyHRuJu56SGmPO52mHXYOx4OvQTd8URvvqjReovE
	G1XOQZYjd4kCi9GNGOL6ngIP3dE+94RJIjO1JXw7YHvHwWRfurJ2bkTl3M5fNjsRQbtZ3hihEHQ
	CejSgcv2PPiM6gSG9GZYXJKqIKNntZ2l1efS5MAtJEbmFsD5xzNIKTRXAJmhndkftwhpPoTa9hF
	fs7l1UyZ6g6Q==
X-Google-Smtp-Source: AGHT+IF7/FSEL/FL21mefzRD0FNnIqW4z7GJgpKznrwLCEpqc+nHhV1if9CL8B9ObJ8hxVZ+Dp1jnQ==
X-Received: by 2002:a05:622a:146:b0:4ec:f697:2c00 with SMTP id d75a77b69052e-4f1d059e3f9mr279660781cf.42.1766010792438;
        Wed, 17 Dec 2025 14:33:12 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:929a:4aff:fe16:c778])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4f35fcb439csm3688841cf.15.2025.12.17.14.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 14:33:11 -0800 (PST)
Date: Wed, 17 Dec 2025 17:33:11 -0500
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
Message-ID: <aUMvp5WzDp6dZCVr@cmpxchg.org>
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
 <bd929a89469bff4f1f77dbe6508b06e386b73595.1765956026.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd929a89469bff4f1f77dbe6508b06e386b73595.1765956026.git.zhengqi.arch@bytedance.com>

On Wed, Dec 17, 2025 at 03:27:44PM +0800, Qi Zheng wrote:
> From: Muchun Song <songmuchun@bytedance.com>
> 
> In the near future, a folio will no longer pin its corresponding
> memory cgroup. So an lruvec returned by folio_lruvec() could be
> released without the rcu read lock or a reference to its memory
> cgroup.
> 
> In the current patch, the rcu read lock is employed to safeguard
> against the release of the lruvec in zswap_folio_swapin().
> 
> This serves as a preparatory measure for the reparenting of the
> LRU pages.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Acked-by: Nhat Pham <nphamcs@gmail.com>
> Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Btw, it would make the series shorter if you combined the changes to
workingset.c, zswap.c etc. It should still be easy to review as long
as you just stick to making folio_memcg(), folio_lruvec() calls safe.

