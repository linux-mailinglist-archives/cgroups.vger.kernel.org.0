Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E715296F24
	for <lists+cgroups@lfdr.de>; Wed, 21 Aug 2019 04:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbfHUCAj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 20 Aug 2019 22:00:39 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:41849 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726512AbfHUCAi (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 20 Aug 2019 22:00:38 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07417;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0Ta0UEVw_1566352833;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0Ta0UEVw_1566352833)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 21 Aug 2019 10:00:33 +0800
Subject: Re: [PATCH 00/14] per memcg lru_lock
To:     Hugh Dickins <hughd@google.com>, Michal Hocko <mhocko@kernel.org>
Cc:     Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tejun Heo <tj@kernel.org>, Shakeel Butt <shakeelb@google.com>,
        Yu Zhao <yuzhao@google.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
References: <1566294517-86418-1-git-send-email-alex.shi@linux.alibaba.com>
 <20190820104532.GP3111@dhcp22.suse.cz>
 <CALvZod7-dL90jwd2pywpaD8NfUByVU9Y809+RfvJABGdRASYUg@mail.gmail.com>
 <alpine.LSU.2.11.1908201038260.1286@eggly.anvils>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <e9ac9c8c-15c1-8365-5c39-285c6d7b07a6@linux.alibaba.com>
Date:   Wed, 21 Aug 2019 10:00:33 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.11.1908201038260.1286@eggly.anvils>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



在 2019/8/21 上午2:24, Hugh Dickins 写道:
> I'll set aside what I'm doing, and switch to rebasing ours to v5.3-rc
> and/or mmotm.  Then compare with what Alex has, to see if there's any
> good reason to prefer one to the other: if no good reason to prefer ours,
> I doubt we shall bother to repost, but just use it as basis for helping
> to review or improve Alex's.

For your review, my patchset are pretty straight and simple. It just use per lruvec lru_lock to replace necessary pgdat lru_lock. just this. 
We could talk more after I back to work. :)

Thanks alot!
Alex
