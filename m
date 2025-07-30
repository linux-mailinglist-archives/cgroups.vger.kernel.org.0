Return-Path: <cgroups+bounces-8936-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5917DB1654D
	for <lists+cgroups@lfdr.de>; Wed, 30 Jul 2025 19:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C88F3A59A8
	for <lists+cgroups@lfdr.de>; Wed, 30 Jul 2025 17:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC66D2DE6FF;
	Wed, 30 Jul 2025 17:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="vR+L1CCy"
X-Original-To: cgroups@vger.kernel.org
Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1784414883F;
	Wed, 30 Jul 2025 17:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753895968; cv=none; b=TMAUXFZc18SSxzMDJGWNquRcabPuRQmhTzI8Q8gFrf5snYBQWug2YjtUltwDOEOU79tNIhY7/zAY6I2LgItNPBqYy1xfJ82MIivXTKeYnH39Pvg2vH/t7p8nCNvMyisNtPf7XjhRan1e4H5cfUDs2t6Q3OCwlUGYkzvB/R9TwE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753895968; c=relaxed/simple;
	bh=vVO1ljNSDH1Cp8VX7BOW3MNOkdRvOJSjxYNtbTlnUxY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nj4wykLw1hwnE2Gx+skqM03dlKihvJflLrbjmiFaWALCzXRwTL3tlLGXDkTxInoG5uBQaXvoiAuRt1ROJGhSDFtmrVjf0iRPbf5NZzkmld6XaC72WQKTRRkf+m7iLk9JQ7bP764RznO4u7rtynXyojtRONkPMz5sjKoQxnGi6vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=vR+L1CCy; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4bsf8S4bH0zm174f;
	Wed, 30 Jul 2025 17:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1753895958; x=1756487959; bh=LK8Ywagmger3p3W2LJRM3ZNT
	6HAP88/rEQvWnEl+jZ0=; b=vR+L1CCysci27QjVRibHOjHpw9xGe8jKVJeiyHWW
	HEdX5WigwOwGXwP1eY+WjnYE9keaWPbcA+jL8DHRFz+ZZm4crkODbTivJFcqLesw
	1jeVypCa5RxfLbgZawCNUTo03zdbGiTiNQK/J4G1yOPaB4b6i3M2zOJCWRnG9XzS
	ruZ/qkwyhHbs9rJ0Fe+4BujhY3Et60qx+7AsvJd8Ys6rs69QZAqxTlbhJpyCwEip
	XXelttie9C3vCBX3rPJwuhrqcSPyBkidxzeNEO1VS//OWr39er5GttlFih+H2L7N
	MVwfeptuJF3E8m/GEdCd6sWOnjCAM5BAR/tC7hQ/wWccVg==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id vVwTOGKiAr_y; Wed, 30 Jul 2025 17:19:18 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4bsf8F0mktzm1Hc9;
	Wed, 30 Jul 2025 17:19:08 +0000 (UTC)
Message-ID: <e07ce691-c298-4cb4-8ac3-35c8a8beaea4@acm.org>
Date: Wed, 30 Jul 2025 10:19:07 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] blk-mq-sched: introduce high level elevator lock
To: Yu Kuai <yukuai1@huaweicloud.com>, dlemoal@kernel.org, hare@suse.de,
 jack@suse.cz, tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
 yukuai3@huawei.com
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 johnny.chenyi@huawei.com
References: <20250730082207.4031744-1-yukuai1@huaweicloud.com>
 <20250730082207.4031744-2-yukuai1@huaweicloud.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250730082207.4031744-2-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/30/25 1:22 AM, Yu Kuai wrote:
> +		if (sq_sched)
> +			spin_lock(&e->lock);
>   		rq = e->type->ops.dispatch_request(hctx);
> +		if (sq_sched)
> +			spin_unlock(&e->lock);

The above will confuse static analyzers. Please change it into something
like the following:

if (blk_queue_sq_sched(q)) {
	spin_lock(&e->lock);
	rq = e->type->ops.dispatch_request(hctx);
	spin_unlock(&e->lock);
} else {
	rq = e->type->ops.dispatch_request(hctx);
}

Otherwise this patch looks good to me.

Thanks,

Bart.

