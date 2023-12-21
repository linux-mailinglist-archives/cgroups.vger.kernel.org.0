Return-Path: <cgroups+bounces-991-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E42381C065
	for <lists+cgroups@lfdr.de>; Thu, 21 Dec 2023 22:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C38D61F2825A
	for <lists+cgroups@lfdr.de>; Thu, 21 Dec 2023 21:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06FDA7765F;
	Thu, 21 Dec 2023 21:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eK+FQoFU"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883E27762C;
	Thu, 21 Dec 2023 21:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-28bc870c540so1001754a91.2;
        Thu, 21 Dec 2023 13:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703194964; x=1703799764; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BXPgr2T6k2cqQM51LPyd+8bHsl0/1iqBgZw3ozm4OmM=;
        b=eK+FQoFUPU8P0LDUwnlXlF0RVzLlKDDKunolM4fz5VpgQ/NqC8MgWwM3N3/7tfxhTI
         ImqosN4pbZ0Yq/yw+TE+sYYhdRfDYQlMnNXLcDI+h2bmFUa3EuRkOHICCNKUxmWUAZAb
         Nqt/WTXJ9xiVnQzpGYY/mFoPX3I4ia4OGC75sqObfvyhqW9yJMxGwpboSrQBIcf4NGEy
         /m8vNXdGm2WvgrRTJpc6mlU2b1Dv2fTM6dgo9gTrtwhgOSmCRG/l8z6mjAXfgnt8RbSg
         riC0zVBqtBk6Hum/npER+Rd0+B3YpgqLHGVX9dKt4GPuX56Sh03GoBi4l7iDGE9nVuig
         6kmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703194964; x=1703799764;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BXPgr2T6k2cqQM51LPyd+8bHsl0/1iqBgZw3ozm4OmM=;
        b=MHvax+rZu4w2Z9ClboKbkMG3RMTMHtrKhLIchLKjXdVm/OKX9UMLIMK/IzT+o0Dw7l
         1B+nKuvPHozQz8fwhOgs4VG3JdG79z0gpwDTIalN/jJ30wwNc8n2OUsiwKg0MeGUSR2v
         ZJFwCvzOtwm6zTsxIThhNnLmtUugKx3xr6SICYUXbKw7ehs2ViC5CDkIyDKgmgcBLnEL
         5Jzf4MbgBntSNGjqeINWspKWaHOT/zBPgCO88RZhHjm34CbAq40FdB3/gdzTis9CBohh
         qU9TBeinDE5Y44UO6q8kAw91gzXUVYrCvnMjJbMDkKs4H7njC2CN+SkKPYbHdouLYf06
         g4OQ==
X-Gm-Message-State: AOJu0Yyo92sO2XeNyz2nL7qpNiLwXPmjigKRb4WX6iYQ+5XeWrB3bunm
	uf/dLw89G0JjTCQfN6yyvN0=
X-Google-Smtp-Source: AGHT+IFXgwvw7NCQiXUJrDPOJqYvUyH5h3zVjuOWbcYEagdQHOCFWNaI2Vs852k/Nvm2+CpNQB64dg==
X-Received: by 2002:a17:90a:cc05:b0:28b:e25a:9c25 with SMTP id b5-20020a17090acc0500b0028be25a9c25mr376993pju.10.1703194963716;
        Thu, 21 Dec 2023 13:42:43 -0800 (PST)
Received: from localhost ([121.167.227.144])
        by smtp.gmail.com with ESMTPSA id ei8-20020a17090ae54800b0028bd9f88576sm2262757pjb.26.2023.12.21.13.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 13:42:43 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 22 Dec 2023 06:42:40 +0900
From: Tejun Heo <tj@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
	Shaohua Li <shli@fb.com>, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org, cgroups@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH] blk-throttle: Fix some potential string truncation in
 tg_prfill_limit()
Message-ID: <ZYSxUPan9qPNE5Bk@mtj.duckdns.org>
References: <0461f1d69c84cf5a98ae57012856dace757d319e.1702731206.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0461f1d69c84cf5a98ae57012856dace757d319e.1702731206.git.christophe.jaillet@wanadoo.fr>

On Sat, Dec 16, 2023 at 01:54:56PM +0100, Christophe JAILLET wrote:
> When compiled with W=1, we get:
>   block/blk-throttle.c: In function ‘tg_prfill_limit’:
>   block/blk-throttle.c:1539:74: error: ‘snprintf’ output may be truncated before the last format character [-Werror=format-truncation=]
>    1539 |                         snprintf(idle_time, sizeof(idle_time), " idle=%lu",
>         |                                                                          ^
>   block/blk-throttle.c:1539:25: note: ‘snprintf’ output between 8 and 27 bytes into a destination of size 26
>    1539 |                         snprintf(idle_time, sizeof(idle_time), " idle=%lu",
>         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    1540 |                                 tg->idletime_threshold_conf);
>         |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   block/blk-throttle.c:1546:43: error: ‘%lu’ directive output may be truncated writing between 1 and 20 bytes into a region of size 17 [-Werror=format-truncation=]
>    1546 |                                 " latency=%lu", tg->latency_target_conf);
>         |                                           ^~~
>   block/blk-throttle.c:1546:33: note: directive argument in the range [0, 18446744073709551614]
>    1546 |                                 " latency=%lu", tg->latency_target_conf);
>         |                                 ^~~~~~~~~~~~~~
>   block/blk-throttle.c:1545:25: note: ‘snprintf’ output between 11 and 30 bytes into a destination of size 26
>    1545 |                         snprintf(latency_time, sizeof(latency_time),
>         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    1546 |                                 " latency=%lu", tg->latency_target_conf);
>         |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> In order to fix it, remove all the intermediate buffers and write directly
> into the 'sf' seq_file.
> 
> Fixes: ada75b6e5b2a ("blk-throttle: add interface to configure idle time threshold")
> Fixes: ec80991d6fc2 ("blk-throttle: add interface for per-cgroup target latency")

I'm not sure Fixes tags are necessary here given that this isn't something
we'd hit in practice.

> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Looks fine to me, so:

  Acked-by: Tejun Heo <tj@kernel.org>

But, can you please briefly explain how you tested the patch?

Thanks.

-- 
tejun

