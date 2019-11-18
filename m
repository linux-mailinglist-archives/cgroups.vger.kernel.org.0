Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3A2100552
	for <lists+cgroups@lfdr.de>; Mon, 18 Nov 2019 13:08:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfKRMIV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 18 Nov 2019 07:08:21 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51668 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726464AbfKRMIV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 18 Nov 2019 07:08:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=uDdb1pDQwvx9Enh6ck9uQZEmy8t5nOmH+npUrGwmKoQ=; b=dj69PrK6hU4uhSbtILOtORwkvu
        UAgJ+yWIn/iS73f9ZnAWCaz2MFOgeOuHEStFzo4rl7J+/wsatvvBmtKULnSF2Ejpa7ZSpaAp7ypI9
        Vt5/5Q4kaTewk9aWxTGYMYyu7v7MhSkeiLZH+ozs5uiCNSkLZjBDQhRScA+3Xbpd333jKFOdfHRj8
        IEgNblIgLp45dLlPRoMWLjHA4HV+lZF1iWo7wjnShIljDnlZe/ymlAdgZDscXZPwGY46pDcp0vLzz
        BWy+4JYokBqrwj0RmN3gSnXWmKyioPvQyycQkt07R91jxw46AkvEn1mrlY02WsoGyaKUq2yvVs3l5
        z5ZqehHA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iWfpH-0007ns-MP; Mon, 18 Nov 2019 12:08:15 +0000
Date:   Mon, 18 Nov 2019 04:08:15 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tejun Heo <tj@kernel.org>, Hugh Dickins <hughd@google.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Arun KS <arunks@codeaurora.org>
Subject: Re: [PATCH v3 1/7] mm/lru: add per lruvec lock for memcg
Message-ID: <20191118120815.GF20752@bombadil.infradead.org>
References: <1573874106-23802-1-git-send-email-alex.shi@linux.alibaba.com>
 <1573874106-23802-2-git-send-email-alex.shi@linux.alibaba.com>
 <CALvZod77568+TozRXpERDDap__jbj+oJBY8zD=UBd40XNJC2zg@mail.gmail.com>
 <e707fd66-16c2-8523-dd8b-860b5b6bb11d@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e707fd66-16c2-8523-dd8b-860b5b6bb11d@linux.alibaba.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Nov 18, 2019 at 10:44:57AM +0800, Alex Shi wrote:
> 
> 
> 在 2019/11/16 下午2:28, Shakeel Butt 写道:
> > On Fri, Nov 15, 2019 at 7:15 PM Alex Shi <alex.shi@linux.alibaba.com> wrote:
> >>
> >> Currently memcg still use per node pgdat->lru_lock to guard its lruvec.
> >> That causes some lru_lock contention in a high container density system.
> >>
> >> If we can use per lruvec lock, that could relief much of the lru_lock
> >> contention.
> >>
> >> The later patches will replace the pgdat->lru_lock with lruvec->lru_lock
> >> and show the performance benefit by benchmarks.
> > 
> > Merge this patch with actual usage. No need to have a separate patch.
> 
> Thanks for comment, Shakeel!
> 
> Yes, but considering the 3rd, huge and un-splitable patch of actully replacing, I'd rather to pull sth out from 
> it. Ty to make patches a bit more readable, Do you think so?

This method of splitting the patches doesn't help with the reviewability of
the patch series.
