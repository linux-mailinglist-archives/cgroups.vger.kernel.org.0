Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C749F1AECC2
	for <lists+cgroups@lfdr.de>; Sat, 18 Apr 2020 15:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725873AbgDRNpb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 18 Apr 2020 09:45:31 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:47766 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725879AbgDRNpb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 18 Apr 2020 09:45:31 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01355;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0TvvSI1O_1587217526;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TvvSI1O_1587217526)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 18 Apr 2020 21:45:26 +0800
Subject: Re: [PATCH 1/2] memcg: folding CONFIG_MEMCG_SWAP as default
To:     Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>
References: <1587134624-184860-1-git-send-email-alex.shi@linux.alibaba.com>
 <20200417155317.GS26707@dhcp22.suse.cz>
 <CALvZod7Xa4Xs=7zC8OZ7GOfvfDBv+yNbGCzBxeoMgAeRGRtw0A@mail.gmail.com>
 <20200417165442.GT26707@dhcp22.suse.cz>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <caa13db1-3094-0aae-bfb9-c3534949fa21@linux.alibaba.com>
Date:   Sat, 18 Apr 2020 21:44:32 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200417165442.GT26707@dhcp22.suse.cz>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



ÔÚ 2020/4/18 ÉÏÎç12:54, Michal Hocko Ð´µÀ:
> On Fri 17-04-20 09:41:04, Shakeel Butt wrote:
>> On Fri, Apr 17, 2020 at 9:03 AM Michal Hocko <mhocko@kernel.org> wrote:
>>>
>>> On Fri 17-04-20 22:43:43, Alex Shi wrote:
>>>> This patch fold MEMCG_SWAP feature into kernel as default function. That
>>>> required a short size memcg id for each of page. As Johannes mentioned
>>>>
>>>> "the overhead of tracking is tiny - 512k per G of swap (0.04%).'
>>>>
>>>> So all swapout page could be tracked for its memcg id.
>>>
>>> I am perfectly OK with dropping the CONFIG_MEMCG_SWAP. The code that is
>>> guarded by it is negligible and the resulting code is much easier to
>>> read so no objection on that front. I just do not really see any real
>>> reason to flip the default for cgroup v1. Why do we want/need that?
>>>
>>
>> Yes, the changelog is lacking the motivation of this change. This is
>> proposed by Johannes and I was actually expecting the patch from him.
>> The motivation is to make the things simpler for per-memcg LRU locking
>> and workingset for anon memory (Johannes has described these really
>> well, lemme find the email). If we keep the differentiation between
>> cgroup v1 and v2, then there is actually no point of this cleanup as
>> per-memcg LRU locking and anon workingset still has to handle the
>> !do_swap_account case.
> 
> All those details really have to go into the changelog. I have to say
> that I still do not understand why the actual accounting swap or not
> makes any difference for per per-memcg LRU. Especially when your patch
> keeps the kernel command line parameter still in place.
> 
> Anyway, it would be much more simpler to have a patch that drops the
> CONFIG_MEMCG_SWAP and a separate one which switches the default
> beahvior. I am not saying I am ok with the later but if the
> justification is convincing then I might change my mind.
> 

Hi Shakeel & Michal,

Thanks for all comments!

Yes, we still need to remove swapaccount from cmdline and keep swap_cgroup.id
permanently. Just I don't know if this patch could fit into the details of 
Johannes new solution.

Anyway, I will send out v2 for complete memcg id record patch, just in case
if they are useful.

Thanks
Alex
