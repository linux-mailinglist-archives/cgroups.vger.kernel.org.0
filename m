Return-Path: <cgroups+bounces-15267-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2MjeDCjB3Gn5VwkAu9opvQ
	(envelope-from <cgroups+bounces-15267-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 13 Apr 2026 12:10:48 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D429B3EA5BC
	for <lists+cgroups@lfdr.de>; Mon, 13 Apr 2026 12:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9C95C300C0D5
	for <lists+cgroups@lfdr.de>; Mon, 13 Apr 2026 10:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902753BC68B;
	Mon, 13 Apr 2026 10:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="VCv21jxm"
X-Original-To: cgroups@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B005F3B3898;
	Mon, 13 Apr 2026 10:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776074988; cv=none; b=RqPuUXRlIiviBoJKNDYFlMZORAR9WYs6Io6X7su+qtFeLJOovy+Xx6medC3nuFaz1NUDxHgWU9uE5eYKyza1JL/d0o2jOV0jkrfETM7+jsvB5je9tZcFh3b0cXIMAEzrfU2LbVELEe38hqtLbBjUY76kS+5gWOnttjYXv43Akhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776074988; c=relaxed/simple;
	bh=mM7zBvgBx42iFC8b3TBI95XMtmZTg8a5yacqwUJ3qe8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=JAhWIjBZCdCOCEK2YrgTBpOT42smIhiBLwTTuFa40uaAEk6RhV7pV02GxHeAL9wHGIXYB++rPW449BdNgIt4nHpeLAkMoXJOrtdUGAMlIwmku7/KVlpPRTfgpmfHkeFSyIONVkttC9NovcEK6+znExWDQUsre8Ytv/Kpy1ALN2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=VCv21jxm; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=vSWC/GeLWhifKgmfiRwq3q8ElZnUZcjI/gPacHzC0aw=; b=VCv21jxmLcVGvOwA60MIs8XkT1
	WIQ/aymkI4asw9Itbt1KuONFmXxqnFq5Q19qhNW7pH1MlG8fzasxLCoyKITXqgDxr7TmoB1KR3kWE
	3e78k8SOoJkmiciE9yGKlMcdPMG1gnkqXdVCsbm1OPie4cutNiKHS2ZoJWS9ThTU8qSm0sg2POly1
	cuh8FgnNeeUbM9z1NuN3DZscZsU32GoXEBnv1q6z8jWWUDCRIo9L3DrRCknpG8EyxruHviSgHE4pj
	Llu0752ONDGMe6spjFXtS6/pEf2U+m+2Fg4p0XxvzK0EcX4jbI0bhQIXFTz7pqPfsbYvzz0rbOZMz
	+cnSn3Cg==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wCEEX-00CDUJ-2x;
	Mon, 13 Apr 2026 10:09:34 +0000
From: Breno Leitao <leitao@debian.org>
Date: Mon, 13 Apr 2026 03:09:19 -0700
Subject: [PATCH] mm: blk-cgroup: fix use-after-free in
 cgwb_release_workfn()
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260413-blkcg-v1-1-35b72622d16c@debian.org>
X-B4-Tracking: v=1; b=H4sIAM/A3GkC/6tWKk4tykwtVrJSqFYqSi3LLM7Mz1OyUjDUUVBKz
 kjMS0/VzUxRslJQMjIwMjMwMTTWTcrJTk7XtUyyMDI3MzIxNkgzUdJRUCooSk3LrACbEx0L4Re
 XJmWlJpeANCvV1gIA3XeHQWkAAAA=
X-Change-ID: 20260413-blkcg-9b82762430f4
To: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 shakeel.butt@linux.dev, inwardvessel@gmail.com, hannes@cmpxchg.org, 
 josef@toxicpanda.com, "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 cgroups@vger.kernel.org, martin.lau@linux.dev, usama.arif@linux.dev, 
 kernel-team@meta.com, stable@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.16-dev-453a6
X-Developer-Signature: v=1; a=openpgp-sha256; l=3105; i=leitao@debian.org;
 h=from:subject:message-id; bh=mM7zBvgBx42iFC8b3TBI95XMtmZTg8a5yacqwUJ3qe8=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBp3MDXbEz+UX3X1wznCg47+bMMLUhJuXtNNGS+G
 UDV2+dls6eJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCadzA1wAKCRA1o5Of/Hh3
 bV0QD/sE4UyxgXl5apSWceLym9lfJpaUKx/CuJT54NBvmiXhJsfK0YCrX6agjJv+/FSQnXQrIEH
 gyXtFTRw3Wy6Odt9GG1Pgn7N5ugE5aiA2GXwSC92IVUzYJSyHik7d59F7dzMe6ZLeLN70L852G5
 5eFrewoy5uRVHaFMZmPzSMhpOXw3609WV7NP9cZrrOwEvSQ3xfKmjPKtYuHNWviWsS6HG7N4F+L
 26oqRoGhH75UmRESMoQ5bF20/x5btY0PBZQl/v1WptA4o35ZSpOVbfOG2jlzFFZELMfTEcACUmc
 au5t7C9xbrmM5pTCb4DN2hgRk/+/da8nYE45M6d7ahcRiGb+w+90s8rOogszs3yiR56RSN2fYyA
 bCJ7b0WYuGZUjmHykfim0w2UUzIM6PZeXEwdXy3IUSXQuyEmYdKY+V6BiaYvrEkcAkwOf4xHIA5
 L1g1UH5Fbzbg2ZJywnTyMfsAimsw9FHHMJrE6Hx7uf/ZWlQgWbjI/LHLrR7cx2Gq8op7mGnbfrA
 8VPlUWaND6J0TDH0kQH96ZbbrLtjVJ73kJXDqW6HtOBreFBtYzuYziHtTy02i3lWKNU4NGOs22i
 0jPsw6NlfFLnJriIbYYqzzSxzMszKidANrHwWFIPr34u8PZyyC581LB8bpsS+HJvXOH7+J1ZSb9
 Gu9VbGs88iYZfpQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[debian.org];
	FREEMAIL_TO(0.00)[linux-foundation.org,kernel.org,oracle.com,google.com,suse.com,kernel.dk,linux.dev,gmail.com,cmpxchg.org,toxicpanda.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-15267-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D429B3EA5BC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

cgwb_release_workfn() calls css_put(wb->blkcg_css) and then later
accesses wb->blkcg_css again via blkcg_unpin_online(). If css_put()
drops the last reference, the blkcg can be freed asynchronously
(css_free_rwork_fn -> blkcg_css_free -> kfree) before blkcg_unpin_online()
dereferences the pointer to access blkcg->online_pin, resulting in a
use-after-free:

  BUG: KASAN: slab-use-after-free in blkcg_unpin_online (./include/linux/instrumented.h:112 ./include/linux/atomic/atomic-instrumented.h:400 ./include/linux/refcount.h:389 ./include/linux/refcount.h:432 ./include/linux/refcount.h:450 block/blk-cgroup.c:1367)
  Write of size 4 at addr ff11000117aa6160 by task kworker/71:1/531
   Workqueue: cgwb_release cgwb_release_workfn
   Call Trace:
    <TASK>
     blkcg_unpin_online (./include/linux/instrumented.h:112 ./include/linux/atomic/atomic-instrumented.h:400 ./include/linux/refcount.h:389 ./include/linux/refcount.h:432 ./include/linux/refcount.h:450 block/blk-cgroup.c:1367)
     cgwb_release_workfn (mm/backing-dev.c:629)
     process_scheduled_works (kernel/workqueue.c:3278 kernel/workqueue.c:3385)

   Freed by task 1016:
    kfree (./include/linux/kasan.h:235 mm/slub.c:2689 mm/slub.c:6246 mm/slub.c:6561)
    css_free_rwork_fn (kernel/cgroup/cgroup.c:5542)
    process_scheduled_works (kernel/workqueue.c:3302 kernel/workqueue.c:3385)

** Stack based on commit 66672af7a095 ("Add linux-next specific files
for 20260410")

I am seeing this crash sporadically in Meta fleet across multiple
kernel versions. A full reproducer is available at:
https://github.com/leitao/debug/blob/main/reproducers/repro_blkcg_uaf.sh

(The race window is narrow. To make it easily reproducible, inject
a msleep(100) between css_put() and blkcg_unpin_online() in
cgwb_release_workfn(). With that delay and a KASAN-enabled kernel, the
reproducer triggers the splat reliably in less than a second.)

Fix this by moving blkcg_unpin_online() before css_put(), so the
cgwb's CSS reference keeps the blkcg alive while blkcg_unpin_online()
accesses it.

Fixes: 59b57717fff8 ("blkcg: delay blkg destruction until after writeback has finished")
Cc: stable@vger.kernel.org
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 mm/backing-dev.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 7a18fa6c72725..cecbcf9060a65 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -618,12 +618,13 @@ static void cgwb_release_workfn(struct work_struct *work)
 	wb_shutdown(wb);
 
 	css_put(wb->memcg_css);
-	css_put(wb->blkcg_css);
-	mutex_unlock(&wb->bdi->cgwb_release_mutex);
 
 	/* triggers blkg destruction if no online users left */
 	blkcg_unpin_online(wb->blkcg_css);
 
+	css_put(wb->blkcg_css);
+	mutex_unlock(&wb->bdi->cgwb_release_mutex);
+
 	fprop_local_destroy_percpu(&wb->memcg_completions);
 
 	spin_lock_irq(&cgwb_lock);

---
base-commit: 66672af7a095d89f082c5327f3b15bc2f93d558e
change-id: 20260413-blkcg-9b82762430f4

Best regards,
--  
Breno Leitao <leitao@debian.org>


