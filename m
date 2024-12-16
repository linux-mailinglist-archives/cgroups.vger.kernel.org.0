Return-Path: <cgroups+bounces-5905-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE579F2E74
	for <lists+cgroups@lfdr.de>; Mon, 16 Dec 2024 11:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D61531889B36
	for <lists+cgroups@lfdr.de>; Mon, 16 Dec 2024 10:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C0920408C;
	Mon, 16 Dec 2024 10:45:18 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3EE203D4C;
	Mon, 16 Dec 2024 10:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734345918; cv=none; b=aGGD1HURYPJk0lWBUmigNyDGkBMCvBMRhgem6H8jFfyTCFasda+H7TQOFnwY0oQLGW5NYmjetZkUYTzRBsPCiFBfxRiqnibER/dtZgNjaFypjpnSp8OEo8iv9vUmwz0OEUdBbyIz+Xb3VtNRdciEQi1+0pGyv9FiNuLZoqJl/+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734345918; c=relaxed/simple;
	bh=b6jv3+DWBxCF8l0TUWPyTMuxIa0cbs6w/yR4rfH7TGI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R73EE7Ak99XEHqMkzH7AHen5TVJnvvryjrm4ZbvS1HMncTc5v+JE2NyD5tgxOGYYz1wNuHkiV4wwqQCsXuhpVanggrmLD1/HiqdNkds0grMNkPJGlRbF7IL1O9ng4mz0IswUucyT9/EeCkDdPP9Gwesn5IdInv5ameKVjRNOspA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YBc5c0lnPz4f3khf;
	Mon, 16 Dec 2024 18:44:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 862241A0194;
	Mon, 16 Dec 2024 18:45:11 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP3 (Coremail) with SMTP id _Ch0CgAH5sK1BGBn6R17Eg--.10368S2;
	Mon, 16 Dec 2024 18:45:11 +0800 (CST)
Message-ID: <fe6728eb-d1a4-4e5d-a01c-9585452d0a79@huaweicloud.com>
Date: Mon, 16 Dec 2024 18:45:09 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] freezer, sched: report the frozen task stat as 'D'
To: Tejun Heo <tj@kernel.org>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, mkoutny@suse.com,
 roman.gushchin@linux.dev, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, chenridong@huawei.com, wangweiyang2@huawei.com
References: <20241213110332.3105932-1-chenridong@huaweicloud.com>
 <Z1xkFq9WIeF-MvHr@slm.duckdns.org>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <Z1xkFq9WIeF-MvHr@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgAH5sK1BGBn6R17Eg--.10368S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Wr4ruw13Zw17JFWrGryrtFb_yoWfXwb_ua
	13KFy0kFs7Xr4fZ3W7tF42yryrKayxXrn7X395Gr4jyrs8Ja95G3Z5XFWDGrWfWrZ7uF1q
	k3ZIqaykKwnI9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbx8YFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AK
	xVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_Wryl
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UAwI
	DUUUUU=
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2024/12/14 0:43, Tejun Heo wrote:
> On Fri, Dec 13, 2024 at 11:03:32AM +0000, Chen Ridong wrote:
> ...
>> diff --git a/include/linux/sched.h b/include/linux/sched.h
>> index d380bffee2ef..dbe0cb97461f 100644
>> --- a/include/linux/sched.h
>> +++ b/include/linux/sched.h
>> @@ -1630,8 +1630,9 @@ static inline unsigned int __task_state_index(unsigned int tsk_state,
>>  	 * We're lying here, but rather than expose a completely new task state
>>  	 * to userspace, we can make this appear as if the task has gone through
>>  	 * a regular rt_mutex_lock() call.
>> +	 * Report the frozen task uninterruptible.
>>  	 */
>> -	if (tsk_state & TASK_RTLOCK_WAIT)
>> +	if (tsk_state & TASK_RTLOCK_WAIT || tsk_state & TASK_FROZEN)
> 
> Can you please add ()'s so that it's if ((a & b) || (c & d))? Other than
> that,
> 
> Acked-by: Tejun Heo <tj@kernel.org>
> 
> Thanks.
> 

Thanks, will update.


