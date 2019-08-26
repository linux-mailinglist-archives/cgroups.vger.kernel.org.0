Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF139CBC2
	for <lists+cgroups@lfdr.de>; Mon, 26 Aug 2019 10:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729519AbfHZIjy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 26 Aug 2019 04:39:54 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:42262 "EHLO
        forwardcorp1j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729523AbfHZIjx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 26 Aug 2019 04:39:53 -0400
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net [IPv6:2a02:6b8:0:1619::119])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 3B9232E045B;
        Mon, 26 Aug 2019 11:39:51 +0300 (MSK)
Received: from smtpcorp1p.mail.yandex.net (smtpcorp1p.mail.yandex.net [2a02:6b8:0:1472:2741:0:8b6:10])
        by mxbackcorp2j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id kPAtGJAWjF-doPiv6Rx;
        Mon, 26 Aug 2019 11:39:51 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1566808791; bh=Y7ejts7lpiJhlX4+egWDk+iu4dJWOZ7po0kKT0OpMC4=;
        h=In-Reply-To:References:Date:Message-ID:From:To:Subject;
        b=ZVQN0C0X7bfLpqONhnIcbXCciPSnf0ZQe87EOzqxF7ubpJcjvtoTJmY+Jof+wIqia
         PEaE9w9ENQcqOpxatGvjD0TmDLw+9EItjqMz8obWXNyoLfUEk2Nq2/ckAr+NthoGs5
         cCPwE+ZAbNG9qfRqLLqgDRWz23KdHvzmNr8zZToU=
Authentication-Results: mxbackcorp2j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:f558:a2a9:365e:6e19])
        by smtpcorp1p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id n5aJDOHkZi-doBieEVh;
        Mon, 26 Aug 2019 11:39:50 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: Re: [PATCH 00/14] per memcg lru_lock
To:     Daniel Jordan <daniel.m.jordan@oracle.com>,
        Alex Shi <alex.shi@linux.alibaba.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>
References: <1566294517-86418-1-git-send-email-alex.shi@linux.alibaba.com>
 <6ba1ffb0-fce0-c590-c373-7cbc516dbebd@oracle.com>
 <348495d2-b558-fdfd-a411-89c75d4a9c78@linux.alibaba.com>
 <b776032e-eabb-64ff-8aee-acc2b3711717@oracle.com>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <d5256ebf-8314-8c24-a7ed-e170b7d39b61@yandex-team.ru>
Date:   Mon, 26 Aug 2019 11:39:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <b776032e-eabb-64ff-8aee-acc2b3711717@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 22/08/2019 18.20, Daniel Jordan wrote:
> On 8/22/19 7:56 AM, Alex Shi wrote:
>> 在 2019/8/22 上午2:00, Daniel Jordan 写道:
>>>    https://git.kernel.org/pub/scm/linux/kernel/git/wfg/vm-scalability.git/tree/case-lru-file-readtwice>
>>> It's also synthetic but it stresses lru_lock more than just anon alloc/free.  It hits the page activate path, which is where we see this 
>>> lock in our database, and if enough memory is configured lru_lock also gets stressed during reclaim, similar to [1].
>>
>> Thanks for the sharing, this patchset can not help the [1] case, since it's just relief the per container lock contention now.
> 
> I should've been clearer.  [1] is meant as an example of someone suffering from lru_lock during reclaim.  Wouldn't your series help 
> per-memcg reclaim?
> 
>> Yes, readtwice case could be more sensitive for this lru_lock changes in containers. I may try to use it in container with some tuning. 
>> But anyway, aim9 is also pretty good to show the problem and solutions. :)
>>>
>>> It'd be better though, as Michal suggests, to use the real workload that's causing problems.  Where are you seeing contention?
>>
>> We repeatly create or delete a lot of different containers according to servers load/usage, so normal workload could cause lots of pages 
>> alloc/remove. 
> 
> I think numbers from that scenario would help your case.
> 
>> aim9 could reflect part of scenarios. I don't know the DB scenario yet.
> 
> We see it during DB shutdown when each DB process frees its memory (zap_pte_range -> mark_page_accessed).  But that's a different thing, 
> clearly Not This Series.
> 
>>>> With this patch series, lruvec->lru_lock show no contentions
>>>>           &(&lruvec->lru_l...          8          0               0       0               0               0
>>>>
>>>> and aim9 page_test/brk_test performance increased 5%~50%.
>>>
>>> Where does the 50% number come in?  The numbers below seem to only show ~4% boost.
>>After splitting lru-locks present per-cpu page-vectors works no so well
because they mixes pages from different cgroups.

pagevec_lru_move_fn and friends need better implementation:
either sorting pages or splitting vectores in per-lruvec basis.
>> the Setddev/CoeffVar case has about 50% performance increase. one of container's mmtests result as following:
>>
>> Stddev    page_test      245.15 (   0.00%)      189.29 (  22.79%)
>> Stddev    brk_test      1258.60 (   0.00%)      629.16 (  50.01%)
>> CoeffVar  page_test        0.71 (   0.00%)        0.53 (  26.05%)
>> CoeffVar  brk_test         1.32 (   0.00%)        0.64 (  51.14%)
> 
> Aha.  50% decrease in stdev.
> 

After splitting lru-locks present per-cpu page-vectors works
no so well because they mix pages from different cgroups.

pagevec_lru_move_fn and friends need better implementation:
either sorting pages or splitting vectores in per-lruvec basis.
