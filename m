Return-Path: <cgroups+bounces-10412-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CC5B98B24
	for <lists+cgroups@lfdr.de>; Wed, 24 Sep 2025 09:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33BAB4A6DA9
	for <lists+cgroups@lfdr.de>; Wed, 24 Sep 2025 07:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90FFC28725A;
	Wed, 24 Sep 2025 07:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="D3R2aYV/"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991BA256C8D
	for <cgroups@vger.kernel.org>; Wed, 24 Sep 2025 07:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758700253; cv=none; b=lhtM56YmZ1nu5Uxqbz/HuPQn6vW1CupZKDdii55lzfvs5feWxPqRmUQq0ImMysXjRUmcQfAQKViL+uT/i8/4PUZJiIs5u/ADfpq1h4RLbMQ7gV8qW5BbM64u7nbOg2smKfrG6YcEMz0Lf331N34ykL0VpBb7IjcVR5w+jGn/EeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758700253; c=relaxed/simple;
	bh=45ID2kuv0qFzfqDiZyEd9DoHC7kvx6ye7Wh2smi4EfU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fiRLV7YLphi/m5soCPux7Vfd6Vygm7UxWiIH+7Z4jQwXi0Ruoq0haUFVDAbkpEZ6y8t8wYQI918+4gyDOzhF0S02Y4OmEsXXqC9W2OHZMeqB3urPVEDP0JqGd2u+UvFIoe3SXI2z6CpDcT69Vk6X0nt2t89O8qcFOpPpo3iBE/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=D3R2aYV/; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7761b83fd01so6198860b3a.3
        for <cgroups@vger.kernel.org>; Wed, 24 Sep 2025 00:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758700251; x=1759305051; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CV8Ezfn2saza8BjopllSPTGobi36DchCDdd90Jw4e3I=;
        b=D3R2aYV/E2VgUiaTXCyGZyOYBD0HiSit4mSb8GssohgxP40kNsfleMraXpc0XZAC++
         S0yn9ZlVzoKjoTNHS2PF+7/7XZcoJ6OZSuwxwbflSkA5azZB7cRsdgaWTHCg0rVS25A3
         Q+76runYZeLgnHgqpHIdDKWT98mHjZJLjeEIoUrtiIGZeZdPNoj9uzkFdft5d2QvqF6U
         3n7LD3wxSaNRq7Pp4bzoVEYkH0elXmApzlDGhE9cmJ16tFC/cRhXJejf4Jpf9ysHo2OQ
         2Il0WzNFFC6swZz+T6/2Ou4j8tHSJfdayS6N8NpgYGnxkKZk7jm8PFKu82nQCLVUzffZ
         j9Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758700251; x=1759305051;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CV8Ezfn2saza8BjopllSPTGobi36DchCDdd90Jw4e3I=;
        b=im6TLrcwJDzCKeYZxVMP4DoGVpDRpAZFdVNfxawiNXrIvipOI8czqnjDH9Wri3njAm
         ZBdu4BTaqmb9+2R5VrlzRjV2jPmhOFv0RwA6DDD8zuFDf81LV5epDukJ3Voowr4angT/
         fpNmaOHWgaGvUXjL0ptOSAsCalhdC34rivVYJFJp/kreZJTF4I2l+D6mrMkLlMVMaKov
         CMd7Sw0FNvqO8mjsTHbzI+7JYCGsYvNKJ5tc3yKh5+h5y61fowSLDAKcHDmZxeiFtVGb
         QJgt10bVPsCoMYK5O0vrUhUKG5n0i+IyZTDXEDmTMj60zbQ6eoPZcmg9AeETuls3ztPY
         WBQA==
X-Gm-Message-State: AOJu0YzAJ/k3eZJZre+xAXmGbpxg221BY8vQADvfRz5dMAE3TuGCCAI/
	JbwdoKivbrOB0Bg6V4uv3dc6ohzQD+6sddvAlnzsFYX/jSAriPfWTaYpOUYvEn/h36E=
X-Gm-Gg: ASbGnculY5eXS6wolyXhs8NUBuGDIH/Y5kGH7+DyjjqF3ndPcT/U3BOGTGWg77G7Asr
	f7QihoYm7OpeoI3oy0klqAPjklwwYtVl3wziaXkh1MqRvySLbhvFcdkTlUkcwtVcSvaZseUJemy
	XxB6YG7riQZ8uEOHGtEliewJKZthLOci6Q/XCgLDrDc8IueLXBDCx34QMK0V+z4dJP0d7X5mv/x
	PZCke/rhu+5mtIqzwCTC7MvbWCjBJTC7ebNIfbh1arDmI5NuBP2S5DVrnC0aiRATLBW9trHf5vt
	egh8keLppTs67lguT2rPpSohjzpfLos5+ZOiJq7WF85VnlB8rIxHfauL+/U5ssySF2vbkEOruz+
	4EywjQEA/lqbSIApdfrg1dWU5fP1+pSKIpNe8kbnXcXUz8GbQtviP6lvjs67j0Ptxr+2+oQPXDg
	==
