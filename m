Return-Path: <cgroups+bounces-6258-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3BAA1B10B
	for <lists+cgroups@lfdr.de>; Fri, 24 Jan 2025 08:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06E51188AAFB
	for <lists+cgroups@lfdr.de>; Fri, 24 Jan 2025 07:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82FDF1DAC9F;
	Fri, 24 Jan 2025 07:42:16 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502261DA10A;
	Fri, 24 Jan 2025 07:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737704536; cv=none; b=DgLsdyz2R8dZDxZNEISoty853kQzw/0MSf43EN4gzdMbVjpcQFf6TC8p3SPReE59AbaV+Eot9Abn7BVJ+PeLHbvgJsXYJKwwXc2ww1bCoSZC5HkEQB06vepEfOs4AF9v0xGeIksZmwtgt7IV6po3inYU4Coxybsg9mvq7s7uqi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737704536; c=relaxed/simple;
	bh=nkwoPcdjj71lkE4dlzCAt5xGDy19DizgBrAjSXBFVac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=df18pYczMHpN/JJYw9MFEUe7WG3cscsQHzgNU+K9gIXfX6ZA0wxIEOFrPzW2zkAlO7qTFBGuquXOuJmv2KdOmEBg54hkU8QCn8uglkVsygjDnStoAXHvztR/y+0wo4sUDlknh6Vea7JAC5P3U/8REStOK9edk928kBJJgOni8IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YfVBL4gvtz4f3jQP;
	Fri, 24 Jan 2025 15:41:46 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 9B7F71A0A31;
	Fri, 24 Jan 2025 15:42:08 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP3 (Coremail) with SMTP id _Ch0CgC3V8JPRJNnZMJABw--.54478S2;
	Fri, 24 Jan 2025 15:42:08 +0800 (CST)
Message-ID: <50927192-67ac-4fb5-b41f-d11cdcd4e0e3@huaweicloud.com>
Date: Fri, 24 Jan 2025 15:42:07 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 next 4/5] memcg: factor out
 stat(event)/stat_local(event_local) reading functions
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Yosry Ahmed <yosryahmed@google.com>, akpm@linux-foundation.org,
 mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
 muchun.song@linux.dev, davidf@vimeo.com, vbabka@suse.cz, mkoutny@suse.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 chenridong@huawei.com, wangweiyang2@huawei.com
References: <20250117014645.1673127-1-chenridong@huaweicloud.com>
 <20250117014645.1673127-5-chenridong@huaweicloud.com>
 <20250117165615.GF182896@cmpxchg.org>
 <CAJD7tkYahASkO+4VkwSL0QnL3fFY4pgvnN84moip4tzLcvQ_yQ@mail.gmail.com>
 <20250117180238.GI182896@cmpxchg.org>
 <6daaf853-1283-42e6-bb0f-55d951edc925@huaweicloud.com>
 <20250124042302.GA5581@cmpxchg.org>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <20250124042302.GA5581@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgC3V8JPRJNnZMJABw--.54478S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw1kGFy3Cw13Kw43WF4kZwb_yoW8Kr1kpr
	W2yFyjkayDGrWrAF12ya15Ww1S9r93JrW5X34qvryIqr9Fqwn7try2kr45uFy5Jr4xXr1Y
	yr4Yqry2vF45AaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	7KsUUUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/1/24 12:23, Johannes Weiner wrote:
> On Tue, Jan 21, 2025 at 10:15:00PM +0800, Chen Ridong wrote:
>>
>>
>> On 2025/1/18 2:02, Johannes Weiner wrote:
>>> On Fri, Jan 17, 2025 at 09:01:59AM -0800, Yosry Ahmed wrote:
>>>> On Fri, Jan 17, 2025 at 8:56 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>>>>>
>>>>> On Fri, Jan 17, 2025 at 01:46:44AM +0000, Chen Ridong wrote:
>>>>>> From: Chen Ridong <chenridong@huawei.com>
>>>>>>
>>>>>> The only difference between 'lruvec_page_state' and
>>>>>> 'lruvec_page_state_local' is that they read 'state' and 'state_local',
>>>>>> respectively. Factor out an inner functions to make the code more concise.
>>>>>> Do the same for reading 'memcg_page_stat' and 'memcg_events'.
>>>>>>
>>>>>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>>>>>
>>>>> bool parameters make for poor readability at the callsites :(
>>>>>
>>>>> With the next patch moving most of the duplication to memcontrol-v1.c,
>>>>> I think it's probably not worth refactoring this.
>>>>
>>>> Arguably the duplication would now be across two different files,
>>>> making it more difficult to notice and keep the implementations in
>>>> sync.
>>>
>>> Dependencies between the files is a bigger pain. E.g. try_charge()
>>> being defined in memcontrol-v1.h makes memcontrol.c more difficult to
>>> work with. That shared state also immediately bitrotted when charge
>>> moving was removed and the last cgroup1 caller disappeared.
>>>
>>> The whole point of the cgroup1 split was to simplify cgroup2 code. The
>>> tiny amount of duplication in this case doesn't warrant further
>>> entanglement between the codebases.
>>
>> Thank you for your review.
>>
>> I agree with that. However, If I just move the 'local' functions to
>> memcontrol-v1.c, I have to move some dependent declarations to the
>> memcontrol-v1.h.
>> E.g. struct memcg_vmstats, MEMCG_VMSTAT_SIZE and so on.
>>
>> Is this worth doing?
> 
> Ah, right. No, that's not worth it.
> 
> The easiest way is to slap CONFIG_MEMCG_V1 guards around the local
> functions but leave them in memcontrol.c for now. We already have a
> few of those ifdefs for where splitting/sharing wasn't practical. At
> least then it's clearly marked and they won't get built.

Thank you, will do that.

Best regards,
Ridong


