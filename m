Return-Path: <cgroups+bounces-4835-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1391E9744B4
	for <lists+cgroups@lfdr.de>; Tue, 10 Sep 2024 23:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2AF71F26AE2
	for <lists+cgroups@lfdr.de>; Tue, 10 Sep 2024 21:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164011AAE38;
	Tue, 10 Sep 2024 21:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J81oXUlp"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26A823774;
	Tue, 10 Sep 2024 21:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726003159; cv=none; b=Lm+9Tad8aVIUBz1TrrWFSxPVitVmtzo3QTX7ZO3byWLj6kchtQ9pBtGWuuE9ewsMEp+WytyhUG7VRHNqgf1ASTKDQfEy9n6Elh18XG7bTnf9zUQIEzOzsH9nOeYy7LB34L9wvsaJCfbl4biGU5lpDLomhWTesNgP5rUdW7xu908=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726003159; c=relaxed/simple;
	bh=MPDj1SGwwOCMCVLZEATJhLlQx2eSypRL742ONHdEA9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tNu7qYB/GAZtr2G10taMxuiu2DQhHNqMU2g51/57tI57bPPz8jJF0Ybld1R7y2uHA4wMtYWJPx8bwLKa/Ad9VyVLLFzFYvyUM+EPx0nz5p/5PJreosHAglhJF9T/MsBhNvARYQS8ATp/WnMyTXGCkFTH9G3/j1tw93+hQb+rhPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J81oXUlp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CC8EC4CEC3;
	Tue, 10 Sep 2024 21:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726003159;
	bh=MPDj1SGwwOCMCVLZEATJhLlQx2eSypRL742ONHdEA9w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J81oXUlp4rb/gPRGW4izOxRdjVlQp3bOHkB3dcKqNO957k9Z3BCDe/Yh6x3c8roXh
	 5wZnDE8UnoMDhlXxVgJUYWXCDKsOewChcLFzcjNbSKiLDATGLK33Z4zSTzfC1FFmRW
	 K+EWsGyoOP6dqJbajljQSyelKKGlP9Xuwmoz/AE6R6cJnQQ8oLD8at1U6Us24sGrDO
	 XC1NxKaRyUFis84fUDk7ylXlnzjTBlzizvQ6caS0Mqimw6pXoXjl8yW0Ed1mJ2ZrAV
	 Pec5oJ9Dymsedw3pPwrmMhL2I2jxXapLVCGG+cpVHsuoajJJGSEVtZk6ZtBVQsLoiY
	 dINUPvBxtge+Q==
Date: Tue, 10 Sep 2024 11:19:18 -1000
From: Tejun Heo <tj@kernel.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH for-6.12 2/2] blk-throttle: support prioritized
 processing of metadata
Message-ID: <ZuC31sqB6qUd_Gut@slm.duckdns.org>
References: <20240903135149.271857-1-yukuai1@huaweicloud.com>
 <20240903135149.271857-3-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903135149.271857-3-yukuai1@huaweicloud.com>

On Tue, Sep 03, 2024 at 09:51:49PM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Currently, blk-throttle handle all IO fifo, hence if data IO is
> throttled and then meta IO is dispatched, the meta IO will have to wait
> for the data IO, causing priority inversion problems.
> 
> This patch support to handle metadata first and then pay debt while
> throttling data.
> 
> Test script: use cgroup v1 to throttle root cgroup, then create new
> dir and file while write back is throttled
> 
> test() {
>   mkdir /mnt/test/xxx
>   touch /mnt/test/xxx/1
>   sync /mnt/test/xxx
>   sync /mnt/test/xxx
> }
> 
> mkfs.ext4 -F /dev/nvme0n1 -E lazy_itable_init=0,lazy_journal_init=0
> mount /dev/nvme0n1 /mnt/test
> 
> echo "259:0 $((1024*1024))" > /sys/fs/cgroup/blkio/blkio.throttle.write_bps_device
> dd if=/dev/zero of=/mnt/test/foo1 bs=16M count=1 conv=fdatasync status=none &
> sleep 4
> 
> time test
> echo "259:0 0" > /sys/fs/cgroup/blkio/blkio.throttle.write_bps_device
> 
> sleep 1
> umount /dev/nvme0n1
> 
> Test result: time cost for creating new dir and file
> before this patch:  14s
> after this patch:   0.1s
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

This is a lot simpler than I expected. Great.

 Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

