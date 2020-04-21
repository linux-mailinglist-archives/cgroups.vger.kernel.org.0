Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 049831B22BE
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2020 11:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726018AbgDUJ2l (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 21 Apr 2020 05:28:41 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:34008 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725920AbgDUJ2l (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 21 Apr 2020 05:28:41 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R791e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04427;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0TwDn9.b_1587461316;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TwDn9.b_1587461316)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 21 Apr 2020 17:28:37 +0800
Subject: Re: [PATCH 15/18] mm: memcontrol: make swap tracking an integral part
 of memory control
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
 <20200420221126.341272-16-hannes@cmpxchg.org>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <e9d58c82-d746-dcd0-d9e3-6322014a3b03@linux.alibaba.com>
Date:   Tue, 21 Apr 2020 17:27:30 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200420221126.341272-16-hannes@cmpxchg.org>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



ÔÚ 2020/4/21 ÉÏÎç6:11, Johannes Weiner Ð´µÀ:
> The swapaccount=0 boot option will continue to exist, and it will
> eliminate the page_counter overhead and hide the swap control files,
> but it won't disable swap slot ownership tracking.

May we add extra explanation for this change to user? and the default
memsw limitations?

> 
> This patch makes sure we always have the cgroup records at swapin
> time; the next patch will fix the actual bug by charging readahead
> swap pages at swapin time rather than at fault time.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
