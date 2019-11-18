Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3D70FFD38
	for <lists+cgroups@lfdr.de>; Mon, 18 Nov 2019 03:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbfKRCwq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 17 Nov 2019 21:52:46 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:45757 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726168AbfKRCwq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 17 Nov 2019 21:52:46 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0TiMfBZg_1574045560;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TiMfBZg_1574045560)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 18 Nov 2019 10:52:41 +0800
Subject: Re: [PATCH v3 2/7] mm/lruvec: add irqsave flags into lruvec struct
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tejun Heo <tj@kernel.org>, Hugh Dickins <hughd@google.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Arun KS <arunks@codeaurora.org>,
        Rong Chen <rong.a.chen@intel.com>
References: <1573874106-23802-1-git-send-email-alex.shi@linux.alibaba.com>
 <1573874106-23802-3-git-send-email-alex.shi@linux.alibaba.com>
 <CALvZod5xuetOb8Vunhgjp69-HcrnHgGHZKKyjVBo3tmoc3WqaA@mail.gmail.com>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <de24def3-3593-a2f7-ab73-5ac379c1e5ca@linux.alibaba.com>
Date:   Mon, 18 Nov 2019 10:52:40 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <CALvZod5xuetOb8Vunhgjp69-HcrnHgGHZKKyjVBo3tmoc3WqaA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



在 2019/11/16 下午2:31, Shakeel Butt 写道:
> On Fri, Nov 15, 2019 at 7:15 PM Alex Shi <alex.shi@linux.alibaba.com> wrote:
>> We need a irqflags vaiable to save state when do irqsave action, declare
>> it here would make code more clear/clean.
>>
>> Rong Chen <rong.a.chen@intel.com> reported the 'irqflags' variable need
>> move to the tail of lruvec struct otherwise it causes 18% regressions of
>> vm-scalability testing on his machine. So add the flags and lru_lock to
>> both near struct tail, even I have no clue of this perf losing.
> Regressions compared to what? Also no need to have a separate patch.
> 

Thanks for question, Shakeel, 
I will change the commit log and mention the original place: the head of lruvec struct.
As to the folding, the 3rd is already toooo long. May I leave it here to relief a littel bit burden on reading?

Thanks
Alex
