Return-Path: <cgroups+bounces-3178-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 750C0906475
	for <lists+cgroups@lfdr.de>; Thu, 13 Jun 2024 08:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E65F91F23116
	for <lists+cgroups@lfdr.de>; Thu, 13 Jun 2024 06:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17EA9137924;
	Thu, 13 Jun 2024 06:53:59 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73589130485;
	Thu, 13 Jun 2024 06:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718261638; cv=none; b=FTVSwp0NxW18e4qI9PmAGUloBR7l/tOKPx6LIk+1ZHibDPnBlcbUnMbMqs0kDo9fmlAD2vF4kw6j95WqrkJEOp+TkD8pnxIlVJ/4/VenblD6pDdKPh0/HiNcAEaxnofxqWU7T03ogOFKFjzLxyKdtz9ew7bcij56Mj0jLdhxSDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718261638; c=relaxed/simple;
	bh=P3BRiGgLtUo6sBjPMfZWxPOYw2HDqNhnljGcJWYo36w=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=CF7z4/UxPdnSOyVmTJ1clKGMh5tRWrAtD2wDf4+8kouVSetuE3g2317Uy6zaC0DZqKymT3i/kMgTuY+PrJxCwjHAmrhzsLQmj/AOvzM+lHHWp6y8ManWUOAejX6YHbUaSf0dIM4ZHPZ3edqRC671RGtAwVp0ljLzVpsiovWUIc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4W0Cmj1Q7sz4f3m78;
	Thu, 13 Jun 2024 14:53:41 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id AE4E61A0FBD;
	Thu, 13 Jun 2024 14:53:52 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgBHGBF+l2pmLWhmPQ--.2534S3;
	Thu, 13 Jun 2024 14:53:52 +0800 (CST)
Subject: Re: [PATCH RFC -next 0/7] blk-iocost: support to build iocost as
 kernel module
To: Greg KH <gregkh@linuxfoundation.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: axboe@kernel.dk, tj@kernel.org, josef@toxicpanda.com,
 lizefan.x@bytedance.com, hannes@cmpxchg.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, yi.zhang@huawei.com,
 yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20240613014937.1326020-1-yukuai1@huaweicloud.com>
 <2024061342-walk-cavalier-7e48@gregkh>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <278e27fd-ff5f-660a-5173-b0cff6c55821@huaweicloud.com>
Date: Thu, 13 Jun 2024 14:53:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <2024061342-walk-cavalier-7e48@gregkh>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBHGBF+l2pmLWhmPQ--.2534S3
X-Coremail-Antispam: 1UD129KBjvdXoW7JF4DCF47Xry8XF47GryDZFb_yoWDZrc_u3
	WkJryI9rnrGF4Iyw4ktFsavFZrWF4rCrWqy348XFW2qF1FyFsFyws3ZrZ5ZFn8tF17GF95
	ury3ZFyv9Fy7WjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUba8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
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
	3wCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcS
	sGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2024/06/13 13:54, Greg KH Ð´µÀ:
> On Thu, Jun 13, 2024 at 09:49:30AM +0800, Yu Kuai wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> Yu Kuai (7):
>>    kernfs: export pr_cont_kernfs_path()
>>    cgroup: export cgroup_parse_float
>>    block: export some API
>>    blk-iocost: factor out helpers to handle params from ioc_qos_write()
>>    blk-iocost: parse params before initializing iocost
>>    blk-iocost: support to free iocost
>>    blk-iocost: support to build iocost as kernel module
> 
> No where do you say _why_ building this as a module is a good idea.

Yes, we discussed this before and this is actually an general question.
Main advantages are:

- Flexibility and Maintainability, allows for dynamic loading and
unloading of modules at runtime without the need to recompile and
restart the kernel, for example fixing iocost CVE in our production
environment.

- Kernel Size and Resource Usage, modules are loaded only when their
specific functionality is required.

Thanks,
Kuai

> 
> Why do this at all?
> 
> thanks,
> 
> greg k-h
> 
> .
> 


