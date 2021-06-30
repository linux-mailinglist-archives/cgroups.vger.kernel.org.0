Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8174D3B7F27
	for <lists+cgroups@lfdr.de>; Wed, 30 Jun 2021 10:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232982AbhF3ImS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 30 Jun 2021 04:42:18 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:33596 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232904AbhF3ImS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 30 Jun 2021 04:42:18 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 04C62225F4;
        Wed, 30 Jun 2021 08:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1625042389; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LAok8aXqVPRw4PDdITfa7F/8C/VBQZ8wiZP19XKfIr4=;
        b=nSWI2n/eeRY5vZ8luIa/myWC8es4URiXrfWhkVK5QQ03iSKA0n2lQTT7LilT67L6m2SMgV
        bv2lagtUox3xY0aiP46UEorTxBTnVDoBaZMml4Iev7Cnt0L1r5sj9ahTFbNP6DRBJ67DIP
        JQLV6CMw30x+rh+nmkq1QGG+SOcRFAg=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id CE37BA3B85;
        Wed, 30 Jun 2021 08:39:48 +0000 (UTC)
Date:   Wed, 30 Jun 2021 10:39:48 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, cgroups@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: [PATCH v3 17/18] mm/memcg: Add folio_lruvec_relock_irq() and
 folio_lruvec_relock_irqsave()
Message-ID: <YNwt1P0c6RxyQHq3@dhcp22.suse.cz>
References: <20210630040034.1155892-1-willy@infradead.org>
 <20210630040034.1155892-18-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210630040034.1155892-18-willy@infradead.org>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 30-06-21 05:00:33, Matthew Wilcox wrote:
> These are the folio equivalents of relock_page_lruvec_irq() and
> folio_lruvec_relock_irqsave(), which are retained as compatibility wrappers.
> Also convert lruvec_holds_page_lru_lock() to folio_lruvec_holds_lru_lock().

$ git grep relock_page_lruvec_irqsave
include/linux/memcontrol.h:static inline struct lruvec *relock_page_lruvec_irqsave(struct page *page,

on your tree.
-- 
Michal Hocko
SUSE Labs
