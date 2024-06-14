Return-Path: <cgroups+bounces-3184-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A61C90807D
	for <lists+cgroups@lfdr.de>; Fri, 14 Jun 2024 03:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70E3B1C21884
	for <lists+cgroups@lfdr.de>; Fri, 14 Jun 2024 01:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF43158D9C;
	Fri, 14 Jun 2024 01:07:12 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0178157E7D;
	Fri, 14 Jun 2024 01:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718327232; cv=none; b=JdlSymMPzaXm5v39j4Cpe2SwvRbCf5frMjvV5RBVu4XeriNa62bdOb4ovl8vWhKFrl29P1mBdLlYhRH3yVJJuWgdiuVNmx1d4kla3UKN6nCl4SbtI9CSSBStmFjFDS+WDLPm/NVw1cZuou91dOyFWUzoJDoaHUtiLCJYufcCVno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718327232; c=relaxed/simple;
	bh=2tC/fV53SlYxr1+Tb0Q8m2wjAfrkmL7OuJnZr23PIcI=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=bflDOy65M6cJWLNCLlk6rNt+vt51vQzbGYFC08e13BaYKsVuyCtYDOd1IBV6/FoI0tpportg4FzaVHE6Ti5OWqsZIi0AL8t7IRuvzwOF/Bwwu5DXlIGAt439cjNEtdZAzmE6avIrM/WXmGAhTo3YbQ1deIbpIipPQvRMBgE8IAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4W0h262P9Fz4f3mHq;
	Fri, 14 Jun 2024 09:06:54 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id D76B71A0185;
	Fri, 14 Jun 2024 09:07:05 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgBnOBG3l2tmQXutPQ--.44541S3;
	Fri, 14 Jun 2024 09:07:05 +0800 (CST)
Subject: Re: [PATCH RFC -next 0/7] blk-iocost: support to build iocost as
 kernel module
To: Bart Van Assche <bvanassche@acm.org>, Greg KH
 <gregkh@linuxfoundation.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: axboe@kernel.dk, tj@kernel.org, josef@toxicpanda.com,
 lizefan.x@bytedance.com, hannes@cmpxchg.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, yi.zhang@huawei.com,
 yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20240613014937.1326020-1-yukuai1@huaweicloud.com>
 <2024061342-walk-cavalier-7e48@gregkh>
 <97a2b888-4dac-451c-bb9c-40d8dc52cd60@acm.org>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <6bfbe267-8a75-486c-877b-e3236cddfa93@huaweicloud.com>
Date: Fri, 14 Jun 2024 09:07:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <97a2b888-4dac-451c-bb9c-40d8dc52cd60@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBnOBG3l2tmQXutPQ--.44541S3
X-Coremail-Antispam: 1UD129KBjvdXoW7XF1DKFWUZw15CFWrCw1Utrb_yoWDWFgEv3
	Z5ZFyjqryxWayDAw1qyFs0qrWkKr4ruw4jy34UWayUKFn5tFnYyw1rX34kZFn8GF47Crn5
	uFy5XF1ktF1YgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb3AFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq
	3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUoOJ5UUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2024/06/14 0:15, Bart Van Assche 写道:
> On 6/12/24 10:54 PM, Greg KH wrote:
>> On Thu, Jun 13, 2024 at 09:49:30AM +0800, Yu Kuai wrote:
>>> From: Yu Kuai <yukuai3@huawei.com>
>>>
>>> Yu Kuai (7):
>>>    kernfs: export pr_cont_kernfs_path()
>>>    cgroup: export cgroup_parse_float
>>>    block: export some API
>>>    blk-iocost: factor out helpers to handle params from ioc_qos_write()
>>>    blk-iocost: parse params before initializing iocost
>>>    blk-iocost: support to free iocost
>>>    blk-iocost: support to build iocost as kernel module
>>
>> No where do you say _why_ building this as a module is a good idea.
>>
>> Why do this at all?
> 
> With CONFIG_BLK_CGROUP_IOCOST=y (as in the Android kernel), the
> blk-iocost kernel module causes a (small) runtime overhead, even if it
> is not being used.

I think this is not true... Because iocost is lazy initialized, and if
iocost is not initialized, there should not be such overhead.

Thanks,
Kuai

> 
> Thanks,
> 
> Bart.
> 
> 
> .
> 


