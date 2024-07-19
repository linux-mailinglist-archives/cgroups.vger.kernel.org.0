Return-Path: <cgroups+bounces-3792-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5521C937436
	for <lists+cgroups@lfdr.de>; Fri, 19 Jul 2024 09:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F28801F22997
	for <lists+cgroups@lfdr.de>; Fri, 19 Jul 2024 07:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672954F215;
	Fri, 19 Jul 2024 07:14:13 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9074AEE0;
	Fri, 19 Jul 2024 07:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721373253; cv=none; b=HjuxFABWQLG0Rat4hcgw8ZHS6RrGXpHkaC2xc4GZvkUMo5XoWiBEuQvq89z0crdbRLqjdU+FmCDaO2hdmeQ3rPQNBVZKUzIVx/GVcNzTsZbMtgHcyDjyACNfqTLAHHu7xjv9c8FcGdFuTUu1peu/MFK7dPwrQzy0dgaajvQcWHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721373253; c=relaxed/simple;
	bh=KtyGZb9W8Q1ecjKuTeHnlU7VWGpRiHr904ZLYJD/4qc=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=noI/bhYuqFQATv22izPpymrpF6tBGP1HVhPcUTQmQYKuym7pfep2cRF8rpok3+JeZ4wnAkFLtiYituoJIzeHqgpYqZh60ShgzZLui8cKLv3INGhEoyplIRBhutxBAbqabroxebnxdcRqIUfer6F+J8pGm6fLZOuQ6MOK4srHOAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WQLWV1VXPz4f3jZV;
	Fri, 19 Jul 2024 15:13:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 471CE1A0187;
	Fri, 19 Jul 2024 15:14:06 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP4 (Coremail) with SMTP id gCh0CgCHazk8EppmA2I2Ag--.65196S3;
	Fri, 19 Jul 2024 15:14:06 +0800 (CST)
Subject: Re: [PATCH v2 1/3] blk-cgroup: check for pd_(alloc|free)_fn in
 blkcg_activate_policy()
To: Christoph Hellwig <hch@infradead.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: bvanassche@acm.org, jack@suse.cz, tj@kernel.org, josef@toxicpanda.com,
 axboe@kernel.dk, cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20240719023431.3800647-1-yukuai1@huaweicloud.com>
 <20240719023431.3800647-2-yukuai1@huaweicloud.com>
 <Zpn5zvcC4TbDxeKU@infradead.org>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <314af89f-3c47-0c6e-a31d-17663d8f17fb@huaweicloud.com>
Date: Fri, 19 Jul 2024 15:14:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Zpn5zvcC4TbDxeKU@infradead.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCHazk8EppmA2I2Ag--.65196S3
X-Coremail-Antispam: 1UD129KBjvdXoWruF1rCr43Ww4fJr4xZrWrKrg_yoWxtrb_Wr
	909rW7W3srJF40va9rtr1qvFWxKrW5tr10vF1YyFW5GFyDG397tw17Z345Cayftw4jvFyU
	Ca90vrZ8tr4jgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbfAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VU13ku3UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi!

ÔÚ 2024/07/19 13:29, Christoph Hellwig Ð´µÀ:
> On Fri, Jul 19, 2024 at 10:34:29AM +0800, Yu Kuai wrote:
>> +	/*
>> +	 * Make sure cpd/pd_alloc_fn and cpd/pd_free_fn in pairs, and policy
>> +	 * without pd_alloc_fn/pd_free_fn can't be activated.
>> +	 */
>>   	if ((!pol->cpd_alloc_fn ^ !pol->cpd_free_fn) ||
>>   		(!pol->pd_alloc_fn ^ !pol->pd_free_fn))
>>   		goto err_unlock;
>> -- 
> 
> I know this is existing code, but can you fix up the incorrect
> indentation while you touch this:

Yes, and thanks for the review.

Kuai

> 
>   	if ((!pol->cpd_alloc_fn ^ !pol->cpd_free_fn) ||
>   	    (!pol->pd_alloc_fn ^ !pol->pd_free_fn))
> 
> Otherwise looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> .
> 


