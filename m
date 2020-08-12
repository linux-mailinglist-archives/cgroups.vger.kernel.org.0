Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA7B24292E
	for <lists+cgroups@lfdr.de>; Wed, 12 Aug 2020 14:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbgHLMQp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 12 Aug 2020 08:16:45 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:39239 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726829AbgHLMQp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 12 Aug 2020 08:16:45 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R751e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07484;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0U5ZBL.H_1597234598;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U5ZBL.H_1597234598)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 12 Aug 2020 20:16:39 +0800
Subject: Re: [PATCH v17 14/21] mm/compaction: do page isolation first in
 compaction
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tejun Heo <tj@kernel.org>, Hugh Dickins <hughd@google.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        kbuild test robot <lkp@intel.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, cgroups@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Rong Chen <rong.a.chen@intel.com>
References: <1595681998-19193-1-git-send-email-alex.shi@linux.alibaba.com>
 <1595681998-19193-15-git-send-email-alex.shi@linux.alibaba.com>
 <CAKgT0UcbBv=QBK9ErqLKXoNLYxFz52L4fiiHy4h6zKdBs=YPOg@mail.gmail.com>
 <241ca157-104f-4f0d-7d5b-de394443788d@linux.alibaba.com>
 <CAKgT0UdSrarC8j+G=LYRSadcaG6yNCoCfeVpFjEiHRJb4A77-g@mail.gmail.com>
 <8dbd004e-8eba-f1ec-a5eb-5dc551978936@linux.alibaba.com>
 <CAKgT0UdK-fy+yYGLFK=YgE+maa_0_uecq0_8S_0kM8BiVgRO7g@mail.gmail.com>
 <d9818e06-95f1-9f21-05c0-98f29ea96d89@linux.alibaba.com>
 <CAKgT0Ues0ShkSbb1XtA7z7EYB8NCPgLGq8zZUjrXK_jcWn8mDQ@mail.gmail.com>
 <9581db48-cef3-788a-7f5a-8548fee56c13@linux.alibaba.com>
Message-ID: <51249892-632b-4aaf-1f66-3bc0d5c5cbab@linux.alibaba.com>
Date:   Wed, 12 Aug 2020 20:16:06 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <9581db48-cef3-788a-7f5a-8548fee56c13@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



在 2020/8/12 下午7:43, Alex Shi 写道:
>>> Sorry, I still can not follow you here. Compound code part is unchanged
>>> and follow the original logical. So would you like to pose a new code to
>>> see if its works?
>> No there are significant changes as you reordered all of the
>> operations. Prior to your change the LRU bit was checked, but not
>> cleared before testing for PageCompound. Now you are clearing it
>> before you are testing if it is a compound page. So if compaction is
>> running we will be seeing the pages in the LRU stay put, but the
>> compound bit flickering off and on if the compound page is encountered
>> with the wrong or NULL lruvec. What I was suggesting is that the

> The lruvec could be wrong or NULL here, that is the base stone of whole
> patchset.
> 
Sorry for typo. s/could/could not/
