Return-Path: <cgroups+bounces-4368-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E09957F2F
	for <lists+cgroups@lfdr.de>; Tue, 20 Aug 2024 09:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 225941C23AD9
	for <lists+cgroups@lfdr.de>; Tue, 20 Aug 2024 07:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC8E16D313;
	Tue, 20 Aug 2024 07:13:51 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BAB1667ED;
	Tue, 20 Aug 2024 07:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724138031; cv=none; b=Z8wi98xbcNgMNXEDvfFmObR6gQQwwlC8PWhxQ6KYwzgXbTeDzKxCSmxncX6DaIXANG+nZM2S4hfOfBMBPXpyzkE3R6dF37NSwUa/y+raRza9RxM1jSpOlMYBglsWOxOOQR+mXowMtVzOi3n5dd6oqhL5Xg2DQpn1e1ZsLGpv6KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724138031; c=relaxed/simple;
	bh=XCoTEaNpEo9WksCi1jc/+c3zlnEhaEoqy/tDH8Z3w8w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UNbe+ZgqHjzXzKDqseh4ON/m5Kzr3RnpDOPjYgC50xc2t49LVLCHEX2gQVf/KSbLRr+YuJ0vI8jzgrXMdA1sAmHiAehb/PyyqGxHA8WtflkhQcMBqp8dQivzaUZ/Z46G8NVg6B91cW1HHXpwJs6Vo/8VtvY0gTell9GxgHkBcQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Wp1093Nzcz4f3jk0;
	Tue, 20 Aug 2024 15:13:29 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 14E471A018D;
	Tue, 20 Aug 2024 15:13:39 +0800 (CST)
Received: from [10.174.179.155] (unknown [10.174.179.155])
	by APP4 (Coremail) with SMTP id gCh0CgB37IIhQsRmPw_NCA--.30967S3;
	Tue, 20 Aug 2024 15:13:38 +0800 (CST)
Message-ID: <028f4d78-ebf6-c9cf-a8d8-718779cbe419@huaweicloud.com>
Date: Tue, 20 Aug 2024 15:13:37 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:104.0) Gecko/20100101
 Thunderbird/104.0
Subject: Re: [PATCH v3] block: flush all throttled bios when deleting the
 cgroup
To: Tejun Heo <tj@kernel.org>
Cc: josef@toxicpanda.com, hch@lst.de, mkoutny@suse.com, axboe@kernel.dk,
 cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yukuai1@huaweicloud.com, houtao1@huawei.com,
 yi.zhang@huawei.com, yangerkun@huawei.com, yukuai3@huawei.com,
 lilingfeng3@huawei.com
References: <20240817071108.1919729-1-lilingfeng@huaweicloud.com>
 <ZsO4ArRKhZrtDoey@slm.duckdns.org>
From: Li Lingfeng <lilingfeng@huaweicloud.com>
In-Reply-To: <ZsO4ArRKhZrtDoey@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgB37IIhQsRmPw_NCA--.30967S3
X-Coremail-Antispam: 1UD129KBjvdXoWrZr13CrWUJrW5Aw4kJryxKrg_yoWkKFg_ur
	Waqr1kAw18Xa4kCay3Ga9xWFZIgr48Gry7Xan5tryqgryrJa1DZFZrGrW3ZFy3Za4xKr9x
	JrnrX3W3uwn7ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
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
X-CM-SenderInfo: polox0xjih0w46kxt4xhlfz01xgou0bp/


在 2024/8/20 5:24, Tejun Heo 写道:
> Hello,
>
> On Sat, Aug 17, 2024 at 03:11:08PM +0800, Li Lingfeng wrote:
>> From: Li Lingfeng <lilingfeng3@huawei.com>
>>
>> When a process migrates to another cgroup and the original cgroup is deleted,
>> the restrictions of throttled bios cannot be removed. If the restrictions
>> are set too low, it will take a long time to complete these bios.
>>
>> Refer to the process of deleting a disk to remove the restrictions and
>> issue bios when deleting the cgroup.
>>
>> This makes difference on the behavior of throttled bios:
>> Before: the limit of the throttled bios can't be changed and the bios will
>> complete under this limit;
>> Now: the limit will be canceled and the throttled bios will be flushed
>> immediately.
> I still don't see why this behavior is better. Wouldn't this make it easy to
> escape IO limits by creating cgroups, doing a bunch of IOs and then deleting
> them?
>
> Thanks.
Yes, this actually would make it easy to escape IO limits.

As described by Yu Kuai in v2, I changed this to prevent IO hang.
And I think it may be more appropriate to remove the limits in this
scenario since the limits were set by cgroup and the cgroup has been
deleted.

Thanks.


