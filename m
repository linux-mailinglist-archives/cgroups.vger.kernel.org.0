Return-Path: <cgroups+bounces-9632-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A162B41164
	for <lists+cgroups@lfdr.de>; Wed,  3 Sep 2025 02:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBC5B48860D
	for <lists+cgroups@lfdr.de>; Wed,  3 Sep 2025 00:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3382718991E;
	Wed,  3 Sep 2025 00:39:28 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854A5632;
	Wed,  3 Sep 2025 00:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756859968; cv=none; b=XtHnYe97XeWOK2Z5i8f1u53NeXQfvZlH/oqMFNvq9N/GgLK53Q8MTvLRxwQueLr4lP3XJf/CBsEECGCqCihREAxTYiTLaGn/xoqBHsVg6XTvaz/qsR5m0RJgu5jyC+Ao0KgBcuiPhpWVt/y9Otq+PFoenpDtes0hn+SLfDQbHhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756859968; c=relaxed/simple;
	bh=Je2/yHkVTISW+1lChsj19DBet6v4DsTYIUqyQFCH3tI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UvyKtSG4h/yt9R63+09ZoONgXJl8wI7fleA1iPJoSsealXopyIkRSGjYDZDPKcGtupdhT6v/3KxF06HDTlRKVdFc+cAK5/eysWWeX3w/5eYNFMa5aYKH8C+sANXo6SKhWG95obagTCUXAck26wvo8qVMl3wrUtf7XtlDfjcDrXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cGkJW0dbKzKHLws;
	Wed,  3 Sep 2025 08:39:23 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id F0A391A0DDD;
	Wed,  3 Sep 2025 08:39:22 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP3 (Coremail) with SMTP id _Ch0CgAnwmk3jrdo3zS3BA--.42353S2;
	Wed, 03 Sep 2025 08:39:20 +0800 (CST)
Message-ID: <3c51992e-a61a-4644-b7ac-1daa8ed0e06d@huaweicloud.com>
Date: Wed, 3 Sep 2025 08:39:18 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cgroup/cpuset: Prevent NULL pointer access in
 free_tmpmasks()
To: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ashay Jaiswal <quic_ashayj@quicinc.com>, Chen Ridong <chenridong@huawei.com>
References: <20250902181537.833102-1-longman@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <20250902181537.833102-1-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgAnwmk3jrdo3zS3BA--.42353S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tw1fXr1UZw1fArWkuryDZFb_yoW8Wr43pF
	WYkFyj93y5GFy8K34qqa1xWr1SkaykJF90kwnxJw18AFya9F10vF15ur98Xw40kanIkF1f
	tFy5ZF4jgr1DtF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUylb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUwxhLUUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/9/3 2:15, Waiman Long wrote:
> Commit 5806b3d05165 ("cpuset: decouple tmpmasks and cpumasks freeing in
> cgroup") separates out the freeing of tmpmasks into a new free_tmpmask()
> helper but removes the NULL pointer check in the process. Unfortunately a
> NULL pointer can be passed to free_tmpmasks() in cpuset_handle_hotplug()
> if cpuset v1 is active. This can cause segmentation fault and crash
> the kernel.
> 
> Fix that by adding the NULL pointer check to free_tmpmasks().
> 
> Fixes: 5806b3d05165 ("cpuset: decouple tmpmasks and cpumasks freeing in cgroup")
> Reported-by: Ashay Jaiswal <quic_ashayj@quicinc.com>
> Closes: https://lore.kernel.org/lkml/20250902-cpuset-free-on-condition-v1-1-f46ffab53eac@quicinc.com/
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  kernel/cgroup/cpuset.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index a78ccd11ce9b..c0c281a8860d 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -484,6 +484,9 @@ static inline int alloc_tmpmasks(struct tmpmasks *tmp)
>   */
>  static inline void free_tmpmasks(struct tmpmasks *tmp)
>  {
> +	if (!tmp)
> +		return;
> +
>  	free_cpumask_var(tmp->new_cpus);
>  	free_cpumask_var(tmp->addmask);
>  	free_cpumask_var(tmp->delmask);

Thank you, Longman and Ashay.

My apologies for missing the NULL pointer check, which led to this issue.
I have double-checked the free_cpuset function, and it does not receive a NULL pointer as input.

-- 
Best regards,
Ridong


