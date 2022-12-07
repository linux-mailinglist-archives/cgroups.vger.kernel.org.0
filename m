Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A173645A48
	for <lists+cgroups@lfdr.de>; Wed,  7 Dec 2022 14:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiLGNAq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 7 Dec 2022 08:00:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiLGNAo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 7 Dec 2022 08:00:44 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2633350D73
        for <cgroups@vger.kernel.org>; Wed,  7 Dec 2022 05:00:43 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id d1so27954063wrs.12
        for <cgroups@vger.kernel.org>; Wed, 07 Dec 2022 05:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xR1noXbyPM5kt/sYfkF4dJpSqyLI733A+gni4V3Hl+g=;
        b=yeFZCjZBCI9Jl2kn0mMwm5h3PCNQV0qMVvCmJLEPczp/jvmDAWIfUZZZbfXW/EXohY
         p2XOzLBhN+FZBTdxRVYo44n24EZiyP96Jx5kd/7p3Hc+l8wdcRpierf6Dp49w8DJUQDy
         rlBFc+EHmIFOsMjJqc5U/27MwGIGi1dyA0aOpjKrEGMwSdLG15MR/hFUANlgdcLoVSMy
         tGxtn8JsPnRt/XqqdlJcxbVGkDLHo+cYI60OVm5g44w4aaSGFBdCTWJ5kcy1eAG75Mkg
         tJLpMweFuT/1HwNNf/oHnBgCm87mrMqKt+FPX76ImHI3UkxCCwnkVWry+O/oi/fCry9i
         XXNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xR1noXbyPM5kt/sYfkF4dJpSqyLI733A+gni4V3Hl+g=;
        b=HLiainvteYYcPLYkFxe0E4lRFp1uBmgu4fvs1dMP9YTofr3uHFrjyL/yuD5yAV8hWU
         BR1F+T5Lse+Q4aMGubp7i52PAlc85hTj2k8eC1ahnBCeZpt3qWoXHa/7YO1WPW3VFxoT
         u/xayv25U7Ac2v2L7bqgzA1OfyZ+vyho0BC8pMeoZaE+hi07J82NDy1mZATc1Yf4zabx
         JSi7cjUSuv+LxR6YTjjxPBFppFc6bNJFq/v/aWvNoPYge0HD7SpV2rrR0T6zuZ9PRtoy
         BrNqN9k1lF7sMQG9h/fl+kmiIeBES2EZpt8IfgO4+EPYHvoDH12AzMlKI1oM2tU7ZEtj
         K+bw==
X-Gm-Message-State: ANoB5pkzw6p9CwAFak5kwtUMmoH1+/xVAG2ONYRN8Ftcl4YU+ZNUSg+s
        /pE6vpWdbeeV60HMrMNtNqe5KA==
X-Google-Smtp-Source: AA0mqf5ZqtIW3Nlw0Hn0bcSCxhPju08BUFN33Uu0nIt2jrv6oohoW/Xp5yzOalr4pHN+P7tCxG+4GA==
X-Received: by 2002:a05:6000:1d92:b0:241:6e0a:bfe6 with SMTP id bk18-20020a0560001d9200b002416e0abfe6mr47301524wrb.34.1670418041694;
        Wed, 07 Dec 2022 05:00:41 -0800 (PST)
Received: from localhost (ip-046-005-139-011.um12.pools.vodafone-ip.de. [46.5.139.11])
        by smtp.gmail.com with ESMTPSA id t14-20020a05600c198e00b003cfd4a50d5asm1645753wmq.34.2022.12.07.05.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 05:00:41 -0800 (PST)
Date:   Wed, 7 Dec 2022 14:00:39 +0100
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] mm: memcontrol: deprecate charge moving
Message-ID: <Y5COd+qXwk/S+n8N@cmpxchg.org>
References: <20221206171340.139790-1-hannes@cmpxchg.org>
 <20221206171340.139790-4-hannes@cmpxchg.org>
 <02b9663-4377-bd67-8da2-aad72240da@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02b9663-4377-bd67-8da2-aad72240da@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Dec 06, 2022 at 05:58:14PM -0800, Hugh Dickins wrote:
> On Tue, 6 Dec 2022, Johannes Weiner wrote:
> 
> > Charge moving mode in cgroup1 allows memory to follow tasks as they
> > migrate between cgroups. This is, and always has been, a questionable
> > thing to do - for several reasons.
> > 
> > First, it's expensive. Pages need to be identified, locked and
> > isolated from various MM operations, and reassigned, one by one.
> > 
> > Second, it's unreliable. Once pages are charged to a cgroup, there
> > isn't always a clear owner task anymore. Cache isn't moved at all, for
> > example. Mapped memory is moved - but if trylocking or isolating a
> > page fails, it's arbitrarily left behind. Frequent moving between
> > domains may leave a task's memory scattered all over the place.
> > 
> > Third, it isn't really needed. Launcher tasks can kick off workload
> > tasks directly in their target cgroup. Using dedicated per-workload
> > groups allows fine-grained policy adjustments - no need to move tasks
> > and their physical pages between control domains. The feature was
> > never forward-ported to cgroup2, and it hasn't been missed.
> > 
> > Despite it being a niche usecase, the maintenance overhead of
> > supporting it is enormous. Because pages are moved while they are live
> > and subject to various MM operations, the synchronization rules are
> > complicated. There are lock_page_memcg() in MM and FS code, which
> > non-cgroup people don't understand. In some cases we've been able to
> > shift code and cgroup API calls around such that we can rely on native
> > locking as much as possible. But that's fragile, and sometimes we need
> > to hold MM locks for longer than we otherwise would (pte lock e.g.).
> > 
> > Mark the feature deprecated. Hopefully we can remove it soon.
> > 
> > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> 
> Acked-by: Hugh Dickins <hughd@google.com>

