Return-Path: <cgroups+bounces-3631-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6852092EE56
	for <lists+cgroups@lfdr.de>; Thu, 11 Jul 2024 20:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F14A4B22E35
	for <lists+cgroups@lfdr.de>; Thu, 11 Jul 2024 18:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390E717C7B3;
	Thu, 11 Jul 2024 18:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="pAkdR3P2"
X-Original-To: cgroups@vger.kernel.org
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9174917BB3C;
	Thu, 11 Jul 2024 18:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720720871; cv=none; b=A0D3BAKkWFCsJyMFprXCeq+75ULovVLT/mkaMrhL9qeUB7t9oWjm1tm99VTvTDHoKI0e1a1uYdyQS0w3+DPgA707XxelNy8zXsVbCPa0tw3DLGTg5cmE2/Z2YEiveEESqw6nyDH8NcRqQTp1n4YhWtmqFhyPPB1/ZwYfDA1T2jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720720871; c=relaxed/simple;
	bh=EukfsqD8rodAYY6/mdsuH05IFV/tsORH99jQjePUr/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HSvTnY0tqEizZJPoUr3/rmBxzHvqNK9d0Szuit6ptkWXN259BSQM5tippCe2OHHjeigTOUzBhdbz4Ay5ayUNRBgL9grcM20yb+t9OwfTCPpUL7o5KTT1b7pmAtIKNlUwfCmAZQjfvwfpaWXccJSX+QIBOcOfnCKFi8aHslIR1N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=pAkdR3P2; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4WKjFq0s98zll9ds;
	Thu, 11 Jul 2024 18:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1720720860; x=1723312861; bh=EukfsqD8rodAYY6/mdsuH05I
	FV/tsORH99jQjePUr/o=; b=pAkdR3P2cNKI1EjW6Lup76PiL/mb7/2edJ3lc1ZO
	DJUumiBUxLo4zU933ze1/d8jQzuzKHDCzAGAhq6GH0kaHvAIk0gp9UO3H6jhzToY
	RblQMLyFphN92AAlB4csFqP/RHiyBHXiu7qUYRApEnrWmdhwDVnxbHuabqqs6SU+
	DbSkZ8MOhzAkjn0gfCwHC47/CaQsJ6Py7TOVZYdES7Rgr7Npf8930lisyrohHQQy
	T8Rz8NtNxoPMkV1DjZZ+UNaGGCR4w3XNqvep808OaC2hGspELXQvEUBKRxD7DaQm
	Cm4WQ5gSG8JmdgvwZws/2TCvcfsADYPo9i9XR9CT+xsrrA==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id mp6sO_zfjB68; Thu, 11 Jul 2024 18:01:00 +0000 (UTC)
Received: from [100.96.154.26] (unknown [104.132.0.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4WKjFl0QBgzllBd6;
	Thu, 11 Jul 2024 18:00:58 +0000 (UTC)
Message-ID: <20957ae8-2d05-4852-b149-64edb071426f@acm.org>
Date: Thu, 11 Jul 2024 11:00:58 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] blk-ioprio: remove ioprio_blkcg_from_bio()
To: Yu Kuai <yukuai1@huaweicloud.com>, tj@kernel.org, josef@toxicpanda.com,
 jack@suse.cz, axboe@kernel.dk
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yukuai3@huawei.com, yi.zhang@huawei.com,
 yangerkun@huawei.com
References: <20240711090059.3998565-1-yukuai1@huaweicloud.com>
 <20240711090059.3998565-2-yukuai1@huaweicloud.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240711090059.3998565-2-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/11/24 2:00 AM, Yu Kuai wrote:
> Currently, if config is enabled, then ioprio is always enabeld by

enabeld -> enabled

> default from blkcg_init_disk(), hence there is no point to check if
> the policy is enabled from blkg in ioprio_blkcg_from_bio(). Hence remove
> it and get blkcg directly from bio.

Anyway:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

