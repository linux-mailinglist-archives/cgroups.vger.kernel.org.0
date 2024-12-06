Return-Path: <cgroups+bounces-5778-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3385A9E6B3C
	for <lists+cgroups@lfdr.de>; Fri,  6 Dec 2024 11:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D1F916A6BB
	for <lists+cgroups@lfdr.de>; Fri,  6 Dec 2024 10:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C235E1BD9E4;
	Fri,  6 Dec 2024 10:02:48 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51FA18C932;
	Fri,  6 Dec 2024 10:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733479368; cv=none; b=qyjOOTRvlKfev7I3F4nT17SWJLy33A26N29HQ7g98dF+V7s+Op2dhkoOzruKfKXVskYOb14xFOD1vCRDhOd0nKglMmxwoQF4NXyNoaYeuAGl1HSr5ZjpeViDIVreXqH+iynvjnhmXNYqMyM/EmLkgbhiD+MJc/OWgczJfsh9O3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733479368; c=relaxed/simple;
	bh=yoTakXWpm/NE0li7ticRGi+v9cW+Md+MAg5MxT8Xo2o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uNJmBRfLTRy/YON+hcHzzQCcMLQLDLMDq7ZtEWwF1kpwDjcxCGuhY29tJkinLoskGgG7OP8+CODgiOgz7Ptty5pysX5JhK5hZa66lNmbqGCc8IqyqW/gBaDv3ltiZWsUKapHFgnDBQd/FQV7268yGydrFmLJJF/TpfR5KkpA2vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Y4Rd72Gb0z4f3lfZ;
	Fri,  6 Dec 2024 18:02:19 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 587F81A0196;
	Fri,  6 Dec 2024 18:02:39 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP3 (Coremail) with SMTP id _Ch0CgAHmMS9y1JnrSHUDg--.2760S2;
	Fri, 06 Dec 2024 18:02:39 +0800 (CST)
Message-ID: <fd60bf25-1e27-4992-92d6-7d9415a4e23f@huaweicloud.com>
Date: Fri, 6 Dec 2024 18:02:37 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [next -v1 3/5] memcg: simplify the mem_cgroup_update_lru_size
 function
To: Hugh Dickins <hughd@google.com>
Cc: Yu Zhao <yuzhao@google.com>, akpm@linux-foundation.org,
 mhocko@kernel.org, hannes@cmpxchg.org, yosryahmed@google.com,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev,
 davidf@vimeo.com, vbabka@suse.cz, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 chenridong@huawei.com, wangweiyang2@huawei.com
References: <20241206013512.2883617-1-chenridong@huaweicloud.com>
 <20241206013512.2883617-4-chenridong@huaweicloud.com>
 <CAOUHufbCCkOBGcSPZqNY+FXcrH8+U7_nRvftzOzKUBS4hn+kuQ@mail.gmail.com>
 <897b04c9-dba3-44ae-8113-145ca3457cb3@huaweicloud.com>
 <edab8d46-7c03-4bf5-fe1c-0150cdf4d96a@google.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <edab8d46-7c03-4bf5-fe1c-0150cdf4d96a@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgAHmMS9y1JnrSHUDg--.2760S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWw18uw17KF48WF1xKrWfKrg_yoWrAw4kpF
	WUKFyYya1kZrW7A3s2ywsaq3y0kr4fAFWUXr13G34rAw1qvFyxtF4UKrWY9FWDArs3Cw43
	tFZ3Wrn7AFs8ZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07
	UAwIDUUUUU=
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2024/12/6 16:24, Hugh Dickins wrote:
> On Fri, 6 Dec 2024, Chen Ridong wrote:
>> On 2024/12/6 13:33, Yu Zhao wrote:
>>> On Thu, Dec 5, 2024 at 6:45 PM Chen Ridong <chenridong@huaweicloud.com> wrote:
>>>> From: Chen Ridong <chenridong@huawei.com>
>>>>
>>>> In the `mem_cgroup_update_lru_size` function, the `lru_size` should be
>>>> updated by adding `nr_pages` regardless of whether `nr_pages` is greater
>>>> than 0 or less than 0. To simplify this function, add a check for
>>>> `nr_pages` == 0. When `nr_pages` is not equal to 0, perform the same
>>>> actions.
>>>>
>>>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>>>
>>> NAK.
>>>
>>> The commit that added that clearly explains why it was done that way.
> 
> Thanks Yu: I did spot this going by, but was indeed hoping that someone
> else would NAK it, with more politeness than I could muster at the time!
> 
>>
>> Thank you for your reply.
>>
>> I have read the commit message for ca707239e8a7 ("mm: update_lru_size
>> warn and reset bad lru_size") before sending my patch. However, I did
>> not quite understand why we need to deal with the difference between
>> 'nr_pages > 0' and 'nr_pages < 0'.
>>
>>
>> The 'lru_zone_size' can only be modified in the
>> 'mem_cgroup_update_lru_size' function. Only subtracting 'nr_pages' or
>> adding 'nr_pages' in a way that causes an overflow can make the size < 0.
>>
>> For case 1, subtracting 'nr_pages', we should issue a warning if the
>> size goes below 0. For case 2, when adding 'nr_pages' results in an
>> overflow, there will be no warning and the size won't be reset to 0 the
>> first time it occurs . It might be that a warning will be issued the
>> next time 'mem_cgroup_update_lru_size' is called to modify the
>> 'lru_zone_size'. However, as the commit message said, "the first
>> occurrence is the most informative," and it seems we have missed that
>> first occurrence.
>>
>> As the commit message said: "and then the vast unsigned long size draws
>> page reclaim into a loop of repeatedly", I think that a warning should
>> be issued and 'lru_zone_size' should be reset whenever 'size < 0' occurs
>> for the first time, whether from subtracting or adding 'nr_pages'.
> 
> One thing, not obvious, but important to understand, is that WARN_ONCE()
> only issues a warning the first time its condition is found true, but
> it returns the true or false of the condition every time.  So lru_size
> is forced to 0 each time an inconsistency is detected.
> 

Thank you for your explanation.
My patch does not change this logic.

> (But IIRC VM_WARN_ON_ONCE() does not behave in that useful way; or maybe
> I've got that macro name wrong - we have so many slightly differing.)
> 
> Perhaps understanding that will help you to make better sense of the
> order of events in this function.
> 
> Another thing to understand: it's called before adding folio to list,
> but after removing folio from list: when it can usefully compare whether
> the emptiness of the list correctly matches lru_size 0.  It cannot do so
> when adding if you "simplify" it in the way that you did.
> 

The commit b4536f0c829c ("mm, memcg: fix the active list aging for
lowmem requests when memcg is enabled") has removed the emptiness check.

What is meaningful is that we can determine whether the size is smaller
than 0 before adding `nr_pages`. However, as I mentioned, the
`lru_zone_size` can only be modified in the `mem_cgroup_update_lru_size`
function, which means that a warning must have been issued if the size
was smaller than 0 before adding `nr_pages` when `nr_pages` is greater
than 0. In this case, it will not issue a warning again.

Perhaps "when it can usefully compare whether the emptiness of the list
correctly matches lru_size 0" is not useful now.

> You might be focusing too much on the "size < 0" aspect of it, or you
> might be worrying more than I did about size growing larger and larger
> until it wraps to negative (not likely on 64-bit, unless corrupted).> I hope these remarks help, but you need to think through it again
> for yourself.
> 
> Hugh

Thank you very much for your patience.

Best regards,
Ridong

> 
>>
>> I am be grateful if you can explain more details, it has confused me for
>> a while. Thank you very much.
>>
>> Best regards,
>> Ridong


