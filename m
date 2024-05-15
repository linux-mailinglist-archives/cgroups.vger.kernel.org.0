Return-Path: <cgroups+bounces-2911-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 613EC8C61E4
	for <lists+cgroups@lfdr.de>; Wed, 15 May 2024 09:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 929FF1C20F39
	for <lists+cgroups@lfdr.de>; Wed, 15 May 2024 07:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C548C446D9;
	Wed, 15 May 2024 07:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e8+pZEkW"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176FA44391;
	Wed, 15 May 2024 07:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715758861; cv=none; b=q8BTcAh8fJdXht7TmCsZfCR2SMC+PFb+aEqYWFS/mWIvIOmWmv19pvpGYUF73xuEOBAjsab9g96seZ5pbm0MHEG+Celd+B0h1sxDv2rCgH/YsPHW5OEBEan5QbUkZnzbyjWL5GEZW0M2gN7bdu+csuenAO4SSoJYpeXaIg9WsaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715758861; c=relaxed/simple;
	bh=t9RspgqG+F2PVlmvWuEQ0GLhwwngFJ3ao73Evv6IOpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lycdBEhIjUgeahdFvxQWIdRdbrzKpTcR4FJwkqQH0/3i49ZR6WH5oXRcSutYRZdsNhVcRVWK81MCRz/Yi/vGBH91bL7PT8myyU+mH8ujy+Vqlyhbq8t9I+0Id9R8ENmWEs33yB2A4iBMgMspKyZIf9X4kWdt4wbbgZ4b3NefdwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e8+pZEkW; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6f0f5645c68so2211271a34.1;
        Wed, 15 May 2024 00:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715758859; x=1716363659; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TLhn4fqdh7o5svdDGhY37fd8hSl+dswnienDJA3jE4w=;
        b=e8+pZEkWRrmirjaxLS/JuS0I+LZprA9UzY2I1lgAHtV7JaJoWwp1sOvka8kN/b/V8B
         0md3lEy3wv8jJHUH271MxrtdZTERZLp7vu/5Orfn7DiBzV6yRE3jkeYgIMYBArevzh86
         eIiVlL4adsC6kpkQOr+f1mrjf11H+7gzCeLmZlCG1z3G6nbd9/bYO06telsZCFXj5Q+w
         A6AjussYuWZkGjket7wxkUd25Hcl92adqxxKtByIcaCsUgwgaMIB2LS+K89mIkjbt4mV
         fJ4yv871NzFE7phzB4UiNrvkCAOZ4PMIeHzlp6RVtIYswRoVvgQTE5kLtO9JBZrUcCa1
         UMuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715758859; x=1716363659;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TLhn4fqdh7o5svdDGhY37fd8hSl+dswnienDJA3jE4w=;
        b=OTY7I8PskVeO/rgBpDSwS4bdXjYizR6njNgpLfizv0ktga/OlOXODtn/cTLbqcf/Ew
         YTAqCFFY5UuLJVy0GNYR7uQDU2DKcAH6jomK6VRa/ddrpOGw68qFIFRTNpTbpkZkAnY4
         B37fAwz0ODajWocgblRqLSD9sW9dwleMzswOhAO7e1GuAfEtG+/qLeP05QkWDuhC0pFK
         uVzN3zBSzNdpAKLXYSiWeH6SM/jY10rBRslRBy5Tp8ZojRcOvOuBz4Lo0F90QQOJhCG0
         bPoAQfSlnVEMFBcD+SX7tAf7ee/+Wts6w2qv0WNcomcxYP1ncbqRX1pVdQdFp8z1jPJ5
         q8bQ==
X-Forwarded-Encrypted: i=1; AJvYcCWC6IOCdu5Mjah025IGxZ6SZkXkjDxAEkdheBZseQBSTw3dBq63G5HmQJhgHdEWsu0BvQ2DlZzsdPU+vz4rN82l/XqlZnxGrxXNjD2emHDeW/4ly55coq2dbM/lLBYsoX14enj69qCk418DOYfiRkW+wv/joXOwip59ZrEAeu6kVndH
X-Gm-Message-State: AOJu0Yzpbgq6OpmkK5aowEtbWxaU7/G3PV7mFHzsYkvhg/lGjkJIkkpa
	Av/E9Qm1WDfiPBJW1w1o+F8XdaOfD4ufk8tG8t44zzcDuE+bnR6K
X-Google-Smtp-Source: AGHT+IFAoB28Oxhj1Qe9IKvpyG7rsjUv6rTIqwphEgorIUy9cjMuH127glK9Bi63tCvYIjYKLEYIaQ==
X-Received: by 2002:a05:6830:f8c:b0:6f1:23cc:b4ff with SMTP id 46e09a7af769-6f123ccbc9amr1247245a34.11.1715758859033;
        Wed, 15 May 2024 00:40:59 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-63411530b0esm10843078a12.88.2024.05.15.00.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 00:40:58 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 14 May 2024 21:40:56 -1000
From: Tejun Heo <tj@kernel.org>
To: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	Josef Bacik <josef@toxicpanda.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>, linux-mm@kvack.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, Zhaoyang Huang <huangzhaoyang@gmail.com>,
	steve.kang@unisoc.com
Subject: Re: [RFC PATCH 2/2] mm: introduce budgt control in readahead
Message-ID: <ZkRnCDasZNvFQUaY@slm.duckdns.org>
References: <20240515012350.1166350-1-zhaoyang.huang@unisoc.com>
 <20240515012350.1166350-3-zhaoyang.huang@unisoc.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240515012350.1166350-3-zhaoyang.huang@unisoc.com>

Hello,

On Wed, May 15, 2024 at 09:23:50AM +0800, zhaoyang.huang wrote:
> +static unsigned long get_next_ra_size(struct readahead_control *ractl,
>  				      unsigned long max)
>  {
> +	unsigned long cur = ractl->ra->size;
> +	struct inode *inode = ractl->mapping->host;
> +	unsigned long budgt = inode->i_sb->s_bdev ?
> +			blk_throttle_budgt(inode->i_sb->s_bdev) : 0;

Technical correctness aside, I'm not convinced it's generally a good idea to
bubble up one specific IO control mechanism's detail all the way upto RA
layer. Besides what's the gain here? For continuous IO stream, whether some
RA bios are oversized or not shouldn't matter, no? Doesn't this just affect
the accuracy of the last RA IO of a finite read stream?

Thanks.

-- 
tejun

