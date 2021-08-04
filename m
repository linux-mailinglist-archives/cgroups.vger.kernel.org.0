Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1183DFD51
	for <lists+cgroups@lfdr.de>; Wed,  4 Aug 2021 10:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235216AbhHDIwv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 4 Aug 2021 04:52:51 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:33530 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236689AbhHDIwv (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 4 Aug 2021 04:52:51 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 27BB622029;
        Wed,  4 Aug 2021 08:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1628067158; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0b7BpAenRMJ5oMid71xEw73/C0eBnz+/7D1hkNZyYUk=;
        b=fnvlgV0kQl5eGqkDNi1u2Fd9DECKfV794NWwudenH7QZzVVYgIWsOBi6tw43Fh4ce4d9Mp
        1vv98NW/26rcwniF04DbenIJpRKWAkwzOfU4s1ww693aKL8jcC6ikPXBuELG2IckXoNypI
        xeRV4NcCVvBCCEz0PRsgzEqqlN8bK4s=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E299EA3B92;
        Wed,  4 Aug 2021 08:52:37 +0000 (UTC)
Date:   Wed, 4 Aug 2021 10:52:35 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Waiman Long <llong@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <guro@fb.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Luis Goncalves <lgoncalv@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] mm/memcg: Disable task obj_stock for PREEMPT_RT
Message-ID: <YQpVU4/QNE251IcX@dhcp22.suse.cz>
References: <20210803175519.22298-1-longman@redhat.com>
 <87h7g62jxm.ffs@tglx>
 <8953e099-356e-ee09-a701-f4c7f4cda487@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8953e099-356e-ee09-a701-f4c7f4cda487@redhat.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 03-08-21 21:40:35, Waiman Long wrote:
[...]
> The purpose of this series is to improve kmem_cache allocation and free
> performance for non-RT kernel. So not disabling/enabling interrupt help a
> bit in this regard.

Johannes has explained the irq disabling role in the stock draining just
yesterday. Have a look at http://lkml.kernel.org/r/YQlPiLY0ieRb704V@cmpxchg.org
-- 
Michal Hocko
SUSE Labs
