Return-Path: <cgroups+bounces-2590-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E01BE8A9F46
	for <lists+cgroups@lfdr.de>; Thu, 18 Apr 2024 17:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A120285B90
	for <lists+cgroups@lfdr.de>; Thu, 18 Apr 2024 15:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D6E16F840;
	Thu, 18 Apr 2024 15:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FyijSi3H"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38EE16E89E;
	Thu, 18 Apr 2024 15:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713455838; cv=none; b=VmfV6VLYcBDQTvkfyQ1LeTZSaMMCluRQagFUR6V4kkXS8HTD9ORYxW8IOXWdUNwI2oALuaSAPF+q0u5YwNZPvUn0OV+WHc4ozbAfyqNuGkQJrZFD+onjppFIqkYbBwLdCfi8hFKkgG2AmkNJduQdq58CpY5MwucgKgb1WFH63sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713455838; c=relaxed/simple;
	bh=NZIjz58uChGfVrQTFf9J8bzx9/b0OCWG32jP5AflxYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HULfq3W278JXWEduOSjb8tISUjCa5dncSyNOPA/r5O/Txp7gyLoS2/d2gOZIvpAeRFoaUaLzT6/z16Hc6jlauzAPNtYg4Mj8JwqcE1zeK+2bfF6HusveVbXpT6ukh8hqXPSp2hofkIrKp9m18qj7vqwjesUe/oS8gQsFDf5Kz0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FyijSi3H; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6ee0642f718so1562470b3a.0;
        Thu, 18 Apr 2024 08:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713455836; x=1714060636; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=31gcKiCM041JeHwiuTiAkytMVofo37R4KQG8kS1eMO4=;
        b=FyijSi3Hs31tWdXijU3isd+usZivxkuUt0qq58SxqQFkfNfLoCyKibCpOkts6YoR1t
         qtt2XSv0okFYv0xJ7520NnhFtsc25GTjavWxm2tx6etm6aURZlHRP0w6qQWMpMlnxDow
         qBW0JbDyhgBxbK4PBew2q+xa8TDruF9bzprUAnz0mJZdVBn1CTXHr7zy8+pvRJGU3a0x
         uf0+l7DDoFwDJ4DSLOh5zvJr60efr8mM5UzuUQB7C6vxUV+wb7DX5Xjyh0qF6UPIGYiy
         eNd2rQ9FjqrgqtPV9feZN3CBn/ObILQ9gD6ccD4ynPN+Hr9si8A/IIo+JyL6UHg+w9S3
         QFMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713455836; x=1714060636;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=31gcKiCM041JeHwiuTiAkytMVofo37R4KQG8kS1eMO4=;
        b=ilyTyeKjMALGysslseJXT8C8HppLldc8qMcXfHS0U11UsENbHEIsbxBmYJjidkSLJW
         87ZnNZe0ZUOzswXXheG8udKGExyq5ZnUN0LBrRioJGyJwRgPbNZTjWCFMkuf+yDgBRE0
         0wiZvJUaroU1Q5xC3nLvzIRE5Z3IUZL+qkk4AIygtw/feH4DRk9XmSA9YX/b/8EvNdZa
         zJ0uShJxcfsZg/5/ocTu2F+v4BmrjwEVk7eC9BDa8e3mGT5lzs54jx/3PZ2r7dS9UXJk
         5xBIdvXnUWckjkxkymcy/QETC16HDW0uRHPJG+XipOikfUOjQOwQe2QhWewrXSBsX48j
         W6BA==
X-Forwarded-Encrypted: i=1; AJvYcCU45zyTH7cs/Cry17r9Vk6DSLMfmt1M3DKxiYfaJHnZciKv9fhPoyjH1+OZq3NJ0XiR9PkYODi+4MqM+l4/N9ichjIGGudJIQMcS0uQ/Z9aJ/i81BDsPjo9GWAuzy6eZ+NX5gzbmw==
X-Gm-Message-State: AOJu0Ywq9M7rNEcLvUk/gsz6zhwgIWIzQx1nkhE+rs9ERD8maQFFQsgV
	VqaSiy/cLd07PuBj/kU707OYqphf8UtlOD141YGITHWEKP15dbphNIkgi/cK
X-Google-Smtp-Source: AGHT+IECbU03OA/uDtt/4eiPZmOnQn58qU66mWE0ULSPEhGbJvwpcV57muu+sGx72J6Sn//yYT08ag==
X-Received: by 2002:a05:6a21:2723:b0:1a7:9b0e:ded3 with SMTP id rm35-20020a056a21272300b001a79b0eded3mr3931879pzb.11.1713455836062;
        Thu, 18 Apr 2024 08:57:16 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:6f51])
        by smtp.gmail.com with ESMTPSA id g13-20020a62e30d000000b006ecfd2ad4ddsm1696343pfh.146.2024.04.18.08.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 08:57:15 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 18 Apr 2024 05:57:14 -1000
From: Tejun Heo <tj@kernel.org>
To: Xiu Jianfeng <xiujianfeng@huaweicloud.com>
Cc: lizefan.x@bytedance.com, hannes@cmpxchg.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 -next] cgroup: don't call
 cgroup1_pidlist_destroy_all() for v2
Message-ID: <ZiFC2u5g5QGGRFFa@slm.duckdns.org>
References: <20240418021930.914245-1-xiujianfeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418021930.914245-1-xiujianfeng@huaweicloud.com>

On Thu, Apr 18, 2024 at 02:19:30AM +0000, Xiu Jianfeng wrote:
> From: Xiu Jianfeng <xiujianfeng@huawei.com>
> 
> Currently cgroup1_pidlist_destroy_all() will be called when releasing
> cgroup even if the cgroup is on default hierarchy, however it doesn't
> make any sense for v2 to destroy pidlist of v1.
> 
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>

Applied to cgroup/for-6.10.

Thanks.

-- 
tejun

