Return-Path: <cgroups+bounces-9679-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10EC3B42772
	for <lists+cgroups@lfdr.de>; Wed,  3 Sep 2025 19:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D451D206CF2
	for <lists+cgroups@lfdr.de>; Wed,  3 Sep 2025 17:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313DF2FD1C2;
	Wed,  3 Sep 2025 17:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yukuai.org.cn header.i=hailan@yukuai.org.cn header.b="JNRqTkGj"
X-Original-To: cgroups@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0062D481F;
	Wed,  3 Sep 2025 17:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756918850; cv=pass; b=qDHT7xrUfRCj3rnEhe5zFIeaj/sXINBd7zOXnZZRqOk7DUsvXMExD4f+MlxK274lwHgpOA/fUeQfvHHpTsV897Hgdqmxtl+v3cPTP0rALtFy9xHjUZ7V1EkHRiB3n5oFILR3Mj0zerpyxk2wY/OLOx7DcibsSIs15BvI5yuoJjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756918850; c=relaxed/simple;
	bh=xYywHF63vu9Hnz2rgaGv3NTiqlWju88O0hyzHabmkHo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P7tM8k7GE8Yj0H25R0lswfN5+H+BA9kyhTgEoLb/YYZ6fVGNtb2pHJOR86HMWcxEtOG+aZW6C6Vq8LE5Zk2kWbO2Srz8FJ8JT706+3lvnybbkxllY1mbczwIWG2VvniSbhKyLGxti51Kk6B65hZxEy0kvtO1xmlnPFBgqWYyyrM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yukuai.org.cn; spf=pass smtp.mailfrom=yukuai.org.cn; dkim=pass (1024-bit key) header.d=yukuai.org.cn header.i=hailan@yukuai.org.cn header.b=JNRqTkGj; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yukuai.org.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yukuai.org.cn
ARC-Seal: i=1; a=rsa-sha256; t=1756918803; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=W8jZs/m4kHlqzCkU6djWRpHkTZkRdCrBCMGWTXgjAHxLhcr57usUawrP6QcAAas8NBHcaAM4eJL8LgDxxmK6uGpa/koGICF0AzxpziN7IsE1AZoK5nxHihnjxhhDudspNz8u2asPwVEG74rL/qSvfWG3Fho3b7BhJCpUkQSwsyA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756918803; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=WyTMW/VsquP3eLZFDnSYpE40hd0f1MFOnn4qLTmo8eQ=; 
	b=lojD4A4XsE/7rNfyj53+oIaCyWFtWvbHMzxFYAKk3u8hCClE+wZ1X746pP/SvRvr3sJTNfuQci5Bb7x05yEwaOfgwODJWK8oQ3sz1q/biO9/G0pVaDm5isLaEuLQibugqkeCM7Tq1hsSQDSEWM3N+nSLQANlsJbd7DFPSyIb7Mc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=yukuai.org.cn;
	spf=pass  smtp.mailfrom=hailan@yukuai.org.cn;
	dmarc=pass header.from=<hailan@yukuai.org.cn>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756918803;
	s=zmail; d=yukuai.org.cn; i=hailan@yukuai.org.cn;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=WyTMW/VsquP3eLZFDnSYpE40hd0f1MFOnn4qLTmo8eQ=;
	b=JNRqTkGjpL7bcrW9LWaiNFOmLDFs+KlfO+jk1w0CuMC9dm+qo2rlGb1+kGyedji4
	LLJdNNBtpEvBh4Ct3KO3fRnyN1239TM9ZpxPYxKn8cHWeebdMIf3zrN4Xzfqm79qKkl
	+mrP8YPJlGt12klooHnQ7e3+5qDcP87lGXZU1pzI=
Received: by mx.zohomail.com with SMTPS id 1756918799888735.5865422299123;
	Wed, 3 Sep 2025 09:59:59 -0700 (PDT)
Message-ID: <ad353972-085f-42a3-b8f0-20416312479b@yukuai.org.cn>
Date: Thu, 4 Sep 2025 00:59:49 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 14/15] block: fix disordered IO in the case
 recursive split
To: Christoph Hellwig <hch@infradead.org>, Yu Kuai <yukuai1@huaweicloud.com>
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
From: Yu Kuai <hailan@yukuai.org.cn>
In-Reply-To: <aLhD8Vi-UwnwK93L@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hi,

在 2025/9/3 21:34, Christoph Hellwig 写道:
> Btw disordered IO sounds a bit odd to me.  I'm not a native english
> sepaker, but in the past we've used the term "I/O reordering" for
> issues like this.
>
>> +		if (split && !bdev_is_zoned(bio->bi_bdev))
> Why are zoned devices special cased here?
>
I'm not that sure about zoned device before, I'll remove this checking,
and mention the problem Bart met in commit message in the next version.

Thanks,
Kuai


