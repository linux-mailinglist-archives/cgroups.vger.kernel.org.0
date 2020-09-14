Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1265326881D
	for <lists+cgroups@lfdr.de>; Mon, 14 Sep 2020 11:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbgINJSr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 14 Sep 2020 05:18:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:54652 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726123AbgINJSr (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 14 Sep 2020 05:18:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B9090ADC2;
        Mon, 14 Sep 2020 09:19:00 +0000 (UTC)
Date:   Mon, 14 Sep 2020 11:18:44 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Cgroups <cgroups@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [External] Re: [PATCH] mm: memcontrol: Fix out-of-bounds on the
 buf returned by memory_stat_format
Message-ID: <20200914091844.GE16999@dhcp22.suse.cz>
References: <20200912155100.25578-1-songmuchun@bytedance.com>
 <20200912174241.eeaa771755915f27babf9322@linux-foundation.org>
 <CAMZfGtXNg31+8QLbUMj7f61Yg1Jgt0rPB7VTDE7qoopGCANGjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZfGtXNg31+8QLbUMj7f61Yg1Jgt0rPB7VTDE7qoopGCANGjA@mail.gmail.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 14-09-20 12:02:33, Muchun Song wrote:
> On Sun, Sep 13, 2020 at 8:42 AM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Sat, 12 Sep 2020 23:51:00 +0800 Muchun Song <songmuchun@bytedance.com> wrote:
> >
> > > The memory_stat_format() returns a format string, but the return buf
> > > may not including the trailing '\0'. So the users may read the buf
> > > out of bounds.
> >
> > That sounds serious.  Is a cc:stable appropriate?
> >
> 
> Yeah, I think we should cc:stable.

Is this a real problem? The buffer should contain 36 lines which makes
it more than 100B per line. I strongly suspect we are not able to use
that storage up.
-- 
Michal Hocko
SUSE Labs
