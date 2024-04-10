Return-Path: <cgroups+bounces-2434-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA408A00E7
	for <lists+cgroups@lfdr.de>; Wed, 10 Apr 2024 21:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7DB21C2212B
	for <lists+cgroups@lfdr.de>; Wed, 10 Apr 2024 19:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1487C18133B;
	Wed, 10 Apr 2024 19:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yxgoha2k"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C54428FD;
	Wed, 10 Apr 2024 19:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712778836; cv=none; b=iz07hoVR9Bp692Jm/F8e92CQiBaY5YeqbuNn1/SI1ATxP7mzPtQjx8IYh2Z2tfuIXflY84mWGJopFKcDDJZDfIxSFeq8pU+ksG5piZpha1ortoLzpIRFDVSiP2uSmYpie5SWVNe4rj1NcHxw7zOxKgqQ5wR187qWNnuzFCwIcpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712778836; c=relaxed/simple;
	bh=/gzrab9sjjLCDQ6VDRJrkCIVoiCcc5F44HEM5Lx1Wxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fCcCaZgX8u5YKO7tXhbY62NEGQoQPC8vv2H5pA7AHXVMRZLVDSqBrqRjdL2t0oZwdPcb0/cNPcM+0Iuc8C+/vaUWBM6WZQ/jatxp93kQdPqEbAS+s+kRrEMj+w2wcvuv8s1M+nyZTigyhbmo34fSNd1VIhmBjoN0FpIM5ZMpEMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yxgoha2k; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6ed20fb620fso3372588b3a.2;
        Wed, 10 Apr 2024 12:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712778835; x=1713383635; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9LLpYn6RY+9fmh/DEGHkQYLiUAYafku1LckmK98WH34=;
        b=Yxgoha2kL19hmet5BgDig0Jsj/o9EeLXC5tei1ccue5csVlagoDOoM72hTr667GyWh
         +0y0epT3YSYL/TQWTCwO7l8cO0+77qXkSljm2MznB4yxlLJ1SCIhr4YjCfxoNYmyTpCb
         p24Y4qXaZ3iCdg0kLT+9Uayad0sf3jJyUd5V1/tzVaPAIzXk+o4xsg/PmhI+d632mnHB
         QnJJqSYMTQzfAUoF8iw3MGvjOJLbc1yoDY2DzVl61J6QRq3WpIECX3Ymxp/GsGpJsGG+
         lHEYkvn7jhVcncwrgsPnetvn/cZIJqN8HXEUETuKbW/aRgfq0m7G5MoiXrbxUhQeR4ZL
         P8ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712778835; x=1713383635;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9LLpYn6RY+9fmh/DEGHkQYLiUAYafku1LckmK98WH34=;
        b=SECTIYH5Zo9gKnIVn2A+1+h0sSODWODnc9HYJ3LvTOlM8wUPIBuJcs9y/xIy9jwcl7
         XXFsxPHw0Oi00J7ZPaUMhkwKiDMxwM3agnO/pP0YLNSVn4pwoMWQwqKot3uu4jWMj8Kd
         JfBF74lhvnjUMdRhRfG6gFcJ5pSMBbxNpNoeBBUDIOwms+o9tFYnhlBExAjrb9K16X0Q
         TLYXJTj6Y60rYv6olJHIwq7vpNMryABjNM7Tq1tsYSpAbQyZizeZXmLtTqWDflLy2mBP
         0ehTnuxjbJtEFbVWbt9qx1SdpVDZoI3WKQUxN4ge6m4eM5QG1l/39DsrKYOnRt/1PlYy
         rB+Q==
X-Forwarded-Encrypted: i=1; AJvYcCV0PhQ/i/CQ+Qqhs/N2EuRZtehGm7Slzii3i/aN4NJvy7mfYtrDpgzF6r/entqenHXu2dcrstIn6jvj7SppWARUVMp1NWmhSMK2TOlMip/ca4ftf0FhcltyX8ELrBePNmyDifqB81OgvbIy/o2mAfqNsbpOYg+SK2Ggm9lv09JVv5OI
X-Gm-Message-State: AOJu0YxCl1sUJktteu4HJa8I+5BKu/YDSjrQ9wnGOhATfqZxzDRbaZEu
	Ety9PMPJzzYEnaGvwOJJZbfn8zu2Ly53eRjRsY/2tYu640wij70J
X-Google-Smtp-Source: AGHT+IHuPW954ptixzpDzELZzOQ7XNdbd+B9en0dSzEz+zcbSgQ6uda+APwZYb4XeW5oP6FiMtuJxA==
X-Received: by 2002:a05:6a21:3e0c:b0:1a7:11bf:7b74 with SMTP id bk12-20020a056a213e0c00b001a711bf7b74mr3495432pzc.62.1712778834624;
        Wed, 10 Apr 2024 12:53:54 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:a5f4])
        by smtp.gmail.com with ESMTPSA id gx15-20020a056a001e0f00b006e71aec34a8sm15295pfb.167.2024.04.10.12.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 12:53:54 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 10 Apr 2024 09:53:52 -1000
From: Tejun Heo <tj@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
	leit@meta.com,
	"open list:CONTROL GROUP - BLOCK IO CONTROLLER (BLKIO)" <cgroups@vger.kernel.org>,
	"open list:CONTROL GROUP - BLOCK IO CONTROLLER (BLKIO)" <linux-block@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] blk-iocost: Fix shift-out-of-bounds in iocg_kick_delay()
Message-ID: <ZhbuUKXQwBwye1_r@slm.duckdns.org>
References: <20240410193642.1303741-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410193642.1303741-1-leitao@debian.org>

Hello, Breno.

On Wed, Apr 10, 2024 at 12:36:41PM -0700, Breno Leitao wrote:
> When running iocg_kick_delay(), iocg->delay_at could be way behind "now",
> which causes a huge tdelta difference.
> 
> The tdelta value is used to shift some bits around, raising the
> following UBSAN splat:
> 
> 	UBSAN: shift-out-of-bounds in block/blk-iocost.c:1366:23
> 
> Debugging this, these are some values I got in my machine with 6.9-rc3.
> 
>  now = 3626064295
>  iocg->delay_at = 3275794093
> 
> Fix this by validating that the shift if valid, otherwise bail out,
> similarly to commit 2a427b49d029 ("blk-iocost: Fix an UBSAN
> shift-out-of-bounds warning")

Rik alreaady sent a fix:

  http://lkml.kernel.org/r/20240404123253.0f58010f@imladris.surriel.com

which got commited as beaa51b36012fad5a4d3c18b88a617aea7a9b96d.

Thanks.

-- 
tejun

