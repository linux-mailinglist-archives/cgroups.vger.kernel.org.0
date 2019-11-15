Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48F33FE245
	for <lists+cgroups@lfdr.de>; Fri, 15 Nov 2019 17:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbfKOQH3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 15 Nov 2019 11:07:29 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46156 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727564AbfKOQH2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 15 Nov 2019 11:07:28 -0500
Received: by mail-pl1-f193.google.com with SMTP id l4so4942138plt.13
        for <cgroups@vger.kernel.org>; Fri, 15 Nov 2019 08:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1MDIj/Ne5pWo+qodnUOYNjkosiDdOXlcWKy8+ElVdyg=;
        b=HzFBCREP8wXPZZXgWF27J4qUzWH5xoBUAuAtElEVPcSC+Ki7U/c5SUXGvYZa01flfV
         YDHshfhjrztIe8xP8xPhd0nx9YE4eVyuCblRCwS1pg7oij+8FE1TrEk6Jj+fNx6W+AHI
         IYJZHmpNmtsc6G8iFGqUHRz8muPDmz4HrNqZ0zvq6vfgirhS0QoZnsj8w6jFmfHkfh7U
         4+cd6pqvCvowO/FlGZ1B/OCnQxWPbEIlFGrWe1Ss8FEf4VixRWYaqnJ/T8tNNgV4NOiC
         GIYUSUi39Pu5pVdEbudq/SadJ+Hy2Pg2kisrZ/lT3gydRjxhPK7Lg+wUJrhxZoUP8mHx
         qhhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1MDIj/Ne5pWo+qodnUOYNjkosiDdOXlcWKy8+ElVdyg=;
        b=ha0r70g0HiaFpbF7KQCeUFZvH5rH4Wy8pkN9IIvIGAkisEpeBanzlyvE0qIh0dPvqK
         HiBAuzNn76dLaFXOrYUZpw1WVwySpkiHoirRzIV4LlO++822gzIqoGmPG+5n7QoGvNP+
         5nWNnNdqL8nbjE7ihuxD5/u6xYi1Tu9z/KJ5kwusCtr9GmvgIcPRPAqvCfX8HC8Mz36J
         OX7Akd7F+1T6QPYnYge56SMC2UTdPSuauo9OkgzHn3XdfSeaDNN3ApUDuIygXb/fqhFT
         KkREfQDYSho9qQ94M522wxfqKEeV1MupFFcWXzF4uSZyOST0+uTFjxpsjatbTkeitS7f
         zo4g==
X-Gm-Message-State: APjAAAXTe0PtPWGytkIaxsJVp/LhTPHliCMMZU7x4aEVi9Zs4LudiSlV
        qrgnfxVvaZtDXzpbr6dR+6GOLw==
X-Google-Smtp-Source: APXvYqwrOAVOnU7OMk5MtyPLxWlFt3r9kNrFgnMuuxt45gS8mFGw7nKAnqWdVJyx+preTg6WeyxjEA==
X-Received: by 2002:a17:902:322:: with SMTP id 31mr4544289pld.244.1573834045491;
        Fri, 15 Nov 2019 08:07:25 -0800 (PST)
Received: from localhost ([2620:10d:c090:180::a9db])
        by smtp.gmail.com with ESMTPSA id v10sm10527644pfg.11.2019.11.15.08.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 08:07:24 -0800 (PST)
Date:   Fri, 15 Nov 2019 11:07:22 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Rik van Riel <riel@surriel.com>,
        Michal Hocko <mhocko@suse.com>, Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH 2/3] mm: vmscan: detect file thrashing at the reclaim root
Message-ID: <20191115160722.GA309754@cmpxchg.org>
References: <20191107205334.158354-1-hannes@cmpxchg.org>
 <20191107205334.158354-3-hannes@cmpxchg.org>
 <CALvZod5y2NPPg=24q33=ktQqwyUsH1gpwHgROe5z_P+tW74SDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod5y2NPPg=24q33=ktQqwyUsH1gpwHgROe5z_P+tW74SDw@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Nov 14, 2019 at 03:47:59PM -0800, Shakeel Butt wrote:
