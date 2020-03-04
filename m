Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D880178B13
	for <lists+cgroups@lfdr.de>; Wed,  4 Mar 2020 08:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbgCDHHG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 4 Mar 2020 02:07:06 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:38063 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726860AbgCDHHG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 4 Mar 2020 02:07:06 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04396;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0TrcsTun_1583305608;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TrcsTun_1583305608)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 04 Mar 2020 15:06:48 +0800
Subject: Re: [PATCH v9 07/20] mm/lru: introduce TestClearPageLRU
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     cgroups@vger.kernel.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, yang.shi@linux.alibaba.com,
        willy@infradead.org, hannes@cmpxchg.org, lkp@intel.com,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Rong Chen <rong.a.chen@intel.com>
References: <1583146830-169516-1-git-send-email-alex.shi@linux.alibaba.com>
 <1583146830-169516-8-git-send-email-alex.shi@linux.alibaba.com>
 <20200302141144.b30abe0d89306fd387e13a92@linux-foundation.org>
 <9cacdc21-9c1f-2a17-05cb-e9cf2959cef5@linux.alibaba.com>
 <20200303164659.b3a30ab9d68c9ed82299a29c@linux-foundation.org>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <6d155f79-8ba2-b322-4e92-311e7be98f79@linux.alibaba.com>
Date:   Wed, 4 Mar 2020 15:06:48 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200303164659.b3a30ab9d68c9ed82299a29c@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



在 2020/3/4 上午8:46, Andrew Morton 写道:
> 
> Well, any difference would be small and the numbers did get a bit
> lower, albeit probably within the margin of error.
> 
> But you know, if someone were to send a patch which micro-optimized
> some code by replacing 'TestClearXXX()' with `if PageXXX()
> ClearPageXXX()', I would happily merge it!
> 
> Is this change essential to the overall patchset?  If not, I'd be
> inclined to skip it?
> 

Hi Andrew,

Thanks a lot for comments!
Yes, this patch is essential for all next.

Consider the normal memory testing would focus on user page, that probabably with PageLRU. 

Fengguang's vm-scalibicase-small-allocs which used a lots vm_area_struct slab, which may
got some impact. 0day/Cheng Rong is working on the test. In my roughly testing, it may drop 5% on my
96threads/394GB machine.

Thanks
Alex
