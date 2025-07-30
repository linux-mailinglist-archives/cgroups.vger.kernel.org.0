Return-Path: <cgroups+bounces-8937-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B0AB1655C
	for <lists+cgroups@lfdr.de>; Wed, 30 Jul 2025 19:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54B131AA3613
	for <lists+cgroups@lfdr.de>; Wed, 30 Jul 2025 17:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2EC2E03F5;
	Wed, 30 Jul 2025 17:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="bUWbVv4k"
X-Original-To: cgroups@vger.kernel.org
Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CD11F4E4F;
	Wed, 30 Jul 2025 17:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753896094; cv=none; b=AdV1vND2rx1QMnzfvTAq1Ex/LMbpYQ8H7ps3+cs95qPOJbP5JZ1dRyo0MfGQXzyDF/Fo4U91REtfXHZkYCYH65gzIQ+Rsgt9mmIF/q9PIH+Nm6rVkwW24Mk2QiDsJoDuLYaD7SUgvqS1p7ynzuZrhEYNCHnKO+J9TyxaGcpJeNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753896094; c=relaxed/simple;
	bh=67VjkldB/7jMHfypCjX0WuPxqoUEBiPfst24QFVctZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n1rl87qf0L3YdrZenIfsRJQbGXbvxgj8mb4uQ5zXCklqG49noNWtBgUo2g2+lKh8LNF0IJQXN0JpmJIoVFH9alw8RJ9FNP37KPA8Qm0Cm5zACiwRU4AwO+W7V8vGS+kpZC5nIx115gE2aRvFWz3fR/V4lddDYCciYlm/yAgrmZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=bUWbVv4k; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4bsfC01ZPtzm0ySX;
	Wed, 30 Jul 2025 17:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1753896089; x=1756488090; bh=n+tNQc7vQY06it9YUlWe3e9Z
	JzpqeZ50aWCx/bCQgt8=; b=bUWbVv4kdOctXJICKUTx8DVTAy4bRgqjFByoETRJ
	+uxVVIZ086D8sZA5SU3aFApHvFW9x2//84uE1SECa7oJoVjlfcrfLOeoIKNQtw5t
	xCmPCck7yEcjX0O+yqu/1EmQYGDpUg2tonIvp+VMe6m0Ia+i22DndK3GXE+eSYjA
	9hZzKvlJr5Cc07WehzfIf0qrhbRTzYnA3Wg8dRtUChZ36NBz5I2GZ8jNc95GqQlj
	+8GA7WggFd+7erMDMD2jv5o18evb+yDndgMt4BF895f/N9intzVhuWLEtU1QZAtz
	7UK3nxBiPhw+j+txpHg7KeYAtCE/uj7tDiHyWQ+c38lGVA==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id qIEs07CurX4A; Wed, 30 Jul 2025 17:21:29 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4bsfBk2ZQbzm1HcH;
	Wed, 30 Jul 2025 17:21:17 +0000 (UTC)
Message-ID: <ca605746-da46-46a4-a0f3-460ed2d35b0b@acm.org>
Date: Wed, 30 Jul 2025 10:21:16 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] mq-deadline: switch to use elevator lock
To: Yu Kuai <yukuai1@huaweicloud.com>, dlemoal@kernel.org, hare@suse.de,
 jack@suse.cz, tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
 yukuai3@huawei.com
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 johnny.chenyi@huawei.com
References: <20250730082207.4031744-1-yukuai1@huaweicloud.com>
 <20250730082207.4031744-3-yukuai1@huaweicloud.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250730082207.4031744-3-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/30/25 1:22 AM, Yu Kuai wrote:
> @@ -466,10 +466,9 @@ static struct request *dd_dispatch_request(struct blk_mq_hw_ctx *hctx)
>   	struct request *rq;
>   	enum dd_prio prio;
>   
> -	spin_lock(&dd->lock);
>   	rq = dd_dispatch_prio_aged_requests(dd, now);

The description says "no functional changes" but I think I see a 
functional change above. Please restrict this patch to changing
&dd->lock into dd->lock only.

Thanks,

Bart.

