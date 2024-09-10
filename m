Return-Path: <cgroups+bounces-4783-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2DDF972784
	for <lists+cgroups@lfdr.de>; Tue, 10 Sep 2024 05:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02512B2418A
	for <lists+cgroups@lfdr.de>; Tue, 10 Sep 2024 03:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A7B14D719;
	Tue, 10 Sep 2024 03:08:26 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DE14436A;
	Tue, 10 Sep 2024 03:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725937703; cv=none; b=db77Gytciz1MpQLZeASm+Kardd1eGcRpGkyHjKWlZIYkXclFVzXnPkTc8tmRk08vqFxge1fWe5/mglfRScWmKVfJmLkOuSB8iwIjpUdufFbY5dVc3FO6JMMtCINkUeGQAOS5EiUWkp7tdXWDkUoz9LrEUgiX1cAzfZraCw1oeUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725937703; c=relaxed/simple;
	bh=CGNC5vOabUFGn3zbWqEpudwA5CU9RpdJX8LOgG6Kujg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KGPSEhp6iikxKKYsYztwQcNdbSR3sWwQ0UYfQS8nuyKqq1atzxTb3Z31s3CuWpOS8QS68jl095uFRzt7LU8Q3x2T2xzZipwlJkf2K9YW1ctO9L173sjf7L0hL/qAaGrC0y72WEopblDmFbHFaKj0xANIaN0pzDRQGw3pOdUhvm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4X2pYH53nJz4f3jkV;
	Tue, 10 Sep 2024 11:08:03 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 455251A06D7;
	Tue, 10 Sep 2024 11:08:14 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP1 (Coremail) with SMTP id cCh0CgDXAS4cuN9mnFB7Aw--.46030S2;
	Tue, 10 Sep 2024 11:08:14 +0800 (CST)
Message-ID: <5a29e13b-7956-4f68-8c39-92183e5ed0ca@huaweicloud.com>
Date: Tue, 10 Sep 2024 11:08:12 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 -next 2/3] cgroup/freezer: Reduce redundant propagation
 for cgroup_propagate_frozen
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Chen Ridong <chenridong@huawei.com>
Cc: tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
 longman@redhat.com, adityakali@google.com, sergeh@kernel.org,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240905134130.1176443-1-chenridong@huawei.com>
 <20240905134130.1176443-3-chenridong@huawei.com>
 <cieafhuvoj4xby634ezy244j4fi555aytp65cqefw3floxejjj@gn7kcaetqwlj>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <cieafhuvoj4xby634ezy244j4fi555aytp65cqefw3floxejjj@gn7kcaetqwlj>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDXAS4cuN9mnFB7Aw--.46030S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZF13GF4xtr4DurWxGFWxZwb_yoWrCryfpr
	Z5JF4Skw4Dtr1avrn8t34j9Fsa9Fs3tr48Kry5Xa4xJrZxXr97tFy8A34Ygr18ArWSyrW5
	AFWYvwnruws3ZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	7KsUUUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2024/9/10 3:02, Michal Koutný wrote:
> On Thu, Sep 05, 2024 at 01:41:29PM GMT, Chen Ridong <chenridong@huawei.com> wrote:
>> When a cgroup is frozen/unfrozen, it will always propagate down to up.
>                                                               bottom up
> 
>> However it is unnecessary to propagate to the top every time. This patch
>> aims to reduce redundant propagation for cgroup_propagate_frozen.
>>
>> For example, subtree like:
>> 	a
>> 	|
>> 	b
>>        / | \
>>       c  d  e
>> If c is frozen, and d and e are not frozen now, it doesn't have to
>> propagate to a; Only when c, d and e are all frozen, b and a could be set
>> to frozen. Therefore, if nr_frozen_descendants is not equal to
>> nr_descendants, just stop propagate. If a descendant is frozen, the
>> parent's nr_frozen_descendants add child->nr_descendants + 1. This can
>> reduce redundant propagation.
> 
> So, IIUC, this saves the updates by aggregating updates of
> nr_frozen_descendants into chunks sized same like each child's
> nr_descendants, otherwise there's no effect to propagate upward,
> correct?
> 

correct.

