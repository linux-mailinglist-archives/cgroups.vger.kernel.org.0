Return-Path: <cgroups+bounces-7792-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8016A9A8BF
	for <lists+cgroups@lfdr.de>; Thu, 24 Apr 2025 11:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35A311B8682B
	for <lists+cgroups@lfdr.de>; Thu, 24 Apr 2025 09:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00527247293;
	Thu, 24 Apr 2025 09:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qlHe8hh3"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B028E221261;
	Thu, 24 Apr 2025 09:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745487594; cv=none; b=E9/MGxfU415m9iOlVbr3V5zZeWWDH0Win+ryPgifspZu4U1nodKBzvNAsPryHyrF9BZuKp/DJop+Pu8qN4JbGgnOSsap7VfjTTezFMOHSYOLc+tjk6r5gxnbPR9c2BzTMX6L9GrYlLVoJZDdxVz1yGTZiEytERCm8oMNjf+XAgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745487594; c=relaxed/simple;
	bh=Fu1D6/3SMuBcvONuuAZrd45zEnd8X8dCBTBRjeIPM7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pJAA1EnfZBHCln5MN8/uGSxr22xTU2wOAehhYIrKNfy1DBjwnKrm9XGuxKEn2+oPVx0NAKJL/vspVFd7jYHB163wCFdNfSonuljYYg0178GLB3l1OCbQownizZGMgGo/EgmfhYx1odj/mMI9qF2i58IZl7NJ5ONIakPNadz/TJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qlHe8hh3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83A40C4CEED;
	Thu, 24 Apr 2025 09:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745487594;
	bh=Fu1D6/3SMuBcvONuuAZrd45zEnd8X8dCBTBRjeIPM7o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qlHe8hh3EbdSEoUlNGm4cBIefYx+vHJdO0uU4/yuNv/U9SlAaWsBbzZyUfzGe+spU
	 lVEt8UKB6tvYJIcSshD9apuyoJuB6KdPjjBWtMCCi4GPtkG8g63XwqTxKNKtjeiQ2L
	 NwDnbsl1ODeMudm6OVZdPphLQRVJXvioGjsXf1tVTQyn8leDo96O1UUYz1vlFu954b
	 1pdmBPX3ipq2sm3tijmFxkUhIZiRAB76CHtGPWiUH5iOrqLm8TlrjU+0lqho+Y/S+y
	 CV288iHU1kOtUr+h7NPhP9pUyxWpmiYSzheZlTh0kjO8z4qXPkgRYjy9vmRr66vrQj
	 xlxPB4+6JS1+Q==
Date: Thu, 24 Apr 2025 11:39:50 +0200
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>, 
	Josef Bacik <josef@toxicpanda.com>, Christian Brauner <christian@brauner.io>, 
	linux-block@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: don't autoload block drivers on stat (and cgroup configuration)
Message-ID: <20250424-grabmal-storch-1899923883a0@brauner>
References: <20250423053810.1683309-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250423053810.1683309-1-hch@lst.de>

On Wed, Apr 23, 2025 at 07:37:38AM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> Christian pointed out that the addition of the block device lookup

Thank you! And sorry I just sent you a mail complaining about this
again. I didn't see this patch series until just now. Thanks for doing
this!

Reviewed-by: Christian Brauner <brauner@kernel.org>

> from stat can cause the legacy driver autoload to trigger from a plain
> stat, which is a bad idea.
> 
> This series fixes that and also stops autoloading from blk-cgroup
> configuration, which isn't quite as bad but still silly.
> 
> Diffstat:
>  block/bdev.c           |   17 +++++++----------
>  block/blk-cgroup.c     |    2 +-
>  block/blk.h            |    3 +++
>  block/fops.c           |    2 +-
>  include/linux/blkdev.h |    4 ----
>  5 files changed, 12 insertions(+), 16 deletions(-)

