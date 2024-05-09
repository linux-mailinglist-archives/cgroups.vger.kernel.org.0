Return-Path: <cgroups+bounces-2836-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 736138C10D0
	for <lists+cgroups@lfdr.de>; Thu,  9 May 2024 16:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F197282D16
	for <lists+cgroups@lfdr.de>; Thu,  9 May 2024 14:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68EE15E1F8;
	Thu,  9 May 2024 14:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="FHIxmQjk"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7965B15CD76
	for <cgroups@vger.kernel.org>; Thu,  9 May 2024 14:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715263515; cv=none; b=TRc5WErzFZPAUnyHloKauIrNo8L0tf0UEH5s9daUSYxum9WjWLAE3ueKg+PpDXN78qpxDhADfGuEPJTnfPrEhHMXb/pGWZFwgSUYyXGI3dtJUmlzF0UE/4PMtSIr0zT+3tBBcM+nkUPtLWranb5PoM88bJ++GjqAjSO7XihlXdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715263515; c=relaxed/simple;
	bh=0YdZl6Zq6//+zNC1b0gYUiB5yFvpiMGteATa5STZ6Ns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G7fBe9hRgmz5oM29/dh0mSCKlZ4VygjXtJq+H0FMIeOQ/yCsAPyfMZZicltWBuRWdHI94/M7IYryaA7VLfbtni3KWhBB09Cw9lUvWyXKsoeHweS6EZCGNmgUQhqEX6j8JlIzo4/Z3Mq7K/7uVALkrN7ljdxB3I2bwaeESNVIS6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=FHIxmQjk; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6a0ffaa079dso16961316d6.1
        for <cgroups@vger.kernel.org>; Thu, 09 May 2024 07:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1715263511; x=1715868311; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kvn9rngIDL29d8F1SzHuLjz6VO7wTPtvUbwSUyJZyRo=;
        b=FHIxmQjkc7Ualuluw2fLfP7N3RZpwBpOH4wmseQW7FNB9X3FWNS1UPfB67weeQBBpv
         zy7Gezo5pdz8WGWStjpbhWXT80YlNDPFqyN4oS13TGfiaFywO1X+RiMBA9OQ3hJOOgkH
         CagMA18SFj9pSsh9y2lztZd+M0erjhxVfLE9ohUmAy5w5PzO3EZANFUmU5OfZ0dCX2ai
         nsLfk+HBoS4SlhYx06YS/sH/JPr55gJxmrWwH2xyEuipwS/9CnnfAlmKSUv4NAwnUiZd
         9teI53e5AjExu2Xya21omP81Ywj/A/Wh7N8uDI6O30bEJqxOv/gOvHvLub9m+xperc4a
         NnQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715263511; x=1715868311;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kvn9rngIDL29d8F1SzHuLjz6VO7wTPtvUbwSUyJZyRo=;
        b=gs/hiCRf0KrjhquyjkQWHkiJRfMLB8o8vjasuO2CUuUZ6OfDIxHMi3wty6mB2GhYlv
         Zw987yvT7MSOI2w9d8bdE2cLgN6zemT21VSxkX8DQ3gJaFPM/yAxE4OHbzweX7rWhqTc
         qZ+P86RrGEQOYe8VCQtS+aT7q6fGCp0w9nT3i4Mhz8NpPtvTgfXfA+hQtEnPz5wCdKpZ
         91OGHG/ySWTcBYLtygm9+zK1Uk9vMNXr/y/B6i5x8o9lTHd+40X5DkwzBtFY7EyDCAmo
         RR/VbtwcjRxZ6DKaJ4MCBGdQoGu0RsxYabWDAYaq3VugLQmLuY4O1FVSO0upsDGiOtgf
         WIAg==
X-Forwarded-Encrypted: i=1; AJvYcCUjxvLcHOaS4pEfyWqpD+0szcjEr4XPgr7AATW6jlGCRGVrsPKCOQMT1OVXCsSAddUGtqMNcuaieq/GLP6XOrXP8k5Tv9rSkw==
X-Gm-Message-State: AOJu0YxkEJPS1o8TN8cdJmLIUPUBBXhBhWubfndiPXoMBL5dkgyZzrns
	Bio4eB6smaowZlC7BP4bdH1Wujm0mlxDUlKJVNmSgF1XXhffGggyQbP5if8W0AM=
X-Google-Smtp-Source: AGHT+IGfjpV8KyyCSoYBb7jd/faTYT6XDBXmV2leln7rpsUs8MqA5s1oe086inZatvtDiGmDWFpCkg==
X-Received: by 2002:a05:6214:110d:b0:6a0:deb6:7b0f with SMTP id 6a1803df08f44-6a15cc96ce2mr42735196d6.29.1715263511394;
        Thu, 09 May 2024 07:05:11 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a15f1cd3desm7259176d6.88.2024.05.09.07.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 07:05:10 -0700 (PDT)
Date: Thu, 9 May 2024 10:05:09 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Xiu Jianfeng <xiujianfeng@huawei.com>
Cc: mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, akpm@linux-foundation.org,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 -next] mm: memcg: make
 alloc_mem_cgroup_per_node_info() return bool
Message-ID: <20240509140509.GB374370@cmpxchg.org>
References: <20240507110832.1128370-1-xiujianfeng@huawei.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507110832.1128370-1-xiujianfeng@huawei.com>

On Tue, May 07, 2024 at 11:08:32AM +0000, Xiu Jianfeng wrote:
> Currently alloc_mem_cgroup_per_node_info() returns 1 if failed,
> make it return bool, false for failure and true for success.
> 
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>

I also slightly preferred the -ENOMEM version. But this is better than
the status quo.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

