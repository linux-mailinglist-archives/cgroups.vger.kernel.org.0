Return-Path: <cgroups+bounces-3551-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E5C928CF3
	for <lists+cgroups@lfdr.de>; Fri,  5 Jul 2024 19:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2BD31C243C3
	for <lists+cgroups@lfdr.de>; Fri,  5 Jul 2024 17:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A712A16D33B;
	Fri,  5 Jul 2024 17:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NQSdstOt"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A19916B3BA;
	Fri,  5 Jul 2024 17:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720199614; cv=none; b=rXo7WdJ8yqHhiC7bIQb1zC81O6lk6aaYfqtk9qN5KapI9pn2TZl4kPMsjUtwAw+QW0WlLVeNgDaHR7bmc0EEYFYBaY14bPMFbnVQZgOuKwAFMO1CKbwOPoikTNEQlPzNZ1u1tMBLtagQND91hut6Pwwa8zQ8J8ISiSDkS84tydE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720199614; c=relaxed/simple;
	bh=VGVomkM/rYHhvPwoV2bSDwfdJBUjSxyszcJm5AMp2fQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=apxl1vQ5z4BCrIEVthAL+IYEulz8J2JGtWdKKHn+ABY2QKjLuS43lLedfy9I1cy6nTUWDuci8lZ0atk9sjj+CyX+OYevGLCyFuA9yabFiFO4sAlxS787glYnFIcdZqoMj3f5pMzlsSqYIIvpYistM93H7ic0dPUz7lCxnst5SZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NQSdstOt; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fb4fa1bb34so4844665ad.0;
        Fri, 05 Jul 2024 10:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720199612; x=1720804412; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jVFbWqs/ujGoWS6V+Wtmkt0OqRspry6ZAA+kHzk0dpg=;
        b=NQSdstOtTF9ZZMGADBw8fYWGmyUt9hHlPiIaNiwVzDTvFLRxK5vzNiNgQ+zMqYOO5T
         OOCmnLfUheCLM11LKYzx+O3Raltm/Hc7uta419CXzmZ19mP0cw7fQF0CV+n884WDEz33
         v6mCioBVPJTRRfQXlSpU0h5GG94dYT8+7xZUb57MJD2pTBZ1Ft9NLE2o8yltvB4AU8Ml
         oovdOI7j/BKiFE1dTybrShnEutPN1g3HTpVzE3rA5bgOnUcP6D+AWweE25oqgwzS1anV
         1nRcCcBMLnrH0D+eQkAQOw+QSVFRu6gkK9fzYRK39Wua6cTR8N7FuIotmrtvURNe6r+n
         QyUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720199612; x=1720804412;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jVFbWqs/ujGoWS6V+Wtmkt0OqRspry6ZAA+kHzk0dpg=;
        b=dfFiUYBDJg4quF/H+KmHp9LimyCG2gHxGZpDVN25wERQpJONECTE6F34pi0OKLgWnQ
         Rua9cIgoIDYLIyRlXwZxmKSdZub3Q0jZBmNYMReYcYDLOCM3lzVc1Bytk0KMCoIZ0rtB
         bsJITTM7j/ervg3QrYLRQhTxJPZgOnbA3Q8ulZPbwM45PFWBXbfBXUJHbAldK6wzti8o
         p4KaNVIQokMm4+BHpOP2GWJxni9Ac5uTmXlVtnNwBIHq4KHjPWVzbdk3HvyGDcLffx3C
         1KjbIe5v1Vg4YLhXkUIVMhmEikvCdoHGlJZC20FSRZjERA1BEN7M40bFHNN4SZGLAzBD
         qgZw==
X-Forwarded-Encrypted: i=1; AJvYcCWFev5TZSaFIQu6TqcZaJotj0D85WvghgKcq54FBcgHPu7co3jp9n+/yCW2S+0S2cLeECwTq009CN8U+htnm/9Gbg60MsNf50hMcAaW/7kqnr4Twf1wFxNprk/Dm2mPbBzmDvZDCD1WXxrpHN2SORCn7sV1dkgAyxMzzbIU2HosSRA5
X-Gm-Message-State: AOJu0YxjmjxkKFgM8nXqVBxINglY3zn3I3hvbOE+vttswycvf1gr/3LC
	EmY0HcSHb6UTVII8EUl5bfrym268Ev2Hib+evwwTIHLiZAapi17O
X-Google-Smtp-Source: AGHT+IH31dSGm35koHtTUahNqqOpbaEin66n8iLUwVNuXlEOt+qvmQRWPJFKWZW/d4uoEwNBfCOkVQ==
X-Received: by 2002:a17:902:6805:b0:1fb:3474:9527 with SMTP id d9443c01a7336-1fb34749830mr30241585ad.25.1720199612155;
        Fri, 05 Jul 2024 10:13:32 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fb57299335sm10136725ad.128.2024.07.05.10.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 10:13:31 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 5 Jul 2024 07:13:30 -1000
From: Tejun Heo <tj@kernel.org>
To: "boy.wu" <boy.wu@mediatek.com>
Cc: Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Boris Burkov <boris@bur.io>, cgroups@vger.kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, iverlin.wang@mediatek.com
Subject: Re: [PATCH] blk-cgroup: add spin_lock for u64_stats_update
Message-ID: <Zogpum23mjHZC8yO@slm.duckdns.org>
References: <20240705075544.11315-1-boy.wu@mediatek.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240705075544.11315-1-boy.wu@mediatek.com>

Hello,

On Fri, Jul 05, 2024 at 03:55:44PM +0800, boy.wu wrote:
> From: Boy Wu <boy.wu@mediatek.com>
> 
> In 32bit SMP systems, if the system is stressed on the sys node
> by processes, it may cause blkcg_fill_root_iostats to have a concurrent

What is sys node?

> problem on the seqlock in u64_stats_update, which will cause a deadlock 
> on u64_stats_fetch_begin in blkcg_print_one_stat.

I'm not following the scenario. Can you please detail the scenario where
this leads to deadlocks?

Thanks.

-- 
tejun

