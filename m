Return-Path: <cgroups+bounces-9682-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B0EB4285D
	for <lists+cgroups@lfdr.de>; Wed,  3 Sep 2025 19:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F9677C2903
	for <lists+cgroups@lfdr.de>; Wed,  3 Sep 2025 17:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02BAA33473D;
	Wed,  3 Sep 2025 17:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="NlDYNHqx"
X-Original-To: cgroups@vger.kernel.org
Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250622D9795;
	Wed,  3 Sep 2025 17:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756922016; cv=none; b=lqIsrvUlyABajnqFWvwJQKOCgpxnONmSqhqyPs61uWdPWrwCaKp2tcvUnJVehhtcUJ2XU3kq3+RS+3XJXhNg0Ci8lUBvUS1wg++XVzkcFyEWH9b4ornpabA2E61Y4L6f8l+5qq5HLiT24rHygvR4VjnCY8VJo/xkG3rtgQ732qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756922016; c=relaxed/simple;
	bh=wR2Vfr+EKguOFVkVDQPfYHMN2PHm1sHKMW0xxM4JxO4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cVaPOgqhwLqO1wABfxYajGLrLvVlRqlDLWifYx0VVLZm4loqFvtnRMeq64vJL/9D7LJ6BJHaB/PCjOXhOm0zifZ6nHygNdfC0qoqHPHer79bNTwuiOr+dCXu58LRp98Irh8PC7Wb9FfImE+Bi0liRIx99gOj9wRoN9R4qjyGEG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=NlDYNHqx; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4cH9Fh0yWJzm0ySJ;
	Wed,  3 Sep 2025 17:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1756921997; x=1759513998; bh=wR2Vfr+EKguOFVkVDQPfYHMN
	2PHm1sHKMW0xxM4JxO4=; b=NlDYNHqxaM/i2jsTFF8Efi9FHbLBkn3NEICmqNwF
	DxJfiRSP1C9fTPe5LTzfPfWh99bVI4O6rfFZFqE5EuIKQMafCVsW1+ZcukdBBNgi
	5k1ezqxQv5+TYWxa+9Si/X0HnXMcvuldTC3SKu7UPeiYX3hBfRZyKd5kBAI8P5m7
	kUY6JrguXwNl6N1yYL/7bPJ4ezQ8chr0R4r0OXvjILMUWTckPB+jXp9r/GE00UJg
	5QmBTW0P/mWe4ZOg8iZvlz/E3Cam6ox8vLQ0wBBSp91E57CnQCnCCigo6IFGphv8
	ONM2sbV4Jwrc9iIWOelGmjvlXb71Dngo8NOLFq6qilyciQ==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 9PPefpCeIZIc; Wed,  3 Sep 2025 17:53:17 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4cH9F76b6Mzm1746;
	Wed,  3 Sep 2025 17:52:58 +0000 (UTC)
Message-ID: <0c345d21-312b-4b83-8296-b8df01b9b819@acm.org>
Date: Wed, 3 Sep 2025 10:52:57 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 14/15] block: fix disordered IO in the case
 recursive split
To: Yu Kuai <hailan@yukuai.org.cn>, Christoph Hellwig <hch@infradead.org>,
 Yu Kuai <yukuai1@huaweicloud.com>
Cc: colyli@kernel.org, hare@suse.de, dlemoal@kernel.org, tieren@fnnas.com,
 axboe@kernel.dk, tj@kernel.org, josef@toxicpanda.com, song@kernel.org,
 kmo@daterainc.com, satyat@google.com, ebiggers@google.com, neil@brown.name,
 akpm@linux-foundation.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 linux-raid@vger.kernel.org, yukuai3@huawei.com, yi.zhang@huawei.com,
 yangerkun@huawei.com, johnny.chenyi@huawei.com
References: <20250901033220.42982-1-yukuai1@huaweicloud.com>
 <20250901033220.42982-15-yukuai1@huaweicloud.com>
 <aLhD8Vi-UwnwK93L@infradead.org>
 <ad353972-085f-42a3-b8f0-20416312479b@yukuai.org.cn>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <ad353972-085f-42a3-b8f0-20416312479b@yukuai.org.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 9/3/25 9:59 AM, Yu Kuai wrote:
> =E5=9C=A8 2025/9/3 21:34, Christoph Hellwig =E5=86=99=E9=81=93:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (split && !bdev_is_zon=
ed(bio->bi_bdev))
 >>
>> Why are zoned devices special cased here?
>>
> I'm not that sure about zoned device before, I'll remove this checking,
> and mention the problem Bart met in commit message in the next version.

If I keep the bdev_is_zoned() check, test zbd/014 fails. If I remove it,
test zbd/014 passes. I think that's a strong argument to remove that
check. Test zbd/014 is not yet in the blktests repository but is
available here:
https://lore.kernel.org/linux-block/a8a714c7-de3d-4cc9-8c23-38b8dc06f5bb@=
acm.org/

Thanks,

Bart.

