Return-Path: <cgroups+bounces-3501-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E4E9924541
	for <lists+cgroups@lfdr.de>; Tue,  2 Jul 2024 19:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FD1D1C20DDC
	for <lists+cgroups@lfdr.de>; Tue,  2 Jul 2024 17:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5641BE86D;
	Tue,  2 Jul 2024 17:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/UKvDnm"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2D31BE85B;
	Tue,  2 Jul 2024 17:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719940794; cv=none; b=QOBBfKaFubkVKORTGlMDz8AG3bx94L13/5mUKnjMvdDcqooX4z52RAm+ls5+JvKYXdqupyuaFFU/u3Qkp3Jhy2n6QCREn8sh/GLGXdgVdEIml3bSwZSMzcehHIyAoSLTcu8xJfNlIYkm3aIA1i/zMzmC4oaAQR+nAOUdfs2mwBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719940794; c=relaxed/simple;
	bh=DTrYWF3WX9XTMQJjDxP1P7/Hs6Ylpuj2bLq4FCk9sVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QVQGYt+Sd8L3hTZqC5CC42wKmXZv60w4FmyZrLC5srI7I9LEBpu/hAKdQub17YLDnw/xUDvwzCvq20hJ+zB8HTQM7RYGtlr2G/rfys9lPBpul1IYH2DYGlzjQmiSmJhVIQ7RmnMoOSQKJTEspXAgx6Y+hjfG/vXqQkx9re+/1bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A/UKvDnm; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-25da8a19acaso2083153fac.2;
        Tue, 02 Jul 2024 10:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719940792; x=1720545592; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o+LeKSyNiYZl01CREUkEC5UyawrBHODzePPwogqcsLo=;
        b=A/UKvDnmv1Ggc5Klp9d6FhqIbNohyc413MVAnBCcXvdQ1CpJFfev8iR4zk3+F+J/cx
         a8dRcQxDkyjvUpJYrZZZZVxQU52W1Pe1as4KDf1Vg4Uo7aE/0LGKG99a4bcFKEZkyRsl
         td7EWurhDUBJLo+PMgMHr9RcNuqGOVY8JDtSKAuoQ8iSzB92KtIVdKc+548El6TfHwZR
         41I0ppNuu40jtjvsvysrwMjXF2TO/OaQ1CWM3z3N5ZTNAovXeh9VyUKMZAmhWWnt/ySz
         4PLCEpo0J9uuY8uSUCVH60UOouiCNh48ryu4/awV6UBFn0Y9kl1oPS546tNJRKPptEgJ
         fKpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719940792; x=1720545592;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o+LeKSyNiYZl01CREUkEC5UyawrBHODzePPwogqcsLo=;
        b=UWLa1d+YJ7/tXbXhe7EIwXifbI1tb0DFHDD8B1XBOdmVnAVUyBohbQFv3V3Gi14qfR
         U/+RuBFG53IfVRwfZGlbQ5WEKWSm/844wwIr1cvvrjVw/hf4JfZThhwkdYJRtYkutrir
         jf5uT/fC2aSV8LKjMcF5hncughnf4tR9+ifb0MAzq2V+7JJpQXUvf4ha+LM4ctjyoYml
         yeQp4E5HqDPP8yDFn3JrP1I1hvA46fN3eFPQyNaGqx0oGBaJsIrMwqJ3/lAuDZbkAakT
         Gg0K1saaG5r8Kp7Y5Zw9TL0wfS9qTOMM9dRWYfVV1TABIm4atFw3rMDpmC/j4zf5o5EG
         UmnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKVFozgWLU05sl+kjj5l8AKMkMDOE/7TdCIgHocipsiVonuu1x9QANfJszIqB2PaFIJW4PwIjACx2g3DjbATMR5ScuDM00seZUmjkZXo3+z7z8LrfaTm54486KUc0OTVgmQ0YAew==
X-Gm-Message-State: AOJu0Yy6Ak9KKFfd1SuexSp2G8/3Oo+j11ZMXo2Ych3kaFoETBbMiEz5
	S4q8hKKcfQ7nmRsxF1X36SFqZ1gkjAXn6plI5iA/by/RZkBpBVKX
X-Google-Smtp-Source: AGHT+IERtRWeqDgNUQBksZ3dIu7zuC2ahEwg1n7khkj/y2qPZPJUjYuhjpolYC+OaJl6ryJSpmbWDw==
X-Received: by 2002:a05:6871:24c2:b0:25e:368:b5a4 with SMTP id 586e51a60fabf-25e0368bc3emr843194fac.18.1719940791783;
        Tue, 02 Jul 2024 10:19:51 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70838a9a188sm8606794b3a.131.2024.07.02.10.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 10:19:51 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 2 Jul 2024 07:19:50 -1000
From: Tejun Heo <tj@kernel.org>
To: Chen Ridong <chenridong@huawei.com>
Cc: lizefan.x@bytedance.com, hannes@cmpxchg.org, longman@redhat.com,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 -next] cgroup/rstat: add force idle show helper
Message-ID: <ZoQ2ti7nnz9EJSc3@slm.duckdns.org>
References: <20240702022822.1032693-1-chenridong@huawei.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702022822.1032693-1-chenridong@huawei.com>

Hello,

On Tue, Jul 02, 2024 at 02:28:22AM +0000, Chen Ridong wrote:
...
>  	if (cgroup_parent(cgrp)) {
>  		cgroup_rstat_flush_hold(cgrp);
>  		usage = cgrp->bstat.cputime.sum_exec_runtime;
>  		cputime_adjust(&cgrp->bstat.cputime, &cgrp->prev_cputime,
>  			       &utime, &stime);
> -#ifdef CONFIG_SCHED_CORE
> -		forceidle_time = cgrp->bstat.forceidle_sum;
> -#endif
> +		bstat = cgrp->bstat;

Please don't copy non-trivial struct like this. Maybe add a pointer which
points to the bstat to use?

Thanks.

-- 
tejun

