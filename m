Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76239102195
	for <lists+cgroups@lfdr.de>; Tue, 19 Nov 2019 11:05:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725280AbfKSKFs (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 19 Nov 2019 05:05:48 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:46365 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725798AbfKSKFs (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 19 Nov 2019 05:05:48 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0TiY4-pZ_1574157939;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TiY4-pZ_1574157939)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 19 Nov 2019 18:05:40 +0800
Subject: Re: [PATCH v3 1/7] mm/lru: add per lruvec lock for memcg
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tejun Heo <tj@kernel.org>, Hugh Dickins <hughd@google.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Arun KS <arunks@codeaurora.org>
References: <1573874106-23802-1-git-send-email-alex.shi@linux.alibaba.com>
 <1573874106-23802-2-git-send-email-alex.shi@linux.alibaba.com>
 <CALvZod77568+TozRXpERDDap__jbj+oJBY8zD=UBd40XNJC2zg@mail.gmail.com>
 <e707fd66-16c2-8523-dd8b-860b5b6bb11d@linux.alibaba.com>
 <20191118120815.GF20752@bombadil.infradead.org>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <9bfbd4f0-3502-7186-34ad-d302bb526fc7@linux.alibaba.com>
Date:   Tue, 19 Nov 2019 18:05:39 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191118120815.GF20752@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



在 2019/11/18 下午8:08, Matthew Wilcox 写道:
>> Thanks for comment, Shakeel!
>>
>> Yes, but considering the 3rd, huge and un-splitable patch of actully replacing, I'd rather to pull sth out from 
>> it. Ty to make patches a bit more readable, Do you think so?
> This method of splitting the patches doesn't help with the reviewability of
> the patch series.

thanks for comments! I will reorg my patchset for better understanding.

Alex
