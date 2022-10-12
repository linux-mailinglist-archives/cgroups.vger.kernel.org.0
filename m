Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6C1D5FCB65
	for <lists+cgroups@lfdr.de>; Wed, 12 Oct 2022 21:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbiJLTSa (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 12 Oct 2022 15:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbiJLTS3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 12 Oct 2022 15:18:29 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E9DD8EC2
        for <cgroups@vger.kernel.org>; Wed, 12 Oct 2022 12:18:27 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id l19so11508432qvu.4
        for <cgroups@vger.kernel.org>; Wed, 12 Oct 2022 12:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xTWRUnDxg5WQLtUKHyxIbDJqKoru4qK1Fda+GBVPdWs=;
        b=u6/Evi3Ua3Qff121cxWdTbUpOWna2SmUTmaAyYLtOBehmRseUhhwcXPIkTslo5YKZx
         SGyGqt2H0Vkp/h7VvL6UQCd9tVBFXIcR/JjXOKezzByudNNKG8RNsmS1Wdo7rTbtzJgi
         3IBDuQ8Fei8y2bKPPKQKFN76OofdAqxwo6ucWDABxTIDqiQo9JoKCIqgnDfdP+A6GdYd
         E6IDTkZMzoXa3HnAAhSQqTxCw3Zj6R0SMmF9kSYTSEtmEFD5UuQ48Ss5dhbcIXFSU4qv
         wePlXqf/7AT8sZWV4Sl2tYaiUgy3X5Fl/8S9j1AuKo8+Hkdgi+hfnmEi5YNeOqDeaBf1
         JJ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xTWRUnDxg5WQLtUKHyxIbDJqKoru4qK1Fda+GBVPdWs=;
        b=BC7QGey8ONdc6CuqUOxwBBeO8WdLYtHF5tWDVGNqzuZvtByl09STaGgfEMhOuvD7aZ
         TvBQZHSLRyselhk9y6pT2Mkn0AuPcin118urLe++kMcM7l7b135AzGRjAKelohwHyB/q
         vFoIpXJS/hYlTI0Xn+R2AJRMV+qAk/Bep1gzUSz0PUITDQH/wxU45aqINu5LHrQ1UfCy
         HpZtDNw7mBaaAdy/khXzo0hhc2VeL8815x4Gd9i1Cf2FEWPnQolC1i3L/GO1lNV31g6p
         hO/AJyOokCSZ/oOgr2YMN7HjsSLS7z0YS3OVKj4CqZHNHGHK1LBiolFvd6BMJa+o0UJY
         kj3g==
X-Gm-Message-State: ACrzQf1c/JgTov20bZ5JmmvE3LqGE7m/YLptN47EuK5GY3X+x0QxajbW
        xegW597tI33dmV3O+lKcNHun6Q==
X-Google-Smtp-Source: AMsMyM7dd7vMt6MMSA9eogk+qE4CpLTBmG4RZRzTCcW2zB6q8muh7+H+8Rp+ky+maTbshi0EMmGlfQ==
X-Received: by 2002:a05:6214:caf:b0:4b1:7904:5425 with SMTP id s15-20020a0562140caf00b004b179045425mr24968643qvs.32.1665602306994;
        Wed, 12 Oct 2022 12:18:26 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::3a61])
        by smtp.gmail.com with ESMTPSA id c2-20020ac87dc2000000b0039a8b075248sm6946364qte.14.2022.10.12.12.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 12:18:26 -0700 (PDT)
Date:   Wed, 12 Oct 2022 15:18:25 -0400
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
Message-ID: <Y0cTAdntxrn8zFbX@cmpxchg.org>
References: <b91e75f4-b09c-85aa-c6ad-2364dab9af92@gmail.com>
 <Yzm5cukBe6IfyAs7@P9FQF9L96D.lan>
 <d3cf9c69-19a1-53f9-cf97-5d40ce5cda44@gmail.com>
 <YzrkaKZKYqx+c325@dhcp22.suse.cz>
 <821923d8-17c3-f1c2-4d6a-5653c88db3e8@gmail.com>
 <YzrxNGpf7sSwSWy2@dhcp22.suse.cz>
 <2f9bdffd-062e-a364-90c4-da7f09c95619@gmail.com>
 <Yzxc0jzOnAu667F8@P9FQF9L96D.lan>
 <Y0b3/wGDBL7GaNWJ@cmpxchg.org>
 <Y0cMMPwE4aus3P9c@P9FQF9L96D.corp.robot.car>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0cMMPwE4aus3P9c@P9FQF9L96D.corp.robot.car>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Oct 12, 2022 at 11:49:20AM -0700, Roman Gushchin wrote:
