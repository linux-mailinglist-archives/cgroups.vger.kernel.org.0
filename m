Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF611492D42
	for <lists+cgroups@lfdr.de>; Tue, 18 Jan 2022 19:26:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbiARS0M (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 18 Jan 2022 13:26:12 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:42006 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347803AbiARS0L (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 18 Jan 2022 13:26:11 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E37FB21709;
        Tue, 18 Jan 2022 18:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1642530370; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ge3g8LQjPPjPT4iWHPjDIO/ZDcQCDnvHvSUhi3iQ1rQ=;
        b=OrSB7UBk3Zx97KIJkOYB5/kufBllUFb5h0WOoqblWugIrDuY6fI4jMScI8ZXt28J8tyxS1
        bS38D81tmtfhLt1vAcQlfLpfAqsWk7kcK5h/W40SGY9cXN/ZY7TVfEA3pKjrCwqhplgM/8
        CQJV6oKK94ZSeCnenftUsSkJ0Ok5ARQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BA48C13AC9;
        Tue, 18 Jan 2022 18:26:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rbGALEIG52EsPgAAMHmgww
        (envelope-from <mkoutny@suse.com>); Tue, 18 Jan 2022 18:26:10 +0000
From:   =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To:     bigeasy@linutronix.de
Cc:     akpm@linux-foundation.org, cgroups@vger.kernel.org,
        hannes@cmpxchg.org, linux-mm@kvack.org, longman@redhat.com,
        mhocko@kernel.org, mkoutny@suse.com, peterz@infradead.org,
        tglx@linutronix.de, vdavydov.dev@gmail.com
Subject: [PATCH] mm/memcg: Do not check v1 event counter when not needed
Date:   Tue, 18 Jan 2022 19:26:00 +0100
Message-Id: <20220118182600.15007-1-mkoutny@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <YeE9zyUokSY9L2ZI@linutronix.de>
References: <YeE9zyUokSY9L2ZI@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The function memcg_check_events() is called to trigger possible event
notifications or soft limit updates when page event "clock" moves
sufficiently. This tracking is not needed when neither soft limit nor (v1)
event notifications are configured. The tracking can catch-up
with the clock at any time upon thresholds configuration.

Guard this functionality behind an unlikely static branch (soft limit
and events are presumably rather unused than used).

This has slight insignificant performance gain in page-fault specific
benchmark but overall no performance impact is expected. The goal is to
partition the charging code per provided user functionality.

Suggested-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 mm/memcontrol.c | 8 ++++++++
 1 file changed, 8 insertions(+)


On Fri, Jan 14, 2022 at 10:09:35AM +0100, Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> So avoiding these two also avoids memcg_check_events()?

I've made the matter explicit with the surrounding patch.

[
The performance "gain" is negligible (differences of pft [1] are dominated by
non-root memcg classification):

                         nocg, nopatch            cg, nopatch              nocg, patch              cg, patch
Hmean     faults/sec-2   273366.6312 (   0.00%)   243573.3767 * -10.90%*   273901.9709 *   0.20%*   247702.4104 *  -9.39%*
CoeffVar  faults/sec-2        3.8771 (   0.00%)        3.8396 (   0.97%)        3.1400 (  19.01%)        4.1188 (  -6.24%)

                                                  cg, nopatch                                       cg, patch
Hmean     faults/sec-2                            243573.3767 (   0.00%)                            247702.4104 *   1.70%*
CoeffVar  faults/sec-2                                 3.8396 (   0.00%)                                 4.1188 (  -7.27%)

On less targetted benchmarks it's well below noise.
]

I think it would make sense inserting the patch into your series and
subsequently reject enabling on PREEMPT_RT -- provided this patch makes sense
to others too -- the justification is rather functionality splitting for
this PREEMPT_RT effort.

> Are there plans to remove v1 or is this part of "we must not break
> userland"?

It's part of that mantra, so v1 can't be simply removed. OTOH, my sensing is
that this change also fits under not extending v1 (to avoid doubling effort on
everything).

Michal

[1] https://github.com/gormanm/mmtests/blob/6bcb8b301a48386e0cc63a21f7642048a3ceaed5/configs/config-pagealloc-performance#L6

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 4a7b3ebf8e48..7f64ce33d137 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -106,6 +106,8 @@ static bool do_memsw_account(void)
 #define THRESHOLDS_EVENTS_TARGET 128
 #define SOFTLIMIT_EVENTS_TARGET 1024
 
+DEFINE_STATIC_KEY_FALSE(memcg_v1_events_enabled_key);
+
 /*
  * Cgroups above their limits are maintained in a RB-Tree, independent of
  * their hierarchy representation
@@ -852,6 +854,9 @@ static bool mem_cgroup_event_ratelimit(struct mem_cgroup *memcg,
  */
 static void memcg_check_events(struct mem_cgroup *memcg, int nid)
 {
+	if (!static_branch_unlikely(&memcg_v1_events_enabled_key))
+		return;
+
 	/* threshold event is triggered in finer grain than soft limit */
 	if (unlikely(mem_cgroup_event_ratelimit(memcg,
 						MEM_CGROUP_TARGET_THRESH))) {
@@ -3757,6 +3762,7 @@ static ssize_t mem_cgroup_write(struct kernfs_open_file *of,
 		break;
 	case RES_SOFT_LIMIT:
 		memcg->soft_limit = nr_pages;
+		static_branch_enable(&memcg_v1_events_enabled_key);
 		ret = 0;
 		break;
 	}
@@ -4831,6 +4837,8 @@ static ssize_t memcg_write_event_control(struct kernfs_open_file *of,
 	list_add(&event->list, &memcg->event_list);
 	spin_unlock_irq(&memcg->event_list_lock);
 
+	static_branch_enable(&memcg_v1_events_enabled_key);
+
 	fdput(cfile);
 	fdput(efile);
 
-- 
2.34.1

