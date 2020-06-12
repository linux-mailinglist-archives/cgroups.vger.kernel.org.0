Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8441F7261
	for <lists+cgroups@lfdr.de>; Fri, 12 Jun 2020 05:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbgFLDJk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 11 Jun 2020 23:09:40 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:45496 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726305AbgFLDJk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 11 Jun 2020 23:09:40 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01358;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0U.K13Qc_1591931375;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U.K13Qc_1591931375)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 12 Jun 2020 11:09:35 +0800
Subject: Re: [PATCH v12 00/16] per memcg lru lock
To:     Hugh Dickins <hughd@google.com>
Cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, yang.shi@linux.alibaba.com,
        willy@infradead.org, hannes@cmpxchg.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com
References: <1591856209-166869-1-git-send-email-alex.shi@linux.alibaba.com>
 <alpine.LSU.2.11.2006111510220.10801@eggly.anvils>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <b645a763-0661-cc14-bc99-57edde19267b@linux.alibaba.com>
Date:   Fri, 12 Jun 2020 11:09:33 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.11.2006111510220.10801@eggly.anvils>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



ÔÚ 2020/6/12 ÉÏÎç6:26, Hugh Dickins Ð´µÀ:
>> ..."
> It was well worth exploring, and may help in a few cases;
> Johannes's memcg swap simplifications have helped a lot more;
> but crashes under rotate_reclaimable_page() show that this series
> still does not give enough protection from mem_cgroup_move_account().
> 
> I'll send a couple of fixes to compaction bugs in reply to this:
> with those in, compaction appears to be solid.
> 

Thanks a lot for fixing. I will look into them and try to merge into
the patchset.

Thanks a lot!
Alex
