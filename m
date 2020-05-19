Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3E291DA53D
	for <lists+cgroups@lfdr.de>; Wed, 20 May 2020 01:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbgESXOl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 19 May 2020 19:14:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:55176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726318AbgESXOl (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 19 May 2020 19:14:41 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B12C20578;
        Tue, 19 May 2020 23:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589930081;
        bh=kFVmk07C+lCDPUldrdSqVB+RgnW09KwNynO8E7jgKP4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CPvadw6o4TkrMm6zhPGc/Fm7a62w+1BbAGeTO3S9haFDCVPS7RIna8lD5ssh74RjP
         t+aMesV4qDTyelgVbrAZFZ5m76cba3pUP5ZgvDc+UiLt5BRCjEKdpmGFWbeBiBkng6
         PD9W9jab6gryKkZMUotBU+FXCbEVp9YXN/5Ma6RA=
Date:   Tue, 19 May 2020 16:14:38 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Kernel Team <kernel-team@fb.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Chris Down <chris@chrisdown.name>,
        Cgroups <cgroups@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH mm v4 3/4] mm: move cgroup high memory limit setting
 into struct page_counter
Message-ID: <20200519161438.4f11ddec@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <CALvZod4i2sBWcbKe3MHMuSMV3ywWwQx1Xr-abEqPS6n8vioC7w@mail.gmail.com>
References: <20200519171938.3569605-1-kuba@kernel.org>
        <20200519171938.3569605-4-kuba@kernel.org>
        <CALvZod4i2sBWcbKe3MHMuSMV3ywWwQx1Xr-abEqPS6n8vioC7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, 19 May 2020 15:15:41 -0700 Shakeel Butt wrote:
> > --- a/mm/page_counter.c
> > +++ b/mm/page_counter.c
> > @@ -198,6 +198,11 @@ int page_counter_set_max(struct page_counter *counter, unsigned long nr_pages)
> >         }
> >  }
> >
> > +void page_counter_set_high(struct page_counter *counter, unsigned long nr_pages)
> > +{
> > +       WRITE_ONCE(counter->high, nr_pages);
> > +}
> > +  
> 
> Any reason not to make this static inline like
> page_counter_is_above_high() and in page_counter.h?

My reason was consistency with other page_counter_set_xyz() helpers,
but obviously happy to change if needed...
