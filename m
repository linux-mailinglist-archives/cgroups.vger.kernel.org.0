Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A75D4A4E2E
	for <lists+cgroups@lfdr.de>; Mon, 31 Jan 2022 19:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351012AbiAaSZm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 31 Jan 2022 13:25:42 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:48892 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356713AbiAaSZ1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 31 Jan 2022 13:25:27 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C0DA41F380;
        Mon, 31 Jan 2022 18:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1643653525; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FTFA2b8ZYqmua0W1dg2oBKqfoda+M3kBiT0mJekqZsw=;
        b=XjVzr1CnsL27EfZQj2F2hpCP5vbc4QBXNF1eoFWrbyL2VFCRPnJydl3ZVbHSVp5xUVA7lF
        QwQr3bMoRIBAy7byOQcMSGSh7g7wv07HDD4L3O9V/0Obawh8FZcQ+JUekpCtFpTdW3gypp
        sBg/1U1rWLah6wt4shoX2WxFPps9PYo=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4497AA3B8E;
        Mon, 31 Jan 2022 18:25:25 +0000 (UTC)
Date:   Mon, 31 Jan 2022 19:25:22 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Waiman Long <longman@redhat.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Ira Weiny <ira.weiny@intel.com>,
        Rafael Aquini <aquini@redhat.com>
Subject: Re: [PATCH v2 3/3] mm/page_owner: Dump memcg information
Message-ID: <Yfgpknwr1tMnPkqh@dhcp22.suse.cz>
References: <20220129205315.478628-1-longman@redhat.com>
 <20220129205315.478628-4-longman@redhat.com>
 <YfeuK5j7cbgM+Oo+@dhcp22.suse.cz>
 <YfgT/9tEREQNiiAN@cmpxchg.org>
 <YfgnUZQBRkqhrEIb@carbon.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfgnUZQBRkqhrEIb@carbon.dhcp.thefacebook.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 31-01-22 10:15:45, Roman Gushchin wrote:
> On Mon, Jan 31, 2022 at 11:53:19AM -0500, Johannes Weiner wrote:
> > On Mon, Jan 31, 2022 at 10:38:51AM +0100, Michal Hocko wrote:
> > > On Sat 29-01-22 15:53:15, Waiman Long wrote:
> > > > It was found that a number of offlined memcgs were not freed because
> > > > they were pinned by some charged pages that were present. Even "echo
> > > > 1 > /proc/sys/vm/drop_caches" wasn't able to free those pages. These
> > > > offlined but not freed memcgs tend to increase in number over time with
> > > > the side effect that percpu memory consumption as shown in /proc/meminfo
> > > > also increases over time.
> > > > 
> > > > In order to find out more information about those pages that pin
> > > > offlined memcgs, the page_owner feature is extended to dump memory
> > > > cgroup information especially whether the cgroup is offlined or not.
> > > 
> > > It is not really clear to me how this is supposed to be used. Are you
> > > really dumping all the pages in the system to find out offline memcgs?
> > > That looks rather clumsy to me. I am not against adding memcg
> > > information to the page owner output. That can be useful in other
> > > contexts.
> > 
> > We've sometimes done exactly that in production, but with drgn
> > scripts. It's not very common, so it doesn't need to be very efficient
> > either. Typically, we'd encounter a host with an unusual number of
> > dying cgroups, ssh in and poke around with drgn to figure out what
> > kind of objects are still pinning the cgroups in question.
> > 
> > This patch would make that process a little easier, I suppose.
> 
> Right. Over last few years I've spent enormous amount of time digging into
> various aspects of this problem and in my experience the combination of drgn
> for the inspection of the current state and bpf for following various decisions
> on the reclaim path was the most useful combination.
> 
> I really appreciate an effort to put useful tools to track memcg references
> into the kernel tree, however the page_owner infra has a limited usefulness
> as it has to be enabled on the boot. But because it doesn't add any overhead,
> I also don't think there any reasons to not add it.

Would it be feasible to add a debugfs interface to displa dead memcg
information?
-- 
Michal Hocko
SUSE Labs