Thanks

> but I wonder if it would be helpful to mention move_charge_at_immigrate
> in the deprecation message: maybe the first line should be
> "Cgroup memory moving (move_charge_at_immigrate) is deprecated.\n"

Fair enough! Here is the updated patch.

---

From 0e791e6ab8ba2f75dd4205684c06bcc7308d9867 Mon Sep 17 00:00:00 2001
From: Johannes Weiner <hannes@cmpxchg.org>
Date: Mon, 5 Dec 2022 19:57:06 +0100
Subject: [PATCH] mm: memcontrol: deprecate charge moving

Charge moving mode in cgroup1 allows memory to follow tasks as they
migrate between cgroups. This is, and always has been, a questionable
thing to do - for several reasons.

First, it's expensive. Pages need to be identified, locked and
isolated from various MM operations, and reassigned, one by one.

Second, it's unreliable. Once pages are charged to a cgroup, there
isn't always a clear owner task anymore. Cache isn't moved at all, for
example. Mapped memory is moved - but if trylocking or isolating a
page fails, it's arbitrarily left behind. Frequent moving between
domains may leave a task's memory scattered all over the place.

Third, it isn't really needed. Launcher tasks can kick off workload
tasks directly in their target cgroup. Using dedicated per-workload
groups allows fine-grained policy adjustments - no need to move tasks
and their physical pages between control domains. The feature was
never forward-ported to cgroup2, and it hasn't been missed.

Despite it being a niche usecase, the maintenance overhead of
supporting it is enormous. Because pages are moved while they are live
and subject to various MM operations, the synchronization rules are
complicated. There are lock_page_memcg() in MM and FS code, which
non-cgroup people don't understand. In some cases we've been able to
shift code and cgroup API calls around such that we can rely on native
locking as much as possible. But that's fragile, and sometimes we need
to hold MM locks for longer than we otherwise would (pte lock e.g.).

Mark the feature deprecated. Hopefully we can remove it soon.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Shakeel Butt <shakeelb@google.com>
Acked-by: Hugh Dickins <hughd@google.com>
Cc: stable@vger.kernel.org
---
 Documentation/admin-guide/cgroup-v1/memory.rst | 11 ++++++++++-
 mm/memcontrol.c                                |  4 ++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/cgroup-v1/memory.rst b/Documentation/admin-guide/cgroup-v1/memory.rst
index 60370f2c67b9..87d7877b98ec 100644
--- a/Documentation/admin-guide/cgroup-v1/memory.rst
+++ b/Documentation/admin-guide/cgroup-v1/memory.rst
@@ -86,6 +86,8 @@ Brief summary of control files.
  memory.swappiness		     set/show swappiness parameter of vmscan
 				     (See sysctl's vm.swappiness)
  memory.move_charge_at_immigrate     set/show controls of moving charges
+                                     This knob is deprecated and shouldn't be
+                                     used.
  memory.oom_control		     set/show oom controls.
  memory.numa_stat		     show the number of memory usage per numa
 				     node
@@ -717,9 +719,16 @@ Soft limits can be setup by using the following commands (in this example we
        It is recommended to set the soft limit always below the hard limit,
        otherwise the hard limit will take precedence.
 
-8. Move charges at task migration
+8. Move charges at task migration (DEPRECATED!)
 =================================
 
+THIS IS DEPRECATED!
+
+It's expensive and unreliable! It's better practice to launch workload
+tasks directly from inside their target cgroup. Use dedicated workload
+cgroups to allow fine-grained policy adjustments without having to
+move physical pages between control domains.
+
 Users can move charges associated with a task along with task migration, that
 is, uncharge task's pages from the old cgroup and charge them to the new cgroup.
 This feature is not supported in !CONFIG_MMU environments because of lack of
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index b696354c1b21..9c9a42153b76 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3919,6 +3919,10 @@ static int mem_cgroup_move_charge_write(struct cgroup_subsys_state *css,
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
 
+	pr_warn_once("Cgroup memory moving (move_charge_at_immigrate) is deprecated. "
+		     "Please report your usecase to linux-mm@kvack.org if you "
+		     "depend on this functionality.\n");
+
 	if (val & ~MOVE_MASK)
 		return -EINVAL;
 
-- 
2.38.1

