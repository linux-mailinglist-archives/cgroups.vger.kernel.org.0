Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF657166981
	for <lists+cgroups@lfdr.de>; Thu, 20 Feb 2020 22:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729086AbgBTVDr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 20 Feb 2020 16:03:47 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37464 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729055AbgBTVDq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 20 Feb 2020 16:03:46 -0500
Received: by mail-qt1-f194.google.com with SMTP id w47so3955916qtk.4
        for <cgroups@vger.kernel.org>; Thu, 20 Feb 2020 13:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6QH645NYVKdQbEm2dIlQdYX121ucp0jcY5IFqd2iTAM=;
        b=m1KDQ49IVlT6YDlcrR6kEHfCL5+o2vBShdjFVu+ROsFCINUdPBhVp7ZfyQt8YkI4V1
         ApmRefafOkHmPeBqAw+aOBORpbSSPQvei4ZebQKB6lbePikwbuyMsGeJXjPGkKyhKF37
         9o1/9zImGJswylC3buBORrbYwImOCEp6dvqkw7OsG2kKvjpLcZYbIMBWEEJBGIfSfePm
         lGuJBobkL/67AGpQYKeKwnKNQ1SI7SGZF6n4xEHA6Fr1dU2rHcyXW6iOC4YReVB3nvXP
         1eTMKYwJmvRR0MRNpnHb4fLXuhiRnQktysIIIW6duWgeu98O/ehaOE4y54nOMfsUxX8A
         5c/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6QH645NYVKdQbEm2dIlQdYX121ucp0jcY5IFqd2iTAM=;
        b=BKpgc++MGCRUPaeTwcVSbsUl4nYtXk2s90YSW0PABYUH6cQ9Wu+SlHwFKI4HnR9ZRB
         L4VXFK/5v1w7e2DYB6s2r/gBzd8zkFpaf3UTpYmYciaSL7omFtcdpKwRApkmdpOGoUMF
         Ibe+hB0wWmwVeNh3Ism5Xp0TS4WlvfpwcuAE1XzHVWXmg9mav23jLPxrII3k2xfnTYOd
         E1YTjkMPmxR6SA/R3opV0W9gb15LO/scLBSd3Q0vzfJ7pqxmxV3ydrdbzMhNLh4TKcZu
         yfLCsZW2zFFdS0/zbWXNpERDaxF2JA7HW7KsTWSyBBismQP1WAvsHlHMF6Xv6AjoUxIe
         HaEA==
X-Gm-Message-State: APjAAAVT9DqRlP26vaW9c0cdoCq9W/zWa9CKpOL4i55belGOVBtjAy+B
        6Afxub1eS6ea1ItsWMmqr6CPhUOQswY=
X-Google-Smtp-Source: APXvYqysf1N+4rBFuAy/S4cj47nv2KlYs5KqccQLWtqnaJveOyCZVqgwo5POmZuC5JIHml5pKKa8hg==
X-Received: by 2002:ac8:7258:: with SMTP id l24mr27935548qtp.154.1582232625787;
        Thu, 20 Feb 2020 13:03:45 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::1:3504])
        by smtp.gmail.com with ESMTPSA id h6sm420212qtr.33.2020.02.20.13.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 13:03:44 -0800 (PST)
Date:   Thu, 20 Feb 2020 16:03:44 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Dan Schatzberg <schatzberg.dan@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Roman Gushchin <guro@fb.com>,
        Chris Down <chris@chrisdown.name>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        "open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" 
        <linux-mm@kvack.org>
Subject: Re: [PATCH v3 2/3] mm: Charge active memcg when no mm is set
Message-ID: <20200220210344.GK54486@cmpxchg.org>
References: <cover.1582216294.git.schatzberg.dan@gmail.com>
 <0a27b6fcbd1f7af104d7f4cf0adc6a31e0e7dd19.1582216294.git.schatzberg.dan@gmail.com>
 <CALvZod5bDQvYHTMCHoWbhiEbcBs4KATv=QLdjjivJ33kb6ZY+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod5bDQvYHTMCHoWbhiEbcBs4KATv=QLdjjivJ33kb6ZY+w@mail.gmail.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hey Shakeel!

On Thu, Feb 20, 2020 at 10:14:45AM -0800, Shakeel Butt wrote:
> On Thu, Feb 20, 2020 at 8:52 AM Dan Schatzberg <schatzberg.dan@gmail.com> wrote:
> >
> > memalloc_use_memcg() worked for kernel allocations but was silently
> > ignored for user pages.
> >
> > This patch establishes a precedence order for who gets charged:
> >
> > 1. If there is a memcg associated with the page already, that memcg is
> >    charged. This happens during swapin.
> >
> > 2. If an explicit mm is passed, mm->memcg is charged. This happens
> >    during page faults, which can be triggered in remote VMs (eg gup).
> >
> > 3. Otherwise consult the current process context. If it has configured
> >    a current->active_memcg, use that.
> 
> What if css_tryget_online(current->active_memcg) in
> get_mem_cgroup_from_current() fails? Do we want to change this to
> css_tryget() and even if that fails should we fallback to
> root_mem_cgroup or current->mm->memcg?

Good questions.

I think we can switch to css_tryget(). If a cgroup goes offline
between issuing the IO and the loop layer executing that IO, the
resources used could end up in the root instead of the closest
ancestor of the offlined group. However, the risk of that actually
happening and causing problems is probably pretty small, and the
behavior isn't really worse than before Dan's patches.

Would you mind sending a separate patch for this? AFAICS similar
concerns apply to all users of foreign charging.

As for tryget failing: can that actually happen? AFAICS, all current
users acquire a reference first (get_memcg_from_somewhere()) that they
assign to current->active_memcg. We should probably codify this rule
and do WARN_ON(!css_tryget()) /* current->active_memcg must hold a ref */
