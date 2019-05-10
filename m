Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3164A1965F
	for <lists+cgroups@lfdr.de>; Fri, 10 May 2019 03:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfEJByf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 9 May 2019 21:54:35 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:40190 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726862AbfEJByf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 9 May 2019 21:54:35 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04391;MF=zhangliguang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0TRINaUb_1557453267;
Received: from 30.5.116.80(mailfrom:zhangliguang@linux.alibaba.com fp:SMTPD_---0TRINaUb_1557453267)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 10 May 2019 09:54:28 +0800
Subject: Re: [PATCH] fs/writeback: Attach inode's wb to root if needed
To:     Tejun Heo <tj@kernel.org>
Cc:     akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
References: <1557389033-39649-1-git-send-email-zhangliguang@linux.alibaba.com>
 <20190509164802.GV374014@devbig004.ftw2.facebook.com>
From:   =?UTF-8?B?5Lmx55+z?= <zhangliguang@linux.alibaba.com>
Message-ID: <a5bb3773-fef5-ce2b-33b9-18e0d49c33c4@linux.alibaba.com>
Date:   Fri, 10 May 2019 09:54:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190509164802.GV374014@devbig004.ftw2.facebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Tejun,

在 2019/5/10 0:48, Tejun Heo 写道:
> Hi Tejun,
>
> On Thu, May 09, 2019 at 04:03:53PM +0800, zhangliguang wrote:
>> There might have tons of files queued in the writeback, awaiting for
>> writing back. Unfortunately, the writeback's cgroup has been dead. In
>> this case, we reassociate the inode with another writeback cgroup, but
>> we possibly can't because the writeback associated with the dead cgroup
>> is the only valid one. In this case, the new writeback is allocated,
>> initialized and associated with the inode. It causes unnecessary high
>> system load and latency.
>>
>> This fixes the issue by enforce moving the inode to root cgroup when the
>> previous binding cgroup becomes dead. With it, no more unnecessary
>> writebacks are created, populated and the system load decreased by about
>> 6x in the online service we encounted:
>>      Without the patch: about 30% system load
>>      With the patch:    about  5% system load
> Can you please describe the scenario with more details?  I'm having a
> bit of hard time understanding the amount of cpu cycles being
> consumed.
>
> Thanks.

Our search line reported a problem, when containerA was removed,
containerB and containerC's system load were up to 30%.

We record the trace with 'perf record cycles:k -g -a', found that wb_init
was the hotspot function.

Function call:

generic_file_direct_write
    filemap_write_and_wait_range
       __filemap_fdatawrite_range
          wbc_attach_fdatawrite_inode
             inode_attach_wb
                __inode_attach_wb
                   wb_get_create
             wbc_attach_and_unlock_inode
                if (unlikely(wb_dying(wbc->wb)))
                   inode_switch_wbs
                      wb_get_create
                         ; Search bdi->cgwb_tree from memcg_css->id
                         ; OR cgwb_create
                            kmalloc
                            wb_init       // hot spot
                            ; Insert to bdi->cgwb_tree, mmecg_css->id as key

We discussed it through, base on the analysis:  When we running into the
issue, there is cgroups are being deleted. The inodes (files) that were
associated with these cgroups have to switch into another newly created
writeback. We think there are huge amount of inodes in the writeback list
that time. So we don't think there is anything abnormal. However, one
thing we possibly can do: enforce these inodes to BDI embedded wirteback
and we needn't create huge amount of writebacks in that case, to avoid
the high system load phenomenon. We expect correct wb (best candidate) is
picked up in next round.

Thanks,
Liguang

>
