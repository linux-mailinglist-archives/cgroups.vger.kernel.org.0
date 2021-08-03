Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36E4C3DF1BC
	for <lists+cgroups@lfdr.de>; Tue,  3 Aug 2021 17:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236970AbhHCPpD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 3 Aug 2021 11:45:03 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:56657 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236745AbhHCPpD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 3 Aug 2021 11:45:03 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R821e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UhtcbfK_1628005489;
Received: from 30.39.225.192(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0UhtcbfK_1628005489)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 03 Aug 2021 23:44:50 +0800
Subject: Re: [PATCH] mm: memcontrol: Set the correct memcg swappiness
 restriction
To:     Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org,
        vdavydov.dev@gmail.com, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <d77469b90c45c49953ccbc51e54a1d465bc18f70.1627626255.git.baolin.wang@linux.alibaba.com>
 <YQOekWWgtZUfim4M@dhcp22.suse.cz>
 <6e6570d2-44a2-1da1-6c2a-38766786c40c@suse.cz>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
Message-ID: <02826fde-43a8-e20d-37f5-55416ba0c773@linux.alibaba.com>
Date:   Tue, 3 Aug 2021 23:45:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <6e6570d2-44a2-1da1-6c2a-38766786c40c@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



On 2021/8/3 23:20, Vlastimil Babka wrote:
> On 7/30/21 8:39 AM, Michal Hocko wrote:
>> On Fri 30-07-21 14:26:35, Baolin Wang wrote:
>>> Since commit c843966c556d ("mm: allow swappiness that prefers reclaiming
>>> anon over the file workingset") has expended the swappiness value to
>>> make swap to be preferred in some systems. We should also change the
>>> memcg swappiness restriction to allow memcg swap-preferred.
>>>
>>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>
>> Yes, this looks like an omission. It doesn't really make sense to have
>> two different constrains on the value.
>>
>> Acked-by: Michal Hocko <mhocko@suse.com>
> 
> So, also Fixes: c843966c556d ("mm: allow swappiness that prefers reclaiming anon
> over the file workingset")
> ?

Sure. Andrew, do I need resend it with adding fixes tag, or you can help 
to add it? Thanks.