> On Thu, Nov 7, 2019 at 12:53 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > We use refault information to determine whether the cache workingset
> > is stable or transitioning, and dynamically adjust the inactive:active
> > file LRU ratio so as to maximize protection from one-off cache during
> > stable periods, and minimize IO during transitions.
> >
> > With cgroups and their nested LRU lists, we currently don't do this
> > correctly. While recursive cgroup reclaim establishes a relative LRU
> > order among the pages of all involved cgroups, refaults only affect
> > the local LRU order in the cgroup in which they are occuring. As a
> > result, cache transitions can take longer in a cgrouped system as the
> > active pages of sibling cgroups aren't challenged when they should be.
> >
> > [ Right now, this is somewhat theoretical, because the siblings, under
> >   continued regular reclaim pressure, should eventually run out of
> >   inactive pages - and since inactive:active *size* balancing is also
> >   done on a cgroup-local level, we will challenge the active pages
> >   eventually in most cases. But the next patch will move that relative
> >   size enforcement to the reclaim root as well, and then this patch
> >   here will be necessary to propagate refault pressure to siblings. ]
> >
> > This patch moves refault detection to the root of reclaim. Instead of
> > remembering the cgroup owner of an evicted page, remember the cgroup
> > that caused the reclaim to happen. When refaults later occur, they'll
> > correctly influence the cross-cgroup LRU order that reclaim follows.
> 
> Can you please explain how "they'll correctly influence"? I see that
> if the refaulted page was evicted due to pressure in some ancestor,
> then that's ancestor's refault distance and active file size will be
> used to decide to activate the refaulted page but how that is
> influencing cross-cgroup LRUs?

I take it the next patch answered your question: Activating a page
inside a cgroup has an effect on how it's reclaimed relative to pages
in sibling cgroups. So the influence part isn't new with this change -
it's about recognizing that an activation has an effect on a wider
scope than just the local cgroup, and considering that scope when
making the decision whether to activate or not.

> > @@ -302,6 +330,17 @@ void workingset_refault(struct page *page, void *shadow)
> >          */
> >         refault_distance = (refault - eviction) & EVICTION_MASK;
> >
> > +       /*
> > +        * The activation decision for this page is made at the level
> > +        * where the eviction occurred, as that is where the LRU order
> > +        * during page reclaim is being determined.
> > +        *
> > +        * However, the cgroup that will own the page is the one that
> > +        * is actually experiencing the refault event.
> > +        */
> > +       memcg = get_mem_cgroup_from_mm(current->mm);
> 
> Why not page_memcg(page)? page is locked.

Nice catch! Indeed, the page is charged and locked at this point, so
we don't have to do another lookup and refcounting dance here.

Delta patch:

---

From 8984f37f3e88b1b39c7d6470b313730093b24474 Mon Sep 17 00:00:00 2001
From: Johannes Weiner <hannes@cmpxchg.org>
Date: Fri, 15 Nov 2019 09:14:04 -0500
Subject: [PATCH] mm: vmscan: detect file thrashing at the reclaim root fix

Shakeel points out that the page is locked and already charged by the
time we call workingset_refault(). Instead of doing another cgroup
lookup and reference from current->mm we can simply use page_memcg().

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/workingset.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/mm/workingset.c b/mm/workingset.c
index f0885d9f41cd..474186b76ced 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -338,7 +338,7 @@ void workingset_refault(struct page *page, void *shadow)
 	 * However, the cgroup that will own the page is the one that
 	 * is actually experiencing the refault event.
 	 */
-	memcg = get_mem_cgroup_from_mm(current->mm);
+	memcg = page_memcg(page);
 	lruvec = mem_cgroup_lruvec(memcg, pgdat);
 
 	inc_lruvec_state(lruvec, WORKINGSET_REFAULT);
@@ -349,7 +349,7 @@ void workingset_refault(struct page *page, void *shadow)
 	 * the memory was available to the page cache.
 	 */
 	if (refault_distance > active_file)
-		goto out_memcg;
+		goto out;
 
 	SetPageActive(page);
 	advance_inactive_age(memcg, pgdat);
@@ -360,9 +360,6 @@ void workingset_refault(struct page *page, void *shadow)
 		SetPageWorkingset(page);
 		inc_lruvec_state(lruvec, WORKINGSET_RESTORE);
 	}
-
-out_memcg:
-	mem_cgroup_put(memcg);
 out:
 	rcu_read_unlock();
 }
-- 
2.24.0

