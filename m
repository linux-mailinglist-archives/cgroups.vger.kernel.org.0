Return-Path: <cgroups+bounces-9611-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2A6B3F846
	for <lists+cgroups@lfdr.de>; Tue,  2 Sep 2025 10:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34676189B1C6
	for <lists+cgroups@lfdr.de>; Tue,  2 Sep 2025 08:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39DD2E7BDF;
	Tue,  2 Sep 2025 08:26:02 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DCA3D76;
	Tue,  2 Sep 2025 08:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756801562; cv=none; b=DnIp8/kBy5wJzWShAiKbZrZpskR51skXisnMWrME8xX3oAbCdcMf7gwzu8y2TVyMqZeh5ZfdJ5JrwSoa0BSi7dp+uI78VvI9XSwoNJY5SRyjR15d/EwAecZLHpEzSJT+UNhIwMA3cQepPW8wnIIv/cY143LOP87WtPkxAq+QOcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756801562; c=relaxed/simple;
	bh=9CfBYNh+4iSPQYtdoH6uGIT6doeJg35kpISD+8fFxJg=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=nu0munmAKCZ1hv0piIyCAXyQzI5V1CAAjSzarzpHYkvxKcy5XK+ZPXjbYwVvLbyccIa80R/tI+E9G6H8pzbL029a7fJ10Sg6lRExB7sZyShHlzdVm4jeD5vWnTIjX//8+c6uUaB6rKCTc1IkWhLGdz5omKxGpUcgBlIvcKxwFms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cGJjK0rjbzKHNRN;
	Tue,  2 Sep 2025 16:25:57 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id EB89D1A0DCD;
	Tue,  2 Sep 2025 16:25:56 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgCn8IwSqrZo0Mp+BA--.22340S3;
	Tue, 02 Sep 2025 16:25:56 +0800 (CST)
Subject: Re: [PATCH RFC 4/7] md/raid10: convert read/write to use
 bio_submit_split()
To: John Garry <john.g.garry@oracle.com>,
 Christoph Hellwig <hch@infradead.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: anthony <antmbox@youngman.org.uk>, colyli@kernel.org, hare@suse.de,
 tieren@fnnas.com, axboe@kernel.dk, tj@kernel.org, josef@toxicpanda.com,
 song@kernel.org, akpm@linux-foundation.org, neil@brown.name,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-raid@vger.kernel.org, yi.zhang@huawei.com,
 yangerkun@huawei.com, johnny.chenyi@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250825093700.3731633-1-yukuai1@huaweicloud.com>
 <20250825093700.3731633-5-yukuai1@huaweicloud.com>
 <aKxCJT6ul_WC94-x@infradead.org>
 <6c6b183a-bce7-b01c-8749-6e0b5a078384@huaweicloud.com>
 <aK1ocfvjLrIR_Xf2@infradead.org>
 <fe595b6a-8653-d1aa-0ae3-af559107ac5d@huaweicloud.com>
 <835fe512-4cff-4130-8b67-d30b91d95099@youngman.org.uk>
 <aK60bmotWLT50qt5@infradead.org>
 <def0970e-0bf7-4a6d-9b68-692b40aeecae@oracle.com>
 <aLaPHctB8IgtD_Sg@infradead.org>
 <bcdb3af6-44b4-44f8-b03f-a89f98d8a71b@oracle.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <4a360dec-79ff-1444-6c1e-830f43b13c2f@huaweicloud.com>
Date: Tue, 2 Sep 2025 16:25:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <bcdb3af6-44b4-44f8-b03f-a89f98d8a71b@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCn8IwSqrZo0Mp+BA--.22340S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar47ur4kKFW3GF4UCFW7Jwb_yoW8Gw18pF
	Z2v3ZYyr4qkF10v3Z7Zw4IqFyrt3yfA34UJFW5JrWFkFyY9FyftFs7GFZ0gFy29ryxJ3sF
	9ayYgFykGFs8AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBF14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRHUDLUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2025/09/02 14:58, John Garry 写道:
> On 02/09/2025 07:30, Christoph Hellwig wrote:
>> On Tue, Sep 02, 2025 at 07:18:01AM +0100, John Garry wrote:
>>> BTW, do we realistically expect atomic writes HW support and bad 
>>> blocks ever
>>> to meet?
>>
>> That's the point I'm trying to make.  bad block tracking is stupid
>> with modern hardware.  Both SSDs and HDDs are overprovisioned on
>> physical "blocks", and once they run out fine grained bad block tracking
>> is not going to help.  І really do not understand why md even tries
>> to do this bad block tracking, 
> 
> Just because they can try to deal with bad blocks for some (mirroring) 
> personalities, I suppose.

I agree it's useless for enterprise storage, however, for personal
storage, there are lots of users using cost-effective (often aging)
disks, badblocks tracking can reduce the risk of data lost, and
make sure these devices will not become waste.

> 
>> but claiming to support atomic writes
>> while it does is actively harmful.
>>
> 
> There does not look to be some switch to turn off bad block support. 
> That's from briefly checking raid10.c anyway. Kuai, any thoughts on 
> whether we should allow this to be disabled?
> 

I remember that I used to suggest always enable failfast in this case,
and badblocks can be bypassed. Anyway, I think it's good to allow this
to be disabled, it will behave very similar to failfast.

Thanks,
Kuai

> Thanks,
> John
> 
> .
> 


