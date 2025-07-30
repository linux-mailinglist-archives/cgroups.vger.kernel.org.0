Return-Path: <cgroups+bounces-8941-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D77B0B16611
	for <lists+cgroups@lfdr.de>; Wed, 30 Jul 2025 20:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30411175981
	for <lists+cgroups@lfdr.de>; Wed, 30 Jul 2025 18:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C80A2D9ECD;
	Wed, 30 Jul 2025 18:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="QUz2Qwop"
X-Original-To: cgroups@vger.kernel.org
Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544C21DF98F;
	Wed, 30 Jul 2025 18:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753899043; cv=none; b=J9iqRBq/eKvI68QhuV1CCiIq1cMC3nNzMvlb91dXF1ZPwQjz5A54qPWswqpeBy36gohrWb/9WCzNA1dL7JxWxd6DASKxQfNWkXHsbv9naPpFhHaqyEERTODpKLQEZ72U31kMj1dBaTYwzuyXpjZHc/YOYqktA0zQTmr3lvSlznM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753899043; c=relaxed/simple;
	bh=lCk0vwDNFmJ0RsVYQ+rLHlwtUTBY3kSZuRjSXYAlmkY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nzgheY+78nlLja7HsLMNRu7o/umO4+ooXblaSV/YbdI8FfqSm0JuVpoAq6wGDDn8avmHXOWd9Pbg5BxWzTqMy509Wcob/Xp1GWrWWRxsVjWNm2SpB5eyRMRWGBsxZJpLaJAsO3jFV0HCD6LvEYc3gzoteDuspYrwIrzYk1FfsYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=QUz2Qwop; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4bsgHh1szmzm0yQd;
	Wed, 30 Jul 2025 18:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1753899037; x=1756491038; bh=Zpjz4pPSStNS5tw5fFT7ZAbJ
	XfEgP/hudW65uYZt/AU=; b=QUz2QwopZssNgFrgBexce/nuNQwoyFZzlLGiAoHZ
	HLRnONO22jheUC+MqXNVj+6taMxV9dhZ/pGwk4veKM9oC4bTxII8b6+bFqT/RWm8
	qWXg6G9sLZc1mDccCW5tIpmibu2hvd4hb8bYp5U4cGdZaZaLmg/DxJtn0YAt1PnR
	ozBiHl6r7tzeRWuT5+dmKqhot1QGL1IllSu+M/AgV1zVRFhjo9HMT+yQ56hkzOqt
	Y+mJi1kkYEvjIWoBW5/TuvM58iulvhOxlm27qV1ggfAfCTN7xsLtwShUHiHpcAKA
	O6YqxeUUoj8AYzNwXaziSQn8fdxrSiLubxlqv1MIXAI2xg==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id QJ_N9-q0RLPk; Wed, 30 Jul 2025 18:10:37 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4bsgHP2lDmzm0c2T;
	Wed, 30 Jul 2025 18:10:24 +0000 (UTC)
Message-ID: <06f98711-7c09-4544-b832-b2a931907de8@acm.org>
Date: Wed, 30 Jul 2025 11:10:23 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] mq-deadline: switch to use elevator lock
To: yukuai@kernel.org, Yu Kuai <yukuai1@huaweicloud.com>, dlemoal@kernel.org,
 hare@suse.de, jack@suse.cz, tj@kernel.org, josef@toxicpanda.com,
 axboe@kernel.dk, yukuai3@huawei.com
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 johnny.chenyi@huawei.com
References: <20250730082207.4031744-1-yukuai1@huaweicloud.com>
 <20250730082207.4031744-3-yukuai1@huaweicloud.com>
 <ca605746-da46-46a4-a0f3-460ed2d35b0b@acm.org>
 <d80b9fc4-515e-4ce8-9f3c-28bdf2676336@kernel.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <d80b9fc4-515e-4ce8-9f3c-28bdf2676336@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/30/25 11:01 AM, Yu Kuai wrote:
> Ok, you mean that the lock is moved to the caller is functional change, 
> right?

That's something one could argue about. But I think there is agreement
that each patch should only include one logical change.

Thanks,

Bart.