> On Wed, Oct 12, 2022 at 01:23:11PM -0400, Johannes Weiner wrote:
> > On Tue, Oct 04, 2022 at 09:18:26AM -0700, Roman Gushchin wrote:
> > > On Mon, Oct 03, 2022 at 06:01:35PM +0300, Alexander Fedorov wrote:
> > > > On 03.10.2022 17:27, Michal Hocko wrote:
> > > > > On Mon 03-10-22 17:09:15, Alexander Fedorov wrote:
> > > > >> On 03.10.2022 16:32, Michal Hocko wrote:
> > > > >>> On Mon 03-10-22 15:47:10, Alexander Fedorov wrote:
> > > > >>>> @@ -3197,17 +3197,30 @@ static void drain_obj_stock(struct memcg_stock_pcp *stock)
> > > > >>>>  		stock->nr_bytes = 0;
> > > > >>>>  	}
> > > > >>>>  
> > > > >>>> -	obj_cgroup_put(old);
> > > > >>>> +	/*
> > > > >>>> +	 * Clear pointer before freeing memory so that
> > > > >>>> +	 * drain_all_stock() -> obj_stock_flush_required()
> > > > >>>> +	 * does not see a freed pointer.
> > > > >>>> +	 */
> > > > >>>>  	stock->cached_objcg = NULL;
> > > > >>>> +	obj_cgroup_put(old);
> > > > >>>
> > > > >>> Do we need barrier() or something else to ensure there is no reordering?
> > > > >>> I am not reallyu sure what kind of barriers are implied by the pcp ref
> > > > >>> counting.
> > > > >>
> > > > >> obj_cgroup_put() -> kfree_rcu() -> synchronize_rcu() should take care
> > > > >> of this:
> > > > > 
> > > > > This is a very subtle guarantee. Also it would only apply if this is the
> > > > > last reference, right?
> > > > 
> > > > Hmm, yes, for the last reference only, also not sure about pcp ref
> > > > counter ordering rules for previous references.
> > > > 
> > > > > Is there any reason to not use
> > > > > 	WRITE_ONCE(stock->cached_objcg, NULL);
> > > > > 	obj_cgroup_put(old);
> > > > > 
> > > > > IIRC this should prevent any reordering. 
> > > > 
> > > > Now that I think about it we actually must use WRITE_ONCE everywhere
> > > > when writing cached_objcg because otherwise compiler might split the
> > > > pointer-sized store into several smaller-sized ones (store tearing),
> > > > and obj_stock_flush_required() would read garbage instead of pointer.
> > > >
> > > > And thinking about memory barriers, maybe we need them too alongside
> > > > WRITE_ONCE when setting pointer to non-null value?  Otherwise
> > > > drain_all_stock() -> obj_stock_flush_required() might read old data.
> > > > Since that's exactly what rcu_assign_pointer() does, it seems
> > > > that we are going back to using rcu_*() primitives everywhere?
> > > 
> > > Hm, Idk, I'm still somewhat resistant to the idea of putting rcu primitives,
> > > but maybe it's the right thing. Maybe instead we should always schedule draining
> > > on all cpus instead and perform a cpu-local check and bail out if a flush is not
> > > required? Michal, Johannes, what do you think?
> > 
> > I agree it's overkill.
> > 
> > This is a speculative check, and we don't need any state coherency,
> > just basic lifetime. READ_ONCE should fully address this problem. That
> > said, I think the code could be a bit clearer and better documented.
> > 
> > How about the below?
> 
> I'm fine with using READ_ONCE() to fix this immediate issue (I suggested it
> in the thread above), please feel free to add my ack:
> Acked-by: Roman Gushchin <roman.gushchin@linux.dev> .

