Return-Path: <cgroups+bounces-6721-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9651A46750
	for <lists+cgroups@lfdr.de>; Wed, 26 Feb 2025 18:03:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E12B426135
	for <lists+cgroups@lfdr.de>; Wed, 26 Feb 2025 16:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294D521C9E8;
	Wed, 26 Feb 2025 16:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MLxnVBLw"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EBC21D594;
	Wed, 26 Feb 2025 16:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740588524; cv=none; b=OgQfPPJzhzGcRuU3zLCHEUeMlRatE47IrB2I5FzLGbPZaS9vyEjtj52vWKE25lX8lOM4P4RGnXsOshxtJaH97Rp8w6gUSrYsnt83UT37TVVKH+Y7KMHI2WFJSyR0GGEj8I6RsWmzsVhGNbfsyubGMNZFvOw47EKJyv1Z8babpGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740588524; c=relaxed/simple;
	bh=cudwfSFk+04xxJC0BxMm+5FmyfHUG/wZm2fscloKh1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EIZiVTGRvAbVeyCQI2oXAKTrHhcUW3FWWJZGkRc7vsOQBknJhUFv9oC+CcsgwPXLJ2LW/HCapBwPMNQefhLE6CMiSBuuU8v3+s/SxQ907F9X7FVb1vMLQk4uPEFrrlOhVZSz+r7jxUCqUyWu61wQfxIXzJBHwWEgrUrsbDHoaSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MLxnVBLw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B523C4CED6;
	Wed, 26 Feb 2025 16:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740588524;
	bh=cudwfSFk+04xxJC0BxMm+5FmyfHUG/wZm2fscloKh1k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MLxnVBLwIzYmWNnND9nldb0LrWIDDYx/QB9Y26joWfuhvXEklTTbYl2orqF6JtrH8
	 61dh3G0GT+mhLPcLVWDoMdrw91KWrlDQAmLu+N46Y2puzex5GikBkgXD3SZ/0oIPRV
	 zZ2Pj9/bq3JnVuYVKOwZRKXTIPUxiYOZVzR3Zlia/2OQJO9z1rtcroKOChFA+cyYad
	 PWCZpbG2rDrwHGr12GOhkLS+v6QxMybkIiO/MF1QUOHOuXlsxFvT6FG2JXQEzMd6gF
	 6iGP7MNLhH4TzrXC/l4TjAa0WaK8n+clQjrCxaaVgtxBrb4D72mQSBvWRq9Twhdpio
	 OEp4T90UUhKtQ==
Date: Wed, 26 Feb 2025 06:48:43 -1000
From: Tejun Heo <tj@kernel.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: ming.lei@redhat.com, josef@toxicpanda.com, axboe@kernel.dk,
	vgoyal@redhat.com, cgroups@vger.kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH] blk-throttle: fix lower bps rate by throtl_trim_slice()
Message-ID: <Z79F6xfDbwVJ4psU@slm.duckdns.org>
References: <20250226011627.242912-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226011627.242912-1-yukuai1@huaweicloud.com>

On Wed, Feb 26, 2025 at 09:16:27AM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> The bio submission time may be a few jiffies more than the expected
> waiting time, due to 'extra_bytes' can't be divided in
> tg_within_bps_limit(), and also due to timer wakeup delay. In this
> case, adjust slice_start to jiffies will discard the extra wait time,
> causing lower rate than expected.
> 
> This problem will cause blktests throtl/001 failure in case of
> CONFIG_HZ_100=y, fix it by preserving one finished slice in
> throtl_trim_slice() and allowing deviation between [0, 2 slices).
> 
> For example, assume bps_limit is 1000bytes, 1 jiffes is 10ms, and
> slice is 20ms(2 jiffies), expected rate is 1000 / 1000 * 20 = 20 bytes
> per slice.
> 
> If user issues two 21 bytes IO, then wait time will be 30ms for the
> first IO:
> 
> bytes_allowed = 20, extra_bytes = 1;
> jiffy_wait = 1 + 2 = 3 jiffies
> 
> and consider
> extra 1 jiffies by timer, throtl_trim_slice() will be called at:
> 
> jiffies = 40ms
> slice_start = 0ms, slice_end= 40ms
> bytes_disp = 21
> 
> In this case, before the patch, real rate in the first two slices is
> 10.5 bytes per slice, and slice will be updated to:
> 
> jiffies = 40ms
> slice_start = 40ms, slice_end = 60ms,
> bytes_disp = 0;
> 
> Hence the second IO will have to wait another 30ms;
> 
> With the patch, the real rate in the first slice is 20 bytes per slice,
> which is the same as expected, and slice will be updated:
> 
> jiffies=40ms,
> slice_start = 20ms, slice_end = 60ms,
> bytes_disp = 1;
> 
> And now, there is still 19 bytes allowed in the second slice, and the
> second IO will only have to wait 10ms;
> 
> Fixes: e43473b7f223 ("blkio: Core implementation of throttle policy")
> Reported-by: Ming Lei <ming.lei@redhat.com>
> Closes: https://lore.kernel.org/linux-block/20250222092823.210318-3-yukuai1@huaweicloud.com/
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

