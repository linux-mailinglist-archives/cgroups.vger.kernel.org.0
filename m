Return-Path: <cgroups+bounces-11799-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 44EC6C4BA16
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 07:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BC48F34E623
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 06:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD2B2D0C80;
	Tue, 11 Nov 2025 06:18:22 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5662D061C;
	Tue, 11 Nov 2025 06:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762841902; cv=none; b=BISkiex3VAz9y9rxgz7SaSYqDawNxlG3r8GbGIUWLSKjPFl44EQyLCWLp+DXCUna/8kNcBEZ0BVhTY9C9FXg4z9DABBaUZEtSbBcRPeK7xcIcUT+w459/deXHieToTcbzGOMk9O6y1jTTPIICGrA2NSIjou9hvWe6zybOt9J+t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762841902; c=relaxed/simple;
	bh=KeoIEtwdzKup6o9wdCNX+YzvBM3y0x1I7aF5p15+UMs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kiVvKjXK4l5WL/+SmKmfh5EAjXlAkeq5FHX8uo6qnrCnPoaIT7Mzx8Y0ovXNIs++FtoA5ZA/iQTfJaX1KWChVuRce31Eh6robJKsEHBe15YvIqXh2STeLZZG+DKyYpvWooE+DzsiatNAOifVGAmKlrPCQIWoeRybiUno2rvo4iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4d5GYB5vXNzYQtxD;
	Tue, 11 Nov 2025 14:17:50 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 210E91A07BB;
	Tue, 11 Nov 2025 14:18:17 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP1 (Coremail) with SMTP id cCh0CgDHAkwo1RJpioRfAQ--.29813S2;
	Tue, 11 Nov 2025 14:18:17 +0800 (CST)
Message-ID: <4d2b0bd3-832b-41a0-b208-18fbf24f1366@huaweicloud.com>
Date: Tue, 11 Nov 2025 14:18:16 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next 3/3] cpuset: remove need_rebuild_sched_domains
To: Waiman Long <llong@redhat.com>, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20251110015228.897736-1-chenridong@huaweicloud.com>
 <20251110015228.897736-4-chenridong@huaweicloud.com>
 <e5a25c3d-cd81-48bc-bae0-b1b28778272b@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <e5a25c3d-cd81-48bc-bae0-b1b28778272b@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDHAkwo1RJpioRfAQ--.29813S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJr13ur4kXw1xZr4xKFy8Zrb_yoW8CF1DpF
	1kJryUX3yjgr18Ww1UZa47Zry5ta17t3WDtwn8JFy8Jr17tr12gF1UW3Z0gr90vw4xGr1U
	AF1qqanrZr15trJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyGb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1aZX5UUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/11/11 12:37, Waiman Long wrote:
> 
> On 11/9/25 8:52 PM, Chen Ridong wrote:
>> From: Chen Ridong <chenridong@huawei.com>
>>
>> Previously, update_cpumasks_hier() used need_rebuild_sched_domains to
>> decide whether to invoke rebuild_sched_domains_locked(). Now that
>> rebuild_sched_domains_locked() only sets force_rebuild, the flag is
>> redundant. Hence, remove it.
>>
>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>> ---
>>   kernel/cgroup/cpuset.c | 6 +-----
>>   1 file changed, 1 insertion(+), 5 deletions(-)
>>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index c357bfb69fe2..22084d8bdc3f 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -2184,7 +2184,6 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
>>   {
>>       struct cpuset *cp;
>>       struct cgroup_subsys_state *pos_css;
>> -    bool need_rebuild_sched_domains = false;
>>       int old_prs, new_prs;
>>         rcu_read_lock();
>> @@ -2348,15 +2347,12 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
>>           if (!cpumask_empty(cp->cpus_allowed) &&
>>               is_sched_load_balance(cp) &&
>>              (!cpuset_v2() || is_partition_valid(cp)))
>> -            need_rebuild_sched_domains = true;
>> +            cpuset_force_rebuild();
>>             rcu_read_lock();
>>           css_put(&cp->css);
>>       }
>>       rcu_read_unlock();
>> -
>> -    if (need_rebuild_sched_domains)
>> -        cpuset_force_rebuild();
>>   }
>>     /**
> Reviewed-by: Waiman Long <longman@redhat.com>
> 

Thanks.

-- 
Best regards,
Ridong


