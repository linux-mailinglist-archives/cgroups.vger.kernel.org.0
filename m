Return-Path: <cgroups+bounces-12452-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ED899CC9AD2
	for <lists+cgroups@lfdr.de>; Wed, 17 Dec 2025 23:14:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F015C3016B97
	for <lists+cgroups@lfdr.de>; Wed, 17 Dec 2025 22:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15AB8311592;
	Wed, 17 Dec 2025 22:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="TcAYtLZS"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84C1279792
	for <cgroups@vger.kernel.org>; Wed, 17 Dec 2025 22:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766009667; cv=none; b=bIjKp5iaODXpRGb7ZYFCZZ+wjhnkc97y8NHu5g3gYDnSCx/J2VWEgbvXp4/JJGuZept8fLX9W5W/QO/xiNEjsYTeSI7MjdbnddF8X/YjF+gBX/IipHmvc6iaMLDjzvO8adXv83bbDsYBP/G98/oaQQ28n9zoO+3zVYQXFOCeL+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766009667; c=relaxed/simple;
	bh=ZOi/W03jfmkbjkanUI3k6txc6G03Dk6CgoRe5Jl4YJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y5D3j6AlSzIAgyCGB3s6wzuP+9rPAdnD9C3hz2E/Qr1Fvykg+REuZVat1optlKDqVDDYXAVM8z2uWqnsdFcCoPl0YgS9Ry3qL7p7m0JIvRu2S6QdB6evUdkePk6qXRRgiwyOEAXTrm+PVzLmlubiy432vdEULwWOwiille18sAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=TcAYtLZS; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8888a16d243so31246d6.1
        for <cgroups@vger.kernel.org>; Wed, 17 Dec 2025 14:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1766009664; x=1766614464; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aGo5RkEniLnoVlNdAAhpzsAz4q6lb7BEV8qHSPJsHsc=;
        b=TcAYtLZSWSQxzZK8i3/cx1eTJO29E2iSJEoY1K7reqEP+kN/z3fqyGXSvkOWp2tOAM
         6+Cx7kl21TdkqzcKVCppJWp0wBuywCDSzvbddeTyjPqHNk4ZsqApsQR/rflBPdIQacyR
         hkOx1zGVw/J2OUV3kiAZBja6PS+NiDWluwbE5up/gsx0n4LqkZVFRTQPSpgh7wM30n/R
         fCpoboHSWKSnxKbv1dfEZ7Yhc2mNGpFYrElMXlwGBq3Im1I59nT45uDTchFMfIilPxwT
         G4PMXVf2oOAMUUOf8raGOyVcpZ4RFPWj/ZKYeUvIT/yN/Hn3XbrHZTjJjjqrCsJeGbt+
         AfQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766009664; x=1766614464;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aGo5RkEniLnoVlNdAAhpzsAz4q6lb7BEV8qHSPJsHsc=;
        b=vL2EwV4loKOUhOMDqf3fukopY3kfESh9yWGDV+I7Uf6aodmkaOd8t5ebF3S9C+JkuF
         tLgwnXgfXaX4fsAzTNrbIZlY55nBrJ1WK99tJH3AmcWsE6AJwa+MyWD7V1wBzgixXS8f
         RB4FnzuV8RAx362cEpkd4boFdDEBvsReiJLnYMIK/BrNHjHACOYRgitjoci9LD6fHbee
         hrblMYuhtHTjqlhKtO/FIwZNEHI8me3/G06LLhL6djxKkXOUtskCt+YzrONvSrF64MAf
         BhN9EQEuYiblJOONIV4DMaSCxp1Ng+mxMX8TekimfmF85eQrYf3K4G1jMrm4J87E3i5U
         kAzA==
X-Forwarded-Encrypted: i=1; AJvYcCX7sFT5/UcCqQ+HISfKnw+S1w5mXlXxL1jZSjwvodZRagn7RuvViWUwGgKbmj6XU1o3qiarmTSg@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzd1fkHocr4wRfffHQ5VGExLni5EgSZSSar8xf/oulLR6XN63D
	vtO451/3BmR6HpgoD/pPQe3/SgTuN4Aw1xjV7kbHLqlRaGc+y5T+R/jrNO3xeeox5jg=
X-Gm-Gg: AY/fxX5blZ0LDG9041pDLDnTPLI2P7jf5NQTmhvippkXAhEX3cuw5m2Pym2CKiuYA+P
	HOpIerqGgSV9zfY5eXlf27H7UEDCXHmr+avyUIn2lL/PBaFhRZPpQHUHIWo++AflM2DIEW/+5Qo
	H5G7OQZgI4kqjn71sgMKTcIVFqrMfdocYWDtGoLZbaLwNtbZOL95bl4x21ZLAWLNK49fn608X4k
	uzhlM4tH6Nj/EkUq4vuBL8fORIw+c+6jlOibIG3lUTWwJqqyFhW0YeNlCvQR9V7BiigWHMDVG63
	Hm03EbKAYKy4kHN1A7Ie6nSaoQMBZEAOZ4UyD9CKzx5WoZqN1ZYAg+x4PxFlc3hXoP3+zc8SeQq
	IYJ8/xepeCVgXDg7gZ565xkis5lvPuNwI7BkqmjJXfWEfjtzsUgZq/PfC3CWTfjjT4r2dglibrE
	pMRvmLMHc8OA==
X-Google-Smtp-Source: AGHT+IFS0hMSIg8OqTULT2EjwaYx5tVuyqOEnUFZpUlrOcjLRS7kG+GrEOBoyYRa59p6kqOffpjgmQ==
X-Received: by 2002:a05:6214:3d9f:b0:88a:2fd1:b582 with SMTP id 6a1803df08f44-88a2fd1ba98mr210156126d6.47.1766009663688;
        Wed, 17 Dec 2025 14:14:23 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:929a:4aff:fe16:c778])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88c6089a7c3sm4446836d6.27.2025.12.17.14.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 14:14:23 -0800 (PST)
Date: Wed, 17 Dec 2025 17:14:22 -0500
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
Subject: Re: [PATCH v2 13/28] mm: migrate: prevent memory cgroup release in
 folio_migrate_mapping()
Message-ID: <aUMrPm-ylp-6_xNg@cmpxchg.org>
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
 <1554459c705a46324b83799ede617b670b9e22fb.1765956025.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1554459c705a46324b83799ede617b670b9e22fb.1765956025.git.zhengqi.arch@bytedance.com>

On Wed, Dec 17, 2025 at 03:27:37PM +0800, Qi Zheng wrote:
> From: Muchun Song <songmuchun@bytedance.com>
> 
> In the near future, a folio will no longer pin its corresponding
> memory cgroup. To ensure safety, it will only be appropriate to
> hold the rcu read lock or acquire a reference to the memory cgroup
> returned by folio_memcg(), thereby preventing it from being released.
> 
> In the current patch, the rcu read lock is employed to safeguard
> against the release of the memory cgroup in folio_migrate_mapping().
> 
> This serves as a preparatory measure for the reparenting of the
> LRU pages.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

