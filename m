Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA89522308
	for <lists+cgroups@lfdr.de>; Tue, 10 May 2022 19:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343502AbiEJRrn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 10 May 2022 13:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241938AbiEJRrm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 10 May 2022 13:47:42 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478A6267C0C;
        Tue, 10 May 2022 10:43:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EA9DF1F8C6;
        Tue, 10 May 2022 17:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1652204622; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u1whn4lbU6iVVflTZcVGrO43VdILAmiKvJmX0VyooKo=;
        b=MGKHbxCeHphlHKb4O8pw0mUgVlGBvE/udt9yYT5XSXjFAViZaUhM99PfoAdSQqPaGswXyF
        Y5tmVVRjt3whErQQNDqDMNCmjEYAHz7dQPvG3ur4lGFo6+2ZZSaXikho387KG2m1BDY84b
        aY1Pxop+HSelwIr3m8X26Ice7l9tYKI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A60C913AC1;
        Tue, 10 May 2022 17:43:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rf3CJk6kemLFIgAAMHmgww
        (envelope-from <mkoutny@suse.com>); Tue, 10 May 2022 17:43:42 +0000
Date:   Tue, 10 May 2022 19:43:41 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        David Vernet <void@manifault.com>, tj@kernel.org,
        roman.gushchin@linux.dev, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org, mhocko@kernel.org,
        shakeelb@google.com, kernel-team@fb.com,
        Richard Palethorpe <rpalethorpe@suse.com>,
        Chris Down <chris@chrisdown.name>
Subject: Re: [PATCH v2 2/5] cgroup: Account for memory_recursiveprot in
 test_memcg_low()
Message-ID: <20220510174341.GC24172@blackbody.suse.cz>
References: <20220423155619.3669555-1-void@manifault.com>
 <20220423155619.3669555-3-void@manifault.com>
 <20220427140928.GD9823@blackbody.suse.cz>
 <20220429010333.5rt2jwpiumnbuapf@dev0025.ash9.facebook.com>
 <20220429092620.GA23621@blackbody.suse.cz>
 <20220506164015.fsdsuv226nhllos5@dev0025.ash9.facebook.com>
 <Ynkum8DeJIAtGi9y@cmpxchg.org>
 <20220509174424.e43e695ffe0f7333c187fba8@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220509174424.e43e695ffe0f7333c187fba8@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello all.

On Mon, May 09, 2022 at 05:44:24PM -0700, Andrew Morton <akpm@linux-foundation.org> wrote:
> So I think we're OK with [2/5] now.  Unless there be objections, I'll
> be looking to get this series into mm-stable later this week.

I'm sorry, I think the current form of the test reveals an unexpected
behavior of reclaim and silencing the test is not the way to go.
Although, I may be convinced that my understanding is wrong.


On Mon, May 09, 2022 at 11:09:15AM -0400, Johannes Weiner <hannes@cmpxchg.org> wrote:
> My understanding of the issue you're raising, Michal, is that
> protected siblings start with current > low, then get reclaimed
> slightly too much and end up with current < low. This results in a
> tiny bit of float that then gets assigned to the low=0 sibling; 

Up until here, we're on the same page.

> when that sibling gets reclaimed regardless, it sees a low event.
> Correct me if I missed a detail or nuance here.

Here, I'd like to stress that the event itself is just a messenger (whom
my original RFC patch attempted to get rid of). The problem is that if
the sibling with recursive protection is active enough to claim it, it's
effectively stolen from the passive sibling. See the comparison of
'precious' vs 'victim' in [1].

> But unused float going to siblings is intentional. This is documented
> in point 3 in the comment above effective_protection(): if you use
> less than you're legitimately claiming, the float goes to your
> siblings.

The problem is how the unused protection came to be (voluntarily not
consumed vs reclaimed).

> So the problem doesn't seem to be with low accounting and
> event generation, but rather it's simply overreclaim.

Exactly.

> It's conceivable to make reclaim more precise and then tighten up the
> test. But right now, David's patch looks correct to me.

