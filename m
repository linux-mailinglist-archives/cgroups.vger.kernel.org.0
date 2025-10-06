Return-Path: <cgroups+bounces-10546-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA53BBCF99
	for <lists+cgroups@lfdr.de>; Mon, 06 Oct 2025 03:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 049E03B4C56
	for <lists+cgroups@lfdr.de>; Mon,  6 Oct 2025 01:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023221A9F8D;
	Mon,  6 Oct 2025 01:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yukuai.org.cn header.i=hailan@yukuai.org.cn header.b="Q88TO4KN"
X-Original-To: cgroups@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938238F6F;
	Mon,  6 Oct 2025 01:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759715784; cv=pass; b=J6khJRlcNBMvFfyNWLL4IQpfrSXjzcunluIYWQpPfLIdkJGpsyJyZQZEf1cqyPCeCNep7emIgPT4jLeIemh97tuC/i13at5RsLABb670Pf+ZhCsHM1aZ0hELZJ2xX41Zrk62U/BESd656YbjKP9DwE7omTW8kJtyrhwawNjyo68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759715784; c=relaxed/simple;
	bh=3FYkDME2ofzqETRfDXyqVTaDE3sgIA+Dr49WTIoXzWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MVGcRxpsiTxOLNl/bfm1gCngIYu9pK/3GI3iayGmGc72NgbqRtTen38H3iEyTMCyjBIEc7yVu8j9cALshhYZxXHUStzE+pEjGppFK1sIGE3En2j4h2duuNAfoqbrHflVRWAbyr61r39jGphB2BTf5CeOHSEB+7V7XC9UtUDBVlI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yukuai.org.cn; spf=pass smtp.mailfrom=yukuai.org.cn; dkim=pass (1024-bit key) header.d=yukuai.org.cn header.i=hailan@yukuai.org.cn header.b=Q88TO4KN; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yukuai.org.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yukuai.org.cn
ARC-Seal: i=1; a=rsa-sha256; t=1759715753; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Ps9P7sGt3jM/G0pQ3sKHhIRZf6ZI1UPcYjAtC1BEvT2n9IvTa67uZBU5AyrXI6PTg15f4vqjhmbWtyIvPP9VvBP7IhI+yzi86XyneGxpo4oIhWFijFwYFVZFOgPuL8NjWyK2l6+hUm2wDT5CqVAEDE+89y+RtHzPsil419kuxHU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1759715753; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=3FYkDME2ofzqETRfDXyqVTaDE3sgIA+Dr49WTIoXzWs=; 
	b=RxP+Suk7//sB+Wwsseogzeqvdto5otHP5O6Was6IkpEXjEkqfhnIlPGOm6NkCcgmNbU5C2VUWjN9wzZko6Q8J91FBUOnsuksMzVFP8mfN+5LZK6G5QWTXGX+SUM1moWkLQ+zjX7DqzavJ0PoFx+p+27L8r77v9dYEUZfk6+kZDw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=yukuai.org.cn;
	spf=pass  smtp.mailfrom=hailan@yukuai.org.cn;
	dmarc=pass header.from=<hailan@yukuai.org.cn>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1759715753;
	s=zmail; d=yukuai.org.cn; i=hailan@yukuai.org.cn;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=3FYkDME2ofzqETRfDXyqVTaDE3sgIA+Dr49WTIoXzWs=;
	b=Q88TO4KN/EuxHymJfTgTxilqoTOB8G4sTbVVD/ImBv+uTeow5/z1W5m/FDw2t6YB
	5vtdh7DJ3qE/p6qnkUzto8a62B9GD7aNRL+PbhLFjLOE7uZa/ks9P8ZR5NZKC3gi5VC
	yhRTbMYq/bxUzibE+yJwnqhl72VCrs9i1i/5HFAg=
Received: by mx.zohomail.com with SMTPS id 1759715749848263.4345026807009;
	Sun, 5 Oct 2025 18:55:49 -0700 (PDT)
Message-ID: <497b2eb9-a214-4887-ac89-bd2ddff3cb7d@yukuai.org.cn>
Date: Mon, 6 Oct 2025 09:55:39 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/10] blk-cgroup: remove radix_tree_preload()
To: Christoph Hellwig <hch@lst.de>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: tj@kernel.org, ming.lei@redhat.com, nilay@linux.ibm.com,
 josef@toxicpanda.com, axboe@kernel.dk, akpm@linux-foundation.org,
 vgoyal@redhat.com, cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, yukuai3@huawei.com,
 yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com
References: <20250925081525.700639-1-yukuai1@huaweicloud.com>
 <20250925081525.700639-9-yukuai1@huaweicloud.com>
 <20251003073724.GA12933@lst.de>
From: Yu Kuai <hailan@yukuai.org.cn>
In-Reply-To: <20251003073724.GA12933@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hi,

在 2025/10/3 15:37, Christoph Hellwig 写道:
> On Thu, Sep 25, 2025 at 04:15:23PM +0800, Yu Kuai wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> Now that blkcg_mutex is used to protect blkgs, memory allocation no
>> longer need to be non-blocking, this is not needed.
> Btw, this might also be a good time to convert from the old radix tree
> to an xarray.
>
Sure, I can do that, perhaps after this set and cleanup blkg_conf_prep apis.

Thanks,
Kuai


