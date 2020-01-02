Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 505FD12E4EB
	for <lists+cgroups@lfdr.de>; Thu,  2 Jan 2020 11:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbgABKWo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 2 Jan 2020 05:22:44 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:36329 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727990AbgABKWo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 2 Jan 2020 05:22:44 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R931e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0Tmc9SUd_1577960560;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0Tmc9SUd_1577960560)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 02 Jan 2020 18:22:40 +0800
Subject: Re: [PATCH v7 00/10] per lruvec lru_lock for memcg
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mgorman@techsingularity.net, tj@kernel.org,
        hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, yang.shi@linux.alibaba.com,
        willy@infradead.org, shakeelb@google.com, hannes@cmpxchg.org
References: <1577264666-246071-1-git-send-email-alex.shi@linux.alibaba.com>
 <20191231150514.61c2b8c8354320f09b09f377@linux-foundation.org>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <944f0f6a-466a-7ce3-524c-f6db86fd0891@linux.alibaba.com>
Date:   Thu, 2 Jan 2020 18:21:47 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20191231150514.61c2b8c8354320f09b09f377@linux-foundation.org>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



ÔÚ 2020/1/1 ÉÏÎç7:05, Andrew Morton Ð´µÀ:
> On Wed, 25 Dec 2019 17:04:16 +0800 Alex Shi <alex.shi@linux.alibaba.com> wrote:
> 
>> This patchset move lru_lock into lruvec, give a lru_lock for each of
>> lruvec, thus bring a lru_lock for each of memcg per node.
> 
> I see that there has been plenty of feedback on previous versions, but
> no acked/reviewed tags as yet.
> 
> I think I'll take a pass for now, see what the audience feedback looks
> like ;)
> 


Thanks a lot! Andrew.

Please drop the 10th patch since it's for debug only and cost performance drop.

Best regards & Happy new year! :)
Alex
