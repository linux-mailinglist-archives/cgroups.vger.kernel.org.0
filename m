Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24C7D2329D4
	for <lists+cgroups@lfdr.de>; Thu, 30 Jul 2020 04:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbgG3CQU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 29 Jul 2020 22:16:20 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:46403 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726319AbgG3CQT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 29 Jul 2020 22:16:19 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R401e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04397;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0U4C7kb-_1596075375;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U4C7kb-_1596075375)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 30 Jul 2020 10:16:16 +0800
Subject: Re: [PATCH v17 00/21] per memcg lru lock
To:     Hugh Dickins <hughd@google.com>
Cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, yang.shi@linux.alibaba.com,
        willy@infradead.org, hannes@cmpxchg.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com,
        kirill@shutemov.name, alexander.duyck@gmail.com,
        rong.a.chen@intel.com
References: <1595681998-19193-1-git-send-email-alex.shi@linux.alibaba.com>
 <49d4f3bf-ccce-3c97-3a4c-f5cefe2d623a@linux.alibaba.com>
 <c00ac587-7f69-768a-84ea-53cbf7469ae9@linux.alibaba.com>
 <alpine.LSU.2.11.2007291105570.4649@eggly.anvils>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <08c8797d-1935-7b41-b8db-d22f054912ac@linux.alibaba.com>
Date:   Thu, 30 Jul 2020 10:16:13 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.11.2007291105570.4649@eggly.anvils>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



ÔÚ 2020/7/30 ÉÏÎç2:06, Hugh Dickins Ð´µÀ:
> On Wed, 29 Jul 2020, Alex Shi wrote:
>>
>> Is there any comments or suggestion for this patchset?
>> Any hints will be very appreciated.
> 
> Alex: it is now v5.8-rc7, obviously too late for this patchset to make
> v5.9, so I'm currently concentrated on checking some patches headed for
> v5.9 (and some bugfix patches of my own that I don't get time to send):
> I'll get back to responding on lru_lock in a week or two's time.

Hi Hugh,

Thanks a lot for response! It's fine to wait longer.
But thing would be more efficient if review get concentrated...
I am still too new in mm area.

Thanks
Alex
