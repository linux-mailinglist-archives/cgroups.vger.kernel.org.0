Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 439182695CF
	for <lists+cgroups@lfdr.de>; Mon, 14 Sep 2020 21:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725978AbgINTov (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 14 Sep 2020 15:44:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27709 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725953AbgINTov (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 14 Sep 2020 15:44:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600112690;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A/DjrjveF5/2wA8RTl0T9a0Cox1J1OLY+rMuhaYpfao=;
        b=iU4h2vv/M1zUWJJz3Pm72a/wlgb/ICjPAbhhKRyOKH64W14MyQnKrWpLxLP/bp+H4sXp63
        QxHNa9MkaaBA/+HL5IM82Kll7c4Tj4Ta+th02dHDNj1ynlbZrV2izvmZYL0VHEt1F3LO4X
        UHIH2ObFAXPo+z1V/z4LuGGARwz5QTI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-JgGmMpLmOG2xlwIrBHTevw-1; Mon, 14 Sep 2020 15:44:43 -0400
X-MC-Unique: JgGmMpLmOG2xlwIrBHTevw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 773238015AA;
        Mon, 14 Sep 2020 19:44:41 +0000 (UTC)
Received: from ovpn-113-249.rdu2.redhat.com (ovpn-113-249.rdu2.redhat.com [10.10.113.249])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ACF737513E;
        Mon, 14 Sep 2020 19:44:39 +0000 (UTC)
Message-ID: <05803c18b64db8a811c692bcbdc03172935ea483.camel@redhat.com>
Subject: Re: [PATCH v2 3/8] mm: Optimise madvise WILLNEED
From:   Qian Cai <cai@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, intel-gfx@lists.freedesktop.org,
        Huang Ying <ying.huang@intel.com>,
        Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        William Kucharski <william.kucharski@oracle.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Matthew Auld <matthew.auld@intel.com>
Date:   Mon, 14 Sep 2020 15:44:39 -0400
In-Reply-To: <20200914165032.GS6583@casper.infradead.org>
References: <20200910183318.20139-1-willy@infradead.org>
         <20200910183318.20139-4-willy@infradead.org>
         <c48c5eaa09d1ea5b78b12b545c034d1e937c49ba.camel@redhat.com>
         <20200914165032.GS6583@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, 2020-09-14 at 17:50 +0100, Matthew Wilcox wrote:
> On Mon, Sep 14, 2020 at 12:17:07PM -0400, Qian Cai wrote:
> > Reverting the "Return head pages from find_*_entry" patchset [1] up to this
> > patch fixed the issue that LTP madvise06 test [2] would trigger endless
> > soft-
> > lockups below. It does not help after applied patches fixed other separate
> > issues in the patchset [3][4].
> 
> Thanks for the report.  Could you try this?

It works fine.

> 
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 96189acd6969..2d9ceccb338d 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -234,6 +234,7 @@ static void force_shm_swapin_readahead(struct
> vm_area_struct *vma,
>  
>  		if (!xa_is_value(page))
>  			continue;
> +		xas_pause(&xas);
>  		rcu_read_unlock();
>  
>  		swap = radix_to_swp_entry(page);
> @@ -243,7 +244,6 @@ static void force_shm_swapin_readahead(struct
> vm_area_struct *vma,
>  			put_page(page);
>  
>  		rcu_read_lock();
> -		xas_reset(&xas);
>  	}
>  	rcu_read_unlock();
>  
> 

