Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2181225AC6
	for <lists+cgroups@lfdr.de>; Mon, 20 Jul 2020 11:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgGTJFB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 20 Jul 2020 05:05:01 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:45371 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726030AbgGTJFB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 20 Jul 2020 05:05:01 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01422;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0U3FgSDJ_1595235887;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U3FgSDJ_1595235887)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 20 Jul 2020 17:04:48 +0800
Subject: Re: [PATCH v16 14/22] mm/thp: add tail pages into lru anyway in
 split_huge_page()
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, yang.shi@linux.alibaba.com,
        willy@infradead.org, hannes@cmpxchg.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com,
        =?UTF-8?Q?Mika_Penttil=c3=a4?= <mika.penttila@nextfour.com>
References: <1594429136-20002-1-git-send-email-alex.shi@linux.alibaba.com>
 <1594429136-20002-15-git-send-email-alex.shi@linux.alibaba.com>
 <d478a44b-c598-e99b-d438-9387f208ad37@linux.alibaba.com>
 <20200720084931.jusstogio6j74uhs@box>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <dd33c5ae-7924-393d-ecd2-3c7fc1bfd1cc@linux.alibaba.com>
Date:   Mon, 20 Jul 2020 17:04:46 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200720084931.jusstogio6j74uhs@box>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



ÔÚ 2020/7/20 ÏÂÎç4:49, Kirill A. Shutemov Ð´µÀ:
>>
>> Split_huge_page() must start with PageLRU(head), and we are holding the
>> lru_lock here. If the head was cleared lru bit unexpected, tracking it.
>>
>> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Hi Kirill,

Millions thanks for review!

Alex
