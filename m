Return-Path: <cgroups+bounces-3176-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D179063A1
	for <lists+cgroups@lfdr.de>; Thu, 13 Jun 2024 07:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 283071C21933
	for <lists+cgroups@lfdr.de>; Thu, 13 Jun 2024 05:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9113136987;
	Thu, 13 Jun 2024 05:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gLjc4Ukv"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EDB633;
	Thu, 13 Jun 2024 05:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718258077; cv=none; b=EUBuOFAubvVF1I1Ej1ivjpwIN/ThNwLnT9nr+hX2foMxAkuEmmBmWIGMILJ1f0dSwH7i9Tsq4XoCUUuGK6X0PddVb2r7ACSYKajd2pzzbLvnAHe7BM+jH/SJet8/eUEdcu7lQnfmcXRnYH21Bvxt6HKN2Zu4N4+3C0POMT0vKIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718258077; c=relaxed/simple;
	bh=hK1EwviYFbf5k674Rrp8MqceOgTb5+SomfHwplTuMiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HGaVYlXN43wI7Fqwg9bMzwe/DlL1MojS8TmdGMeSkoNMp743b/VJZ8cwL0gDxem8m4EfwcP9fX90RbXf9/OAPYYiHvfHnKCkpDKlPXoPSeo19rMne7+B9p+bBnDxNRFYJRpROyNk5NteB8E8X0WLr3UEJAPWHnDMsdNfaGt17JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gLjc4Ukv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAD6DC2BBFC;
	Thu, 13 Jun 2024 05:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718258077;
	bh=hK1EwviYFbf5k674Rrp8MqceOgTb5+SomfHwplTuMiM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gLjc4UkvDa7d/f+jtxS4cuanBOn/IJJp88sHEi8web4BHcB/MWFUMobdv87Nd/7Kx
	 Kzu7wXlue2jiGZnOc9pklszfZXqww/D6w7rAmVZEca5G1NL7fpuOS7j8U/zA9qBb3o
	 ejJ4jlJlcKC7M+e+sEfqXyb5uMu8buTHI6Z+m9ZA=
Date: Thu, 13 Jun 2024 07:54:34 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: axboe@kernel.dk, tj@kernel.org, josef@toxicpanda.com,
	lizefan.x@bytedance.com, hannes@cmpxchg.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, yukuai3@huawei.com, yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: Re: [PATCH RFC -next 7/7] blk-iocost: support to build iocost as
 kernel module
Message-ID: <2024061314-gawk-unpaid-81d3@gregkh>
References: <20240613014937.1326020-1-yukuai1@huaweicloud.com>
 <20240613014937.1326020-8-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613014937.1326020-8-yukuai1@huaweicloud.com>

On Thu, Jun 13, 2024 at 09:49:37AM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  block/Kconfig             |  2 +-
>  block/blk-iocost.c        | 14 +++++++++++++-
>  include/linux/blk_types.h |  2 +-
>  3 files changed, 15 insertions(+), 3 deletions(-)

For obvious reasonse we can't take patches without any changelog text.
Nor can we review them :(

greg k-h

