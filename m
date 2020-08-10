Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61DEA2405E9
	for <lists+cgroups@lfdr.de>; Mon, 10 Aug 2020 14:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbgHJMa1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 10 Aug 2020 08:30:27 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:35375 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726450AbgHJMa0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 10 Aug 2020 08:30:26 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07425;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0U5MbFSe_1597062621;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U5MbFSe_1597062621)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 10 Aug 2020 20:30:21 +0800
Subject: Re: [PATCH] mm/memcg: remove useless check on page->mem_cgroup
To:     Michal Hocko <mhocko@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1596166480-22814-1-git-send-email-alex.shi@linux.alibaba.com>
 <20200731151655.GB491801@cmpxchg.org>
 <9338716f-ca0e-057f-8d94-03e2b3f70281@linux.alibaba.com>
 <20200803081815.GD5174@dhcp22.suse.cz>
 <bd61e672-b997-c4cd-2047-fca9dc11cc4c@linux.alibaba.com>
 <92dd8e68-8095-72c5-0144-2a084e4d5993@linux.alibaba.com>
 <20200810095500.GE4773@dhcp22.suse.cz>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <cc200767-de15-43d9-85f0-e95e48e1ac30@linux.alibaba.com>
Date:   Mon, 10 Aug 2020 20:29:53 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200810095500.GE4773@dhcp22.suse.cz>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



ÔÚ 2020/8/10 ÏÂÎç5:55, Michal Hocko Ð´µÀ:
>>
>> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
>> Cc: Johannes Weiner <hannes@cmpxchg.org>
>> Cc: Michal Hocko <mhocko@kernel.org>
>> Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: cgroups@vger.kernel.org
>> Cc: linux-mm@kvack.org
>> Cc: linux-kernel@vger.kernel.org
> Looks good to me. I am not familiar with the section tweaks but that
> should be ok.
> 
> Acked-by: Michal Hocko <mhocko@suse.com>
> 

Thanks a lot, Michal!

> Once you collect more feedback, please send both patches so that they do
> not get lost in this thread.

I will resend with your ack.

Thanks!
Alex
