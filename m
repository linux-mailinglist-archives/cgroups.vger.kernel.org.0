Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79186B5E36
	for <lists+cgroups@lfdr.de>; Wed, 18 Sep 2019 09:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbfIRHlj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 18 Sep 2019 03:41:39 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:41346 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727200AbfIRHlj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 18 Sep 2019 03:41:39 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8I7eloQ096325;
        Wed, 18 Sep 2019 07:41:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=GXso365c2WcI0Kw7j10Azrhin+WL7mW3uN7GhGiBnn0=;
 b=V3lz4dST5HxFAZtcChaY6XNjUhOI0BVZ20MCuwZBqJK9da629WLewQh2DSp7QRSIRiMZ
 z5cNebBrjY6rbSeldQpgiVRGrybr+2Hs0HEW2tw8KWdz3rJxTpCa15TgveAaSpup+iZ+
 85t8mv3X9zz801dvfQwZkAVzK0F2fUZDLBWLAupyLi1TUvz7eiGPBcgL0sPjasVH13xK
 NaZOcQHz4L3H62sQeiFnugeNKcvJ4cM1N1s6/hjn9GszAWFWakjaf70xvXnCjbrIEJ8z
 DTQ/vA+lmzxImtJxHgCSakyPGc1MNsk3Yt4yeL4XuC5GAaRx9ZIFWG3cohXlzs/CpOpp aA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2v385e1w52-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Sep 2019 07:41:14 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8I7cXkW113512;
        Wed, 18 Sep 2019 07:41:14 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2v37mm35m9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Sep 2019 07:41:14 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x8I7fA4Y017752;
        Wed, 18 Sep 2019 07:41:11 GMT
Received: from [10.182.69.197] (/10.182.69.197)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 18 Sep 2019 00:41:10 -0700
Subject: Re: [PATCH] cgroup: freezer: Don't wake up process really blocked on
 signal
To:     Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>
Cc:     lizefan@huawei.com, hannes@cmpxchg.org, cgroups@vger.kernel.org,
        Roman Gushchin <guro@fb.com>
References: <20190917064645.14666-1-honglei.wang@oracle.com>
 <20190917123941.GG3084169@devbig004.ftw2.facebook.com>
 <20190917134715.GA30334@redhat.com>
From:   Honglei Wang <honglei.wang@oracle.com>
Message-ID: <685531ef-3399-a6a8-0e9e-449c713c6785@oracle.com>
Date:   Wed, 18 Sep 2019 15:41:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190917134715.GA30334@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9383 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909180081
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9383 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909180081
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



On 9/17/19 9:47 PM, Oleg Nesterov wrote:
> On 09/17, Tejun Heo wrote:
>>
>> (cc'ing Roman and Oleg and quoting whole body)
>>
>> On Tue, Sep 17, 2019 at 02:46:45PM +0800, Honglei Wang wrote:
>>> Process who's waiting for specific sigset shouldn't be woke up
>>> neither it is moved between different cgroups nor the cgroup it
>>> belongs to changes the frozen state. We'd better keep it as is
>>> and let it wait for the desired signals coming.
>>>
>>> Following test case is one scenario which will get "Interrupted
>>> system call" error if we wake it up in cgroup_freeze_task().
>>>
>>> int main(int argc, char *argv[])
>>> {
>>>          sigset_t waitset;
>>>          int signo;
>>>
>>>          sigemptyset(&waitset);
>>>          sigaddset(&waitset, SIGINT);
>>>          sigaddset(&waitset, SIGUSR1);
>>>
>>>          pthread_sigmask(SIG_BLOCK, &waitset, NULL);
>>>
>>>          for (;;) {
>>>                  signo = sigwaitinfo(&waitset, NULL);
>>>                  if (signo < 0)
>>>                          err(1, "sigwaitinfo() failed");
>>>
>>>                  if (signo == SIGUSR1)
>>>                          printf("Receive SIGUSR1\n");
>>>                  else
>>>                          break;
>>>          }
>>>
>>>          return 0;
>>> }
> 
> Well, I think we do not care. Userspace should handle -EINTR and restart
> if necessary. And afaics this test case can equally "fail" if it races
> with the system freezer, freeze_task() can be called between
> set_current_state(TASK_INTERRUPTIBLE) and freezable_schedule() in
> do_sigtimedwait().
> 
> OTOH, this is another indication that kernel/cgroup/freezer.c should
> interact with freezer_do_not_count/freezer_count somehow.
> 

It looks weird if a task is happily waiting for the desired signal, but 
is woke up by an move from one cgroup to another (which is really not 
related to any signal action from the point of userspace), doesn't it?

And same program works well in the kernel earlier than v5.2...

I knew the freeze_task() problem, but this patch is focused on the 
cgroup part. Maybe we can open another loop for the system freezer or 
just leave it there as is.

At this point, seems we need to be sure if it's necessary for cgroup to 
fix this problem or not.

> 
>>>
>>> Signed-off-by: Honglei Wang <honglei.wang@oracle.com>
>>> ---
>>>   kernel/cgroup/freezer.c | 8 ++++++--
>>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/kernel/cgroup/freezer.c b/kernel/cgroup/freezer.c
>>> index 8cf010680678..08f6abacaa75 100644
>>> --- a/kernel/cgroup/freezer.c
>>> +++ b/kernel/cgroup/freezer.c
>>> @@ -162,10 +162,14 @@ static void cgroup_freeze_task(struct task_struct *task, bool freeze)
>>>   
>>>   	if (freeze) {
>>>   		task->jobctl |= JOBCTL_TRAP_FREEZE;
>>> -		signal_wake_up(task, false);
>>> +
>>> +		if (sigisemptyset(&task->real_blocked))
>>> +			signal_wake_up(task, false);
> 
> This can't really help, ->real_blocked can be empty even if this task
> sleeps in sigwaitinfo().
>

Sorry, I'm not quit clear about the 'sleep'. sigwaitinfo() sets 
->real_blocked in do_sigtimedwait() and it goes to 
freezable_schedule_hrtimeout_range() soon. After the task is woke up, 
->real_blocked is cleared. Seems there is no chance to set 
->real_blocked to empty in this path. Do I miss something important 
here? Please correct me.

Thanks in advance,

Honglei

> Oleg.
> 
