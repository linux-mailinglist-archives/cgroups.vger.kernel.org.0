Return-Path: <cgroups+bounces-9400-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA139B350E2
	for <lists+cgroups@lfdr.de>; Tue, 26 Aug 2025 03:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7CA73B47F7
	for <lists+cgroups@lfdr.de>; Tue, 26 Aug 2025 01:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED19B19FA8D;
	Tue, 26 Aug 2025 01:15:40 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EE4C133;
	Tue, 26 Aug 2025 01:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756170940; cv=none; b=W6pyX4zTqlhwT/fZ/WssSQlypG1FpiijJGxgYxND9QHDn8n9lokK5qw0w9G/uyxE8cXwfjtajUpZ7SezIuNCXeVn0J0F8a9T7G/hNZl00nAEV2y3HN3jvndfagkCwYu3gJvp2jEIWDSbeCb5HHmcgDnqT5EzreMoNrIjhmZteHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756170940; c=relaxed/simple;
	bh=VggXqR9HiOhHU2xuUQNK5l07n6NgkuzQH/GVGoOZbqo=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=jMmVKQrH7TnvkuJzthR/Jpug5acSOkZF4DwzanYKtC7hAEEAGqgcNm/r4IjV0wn+EW+VwNulV8z2l0Z/0PjmZYqOJX8A+l6fUNG/ZmqtaDDxGQ3zAR+0EhcqMRCAoALcA+D+3ldPpYD4UImQ4XnPAQHfGM/0r6oZzT0im8wYOR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4c9qV05D6BzKHNTH;
	Tue, 26 Aug 2025 09:15:36 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 54A041A0C9F;
	Tue, 26 Aug 2025 09:15:36 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgCn8Y23Cq1oQdg7AQ--.16842S3;
	Tue, 26 Aug 2025 09:15:36 +0800 (CST)
Subject: Re: [PATCH RFC 5/7] md/raid5: convert to use bio_submit_split()
To: Christoph Hellwig <hch@infradead.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: colyli@kernel.org, hare@suse.de, tieren@fnnas.com, axboe@kernel.dk,
 tj@kernel.org, josef@toxicpanda.com, song@kernel.org,
 akpm@linux-foundation.org, neil@brown.name, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 linux-raid@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 johnny.chenyi@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20250825093700.3731633-1-yukuai1@huaweicloud.com>
 <20250825093700.3731633-6-yukuai1@huaweicloud.com>
 <aKxCStAJPOI3LdtG@infradead.org>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <5af54574-2c28-dc6f-7205-cb3c3575c93b@huaweicloud.com>
Date: Tue, 26 Aug 2025 09:15:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aKxCStAJPOI3LdtG@infradead.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCn8Y23Cq1oQdg7AQ--.16842S3
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYM7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E
	6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28Cjx
	kF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8I
	cVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87
	Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE
	6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72
	CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4II
	rI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr4
	1l4c8EcI0Ec7CjxVAaw2AFwI0_GFv_Wryl4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6r
	W5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
	0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x
	0JUl-eOUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2025/08/25 19:00, Christoph Hellwig Ð´µÀ:
> On Mon, Aug 25, 2025 at 05:36:58PM +0800, Yu Kuai wrote:
>> +		raid_bio = bio_submit_split(raid_bio, sectors,
>> +					    &conf->bio_split);
>> +		if (!raid_bio)
>> +			return NULL;
>> +
>> +		raid_bio->bi_opf &= ~REQ_NOMERGE;
> 
> It almost feels as if md wants a little helper that wraps
> bio_submit_split and also clears REQ_NOMERGE?
> 

Yes.

And with the respect bio_submit_split() set this flag and then we clear
it, will it make more sense to set this flag after bio_submit_split()
from block layer?

Thanks,
Kuai

> .
> 


