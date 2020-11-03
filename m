Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2BF12A3AA6
	for <lists+cgroups@lfdr.de>; Tue,  3 Nov 2020 03:54:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgKCCyH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 2 Nov 2020 21:54:07 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:48735 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725997AbgKCCyG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 2 Nov 2020 21:54:06 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=23;SR=0;TI=SMTPD_---0UE2a1yR_1604372041;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UE2a1yR_1604372041)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 03 Nov 2020 10:54:02 +0800
Subject: Re: [PATCH v20 12/20] mm/vmscan: remove lruvec reget in
 move_pages_to_lru
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, willy@infradead.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com,
        kirill@shutemov.name, alexander.duyck@gmail.com,
        rong.a.chen@intel.com, mhocko@suse.com, vdavydov.dev@gmail.com,
        shy828301@gmail.com,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>
References: <1603968305-8026-1-git-send-email-alex.shi@linux.alibaba.com>
 <1603968305-8026-13-git-send-email-alex.shi@linux.alibaba.com>
 <20201102145220.GE724984@cmpxchg.org>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <3aa7469c-1400-5a21-fece-465db8f4e8ac@linux.alibaba.com>
Date:   Tue, 3 Nov 2020 10:51:27 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201102145220.GE724984@cmpxchg.org>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



ÔÚ 2020/11/2 ÏÂÎç10:52, Johannes Weiner Ð´µÀ:
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> 
> A brief comment in the code could be good: all pages were isolated
> from the same lruvec (and isolation inhibits memcg migration).

Yes, I will add the words both in code and commit log.

Thanks