The obvious fix is at the end of this message, it resolves the case I
posted earlier (with memory_recursiveprot), however, it "breaks"
memory.events:low accounting inside recursive children, hence I'm not
considering it finished. (I may elaborate on the breaking case if
interested, I also need to look more into that myself).


On Fri, May 06, 2022 at 09:40:15AM -0700, David Vernet <void@manifault.com> wrote:
> If you look at how much memory A/B/E gets at the end of the reclaim,
> it's still far less than 1MB (though should it be 0?).

This selftest has two ±equal workloads in siblings, however, if their
activity varies, it can end up even opposite (the example [1]).

> This definitely sounds to me like a useful testcase to add, and I'm
> happy to do so in a follow-on patch. If we added this, do you think
> we need to keep the check for memory.low events for the memory.low ==
> 0 child in the overcommit testcase?

I think it's still useful, to check the behavior when inherited vs
explicit siblings coexist under protected parent.
Actually, the second case of all siblings having the inherited
(implicit) protection is also interesting (it seems that's that I'm
seeing in my tests with the attached patch).

+Cc: Chris, who reasoned about the SWAP_CLUSTER_MAX rounding vs too high
priority (too low numerically IIUC) [2].

Michal

[1] https://lore.kernel.org/r/20220325103118.GC2828@blackbody.suse.cz/
[2] https://lore.kernel.org/all/20190128214213.GB15349@chrisdown.name/

--- 8< ---
From e18caf7a5a1b0f39185fbdc11e4034def42cde88 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Date: Tue, 10 May 2022 18:48:31 +0200
Subject: [RFC PATCH] mm: memcg: Do not overreclaim SWAP_CLUSTER_MAX from
 protected memcg
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This was observed with memcontrol selftest/new LTP test but can be also
reproduced in simplified setup of two siblings:

	`parent .low=50M
	  ` s1	.low=50M  .current=50M+ε
	  ` s2  .low=0M   .current=50M

The expectation is that s2/memory.events:low will be zero under outer
reclaimer since no protection should be given to cgroup s2 (even with
memory_recursiveprot).

However, this does not happen. The apparent reason is that when s1 is
considered for (proportional) reclaim the scanned proportion is rounded
up to SWAP_CLUSTER_MAX and slightly over-proportional amount is
reclaimed. Consequently, when the effective low value of s2 is
calculated, it observes unclaimed parent's protection from s1
(ε-SWAP_CLUSTER_MAX in theory) and effectively appropriates it.

What is worse, when the sibling s2 has more (memory) greedy workload, it
can repeatedly "steal" the protection from s1 and the distribution ends
up with s1 mostly reclaimed despite explicit prioritization over s2.

Simply fix it by _not_ rounding up to SWAP_CLUSTER_MAX. This would have
saved us ~5 levels of reclaim priority. I.e. we may be reclaiming from
protected memcgs at relatively low priority _without_ counting any
memory.events:low (due to overreclaim). Now, if the moderated scan is
not enough, we must bring priority to zero to open protected reserves.
And that's correct, we want to be explicit when reclaiming those.


Fixes: 8a931f801340 ("mm: memcontrol: recursive memory.low protection")
Fixes: 9783aa9917f8 ("mm, memcg: proportional memory.{low,min} reclaim")
Reported-by: Richard Palethorpe <rpalethorpe@suse.com>
Link: https://lore.kernel.org/all/20220321101429.3703-1-rpalethorpe@suse.com/
Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 mm/vmscan.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 1678802e03e7..cd760842b9ad 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2798,13 +2798,6 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
 
 			scan = lruvec_size - lruvec_size * protection /
 				(cgroup_size + 1);
-
-			/*
-			 * Minimally target SWAP_CLUSTER_MAX pages to keep
-			 * reclaim moving forwards, avoiding decrementing
-			 * sc->priority further than desirable.
-			 */
-			scan = max(scan, SWAP_CLUSTER_MAX);
 		} else {
 			scan = lruvec_size;
 		}
-- 
2.35.3


