Return-Path: <cgroups+bounces-6243-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB50A17F7E
	for <lists+cgroups@lfdr.de>; Tue, 21 Jan 2025 15:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 594F53AAD8C
	for <lists+cgroups@lfdr.de>; Tue, 21 Jan 2025 14:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29571F37D4;
	Tue, 21 Jan 2025 14:15:09 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A481F37CA;
	Tue, 21 Jan 2025 14:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737468909; cv=none; b=UX0sWbT0FcPqhvrKJwl8DxcEIACGmhLUMnoJ/TnFvpA9BkoX0uVI5PD3/0VCA6ixstHoccnnuK/1CzgVGCH28q/E22x3DxHMw72E48f35+kJR60HwKRlGev6xa1ceeANw7d66Qgb2TOF0Du8N85TOcTI3/Bg2woBDkuj7lifKc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737468909; c=relaxed/simple;
	bh=wSw3qcr+HiKsMID+4H165eLUSiKj7LIYBwrBnauZ/sk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EmVGDqnJir5NuwIFJPVBla0g+gqRUSyKJu2AOZL0F69Hm0IwZzJlAint5RoDX/y7uI+2GEldSyht20L1+LyeUblorRCPq7UFghs+FyUdo2uY+z80DRwCcUKyWwymWV+Uwa1K980F/uqfg72DwKRoBH56wILsZ0pYtGXnc/duc/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Ycq351SpTz4f3jYR;
	Tue, 21 Jan 2025 22:14:41 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id C31231A1422;
	Tue, 21 Jan 2025 22:15:01 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP2 (Coremail) with SMTP id Syh0CgCXoGPkq49nlLdTBg--.37785S2;
	Tue, 21 Jan 2025 22:15:01 +0800 (CST)
Message-ID: <6daaf853-1283-42e6-bb0f-55d951edc925@huaweicloud.com>
Date: Tue, 21 Jan 2025 22:15:00 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 next 4/5] memcg: factor out
 stat(event)/stat_local(event_local) reading functions
To: Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>
Cc: akpm@linux-foundation.org, mhocko@kernel.org, roman.gushchin@linux.dev,
 shakeel.butt@linux.dev, muchun.song@linux.dev, davidf@vimeo.com,
 vbabka@suse.cz, mkoutny@suse.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 chenridong@huawei.com, wangweiyang2@huawei.com
References: <20250117014645.1673127-1-chenridong@huaweicloud.com>
 <20250117014645.1673127-5-chenridong@huaweicloud.com>
 <20250117165615.GF182896@cmpxchg.org>
 <CAJD7tkYahASkO+4VkwSL0QnL3fFY4pgvnN84moip4tzLcvQ_yQ@mail.gmail.com>
 <20250117180238.GI182896@cmpxchg.org>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <20250117180238.GI182896@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgCXoGPkq49nlLdTBg--.37785S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AF47XF45Ww1DXrW5Ww17Jrb_yoW8AFyrpr
	W7uFyUAayDGrySkFnIya13Ww1F9rZ3JrW5Z34v934IqFnIqwn7Kry2kFW5uFWrJr1Iqr1U
	Aw4Yqryayay5AaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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



On 2025/1/18 2:02, Johannes Weiner wrote:
> On Fri, Jan 17, 2025 at 09:01:59AM -0800, Yosry Ahmed wrote:
>> On Fri, Jan 17, 2025 at 8:56 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>>>
>>> On Fri, Jan 17, 2025 at 01:46:44AM +0000, Chen Ridong wrote:
>>>> From: Chen Ridong <chenridong@huawei.com>
>>>>
>>>> The only difference between 'lruvec_page_state' and
>>>> 'lruvec_page_state_local' is that they read 'state' and 'state_local',
>>>> respectively. Factor out an inner functions to make the code more concise.
>>>> Do the same for reading 'memcg_page_stat' and 'memcg_events'.
>>>>
>>>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>>>
>>> bool parameters make for poor readability at the callsites :(
>>>
>>> With the next patch moving most of the duplication to memcontrol-v1.c,
>>> I think it's probably not worth refactoring this.
>>
>> Arguably the duplication would now be across two different files,
>> making it more difficult to notice and keep the implementations in
>> sync.
> 
> Dependencies between the files is a bigger pain. E.g. try_charge()
> being defined in memcontrol-v1.h makes memcontrol.c more difficult to
> work with. That shared state also immediately bitrotted when charge
> moving was removed and the last cgroup1 caller disappeared.
> 
> The whole point of the cgroup1 split was to simplify cgroup2 code. The
> tiny amount of duplication in this case doesn't warrant further
> entanglement between the codebases.

Thank you for your review.

I agree with that. However, If I just move the 'local' functions to
memcontrol-v1.c, I have to move some dependent declarations to the
memcontrol-v1.h.
E.g. struct memcg_vmstats, MEMCG_VMSTAT_SIZE and so on.

Is this worth doing?

Best regards,
Ridong


