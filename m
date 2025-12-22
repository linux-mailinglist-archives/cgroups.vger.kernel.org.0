Return-Path: <cgroups+bounces-12579-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E02CD531E
	for <lists+cgroups@lfdr.de>; Mon, 22 Dec 2025 09:54:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A33F3304FFF3
	for <lists+cgroups@lfdr.de>; Mon, 22 Dec 2025 08:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2108335571;
	Mon, 22 Dec 2025 08:28:59 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59143346B9;
	Mon, 22 Dec 2025 08:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766392139; cv=none; b=P1UtuddCE8HJoyQqE4vOThVtHZgiSnkj7fnGXCT+ZBUrOPSUXsvmj7ymJir5ne3cyqRyTuocFJJPbpjTqSAyyeZuXG55S7B071OkW3l8R2t8F9ikRATSmkUs/26Uxuzl4y4HhEBE+njz5VCKWR6oy2F3yh45bdZLg86B7WwPePw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766392139; c=relaxed/simple;
	bh=uLZxRiuhHSGknMraBirxPnD/jCGevs/LYe/b8v0dY7U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dWBuzPAPslHk/sK2+GKlkiOj1KZqZTEHo2ReHA6tUPhYgQscemvxoDa3tZWhIGhlJaA22bOtGOzUT9y7AYn8fbIXHLUw8nRIzM4OIpk9w61cGoHbDA6+hb2/s63BytojlkGMNNt60z8WT3xlRLePz+518gMZKPzFNL+95G2OM3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dZWW849VSzKHMVl;
	Mon, 22 Dec 2025 16:28:36 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 0FC5740570;
	Mon, 22 Dec 2025 16:28:53 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP4 (Coremail) with SMTP id gCh0CgA3l_dDAUlp1vdGBA--.55773S2;
	Mon, 22 Dec 2025 16:28:52 +0800 (CST)
Message-ID: <2906e2b7-cc89-4d1b-893a-c20e4f100f97@huaweicloud.com>
Date: Mon, 22 Dec 2025 16:28:51 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] mm/vmscan: check all allowed targets in
 can_demote()
To: Bing Jiao <bingjiao@google.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 akpm@linux-foundation.org, gourry@gourry.net, longman@redhat.com,
 hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
 shakeel.butt@linux.dev, muchun.song@linux.dev, tj@kernel.org,
 mkoutny@suse.com, david@kernel.org, zhengqi.arch@bytedance.com,
 lorenzo.stoakes@oracle.com, axelrasmussen@google.com, yuanchu@google.com,
 weixugc@google.com, cgroups@vger.kernel.org
References: <20251220061022.2726028-1-bingjiao@google.com>
 <20251221233635.3761887-1-bingjiao@google.com>
 <20251221233635.3761887-3-bingjiao@google.com>
 <d5df710a-e0e1-4254-b58f-60ddc5adcbd5@huaweicloud.com>
 <aUjgt4EdBv4UyrTM@google.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <aUjgt4EdBv4UyrTM@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgA3l_dDAUlp1vdGBA--.55773S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr1kAFykGF1kXw1kuFW7Jwb_yoW8Zr4fpF
	1UCF12ya1kXr1fCws2v340v34Fvw18JF4UJF1rJFn3Cr9IyF1xAFn8ta1YgFyrWF1fur10
	qayYkw4xua4DAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07
	jIksgUUUUU=
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/12/22 14:09, Bing Jiao wrote:
> On Mon, Dec 22, 2025 at 10:51:49AM +0800, Chen Ridong wrote:
>>
>>
>> On 2025/12/22 7:36, Bing Jiao wrote:
>>> -void cpuset_node_filter_allowed(struct cgroup *cgroup, nodemask_t *mask)
>>> -{
>>> -	struct cgroup_subsys_state *css;
>>> -	struct cpuset *cs;
>>> -
>>> -	if (!cpuset_v2())
>>> -		return;
>>> -
>>> -	css = cgroup_get_e_css(cgroup, &cpuset_cgrp_subsys);
>>> -	if (!css)
>>> -		return;
>>> -
>>> -	/* Follows the same assumption in cpuset_node_allowed() */
>>> -	cs = container_of(css, struct cpuset, css);
>>>  	nodes_and(*mask, *mask, cs->effective_mems);
>>>  	css_put(css);
>>>  }
>>
>> Oh, I see you merged these two functions here.
>>
>> However, I think cpuset_get_mem_allowed would be more versatile in general use.
>>
>> You can then check whether the returned nodemask intersects with your target mask. In the future,
>> there may be scenarios where users simply want to retrieve the effective masks directly.
>>
> 
> Hi Ridong, thank you for the suggestions.
> 
> I agree that returning a nodemask would provide greater versatility.
> 
> I think cpuset_get_mem_allowed_relax() would be a better name,
> since we do not need the locking and online mem guarantees
> compared to an similar function cpuset_mems_allowed().
> 

I think the key difference between cpuset_mems_allowed and the helper you intend to implement lies
not in locking or online memory guarantees, but in the input parameter: you want to retrieve
cpuset->effective_mems for a cgroup from another subsystem.

The cs->effective_mems should typically only include online nodes, except during brief transitional
periods such as hotplug operations. Similarly, node migration logic also requires online nodes.

Therefore, cpuset_get_mem_allowed seems acceptable to me.

Additionally, you may consider calling guarantee_online_mems inside your new helper to ensure
consistency.

-- 
Best regards,
Ridong


