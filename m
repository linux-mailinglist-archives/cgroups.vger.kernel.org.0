Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B24951FF23
	for <lists+cgroups@lfdr.de>; Thu, 16 May 2019 07:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbfEPFya (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 16 May 2019 01:54:30 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:36397 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726277AbfEPFya (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 16 May 2019 01:54:30 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04391;MF=zhangliguang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0TRt6yLM_1557986065;
Received: from 30.5.117.67(mailfrom:zhangliguang@linux.alibaba.com fp:SMTPD_---0TRt6yLM_1557986065)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 16 May 2019 13:54:25 +0800
Subject: Re: [PATCH] fs/writeback: Attach inode's wb to root if needed
To:     Dennis Zhou <dennis@kernel.org>
Cc:     Tejun Heo <tj@kernel.org>, akpm@linux-foundation.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org
References: <1557389033-39649-1-git-send-email-zhangliguang@linux.alibaba.com>
 <20190509164802.GV374014@devbig004.ftw2.facebook.com>
 <a5bb3773-fef5-ce2b-33b9-18e0d49c33c4@linux.alibaba.com>
 <20190513183053.GA73423@dennisz-mbp>
From:   =?UTF-8?B?5Lmx55+z?= <zhangliguang@linux.alibaba.com>
Message-ID: <4ebf1f8e-0f77-37df-da32-037384643527@linux.alibaba.com>
Date:   Thu, 16 May 2019 13:54:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190513183053.GA73423@dennisz-mbp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Dennis,

Sorry for the later reply. Becase I cann't reproduce this problem by 
local test,

and online environment is not allowed to operate, I am constructing 
scenario

to reproduce it in recent days.


在 2019/5/14 2:30, Dennis Zhou 写道:
> Hi Liguang,
>
> On Fri, May 10, 2019 at 09:54:27AM +0800, 乱石 wrote:
>> Hi Tejun,
>>
>> 在 2019/5/10 0:48, Tejun Heo 写道:
>>> Hi Tejun,
>>>
>>> On Thu, May 09, 2019 at 04:03:53PM +0800, zhangliguang wrote:
>>>> There might have tons of files queued in the writeback, awaiting for
>>>> writing back. Unfortunately, the writeback's cgroup has been dead. In
>>>> this case, we reassociate the inode with another writeback cgroup, but
>>>> we possibly can't because the writeback associated with the dead cgroup
>>>> is the only valid one. In this case, the new writeback is allocated,
>>>> initialized and associated with the inode. It causes unnecessary high
>>>> system load and latency.
>>>>
>>>> This fixes the issue by enforce moving the inode to root cgroup when the
>>>> previous binding cgroup becomes dead. With it, no more unnecessary
>>>> writebacks are created, populated and the system load decreased by about
>>>> 6x in the online service we encounted:
>>>>       Without the patch: about 30% system load
>>>>       With the patch:    about  5% system load
>>> Can you please describe the scenario with more details?  I'm having a
>>> bit of hard time understanding the amount of cpu cycles being
>>> consumed.
>>>
>>> Thanks.
>> Our search line reported a problem, when containerA was removed,
>> containerB and containerC's system load were up to 30%.
>>
>> We record the trace with 'perf record cycles:k -g -a', found that wb_init
>> was the hotspot function.
>>
>> Function call:
>>
>> generic_file_direct_write
>>     filemap_write_and_wait_range
>>        __filemap_fdatawrite_range
>>           wbc_attach_fdatawrite_inode
>>              inode_attach_wb
>>                 __inode_attach_wb
>>                    wb_get_create
>>              wbc_attach_and_unlock_inode
>>                 if (unlikely(wb_dying(wbc->wb)))
>>                    inode_switch_wbs
>>                       wb_get_create
>>                          ; Search bdi->cgwb_tree from memcg_css->id
>>                          ; OR cgwb_create
>>                             kmalloc
>>                             wb_init       // hot spot
>>                             ; Insert to bdi->cgwb_tree, mmecg_css->id as key
>>
>> We discussed it through, base on the analysis:  When we running into the
>> issue, there is cgroups are being deleted. The inodes (files) that were
>> associated with these cgroups have to switch into another newly created
>> writeback. We think there are huge amount of inodes in the writeback list
>> that time. So we don't think there is anything abnormal. However, one
>> thing we possibly can do: enforce these inodes to BDI embedded wirteback
>> and we needn't create huge amount of writebacks in that case, to avoid
>> the high system load phenomenon. We expect correct wb (best candidate) is
>> picked up in next round.
>>
>> Thanks,
>> Liguang
>>
> If I understand correctly, this is mostlikely caused by a file shared by
> cgroup A and cgroup B. This means cgroup B is doing direct io against
> the file owned by the dying cgroup A. In this case, the code tries to do
> a wb switch. However, it fails to reallocate the wb as it's deleted and
> for the original cgrouip A's memcg id.
>
> I think the below may be a better solution. Could you please test it? If
> it works, I'll spin a patch with a more involved description.
>
> Thanks,
> Dennis
>
> ---
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 36855c1f8daf..fb331ea2a626 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -577,7 +577,7 @@ void wbc_attach_and_unlock_inode(struct writeback_control *wbc,
>   	 * A dying wb indicates that the memcg-blkcg mapping has changed
>   	 * and a new wb is already serving the memcg.  Switch immediately.
>   	 */
> -	if (unlikely(wb_dying(wbc->wb)))
> +	if (unlikely(wb_dying(wbc->wb)) && !css_is_dying(wbc->wb->memcg_css))
>   		inode_switch_wbs(inode, wbc->wb_id);
>   }
>   
> diff --git a/mm/backing-dev.c b/mm/backing-dev.c
> index 72e6d0c55cfa..685563ed9788 100644
> --- a/mm/backing-dev.c
> +++ b/mm/backing-dev.c
> @@ -659,7 +659,7 @@ struct bdi_writeback *wb_get_create(struct backing_dev_info *bdi,
>   
>   	might_sleep_if(gfpflags_allow_blocking(gfp));
>   
> -	if (!memcg_css->parent)
> +	if (!memcg_css->parent || css_is_dying(memcg_css))
>   		return &bdi->wb;
>   
>   	do {
