Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A62EC273958
	for <lists+cgroups@lfdr.de>; Tue, 22 Sep 2020 05:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbgIVDke (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 21 Sep 2020 23:40:34 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:60877 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726467AbgIVDke (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 21 Sep 2020 23:40:34 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0U9jwaHs_1600746028;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U9jwaHs_1600746028)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 22 Sep 2020 11:40:31 +0800
Subject: Re: [PATCH v18 15/32] mm/lru: move lock into lru_note_cost
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
 <1598273705-69124-16-git-send-email-alex.shi@linux.alibaba.com>
 <alpine.LSU.2.11.2009211434490.5214@eggly.anvils>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <dfc21f50-998f-a9b7-4ab9-3598c32d7e49@linux.alibaba.com>
Date:   Tue, 22 Sep 2020 11:38:22 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.11.2009211434490.5214@eggly.anvils>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



ÔÚ 2020/9/22 ÉÏÎç5:36, Hugh Dickins Ð´µÀ:
> 
>> We have to move lru_lock into lru_note_cost, since it cycle up on memcg
>> tree, for future per lruvec lru_lock replace. It's a bit ugly and may
>> cost a bit more locking, but benefit from multiple memcg locking could
>> cover the lost.
>>
>> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Acked-by: Hugh Dickins <hughd@google.com>

Thanks!

