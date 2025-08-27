Return-Path: <cgroups+bounces-9435-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7B9B37649
	for <lists+cgroups@lfdr.de>; Wed, 27 Aug 2025 02:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74E833B2E3C
	for <lists+cgroups@lfdr.de>; Wed, 27 Aug 2025 00:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579EA1E51EB;
	Wed, 27 Aug 2025 00:54:09 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8561D90DD;
	Wed, 27 Aug 2025 00:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756256049; cv=none; b=LboWF2blbcayJhEO7yDcdxAGDaJjMi/99Tr2m4//7R1Q3GEyVx6jqcHtwEFtLpT6P+mv33/U7rc9Hs0D+b/l/PBm4IwXOhcBLGWgaAJRXJ/vS8Ac8oVvOfM8GBBkAV9iAFCZsJyncQtCv/IaaR4cu2lv40guhSvzWOt/FfDkcPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756256049; c=relaxed/simple;
	bh=vPul/Lgsj7G25acvYdxdmCM/dP5Ia+Fm2Ed5EQVmXsc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rsQnAec+L74Me5/x5hcqQANc8uGCK7D9kgbqr+Z4ppzIWngD+0DBR6yvNcMnQ063P2gZ8+z5knF3JHSNzihFIke5Ppcfaj+0Fsobim/sfIafZMy2zED2ONrWOBda1+c4CpI16QQ5TvZMit/UN1czuXfy44FNHwDS/kUNr/NcQXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cBQyh6L12zKHMsn;
	Wed, 27 Aug 2025 08:54:04 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 859141A1769;
	Wed, 27 Aug 2025 08:54:04 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP2 (Coremail) with SMTP id Syh0CgDXAZkrV65obTGoAQ--.425S2;
	Wed, 27 Aug 2025 08:54:04 +0800 (CST)
Message-ID: <0cd291b3-012d-412d-b5d3-72e96330d468@huaweicloud.com>
Date: Wed, 27 Aug 2025 08:54:02 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH cgroup/for-next 1/3] cgroup: remove redundancy online_cnt
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: tj@kernel.org, hannes@cmpxchg.org, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, lujialin4@huawei.com, chenridong@huawei.com
References: <20250826034022.1736249-1-chenridong@huaweicloud.com>
 <20250826034022.1736249-2-chenridong@huaweicloud.com>
 <zumtn2pez376u2xacibdd6eueeueh6ole5w6pqbgccg2bj7fgd@o2szr644a3om>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <zumtn2pez376u2xacibdd6eueeueh6ole5w6pqbgccg2bj7fgd@o2szr644a3om>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgDXAZkrV65obTGoAQ--.425S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw4kAFyrurykKr4UXrW3GFg_yoW8WF48pF
	s5Za43Ja18Jry5JF90v3y0qryF9Fs3K34kCrWUGFyfXrWayF10qa1UArW5JF1rArZ3Zr1a
	yFWjv3s3Cw4UtaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUymb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UK2NtUUUUU=
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/8/26 22:14, Michal Koutný wrote:
> Hello Ridong.
> 
> On Tue, Aug 26, 2025 at 03:40:20AM +0000, Chen Ridong <chenridong@huaweicloud.com> wrote:
>> @@ -5949,7 +5944,7 @@ static void css_killed_work_fn(struct work_struct *work)
>>  		css_put(css);
>>  		/* @css can't go away while we're holding cgroup_mutex */
>>  		css = css->parent;
>> -	} while (css && atomic_dec_and_test(&css->online_cnt));
>> +	} while (css && css_is_dying(css) && !css->nr_descendants);
> 
> Here it's OK...
> 
>>  
>>  	cgroup_unlock();
>>  }
>> @@ -5960,7 +5955,7 @@ static void css_killed_ref_fn(struct percpu_ref *ref)
>>  	struct cgroup_subsys_state *css =
>>  		container_of(ref, struct cgroup_subsys_state, refcnt);
>>  
>> -	if (atomic_dec_and_test(&css->online_cnt)) {
>> +	if (!css->nr_descendants) {
>>  		INIT_WORK(&css->destroy_work, css_killed_work_fn);
>>  		queue_work(cgroup_offline_wq, &css->destroy_work);
>>  	}
> 
> ... but here in percpu_ref's confirm callback you're accessing
> nr_descendants without cgroup_mutex where the atomic would have
> prevented the data race.
> 

Thank you very much, Michal, I miss this case.

> Also the semantics of online_cnt and nr_descendants is slightly
> different -- killed vs offlined. Or can you add a description why
> they're same (after workqueue split)?
> 

The nr_descendants value does not include the dying CSS; it only reflects the number of currently
living descendants. Moreover, a CSS can only be taken offline when no living CSS remains. Therefore,
I believe the online_cnt is no longer necessary. This is unrelated to workqueue splitting.

-- 
Best regards,
Ridong


