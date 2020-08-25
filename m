Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 636EA250E31
	for <lists+cgroups@lfdr.de>; Tue, 25 Aug 2020 03:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbgHYB0o (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 24 Aug 2020 21:26:44 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:34162 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726090AbgHYB0n (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 24 Aug 2020 21:26:43 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R261e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01355;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0U6n39Zm_1598318789;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U6n39Zm_1598318789)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 25 Aug 2020 09:26:31 +0800
Subject: Re: [Resend PATCH 1/6] mm/memcg: warning on !memcg after readahead
 page charged
To:     Michal Hocko <mhocko@suse.com>, Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, nao.horiguchi@gmail.com,
        osalvador@suse.de, mike.kravetz@oracle.com
References: <1597144232-11370-1-git-send-email-alex.shi@linux.alibaba.com>
 <20200820145850.GA4622@lca.pw> <20200821080127.GD32537@dhcp22.suse.cz>
 <20200821123934.GA4314@lca.pw> <20200821134842.GF32537@dhcp22.suse.cz>
 <20200824151013.GB3415@dhcp22.suse.cz>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <12425e06-38ce-7ff4-28ce-b0418353fc67@linux.alibaba.com>
Date:   Tue, 25 Aug 2020 09:25:01 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200824151013.GB3415@dhcp22.suse.cz>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

reproduce using our linux-mm random bug collection on NUMA systems.
>>
>> OK, I must have missed that this was on ppc. The order makes more sense
>> now. I will have a look at this next week.
> 
> OK, so I've had a look and I know what's going on there. The
> move_pages12 is migrating hugetlb pages. Those are not charged to any
> memcg. We have completely missed this case. There are two ways going
> around that. Drop the warning and update the comment so that we do not
> forget about that or special case hugetlb pages.
> 
> I think the first option is better.
> 


Hi Michal,

Compare to ignore the warning which is designed to give, seems addressing
the hugetlb out of charge issue is a better solution, otherwise the memcg
memory usage is out of control on hugetlb, is that right?

Thanks
Alex 
