Return-Path: <cgroups+bounces-9151-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2ABB25868
	for <lists+cgroups@lfdr.de>; Thu, 14 Aug 2025 02:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E1738885CF
	for <lists+cgroups@lfdr.de>; Thu, 14 Aug 2025 00:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0930854774;
	Thu, 14 Aug 2025 00:38:50 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1FB2FF64E;
	Thu, 14 Aug 2025 00:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755131929; cv=none; b=Ein57r0us/RarOUX9m3hM+sT/jBBu8QApmUZellS1HhxarJGX7R1mpZVcSjkDIIzP/l7cDbPz/jmiNM2nxTS0tiK4x8TvLBcqo7E3C1olyXtHhYodmRUMubihNxbOPy0qZ2ZgBnKEYaybpyEBQooYAgVHYnRqWdP0GL+kRP4mwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755131929; c=relaxed/simple;
	bh=J1YWxWusXg5U0+RsTNFDpeJdZvI/anQ05zWjTDl9yjw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FOlwxved0eMBFK2iO4mtE+s5TX6lSJnyYi+xt1XYfV9ohW+/agnYqz4vdxpk2Q5gCJhYRIxKlGG9VUNKdASs1TgTzM5PH/Dfat2w1/b0w42H8TSGXGYDHcmqdVBUoko0xuE4PdSkWKeQ5gA8HSZXgBZbSS8DR3XvsWse6Xnh7vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4c2RF01yCKzYQv90;
	Thu, 14 Aug 2025 08:38:44 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id DD3451A07BD;
	Thu, 14 Aug 2025 08:38:42 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP4 (Coremail) with SMTP id gCh0CgCXExQRMJ1oO0NpDg--.49280S2;
	Thu, 14 Aug 2025 08:38:42 +0800 (CST)
Message-ID: <628e9bb8-380b-4731-8518-b6e58eb04ee5@huaweicloud.com>
Date: Thu, 14 Aug 2025 08:38:40 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [-next v2 2/4] cpuset: decouple tmpmaks and cpumaks of cs free
To: Waiman Long <llong@redhat.com>, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com, christophe.jaillet@wanadoo.fr
References: <20250813082904.1091651-1-chenridong@huaweicloud.com>
 <20250813082904.1091651-3-chenridong@huaweicloud.com>
 <d50ccb6d-a26c-4ab8-b213-161622e25c7c@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <d50ccb6d-a26c-4ab8-b213-161622e25c7c@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCXExQRMJ1oO0NpDg--.49280S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Gw4DGFy7XryftF17ur45KFg_yoWxurc_ur
	nY9r929wn5uFs7tw4a9ayqvrWq9a4qyw1vq3s8JrWUZa4rXrykCFs7Zr90vr18Aa1xWFyD
	Zr93Ga1vqryUJjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UAwIDUUUUU=
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/8/14 3:50, Waiman Long wrote:
> On 8/13/25 4:29 AM, Chen Ridong wrote:
>> From: Chen Ridong <chenridong@huawei.com>
>>
>> Currently, free_cpumasks can free tmpmasks of cpumask of cs. However, it
>> doesn't have couple these 2 options. To make the function more clearer,
>> move the freeing of cpumask in cs to the free_cpuset. And rename the
>> free_cpumasks to the free_tmpmasks. which is Single responsibility.
>>
>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> 
> Other than typos in the patch title, the code change looks good to me.
> 
> Cheers,
> Longman

Thank you for your feedback.
I apologize for the typos—I will correct them promptly.

Best regards,
Ridong


