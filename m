Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B99E8274EC3
	for <lists+cgroups@lfdr.de>; Wed, 23 Sep 2020 03:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbgIWB6G (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 22 Sep 2020 21:58:06 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:45817 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726548AbgIWB6G (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 22 Sep 2020 21:58:06 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0U9oxump_1600826281;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U9oxump_1600826281)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 23 Sep 2020 09:58:02 +0800
Subject: Re: [PATCH v18 24/32] mm/pgdat: remove pgdat lru_lock
To:     Hugh Dickins <hughd@google.com>
Cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, willy@infradead.org,
        hannes@cmpxchg.org, lkp@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        shakeelb@google.com, iamjoonsoo.kim@lge.com,
        richard.weiyang@gmail.com, kirill@shutemov.name,
        alexander.duyck@gmail.com, rong.a.chen@intel.com, mhocko@suse.com,
        vdavydov.dev@gmail.com, shy828301@gmail.com
References: <1598273705-69124-1-git-send-email-alex.shi@linux.alibaba.com>
 <1598273705-69124-25-git-send-email-alex.shi@linux.alibaba.com>
 <alpine.LSU.2.11.2009212248350.6434@eggly.anvils>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <8b6af431-b910-c06f-a4a7-1c383af1eceb@linux.alibaba.com>
Date:   Wed, 23 Sep 2020 09:55:52 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.11.2009212248350.6434@eggly.anvils>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



ÔÚ 2020/9/22 ÏÂÎç1:53, Hugh Dickins Ð´µÀ:
>> Now pgdat.lru_lock was replaced by lruvec lock. It's not used anymore.
>>
>> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
>> Reviewed-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> I don't take pleasure in spoiling your celebrations and ceremonies,
> but I strongly agree with AlexD that this should simply be merged
> into the big one, 20/32.  That can be ceremony enough.
> 

folded into that patch.
Thanks!
