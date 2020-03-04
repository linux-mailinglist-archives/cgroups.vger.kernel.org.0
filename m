Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA29D178C6D
	for <lists+cgroups@lfdr.de>; Wed,  4 Mar 2020 09:15:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbgCDIPg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 4 Mar 2020 03:15:36 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:52574 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725271AbgCDIPg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 4 Mar 2020 03:15:36 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R691e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0TrcoXXb_1583309623;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TrcoXXb_1583309623)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 04 Mar 2020 16:13:44 +0800
Subject: Re: [PATCH v9 04/20] mm/thp: move lru_add_page_tail func to
 huge_memory.c
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     cgroups@vger.kernel.org, akpm@linux-foundation.org,
        mgorman@techsingularity.net, tj@kernel.org, hughd@google.com,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        yang.shi@linux.alibaba.com, willy@infradead.org,
        hannes@cmpxchg.org, lkp@intel.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <1583146830-169516-1-git-send-email-alex.shi@linux.alibaba.com>
 <1583146830-169516-5-git-send-email-alex.shi@linux.alibaba.com>
 <20200304074719.e6unbgdop2r3jhk2@box>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <3b18a429-25fd-df28-1bf3-57bcd38c6cd8@linux.alibaba.com>
Date:   Wed, 4 Mar 2020 16:13:43 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200304074719.e6unbgdop2r3jhk2@box>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



ÔÚ 2020/3/4 ÏÂÎç3:47, Kirill A. Shutemov Ð´µÀ:
> On Mon, Mar 02, 2020 at 07:00:14PM +0800, Alex Shi wrote:
>> The func is only used in huge_memory.c, defining it in other file with a
>> CONFIG_TRANSPARENT_HUGEPAGE macro restrict just looks weird.
>>
>> Let's move it close user.
> 
> I don't think it's strong enough justification. I would rather keep all
> lru helpers in one place.
> 

Thanks for comments, Kirill,

If it's a common used func, yes.

But if you look into details of this func, it's thp used only func. 

Thanks
Alex
