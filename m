Return-Path: <cgroups+bounces-2690-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC938AFFAE
	for <lists+cgroups@lfdr.de>; Wed, 24 Apr 2024 05:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59E33B22665
	for <lists+cgroups@lfdr.de>; Wed, 24 Apr 2024 03:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B52139574;
	Wed, 24 Apr 2024 03:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nwjez3Qj"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3956C13340B;
	Wed, 24 Apr 2024 03:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713929532; cv=none; b=aTzXltif1JmgTMMPgZoTHZsu2u4RtAaI4kP7VPTWv6gvgdQKXgkV1Qm5miVyTuiyT0quBrxsVr2Eg0jtOBpVI2btVzsKF00MaYQdiyBYQKyxf+dz8r24bxVZXrtqd0DV5v3jKdCKeYYQBttxVdXx6KE7elKcU3SLo1alNl1SFVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713929532; c=relaxed/simple;
	bh=6g97TUaw/jCh3yi3jPP3aYD2czjvp1b6ky2MjDkObNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WUynYQ2VmSTvDae4GOQ4NCP8Rfhi3zQ6h5huzNSAUbmhXVKRL7xW+hHva1LfOh2EKON1YgLOU8zHlf9njLgy1/q6CGRjfCnHt9mraNMMfJf6Iyrc0+gy9rtF5XrlWPvh0LfhdGfmQACC4LLK+Bbx83B6gx3K00kSOsf+PwPDhfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nwjez3Qj; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-22fa7e4b0beso3562617fac.1;
        Tue, 23 Apr 2024 20:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713929530; x=1714534330; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wDmT8lLNd9UXbq0Sx6/V2FNt/nDtuLaceA/unrIBnFY=;
        b=Nwjez3QjlJVGcxlQJR+2juEe8TUpQjCsOn82ZCk2WN2T4bD0BO/jGCME30k+TUFOWP
         2Bed49jQLC0oOo2KL4Yvdq8w0nKV8hSKN47mIUj0YdiL4teQ5mIHoFIj4hzmS2Ti/etN
         4MUPZXv1FJR4d14ql9MzU5DsPYynmf8ERGVWTaYrO6Gyp8rsPrDwZvphg/88Q4D8Gtpm
         5VQxt36fyqIfAr4kTTUo6iUnMIAF1WAFh3qVlPUyXXjxTjO4wZrBQNzNgHiJYLVDd/sx
         hXFg1LmR6srAIY/obYodMIfWD8T2vkCH+ktrW4WPH7zKNlzbSJcsvtv5e2x9mIU1HLBu
         wXfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713929530; x=1714534330;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wDmT8lLNd9UXbq0Sx6/V2FNt/nDtuLaceA/unrIBnFY=;
        b=PPhDOwvz1Lw7NsAhCbkFxHNyzbEGBb5ATQE0h0UaQvq8O2n62WCg7S2qKdJyf5VaP1
         SZ8a7ZdQ0lZPNxhbCENYTNEmV3EkCbkZBV2HyMPjNYtx2NRLVzhWlFv5Tysu4Ye6W0Nh
         vEilL5OZR5erC/veELnKDv5cL/HnJL7UVdvzwvEGLENRfPFyq7rNh60wxRC00pOYTEBv
         nqwhWufS2MDsV8qGjJkpg1wY4Y7rdiDQokputEjm569JPc2HN6KczGiUXVq0+WKgIajN
         AlPgf9QnXz7jiumcm7TcNs8DIG6bq5VZN2LvZpqFCwrwfTnka5VyvPt3tT/q/vFp/I04
         JROw==
X-Forwarded-Encrypted: i=1; AJvYcCVhfOsZLQm/Jz92wv94Mhn7JSqX5nbvWxvenYL00H5oMBsHUv3maVRxRdFzBzWxF7Kvq4rgFao0PjUOVr0GV9HQyDCLomE1DksSPtSHdgS+vbkkxmv5Aif1pvS/geZYZyWjXclK4g==
X-Gm-Message-State: AOJu0YwudSAggkA13n4Ao39TCnRhckrR0nnLgXiCZlj8LdTAa/MSBiS1
	iJVM1p03yP7eqCiPQOu1eb2O1NGKqxCZuDb7wBgV7rlqljI6P1LQ
X-Google-Smtp-Source: AGHT+IGdF1krQFDWhoNw1xQE+nKdWRpL9qOkeMNiMokocZgXTW3pKzK+wXOW63Xe33I3eYFuPGP6yA==
X-Received: by 2002:a05:6870:51c:b0:222:a91e:cc1d with SMTP id j28-20020a056870051c00b00222a91ecc1dmr1407863oao.4.1713929530158;
        Tue, 23 Apr 2024 20:32:10 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id v26-20020a62a51a000000b006e647059cccsm10426636pfm.33.2024.04.23.20.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 20:32:09 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 23 Apr 2024 17:32:08 -1000
From: Tejun Heo <tj@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, Xiu Jianfeng <xiujianfeng@huawei.com>
Subject: Re: [PATCH-cgroup] cgroup/cpuset: Fix incorrect top_cpuset flags
Message-ID: <Zih9OG8Azp5vrg9f@slm.duckdns.org>
References: <20240424010020.181305-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424010020.181305-1-longman@redhat.com>

On Tue, Apr 23, 2024 at 09:00:20PM -0400, Waiman Long wrote:
> Commit 8996f93fc388 ("cgroup/cpuset: Statically initialize more
> members of top_cpuset") uses an incorrect "<" relational operator for
> the CS_SCHED_LOAD_BALANCE bit when initializing the top_cpuset. This
> results in load_balancing turned off by default in the top cpuset which
> is bad for performance.
> 
> Fix this by using the BIT() helper macro to set the desired top_cpuset
> flags and avoid similar mistake from being made in the future.
> 
> Fixes: 8996f93fc388 ("cgroup/cpuset: Statically initialize more members of top_cpuset")
> Signed-off-by: Waiman Long <longman@redhat.com>

Applied to cgroup/for-6.10.

Thanks.

-- 
tejun

