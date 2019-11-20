Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5F881045E3
	for <lists+cgroups@lfdr.de>; Wed, 20 Nov 2019 22:39:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbfKTVje (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 20 Nov 2019 16:39:34 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33693 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbfKTVje (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 20 Nov 2019 16:39:34 -0500
Received: by mail-qt1-f196.google.com with SMTP id y39so1264131qty.0
        for <cgroups@vger.kernel.org>; Wed, 20 Nov 2019 13:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=F4UOOlylYKA4x5XwS/IcSHBpAnEOvDZz0DmXXFZBpcA=;
        b=HWlZvj1c8bNqbGRODv0AgUEGYJvuTzXv3y+PxWcWyLnvLfcKURUZIzxXfU266k3473
         zbm+2dXSBVQG2y2z1Oz1GVrmV3K4GqVzfEG7zivXUO+Tam1zvCqDHyjQpjdWw5WCQwLm
         lzbmvkCSZzNFsiSddiHgU/kP3GzsDD8kMA6FBzb/GPXKxoZTvK43OXZwWhrLYABsdeLv
         GZzAl8OT/xf1vbkEt4gyPza/zcf80oiyWvZOoFYYtZA3z2QPhwDT+f6UtVa8Ol7zZ6Xd
         Z9ETSaZqziR1SUsWpnqyTYIPJuX9pTSwaZV0jCr+JJoXoHoF6WNgYWqzHywVVMTJWeDm
         6YrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=F4UOOlylYKA4x5XwS/IcSHBpAnEOvDZz0DmXXFZBpcA=;
        b=oePGPfb+hl9olLkIghNAyL37rjC1km6r7k8B4BPo7MokNoAIRjLyZeih+3zSJzHbtT
         w1KX2uhx7q4JQ0geniUe9bSHKJiLmHlRv+XyhggW1noliRME17rr+cROPMEjas6H/oAv
         xK+l/bAS3PTJbDScHAqs12crG2XR8iA4KziYHXn0KHEqDFDCaBFbnIjBR2z0c9OnN/s/
         Vrcg6VGLx0kFRgrRnycPiChbxsNinX2Nspu0PJynw0g6i/78ytuu9pxxaw6cXHEc2haI
         qr2h8c56kf/Lq93oHdmRoflxMJyloMbT9sZ1EwhuaCUp9AVvYhFxqeAI+NOcjP/tht2d
         ksyw==
X-Gm-Message-State: APjAAAUOOSLknzNNEbRmfsT25DIF6XfDG0/a13NrGhlqLdTIjxvUnOCk
        42MOQjqd4me15gqTFXsNS6P53g==
X-Google-Smtp-Source: APXvYqylwjRzk+9exZgAIoBdfXGoEfLJGEmoJMQ2QoZKaVar53f/0Ed1XtazpN8A8Z6EAMlIaWC4vw==
X-Received: by 2002:ac8:6697:: with SMTP id d23mr4730012qtp.32.1574285973134;
        Wed, 20 Nov 2019 13:39:33 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::6900])
        by smtp.gmail.com with ESMTPSA id l11sm199918qtq.20.2019.11.20.13.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 13:39:32 -0800 (PST)
Date:   Wed, 20 Nov 2019 16:39:31 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Roman Gushchin <guro@fb.com>, Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH] mm: fix unsafe page -> lruvec lookups with cgroup charge
 migration
Message-ID: <20191120213931.GB428283@cmpxchg.org>
References: <20191120165847.423540-1-hannes@cmpxchg.org>
 <CALvZod50AanTCNkTVSptU+Hg--69j6OuKdc04UPs4Vf64DkGiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod50AanTCNkTVSptU+Hg--69j6OuKdc04UPs4Vf64DkGiw@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Nov 20, 2019 at 12:31:06PM -0800, Shakeel Butt wrote:
> On Wed, Nov 20, 2019 at 8:58 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > While reviewing the "per lruvec lru_lock for memcg" series, Hugh and I
> > noticed two places in the existing code where the page -> memcg ->
> > lruvec lookup can result in a use-after-free bug. This affects cgroup1
> > setups that have charge migration enabled.
> >
> > To pin page->mem_cgroup, callers need to either have the page locked,
> > an exclusive refcount (0), or hold the lru_lock and "own" PageLRU
> > (either ensure it's set, or be the one to hold the page in isolation)
> > to make cgroup migration fail the isolation step.
> 
> I think we should add the above para in the comments for better visibility.

Good idea. I'm attaching a delta patch below.

> > Reported-by: Hugh Dickins <hughd@google.com>
> > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> 
> Reviewed-by: Shakeel Butt <shakeelb@google.com>

Thanks!

---
From 73b58ce09009cce668ea97d9e047611c60e95bd6 Mon Sep 17 00:00:00 2001
From: Johannes Weiner <hannes@cmpxchg.org>
Date: Wed, 20 Nov 2019 16:36:03 -0500
Subject: [PATCH] mm: fix unsafe page -> lruvec lookups with cgroup charge
 migration fix

Better document the mem_cgroup_page_lruvec() caller requirements.

Suggested-by: Shakeel Butt <shakeelb@google.com>
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/memcontrol.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 50f5bc55fcec..2d700fa0d7f4 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1202,9 +1202,18 @@ int mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
  * @page: the page
  * @pgdat: pgdat of the page
  *
- * This function is only safe when following the LRU page isolation
- * and putback protocol: the LRU lock must be held, and the page must
- * either be PageLRU() or the caller must have isolated/allocated it.
+ * NOTE: The returned lruvec is only stable if the calling context has
+ * the page->mem_cgroup pinned! This is accomplished by satisfying one
+ * of the following criteria:
+ *
+ *    a) have the @page locked
+ *    b) have an exclusive reference to @page (e.g. refcount 0)
+ *    c) hold the lru_lock and "own" the PageLRU (meaning either ensure
+ *       it's set, or be the one to hold the page in isolation)
+ *
+ * Otherwise, the page could be freed or moved out of the memcg,
+ * thereby releasing its reference on the memcg and potentially
+ * freeing it and its lruvecs in the process.
  */
 struct lruvec *mem_cgroup_page_lruvec(struct page *page, struct pglist_data *pgdat)
 {
-- 
2.24.0

