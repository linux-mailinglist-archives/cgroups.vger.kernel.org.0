Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 799CC5FC9D9
	for <lists+cgroups@lfdr.de>; Wed, 12 Oct 2022 19:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbiJLRXS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 12 Oct 2022 13:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiJLRXR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 12 Oct 2022 13:23:17 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5CCF33A08
        for <cgroups@vger.kernel.org>; Wed, 12 Oct 2022 10:23:15 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id z8so6086652qtv.5
        for <cgroups@vger.kernel.org>; Wed, 12 Oct 2022 10:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gzjmgre1e1+vrTVLm1NFbUW6zv2WfyHOR2rS1jlu5Bg=;
        b=rseAikHbJJ6W8B692AoRNLHZX5BACwgzRzkBGcT5W0jmSA7CGx1EaMu+JY91yax3zI
         kR1kP9aOuLpOgfDvD85oePRKnLjMMUwtkJUiZfeDHMsfNyPhTGhDn6v0QNRPVYErvreV
         caV3f3Rg16kZBtJjxWig7PM3Rp7r5mgnE6Ik8jzcUIurjuz8/2dCTnNy9AsxbKkMh7+x
         XY6loNL5qx52BPemjcYPYYer9Gy8AwGbq8Zf7A9EKzjCM3AE/F1f9qBsnIusCVKcwRHf
         SFIxbr1ODxMToCrMETdl1hlavxUB9yy1ELtt9HWOqWFo0sHYSxLoYbE45/K+PEfKlhSB
         GY2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gzjmgre1e1+vrTVLm1NFbUW6zv2WfyHOR2rS1jlu5Bg=;
        b=iwRPd9QyXNndvvIS4iPNYGnsQ0VlY2Vm6ZeOtxk29UreCfP4DcpQwza0FQKd50BG3R
         WBycygHI6QzQSJZaNMaQmusbH+cxVRssoezVEwGgjRlwKBC7zCE9Gjj5ZUsxk1O3MmaV
         yamZmh+tIwarDpHcnvbGqXadibichAEm6hwzGYYddmTQqyX/+ImJLvExUNIsfhmk7puO
         WWhAFpIS8Osdo15tVfLJ8L408B1XdUqzfOwAWSmuJKd3i92k7Gjq9iJItPKl6KAWCieu
         8uERl2mfnrC0nkMCB3MUU0JGZ+YtdGAyRv7ANgtEA2R6CyIFq2R9UFITBZ/wZ5xgbAd9
         hPYg==
X-Gm-Message-State: ACrzQf3XtahERNd2OrPh1OYL70XBw3SaOJc+zmiR1hjmboKuxutCSW6F
        TtAmURFacNHw3WmvPt+EnqMhdg==
X-Google-Smtp-Source: AMsMyM6mbuP/iYcRgtjGK/y5fptysYPk18BkGtzL2Xj1Xzf3XfUezsq8vlNDMjTv6uvgioeDNR7I7A==
X-Received: by 2002:ac8:5f52:0:b0:393:752d:b043 with SMTP id y18-20020ac85f52000000b00393752db043mr24718121qta.98.1665595393342;
        Wed, 12 Oct 2022 10:23:13 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::3a61])
        by smtp.gmail.com with ESMTPSA id j9-20020ac85f89000000b00399fe4aac3esm7482244qta.50.2022.10.12.10.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 10:23:12 -0700 (PDT)
Date:   Wed, 12 Oct 2022 13:23:11 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Alexander Fedorov <halcien@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: Possible race in obj_stock_flush_required() vs drain_obj_stock()
Message-ID: <Y0b3/wGDBL7GaNWJ@cmpxchg.org>
References: <1664546131660.1777662787.1655319815@gmail.com>
 <Yzc0yZwDB8GG+4t7@P9FQF9L96D.corp.robot.car>
 <b91e75f4-b09c-85aa-c6ad-2364dab9af92@gmail.com>
 <Yzm5cukBe6IfyAs7@P9FQF9L96D.lan>
 <d3cf9c69-19a1-53f9-cf97-5d40ce5cda44@gmail.com>
 <YzrkaKZKYqx+c325@dhcp22.suse.cz>
 <821923d8-17c3-f1c2-4d6a-5653c88db3e8@gmail.com>
 <YzrxNGpf7sSwSWy2@dhcp22.suse.cz>
 <2f9bdffd-062e-a364-90c4-da7f09c95619@gmail.com>
 <Yzxc0jzOnAu667F8@P9FQF9L96D.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yzxc0jzOnAu667F8@P9FQF9L96D.lan>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Oct 04, 2022 at 09:18:26AM -0700, Roman Gushchin wrote:
