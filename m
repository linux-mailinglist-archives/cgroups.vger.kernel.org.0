Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A427626D14C
	for <lists+cgroups@lfdr.de>; Thu, 17 Sep 2020 04:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbgIQCjn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 16 Sep 2020 22:39:43 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:35878 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726040AbgIQCjm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 16 Sep 2020 22:39:42 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=24;SR=0;TI=SMTPD_---0U9ANYuN_1600310363;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U9ANYuN_1600310363)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 17 Sep 2020 10:39:27 +0800
Subject: Re: [PATCH v18 00/32] per memcg lru_lock: reviews
To:     Daniel Jordan <daniel.m.jordan@oracle.com>,
        Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        mgorman@techsingularity.net, tj@kernel.org,
        khlebnikov@yandex-team.ru, willy@infradead.org, hannes@cmpxchg.org,
        lkp@intel.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com,
        kirill@shutemov.name, alexander.duyck@gmail.com,
        rong.a.chen@intel.com, mhocko@suse.com, vdavydov.dev@gmail.com,
        shy828301@gmail.com, vbabka@suse.cz, minchan@kernel.org, cai@lca.pw
References: <20200824114204.cc796ca182db95809dd70a47@linux-foundation.org>
 <alpine.LSU.2.11.2008241231460.1065@eggly.anvils>
 <alpine.LSU.2.11.2008262301240.4405@eggly.anvils>
 <alpine.LSU.2.11.2009081640070.7256@eggly.anvils>
 <61a42a87-eec9-e300-f710-992756f70de6@linux.alibaba.com>
 <alpine.LSU.2.11.2009091524260.10087@eggly.anvils>
 <855ad6ee-dba4-9729-78bd-23e392905cf6@linux.alibaba.com>
 <alpine.LSU.2.11.2009111634020.22739@eggly.anvils>
 <5cfc6142-752d-26e6-0108-38d13009268b@linux.alibaba.com>
 <alpine.LSU.2.11.2009150112130.1550@eggly.anvils>
 <20200915165807.kpp7uhiw7l3loofu@ca-dmjordan1.us.oracle.com>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <c3362c0a-3707-3a3d-9955-960d95f3ad8c@linux.alibaba.com>
Date:   Thu, 17 Sep 2020 10:37:45 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200915165807.kpp7uhiw7l3loofu@ca-dmjordan1.us.oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



在 2020/9/16 上午12:58, Daniel Jordan 写道:
> On Tue, Sep 15, 2020 at 01:21:56AM -0700, Hugh Dickins wrote:
>> On Sun, 13 Sep 2020, Alex Shi wrote:
>>> Uh, I updated the testing with some new results here:
>>> https://lkml.org/lkml/2020/8/26/212
>> Right, I missed that, that's better, thanks.  Any other test results?
> Alex, you were doing some will-it-scale runs earlier.  Are you planning to do
> more of those?  Otherwise I can add them in.

Hi Daniel,

Does compaction perf scalable, like thpscale, I except they could get some benefit.

Thanks
Alex
