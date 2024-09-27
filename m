Return-Path: <cgroups+bounces-4966-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 125A09881BC
	for <lists+cgroups@lfdr.de>; Fri, 27 Sep 2024 11:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCCA32853CB
	for <lists+cgroups@lfdr.de>; Fri, 27 Sep 2024 09:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05DE91BC9FF;
	Fri, 27 Sep 2024 09:46:30 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08161BA886
	for <cgroups@vger.kernel.org>; Fri, 27 Sep 2024 09:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727430389; cv=none; b=eVbrwLF0nRBgXvPIQWjjvZm5LIin87D5NTIssE0ZnmMQyoXp/uW8AAmHfrepbDK5a2sOkrYvAuvTHtBh43bFojKAxDlSM8QVXT2hYFvZSqang2oPmlPYxtLfZdgCoqLOCCOz41UJ6zOkfO0PxY6Kf0n1/JgvgKr6mSwJaxZoh6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727430389; c=relaxed/simple;
	bh=1Y5ImYC/6aJHUB3s8OWr2FUFRuDLikg5A/Dc2BiOACs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CXlmXrbjD61Ls78VtYNHjuK7rkUgdiUsFS8o5KEipV0qhQZBHZv+M11HS10svH5BleKIZH6kFkIcA2LbiF6GqzKCXN22igxInq77tG/VXom0gDumA8CKitQRDNaSeQoKkijiqENDEC23KBokXtRPzbr7DMfGmBwoOWRwhFvxjRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XFQZk1mNkz4f3jdg
	for <cgroups@vger.kernel.org>; Fri, 27 Sep 2024 17:46:06 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 8EA041A0359
	for <cgroups@vger.kernel.org>; Fri, 27 Sep 2024 17:46:22 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP4 (Coremail) with SMTP id gCh0CgCHvMjtfvZmXkzyCQ--.33465S2;
	Fri, 27 Sep 2024 17:46:22 +0800 (CST)
Message-ID: <1bf886ad-10f4-435d-8fb1-ddd639cb3992@huaweicloud.com>
Date: Fri, 27 Sep 2024 17:46:21 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATHC v3 -next 3/3] cgroup/freezer: Reduce redundant propagation
 for cgroup_propagate_frozen
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Chen Ridong <chenridong@huawei.com>
Cc: tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
 longman@redhat.com, adityakali@google.com, sergeh@kernel.org, guro@fb.com,
 cgroups@vger.kernel.org
References: <20240915071307.1976026-1-chenridong@huawei.com>
 <20240915071307.1976026-4-chenridong@huawei.com>
 <7j6zywvbd2lavlj5wc3yevc4s7ofrusjlpwcmuchhknlhp2mxo@77rwal3h2x65>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <7j6zywvbd2lavlj5wc3yevc4s7ofrusjlpwcmuchhknlhp2mxo@77rwal3h2x65>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCHvMjtfvZmXkzyCQ--.33465S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCr4xuF1rXFW7Ww15CF4Durg_yoWrXryUpr
	WkAF4xtanYyr1Yvr1Dt34jvFnagrs3tr48KrW5ta4xJFsIqr92gr1kA3s8Wr18ArZ2vryY
	y3WYvw1UCwn7tF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
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



