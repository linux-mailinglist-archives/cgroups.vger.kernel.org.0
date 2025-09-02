Return-Path: <cgroups+bounces-9586-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A090B3F202
	for <lists+cgroups@lfdr.de>; Tue,  2 Sep 2025 03:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 469A67B0352
	for <lists+cgroups@lfdr.de>; Tue,  2 Sep 2025 01:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD702848AF;
	Tue,  2 Sep 2025 01:51:04 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C071E47CA;
	Tue,  2 Sep 2025 01:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756777864; cv=none; b=OWL3klHRSUBdp3Om2FB9s8TpT+Oc+WSD/AOMcsF6MdiMy1QK01fQkEoKtkAEkBm0HE18GfcOjOf15r+QWCcCzR4HJEpZFQyoHmsZR136iAeG2IkyREQ3l214o/ibN7P7J9XXqhtGGmqlBEUOBZe/hv/dqWJi1bqsOER1QOmxSF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756777864; c=relaxed/simple;
	bh=eZHqbM0sZ45R7Sy9LTRYFYVLH5mQq+QL7Px/R1t57XQ=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=eRFslI4CrsU0PvaFiDPtYIPeK13Qv/fvuVZ5gB6nvpDHl3SqL7theoiKXNBj5NPAFbj3bItlqRV6KmorObHB7ynwJSo7Wti0Lub844wQGF/Md8wz/SxX3RWQTvPVJrWnJPp3McS6fwuPlk3/vyRvC3cZFu9Q+JkpjB20StHYZsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cG7xX5VrVzYQvJ1;
	Tue,  2 Sep 2025 09:50:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 434AA1A0ADF;
	Tue,  2 Sep 2025 09:50:55 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgCn8Y16TbZoqjtfBA--.16323S3;
	Tue, 02 Sep 2025 09:50:52 +0800 (CST)
Subject: Re: [PATCH RFC v3 00/15] block: fix disordered IO in the case
 recursive split
To: Bart Van Assche <bvanassche@acm.org>, Yu Kuai <yukuai1@huaweicloud.com>,
 hch@infradead.org, colyli@kernel.org, hare@suse.de, dlemoal@kernel.org,
 tieren@fnnas.com, axboe@kernel.dk, tj@kernel.org, josef@toxicpanda.com,
 song@kernel.org, kmo@daterainc.com, satyat@google.com, ebiggers@google.com,
 neil@brown.name, akpm@linux-foundation.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-raid@vger.kernel.org, yi.zhang@huawei.com,
 yangerkun@huawei.com, johnny.chenyi@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250901033220.42982-1-yukuai1@huaweicloud.com>
 <5b3a5bed-939f-4402-aafd-f7381cd46975@acm.org>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <130482e9-8363-6051-5fc6-549cf9aad57b@huaweicloud.com>
Date: Tue, 2 Sep 2025 09:50:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <5b3a5bed-939f-4402-aafd-f7381cd46975@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCn8Y16TbZoqjtfBA--.16323S3
X-Coremail-Antispam: 1UD129KBjvdXoWruFyrKF1fKFWrtryxWr1UAwb_yoWfXwb_Cw
	s8Aa4DtrWxJanaka1xCF1rArWrKFy5Xr4jq34Utr1xWw13JF90qa18ursay3W3GFyxCrnx
	X3y7u39Yy3yIqjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbfAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sRidbbtUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2025/09/01 22:09, Bart Van Assche 写道:
> On 8/31/25 8:32 PM, Yu Kuai wrote:
>> This set is just test for raid5 for now, see details in patch 9;
> 
> Does this mean that this patch series doesn't fix reordering caused by
> recursive splitting for zoned block devices? A test case that triggers
> an I/O error is available here:
> https://lore.kernel.org/linux-block/a8a714c7-de3d-4cc9-8c23-38b8dc06f5bb@acm.org/ 
> 
I'll try this test.

zoned block device is bypassed in patch 14 by:

+		if (split && !bdev_is_zoned(bio->bi_bdev))
+			bio_list_add_head(&current->bio_list[0], bio);

If I can find a reporducer for zoned block, and verify that recursive
split can be fixed as well, I can remove the checking for zoned devices
in the next verison.

Thanks,
Kuai

> 
> I have not yet had the time to review this patch series but plan to take
> a look soon.
> 
> Thanks,
> 
> Bart.
> .
> 