> On Mon, Oct 03, 2022 at 06:01:35PM +0300, Alexander Fedorov wrote:
> > On 03.10.2022 17:27, Michal Hocko wrote:
> > > On Mon 03-10-22 17:09:15, Alexander Fedorov wrote:
> > >> On 03.10.2022 16:32, Michal Hocko wrote:
> > >>> On Mon 03-10-22 15:47:10, Alexander Fedorov wrote:
> > >>>> @@ -3197,17 +3197,30 @@ static void drain_obj_stock(struct memcg_stock_pcp *stock)
> > >>>>  		stock->nr_bytes = 0;
> > >>>>  	}
> > >>>>  
> > >>>> -	obj_cgroup_put(old);
> > >>>> +	/*
> > >>>> +	 * Clear pointer before freeing memory so that
> > >>>> +	 * drain_all_stock() -> obj_stock_flush_required()
> > >>>> +	 * does not see a freed pointer.
> > >>>> +	 */
> > >>>>  	stock->cached_objcg = NULL;
> > >>>> +	obj_cgroup_put(old);
> > >>>
> > >>> Do we need barrier() or something else to ensure there is no reordering?
> > >>> I am not reallyu sure what kind of barriers are implied by the pcp ref
> > >>> counting.
> > >>
> > >> obj_cgroup_put() -> kfree_rcu() -> synchronize_rcu() should take care
> > >> of this:
> > > 
> > > This is a very subtle guarantee. Also it would only apply if this is the
> > > last reference, right?
> > 
> > Hmm, yes, for the last reference only, also not sure about pcp ref
> > counter ordering rules for previous references.
> > 
> > > Is there any reason to not use
> > > 	WRITE_ONCE(stock->cached_objcg, NULL);
> > > 	obj_cgroup_put(old);
> > > 
> > > IIRC this should prevent any reordering. 
> > 
> > Now that I think about it we actually must use WRITE_ONCE everywhere
> > when writing cached_objcg because otherwise compiler might split the
> > pointer-sized store into several smaller-sized ones (store tearing),
> > and obj_stock_flush_required() would read garbage instead of pointer.
> >
> > And thinking about memory barriers, maybe we need them too alongside
> > WRITE_ONCE when setting pointer to non-null value?  Otherwise
> > drain_all_stock() -> obj_stock_flush_required() might read old data.
> > Since that's exactly what rcu_assign_pointer() does, it seems
> > that we are going back to using rcu_*() primitives everywhere?
> 
> Hm, Idk, I'm still somewhat resistant to the idea of putting rcu primitives,
> but maybe it's the right thing. Maybe instead we should always schedule draining
> on all cpus instead and perform a cpu-local check and bail out if a flush is not
> required? Michal, Johannes, what do you think?

I agree it's overkill.

This is a speculative check, and we don't need any state coherency,
just basic lifetime. READ_ONCE should fully address this problem. That
said, I think the code could be a bit clearer and better documented.

How about the below?

(Nevermind the ifdef, I'm working on removing CONFIG_MEMCG_KMEM
altogether, as it's a really strange way to say !SLOB at this point)

---

From 22855af38b116ec030286975ed2aa06851680296 Mon Sep 17 00:00:00 2001
From: Johannes Weiner <hannes@cmpxchg.org>
Date: Wed, 12 Oct 2022 12:59:07 -0400
Subject: [PATCH] mm: memcontrol: fix NULL deref race condition during cgroup
 deletion

Alexander Fedorov reports a race condition between two concurrent
stock draining operations, where the first one clears the stock's obj
pointer between the pointer test and deref of the second. Analysis:

1) First CPU:
   css_killed_work_fn() -> mem_cgroup_css_offline() ->
