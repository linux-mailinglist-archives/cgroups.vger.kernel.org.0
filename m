Return-Path: <cgroups+bounces-3179-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4CD390647A
	for <lists+cgroups@lfdr.de>; Thu, 13 Jun 2024 08:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 499491F23107
	for <lists+cgroups@lfdr.de>; Thu, 13 Jun 2024 06:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B28137C20;
	Thu, 13 Jun 2024 06:55:34 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAE2130485;
	Thu, 13 Jun 2024 06:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718261734; cv=none; b=hdOy2qdW6KwmdHWQANLGNA+HeuQwOoRLE90qZEHJPPlqX6rb4gh1NU83/dTSjDhkeeRotijN1cQLvzad3HGXUOTt6P1kmeTfnUds+zqnmcsPiQOwfeWVUQsxYDH4Fc69QrF4UUnFRUZNjoXATRu4xewCClFKG/moTjufzBZlYLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718261734; c=relaxed/simple;
	bh=IdZQJKQuQHoYb+6SnBjywKNI9W9Zw3NoblQod5oTVHY=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=MggfKN52ekHCBw481JIOvS4cPrR3tDrogYHYvLgMnPByMiuvELxPPaZuIv2AYuFmUBqkiwgb4rpokOfLyHOcsmSet/H7d91Eu0kzyudMCzKkMURXX295SDRdGB4cD+xTuA0e08INpCVDsYT7u0/71muViIxrCna+U7ezEjuVLMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4W0CpZ4XTlz4f3jcx;
	Thu, 13 Jun 2024 14:55:18 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id B01251A0568;
	Thu, 13 Jun 2024 14:55:28 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgAn+RHfl2pm_4JmPQ--.42616S3;
	Thu, 13 Jun 2024 14:55:28 +0800 (CST)
Subject: Re: [PATCH RFC -next 1/7] kernfs: export pr_cont_kernfs_path()
To: Greg KH <gregkh@linuxfoundation.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: axboe@kernel.dk, tj@kernel.org, josef@toxicpanda.com,
 lizefan.x@bytedance.com, hannes@cmpxchg.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, yi.zhang@huawei.com,
 yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20240613014937.1326020-1-yukuai1@huaweicloud.com>
 <20240613014937.1326020-2-yukuai1@huaweicloud.com>
 <2024061314-moodiness-snowflake-14c5@gregkh>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <724f3d15-769e-705d-986f-75a33ad6d715@huaweicloud.com>
Date: Thu, 13 Jun 2024 14:55:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <2024061314-moodiness-snowflake-14c5@gregkh>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAn+RHfl2pm_4JmPQ--.42616S3
X-Coremail-Antispam: 1UD129KBjvdXoWruF43Kr1xuw1fZw48KFyDJrb_yoWDCwc_Cr
	1DC3429w13X3W2yFs0yrZxtrZ0gan5uF4YvayUJrWDtF95ta4rAwsYq3s5ZrnxGF4DW3sa
	yFn8ZFWjqr47ZjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb3AFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Zr0_Wr1U
	MIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUF9a9DUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2024/06/13 13:55, Greg KH Ð´µÀ:
> On Thu, Jun 13, 2024 at 09:49:31AM +0800, Yu Kuai wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> This helper is used in iocost, prepare to build iocost as kernel module.
>>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   fs/kernfs/dir.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
>> index 458519e416fe..84ad163a4281 100644
>> --- a/fs/kernfs/dir.c
>> +++ b/fs/kernfs/dir.c
>> @@ -279,6 +279,7 @@ void pr_cont_kernfs_path(struct kernfs_node *kn)
>>   out:
>>   	spin_unlock_irqrestore(&kernfs_pr_cont_lock, flags);
>>   }
>> +EXPORT_SYMBOL_GPL(pr_cont_kernfs_path);
> 
> This isn't the helper that needs to be exported, it's a include wrapper
> that is using this for cgroups.  Please document this much better and
> perhaps, just fix up the cgroups code instead?

Thanks for the notice, I didn't think much of this, just export API that
is called from iocost. I'll look into this.

Thanks,
Kuai

> 
> thanks,
> 
> greg k-h
> .
> 


