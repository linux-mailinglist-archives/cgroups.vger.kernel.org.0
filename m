Return-Path: <cgroups+bounces-3649-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 873BA92F5B3
	for <lists+cgroups@lfdr.de>; Fri, 12 Jul 2024 08:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4202A283597
	for <lists+cgroups@lfdr.de>; Fri, 12 Jul 2024 06:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D96C13D603;
	Fri, 12 Jul 2024 06:51:58 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB14C39B;
	Fri, 12 Jul 2024 06:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720767118; cv=none; b=R45vwn+BKKOg5U/kVd4gAu+BIH3so6BAtg2XRjcifoBJ1NxKQRsGTvkETv1GXf2PUwmNe+U2SAeWoWnV+YgQUMzwGVcOuxG8KOCWUEKWHbw6AE8g3CA8p9av4fxOCT/3as/heWtB6thyOKurg/51IPGaLCrRStUzCGpm0OT+cuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720767118; c=relaxed/simple;
	bh=N6YChGETgXAsTATwIa3SBIwBb+q0UqUKKngV4F/vp5E=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=S3i6QhYwHzTUQE4FEuYQTqON4+x8ebdZ0nx+igNrJTkVQ/LsgP+yTt+Txcc2fTGASxQLOetfw4jpmJa3mbjZi+PV9dR2lhiaQliOxcch22wCaBybFuERcHF177hUb4vq3DhjAk1+cBUsWO24MH57eH6FJbLOFJk7G30gGUUHQdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WL2M02NSzz4f3jXw;
	Fri, 12 Jul 2024 14:51:40 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 161211A0572;
	Fri, 12 Jul 2024 14:51:52 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP2 (Coremail) with SMTP id Syh0CgCXAIaG0pBmEsGABw--.32319S3;
	Fri, 12 Jul 2024 14:51:51 +0800 (CST)
Subject: Re: [PATCH 2/2] blk-ioprio: remove per-disk structure
To: Christoph Hellwig <hch@infradead.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: Bart Van Assche <bvanassche@acm.org>, tj@kernel.org,
 josef@toxicpanda.com, jack@suse.cz, axboe@kernel.dk,
 cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20240711090059.3998565-1-yukuai1@huaweicloud.com>
 <20240711090059.3998565-3-yukuai1@huaweicloud.com>
 <4c8f1e4e-1b15-4afa-b1e2-084e0c4caeec@acm.org>
 <520b9c10-c152-77f3-bd5a-b86a1f5ac8ea@huaweicloud.com>
 <ZpC9le_FsIO0FCJQ@infradead.org>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <7803ebeb-32a1-57a9-2a65-b44de8f42eed@huaweicloud.com>
Date: Fri, 12 Jul 2024 14:51:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZpC9le_FsIO0FCJQ@infradead.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgCXAIaG0pBmEsGABw--.32319S3
X-Coremail-Antispam: 1UD129KBjvdXoW7JFyxZF1fWF1fKw1xCr4UArb_yoWfWrcEgF
	WkZa9Fk3sxWF9rWFsrZr4UZr9ayFyqgry2qFy7tFZrtrWagrWDGF1DG34fZFyfGw4xKryU
	KF909r1rKrW2kjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb3xFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_GcCE
	3s1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
	1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0
	cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8Jw
	ACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkI
	wI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1l
	IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvf
	C2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2024/07/12 13:22, Christoph Hellwig Ð´µÀ:
> On Fri, Jul 12, 2024 at 09:10:30AM +0800, Yu Kuai wrote:
>>> As one can see in the output of git grep -nHEB1 '>pd_(alloc|free)_fn\(',
>>> none of the pd_alloc_fn / pd_free_fn callers checks whether or not these
>>> pointers are NULL. Hence my question why this patch does not trigger any
>>> NULL pointer dereferences?
>>
>> Because the blkcg_deactivate_policy() is removed as well, there are no
>> callers now... blkcg_policy_register() is still called to make sure
>> cpd_(alloc|free)_fn will still be called.
> 
> Can you throw in a patch documenting this?  Any maybe add a check
> that pd_alloc_fn / pd_free_fn exist in blkcg_activate_policy and
> WARN and return an error otherwise?

Of course, I realized now that just mention don't activate the policy
from commit message is too little explanation.

Thanks,
Kuai

> 
> .
> 


