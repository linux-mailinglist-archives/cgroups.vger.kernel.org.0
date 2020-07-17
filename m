Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4915C2232E3
	for <lists+cgroups@lfdr.de>; Fri, 17 Jul 2020 07:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbgGQFZ2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 17 Jul 2020 01:25:28 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:52663 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725811AbgGQFZ1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 17 Jul 2020 01:25:27 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04427;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0U2ysVL5_1594963521;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U2ysVL5_1594963521)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 17 Jul 2020 13:25:23 +0800
Subject: Re: [PATCH v16 00/22] per memcg lru_lock
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
        "Kirill A. Shutemov" <kirill@shutemov.name>
References: <1594429136-20002-1-git-send-email-alex.shi@linux.alibaba.com>
 <CAKgT0UcKVyTXQ=tGv_uMV+fSvoH_-cuG9zA_zhE+S8Ou11gt=w@mail.gmail.com>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <57c619e7-da7e-198e-3de8-530bf19b9450@linux.alibaba.com>
Date:   Fri, 17 Jul 2020 13:24:28 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAKgT0UcKVyTXQ=tGv_uMV+fSvoH_-cuG9zA_zhE+S8Ou11gt=w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



在 2020/7/16 下午10:11, Alexander Duyck 写道:
>> Thanks for Testing support from Intel 0day and Rong Chen, Fengguang Wu,
>> and Yun Wang. Hugh Dickins also shared his kbuild-swap case. Thanks!
> Hi Alex,
> 
> I think I am seeing a regression with this patch set when I run the
> will-it-scale/page_fault3 test. Specifically the processes result is
> dropping from 56371083 to 43127382 when I apply these patches.
> 
> I haven't had a chance to bisect and figure out what is causing it,
> and wanted to let you know in case you are aware of anything specific
> that may be causing this.


Thanks a lot for the info!

Actually, the patch 17th, and patch 13th may changed performance a little,
like the 17th, intel LKP found vm-scalability.throughput 68.0% improvement,
and stress-ng.remap.ops_per_sec -76.3% regression, or stress-ng.memfd.ops_per_sec
 +23.2%. etc.

This kind performance interference is known and acceptable.
Thanks
Alex
 
