Return-Path: <cgroups+bounces-9398-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D76B350C9
	for <lists+cgroups@lfdr.de>; Tue, 26 Aug 2025 03:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 499F81A87CC6
	for <lists+cgroups@lfdr.de>; Tue, 26 Aug 2025 01:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DBF2284665;
	Tue, 26 Aug 2025 01:09:23 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E056C14A8B;
	Tue, 26 Aug 2025 01:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756170563; cv=none; b=BL3UV2Wy/BIoi7gEUH5iNqw1LzpjNAIgL7wSw0cV1EDpjGJZeEGlsP+G19VrxaWsx5d23bFYJVZRzV/P4ghc426H9xhGd/Hesr8FpESiYHLccwo4NZTKMngkDHeD1mxYeYBfjGs9Hlhi1mi4Jzb68YLdBNFetMkCJ7EkH6iE/Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756170563; c=relaxed/simple;
	bh=t8qAn4BTHJMGQ6VKVltOTsKu86zB0A5UnPaa3nHCH1U=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=eWXjK/clcP4oAqgc6VfsNrSDLNX2DEh3EfQuA8Ix+7lTk3yWeXk9G0N0+8jxIqneF7Ht+wk71MLy0XMbO2yIlE138m0q224OXpYR7FWe8CofJe2m/7d9f7ukjWjPJQA5Hwyf1URrKInCRhVE6s6QxMBvrNFa4IMwYZJ21ZiQDss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4c9qLl1v35zYQw0s;
	Tue, 26 Aug 2025 09:09:19 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id C40EF1A1025;
	Tue, 26 Aug 2025 09:09:17 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgAXYIw8Ca1o8lQ7AQ--.64085S3;
	Tue, 26 Aug 2025 09:09:17 +0800 (CST)
Subject: Re: [PATCH RFC 3/7] md/raid1: convert to use bio_submit_split()
To: Christoph Hellwig <hch@infradead.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: colyli@kernel.org, hare@suse.de, tieren@fnnas.com, axboe@kernel.dk,
 tj@kernel.org, josef@toxicpanda.com, song@kernel.org,
 akpm@linux-foundation.org, neil@brown.name, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 linux-raid@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 johnny.chenyi@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20250825093700.3731633-1-yukuai1@huaweicloud.com>
 <20250825093700.3731633-4-yukuai1@huaweicloud.com>
 <aKxBoHcYyCn9unRp@infradead.org>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <83f1efa2-8909-a250-a1f8-8735f396ea7e@huaweicloud.com>
Date: Tue, 26 Aug 2025 09:09:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aKxBoHcYyCn9unRp@infradead.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAXYIw8Ca1o8lQ7AQ--.64085S3
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYK7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E
	6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28Cjx
	kF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8I
	cVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87
	Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE
	6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72
	CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4II
	rI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr4
	1l4c8EcI0Ec7CjxVAaw2AFwI0_GFv_Wryl4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6r
	W5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxV
	WUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU
	F0eHDUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2025/08/25 18:57, Christoph Hellwig Ð´µÀ:
> On Mon, Aug 25, 2025 at 05:36:56PM +0800, Yu Kuai wrote:
>> +		bio = bio_submit_split(bio, max_sectors,&conf->bio_split);
> 
> missing whitespace after the comma.
> 
> .
> 

Ok,

Thanks for the review.
Kuai


