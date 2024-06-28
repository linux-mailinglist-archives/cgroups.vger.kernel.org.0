Return-Path: <cgroups+bounces-3434-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3521591B50E
	for <lists+cgroups@lfdr.de>; Fri, 28 Jun 2024 04:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E8561C217F9
	for <lists+cgroups@lfdr.de>; Fri, 28 Jun 2024 02:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6AACFBEA;
	Fri, 28 Jun 2024 02:20:29 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C508480;
	Fri, 28 Jun 2024 02:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719541229; cv=none; b=pJ4Dsx9+SfCCXyJQAXnZraRAjPyxFxS9OG5qQ9kYmhIuIHlWtH1qdtS/L2ebgPKZdVNU/J9JR8taPwTfcI6HBeyhuhuFc6ATxdxePqXd+B0zGrC97h5HV6iUDHU95ArIXzS+XN3Wli0ZpXebRnRg+cCj61np43w+HzR8ZVKnBeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719541229; c=relaxed/simple;
	bh=dO9qBeiAL60YekJlPz1a+cPxvLl0Q9VNiXYv1VwjvYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=R7NOoAdyXhAWD9CGXhx6W4arSoD1HYKN2Q8/zYBxKsRFI/WZweMv5ho5QDlTyBbF6XZCwibKMHPgnBGay0SednUT4XCYM4xIKemfRKhTqY+JtHNmBeIp0FtAdoeyQPNQ2mht5O9zHuOVu55gaM3fAMeqwYZVDXYaLATYPUkm3X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4W9Jvp5d7Wz2Ckks;
	Fri, 28 Jun 2024 10:16:22 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (unknown [7.185.36.114])
	by mail.maildlp.com (Postfix) with ESMTPS id 4514714011F;
	Fri, 28 Jun 2024 10:20:24 +0800 (CST)
Received: from [10.67.110.112] (10.67.110.112) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 28 Jun 2024 10:20:23 +0800
Message-ID: <ad7cfc60-d6d5-ca16-c93a-d200febccc9b@huawei.com>
Date: Fri, 28 Jun 2024 10:20:23 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH -next] mm: memcg: remove redundant
 seq_buf_has_overflowed()
Content-Language: en-US
To: Michal Hocko <mhocko@suse.com>
CC: <hannes@cmpxchg.org>, <roman.gushchin@linux.dev>,
	<shakeel.butt@linux.dev>, <muchun.song@linux.dev>,
	<akpm@linux-foundation.org>, <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
References: <20240626094232.2432891-1-xiujianfeng@huawei.com>
 <Zn0RGTZxrEUnI1KZ@tiehlicka>
 <a351c609-4968-398a-9316-2ad19d934e9c@huawei.com>
 <Zn1LFyO_cww9W758@tiehlicka>
 <10b948cd-5fbf-78e7-c3e8-6867661fa50b@huawei.com>
 <Zn1S70yo4VQ24UNT@tiehlicka>
From: xiujianfeng <xiujianfeng@huawei.com>
In-Reply-To: <Zn1S70yo4VQ24UNT@tiehlicka>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500023.china.huawei.com (7.185.36.114)



On 2024/6/27 19:54, Michal Hocko wrote:
> On Thu 27-06-24 19:43:06, xiujianfeng wrote:
>>
>>
>> On 2024/6/27 19:20, Michal Hocko wrote:
>>> On Thu 27-06-24 16:33:00, xiujianfeng wrote:
>>>>
>>>>
>>>> On 2024/6/27 15:13, Michal Hocko wrote:
>>>>> On Wed 26-06-24 09:42:32, Xiu Jianfeng wrote:
>>>>>> Both the end of memory_stat_format() and memcg_stat_format() will call
>>>>>> WARN_ON_ONCE(seq_buf_has_overflowed()). However, memory_stat_format()
>>>>>> is the only caller of memcg_stat_format(), when memcg is on the default
>>>>>> hierarchy, seq_buf_has_overflowed() will be executed twice, so remove
>>>>>> the reduntant one.
>>>>>
>>>>> Shouldn't we rather remove both? Are they giving us anything useful
>>>>> actually? Would a simpl pr_warn be sufficient? Afterall all we care
>>>>> about is to learn that we need to grow the buffer size because our stats
>>>>> do not fit anymore. It is not really important whether that is an OOM or
>>>>> cgroupfs interface path.
>>>>
>>>> I did a test, when I removed both of them and added a lot of prints in
>>>> memcg_stat_format() to make the seq_buf overflow, and then cat
>>>> memory.stat in user mode, no OOM occurred, and there were no warning
>>>> logs in the kernel.
>>>
>>> The default buffer size is PAGE_SIZE.
>>
>> Hi Michal,
>>
>> I'm sorry, I didn't understand what you meant by this sentence. What I
>> mean is that we can't remove both, otherwise, neither the kernel nor
>> user space would be aware of a buffer overflow. From my test, there was
>> no OOM or other exceptions when the overflow occurred; it just resulted
>> in the displayed information being truncated. Therefore, we need to keep
>> one.
> 
> I've had this in mind
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 71fe2a95b8bd..3e17b9c3a27a 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1845,9 +1845,6 @@ static void memcg_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
>  			       vm_event_name(memcg_vm_event_stat[i]),
>  			       memcg_events(memcg, memcg_vm_event_stat[i]));
>  	}
> -
> -	/* The above should easily fit into one page */
> -	WARN_ON_ONCE(seq_buf_has_overflowed(s));
>  }
>  
>  static void memcg1_stat_format(struct mem_cgroup *memcg, struct seq_buf *s);
> @@ -1858,7 +1855,8 @@ static void memory_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
>  		memcg_stat_format(memcg, s);
>  	else
>  		memcg1_stat_format(memcg, s);
> -	WARN_ON_ONCE(seq_buf_has_overflowed(s));
> +	if (seq_buf_has_overflowed(s))
> +		pr_warn("%s: Stat buffer insufficient please report\n", __FUNCTION__);

I found that after the change, the effect is as follows:

# dmesg
[   51.028327] memory_stat_format: Stat buffer insufficient please report

with no keywords such as "Failed", "Warning" to draw attention to this
printout. Should we change it to the following?

if (seq_buf_has_overflowed(s))
      pr_warn("%s: Warning, Stat buffer overflow, please report\n",
__FUNCTION__);


>  }
> >  /**
> 
> Because WARN_ON_ONCE doesn't buy us anything actually. It will dump
> stack trace and it seems really mouthfull (and it will panic when
> panic_on_warn is enabled which is likely not a great thing).

