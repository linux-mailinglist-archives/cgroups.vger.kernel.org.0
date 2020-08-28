Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89E7B255404
	for <lists+cgroups@lfdr.de>; Fri, 28 Aug 2020 07:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725858AbgH1FYV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 28 Aug 2020 01:24:21 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:53915 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725849AbgH1FYV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 28 Aug 2020 01:24:21 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07488;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0U7448ER_1598592253;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U7448ER_1598592253)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 28 Aug 2020 13:24:14 +0800
Subject: Re: [PATCH v18 00/32] per memcg lru_lock
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        mgorman@techsingularity.net, tj@kernel.org,
        khlebnikov@yandex-team.ru, willy@infradead.org, hannes@cmpxchg.org,
        lkp@intel.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com,
        kirill@shutemov.name, alexander.duyck@gmail.com,
        rong.a.chen@intel.com, mhocko@suse.com, vdavydov.dev@gmail.com,
        shy828301@gmail.com
References: <1598273705-69124-1-git-send-email-alex.shi@linux.alibaba.com>
 <20200824114204.cc796ca182db95809dd70a47@linux-foundation.org>
 <alpine.LSU.2.11.2008241231460.1065@eggly.anvils>
 <20200825015627.3c3pnwauqznnp3gc@ca-dmjordan1.us.oracle.com>
 <ec62a835-f79d-2b8c-99c7-120834703b42@linux.alibaba.com>
 <20200826011946.spknwjt44d2szrdo@ca-dmjordan1.us.oracle.com>
 <01ed6e45-3853-dcba-61cb-b429a49a7572@linux.alibaba.com>
 <20200828014022.y5xju6weysqpzxd2@ca-dmjordan1.us.oracle.com>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <327a1bb4-b64d-65b8-e18f-db33e03ca9ed@linux.alibaba.com>
Date:   Fri, 28 Aug 2020 13:22:28 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200828014022.y5xju6weysqpzxd2@ca-dmjordan1.us.oracle.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


ÔÚ 2020/8/28 ÉÏÎç9:40, Daniel Jordan Ð´µÀ:
> I went back to your v1 post to see what motivated you originally, and you had
> some results from aim9 but nothing about where this reared its head in the
> first place.  How did you discover the bottleneck?  I'm just curious about how
> lru_lock hurts in practice.

We have gotten very high 'sys' in some buiness/machines. And found much of time spent
on the lru_lock and/or zone lock. Seems per memcg lru_lock could help this, but still
no idea on zone lock.

Thanks
Alex
