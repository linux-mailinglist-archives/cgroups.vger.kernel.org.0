Return-Path: <cgroups+bounces-3499-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E9E9243D8
	for <lists+cgroups@lfdr.de>; Tue,  2 Jul 2024 18:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05F6C1C23427
	for <lists+cgroups@lfdr.de>; Tue,  2 Jul 2024 16:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69A31BD509;
	Tue,  2 Jul 2024 16:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cTlHJP8o"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B9F1C0DCA;
	Tue,  2 Jul 2024 16:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719938685; cv=none; b=uKawxVTn1ONyRmNO13PE1pe5o5ZUzkoFS059KkOwD23BSLpi/+zzz6u2clpp3TDfyOee/xOky3FDzPCYTQjS09F+SYXQ+w+s+5NPYZoCnLmMG6RDGQ9iGKpbCYyrUzpJ06woRKDZfvNBMuQ/82FlDAphxGevic1tuQx1865IkxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719938685; c=relaxed/simple;
	bh=Tyz3TqYU3UX8c5xyn01VKHdXHg/5NiIVo+c3mmPCbMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LPqfsyx1BN33hv6HnMMxV8+Gt+MKQYKYBGWC+C4OL7yE7E9t4Y1WkVOJ0ME66oP1vryMFLmS+QOcmqUFdeE361vKR+sBhev2mi/7kn1hxMUzOralSoHN6+xte8SmTv+Ne6rDacaSyayTzEpXjJ/iEuXELdHMsQha2iqZfaJTKCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cTlHJP8o; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1f9aeb96b93so30031605ad.3;
        Tue, 02 Jul 2024 09:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719938683; x=1720543483; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yYQFfspilKOpcYu5H8+151P184PuyX7LYe2ftiXcF2g=;
        b=cTlHJP8o51bskjpIItl/1BVoDE5vBv04aGSWR75cGdzL4h4+jAo0OCx8SG/JovGrqy
         u11iOj3fb5bL9Z53IpwJjXxddmcY1kwDrB47ZLPqVSEkk8HXF1k9Orz7ZWimi6fj2t3K
         6a2Kk0SW2uqBSLqXcoUpqV4ZTFzCubIiVMlNn4kU8uoyxyoqs5BKPIFBUfpJ1zsfcdmE
         s+AdR4ni/Zmv9ZJG9N3JoSEunpoXzyjKJuvW3VFaCVEyyeOtA08VkrmemAcUB9EezMgU
         UmMWj+jhG8tdJHj8GX6RNa2WDrOPfwL8NYDEWuJ9pmwLDd774rmbprQrvg3giXuYJydt
         7BJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719938683; x=1720543483;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yYQFfspilKOpcYu5H8+151P184PuyX7LYe2ftiXcF2g=;
        b=Lp8rhHbM6xz/nThpXap++7idiBUY60ZgOykm1dIRbB7VWUpYoDxDhIOLdpDSeZu5bZ
         iUmC6igocC422lAAxSL5fwmNAdxZJ4wHEZiWF3SMXih5XkhgTFVd8YFyqf2dVTd/5JQD
         U8l3zHxUSp2tCejl7MB1R6/D89QWYr8yjHfc3FJRNs7KRSLgPeF3YDiimFw16NyfU8wq
         lrSKuKcd8dMLFjvC1jK0FiFUEYlUzgWz2O0cxfkfrtR4uxe9cVNuDaXVhOvxIv247Wgj
         Clu/S7A8ao5Pgq2QWLzP7rxFmJG/4SUI66XPYXkH0oPtSALifLx+Qbb0gm8zuK9Z2v+o
         6bYw==
X-Forwarded-Encrypted: i=1; AJvYcCWXKRTLadQLx3f7yiVtZCtxvL04him0HFZ6ny6XCya+46FosOhBlsFRnQebVFAodaCPV3CxpOcbIPhSUvyxGYYSTp+HqEyYurGabzYs77/MyTPj+nXBfSsdXRhhgwsm6Nv48evd9sgD+mUUB0kJuUtyrikaOiMR/K21pRJRelh4UA==
X-Gm-Message-State: AOJu0YyfynjBNQZUedWKM0KFMYFfNZLPfSEktLvUJWC2FKWwZASO75iN
	1hYo43r9HD/JGR/uOGyMovi/ChXenRfQ8ofETf/Ppk8vHNWCzBOQz3IJQA==
X-Google-Smtp-Source: AGHT+IFtRAVfGfX7WOnLBEzo8/hdJ4YwGMYKD5zNpsgpRGteKfUv7M/KfKScvhDpxNUvVD2263RTgg==
X-Received: by 2002:a17:90b:1294:b0:2c7:c6c4:1693 with SMTP id 98e67ed59e1d1-2c93d71f47emr8104054a91.21.1719938683575;
        Tue, 02 Jul 2024 09:44:43 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c91ce53bdasm9067348a91.23.2024.07.02.09.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 09:44:43 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 2 Jul 2024 06:44:41 -1000
From: Tejun Heo <tj@kernel.org>
To: Xiu Jianfeng <xiujianfeng@huawei.com>
Cc: lizefan.x@bytedance.com, hannes@cmpxchg.org, corbet@lwn.net,
	kamalesh.babulal@oracle.com, haitao.huang@linux.intel.com,
	cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 -next] cgroup/misc: Introduce misc.peak
Message-ID: <ZoQueSY_8NYcApfi@slm.duckdns.org>
References: <20240702075718.2657635-1-xiujianfeng@huawei.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702075718.2657635-1-xiujianfeng@huawei.com>

Hello,

On Tue, Jul 02, 2024 at 07:57:18AM +0000, Xiu Jianfeng wrote:
>  struct misc_res {
>  	u64 max;
> +	u64 watermark;

atomic64_t is probably better here.

>  	atomic64_t usage;
>  	atomic64_t events;
>  };
...
> +static void misc_cg_update_watermark(struct misc_res *res, u64 new_usage)
> +{
> +	u64 old;
> +

How about just while (true)?

> +	do {
> +		old = READ_ONCE(res->watermark);

here, you can use atomic64_read().

> +		if (new_usage <= old)
> +			break;
> +		if (cmpxchg(&res->watermark, old, new_usage) == old)

and atomic64_cmpxchg().

> +			break;
> +	} while (1);
> +}

Thanks.

-- 
tejun