Thanks!

> We might need a barrier() between zeroing stock->cached and dropping the last
> reference, as discussed above, however I don't think this issue can be
> realistically trgiggered in the real life.

Hm, plus the load tearing.

We can do WRITE_ONCE() just for ->cached and ->cached_objcg. That will
take care of both: load tearing, as well as the compile-time order
with the RCU free call. RCU will then handle the SMP effects.

I still prefer it over rcuifying the pointers completely just for that
one (questionable) optimization.

Updated patch below.

> However I think our overall approach to flushing is questionable:
> 1) we often don't flush when it's necessary: if there is a concurrent flushing
> we just bail out, even if that flushing is related to a completely different
> part of the cgroup tree (e.g. a leaf node belonging to a distant branch).

Right.

> 2) we can race and flush when it's not necessarily: if another cpu is busy,
> likely by the time when work will be executed there will be already another
> memcg cached. So IMO we need to move this check into the flushing thread.

We might just be able to remove all the speculative
checks. drain_all_stock() is slowpath after all...

> I'm working on a different approach, but it will take time and also likely be
> too invasive for @stable, so fixing the crash discovered by Alexander with
> READ_ONCE() is a good idea.

Sounds good, I'm looking forward to those changes.

---

From c9b940db5f75160b5e80c4ae83ea760ad29e8ef9 Mon Sep 17 00:00:00 2001
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
Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 mm/memcontrol.c | 54 +++++++++++++++++++++++--------------------------
 1 file changed, 25 insertions(+), 29 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 2d8549ae1b30..4357dadae95d 100644
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
@@ -2259,8 +2252,8 @@ static void drain_stock(struct memcg_stock_pcp *stock)
 		stock->nr_pages = 0;
 	}
 
+	WRITE_ONCE(stock->cached, NULL);
 	css_put(&old->css);
-	stock->cached = NULL;
 }
 
 static void drain_local_stock(struct work_struct *dummy)
@@ -2298,7 +2291,7 @@ static void __refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 	if (stock->cached != memcg) { /* reset if necessary */
 		drain_stock(stock);
 		css_get(&memcg->css);
-		stock->cached = memcg;
+		WRITE_ONCE(stock->cached, memcg);
 	}
 	stock->nr_pages += nr_pages;
 
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
@@ -3170,7 +3180,7 @@ void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
 		obj_cgroup_get(objcg);
 		stock->nr_bytes = atomic_read(&objcg->nr_charged_bytes)
 				? atomic_xchg(&objcg->nr_charged_bytes, 0) : 0;
-		stock->cached_objcg = objcg;
+		WRITE_ONCE(stock->cached_objcg, objcg);
 		stock->cached_pgdat = pgdat;
 	} else if (stock->cached_pgdat != pgdat) {
 		/* Flush the existing cached vmstat data */
@@ -3289,7 +3299,7 @@ static struct obj_cgroup *drain_obj_stock(struct memcg_stock_pcp *stock)
 		stock->cached_pgdat = NULL;
 	}
 
-	stock->cached_objcg = NULL;
+	WRITE_ONCE(stock->cached_objcg, NULL);
 	/*
 	 * The `old' objects needs to be released by the caller via
 	 * obj_cgroup_put() outside of memcg_stock_pcp::stock_lock.
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
@@ -3325,7 +3321,7 @@ static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
 	if (stock->cached_objcg != objcg) { /* reset if necessary */
 		old = drain_obj_stock(stock);
 		obj_cgroup_get(objcg);
-		stock->cached_objcg = objcg;
+		WRITE_ONCE(stock->cached_objcg, objcg);
 		stock->nr_bytes = atomic_read(&objcg->nr_charged_bytes)
 				? atomic_xchg(&objcg->nr_charged_bytes, 0) : 0;
 		allow_uncharge = true;	/* Allow uncharge when objcg changes */
-- 
2.37.3