> This would deserve some update of the
> cgroup_freezer_state.nr_frozen_descendants comment.
> 
>>
>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>> ---
>>   kernel/cgroup/freezer.c | 31 +++++++++++++++++++++++--------
>>   1 file changed, 23 insertions(+), 8 deletions(-)
>>
>> diff --git a/kernel/cgroup/freezer.c b/kernel/cgroup/freezer.c
>> index 02af6c1fa957..e4bcc41b6a30 100644
>> --- a/kernel/cgroup/freezer.c
>> +++ b/kernel/cgroup/freezer.c
>> @@ -13,7 +13,7 @@
>>    */
>>   static void cgroup_propagate_frozen(struct cgroup *cgrp, bool frozen)
>>   {
>> -	int desc = 1;
>> +	struct cgroup *child = cgrp;
>>   
>>   	/*
>>   	 * If the new state is frozen, some freezing ancestor cgroups may change
>> @@ -23,23 +23,38 @@ static void cgroup_propagate_frozen(struct cgroup *cgrp, bool frozen)
>>   	 */
>>   	while ((cgrp = cgroup_parent(cgrp))) {
>>   		if (frozen) {
>> -			cgrp->freezer.nr_frozen_descendants += desc;
>> +			/*
>> +			 * A cgroup is frozen, parent nr frozen descendants should add
>> +			 * nr cgroups of the entire subtree , including child itself.
>> +			 */
>> +			cgrp->freezer.nr_frozen_descendants += child->nr_descendants + 1;
> 
> Shouldn't this be
> 			cgrp->freezer.nr_frozen_descendants += child->nr_frozen_descendants + 1;
> ?

child->nr_frozen_descendants should be equal to child->nr_descendants if 
the subtree is already frozen.

> 
>> +
>> +			/*
>> +			 * If there is other descendant is not frozen,
>> +			 * cgrp and its parent couldn't be frozen, just break
>> +			 */
>> +			if (cgrp->freezer.nr_frozen_descendants !=
>> +			    cgrp->nr_descendants)
>> +				break;
> 
> Parent's (and ancestral) nr_frozen_descendants would be out of date.
> This should be correct also wrt cgroup creation and removal.
> 
Before calling cgroup_freeze, cgroup_freeze_write have hold the 
cgroup_mutex, could parent's nr_frozen_descendants be changed?

>> +
>> +			child = cgrp;
> 
> This is same in both branches, so it can be taken outside (maybe even
> replace while() with for() if it's cleaner.)
I will try.
> 
>>   			if (!test_bit(CGRP_FROZEN, &cgrp->flags) &&
>> -			    test_bit(CGRP_FREEZE, &cgrp->flags) &&
>> -			    cgrp->freezer.nr_frozen_descendants ==
>> -			    cgrp->nr_descendants) {
>> +			    test_bit(CGRP_FREEZE, &cgrp->flags)) {
>>   				set_bit(CGRP_FROZEN, &cgrp->flags);
>>   				cgroup_file_notify(&cgrp->events_file);
>>   				TRACE_CGROUP_PATH(notify_frozen, cgrp, 1);
>> -				desc++;
>>   			}
>>   		} else {
>> -			cgrp->freezer.nr_frozen_descendants -= desc;
>> +			cgrp->freezer.nr_frozen_descendants -= (child->nr_descendants + 1);
> 
> nit:                                here you add parentheses but not in the frozen branch
> 
>> +
>> +			child = cgrp;
>>   			if (test_bit(CGRP_FROZEN, &cgrp->flags)) {
>>   				clear_bit(CGRP_FROZEN, &cgrp->flags);
>>   				cgroup_file_notify(&cgrp->events_file);
>>   				TRACE_CGROUP_PATH(notify_frozen, cgrp, 0);
>> -				desc++;
>> +			} else {
>> +				/* If parent is unfrozen, don't have to propagate more */
>> +				break;
>>   			}
>>   		}
>>   	}
> 
> I understand the idea roughly. The code in cgroup_propagate_frozen was
> (and stays after your change) slightly difficult to read smoothly but I
> think if it can be changed, the reduced (tree) iteration may end up
> correct.
> 
> 
> Thanks,
> Michal

Thanks, I will update in next patch.

Best regards,
Ridong


