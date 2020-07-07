Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC0D216AC8
	for <lists+cgroups@lfdr.de>; Tue,  7 Jul 2020 12:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgGGKwL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 7 Jul 2020 06:52:11 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:47357 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725941AbgGGKwL (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 7 Jul 2020 06:52:11 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R451e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04397;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0U20Cnyd_1594119126;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U20Cnyd_1594119126)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 07 Jul 2020 18:52:06 +0800
Subject: Re: [PATCH v14 07/20] mm/thp: narrow lru locking
To:     Matthew Wilcox <willy@infradead.org>
Cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, yang.shi@linux.alibaba.com,
        hannes@cmpxchg.org, lkp@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        shakeelb@google.com, iamjoonsoo.kim@lge.com,
        richard.weiyang@gmail.com
References: <1593752873-4493-1-git-send-email-alex.shi@linux.alibaba.com>
 <1593752873-4493-8-git-send-email-alex.shi@linux.alibaba.com>
 <124eeef1-ff2b-609e-3bf6-a118100c3f2a@linux.alibaba.com>
 <20200706113513.GY25523@casper.infradead.org>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <f52e101c-53a7-6342-a92b-fe12259054e6@linux.alibaba.com>
Date:   Tue, 7 Jul 2020 18:51:36 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200706113513.GY25523@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



在 2020/7/6 下午7:35, Matthew Wilcox 写道:
>> Would you like to give some comments or share your concern of this patchset,
>> specialy for THP part? 
> I don't have the brain space to understand this patch set fully at
> the moment.  I'll note that the realtime folks are doing their best to
> stamp out users of local_irq_disable(), so they won't be pleased to see
> you adding a new one.  Also, you removed the comment explaining why the
> lock needed to be taken.
> 

Hi Matthew,

Thanks for response!

As to the local_irq_disable(), we could use local_irq_save(), but Hugh Dickin
suggest it's not necessary here. Also there are still much local_irq_disable()
in code. Hope it would be a big trouble for only one extra.

yes, The lru_lock comments is a bit early to remove, that should do in next 
TestClearPageLRU part. but since it would be changed soon. It won't be a critical
thing. Anyway I can change it to back in next version.

Thanks
Alex
