Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36F749D18F
	for <lists+cgroups@lfdr.de>; Mon, 26 Aug 2019 16:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732303AbfHZOXZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 26 Aug 2019 10:23:25 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:48878 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728324AbfHZOXZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 26 Aug 2019 10:23:25 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0TaX2Psc_1566829386;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TaX2Psc_1566829386)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 26 Aug 2019 22:23:07 +0800
Subject: Re: [PATCH 00/14] per memcg lru_lock
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>
References: <1566294517-86418-1-git-send-email-alex.shi@linux.alibaba.com>
 <6ba1ffb0-fce0-c590-c373-7cbc516dbebd@oracle.com>
 <348495d2-b558-fdfd-a411-89c75d4a9c78@linux.alibaba.com>
 <b776032e-eabb-64ff-8aee-acc2b3711717@oracle.com>
 <d5256ebf-8314-8c24-a7ed-e170b7d39b61@yandex-team.ru>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <1e2de503-9f53-9c51-f20c-f11a4b9625ed@linux.alibaba.com>
Date:   Mon, 26 Aug 2019 22:22:46 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <d5256ebf-8314-8c24-a7ed-e170b7d39b61@yandex-team.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



在 2019/8/26 下午4:39, Konstantin Khlebnikov 写道:
>>>
> because they mixes pages from different cgroups.
> 
> pagevec_lru_move_fn and friends need better implementation:
> either sorting pages or splitting vectores in per-lruvec basis.

Right, this should be the next step to improve. Maybe we could try the per-lruvec pagevec?

Thanks
Alex
