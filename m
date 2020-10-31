Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B36152A1253
	for <lists+cgroups@lfdr.de>; Sat, 31 Oct 2020 02:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725800AbgJaBQZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 30 Oct 2020 21:16:25 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:39015 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725446AbgJaBQZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 30 Oct 2020 21:16:25 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0UDgVMke_1604106977;
Received: from IT-FVFX43SYHV2H.lan(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UDgVMke_1604106977)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 31 Oct 2020 09:16:18 +0800
Subject: Re: [PATCH v20 04/20] mm/thp: use head for head page in
 lru_add_page_tail
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, willy@infradead.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com,
        kirill@shutemov.name, alexander.duyck@gmail.com,
        rong.a.chen@intel.com, mhocko@suse.com, vdavydov.dev@gmail.com,
        shy828301@gmail.com
References: <1603968305-8026-1-git-send-email-alex.shi@linux.alibaba.com>
 <1603968305-8026-5-git-send-email-alex.shi@linux.alibaba.com>
 <20201029135047.GE599825@cmpxchg.org>
 <06a5b7d8-bbf2-51b7-1352-2b630186e15f@linux.alibaba.com>
 <20201030135218.GA666074@cmpxchg.org>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <8fcf24fc-30ed-1e95-2c50-4034404ab416@linux.alibaba.com>
Date:   Sat, 31 Oct 2020 09:14:05 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201030135218.GA666074@cmpxchg.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



在 2020/10/30 下午9:52, Johannes Weiner 写道:
> 
>> From a9ee63a213f40eb4d5a69b52fbb348ff9cd7cf6c Mon Sep 17 00:00:00 2001
>> From: Alex Shi <alex.shi@linux.alibaba.com>
>> Date: Tue, 26 May 2020 16:49:22 +0800
>> Subject: [PATCH v21 04/20] mm/thp: use head for head page in lru_add_page_tail
>>
>> Since the first parameter is only used by head page, it's better to make
>> it explicit.
>>
>> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
>> Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>> Acked-by: Hugh Dickins <hughd@google.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Johannes Weiner <hannes@cmpxchg.org>
>> Cc: Matthew Wilcox <willy@infradead.org>
>> Cc: Hugh Dickins <hughd@google.com>
>> Cc: linux-mm@kvack.org
>> Cc: linux-kernel@vger.kernel.org
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>


Thanks a lot!
Alex
