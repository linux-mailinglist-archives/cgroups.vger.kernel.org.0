Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B397C992B1
	for <lists+cgroups@lfdr.de>; Thu, 22 Aug 2019 13:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732921AbfHVL5D (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 22 Aug 2019 07:57:03 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:34132 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731156AbfHVL5C (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 22 Aug 2019 07:57:02 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0Ta8EzwU_1566475019;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0Ta8EzwU_1566475019)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 22 Aug 2019 19:56:59 +0800
Subject: Re: [PATCH 00/14] per memcg lru_lock
To:     Daniel Jordan <daniel.m.jordan@oracle.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@kernel.org>
References: <1566294517-86418-1-git-send-email-alex.shi@linux.alibaba.com>
 <6ba1ffb0-fce0-c590-c373-7cbc516dbebd@oracle.com>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <348495d2-b558-fdfd-a411-89c75d4a9c78@linux.alibaba.com>
Date:   Thu, 22 Aug 2019 19:56:59 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <6ba1ffb0-fce0-c590-c373-7cbc516dbebd@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



在 2019/8/22 上午2:00, Daniel Jordan 写道:
>>
> 
> This is system-wide right, not per container?  Even per container, 89 usec isn't much contention over 20 seconds.  You may want to give this a try:

yes, perf lock show the host info.
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/wfg/vm-scalability.git/tree/case-lru-file-readtwice> 
> It's also synthetic but it stresses lru_lock more than just anon alloc/free.  It hits the page activate path, which is where we see this lock in our database, and if enough memory is configured lru_lock also gets stressed during reclaim, similar to [1].

Thanks for the sharing, this patchset can not help the [1] case, since it's just relief the per container lock contention now. Yes, readtwice case could be more sensitive for this lru_lock changes in containers. I may try to use it in container with some tuning. But anyway, aim9 is also pretty good to show the problem and solutions. :)
> 
> It'd be better though, as Michal suggests, to use the real workload that's causing problems.  Where are you seeing contention?

We repeatly create or delete a lot of different containers according to servers load/usage, so normal workload could cause lots of pages alloc/remove. aim9 could reflect part of scenarios. I don't know the DB scenario yet.

> 
>> With this patch series, lruvec->lru_lock show no contentions
>>          &(&lruvec->lru_l...          8          0               0       0               0               0
>>
>> and aim9 page_test/brk_test performance increased 5%~50%.
> 
> Where does the 50% number come in?  The numbers below seem to only show ~4% boost.

the Setddev/CoeffVar case has about 50% performance increase. one of container's mmtests result as following:

Stddev    page_test      245.15 (   0.00%)      189.29 (  22.79%)
Stddev    brk_test      1258.60 (   0.00%)      629.16 (  50.01%)
CoeffVar  page_test        0.71 (   0.00%)        0.53 (  26.05%)
CoeffVar  brk_test         1.32 (   0.00%)        0.64 (  51.14%)

