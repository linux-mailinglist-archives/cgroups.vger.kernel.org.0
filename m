Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 103D948F176
	for <lists+cgroups@lfdr.de>; Fri, 14 Jan 2022 21:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245201AbiANUe4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 14 Jan 2022 15:34:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:59784 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244559AbiANUdn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 14 Jan 2022 15:33:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642192422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3JSMWn4K5l2lYnB0cb+D9eToBHXluoZS4fKlQdOWiSk=;
        b=EdrYShyqeowt+5L/jnQw0MRxF11d89aFiND9bpiipnhelmL8LtZuLSapF5/xveSQAIUQOa
        4yVFcgomP5/GMj5ODA5c9TEECyNwmEVgDe+KXjDRpg4bN8otohMQkA9NpVA0mI+lXCpZFn
        uamfLDIXsdSLxHdX+Vh6VmKsgZn/hrc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-433-NXrQ9h4EM4mJuP9QXCWvpA-1; Fri, 14 Jan 2022 15:33:38 -0500
X-MC-Unique: NXrQ9h4EM4mJuP9QXCWvpA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A03AB104FC0D;
        Fri, 14 Jan 2022 20:33:36 +0000 (UTC)
Received: from [10.22.33.90] (unknown [10.22.33.90])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5A96F4BC41;
        Fri, 14 Jan 2022 20:33:35 +0000 (UTC)
Message-ID: <8bda2a8d-7faf-621d-c3c0-6351a49219ea@redhat.com>
Date:   Fri, 14 Jan 2022 15:33:34 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [Question] set_cpus_allowed_ptr() call failed at cpuset_attach()
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>, Zhang Qiao <zhangqiao22@huawei.com>
Cc:     lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
References: <09ce5796-798e-83d0-f1a6-ba38a787bfc5@huawei.com>
 <4415cd09-6de3-bb2d-386d-8beb4927fb46@huawei.com>
 <YeGi2yjRi/uZIF/2@slm.duckdns.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <YeGi2yjRi/uZIF/2@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 1/14/22 11:20, Tejun Heo wrote:
> (cc'ing Waiman and Michal and quoting whole body)
>
> Seems sane to me but let's hear what Waiman and Michal think.
>
> On Fri, Jan 14, 2022 at 09:15:06AM +0800, Zhang Qiao wrote:
>> Hello everyone
>>
>> 	I found the following warning log on qemu. I migrated a task from one cpuset cgroup to
>> another, while I also performed the cpu hotplug operation, and got following calltrace.
>>
>> 	This may lead to a inconsistency between the affinity of the task and cpuset.cpus of the
>> dest cpuset, but this task can be successfully migrated to the dest cpuset cgroup.
>>
>> 	Can we use cpus_read_lock()/cpus_read_unlock() to guarantee that set_cpus_allowed_ptr()
>> doesn't fail, as follows:
>>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index d0e163a02099..2535d23d2c51 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -2265,6 +2265,7 @@ static void cpuset_attach(struct cgroup_taskset *tset)
>>          guarantee_online_mems(cs, &cpuset_attach_nodemask_to);
>>
>>          cgroup_taskset_for_each(task, css, tset) {
>> +               cpus_read_lock();
>>                  if (cs != &top_cpuset)
>>                          guarantee_online_cpus(task, cpus_attach);
>>                  else
>> @@ -2274,6 +2275,7 @@ static void cpuset_attach(struct cgroup_taskset *tset)
>>                   * fail.  TODO: have a better way to handle failure here
>>                   */
>>                  WARN_ON_ONCE(set_cpus_allowed_ptr(task, cpus_attach));
>> +               cpus_read_unlock();
>>
>>
>> 	Is there a better solution?
>>
>> 	Thanks

The change looks OK to me. However, we may need to run the full set of 
regression test to make sure that lockdep won't complain about potential 
deadlock.

Cheers,
Longman

