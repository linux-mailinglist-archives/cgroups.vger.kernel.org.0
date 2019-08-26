Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C266F9D199
	for <lists+cgroups@lfdr.de>; Mon, 26 Aug 2019 16:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732452AbfHZOZn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 26 Aug 2019 10:25:43 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:39063 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728155AbfHZOZn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 26 Aug 2019 10:25:43 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R681e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04391;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0TaWxL0E_1566829535;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TaWxL0E_1566829535)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 26 Aug 2019 22:25:36 +0800
Subject: Re: [PATCH 00/14] per memcg lru_lock
To:     Daniel Jordan <daniel.m.jordan@oracle.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@kernel.org>
References: <1566294517-86418-1-git-send-email-alex.shi@linux.alibaba.com>
 <6ba1ffb0-fce0-c590-c373-7cbc516dbebd@oracle.com>
 <348495d2-b558-fdfd-a411-89c75d4a9c78@linux.alibaba.com>
 <b776032e-eabb-64ff-8aee-acc2b3711717@oracle.com>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <0f8e2bc0-96b4-f55a-51da-b53dac415dd7@linux.alibaba.com>
Date:   Mon, 26 Aug 2019 22:25:14 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <b776032e-eabb-64ff-8aee-acc2b3711717@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



在 2019/8/22 下午11:20, Daniel Jordan 写道:
>>
>>>    https://git.kernel.org/pub/scm/linux/kernel/git/wfg/vm-scalability.git/tree/case-lru-file-readtwice>
>>> It's also synthetic but it stresses lru_lock more than just anon alloc/free.  It hits the page activate path, which is where we see this lock in our database, and if enough memory is configured lru_lock also gets stressed during reclaim, similar to [1].
>>
>> Thanks for the sharing, this patchset can not help the [1] case, since it's just relief the per container lock contention now.
> 
> I should've been clearer.  [1] is meant as an example of someone suffering from lru_lock during reclaim.  Wouldn't your series help per-memcg reclaim?

yes, I got your point, since the aim9 don't show much improvement, I am trying this case in containers.

Thanks
Alex
