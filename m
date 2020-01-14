Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A082213A7C5
	for <lists+cgroups@lfdr.de>; Tue, 14 Jan 2020 11:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729076AbgANK7U (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 14 Jan 2020 05:59:20 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36586 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbgANK7U (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 14 Jan 2020 05:59:20 -0500
Received: by mail-lj1-f196.google.com with SMTP id r19so13825323ljg.3
        for <cgroups@vger.kernel.org>; Tue, 14 Jan 2020 02:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EW8+gP2rKs+jXbNSD4aXu/n/AKA3IlQufSB8tHR0hpU=;
        b=JIpiz5EzHfc1rirgM3SfKKD7NZ7xCQYzlJ6+GdvrzJUYHz0G/NH7/ld3OhUQ1HKJos
         dit9ovo9dYZmngzGa0fLrVJtCCmge5pehCyJvukToG0Nuv+ggS+HyPkXxoj4gKNforWB
         3vF25MkaWlPZp3UnVggalYxD8ki4V8KGg6l3zKEO7hi+CMZjcWQzClCziiB9qV4c0NQe
         Vd5Jpf4zpbttEt6DWbC/XPpzESGs1GPdwXq70JoBVzV+q7XSQkIyCvpKAHFwKsHoCVuP
         Nvz4qrWH2849lEWqK2y1WXBpyP5s8Rs1cgCWkK7IYT2NdUv0t9yYFPNKfdSFKUodOQC2
         OwUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EW8+gP2rKs+jXbNSD4aXu/n/AKA3IlQufSB8tHR0hpU=;
        b=bbXh9DcyTA+jL9miILyIThlYrwB2QiCePNy6SlGqB8ea6KgYJGJvnFip0zxkcgG9da
         1PnFzNeLwMP4qusyQjOoZx6unVUuQZdII8kk+cyZrvChAV54HbrxlUtQCeC9X6avqOpn
         e3aoHm6PKslU7gaLI808iudafYBrcpPUuLoX3ETiWFZMhOevBA5vqAM49cX3tbVDkzOz
         4frrf6p99PWjZO8KxRt5WBmq5mzMKXlMRIms1w0ZhPS1evwwiB7dvh6XvMB/jeQBxdRD
         5HMJMZtAQMLBNEyXDUQa2sdqq8Bb0qpjM0fF+bnqDHXxpGF7YFc59TvU81P1DF6baTGP
         aX/g==
X-Gm-Message-State: APjAAAUhSCFZZz/rVpcCepKyQu3NRhMDkH1vVz9qgpJ+phy0S+7dZdc/
        LN8/h755WsFLR/GCv/Mdkw7FzA==
X-Google-Smtp-Source: APXvYqwwU+OYYmkkbYwhplcfbTT3Ys1dRt6HFgh5JXt2IjPqFpNbmHJc/3aC3GIv3Rs57FEF4FvMYA==
X-Received: by 2002:a2e:8755:: with SMTP id q21mr13841462ljj.156.1578999558693;
        Tue, 14 Jan 2020 02:59:18 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id n23sm7139469lfa.41.2020.01.14.02.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 02:59:17 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id C2A23100823; Tue, 14 Jan 2020 13:59:21 +0300 (+03)
Date:   Tue, 14 Jan 2020 13:59:21 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Wei Yang <richardw.yang@linux.intel.com>, hannes@cmpxchg.org,
        vdavydov.dev@gmail.com, akpm@linux-foundation.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com,
        yang.shi@linux.alibaba.com, alexander.duyck@gmail.com,
        rientjes@google.com
Subject: Re: [Patch v2] mm: thp: grab the lock before manipulation defer list
Message-ID: <20200114105921.eo2vdwikrvtt3gkb@box>
References: <20200109143054.13203-1-richardw.yang@linux.intel.com>
 <20200111000352.efy6krudecpshezh@box>
 <20200114093122.GH19428@dhcp22.suse.cz>
 <20200114103112.o6ozdbkfnzdsc2ke@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200114103112.o6ozdbkfnzdsc2ke@box>
User-Agent: NeoMutt/20180716
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jan 14, 2020 at 01:31:12PM +0300, Kirill A. Shutemov wrote:
> On Tue, Jan 14, 2020 at 10:31:22AM +0100, Michal Hocko wrote:
> > On Sat 11-01-20 03:03:52, Kirill A. Shutemov wrote:
> > > On Thu, Jan 09, 2020 at 10:30:54PM +0800, Wei Yang wrote:
> > > > As all the other places, we grab the lock before manipulate the defer list.
> > > > Current implementation may face a race condition.
> > > > 
> > > > For example, the potential race would be:
> > > > 
> > > >     CPU1                      CPU2
> > > >     mem_cgroup_move_account   split_huge_page_to_list
> > > >       !list_empty
> > > >                                 lock
> > > >                                 !list_empty
> > > >                                 list_del
> > > >                                 unlock
> > > >       lock
> > > >       # !list_empty might not hold anymore
> > > >       list_del_init
> > > >       unlock
> > > 
> > > I don't think this particular race is possible. Both parties take page
> > > lock before messing with deferred queue, but anytway:
> > > 
> > > Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > 
> > I am confused, if the above race is not possible then what would be a
> > real race? We really do not want to have a patch with a misleading
> > changelog, do we?
> 
> The alternative is to make sure that all page_deferred_list() called with
> page lock taken.
> 
> I'll look into it.

split_huge_page_to_list() has page lock taken.

free_transhuge_page() is in the free path and doesn't susceptible to the
race.

deferred_split_scan() is trickier. list_move() should be safe against
list_empty() as it will not produce false-positive list_empty().
list_del_init() *should* (correct me if I'm wrong) be safe because the page
is freeing and memcg will not touch the page anymore.

deferred_split_huge_page() is a problematic one. It called from
page_remove_rmap() path witch does require page lock. I don't see any
obvious way to exclude race with mem_cgroup_move_account() here.
Anybody else?

Wei, could you rewrite the commit message with deferred_split_huge_page()
as a race source instead of split_huge_page_to_list()?

-- 
 Kirill A. Shutemov