X-Google-Smtp-Source: AGHT+IF/FsViDZnN1wC3bVBeDjfe2a1td3Uy9MTTTgmPfAiltbIpdnbAcEVw0Jdsi9BK/RiEHIqtzQ==
X-Received: by 2002:a17:903:4b4b:b0:279:a5bb:54e2 with SMTP id d9443c01a7336-27cc21fabc8mr69834335ad.20.1758700250705;
        Wed, 24 Sep 2025 00:50:50 -0700 (PDT)
Received: from [10.88.210.107] ([61.213.176.55])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ec0a7f443sm13118355ad.105.2025.09.24.00.50.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 00:50:50 -0700 (PDT)
Message-ID: <37fd969e-3799-48d0-a8e0-1937e5a4ae38@bytedance.com>
Date: Wed, 24 Sep 2025 15:50:41 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [PATCH v2 2/2] memcg: Don't trigger hung task
 warnings when memcg is releasing resources.
To: Peter Zijlstra <peterz@infradead.org>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org, lance.yang@linux.dev, mhiramat@kernel.org,
 yangyicong@hisilicon.com, will@kernel.org, dianders@chromium.org,
 mingo@kernel.org, lihuafei1@huawei.com, hannes@cmpxchg.org,
 mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
 muchun.song@linux.dev, tj@kernel.org
References: <20250924034100.3701520-1-sunjunchao@bytedance.com>
 <20250924034100.3701520-3-sunjunchao@bytedance.com>
 <20250924063219.GR4067720@noisy.programming.kicks-ass.net>
From: Julian Sun <sunjunchao@bytedance.com>
In-Reply-To: <20250924063219.GR4067720@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/24/25 2:32 PM, Peter Zijlstra wrote:
> On Wed, Sep 24, 2025 at 11:41:00AM +0800, Julian Sun wrote:
>> Hung task warning in mem_cgroup_css_free() is undesirable and
>> unnecessary since the behavior of waiting for a long time is
>> expected.
>>
>> Use touch_hung_task_detector() to eliminate the possible
>> hung task warning.
>>
>> Signed-off-by: Julian Sun <sunjunchao@bytedance.com>
> 
> Still hate this. It is not tied to progress. If progress really stalls,
> no warning will be given.

Hi, peter

Thanks for your review and comments.

I did take a look at your solution provided yesterday, and get your 
point. However AFAICS it can't resolve the unexpected warnings here. 
Because it only works after we reach the finish_writeback_work(), and 
the key point here is, it *already* takes a long time before we reach 
finish_writeback_work(), and there is true progress before finish the 
writeback work that hung task detector still can not know.

If we want to make the hung task detector to known the progress of 
writeback work, we need to add some code within do_writepages(): after 
each finish of a_ops->writepages(), we need to make detector to known 
there's progress. Something like this:

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 3e248d1c3969..49572a83c47b 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2635,6 +2635,10 @@ int do_writepages(struct address_space *mapping, 
struct writeback_control *wbc)
                 else
                         /* deal with chardevs and other special files */
                         ret = 0;
+               /* Make hung task detector to known there's progress. */
+               if (force_wake)
+                       wake_up_all(waitq);
+
                 if (ret != -ENOMEM || wbc->sync_mode != WB_SYNC_ALL)
                         break;

which has a big impact on current code - I don't want to introduce this.

Yes, the behavior in this patch does have the possibility to paper cover 
the real warnings, and what I want to argue is that the essence of this 
patch is the same as the current touch_nmi_watchdog() and 
touch_softlockup_watchdog() - these functions are used only in specific 
scenarios we known and only affect a single event. And there seems no 
report that touch_nmi/softlockup_watchdog() will paper cover the real 
warnings (do we?).

Correct me if there's anything I'm missing or misunderstanding.


> 
>>   mm/memcontrol.c | 10 +++++++++-
>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index 8dd7fbed5a94..fc73a56372a4 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -63,6 +63,7 @@
>>   #include <linux/seq_buf.h>
>>   #include <linux/sched/isolation.h>
>>   #include <linux/kmemleak.h>
>> +#include <linux/nmi.h>
>>   #include "internal.h"
>>   #include <net/sock.h>
>>   #include <net/ip.h>
>> @@ -3912,8 +3913,15 @@ static void mem_cgroup_css_free(struct cgroup_subsys_state *css)
>>   	int __maybe_unused i;
>>   
>>   #ifdef CONFIG_CGROUP_WRITEBACK
>> -	for (i = 0; i < MEMCG_CGWB_FRN_CNT; i++)
>> +	for (i = 0; i < MEMCG_CGWB_FRN_CNT; i++) {
>> +		/*
>> +		 * We don't want the hung task detector to report warnings
>> +		 * here since there's nothing wrong if the writeback work
>> +		 * lasts for a long time.
>> +		 */
>> +		touch_hung_task_detector(current);
>>   		wb_wait_for_completion(&memcg->cgwb_frn[i].done);
>> +	}
>>   #endif
>>   	if (cgroup_subsys_on_dfl(memory_cgrp_subsys) && !cgroup_memory_nosocket)
>>   		static_branch_dec(&memcg_sockets_enabled_key);
>> -- 
>> 2.39.5
>>

Thanks,
-- 
Julian Sun <sunjunchao@bytedance.com>

