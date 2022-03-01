Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF524C8B72
	for <lists+cgroups@lfdr.de>; Tue,  1 Mar 2022 13:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbiCAMWf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 1 Mar 2022 07:22:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiCAMWe (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 1 Mar 2022 07:22:34 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3027C7BD
        for <cgroups@vger.kernel.org>; Tue,  1 Mar 2022 04:21:51 -0800 (PST)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646137310;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MkBV1p2duSsoNMrj3lAoV1bq8psnWoqvtGtulisyZvo=;
        b=mcYC9YHHcxfeuyhzzO2lCCjI97B1nOA6o7f+Uwyv65FMymcttSPv19lKK0WRBL7AZbZGDw
        aW6/JPK8NCu8HtmmwWYRHP7fqixuYxLvWTUq1f9rpVn7iVBmYicO4A90TRaPIOcr6twDKL
        qSemOLDdQeOQnRgxo1DJdQ8gE/LdYCryxzWTKwbgsKSUjABLA58HvsiEjk9lbGKdwGGeeP
        qIFinPAcZ3zfNrAra3yrn95dgOgUfg5Kwmb9JhPcV1PsLb2NVUrEien6uU7lJKi/UeouhT
        pdD99SBzhNcSGsGFQBCYv9fJBW8cUq6TYYfYBDQIQF5l/5fRlEEk4MEuY32p+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646137310;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MkBV1p2duSsoNMrj3lAoV1bq8psnWoqvtGtulisyZvo=;
        b=zAGbPeMcmFPlhqSZK14/x/lmF/lv2bSohWisuiGxy/cWxSlRLJ0WGfH7uPLUaLnAH1b26F
        iSG1Vg00XVK6LhCg==
To:     cgroups@vger.kernel.org, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 2/2] mm: workingset: Replace IRQ-off check with a lockdep assert.
Date:   Tue,  1 Mar 2022 13:21:43 +0100
Message-Id: <20220301122143.1521823-3-bigeasy@linutronix.de>
In-Reply-To: <20220301122143.1521823-1-bigeasy@linutronix.de>
References: <[PATCH 0/2] Correct locking assumption on PREEMPT_RT>
 <20220301122143.1521823-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Commit
  68d48e6a2df57 ("mm: workingset: add vmstat counter for shadow nodes")

introduced an IRQ-off check to ensure that a lock is held which also
disabled interrupts. This does not work the same way on PREEMPT_RT
because none of the locks, that are held, disable interrupts.

Replace this check with a lockdep assert which ensures that the lock is
held.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 mm/workingset.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/workingset.c b/mm/workingset.c
index 2e4fd7c3296fe..8a3828acc0bfd 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -434,6 +434,8 @@ struct list_lru shadow_nodes;
=20
 void workingset_update_node(struct xa_node *node)
 {
+	struct address_space *mapping;
+
 	/*
 	 * Track non-empty nodes that contain only shadow entries;
 	 * unlink those that contain pages or are being freed.
@@ -442,7 +444,8 @@ void workingset_update_node(struct xa_node *node)
 	 * already where they should be. The list_empty() test is safe
 	 * as node->private_list is protected by the i_pages lock.
 	 */
-	VM_WARN_ON_ONCE(!irqs_disabled());  /* For __inc_lruvec_page_state */
+	mapping =3D container_of(node->array, struct address_space, i_pages);
+	lockdep_assert_held(&mapping->i_pages.xa_lock);
=20
 	if (node->count && node->count =3D=3D node->nr_values) {
 		if (list_empty(&node->private_list)) {
--=20
2.35.1

