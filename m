Return-Path: <cgroups+bounces-10155-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB97BB58FDC
	for <lists+cgroups@lfdr.de>; Tue, 16 Sep 2025 10:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F1BF3AABB1
	for <lists+cgroups@lfdr.de>; Tue, 16 Sep 2025 08:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8106728469E;
	Tue, 16 Sep 2025 08:00:01 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E127228467B;
	Tue, 16 Sep 2025 07:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758009601; cv=none; b=KoLiajz+0pY0cmkTPGP/qP0FCCZLevcdWXxcZDom3eosaEqFEt53DJ47FE+JI1nmeuatUuMhpIcAWRfGddQnowK77sK64dJjEekLgc9qUJhcUDBAUsTQhHwKiv5UETD0tld8hXc/PQ5SudvZMHgC6XsFfYO+LcpkvF3qWmBZVg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758009601; c=relaxed/simple;
	bh=upYn1SaDh/dxXAW/6acZeEgVJxzVW91u/xRUFgUHzHc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oI01xVhnGzuETVtIfg6+T7ssqw073e7uyVVBC9FN3d/pY0D+owABiTOrcFYpdNd3H9lMGwbBnOhj9QWrf+tJ5svbNzYIAZfSM+mJ27STAS1YYcAI4eFXJU6//RTQlPvXn4Ztq8GpJIrQ7u91EeQ10e/NHSEamGsbWID39G+geDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cQvSl1tkJzYQvQM;
	Tue, 16 Sep 2025 15:59:51 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id D220C1A0AB8;
	Tue, 16 Sep 2025 15:59:49 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP1 (Coremail) with SMTP id cCh0CgAX1nv0GMloYU2MCg--.11477S2;
	Tue, 16 Sep 2025 15:59:49 +0800 (CST)
Message-ID: <76e3163d-f323-46db-af3a-06bbd755243b@huaweicloud.com>
Date: Tue, 16 Sep 2025 15:59:48 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next RFC -v2 06/11] cpuset: introduce cpus_excl_conflict
 and mems_excl_conflict helpers
To: Waiman Long <llong@redhat.com>, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20250909033233.2731579-1-chenridong@huaweicloud.com>
 <20250909033233.2731579-7-chenridong@huaweicloud.com>
 <7085a2a8-0f03-4222-9ba8-9281e25d8daf@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <7085a2a8-0f03-4222-9ba8-9281e25d8daf@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAX1nv0GMloYU2MCg--.11477S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKF47Gw47Kr1kJr1DuFyxAFb_yoWfKrgEgr
	s5ArnF93s5AF4fta4fJa1kCrZxCrn8Aa1UJw1UXrs8Xw1rXFZ3G3y0y3yYk3yjkFWSqryk
	ua4YqFZxJ347KjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UK2NtUUUUU=
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/9/16 2:42, Waiman Long wrote:
> 
> On 9/8/25 11:32 PM, Chen Ridong wrote:
>> From: Chen Ridong <chenridong@huawei.com>
>>
>> This patch adds cpus_excl_conflict() and mems_excl_conflict() helper
>> functions to improve code readability and maintainability. The exclusive
>> conflict checking follows these rules:
>>
>> 1. If either cpuset has the 'exclusive' flag set, their user_xcpus must
>>     not have any overlap.
>> 2. If both cpusets are non-exclusive, their 'cpuset.cpus.exclusive' values
>>     must not intersect.
> 
> The term "non-exclusive" is somewhat confusing. I suppose you mean that the exclusive flag isn't
> set. However, exclusive flag is a cpuset v1 only feature and cpus.exclusive is a v2 only feature.
> They will not coexist. You may need to update the wording.
> 
> After you fix that, you can add
> 
> Reveiwed-by: Waiman Long <longman@redhat.com>

Thank you, Longman, I will update.

-- 
Best regards,
Ridong


