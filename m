Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDD34B74DC
	for <lists+cgroups@lfdr.de>; Thu, 19 Sep 2019 10:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725887AbfISIRY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 19 Sep 2019 04:17:24 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:42226 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727273AbfISIRX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 19 Sep 2019 04:17:23 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8J8EtXW149332;
        Thu, 19 Sep 2019 08:17:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=d9r3VlhrD7TrX5L4JkXTInLpJjcZl/nfwrgRK7eYtLg=;
 b=izL9tSlV5se3rjBF1Wuer5aYmmp7PHKpsW8OnEpo2W3crwawG5UWTCddOLfTLj1aS4qa
 orkGH2NdEHQ8cD5zUbD6kpQ+iBj6ejAhueSnl3HbWxFKILfNftobZ/jUQetjl1bIGiHW
 BWOjVrXVZ4dWfHB0TxluceOWoZ7/DdnXhFWlQ8q7BbcAQpwNb/9GhLXC8U3lJ2KKizZL
 b5AvQHv0zqJUicR9u5YxZeUj+DkRUc0iw++dRDVnlJ/ONXqgUYRgxj33iNBqM+PUQ9rs
 FJh9hSXDH0oJ+LEQZFTMAOL710ZHstax4lYNQSKA2ruoTAKSgiw9iCEO+hiSzwzyAShN zg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2v3vb4t6ab-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Sep 2019 08:17:07 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8J8CcSW176361;
        Thu, 19 Sep 2019 08:17:06 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2v3vbfmugn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Sep 2019 08:17:05 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x8J8H1On001925;
        Thu, 19 Sep 2019 08:17:01 GMT
Received: from [10.182.69.197] (/10.182.69.197)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 19 Sep 2019 01:17:01 -0700
Subject: Re: [PATCH] cgroup: freezer: Don't wake up process really blocked on
 signal
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Tejun Heo <tj@kernel.org>, lizefan@huawei.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, Roman Gushchin <guro@fb.com>
References: <20190917064645.14666-1-honglei.wang@oracle.com>
 <20190917123941.GG3084169@devbig004.ftw2.facebook.com>
 <20190917134715.GA30334@redhat.com>
 <685531ef-3399-a6a8-0e9e-449c713c6785@oracle.com>
 <20190918114745.GA16266@redhat.com>
From:   Honglei Wang <honglei.wang@oracle.com>
Message-ID: <e4197769-e8e7-9efb-0045-1d4298732cc5@oracle.com>
Date:   Thu, 19 Sep 2019 16:16:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190918114745.GA16266@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9384 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909190078
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9384 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909190078
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Oleg,

Okay, get your point clearly, thanks for the explanation. Abort this patch.

Honglei

On 9/18/19 7:47 PM, Oleg Nesterov wrote:
> On 09/18, Honglei Wang wrote:
>>
>>
>> On 9/17/19 9:47 PM, Oleg Nesterov wrote:
>>>>> int main(int argc, char *argv[])
>>>>> {
>>>>>          sigset_t waitset;
>>>>>          int signo;
>>>>>
>>>>>          sigemptyset(&waitset);
>>>>>          sigaddset(&waitset, SIGINT);
>>>>>          sigaddset(&waitset, SIGUSR1);
>>>>>
>>>>>          pthread_sigmask(SIG_BLOCK, &waitset, NULL);
>>>>>
>>>>>          for (;;) {
>>>>>                  signo = sigwaitinfo(&waitset, NULL);
>>>>>                  if (signo < 0)
>>>>>                          err(1, "sigwaitinfo() failed");
>>>>>
>>>>>                  if (signo == SIGUSR1)
>>>>>                          printf("Receive SIGUSR1\n");
>>>>>                  else
>>>>>                          break;
>>>>>          }
>>>>>
>>>>>          return 0;
>>>>> }
>>>Abort
>>> Well, I think we do not care. Userspace should handle -EINTR and restart
>>> if necessary. And afaics this test case can equally "fail" if it races
>>> with the system freezer, freeze_task() can be called between
>>> set_current_state(TASK_INTERRUPTIBLE) and freezable_schedule() in
>>> do_sigtimedwait().
>>>
>>> OTOH, this is another indication that kernel/cgroup/freezer.c should
>>> interact with freezer_do_not_count/freezer_count somehow.
>>>
>>
>> It looks weird if a task is happily waiting for the desired signal, but is
>> woke up by an move from one cgroup to another (which is really not related
>> to any signal action from the point of userspace), doesn't it?
> 
> Again, imo a sane application should handle -EINTR. Nothing really weird.
> 
> There are other reasons why sigwaitinfo() can return -EINTR. Say, another
> thread can steal a signal. Or, simply start you test-case and run
> strace -p.
> 
> If you want to "fix" sigwaitinfo() - just make it restartable, that is all.
> But see above, I don't think this makes any sense.
> 
>> At this point, seems we need to be sure if it's necessary for cgroup to fix
>> this problem or not.
> 
> Well, to me this particular problem simply doesn't exist ;) However, cgroup
> freezer has other, more serious problems.
> 
>>>>> diff --git a/kernel/cgroup/freezer.c b/kernel/cgroup/freezer.c
>>>>> index 8cf010680678..08f6abacaa75 100644
>>>>> --- a/kernel/cgroup/freezer.c
>>>>> +++ b/kernel/cgroup/freezer.c
>>>>> @@ -162,10 +162,14 @@ static void cgroup_freeze_task(struct task_struct *task, bool freeze)
>>>>>   	if (freeze) {
>>>>>   		task->jobctl |= JOBCTL_TRAP_FREEZE;
>>>>> -		signal_wake_up(task, false);
>>>>> +
>>>>> +		if (sigisemptyset(&task->real_blocked))
>>>>> +			signal_wake_up(task, false);
>>>
>>> This can't really help, ->real_blocked can be empty even if this task
>>> sleeps in sigwaitinfo().
>>>
>>
>> Sorry, I'm not quit clear about the 'sleep'. sigwaitinfo() sets
>> ->real_blocked in do_sigtimedwait() and it goes to
>> freezable_schedule_hrtimeout_range() soon. After the task is woke up,
>> ->real_blocked is cleared. Seems there is no chance to set ->real_blocked to
>> empty in this path. Do I miss something important here? Please correct me.
> 
> Hmm. do_sigtimedwait() does
> 
> 	tsk->real_blocked = tsk->blocked;
> 
> Now, if tsk->blocked was empty (sigisemptyset() == T), then why do you think
> the sigisemptyset(real_blocked) check in cgroup_freeze_task() won't be true?
> 
> 
> But in fact this doesn't really matter. This patch is wrong in any case.
> sigwaitinfo() must not block cgroup freezer.
> 
> Oleg.
> 
