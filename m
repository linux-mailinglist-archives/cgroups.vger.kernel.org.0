Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01B091B2A03
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2020 16:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbgDUOej (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 21 Apr 2020 10:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbgDUOej (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 21 Apr 2020 10:34:39 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE54C061A10
        for <cgroups@vger.kernel.org>; Tue, 21 Apr 2020 07:34:38 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id c63so14686097qke.2
        for <cgroups@vger.kernel.org>; Tue, 21 Apr 2020 07:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=W/B7BqjKBM4LZhb4muvBIRGp0mx98vy+3KswtAICBb4=;
        b=yYEhL7H/J2T6a6KKsWtsnbqwV2cWxzG4KCkGuvV+HGGqMt695cfXAFayLf634O0D8N
         z82YE/+6dzOh9T+J54Go3udpMsHkfEiyEfpQQEFz+ni8Z3fO6HNe/+OEWnKNZGvCrQFv
         7MyV/oxIsGW5GZYEwaAvXlBxuvKYFNlzgnnPsGfdVhqH4efEsitrvCJ56KEkW1B6EH7w
         odftt7b2/bH6woOvOhVei6k0Joeaku1g3SZ20UgwSTx5fB7+fyYrg6uvz74nLee6+ml6
         5mnXx36doD8smCo0G5RTwTbK3elxGEOatUHv/n1//Z4svtrHZLE23Us6aYYi73MYJ3Ey
         vEZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=W/B7BqjKBM4LZhb4muvBIRGp0mx98vy+3KswtAICBb4=;
        b=JIw2YWRGwX1J+/dfprzsOjOy9yjc5+VznzaJVz5N2kx7YPCcNldpld4OlUK5eBC3dj
         hFvHpYcJmN3rO1EZ51qyR+XGZJYzvIaMy7+BltfKzXTZapgG2RMS8Uh2UqKuqCXdpd+m
         9VOTERQZZ6ejwACtPaSd3n7m17tGOxObG4Xc9qps05F19Vz23f1EdOSMCFpBdsW6b2qz
         vI77cMmvADfTHAtz68mXlTg1klkP7ITvhUA+T/zE+Fw1qNR9HK6maLQfxrYwonbCg2BS
         47bWgnFgMNuSt/KxADEPVHIZOL0Wje5ebNJo9AQ9m6HoDLN9UidOnDLOP0BH0ZkpYQmY
         kxVA==
X-Gm-Message-State: AGi0PuZzrv3ewFDNS45Fl6RaCRgqQb2Xohewjpl00yWUHIaYewc4cM60
        UxuiwMjBPnNk2OclKkrGBBdNoQ==
X-Google-Smtp-Source: APiQypJDgokxNuDXaXcXJrXUlJsXPY/rZTc78iXB1zdm3cuK8LKoUspcWCkYeXie16EUDE3J1THnEA==
X-Received: by 2002:a37:48a:: with SMTP id 132mr22236543qke.390.1587479678044;
        Tue, 21 Apr 2020 07:34:38 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id u35sm1753086qtd.88.2020.04.21.07.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 07:34:37 -0700 (PDT)
Date:   Tue, 21 Apr 2020 10:34:35 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Joonsoo Kim <js1304@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Shakeel Butt <shakeelb@google.com>,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 18/18] mm: memcontrol: update page->mem_cgroup stability
 rules
Message-ID: <20200421143435.GB341682@cmpxchg.org>
References: <20200420221126.341272-1-hannes@cmpxchg.org>
 <20200421091014.2180-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421091014.2180-1-hdanton@sina.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Apr 21, 2020 at 05:10:14PM +0800, Hillf Danton wrote:
> 
> On Mon, 20 Apr 2020 18:11:26 -0400 Johannes Weiner wrote:
> > 
> > The previous patches have simplified the access rules around
> > page->mem_cgroup somewhat:
> > 
> > 1. We never change page->mem_cgroup while the page is isolated by
> >    somebody else. This was by far the biggest exception to our rules
> >    and it didn't stop at lock_page() or lock_page_memcg().
> > 
> > 2. We charge pages before they get put into page tables now, so the
> >    somewhat fishy rule about "can be in page table as long as it's
> >    still locked" is now gone and boiled down to having an exclusive
> >    reference to the page.
> > 
> > Document the new rules. Any of the following will stabilize the
> > page->mem_cgroup association:
> > 
> > - the page lock
> > - LRU isolation
> > - lock_page_memcg()
> > - exclusive access to the page
> 
> Then rule-1 makes rule-3 no longer needed in mem_cgroup_move_account()?

Well, mem_cgroup_move_account() is the write side. It's the function
that changes page->mem_cgroup. So it needs to take all these locks in
order for the readside / fastpath to be okay with any one of them.
