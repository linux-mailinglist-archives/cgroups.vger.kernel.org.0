Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E68E8392193
	for <lists+cgroups@lfdr.de>; Wed, 26 May 2021 22:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbhEZUpI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 May 2021 16:45:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:53544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231321AbhEZUpG (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 26 May 2021 16:45:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DD4EA613C7;
        Wed, 26 May 2021 20:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1622061802;
        bh=Wc0VpiNTofyWs1k/w7vX8Lh3TnH80xRCPirGtLFyVPI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RyuWUuz9Wqha7WDVAel0HwsYR+YjnUkiTHQ+CA3lL0pH90SXDsGQYssU3bqAAmuPf
         GC199lyAGoWTlfwC4P3vddNREIR+y8QrjvVuIjzWkrxwW7YbtgkT8bxAPjON4pwXWI
         TB1H3Y0KdYu/CHYNaF+lt3nafVuovwyPpQLIotV0=
Date:   Wed, 26 May 2021 13:43:21 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH-next] mm/memcontrol.c: Fix potential uninitialized
 variable warning
Message-Id: <20210526134321.42bbd4a9dcbcf53e855c5b1b@linux-foundation.org>
In-Reply-To: <20210526193602.8742-1-longman@redhat.com>
References: <20210526193602.8742-1-longman@redhat.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, 26 May 2021 15:36:02 -0400 Waiman Long <longman@redhat.com> wrote:

> If the -Wno-maybe-uninitialized gcc option is not specified, compilation
> of memcontrol.c may generate the following warnings:
> 
> mm/memcontrol.c: In function ‘refill_obj_stock’:
> ./arch/x86/include/asm/irqflags.h:127:17: warning: ‘flags’ may be used uninitialized in this function [-Wmaybe-uninitialized]
>   return !(flags & X86_EFLAGS_IF);
>           ~~~~~~~^~~~~~~~~~~~~~~~
> mm/memcontrol.c:3216:16: note: ‘flags’ was declared here
>   unsigned long flags;
>                 ^~~~~
> In file included from mm/memcontrol.c:29:
> mm/memcontrol.c: In function ‘uncharge_page’:
> ./include/linux/memcontrol.h:797:2: warning: ‘objcg’ may be used uninitialized in this function [-Wmaybe-uninitialized]
>   percpu_ref_put(&objcg->refcnt);
>   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Fix that by properly initializing *pflags in get_obj_stock() and
> introducing a use_objcg bool variable in uncharge_page() to avoid
> potentially accessing the struct page data twice.
> 

Thanks.  I'll queue this as a fix against your "mm/memcg: optimize user
context object stock access".

