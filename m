Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D747D23B6E4
	for <lists+cgroups@lfdr.de>; Tue,  4 Aug 2020 10:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729932AbgHDIh5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 4 Aug 2020 04:37:57 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:46676 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726058AbgHDIh5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 4 Aug 2020 04:37:57 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R601e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0U4jk5H4_1596530273;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U4jk5H4_1596530273)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 04 Aug 2020 16:37:54 +0800
Subject: Re: [PATCH v17 00/21] per memcg lru lock
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, yang.shi@linux.alibaba.com,
        willy@infradead.org, hannes@cmpxchg.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com,
        kirill@shutemov.name, alexander.duyck@gmail.com,
        rong.a.chen@intel.com, Vladimir Davydov <vdavydov.dev@gmail.com>,
        Michal Hocko <mhocko@kernel.org>
References: <1595681998-19193-1-git-send-email-alex.shi@linux.alibaba.com>
Message-ID: <7c4395f3-56c0-c2ed-67fc-43e1f5f0c3eb@linux.alibaba.com>
Date:   Tue, 4 Aug 2020 16:37:37 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1595681998-19193-1-git-send-email-alex.shi@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From e2918c8fa741442255a2f12659f95dae94fdfe5d Mon Sep 17 00:00:00 2001
From: Alex Shi <alex.shi@linux.alibaba.com>
Date: Tue, 4 Aug 2020 16:20:02 +0800
Subject: [PATCH 0/3] optimzing following per memcg lru_lock

The first 2 patches are code clean up. And the 3rd one is a lru_add optimize.


Alex Shi (3):
  mm/mlock: remove lru_lock on TestClearPageMlocked in munlock_vma_page
  mm/mlock: remove __munlock_isolate_lru_page
  mm/swap.c: optimizing __pagevec_lru_add lru_lock

 mm/mlock.c | 63 +++++++++++++++++++-------------------------------------------
 mm/swap.c  | 57 ++++++++++++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 70 insertions(+), 50 deletions(-)

-- 
1.8.3.1

