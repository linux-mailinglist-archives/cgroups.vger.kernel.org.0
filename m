Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC6B4947FB
	for <lists+cgroups@lfdr.de>; Thu, 20 Jan 2022 08:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358919AbiATHOZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 20 Jan 2022 02:14:25 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:16726 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358745AbiATHOZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 20 Jan 2022 02:14:25 -0500
Received: from dggpeml500022.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JfYZ36lYxzZfDS;
        Thu, 20 Jan 2022 15:10:35 +0800 (CST)
Received: from dggpeml500018.china.huawei.com (7.185.36.186) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 20 Jan 2022 15:14:22 +0800
Received: from [10.67.111.186] (10.67.111.186) by
 dggpeml500018.china.huawei.com (7.185.36.186) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 20 Jan 2022 15:14:22 +0800
Message-ID: <ff49c096-39d9-4215-5b4f-8af2fd7c0c91@huawei.com>
Date:   Thu, 20 Jan 2022 15:14:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [Question] set_cpus_allowed_ptr() call failed at cpuset_attach()
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
CC:     Tejun Heo <tj@kernel.org>, <lizefan.x@bytedance.com>,
        <hannes@cmpxchg.org>, <cgroups@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <09ce5796-798e-83d0-f1a6-ba38a787bfc5@huawei.com>
 <4415cd09-6de3-bb2d-386d-8beb4927fb46@huawei.com>
 <20220119130221.GA31037@blackbody.suse.cz>
From:   Zhang Qiao <zhangqiao22@huawei.com>
In-Reply-To: <20220119130221.GA31037@blackbody.suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.186]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500018.china.huawei.com (7.185.36.186)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

hello

在 2022/1/19 21:02, Michal Koutný 写道:
> On Fri, Jan 14, 2022 at 09:15:06AM +0800, Zhang Qiao <zhangqiao22@huawei.com> wrote:
>> 	I found the following warning log on qemu. I migrated a task from one cpuset cgroup to
>> another, while I also performed the cpu hotplug operation, and got following calltrace.
> 
> Do you have more information on what hotplug event and what error
> (from set_cpus_allowed_ptr() you observe? (And what's src/dst cpuset wrt
> root/non-root)?
  I ran the LTP testcases and a test scripts that do hotplug on a random cpu at the same time.
  The race condition quickly, and I can't reproduce it so far.
  By reading code about set_cpus_allowed_ptr(), i think __set_cpus_allowed_ptr_locked() will
be failed when new_mask and cpu_active_mask do not intersect, as follows:

 __set_cpus_allowed_ptr_locked():
	....
	const struct cpumask *cpu_valid_mask = cpu_active_mask;
	dest_cpu = cpumask_any_and_distribute(cpu_valid_mask, new_mask);
	if (dest_cpu >= nr_cpu_ids) {
		ret = -EINVAL;
		goto out;
	}
	....
}


> 
>> 	Can we use cpus_read_lock()/cpus_read_unlock() to guarantee that set_cpus_allowed_ptr()
>> doesn't fail, as follows:
> 
> I'm wondering what can be wrong with the current actors:
> 
>     cpuset_can_attach
>       down_read(cpuset_rwsem)
>         // check all migratees
>       up_read(cpuset_rwsem)
>                                       [ _cpu_down / cpuhp_setup_state ]
>                                       schedule_work
>                                       ...
>                                       cpuset_hotplug_update_tasks
>                                         down_write(cpuset_rwsem)
>                                         up_write(cpuset_rwsem)
>                                       ... flush_work
>                                       [ _cpu_down / cpu_up_down_serialize_trainwrecks ]
>     cpuset_attach
>       down_write(cpuset_rwsem)
>         set_cpus_allowed_ptr(allowed_cpus_weird)
>       up_write(cpuset_rwsem)
> 

i think the troublesome scenario as follows:
     cpuset_can_attach
       down_read(cpuset_rwsem)
         // check all migratees
       up_read(cpuset_rwsem)
                                       			[ _cpu_down / cpuhp_setup_state ]
     cpuset_attach
      	down_write(cpuset_rwsem)
	guarantee_online_cpus() // (load cpus_attach)
	     						sched_cpu_deactivate
							  set_cpu_active(cpu, false)  // will change cpu_active_mask
        set_cpus_allowed_ptr(cpus_attach)
	   __set_cpus_allowed_ptr_locked()
	     // (if the intersection of cpus_attach and
	      cpu_active_mask is empty, will return -EINVAL)
       up_write(cpuset_rwsem)
	                                     		schedule_work
        	                               		...
                	                       		cpuset_hotplug_update_tasks
                        	                	 down_write(cpuset_rwsem)
	                                	         up_write(cpuset_rwsem)
		                                       ... flush_work
        		                               [ _cpu_down / cpu_up_down_serialize_trainwrecks ]


Regards,
Qiao

> The statement in cpuset_attach() about cpuset_can_attach() test is not
> so strong since task_can_attach() is mostly a pass for non-deadline
> tasks. Still, the use of cpuset_rwsem above should synchronize (I may be
> mistaken) the changes of cpuset's cpu masks, so I'd be interested about
> the details above to understand why the current approach doesn't work.
> 
> The additional cpus_read_{,un}lock (when reordered wrt cpuset_rwsem)
> may work but your patch should explain why (in what situation).
> 
> My .02€,
> Michal
> .
> 
