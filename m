Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75FEB9D17C
	for <lists+cgroups@lfdr.de>; Mon, 26 Aug 2019 16:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729144AbfHZORa (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 26 Aug 2019 10:17:30 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:50628 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729138AbfHZORa (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 26 Aug 2019 10:17:30 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07417;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0TaX0VPG_1566829040;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TaX0VPG_1566829040)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 26 Aug 2019 22:17:23 +0800
Subject: Re: [PATCH 03/14] lru/memcg: using per lruvec lock in
 un/lock_page_lru
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tejun Heo <tj@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Hugh Dickins <hughd@google.com>
References: <1566294517-86418-1-git-send-email-alex.shi@linux.alibaba.com>
 <1566294517-86418-4-git-send-email-alex.shi@linux.alibaba.com>
 <936eb865-d8da-8e53-3e2b-6858c586aa49@yandex-team.ru>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <bd44a613-d820-6085-0145-657078fd79cc@linux.alibaba.com>
Date:   Mon, 26 Aug 2019 22:16:58 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <936eb865-d8da-8e53-3e2b-6858c586aa49@yandex-team.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



在 2019/8/26 下午4:30, Konstantin Khlebnikov 写道:
>>
>>   
> 
> What protects lruvec from freeing at this point?
> After reading resolving lruvec page could be moved and cgroup deleted.
> 
> In this old patches I've used RCU for that: https://lkml.org/lkml/2012/2/20/276
> Pointer to lruvec should be resolved under disabled irq.
> Not sure this works these days.

Thanks for reminder! I will reconsider this point and come up with changes.

Thanks
Alex
