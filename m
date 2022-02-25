Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D430F4C51E5
	for <lists+cgroups@lfdr.de>; Sat, 26 Feb 2022 00:01:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239178AbiBYXCZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 25 Feb 2022 18:02:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233602AbiBYXCZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 25 Feb 2022 18:02:25 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8782C21DF31
        for <cgroups@vger.kernel.org>; Fri, 25 Feb 2022 15:01:51 -0800 (PST)
Date:   Sat, 26 Feb 2022 00:01:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1645830109;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eLa2DAYUTcrHbqT9bu1hfoW/mNp9mXnBGQU+a1wSrFo=;
        b=HhsLwetpyGJFs2/zxUDRAIa9PNAY1BbeDq4Evc1MkFnyHxdsK9dPIGZ5i5aOL/PMFUKjcf
        xD98AWfMqYC4sVIM0nS2UWlgfRWFUBXx1ZiXNhbpk/zgbnSh2R1Z4uxpaqPorZdUW3xZLe
        5pZ5qdjKjGXuC8DcSaZFPEI6x30V3gqq1W7ACNSKObCrRYztOR4Nc/5oQFb/0Xy08JfL9r
        tGNADO9A++ZGKr3o27100KF1QLAqfdpLFTqKFaIfU/qwkTmyifIjzGlhCe7BK7fKUvChM4
        giy/Z1CmicL/cNNwdvrLbIVN0Ik56EGLc61frE66jHcxamyBurt3hhZWjsY1fA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1645830109;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eLa2DAYUTcrHbqT9bu1hfoW/mNp9mXnBGQU+a1wSrFo=;
        b=AsKrXs5arxs4uQjRegtTn8SRZAH3B1ZW9zg7LO4+o3PsHyiYRVcHitgVNhuY9ybY7Cuu9a
        OiRIivkR/0QEkzCg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>, Roman Gushchin <guro@fb.com>
Subject: [PATCH] mm/memcg: Only perform the debug checks on !PREEMPT_RT
Message-ID: <Yhlf29/HqyNMOvGb@linutronix.de>
References: <20220221182540.380526-1-bigeasy@linutronix.de>
 <20220221182540.380526-4-bigeasy@linutronix.de>
 <CALvZod7DfxHp+_NenW+NY81WN_Li4kEx4rDodb2vKhpC==sd5g@mail.gmail.com>
 <YhjzE/8LgbULbj/C@linutronix.de>
 <CALvZod48Tp7i_BbA4Um57m989iuFU5kSvbzLhSOUt23_CiWmjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALvZod48Tp7i_BbA4Um57m989iuFU5kSvbzLhSOUt23_CiWmjw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On PREEMPT_RT interrupts and preemption is always enabled. The locking
function __memcg_stats_lock() always disabled preemptions. The recently
added checks need to performed only on !PREEMPT_RT where preemption and
disabled interrupts are used.

Please fold into:
	"Protect per-CPU counter by disabling preemption on PREEMPT_RT"

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---

Andrew, if this getting to confused at some point, I can fold it myself
and repost the whole lot. Whatever works best for your.

 mm/memcontrol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 73832cd1e9da4..63287fd03250b 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -741,7 +741,7 @@ void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
 	 * interrupt context while other caller need to have disabled interrupt.
 	 */
 	__memcg_stats_lock();
-	if (IS_ENABLED(CONFIG_DEBUG_VM)) {
+	if (IS_ENABLED(CONFIG_DEBUG_VM) && !IS_ENABLED(CONFIG_PREEMPT_RT)) {
 		switch (idx) {
 		case NR_ANON_MAPPED:
 		case NR_FILE_MAPPED:
-- 
2.35.1
