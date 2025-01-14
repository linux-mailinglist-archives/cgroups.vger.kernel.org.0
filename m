Return-Path: <cgroups+bounces-6123-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D701A1067A
	for <lists+cgroups@lfdr.de>; Tue, 14 Jan 2025 13:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74F2C164BB4
	for <lists+cgroups@lfdr.de>; Tue, 14 Jan 2025 12:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B3020F96E;
	Tue, 14 Jan 2025 12:19:42 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50ED0236EAE;
	Tue, 14 Jan 2025 12:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736857182; cv=none; b=jQG+hH3PXspHttOzYSk0bB20mbZYXmPfFS45UA2EjmAM2AILjqA4yyhkpdDFQR/aAYPxgGT71nqlOBjEU34s64HB2hId/bsiR+kv6M46mKstD0ehP88nFUYP6tl6k3rFbARt1Lj9L/o+DdLhxkebGghw9m8Rcs4oF+QHvEbBVpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736857182; c=relaxed/simple;
	bh=kCTfl5Nuf4OdQzo2azsRBBlbm3l3VYvuIC4BR7QoqVE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pdi5CShs4SjhSCI4BAcfTo8ZSXuRV1bGKveAR4qOX0JrT5S0qqG7gfxOnurCdk/bsJoSjSZfUzligwG2iGlBg4dU60Z+yorZLyHPj3wth15WIm1FGhi/ysSEq5t4x005SZM40T4Qutc27U9FARrHorQveuqnhS8fBlAsCWbz62Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YXSq73BN2z4f3jdK;
	Tue, 14 Jan 2025 20:19:15 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id CA8241A09F5;
	Tue, 14 Jan 2025 20:19:35 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP3 (Coremail) with SMTP id _Ch0CgC3V8JXVoZnvH+uAw--.4723S2;
	Tue, 14 Jan 2025 20:19:35 +0800 (CST)
Message-ID: <0d9ea655-5c1a-4ba9-9eeb-b45d74cc68d0@huaweicloud.com>
Date: Tue, 14 Jan 2025 20:19:35 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] memcg: fix soft lockup in the OOM process
To: Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, hannes@cmpxchg.org,
 yosryahmed@google.com, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
 muchun.song@linux.dev, davidf@vimeo.com, handai.szj@taobao.com,
 rientjes@google.com, kamezawa.hiroyu@jp.fujitsu.com,
 RCU <rcu@vger.kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, chenridong@huawei.com, wangweiyang2@huawei.com
References: <20241224025238.3768787-1-chenridong@huaweicloud.com>
 <1ea309c1-d0f8-4209-b0b0-e69ad4e986ae@suse.cz>
 <58caaa4f-cf78-4d0f-af31-8a9277b6ebf5@huaweicloud.com>
 <20250113194546.3de1af46fa7a668111909b63@linux-foundation.org>
 <Z4YjArAULdlOjhUf@tiehlicka> <aaa26dbb-e3b5-42a3-aac0-1cb594a272b6@suse.cz>
 <Z4YunYyj6oqmdrUt@tiehlicka>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <Z4YunYyj6oqmdrUt@tiehlicka>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgC3V8JXVoZnvH+uAw--.4723S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtF1xWF45Jry7tF4ktr18Zrb_yoWDCwc_ur
	WFvr4kuw4DX3y3K3ZrWrZ5twsrWrsxCr13ArWkJasIq3s5X3y5WFZrur97ua9rXa9rtwnI
	kwsYvF13Kw4UWjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbxxYFVCjjxCrM7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUxo
	7KDUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/1/14 17:30, Michal Hocko wrote:
> On Tue 14-01-25 10:20:28, Vlastimil Babka wrote:
>> On 1/14/25 09:40, Michal Hocko wrote:
>>> On Mon 13-01-25 19:45:46, Andrew Morton wrote:
> [...]
>>>>> For global OOM, system is likely to struggle, do we have to do some
>>>>> works to suppress RCU detete?
>>>>
>>>> rcu_cpu_stall_reset()?
>>>
>>> Do we really care about those? The code to iterate over all processes
>>> under RCU is there (basically) since ever and yet we do not seem to have
>>> many reports of stalls? Chen's situation is specific to memcg OOM and
>>> touching the global case was mostly for consistency reasons.
>>
>> Then I'd rather not touch the global case then if it's theoretical?
> 
> No strong opinion on this on my side. The only actual reason
> touch_softlockup_watchdog is there is becuase it originally had
> incorrectly cond_resched there. If half silencing (soft lock up
> detector only) disturbs people then let's just drop that hunk.

So do I. If there are no other opinions, I will drop it.

Best regards,
Ridong


