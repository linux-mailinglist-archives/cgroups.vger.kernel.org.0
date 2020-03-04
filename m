Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEA18178D92
	for <lists+cgroups@lfdr.de>; Wed,  4 Mar 2020 10:37:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729131AbgCDJhk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 4 Mar 2020 04:37:40 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:48469 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729112AbgCDJhk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 4 Mar 2020 04:37:40 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04452;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0TrdAbQ3_1583314652;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TrdAbQ3_1583314652)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 04 Mar 2020 17:37:32 +0800
Subject: Re: [PATCH v9 07/20] mm/lru: introduce TestClearPageLRU
To:     Rong Chen <rong.a.chen@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, cgroups@vger.kernel.org,
        mgorman@techsingularity.net, tj@kernel.org, hughd@google.com,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        yang.shi@linux.alibaba.com, willy@infradead.org,
        hannes@cmpxchg.org, lkp@intel.com,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <1583146830-169516-1-git-send-email-alex.shi@linux.alibaba.com>
 <1583146830-169516-8-git-send-email-alex.shi@linux.alibaba.com>
 <20200302141144.b30abe0d89306fd387e13a92@linux-foundation.org>
 <9cacdc21-9c1f-2a17-05cb-e9cf2959cef5@linux.alibaba.com>
 <20200303164659.b3a30ab9d68c9ed82299a29c@linux-foundation.org>
 <6d155f79-8ba2-b322-4e92-311e7be98f79@linux.alibaba.com>
 <20200304090301.GB5972@shao2-debian>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <60d253bb-33d0-4328-bfde-3b7c26435cde@linux.alibaba.com>
Date:   Wed, 4 Mar 2020 17:37:31 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200304090301.GB5972@shao2-debian>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



在 2020/3/4 下午5:03, Rong Chen 写道:
>> Hi Andrew,
>>
>> Thanks a lot for comments!
>> Yes, this patch is essential for all next.
>>
>> Consider the normal memory testing would focus on user page, that probabably with PageLRU. 
>>
>> Fengguang's vm-scalibicase-small-allocs which used a lots vm_area_struct slab, which may
>> got some impact. 0day/Cheng Rong is working on the test. In my roughly testing, it may drop 5% on my
>> 96threads/394GB machine.
>>
>> Thanks
>> Alex
> Hi,
> 
> We only tested one case and found a slight regression of vm-scalability.median from this patch set:
> 
> Test case: small allocs
> =========================================================================================
> compiler/cpufreq_governor/kconfig/rootfs/runtime/tbox_group/test/testcase/ucode:
>   gcc-7/performance/x86_64-rhel-7.6/debian-x86_64-20191114.cgz/300s/lkp-ivb-d02/small-allocs/vm-scalability/0x21

It's a very acceptable result!

Thanks a lot for so quick testing! I believe your results would be far more stable than me. :)

(My testing show quit different result in 2 reboot(1.3% or 6.6% drop). Maybe sth wrong for me in this case.)

Thanks for your report!
Alex
