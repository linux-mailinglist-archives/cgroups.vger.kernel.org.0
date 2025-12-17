Return-Path: <cgroups+bounces-12448-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4BECC99F4
	for <lists+cgroups@lfdr.de>; Wed, 17 Dec 2025 22:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EEF7D301B12F
	for <lists+cgroups@lfdr.de>; Wed, 17 Dec 2025 21:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1368B30E0D9;
	Wed, 17 Dec 2025 21:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="XGYnNECH"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA88A22D7B5
	for <cgroups@vger.kernel.org>; Wed, 17 Dec 2025 21:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766007956; cv=none; b=T2yVe4mxxwYIQJ+pwWz7iH0vtuInurooDsQ7g4SFvrPV7SLKYXVonyOP2nSqp2dA6Mwa5HLlAh+eHAx7WQWscq7XocbhBzOQnl2O9HRPvh1KScyygHdUYqrSLb6d7p8grmADdzJICXpAn3A0K8PjhSY6oDNcUphttEkC6T1eGOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766007956; c=relaxed/simple;
	bh=dkmNVOl9esvD5PYBr6scBUPZ3jAS1PaBD1rAxbkUci4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YKTvxX5+6p+mHqP3RqZ3C33CqXQZaUOHrlph/RwZYtDrxMGKuI+gkRY1NLhTuIFuToY490QU3X6O19wiY+g8PY0XWawWaHHwG35rmYZo+e9zaa9C8Cf8eUNDvoZEcW52eXsZEK8nrPF6TC2SWsQePnCiPDqdlDGBKjabd+D62rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=XGYnNECH; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-88a367a1db0so58593156d6.3
        for <cgroups@vger.kernel.org>; Wed, 17 Dec 2025 13:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1766007954; x=1766612754; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DEWFBDgpTWFZKv5MW/dmLg7TmGtq77uIIkaqnvXKLbE=;
        b=XGYnNECHkJueQm4M7eGoDy/sVqAVIbtnCcKY9rCr1bl5XMKRqnyMlsupJ9l5TrMRO+
         /+cS9FTZfF+tj7lhZhEvsSxFT5u15JuZU6eaTNZ/+7gVMhNPHYAdeJSyCi/qo7PG9rJb
         ll1sqzJ3xJzFEsLbrnurq5qWXqtVr66xmAS+0J1kqajI2gKOPOVbRVdYccyupd576TjH
         2Fb/WsCpHQRxjiH71oYnyE25oxmVeJd7Y+bKc/is5pFUFfyQMEy6sxj9jcurEOXX4xFt
         5WMVmgaFsXrrbiMnuGnUc0x4omDh0KFeA5KpPS06f82fWktjywk/nejSx7Dzi5Z0rJgY
         yJwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766007954; x=1766612754;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DEWFBDgpTWFZKv5MW/dmLg7TmGtq77uIIkaqnvXKLbE=;
        b=fUdjiuP1IsP7aXrNw1f6XWRJPLIROQDJcL94mJWua5wkgg3awC1q2nn4AtdgHTcQcw
         8YasvWmEgSCCQHP87MyH5dFiBgiDRIZxOyaPpSyka9DNMRKLjvRP1Zq6KWHCNCmps8oP
         KKx81DkejagsX3Je9YFjcwcCv3uwcXe2wsTuwGeDXxDOGOiE2rgcG6+urC7aMgrL4OtW
         S4PqTKuGeTX4brkf0MdzrbsIK7ifAUN3asmR3J4nJv/aCdn8+93pAZBapu2wqvFqdqJ3
         LjghizlELm9Bpnfg8vF9DPMzMCPrFOzMhk8FwxT46zJae4CH+EIK0Dcbc+70OJUzslE3
         MS/g==
X-Forwarded-Encrypted: i=1; AJvYcCWWxgWEBrbp7R/lD73lxzEcFfpPuaHX0/bCjvyHT/wsCmP/5xElgCYwkWG4cFrbKEshuXLO8RIN@vger.kernel.org
X-Gm-Message-State: AOJu0Ywyz8nyrTw6VMqqdwzIClVsHDRumlcjhbsOyNGoAY/YoECFfFl5
	gokmC8echqr0VluuZ1YCA0Go4H6LNRnFGUy+Tg9syl7nTG0xJodN3C/2y/+Du1fgr1Q=
X-Gm-Gg: AY/fxX4ARrFJ85pu2IcNLg9n7I81Td/17+tsJM8yO+SpuiHF63DuqYmhBLMaEvvQE1C
	Z4HOFE7eWBMnKRWD45LdfNIupcsOJDlVZHaH53GAN9+3dGznVABblcq2hKnmp/fzfZV4NMG2e2c
	06swuyggdEnsILvAdXZLRHc4Zr3t60osJG6aVZrOMe4YCom7ooXcR0Io+YnZ0bJswCnQQudbdcr
	r6+Bvr1HUQFg5Zpgl7xfvGPCJqTIgoy1j6diJapPRXn7o+Dkwps89IxB+0SY6LKHsDOMDjyqnpV
	2cYV5e34ZwPfjnIicxx+za/wLWx17lZq9tGBEaOBmdEYoBl2Nx3XUgl0MKocGu7UfAhA9c4aKwG
	S4mKsmYdLanSyV369weacZSft2Kmn9rbxWwN+ZFq88dDPcq8DoPgoOER/yl8TiNqvy+5leX122f
	/WvBsoLScZoMBpMvh23TBV
X-Google-Smtp-Source: AGHT+IEiDeODVgvUicYejjhF2iZLpk651azh1P16FItpwxPM4pdgA1TPCGdZ9Yz8otPLEoSKD5SFng==
X-Received: by 2002:a05:6214:3005:b0:87c:152c:7b25 with SMTP id 6a1803df08f44-8887dfe38cdmr293393766d6.13.1766007953662;
        Wed, 17 Dec 2025 13:45:53 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:929a:4aff:fe16:c778])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88c617699c5sm3733236d6.57.2025.12.17.13.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 13:45:53 -0800 (PST)
Date: Wed, 17 Dec 2025 16:45:52 -0500
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
Subject: Re: [PATCH v2 09/28] buffer: prevent memory cgroup release in
 folio_alloc_buffers()
Message-ID: <aUMkkHrgjUOV63Xw@cmpxchg.org>
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
 <bd87d13b99c159de77f23f61c932724a8b2d000b.1765956025.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd87d13b99c159de77f23f61c932724a8b2d000b.1765956025.git.zhengqi.arch@bytedance.com>

On Wed, Dec 17, 2025 at 03:27:33PM +0800, Qi Zheng wrote:
> From: Muchun Song <songmuchun@bytedance.com>
> 
> In the near future, a folio will no longer pin its corresponding
> memory cgroup. To ensure safety, it will only be appropriate to
> hold the rcu read lock or acquire a reference to the memory cgroup
> returned by folio_memcg(), thereby preventing it from being released.
> 
> In the current patch, the function get_mem_cgroup_from_folio() is
> employed to safeguard against the release of the memory cgroup.
> This serves as a preparatory measure for the reparenting of the
> LRU pages.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

