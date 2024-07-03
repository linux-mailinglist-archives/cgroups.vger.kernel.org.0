Return-Path: <cgroups+bounces-3509-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B87CC924DCB
	for <lists+cgroups@lfdr.de>; Wed,  3 Jul 2024 04:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC4C01C224AA
	for <lists+cgroups@lfdr.de>; Wed,  3 Jul 2024 02:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3506E4409;
	Wed,  3 Jul 2024 02:30:14 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C211DA319;
	Wed,  3 Jul 2024 02:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719973814; cv=none; b=bgJiciA7rd777X3AVIGa4D4BiMrzo+hyi5vGDIhCNDcTiCcAovA64OFl1aPn+Er8uJR69U6W3SpcBo2zbpUmfdsE7Ld2+2gUUprAsutMY/KxIkV6YZvltmGkLq05CjUEA7mhjjGnB2/UsNmfl+r2CaH0HbelrCgCeg6TvgBEnos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719973814; c=relaxed/simple;
	bh=dh1K0a4afBOwGhsy/5Ao11PDsLpTi6WawIOAXpivH0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fByM2dTF8m9aNBjneS4LYl4wXPwv/Om4MgkinZ64uKShKPyUsMu2WRxhjI5NGd1s2/l1zDyu4YSPh8oQEWYXUSGnwOnqtoj6fJN/YRaUKX4cQ/z3+qbt0cBwa7bNJ0Cjf14YHgA5YDWKGUoxzvxrpgXcMoL3oOvQmYQNJ0GBC/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WDNt559zvzZgpd;
	Wed,  3 Jul 2024 10:25:33 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id B8D44140F9A;
	Wed,  3 Jul 2024 10:30:06 +0800 (CST)
Received: from [10.67.109.79] (10.67.109.79) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Wed, 3 Jul
 2024 10:30:06 +0800
Message-ID: <46f19c68-6296-49fe-b684-67625666ca1e@huawei.com>
Date: Wed, 3 Jul 2024 10:30:05 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 -next] cgroup/rstat: add force idle show helper
To: Tejun Heo <tj@kernel.org>
CC: <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>, <longman@redhat.com>,
	<cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240702022822.1032693-1-chenridong@huawei.com>
 <ZoQ2ti7nnz9EJSc3@slm.duckdns.org>
Content-Language: en-US
From: chenridong <chenridong@huawei.com>
In-Reply-To: <ZoQ2ti7nnz9EJSc3@slm.duckdns.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemd100013.china.huawei.com (7.221.188.163)



On 2024/7/3 1:19, Tejun Heo wrote:
> Hello,
> 
> On Tue, Jul 02, 2024 at 02:28:22AM +0000, Chen Ridong wrote:
> ...
>>   	if (cgroup_parent(cgrp)) {
>>   		cgroup_rstat_flush_hold(cgrp);
>>   		usage = cgrp->bstat.cputime.sum_exec_runtime;
>>   		cputime_adjust(&cgrp->bstat.cputime, &cgrp->prev_cputime,
>>   			       &utime, &stime);
>> -#ifdef CONFIG_SCHED_CORE
>> -		forceidle_time = cgrp->bstat.forceidle_sum;
>> -#endif
>> +		bstat = cgrp->bstat;
> 
> Please don't copy non-trivial struct like this. Maybe add a pointer which
> points to the bstat to use?
> 
> Thanks.
> 

I don't wanna add a pointer. If I add pointer,to prevent the situation 
where a variable is unused when CONFIG_SCHED_CORE is disable, I have to 
add #ifdef CONFIG_SCHED_CORE again.
We do not actually need to define bstat. The cgrp->bstat of root is not 
actually used, maybe we can simply use cgrp->bstat directly as below.

void cgroup_base_stat_cputime_show(struct seq_file *seq)
  {
         struct cgroup *cgrp = seq_css(seq)->cgroup;
         u64 usage, utime, stime;
-       struct cgroup_base_stat bstat;
-#ifdef CONFIG_SCHED_CORE
-       u64 forceidle_time;
-#endif

         if (cgroup_parent(cgrp)) {
                 cgroup_rstat_flush_hold(cgrp);
                 usage = cgrp->bstat.cputime.sum_exec_runtime;
                 cputime_adjust(&cgrp->bstat.cputime, &cgrp->prev_cputime,
                                &utime, &stime);
-#ifdef CONFIG_SCHED_CORE
-               forceidle_time = cgrp->bstat.forceidle_sum;
-#endif
                 cgroup_rstat_flush_release(cgrp);
         } else {
-               root_cgroup_cputime(&bstat);
-               usage = bstat.cputime.sum_exec_runtime;
-               utime = bstat.cputime.utime;
-               stime = bstat.cputime.stime;
-#ifdef CONFIG_SCHED_CORE
-               forceidle_time = bstat.forceidle_sum;
-#endif
+               root_cgroup_cputime(&cgrp->bstat);
+               usage = cgrp->bstat.cputime.sum_exec_runtime;
+               utime = cgrp->bstat.cputime.utime;
+               stime = cgrp->bstat.cputime.stime;
         }

         do_div(usage, NSEC_PER_USEC);
         do_div(utime, NSEC_PER_USEC);
         do_div(stime, NSEC_PER_USEC);
-#ifdef CONFIG_SCHED_CORE
-       do_div(forceidle_time, NSEC_PER_USEC);
-#endif

         seq_printf(seq, "usage_usec %llu\n"
                    "user_usec %llu\n"
                    "system_usec %llu\n",
                    usage, utime, stime);

-#ifdef CONFIG_SCHED_CORE
-       seq_printf(seq, "core_sched.force_idle_usec %llu\n", 
forceidle_time);
-#endif
+       cgroup_force_idle_show(seq, &cgrp->bstat);
  }

