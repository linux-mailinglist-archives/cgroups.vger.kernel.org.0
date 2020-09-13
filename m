Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1014267FE8
	for <lists+cgroups@lfdr.de>; Sun, 13 Sep 2020 17:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725938AbgIMP1u (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 13 Sep 2020 11:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbgIMP1t (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 13 Sep 2020 11:27:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 020C5C06174A;
        Sun, 13 Sep 2020 08:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=C1bbDqi5VCfzqw76j0WaYj+8YMSHM3OKpSoM0GoYCKo=; b=OZONTHLY9/TgFfO41JQ+xf6am3
        GJdQeLzpPTtraP+6usD99lKEXnWfjZkuGOgAo/Cj4cPBjC0sXLpR/6bOD43DcmCv65a+BtJX0DB/E
        iJj620MXIapmzXo0y5OoRIGq8YjAylAfC2KBLSG8SqqgFvaJoGD2aCJK7bK/CZJXhrNH7gZZwCyq0
        ud+9D0y83Gyi7Ng6HsQp6NfE7Qc+y/cF2xnZ9Ilrw0WN2JKzxieVj/i4pyQXRZXSAnnFIGDlnYhNE
        XVPdPUH0RHEUs5gBqZ3pm4qm/eCgkvV+Sx18YN3Glw8zlK1Uhba6tusVYMJK5NLL3QfI7zbal90lH
        K/pli+oQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kHTuB-0007a9-UV; Sun, 13 Sep 2020 15:27:04 +0000
Date:   Sun, 13 Sep 2020 16:27:03 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, hannes@cmpxchg.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com,
        kirill@shutemov.name, alexander.duyck@gmail.com,
        rong.a.chen@intel.com, mhocko@suse.com, vdavydov.dev@gmail.com,
        shy828301@gmail.com, Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH v18 06/32] mm/thp: narrow lru locking
Message-ID: <20200913152703.GI6583@casper.infradead.org>
References: <1598273705-69124-1-git-send-email-alex.shi@linux.alibaba.com>
 <1598273705-69124-7-git-send-email-alex.shi@linux.alibaba.com>
 <20200910134923.GR6583@casper.infradead.org>
 <514f6afa-dbf7-11c5-5431-1d558d2c20c9@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <514f6afa-dbf7-11c5-5431-1d558d2c20c9@linux.alibaba.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Sep 11, 2020 at 11:37:50AM +0800, Alex Shi wrote:
> 
> 
> 在 2020/9/10 下午9:49, Matthew Wilcox 写道:
> > On Mon, Aug 24, 2020 at 08:54:39PM +0800, Alex Shi wrote:
> >> lru_lock and page cache xa_lock have no reason with current sequence,
> >> put them together isn't necessary. let's narrow the lru locking, but
> >> left the local_irq_disable to block interrupt re-entry and statistic update.
> > 
> > What stats are you talking about here?
> 
> Hi Matthew,
> 
> Thanks for comments!
> 
> like __dec_node_page_state(head, NR_SHMEM_THPS); will have preemptive warning...

OK, but those stats are guarded by 'if (mapping)', so this patch doesn't
produce that warning because we'll have taken the xarray lock and disabled
interrupts.

> > How about this patch instead?  It occurred to me we already have
> > perfectly good infrastructure to track whether or not interrupts are
> > already disabled, and so we should use that instead of ensuring that
> > interrupts are disabled, or tracking that ourselves.
> 
> So your proposal looks like;
> 1, xa_lock_irq(&mapping->i_pages); (optional)
> 2, spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
> 3, spin_lock_irqsave(&pgdat->lru_lock, flags);
> 
> Is there meaningful for the 2nd and 3rd flags?

Yes.  We want to avoid doing:

	if (mapping)
		spin_lock(&ds_queue->split_queue_lock);
	else
		spin_lock_irq(&ds_queue->split_queue_lock);
...
	if (mapping)
		spin_unlock(&ds_queue->split_queue_lock);
	else
		spin_unlock_irq(&ds_queue->split_queue_lock);

Just using _irqsave has the same effect and is easier to reason about.

> IIRC, I had a similar proposal as your, the flags used in xa_lock_irqsave(),
> but objected by Hugh.

I imagine Hugh's objection was that we know it's safe to disable/enable
interrupts here because we're in a sleepable context.  But for the
other two locks, we'd rather not track whether we've already disabled
interrupts or not.

Maybe you could dig up the email from Hugh?  I can't find it.

