Return-Path: <cgroups+bounces-10473-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27533BA4C40
	for <lists+cgroups@lfdr.de>; Fri, 26 Sep 2025 19:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C26D62A7B40
	for <lists+cgroups@lfdr.de>; Fri, 26 Sep 2025 17:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0AC430C0F1;
	Fri, 26 Sep 2025 17:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="XBDNDX7k"
X-Original-To: cgroups@vger.kernel.org
Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C136B2AD35;
	Fri, 26 Sep 2025 17:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758907220; cv=none; b=pHEwCV570izFffV9TV2TjKD2P8LESNZpr4/Iu+xgW3OoHrFbut5if88mUqmIRG7skQW2JOYU7qEfAZx/q3stKrNyutyN3CxY8NzXS1YmluSW35KviBAIAyc8Wjh94B14U3YhONg/OFHepLesgvm2jiz279KmuydOBFewLSdu5Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758907220; c=relaxed/simple;
	bh=e5cciZIOlUEd14Nlh9r6UpPh7CEgs/6L/FSJjeP9WoA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y/ucb4Yp3C6QOQCCDt1gk33a03Tdg3Nb/zV6BvwN6oSPMITOfPA44yHQ87NHYvHkYBvy+dvIybabytIWG5QJVSlphDxtS0dAo9H2NqU0Kh4MUghrE9NlSY4XyFU0DAEexio76z5E8PeRfxUWPsegheMrA03vm+/W1/cR9ZVVv1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=XBDNDX7k; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4cYHQh1MRvzlgqy3;
	Fri, 26 Sep 2025 17:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1758907209; x=1761499210; bh=e5cciZIOlUEd14Nlh9r6UpPh
	7CEgs/6L/FSJjeP9WoA=; b=XBDNDX7klPhV2LR5Gj/vZnR8shvGvAnsUOjlCkes
	3lenIfMn+DwuRVIZO+Vbr/D1uJ4gOCAPt8k8ZyGBAbr/4xLQHY4DXNHjFRlN/2pG
	Ih6HAHDSWbsF3/pj74+qi3zH6Lg7//Esh9EOA4uqXzio29j1fLOKoPhgqywc7P0w
	sHY8VE/+rJ5hirGz2Thkh5kk4BHltVC7lqIKhJHoyl/MsBET/N6Y+95WmcBsfuk3
	+QdpPt4gMbce9m1iBQ+/x9yHOzExEf+BzmheZVt+M2pFj0DH4n7UFUT41Kqc3RlN
	foQEesFSXjuWNV6F42JvSc45kXjABX3SLM62dUcH17Sjfw==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id GuQ2MpjtDxTQ; Fri, 26 Sep 2025 17:20:09 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4cYHQL0WV5zlgqVf;
	Fri, 26 Sep 2025 17:19:52 +0000 (UTC)
Message-ID: <66dcdcd1-df71-43b9-a468-2b4aaa8b6dc7@acm.org>
Date: Fri, 26 Sep 2025 10:19:51 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] blk-cgroup: use cgroup lock and rcu to protect
 iterating blkcg blkgs
To: Yu Kuai <yukuai1@huaweicloud.com>, Yu Kuai <hailan@yukuai.org.cn>,
 tj@kernel.org, ming.lei@redhat.com, nilay@linux.ibm.com, hch@lst.de,
 josef@toxicpanda.com, axboe@kernel.dk, akpm@linux-foundation.org,
 vgoyal@redhat.com
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, yi.zhang@huawei.com,
 yangerkun@huawei.com, johnny.chenyi@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250925081525.700639-1-yukuai1@huaweicloud.com>
 <20250925081525.700639-2-yukuai1@huaweicloud.com>
 <bc6fe04d-3245-40dd-aa30-c3a3acb670c2@acm.org>
 <01e7eccd-3529-4d12-8ad2-fd9e034a026d@yukuai.org.cn>
 <688275d5-fbb4-08b3-45e1-798ad8cf77fc@huaweicloud.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <688275d5-fbb4-08b3-45e1-798ad8cf77fc@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 9/25/25 5:57 PM, Yu Kuai wrote:
> =E5=9C=A8 2025/09/26 1:07, Yu Kuai =E5=86=99=E9=81=93:
>> =E5=9C=A8 2025/9/25 23:57, Bart Van Assche =E5=86=99=E9=81=93:
>>> On 9/25/25 1:15 AM, Yu Kuai wrote:
>>>> It's safe to iterate blkgs with cgroup lock or rcu lock held, preven=
t
>>>> nested queue_lock under rcu lock, and prepare to convert protecting
>>>> blkcg with blkcg_mutex instead of queuelock.
>>>
>>> Iterating blkgs without holding q->queue_lock is safe but accessing t=
he
>>> blkg members without holding that lock is not safe since q->queue_loc=
k
>>> is acquired by all code that modifies blkg members. Should perhaps a =
new
>>> spinlock be introduced to serialize blkg modifications?
>=20
> Actually, only blkcg_print_blkgs() is using rcu in this patch, and take
> a look at the callers, I don't see anyone have to hold queue_lock. Can
> you explain in detail which field from blkg is problematic in this
> patch?

I'm not a cgroup expert so I cannot answer the above question. But I
think it's clear that the description of this patch is not sufficient as
motivation for this patch. Removing the blkg->q->queue_lock lock and
unlock calls requires a detailed review of all blkcg_print_blkgs() and
blkcg_print_stat() callers. There is no evidence available in the patch
description that shows that such a review has happened.

Thanks,

Bart.

