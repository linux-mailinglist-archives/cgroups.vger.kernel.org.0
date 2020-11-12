Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2D22AFE7D
	for <lists+cgroups@lfdr.de>; Thu, 12 Nov 2020 06:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbgKLFic (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 12 Nov 2020 00:38:32 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:57356 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728329AbgKLDgP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 11 Nov 2020 22:36:15 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0UF1vPTE_1605152168;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UF1vPTE_1605152168)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 12 Nov 2020 11:36:09 +0800
Subject: Re: [PATCH v21 15/19] mm/compaction: do page isolation first in
 compaction
To:     Hugh Dickins <hughd@google.com>, Vlastimil Babka <vbabka@suse.cz>
Cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, willy@infradead.org,
        hannes@cmpxchg.org, lkp@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        shakeelb@google.com, iamjoonsoo.kim@lge.com,
        richard.weiyang@gmail.com, kirill@shutemov.name,
        alexander.duyck@gmail.com, rong.a.chen@intel.com, mhocko@suse.com,
        vdavydov.dev@gmail.com, shy828301@gmail.com
References: <1604566549-62481-1-git-send-email-alex.shi@linux.alibaba.com>
 <1604566549-62481-16-git-send-email-alex.shi@linux.alibaba.com>
 <a0b8c198-6bd0-2ccb-fe55-970895c26a0b@suse.cz>
 <alpine.LSU.2.11.2011111803580.2174@eggly.anvils>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <6d2d215e-fd72-b8cc-331f-189ea04a361d@linux.alibaba.com>
Date:   Thu, 12 Nov 2020 11:35:23 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.11.2011111803580.2174@eggly.anvils>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



ÔÚ 2020/11/12 ÉÏÎç10:28, Hugh Dickins Ð´µÀ:
>>>   			 * Page become compound since the non-locked check,
>>>   			 * and it's on LRU. It can only be a THP so the order
>>> @@ -990,16 +1002,13 @@ static bool too_many_isolated(pg_data_t *pgdat)
> Completely off-topic, and won't matter at all when Andrew rediffs into
> mmotm: but isn't it weird that this is showing "too_many_isolated(",
> when actually the function is isolate_migratepages_block()?
> 

My git version is too low for this. Thanks for reminder. the latest git
work fine on correct function name.

Thanks
