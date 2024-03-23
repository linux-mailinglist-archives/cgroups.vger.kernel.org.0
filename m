Return-Path: <cgroups+bounces-2141-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 900468876DC
	for <lists+cgroups@lfdr.de>; Sat, 23 Mar 2024 04:17:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1DF51C22337
	for <lists+cgroups@lfdr.de>; Sat, 23 Mar 2024 03:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59CC138A;
	Sat, 23 Mar 2024 03:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lAyeo7Oq"
X-Original-To: cgroups@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDB41362;
	Sat, 23 Mar 2024 03:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711163858; cv=none; b=doV4LKx1+tRAG4tmPpnabiwlz6N+MF+nNNLtf+p83yZtSuctkSb/Eq6Dbpfe5HKNmZVc9/eeataMTIg4MEH8SMysIoy3plriav7s2V/zb6wkYCiZIAIByMyH/N9DmgjvkUSTj8yuFaS6999N60lk5ZRQM8qvj/aFK7f40ZgFiqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711163858; c=relaxed/simple;
	bh=HstrJLs9qezvI3wb0xdII2caCNCSQrsje9f24JVu5m8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WtuPVaihSOz2W4zcoRKpZQbiuJmmBSj5mMpa6Ft/cW49br0J6tZUnTE9i9PubLfa4TwBi3GKkNkEMHw+7aGXvjKh3j4Gbyt8WgovtYhbNJAQegS7tzZR+p8OU3Jsq35r5r8xsqAjHKV2NzqcmhNigyr+RPqxYJluEoiqu0opvPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lAyeo7Oq; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=kPanuUPmB0BXN/f8Xx3i3XBoQ2rItQS2/Ad+tn9F05I=; b=lAyeo7OqJ7uXzggwgtsRCKRrFk
	QkgQllyUYVBASYCEvFKpRgPxAVj/k5eBSPzpllezso36AkGujf8dER7lbeRIrYTKfHSzgwkWi3vKV
	lIRJUidQ0qB9J69Zt5CaYYDvEL0C6lemizOmCBHulq5PZKVAUkiUdh7dxMF6rnFOYwisY3hK4Ve9F
	ok9/XSJzd74gVCXYIap1P8dUAxRYn5ICnFpS0tr3OT4/OW9LMqHPQkUF0htPAwUYDrIoQgUKjPpVL
	t/NDZMTf0lfMgRfBTjMCW+auSqXzUQv7c+sMEaq0RptgNNiDxbJM/THx6prIzsNx5NzBLHkzgXamO
	u4H4Qw+w==;
Received: from [50.53.2.121] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnrsu-00000009KHR-1fpG;
	Sat, 23 Mar 2024 03:17:28 +0000
Message-ID: <bf3715e1-bf44-44e6-8877-4bbcfe5f3f98@infradead.org>
Date: Fri, 22 Mar 2024 20:17:26 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next RFC] blk-throttle: remove
 CONFIG_BLK_DEV_THROTTLING_LOW
Content-Language: en-US
To: Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk, tj@kernel.org,
 hch@lst.de, ming.lei@redhat.com, josef@toxicpanda.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, yukuai3@huawei.com, yi.zhang@huawei.com,
 yangerkun@huawei.com
References: <20240323025322.1310935-1-yukuai1@huaweicloud.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240323025322.1310935-1-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi--

On 3/22/24 19:53, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> One the one hand, it's marked EXPERIMENTAL since 2017, and looks like
> there are no users since then, and no testers and no developers, it's
> just not active at all.
> 
> On the other hand, even if the config is disabled, there are still many
> fields in throtl_grp and throtl_data and many functions that are only
> used for throtl low.
> 
> At last, currently blk-throtl is initialized during disk initialization,
> and destroyed during disk removal, and it exposes many functions to be
> called directly from block layer. Hence I'm planning to optimize
> blk-throtl and finially support building it as kernel module. Remove
> throtl low will make the work much easier.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  block/Kconfig        |  11 -
>  block/bio.c          |   1 -
>  block/blk-stat.c     |   3 -
>  block/blk-sysfs.c    |   7 -
>  block/blk-throttle.c | 901 ++-----------------------------------------
>  block/blk-throttle.h |  26 +-
>  block/blk.h          |  11 -
>  7 files changed, 45 insertions(+), 915 deletions(-)

Here are 2 more places to patch:

Documentation/ABI/stable/sysfs-block:           CONFIG_BLK_DEV_THROTTLING_LOW is enabled.
arch/loongarch/configs/loongson3_defconfig:CONFIG_BLK_DEV_THROTTLING_LOW=y


-- 
#Randy

