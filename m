Return-Path: <cgroups+bounces-7002-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5DDA5D435
	for <lists+cgroups@lfdr.de>; Wed, 12 Mar 2025 02:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89B6C189C595
	for <lists+cgroups@lfdr.de>; Wed, 12 Mar 2025 01:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6865613B58A;
	Wed, 12 Mar 2025 01:51:38 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FBB5684;
	Wed, 12 Mar 2025 01:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741744298; cv=none; b=BrQU/S2wXHLmpduUtX5V0PQRDbEDkGGbkcp6lImrhEAKxbYF3sgaP0dTvgxsSbtJKphKVqQdjACxklyCxVVwK86cWxczlGCzRpiS2St5koR98mr2n8t9S/VJK3OhEIBQ2fSSL0NkR5eSpnqyVUISlC8/GwdJdakrK7olWrCXacw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741744298; c=relaxed/simple;
	bh=kBuOWzKazd0QJN+2VfW1BelVrTxdYN+lsa1A1d0T5FI=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ChXXT3j9qxSc5jAgQHw3EQmsBK0ENFUW+hVNwbhB2B0Jo7MEjSj3Zv4c3I5t3B/xDb37vdDzgC9jYiJtOde0mpAi1qLMCTqVek0xc9GAlb+UR34jnO1p/u3NmSfWvxDdnfVuEbG4dr157lu+WMAtTdYk+S2VNC97vJAgL3ix060=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZCDB51JFwz4f3lgM;
	Wed, 12 Mar 2025 09:51:09 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 0386F1A1546;
	Wed, 12 Mar 2025 09:51:33 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgB32l6j6NBncivzGA--.24749S3;
	Wed, 12 Mar 2025 09:51:32 +0800 (CST)
Subject: Re: [PATCH] blk-throttle: support io merge over iops_limit
To: Tejun Heo <tj@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: Ming Lei <ming.lei@redhat.com>, axboe@kernel.dk, josef@toxicpanda.com,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250307090152.4095551-1-yukuai1@huaweicloud.com>
 <Z8sZyElaHQQwKqpB@slm.duckdns.org>
 <5fc124c9-e202-99ca-418d-0f52d027640f@huaweicloud.com>
 <Z85LjhvkCzlqBVZy@fedora> <Z88K5JtR4rhhIFsY@slm.duckdns.org>
 <baba2f82-6c35-8c24-847c-32a002009b63@huaweicloud.com>
 <Z9CQOuJA-bo4xZkH@slm.duckdns.org>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <c1e467a9-7499-e42b-88ed-b8e34b831515@huaweicloud.com>
Date: Wed, 12 Mar 2025 09:51:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Z9CQOuJA-bo4xZkH@slm.duckdns.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgB32l6j6NBncivzGA--.24749S3
X-Coremail-Antispam: 1UD129KBjvdXoWrur15tFWrCryDuFW5Wr48JFb_yoWkGwc_uF
	Z2kF48ua1Yv3Wktay3JryagrZIqay8WryUJrZ2qwsxW340yFWDuFW3Kr98Zw1rGFs7JFn0
	kwn8Zr43ArW29jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbfAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbGQ6JUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2025/03/12 3:34, Tejun Heo Ð´µÀ:
> Hello,
> 
> On Tue, Mar 11, 2025 at 11:08:00AM +0800, Yu Kuai wrote:
> ...
>>> That said, I'm not sure about changing the behavior now. blk-throtl has
>>> mostly used the number of bios as long as it has existed and given that
>>> there can be a signficant difference between the two metrics, I'm not sure
>>> the change is justified at this point.
>>
>> If we really concern about the behavior change, can we consider a new
>> flag that can switch to the old behavior? We'll see if any user will
>> complain.
> 
> Yeah, that may be the right way to go about this, but let me turn this
> around and ask you why adding a new behavior would be a good idea. What
> problems are you trying to solve?

In the case of dirty pages writeback, BIO is 4k, while RQ can be up to
hw_sectors_kb. Our user are limiting iops based on real disk capacity
and they found BIO merge will be broken.

The idea way really is rq-qos based iops limit, which is after BIO merge
and BIO merge is ensured not borken. In this case, I have to suggest
them set a high iops limit or just remove the iops limit.

Thanks,
Kuai

> 
> Thanks.
> 


