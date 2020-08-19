Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1D42497B6
	for <lists+cgroups@lfdr.de>; Wed, 19 Aug 2020 09:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbgHSHuS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 19 Aug 2020 03:50:18 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:41536 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726885AbgHSHt7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 19 Aug 2020 03:49:59 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R411e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0U6D8MDL_1597823393;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U6D8MDL_1597823393)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 19 Aug 2020 15:49:54 +0800
Subject: Re: [RFC PATCH v2 1/5] mm: Identify compound pages sooner in
 isolate_migratepages_block
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     yang.shi@linux.alibaba.com, lkp@intel.com, rong.a.chen@intel.com,
        khlebnikov@yandex-team.ru, kirill@shutemov.name, hughd@google.com,
        linux-kernel@vger.kernel.org, daniel.m.jordan@oracle.com,
        linux-mm@kvack.org, shakeelb@google.com, willy@infradead.org,
        hannes@cmpxchg.org, tj@kernel.org, cgroups@vger.kernel.org,
        akpm@linux-foundation.org, richard.weiyang@gmail.com,
        mgorman@techsingularity.net, iamjoonsoo.kim@lge.com
References: <20200819041852.23414.95939.stgit@localhost.localdomain>
 <20200819042705.23414.84098.stgit@localhost.localdomain>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <660b71b7-7e4f-758d-70c8-d938dded5837@linux.alibaba.com>
Date:   Wed, 19 Aug 2020 15:48:41 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200819042705.23414.84098.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



在 2020/8/19 下午12:27, Alexander Duyck 写道:
> In addition by testing for PageCompound sooner we can avoid having the LRU
> flag cleared and then reset in the exception case. As a result this should
> prevent possible races where another thread might be attempting to pull the
> LRU pages from the list.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>

Reviewed-by: Alex Shi <alex.shi@linux.alibaba.com>