On 2024/9/26 1:46, Michal Koutný wrote:
> On Sun, Sep 15, 2024 at 07:13:07AM GMT, Chen Ridong <chenridong@huawei.com> wrote:
>> diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
>> index dd1ecab99eeb..41e4e5a7ae55 100644
>> --- a/include/linux/cgroup-defs.h
>> +++ b/include/linux/cgroup-defs.h
>> @@ -401,7 +401,9 @@ struct cgroup_freezer_state {
>>   
>>   	/* Fields below are protected by css_set_lock */
>>   
>> -	/* Number of frozen descendant cgroups */
>> +	/* Aggregating frozen descendant cgroups, only when all
>> +	 * descendants of a child are frozen will the count increase.
>> +	 */
>>   	int nr_frozen_descendants;
>>   
>>   	/*
>> diff --git a/kernel/cgroup/freezer.c b/kernel/cgroup/freezer.c
>> index bf1690a167dd..4ee33198d6fb 100644
>> --- a/kernel/cgroup/freezer.c
>> +++ b/kernel/cgroup/freezer.c
>> @@ -35,27 +35,34 @@ static bool cgroup_update_frozen_flag(struct cgroup *cgrp, bool frozen)
>>    */
>>   static void cgroup_propagate_frozen(struct cgroup *cgrp, bool frozen)
>>   {
>> -	int desc = 1;
>> -
>> +	int deta;
>              delta
> 
>> +	struct cgroup *parent;
> 
> I'd suggest here something like
> 
> 	/* root cgroup never changes freeze state */
> 	if (WARN_ON(cgroup_parent(cgrp))
> 		return;
> 
> so that the parent-> dereference below is explicitly safe.
> 
>>   	/*
>>   	 * If the new state is frozen, some freezing ancestor cgroups may change
>>   	 * their state too, depending on if all their descendants are frozen.
>>   	 *
>>   	 * Otherwise, all ancestor cgroups are forced into the non-frozen state.
>>   	 */
>> -	while ((cgrp = cgroup_parent(cgrp))) {
>> +	for (; cgrp; cgrp = cgroup_parent(cgrp)) {
>>   		if (frozen) {
>> -			cgrp->freezer.nr_frozen_descendants += desc;
>> +			/* If freezer is not set, or cgrp has descendants
>> +			 * that are not frozen, cgrp can't be frozen
>> +			 */
>>   			if (!test_bit(CGRP_FREEZE, &cgrp->flags) ||
>>   			    (cgrp->freezer.nr_frozen_descendants !=
>> -			    cgrp->nr_descendants))
>> -				continue;
>> +			     cgrp->nr_descendants))
>> +				break;
>> +			deta = cgrp->freezer.nr_frozen_descendants + 1;
>>   		} else {
>> -			cgrp->freezer.nr_frozen_descendants -= desc;
>> +			deta = -(cgrp->freezer.nr_frozen_descendants + 1);
> 
> In this branch, if cgrp is unfrozen, delta = -1 is cgrp itself,
> however is delta = -cgrp->freezer.nr_frozen_descendants warranted?
> What if they are frozen empty children (of cgrp)? They likely shouldn't
> be subtracted from ancestors nf_frozen_descendants.
> 
> (This refers to a situation when
> 
> 	C	CGRP_FREEZE is set
> 	|\
> 	D E	both CGRP_FREEZE is set
> 
> and an unfrozen task is migrated into C which would make C (temporarily)
> unfrozen but not D nor E.)
> 
Thank you, Michal.

I sorry I missed this situation.
If unfreezing a cgroup, it seems it has to propagate to the top.

After consideration, I modify this function.
the following is acceptable?

/*
  * Propagate the cgroup frozen state upwards by the cgroup tree.
  */
static void cgroup_propagate_frozen(struct cgroup *cgrp, bool frozen)
{
	int deta = 0;
	struct cgroup *parent;
	/*
	 * case1: If the new state is frozen, some freezing ancestor cgroups 
may change
	 * their state too, depending on if all their descendants are frozen.
	 *
	 * case2: unfrozen, all ancestor cgroups are forced into the non-frozen 
state.
	 */
	for (; cgrp; cgrp = cgroup_parent(cgrp)) {
		if (frozen) {
			/* If freezer is not set, or cgrp has descendants
			 * that are not frozen, cgrp can't be frozen
			 */
			if (!test_bit(CGRP_FREEZE, &cgrp->flags) ||
			    (cgrp->freezer.nr_frozen_descendants !=
			     cgrp->nr_descendants))
				break;			
			/* No change, stop propagate */
			if (!cgroup_update_frozen_flag(cgrp, frozen))
				break;
			deta = cgrp->freezer.nr_frozen_descendants + 1;
		} else {
			/* case2: have to propagate all ancestor */
			if (cgroup_update_frozen_flag(cgrp, frozen))
				deta++;
		}

		parent = cgroup_parent(cgrp);
		parent->freezer.nr_frozen_descendants += deta;
	}
}

Best regards,
Ridong


