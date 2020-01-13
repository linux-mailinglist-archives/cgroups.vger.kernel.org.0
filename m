Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D351913966C
	for <lists+cgroups@lfdr.de>; Mon, 13 Jan 2020 17:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728838AbgAMQfA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 Jan 2020 11:35:00 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:33280 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbgAMQe7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 13 Jan 2020 11:34:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=OyWI+2CxCOjVFobV/HzUixcC6m6SP/UUicEvP6oEb8U=; b=XlRk9bRCU394R+rkkl6rrGt/r6
        Qqn9DBhqjxKtJUEgSFbDy5JQNJbJrSLegPLKMIFaGZJU18NogpLUuIVMtSW9KicfpHxIQHnBO/ocW
        i6b7r6Sypq7BF6c/ab4JiZ9/G5L1ZIk9k7+CCRNARPqSaAzbPWx9fppVhgFp9uixD9X1Ccq6Wkp3i
        qaaCOJ0wKe++RohEAsXFx/2Fd4hbRAGlSezRtNA9jQ80y1+7E21HirlBOjtVUEsSogU7s6DPjzYcu
        hkcFwwu2lw67HcSA5E7Nk/AqE+ag7qc1Laiq0dLRZsn/4YzeVcznnqauAkfvMcLgbfs3C3d5NsjI/
        kYfSRGdQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ir2g4-0005KO-K2; Mon, 13 Jan 2020 16:34:56 +0000
Date:   Mon, 13 Jan 2020 08:34:56 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        mgorman@techsingularity.net, tj@kernel.org, hughd@google.com,
        daniel.m.jordan@oracle.com, yang.shi@linux.alibaba.com,
        shakeelb@google.com, hannes@cmpxchg.org,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: [PATCH v7 02/10] mm/memcg: fold lru_lock in lock_page_lru
Message-ID: <20200113163456.GA332@bombadil.infradead.org>
References: <1577264666-246071-1-git-send-email-alex.shi@linux.alibaba.com>
 <1577264666-246071-3-git-send-email-alex.shi@linux.alibaba.com>
 <36d7e390-a3d1-908c-d181-4a9e9c8d3d98@yandex-team.ru>
 <952d02c2-8aa5-40bb-88bb-c43dee65c8bc@linux.alibaba.com>
 <2ba8a04e-d8e0-1d50-addc-dbe1b4d8e0f1@yandex-team.ru>
 <a095d80d-8e34-c84f-e4be-085a5aae1929@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a095d80d-8e34-c84f-e4be-085a5aae1929@linux.alibaba.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Jan 13, 2020 at 08:47:25PM +0800, Alex Shi wrote:
> 在 2020/1/13 下午5:55, Konstantin Khlebnikov 写道:
> >>> That's wrong. Here PageLRU must be checked again under lru_lock.
> >> Hi, Konstantin,
> >>
> >> For logical remain, we can get the lock and then release for !PageLRU.
> >> but I still can figure out the problem scenario. Would like to give more hints?
> > 
> > That's trivial race: page could be isolated from lru between
> > 
> > if (PageLRU(page))
> > and
> > spin_lock_irq(&pgdat->lru_lock);
> 
> yes, it could be a problem. guess the following change could helpful:
> I will update it in new version.

> +       if (lrucare) {
> +               lruvec = lock_page_lruvec_irq(page);
> +               if (likely(PageLRU(page))) {
> +                       ClearPageLRU(page);
> +                       del_page_from_lru_list(page, lruvec, page_lru(page));
> +               } else {
> +                       unlock_page_lruvec_irq(lruvec);
> +                       lruvec = NULL;
> +               }

What about a harder race to hit like a page being on LRU list A when you
look up the lruvec, then it's removed and added to LRU list B by the
time you get the lock?  At that point, you are holding a lock on the
wrong LRU list.  I think you need to check not just that the page
is still PageLRU but also still on the same LRU list.
