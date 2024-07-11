Return-Path: <cgroups+bounces-3632-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B9C92EE60
	for <lists+cgroups@lfdr.de>; Thu, 11 Jul 2024 20:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FCA51C21EEE
	for <lists+cgroups@lfdr.de>; Thu, 11 Jul 2024 18:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0FF16DEC6;
	Thu, 11 Jul 2024 18:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="35GOoYlz"
X-Original-To: cgroups@vger.kernel.org
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D640116D33F;
	Thu, 11 Jul 2024 18:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720721039; cv=none; b=Zo5hFW5tD6vSH9CCjJlSVtxi5/7pXm5pyoUNBfEtHXt94lTj4GnkkYgIdX2OX0i4ov8hfygFj/fzBu0+wEL8lC1Jji0zTEjgM8PvPuov38dj+3YzQ8XI9fHtsOECXMRUTOCPoxK74Lb9ML8jc0Fgt3Q9SDd66w4PAGPWKpo+KiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720721039; c=relaxed/simple;
	bh=pab+mbEW8dwG9AGWYRD0lodd45oLps+hgZoI7xasCZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=doN5voq/ij128XOpcONmzqLZSBg/XAj8sb2CSvyrMf/lvf884tWM2oKcWeb4fScu3gKUzv/P6Gp98eI3sooiCRvDaHx9UmP6ub0dEbIYSFINg7a3urVqsUPoMbC1zMbWVnaKwHT0cAx4Rs7XArE7LFy92K1trAv4FAfg1IgtMr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=35GOoYlz; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4WKjK919fWzlgx6s;
	Thu, 11 Jul 2024 18:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1720721034; x=1723313035; bh=pab+mbEW8dwG9AGWYRD0lodd
	45oLps+hgZoI7xasCZg=; b=35GOoYlzZ3l8VcLtmxmrULG5mUhE1j6ep/3nDBiT
	RhlCkaUPv/iRzciw6FC+VztDCBCROGtbeHqECYKgi90RbEMSA5KojLcYNzJCr2GY
	mQR/HyKl2aTHl2injaQIMz5Xql+cvzj2wRQtGUKpfT0a9AmvJvx/9khevqZpn1cQ
	QMJbMCBHYZk1KkrswuQS3BtaEPJRhr7xlTP5XMpYxKOecZE/YzOw0WTghZOTu6Fw
	V8bG/6UyT73AnIKgPoKmTxJ0Zb6trv1QKLOYgTnIierUP7ZnEdBvW6G0mQk7TQpE
	/gxct5f5nBciTVYNZwZfdgNdhM3SNRMIjSQHxHy4TR+RMA==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id TWGyb7_uIrbK; Thu, 11 Jul 2024 18:03:54 +0000 (UTC)
Received: from [100.96.154.26] (unknown [104.132.0.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4WKjK46vqVzllCRC;
	Thu, 11 Jul 2024 18:03:52 +0000 (UTC)
Message-ID: <4c8f1e4e-1b15-4afa-b1e2-084e0c4caeec@acm.org>
Date: Thu, 11 Jul 2024 11:03:52 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] blk-ioprio: remove per-disk structure
To: Yu Kuai <yukuai1@huaweicloud.com>, tj@kernel.org, josef@toxicpanda.com,
 jack@suse.cz, axboe@kernel.dk
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yukuai3@huawei.com, yi.zhang@huawei.com,
 yangerkun@huawei.com
References: <20240711090059.3998565-1-yukuai1@huaweicloud.com>
 <20240711090059.3998565-3-yukuai1@huaweicloud.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240711090059.3998565-3-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/11/24 2:00 AM, Yu Kuai wrote:
> ioprio works on the blk-cgroup level, all disks in the same cgroup
> are the same, and the struct ioprio_blkg doesn't have anything in it.
> Hence register the policy is enough, because cpd_alloc/free_fn will
> be handled for each blk-cgroup, and there is no need to activate the
> policy for disk.

As one can see in the output of git grep -nHEB1 '>pd_(alloc|free)_fn\(',
none of the pd_alloc_fn / pd_free_fn callers checks whether or not these
pointers are NULL. Hence my question why this patch does not trigger any
NULL pointer dereferences?

Thanks,

Bart.

