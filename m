Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB9021A1AB
	for <lists+cgroups@lfdr.de>; Thu,  9 Jul 2020 16:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgGIOCu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 9 Jul 2020 10:02:50 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:58294 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726353AbgGIOCu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 9 Jul 2020 10:02:50 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01422;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0U2DIjfz_1594303364;
Received: from IT-FVFX43SYHV2H.lan(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U2DIjfz_1594303364)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 09 Jul 2020 22:02:45 +0800
Subject: Re: [PATCH v14 07/20] mm/thp: narrow lru locking
To:     Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, yang.shi@linux.alibaba.com,
        lkp@intel.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com
References: <1593752873-4493-1-git-send-email-alex.shi@linux.alibaba.com>
 <1593752873-4493-8-git-send-email-alex.shi@linux.alibaba.com>
 <124eeef1-ff2b-609e-3bf6-a118100c3f2a@linux.alibaba.com>
 <20200706113513.GY25523@casper.infradead.org>
 <alpine.LSU.2.11.2007062059420.2793@eggly.anvils>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <7bbefd02-9411-1fe2-773d-ac68d67d35f7@linux.alibaba.com>
Date:   Thu, 9 Jul 2020 22:02:07 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.11.2007062059420.2793@eggly.anvils>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



在 2020/7/7 下午12:52, Hugh Dickins 写道:
> My vote, for dispatch of the series, is to leave this patch in;
> but cannot object if consensus were that it should be taken out.

hi Johannes & Kirill,

What's your comments for this patch or others? I am ok to withdraw
this patch if no one like to give more comments on this.

Thanks
Alex
