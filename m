Return-Path: <cgroups+bounces-8582-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7038ADE639
	for <lists+cgroups@lfdr.de>; Wed, 18 Jun 2025 11:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FA46175174
	for <lists+cgroups@lfdr.de>; Wed, 18 Jun 2025 09:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9671927EFE6;
	Wed, 18 Jun 2025 09:03:54 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099A7210FB;
	Wed, 18 Jun 2025 09:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750237434; cv=none; b=ISqZ83cuLLfPxeUr1Cq9VpUFUvsbmRYlyGmQr8fB44/n/rsMT96cPZVnVoU/mOiAIbR86hj7uou590SgK+cD4S/ZGlIQYZtYWb+yD+XR7VLvMdbiFmAaM6WW5X2cjnTYrEHxjvK/69ESKOWT8HJiQw6BHG28w9YQgeCgzWbC8Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750237434; c=relaxed/simple;
	bh=0CaCRVJUxlmn8IXtVkJcHyza7fFV20U9G1AqPhJA228=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LuXw7iElszrystVkpMYlrMyXhIqPKREvI0bLKqgpbdqe3Qxy6hU+f1EQsSi0wGO8QkcKgGAKouYtYqhDrW4ayDfcGXNT2E3yxFWjKIwvcAjO4oeBVRnuOhFVVwI0nLnHSqPnUxipK8ajGEVjIbQ1JJ5AbfFI6oYMkro+YySyhbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bMd865cDYzKHN5d;
	Wed, 18 Jun 2025 17:03:50 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 25D141A0847;
	Wed, 18 Jun 2025 17:03:49 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP3 (Coremail) with SMTP id _Ch0CgB3ycPzgFJotaiTPg--.6566S2;
	Wed, 18 Jun 2025 17:03:48 +0800 (CST)
Message-ID: <906caca3-8564-4443-a1bd-3c18449b0d64@huaweicloud.com>
Date: Wed, 18 Jun 2025 17:03:47 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [next] cgroup,freezer: fix incomplete freezing when attaching
 tasks
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: tj@kernel.org, hannes@cmpxchg.org, rafael.j.wysocki@intel.com,
 mingo@kernel.org, peterz@infradead.org, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, lujialin4@huawei.com, chenridong@huawei.com
References: <20250618073217.2983275-1-chenridong@huaweicloud.com>
 <sfmtpva4z4jxrlmmeyigz4n7wozfveii3cuaks3s4dgf6noyfg@gutbimmbjfbb>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <sfmtpva4z4jxrlmmeyigz4n7wozfveii3cuaks3s4dgf6noyfg@gutbimmbjfbb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgB3ycPzgFJotaiTPg--.6566S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tF4kCFyDGF15ZrWxtF45trb_yoW8XF1rpr
	Z5C3Wjyan5Kr12kryq9a1SvryrKFs7Jr48GF1DWF18JF13Wa42gr4Ivws0gFW5tF1Iyryr
	Ja1Yvr1SyayDAaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
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



On 2025/6/18 16:42, Michal Koutný wrote:
> On Wed, Jun 18, 2025 at 07:32:17AM +0000, Chen Ridong <chenridong@huaweicloud.com> wrote:
>> From: Chen Ridong <chenridong@huawei.com>
>>
>> An issue was found:
> 
> An obligatory reminder to move to freezer in the unifier hierarchy if
> possible. Thanks for the fix though.
> 
Thanks, we are trying to switch to cgroup v2. However some products are
still using cgroup v1.

Thank you for your review.

BR,
Ridong

>>
>> 	# cd /sys/fs/cgroup/freezer/
>> 	# mkdir test
>> 	# echo FROZEN > test/freezer.state
>> 	# cat test/freezer.state
>> 	FROZEN
>> 	# sleep 1000 &
>> 	[1] 863
>> 	# echo 863 > test/cgroup.procs
>> 	# cat test/freezer.state
>> 	FREEZING
>>
>> When tasks are migrated to a frozen cgroup, the freezer fails to
>> immediately freeze the tasks, causing the cgroup to remain in the
>> "FREEZING".
>>
>> The freeze_task() function is called before clearing the CGROUP_FROZEN
>> flag. This causes the freezing() check to incorrectly return false,
>> preventing __freeze_task() from being invoked for the migrated task.
>>
>> To fix this issue, clear the CGROUP_FROZEN state before calling
>> freeze_task().
>>
>> Fixes: f5d39b020809 ("freezer,sched: Rewrite core freezer logic")
>> Reported-by: Zhong Jiawei <zhongjiawei1@huawei.com>
>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>> ---
>>  kernel/cgroup/legacy_freezer.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> Acked-by: Michal Koutný <mkoutny@suse.com>


