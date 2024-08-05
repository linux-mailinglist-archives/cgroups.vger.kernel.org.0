Return-Path: <cgroups+bounces-4078-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A81947265
	for <lists+cgroups@lfdr.de>; Mon,  5 Aug 2024 02:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9C53B222FD
	for <lists+cgroups@lfdr.de>; Mon,  5 Aug 2024 00:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E048229406;
	Mon,  5 Aug 2024 00:43:33 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121841CF90;
	Mon,  5 Aug 2024 00:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722818613; cv=none; b=rE6SL1clw3//aPk/1yAmfazLjxLbDFgbxtAyhaJCNiDxYzsiOq/WyS2AHM/rOhT+/X+mT70uu+9Nk1FsUT7AT9fPpSNE1XzAVHqkLvqEC8PbXpzTnz5xrWn2RdCjeYIurUJzyn9jPLXPNSzgCt8+1iwcIhLZt0Km6D0UDelwpZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722818613; c=relaxed/simple;
	bh=qtFHU41ZOauNlRmNifyoEeWW+O2btftbwPTJvZNtL9M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vCQ6avalktMbxd7otYLKhSn2093VG3IrQjeRwq0dckvifa1Mtz/B+uhqtBNOR9ZfLrbKewlUfk92mlbwWNfNqZWCFPDsvHDl9dYOlIlUlI5k6VBygcvjuL370y3Hlo+vR6xl10PLmHhrVkC5rJaixK4dHETTC+YtzFONUc66M70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Wcd2g6f2kz4f3jMx;
	Mon,  5 Aug 2024 08:43:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 228161A084D;
	Mon,  5 Aug 2024 08:43:21 +0800 (CST)
Received: from [10.67.110.112] (unknown [10.67.110.112])
	by APP1 (Coremail) with SMTP id cCh0CgCXn1EnILBmIdESAw--.43194S2;
	Mon, 05 Aug 2024 08:43:20 +0800 (CST)
Message-ID: <56e67b4e-ff00-7405-25c7-0b67d535fa19@huaweicloud.com>
Date: Mon, 5 Aug 2024 08:43:19 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH -next] cgroup/pids: Remove unreachable paths of
 pids_{can,cancel}_fork
Content-Language: en-US
To: Waiman Long <longman@redhat.com>, tj@kernel.org, lizefan.x@bytedance.com,
 hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 xiujianfeng@huawei.com
References: <20240803061607.50470-1-xiujianfeng@huaweicloud.com>
 <309c8d74-a51f-42f7-b526-f5e74c0ac22c@redhat.com>
From: Xiu Jianfeng <xiujianfeng@huaweicloud.com>
In-Reply-To: <309c8d74-a51f-42f7-b526-f5e74c0ac22c@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCXn1EnILBmIdESAw--.43194S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KrW7Ar45WF4rCrW5JF17trb_yoW8Kw13pF
	n7J34fGFWrCas5ur1rJrZxZFy3tan2g3W5Cr4kXa4Syr42yr1jgFyjgr109ry3ZrWxKw17
	JF1jga9xur1UJr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AF
	wI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UK2N
	tUUUUU=
X-CM-SenderInfo: x0lxyxpdqiv03j6k3tpzhluzxrxghudrp/



On 2024/8/3 21:59, Waiman Long wrote:
> 
> On 8/3/24 02:16, Xiu Jianfeng wrote:
>> From: Xiu Jianfeng <xiujianfeng@huawei.com>
>>
>> According to the implement of cgroup_css_set_fork() and the usage in
> "implementation"?

Thanks, will do

>> the cpuset controller which also has .can_fork and .cancel_fork hooks,
>> the argument 'cset' for these two hooks must not be NULL, so remove
>> the unrechable paths in thse two hooks.
> 
> It is primarily due to cgroup_css_set_fork() will fail if cset cannot be
> found and the can_fork/cancel_fork method will not be called in this case.

Thanks for your review, I will reword the commit message in the next
version.

> 
> Cheers,
> Longman
> 
>>
>> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
>> ---
>>   kernel/cgroup/pids.c | 14 ++------------
>>   1 file changed, 2 insertions(+), 12 deletions(-)
>>
>> diff --git a/kernel/cgroup/pids.c b/kernel/cgroup/pids.c
>> index 34aa63d7c9c6..8f61114c36dd 100644
>> --- a/kernel/cgroup/pids.c
>> +++ b/kernel/cgroup/pids.c
>> @@ -272,15 +272,10 @@ static void pids_event(struct pids_cgroup
>> *pids_forking,
>>    */
>>   static int pids_can_fork(struct task_struct *task, struct css_set
>> *cset)
>>   {
>> -    struct cgroup_subsys_state *css;
>>       struct pids_cgroup *pids, *pids_over_limit;
>>       int err;
>>   -    if (cset)
>> -        css = cset->subsys[pids_cgrp_id];
>> -    else
>> -        css = task_css_check(current, pids_cgrp_id, true);
>> -    pids = css_pids(css);
>> +    pids = css_pids(cset->subsys[pids_cgrp_id]);
>>       err = pids_try_charge(pids, 1, &pids_over_limit);
>>       if (err)
>>           pids_event(pids, pids_over_limit);
>> @@ -290,14 +285,9 @@ static int pids_can_fork(struct task_struct
>> *task, struct css_set *cset)
>>     static void pids_cancel_fork(struct task_struct *task, struct
>> css_set *cset)
>>   {
>> -    struct cgroup_subsys_state *css;
>>       struct pids_cgroup *pids;
>>   -    if (cset)
>> -        css = cset->subsys[pids_cgrp_id];
>> -    else
>> -        css = task_css_check(current, pids_cgrp_id, true);
>> -    pids = css_pids(css);
>> +    pids = css_pids(cset->subsys[pids_cgrp_id]);
>>       pids_uncharge(pids, 1);
>>   }
>>   


