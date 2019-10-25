Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5ECE40FF
	for <lists+cgroups@lfdr.de>; Fri, 25 Oct 2019 03:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388824AbfJYBX1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 24 Oct 2019 21:23:27 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:41538 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388701AbfJYBX1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 24 Oct 2019 21:23:27 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9P1K2cq125141;
        Fri, 25 Oct 2019 01:23:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=9oNKbKCM67hLMRz7mKu/OKhrxcl3yHmWG4tH+pvQHS8=;
 b=K8QhJ41DCg31ArGmXDmxH7fTPxzvbirHQydRcmCqfrk2N898ufRUxx/vaV977pe0z7wk
 1FrKR4Sk0MFlABchDi00ysSjc1P2IvORTiwsbfzWPT5BLPH3/d4r/YPzf5NYOElYx0Di
 +Nh7/UH9NQp7bjaOi7Pj6vDVp6w50b3Jjfre6b2kkqK5pUjFB7HqA8TRYEH8WwK1Xs6U
 iroj9kOsppJlZR6dzn4ZW0zUrtu0FKVkY9/+vVgOyqb4vjJkG9W3Z6I/+YQ4q4BZ34iv
 3Y51f/LrNICdifxwJrRjUW8+U0D1qisg7g3Eq56H6ASO2EFjcZAvJDo/99XsVKxnbwzZ VQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2vqteq76jd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Oct 2019 01:23:10 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9P1MvIv153258;
        Fri, 25 Oct 2019 01:23:10 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2vu0fqedm4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Oct 2019 01:23:10 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9P1N9Nl019798;
        Fri, 25 Oct 2019 01:23:09 GMT
Received: from [10.182.71.227] (/10.182.71.227)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 24 Oct 2019 18:23:08 -0700
Subject: Re: [PATCH] cgroup: freezer: don't change task and cgroups status
 unnecessarily
To:     Roman Gushchin <guro@fb.com>
Cc:     "tj@kernel.org" <tj@kernel.org>,
        "lizefan@huawei.com" <lizefan@huawei.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "oleg@redhat.com" <oleg@redhat.com>
References: <20191021081826.8769-1-honglei.wang@oracle.com>
 <20191021161453.GA3407@castle.DHCP.thefacebook.com>
 <4db30150-262d-b69f-3adf-4cc1be976119@oracle.com>
 <20191025011645.GA16643@tower.DHCP.thefacebook.com>
From:   Honglei Wang <honglei.wang@oracle.com>
Message-ID: <5afa597d-39c5-c584-8ee9-f25d7a6f87be@oracle.com>
Date:   Fri, 25 Oct 2019 09:23:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191025011645.GA16643@tower.DHCP.thefacebook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9420 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910250013
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9420 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910250012
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



On 10/25/19 9:16 AM, Roman Gushchin wrote:
> On Wed, Oct 23, 2019 at 10:18:48AM +0800, Honglei Wang wrote:
>>
>>
>> On 10/22/19 12:14 AM, Roman Gushchin wrote:
>>> On Mon, Oct 21, 2019 at 04:18:26PM +0800, Honglei Wang wrote:
>>>> Seems it's not necessary to adjust the task state and revisit the
>>>> state of source and destination cgroups if the cgroups are not in
>>>> freeze state and the task itself is not frozen.
>>>>
>>>> Signed-off-by: Honglei Wang <honglei.wang@oracle.com>
>>>
>>> Hello Honglei!
>>>
>>> Overall the patch looks correct to me, but what's the goal of this change?
>>> Do you see any performance difference in some tests?
>>> Maybe you can use freezer tests from kselftests to show the difference?
>>>
>>> Your patch will sightly change the behavior of the freezer if unfreezing
>>> of a cgroup is racing with the task migration. The change is probably fine
>>> (at least I can't imagine why not), and I'd totally support the patch,
>>> if there is any performance benefit.
>>>
>>> Thank you!
>>>
>>
>> Hi Roman,
>>
>> Thank you for your attention!
>>
>> When I debug another problem, I just happen add some debug print which show
>> me there are many tasks be woke up when moving tasks from one cgroup to
>> another. After a bit more test, I find there are hundreds of task waking up
>> happen even when the kernel boot up.
>>
>> All of these tasks are not in running state when they are moved into a
>> cgroup or moved from one to anther, and the movement itself is not the
>> signal to wake up these tasks. I feel it's waste that the whole wake-up
>> process have to be done for the tasks who are not supposed ready to put into
>> the runqueue...
> 
> Hello Honglei!
> 
> I'm deeply sorry, I've missed your e-mail being thinking about the proposal
> from Oleg and various edge cases.
> 
> I don't think saving 50% cpu time on migrating 1000 tasks is important,
> but not waking tasks without a reason looks as a perfect justification for
> the patch.
> 
> Please, fell free to use
> Acked-by: Roman Gushchin <guro@fb.com>
> after fixing the comment and adding some justification text to the commit
> message.
> 
> Thank you!
> 

Thanks a lot, Roman. I'll give a v2 later according to the suggestions.

Honglei

>>
>> Then I think further, if somebody want to move huge amount of tasks from one
>> cgroup to another OR from the child cgroup to its parent before remove it,
>> more such waste happens. I do a test which move 1000 tasks from child to
>> parent via a script:
>>
>> without the code change:
>> real 0m0.037s
>> user 0m0.021s
>> sys  0m0.016s
>>
>> with the code change:
>> real 0m0.028s
>> user 0m0.020s
>> sys  0m0.008s
>>
>> it saves 50% time in system part (yes, 0.008s is not a big deal ;)).
>>
>> Does it make sense to you?
>>
>> Thank,
>> Honglei
>>
>>
>>>> ---
>>>>    kernel/cgroup/freezer.c | 9 +++++++++
>>>>    1 file changed, 9 insertions(+)
>>>>
>>>> diff --git a/kernel/cgroup/freezer.c b/kernel/cgroup/freezer.c
>>>> index 8cf010680678..2dd66551d9a6 100644
>>>> --- a/kernel/cgroup/freezer.c
>>>> +++ b/kernel/cgroup/freezer.c
>>>> @@ -230,6 +230,15 @@ void cgroup_freezer_migrate_task(struct task_struct *task,
>>>>    	if (task->flags & PF_KTHREAD)
>>>>    		return;
>>>> +	/*
>>>> +	 * It's not necessary to do changes if both of the src and dst cgroups
>>>> +	 * are not freeze and task is not frozen.
>>>                          ^^^
>>> 		are not freezing?
>>
>> Will fix it in next version if we think this patch is necessary.
>>
>>>> +	 */
>>>> +	if (!test_bit(CGRP_FREEZE, &src->flags) &&
>>>> +	    !test_bit(CGRP_FREEZE, &dst->flags) &&
>>>> +	    !task->frozen)
>>>> +		return;
>>>> +
>>>>    	/*
>>>>    	 * Adjust counters of freezing and frozen tasks.
>>>>    	 * Note, that if the task is frozen, but the destination cgroup is not
>>>> -- 
>>>> 2.17.0
>>>>
