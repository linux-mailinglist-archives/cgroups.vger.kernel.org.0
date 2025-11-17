Return-Path: <cgroups+bounces-12034-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E428DC62B90
	for <lists+cgroups@lfdr.de>; Mon, 17 Nov 2025 08:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8212B34E485
	for <lists+cgroups@lfdr.de>; Mon, 17 Nov 2025 07:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9083195E8;
	Mon, 17 Nov 2025 07:30:44 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E872874E1;
	Mon, 17 Nov 2025 07:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763364644; cv=none; b=Iy54+tITTMOJnyUPIQEwy6xBpppiwnNVSWkvauOy6R7JqjGAEjP/cGbsw+EZvJS0ZklgvDtNY7veZOcpYzmioJ2JXm2ZXQ8GythjQ1jwZMia1Quhblgyx5Ojn1JrJ6KS/qE3XtlN9T2aqUie/mFDPHSQE8fzwYuaDJHY3vtTFNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763364644; c=relaxed/simple;
	bh=5FBbxVDolIuQPBQ6ot5sS2ut5Zf3iBMzGOEOdJ0ghtA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hhAh35at8bRKYVO7Wb0bw5nRN3XBukASxGd/byY/nDnjzQjmf4dwc79HCza9VLeTZnwAYSzsfSZ1HTLD0NoXAD4g4+z7ejydHAYBfNT4hdsHzJXpt8JtzreJo/+nT/BvyMPoXKUw7s1FwiZ932jZkJBURANCdejoB6kMLr4jAzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4d8zsx6W0yzKHLyD;
	Mon, 17 Nov 2025 15:30:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id AF08F1A1084;
	Mon, 17 Nov 2025 15:30:38 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP2 (Coremail) with SMTP id Syh0CgAHY3kdzxppZGInBA--.55239S2;
	Mon, 17 Nov 2025 15:30:38 +0800 (CST)
Message-ID: <a46cd51e-e447-40f5-b2de-3067049ce491@huaweicloud.com>
Date: Mon, 17 Nov 2025 15:30:37 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] cpuset: treate root invalid trialcs as exclusive
To: Sun Shaojie <sunshaojie@kylinos.cn>
Cc: cgroups@vger.kernel.org, hannes@cmpxchg.org,
 linux-kernel@vger.kernel.org, longman@redhat.com, mkoutny@suse.com,
 tj@kernel.org
References: <a16c91d9-a779-44e5-9ca6-e14e7540ed69@huaweicloud.com>
 <20251117065347.1052678-1-sunshaojie@kylinos.cn>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <20251117065347.1052678-1-sunshaojie@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgAHY3kdzxppZGInBA--.55239S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr4UWw4rtw47Xry3WFWUCFg_yoW8XF48pF
	W8KFn8Ja1Fvr1rCwsFq3WxZF45t3ZrZF12vrnxGry8AanFqan0kFs2yFZxuay5Wr9xG34U
	Z3y7urWfXr15ArDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyCb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x02
	67AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07UK2NtUUUUU=
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/11/17 14:53, Sun Shaojie wrote:
> On 2025/11/15 14:23, Chen Ridong wrote:
>> On 2025/11/17 12:35, Sun Shaojie wrote:
>>> Hi, Ridong,
>>>
>>> Maybe, this patch does not apply to the following cases:
>>>  Step
>>>  #1> echo "root" > A1/cpuset.cpus.partition
>>>  #1> echo "0-1" > B1/cpuset.cpus
>>>  #2> echo "1-2" > A1/cpuset.cpus.exclusive  -> return error
>>>  It should return success here.
>>>
>>> Please consider the following modification.
>>>
>>
>> If A1 will automatically change to a valid partition, I think it should return error.
> 
> Hi, Ridong,
> 
> A1 will not automatically change to a valid partition.
> 
> Perhaps this example is more intuitive.
> 
> For example:
> 
>  Before apply this patch:
>  #1> echo "0-1" > B1/cpuset.cpus
>  #2> echo "root" > A1/cpuset.cpus.partition -> A1's prstate is "root invalid"
>  #3> echo "1-2" > A1/cpuset.cpus.exclusive
>  Return success, and A1's prstate is "root invalid"
> 

I did not apply your patch to test my patch. here are the results I obtained:

	# cd /sys/fs/cgroup/
	# mkdir A1
	# mkdir B1
	# echo 0-1 > B1/cpuset.cpus
	# echo root > A1/cpuset.cpus.partition
	# cat A1/cpuset.cpus.partition
	root invalid (cpuset.cpus and cpuset.cpus.exclusive are empty)
	# echo 1-2 > A1/cpuset.cpus
	# cat A1/cpuset.cpus.partition
	root

This differs from the results you provided.

Never mind, let's focus on whether the rule should be relaxed in your patch. Once that's resolved, I
can resubmit my patch. Let's set this patch aside for now.

Thanks.

-- 
Best regards,
Ridong


