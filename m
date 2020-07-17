Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE642232D0
	for <lists+cgroups@lfdr.de>; Fri, 17 Jul 2020 07:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726040AbgGQFOX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 17 Jul 2020 01:14:23 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:52776 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725300AbgGQFOX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 17 Jul 2020 01:14:23 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R591e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01355;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0U2ysU8P_1594962854;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U2ysU8P_1594962854)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 17 Jul 2020 13:14:16 +0800
Subject: Re: [PATCH v16 05/22] mm/thp: move lru_add_page_tail func to
 huge_memory.c
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, yang.shi@linux.alibaba.com,
        willy@infradead.org, hannes@cmpxchg.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com
References: <1594429136-20002-1-git-send-email-alex.shi@linux.alibaba.com>
 <1594429136-20002-6-git-send-email-alex.shi@linux.alibaba.com>
 <924c187c-d4cb-4458-9a71-63f79e0a66c8@linux.alibaba.com>
 <20200716131706.h6c5nob4somfmegp@box>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <045c70c7-e4e4-c1d1-b066-c359ef9f15a5@linux.alibaba.com>
Date:   Fri, 17 Jul 2020 13:13:21 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200716131706.h6c5nob4somfmegp@box>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



ÔÚ 2020/7/16 ÏÂÎç9:17, Kirill A. Shutemov Ð´µÀ:
> On Thu, Jul 16, 2020 at 04:59:48PM +0800, Alex Shi wrote:
>> Hi Kirill & Matthew,
>>
>> Is there any concern from for the THP involved patches?
> 
> It is mechanical move. I don't see a problem.
> 

Many thanks! Kirill,

Do you mind to give a reviewed-by?

And rre they ok for patch 6th,7th and 14th?

Thanks a lot!
Alex
