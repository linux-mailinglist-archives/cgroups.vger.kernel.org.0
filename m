Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED58E1B2277
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2020 11:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbgDUJPO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 21 Apr 2020 05:15:14 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:38471 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726018AbgDUJPO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 21 Apr 2020 05:15:14 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01422;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0TwDXJ5r_1587460498;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TwDXJ5r_1587460498)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 21 Apr 2020 17:14:59 +0800
Subject: Re: [PATCH 07/18] mm: memcontrol: prepare move_account for removal of
 private page type counters
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Joonsoo Kim <js1304@gmail.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
References: <20200420221126.341272-1-hannes@cmpxchg.org>
 <20200420221126.341272-8-hannes@cmpxchg.org>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <fc09bc07-b958-420f-654c-af28f656cb3b@linux.alibaba.com>
Date:   Tue, 21 Apr 2020 17:13:52 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200420221126.341272-8-hannes@cmpxchg.org>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



ÔÚ 2020/4/21 ÉÏÎç6:11, Johannes Weiner Ð´µÀ:
> When memcg uses the generic vmstat counters, it doesn't need to do
> anything at charging and uncharging time. It does, however, need to
> migrate counts when pages move to a different cgroup in move_account.
> 
> Prepare the move_account function for the arrival of NR_FILE_PAGES,
> NR_ANON_MAPPED, NR_ANON_THPS etc. by having a branch for files and a
> branch for anon, which can then divided into sub-branches.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Alex Shi <alex.shi@linux.alibaba.com>
