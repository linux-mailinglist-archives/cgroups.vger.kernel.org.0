Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FFE0495BF5
	for <lists+cgroups@lfdr.de>; Fri, 21 Jan 2022 09:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234743AbiAUIdD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 21 Jan 2022 03:33:03 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:30291 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbiAUIdC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 21 Jan 2022 03:33:02 -0500
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JgCKp0TVXzbjyx;
        Fri, 21 Jan 2022 16:32:14 +0800 (CST)
Received: from dggpeml500018.china.huawei.com (7.185.36.186) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 21 Jan 2022 16:33:00 +0800
Received: from [10.67.111.186] (10.67.111.186) by
 dggpeml500018.china.huawei.com (7.185.36.186) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 21 Jan 2022 16:33:00 +0800
Message-ID: <f4552bb3-a119-5144-778f-f5c6dc16397f@huawei.com>
Date:   Fri, 21 Jan 2022 16:33:00 +0800
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
 <ff49c096-39d9-4215-5b4f-8af2fd7c0c91@huawei.com>
 <20220120140222.GA27269@blackbody.suse.cz>
From:   Zhang Qiao <zhangqiao22@huawei.com>
In-Reply-To: <20220120140222.GA27269@blackbody.suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.186]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500018.china.huawei.com (7.185.36.186)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



在 2022/1/20 22:02, Michal Koutný 写道:
> On Thu, Jan 20, 2022 at 03:14:22PM +0800, Zhang Qiao <zhangqiao22@huawei.com> wrote:
>> i think the troublesome scenario as follows:
>>      cpuset_can_attach
>>        down_read(cpuset_rwsem)
>>          // check all migratees
>>        up_read(cpuset_rwsem)
>>                                        			[ _cpu_down / cpuhp_setup_state ]
>>      cpuset_attach
>>       	down_write(cpuset_rwsem)
>> 	guarantee_online_cpus() // (load cpus_attach)
>> 	     						sched_cpu_deactivate
>> 							  set_cpu_active(cpu, false)  // will change cpu_active_mask
>>         set_cpus_allowed_ptr(cpus_attach)
>> 	   __set_cpus_allowed_ptr_locked()
>> 	     // (if the intersection of cpus_attach and
>> 	      cpu_active_mask is empty, will return -EINVAL)
>>        up_write(cpuset_rwsem)
>> 	                                     		schedule_work
>>         	                               		...
>>                 	                       		cpuset_hotplug_update_tasks
>>                         	                	 down_write(cpuset_rwsem)
>> 	                                	         up_write(cpuset_rwsem)
>> 		                                       ... flush_work
>>         		                               [ _cpu_down / cpu_up_down_serialize_trainwrecks ]
> 
> Thanks, a locking loophole indeed.
> 
> FTR, meanwhile I noticed: a) cpuset_fork() looks buggy when
> CLONE_INTO_CGROUP (and dst.cpus != src.cpus), b) it'd be affected with
> similar hotplug race.

Yes, it shouldn't set the current task's cpumak to the child process at cpuset_fork().

Regards,
Qiao
.
> 
> Michal
> .
> 