drain_all_stock() -> obj_stock_flush_required()
	if (stock->cached_objcg) {

This check sees a non-NULL pointer for *another* CPU's `memcg_stock` instance.

2) Second CPU:
  css_free_rwork_fn() -> __mem_cgroup_free() -> free_percpu() ->
obj_cgroup_uncharge() -> drain_obj_stock()
It frees `cached_objcg` pointer in its own `memcg_stock` instance:
	struct obj_cgroup *old = stock->cached_objcg;
	< ... >
	obj_cgroup_put(old);
	stock->cached_objcg = NULL;

3) First CPU continues after the 'if' check and re-reads the pointer
again, now it is NULL and dereferencing it leads to kernel panic:
static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
				     struct mem_cgroup *root_memcg)
{
< ... >
	if (stock->cached_objcg) {
		memcg = obj_cgroup_memcg(stock->cached_objcg);

There is already RCU protection in place to ensure lifetime. Add the
missing READ_ONCE to the cgroup pointers to fix the TOCTOU, and
consolidate and document the speculative code.

Reported-by: Alexander Fedorov <halcien@gmail.com>
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/memcontrol.c | 44 ++++++++++++++++++++------------------------
 1 file changed, 20 insertions(+), 24 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 2d8549ae1b30..09ac2f8991ee 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2190,8 +2190,6 @@ static DEFINE_MUTEX(percpu_charge_mutex);
 
 #ifdef CONFIG_MEMCG_KMEM
 static struct obj_cgroup *drain_obj_stock(struct memcg_stock_pcp *stock);
-static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
-				     struct mem_cgroup *root_memcg);
 static void memcg_account_kmem(struct mem_cgroup *memcg, int nr_pages);
 
 #else
@@ -2199,11 +2197,6 @@ static inline struct obj_cgroup *drain_obj_stock(struct memcg_stock_pcp *stock)
 {
 	return NULL;
 }
-static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
-				     struct mem_cgroup *root_memcg)
-{
-	return false;
-}
 static void memcg_account_kmem(struct mem_cgroup *memcg, int nr_pages)
 {
 }
@@ -2339,13 +2332,30 @@ static void drain_all_stock(struct mem_cgroup *root_memcg)
 		struct mem_cgroup *memcg;
 		bool flush = false;
 
+		/*
+		 * Speculatively check up front if this CPU has any
+		 * cached charges that belong to the specified
+		 * root_memcg. The state may change from under us -
+		 * which is okay, because the draining itself is a
+		 * best-effort operation. Just ensure lifetime of
+		 * whatever we end up looking at.
+		 */
 		rcu_read_lock();
-		memcg = stock->cached;
+		memcg = READ_ONCE(stock->cached);
 		if (memcg && stock->nr_pages &&
 		    mem_cgroup_is_descendant(memcg, root_memcg))
 			flush = true;
-		else if (obj_stock_flush_required(stock, root_memcg))
-			flush = true;
+#ifdef CONFIG_MEMCG_KMEM
+		else {
+			struct obj_cgroup *objcg;
+
+			objcg = READ_ONCE(stock->cached_objcg);
+			if (objcg && stock->nr_bytes &&
+			    mem_cgroup_is_descendant(obj_cgroup_memcg(objcg),
+						     root_memcg))
+				flush = true;
+		}
+#endif
 		rcu_read_unlock();
 
 		if (flush &&
@@ -3297,20 +3307,6 @@ static struct obj_cgroup *drain_obj_stock(struct memcg_stock_pcp *stock)
 	return old;
 }
 
-static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
-				     struct mem_cgroup *root_memcg)
-{
-	struct mem_cgroup *memcg;
-
-	if (stock->cached_objcg) {
-		memcg = obj_cgroup_memcg(stock->cached_objcg);
-		if (memcg && mem_cgroup_is_descendant(memcg, root_memcg))
-			return true;
-	}
-
-	return false;
-}
-
 static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
 			     bool allow_uncharge)
 {
-- 
2.37.3

