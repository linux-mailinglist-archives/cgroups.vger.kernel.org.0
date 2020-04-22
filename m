Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FAB11B4671
	for <lists+cgroups@lfdr.de>; Wed, 22 Apr 2020 15:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725839AbgDVNob (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 22 Apr 2020 09:44:31 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:42954 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725787AbgDVNoa (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 22 Apr 2020 09:44:30 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R241e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01358;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0TwKj2lW_1587563066;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TwKj2lW_1587563066)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 22 Apr 2020 21:44:27 +0800
Subject: Re: [PATCH 15/18] mm: memcontrol: make swap tracking an integral part
 of memory control
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Joonsoo Kim <js1304@gmail.com>, Shakeel Butt <shakeelb@google.com>,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
References: <20200420221126.341272-1-hannes@cmpxchg.org>
 <20200420221126.341272-16-hannes@cmpxchg.org>
 <e9d58c82-d746-dcd0-d9e3-6322014a3b03@linux.alibaba.com>
 <20200421143923.GC341682@cmpxchg.org>
 <2721c508-9b32-d0e7-454d-386129bfda1b@linux.alibaba.com>
 <20200422133001.GE358439@cmpxchg.org>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <9fc87212-fb75-7512-41a3-79ee13fb7909@linux.alibaba.com>
Date:   Wed, 22 Apr 2020 21:43:13 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200422133001.GE358439@cmpxchg.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



在 2020/4/22 下午9:30, Johannes Weiner 写道:
>> Also as to the RSS account name change, I don't know if it's good to polish
>> them in docs.
> I didn't actually change anything user-visible, just the internal name
> of the counters:
> 
> static const unsigned int memcg1_stats[] = {
> 	NR_FILE_PAGES,		/* was MEMCG_CACHE */
> 	NR_ANON_MAPPED,		/* was MEMCG_RSS */
> 	NR_ANON_THPS,		/* was MEMCG_RSS_HUGE */
> 	NR_SHMEM,
> 	NR_FILE_MAPPED,
> 	NR_FILE_DIRTY,
> 	NR_WRITEBACK,
> 	MEMCG_SWAP,
> };
> 
> static const char *const memcg1_stat_names[] = {
> 	"cache",
> 	"rss",
> 	"rss_huge",
> 	"shmem",
> 	"mapped_file",
> 	"dirty",
> 	"writeback",
> 	"swap",
> };
> 
> Or did you refer to something else?

With about 'was MEMCG_RSS' etc. I believe curious user would know where
the concept from. :)

Thanks for this comments!
Aelx
