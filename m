Return-Path: <cgroups+bounces-6514-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74AC9A31CBA
	for <lists+cgroups@lfdr.de>; Wed, 12 Feb 2025 04:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19630188AE64
	for <lists+cgroups@lfdr.de>; Wed, 12 Feb 2025 03:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826001DA60D;
	Wed, 12 Feb 2025 03:24:46 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C5F1D8DEE;
	Wed, 12 Feb 2025 03:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739330686; cv=none; b=iIBxR+QriFiqSNczgvpayRRBJH9goILDn0PQpEv9IrSEu9HtLvj4upfrvj8vfqOJpxSrTuu+cGFoV1M7wKqe0uEf1zqAD4ag0Ug8yLn5RyGcTJvb7jK7WZY5f4NCpkZRePT6GeSeOCOScQi6Aoanb9NX67VhLzAJubSKbsIFM6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739330686; c=relaxed/simple;
	bh=D6rd0kRCvnMgB1deU5946QLL3NJQk4kXAS0NXcvduu0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=trPsGtnSQs0ff3XMeG6NDwRZRQSqWFobemdnKfVHs6Gc7mkCGRDiQqOVjlbpHlRAqwTdIEmRPZ5r0Nlj5kMN+5QWaCM1grJU4k5/5oRMzcqiFCM8e5qqry3rFqe7/1MpJgqY4IjtU7uNCDbK3TIM/Fo0JvipjffDicxALCOAwLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Yt3ZS1gZpz4f3kvf;
	Wed, 12 Feb 2025 11:24:16 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id E78AB1A0D7E;
	Wed, 12 Feb 2025 11:24:38 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP2 (Coremail) with SMTP id Syh0CgDX4GNzFKxnNpxXDg--.64293S2;
	Wed, 12 Feb 2025 11:24:36 +0800 (CST)
Message-ID: <bad9a99e-a160-4f8a-a22e-d93c7a29f940@huaweicloud.com>
Date: Wed, 12 Feb 2025 11:24:35 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/oom_kill: revert watchdog reset in global OOM process
To: akpm@linux-foundation.org, mhocko@kernel.org, hannes@cmpxchg.org,
 yosryahmed@google.com, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
 muchun.song@linux.dev, davidf@vimeo.com, vbabka@suse.cz, mkoutny@suse.com,
 paulmck@kernel.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, chenridong@huawei.com, wangweiyang2@huawei.com
References: <20250212025707.67009-1-chenridong@huaweicloud.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <20250212025707.67009-1-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgDX4GNzFKxnNpxXDg--.64293S2
X-Coremail-Antispam: 1UD129KBjvJXoW7urWxuryrWryrKF1xCr1UGFg_yoW8Aryxpa
	yDu3WUKws8ta45Z3W7ZrWI9F17J3yrZr48tF9rt34rZwsxtrn2krWIkrnIqr95AFZI9a4Y
	vFnIgrn7JrZ0qw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	7KsUUUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/2/12 10:57, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
> 
> Unlike memcg OOM, which is relatively common, global OOM events are rare
> and typically indicate that the entire system is under severe memory
> pressure. The commit ade81479c7dd ("memcg: fix soft lockup in the OOM
> process") added the touch_softlockup_watchdog in the global OOM handler to
> suppess the soft lockup issues. However, while this change can suppress
> soft lockup warnings, it does not address RCU stalls, which can still be
> detected and may cause unnecessary disturbances. Simply remove the
> modification from the global OOM handler.
> 
> Fixes: ade81479c7dd ("memcg: fix soft lockup in the OOM process")
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>  mm/oom_kill.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 25923cfec9c6..2d8b27604ef8 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -44,7 +44,6 @@
>  #include <linux/init.h>
>  #include <linux/mmu_notifier.h>
>  #include <linux/cred.h>
> -#include <linux/nmi.h>
>  
>  #include <asm/tlb.h>
>  #include "internal.h"
> @@ -431,15 +430,10 @@ static void dump_tasks(struct oom_control *oc)
>  		mem_cgroup_scan_tasks(oc->memcg, dump_task, oc);
>  	else {
>  		struct task_struct *p;
> -		int i = 0;
>  
>  		rcu_read_lock();
> -		for_each_process(p) {
> -			/* Avoid potential softlockup warning */
> -			if ((++i & 1023) == 0)
> -				touch_softlockup_watchdog();
> +		for_each_process(p)
>  			dump_task(p, oc);
> -		}
>  		rcu_read_unlock();
>  	}
>  }

Add discussion link:
https://lore.kernel.org/cgroups/0d9ea655-5c1a-4ba9-9eeb-b45d74cc68d0@huaweicloud.com/


