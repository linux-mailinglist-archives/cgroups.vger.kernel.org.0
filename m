Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42AF2250C2C
	for <lists+cgroups@lfdr.de>; Tue, 25 Aug 2020 01:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbgHXXQQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 24 Aug 2020 19:16:16 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:35313 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726090AbgHXXQQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 24 Aug 2020 19:16:16 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01355;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0U6mPOyb_1598310966;
Received: from IT-FVFX43SYHV2H.lan(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U6mPOyb_1598310966)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 25 Aug 2020 07:16:11 +0800
Subject: Re: [Resend PATCH 1/6] mm/memcg: warning on !memcg after readahead
 page charged
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Michal Hocko <mhocko@suse.com>
Cc:     Qian Cai <cai@lca.pw>, akpm@linux-foundation.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
References: <1597144232-11370-1-git-send-email-alex.shi@linux.alibaba.com>
 <20200820145850.GA4622@lca.pw> <20200824145201.GB4337@lca.pw>
 <20200824151045.GC3415@dhcp22.suse.cz>
 <20200825090054.3c5dd68a@canb.auug.org.au>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <3003ffb6-f527-ae33-60f2-50cd25316fdd@linux.alibaba.com>
Date:   Tue, 25 Aug 2020 07:14:39 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200825090054.3c5dd68a@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



在 2020/8/25 上午7:00, Stephen Rothwell 写道:
>>>> This will trigger,  
>>> Andrew, Stephen, can you drop this series for now? I did manage to trigger this
>>> warning on all arches, powerpc, x86 and arm64 (below).  
>> Yes, I do agree. See http://lkml.kernel.org/r/20200824151013.GB3415@dhcp22.suse.cz
> OK, I have removed the following from linux-next for today:
> 
>   c443db77c9f3 ("mm/thp: narrow lru locking")
>   18bafefba73d ("mm/thp: remove code path which never got into")
>   5fb6c0683017 ("mm/thp: clean up lru_add_page_tail")
>   9d1d568727a8 ("mm/thp: move lru_add_page_tail func to huge_memory.c")
>   47eb331560ff ("mm/memcg: bail out early from swap accounting when memcg is disabled")
>   4b0d99a64d78 ("mm/memcg: warning on !memcg after readahead page charged")

The first patch 4b0d99a64d78 ("mm/memcg: warning on !memcg after readahead page charged")
reveals the hugetlb out of lru on some unexpected path. At least comments are helpful.

All other are good and functional.

Thanks
Alex
