Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7E625191F
	for <lists+cgroups@lfdr.de>; Tue, 25 Aug 2020 15:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726095AbgHYNBs (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 25 Aug 2020 09:01:48 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:37244 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726024AbgHYNBs (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 25 Aug 2020 09:01:48 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01355;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0U6qR9GC_1598360501;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U6qR9GC_1598360501)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 25 Aug 2020 21:01:43 +0800
Subject: Re: [PATCH v18 00/32] per memcg lru_lock
From:   Alex Shi <alex.shi@linux.alibaba.com>
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
        shy828301@gmail.com
References: <1598273705-69124-1-git-send-email-alex.shi@linux.alibaba.com>
 <20200824114204.cc796ca182db95809dd70a47@linux-foundation.org>
 <alpine.LSU.2.11.2008241231460.1065@eggly.anvils>
 <20200825015627.3c3pnwauqznnp3gc@ca-dmjordan1.us.oracle.com>
 <4cc9f54a-9eda-9966-df9a-a00bc9e88f4c@linux.alibaba.com>
Message-ID: <d6127d13-0997-3f9d-3c35-1fe453fc6a12@linux.alibaba.com>
Date:   Tue, 25 Aug 2020 21:00:13 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <4cc9f54a-9eda-9966-df9a-a00bc9e88f4c@linux.alibaba.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



在 2020/8/25 下午4:52, Alex Shi 写道:
> 
> 在 2020/8/25 上午9:56, Daniel Jordan 写道:
>> On Mon, Aug 24, 2020 at 01:24:20PM -0700, Hugh Dickins wrote:
>>> On Mon, 24 Aug 2020, Andrew Morton wrote:
>>>> On Mon, 24 Aug 2020 20:54:33 +0800 Alex Shi <alex.shi@linux.alibaba.com> wrote:
>>> Andrew demurred on version 17 for lack of review.  Alexander Duyck has
>>> been doing a lot on that front since then.  I have intended to do so,
>>> but it's a mirage that moves away from me as I move towards it: I have
>> Same, I haven't been able to keep up with the versions or the recent review
>> feedback.  I got through about half of v17 last week and hope to have more time
>> for the rest this week and beyond.
>>
>>>>> Following Daniel Jordan's suggestion, I have run 208 'dd' with on 104
>>>>> containers on a 2s * 26cores * HT box with a modefied case:
>> Alex, do you have a pointer to the modified readtwice case?
>>
> Hi Daniel,
> 
> my readtwice modification like below.
> 
> diff --git a/case-lru-file-readtwice b/case-lru-file-readtwice

Hi Diniel,

I finally settle down my container, and found I give a different version of my scripts
which can't work out together. I am sorry!

I will try to bring them up together. and try to give a new version.

Thanks a lot!
Alex
