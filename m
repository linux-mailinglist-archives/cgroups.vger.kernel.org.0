Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAE7CA8776
	for <lists+cgroups@lfdr.de>; Wed,  4 Sep 2019 21:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730436AbfIDNx3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 4 Sep 2019 09:53:29 -0400
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:59498 "EHLO
        forwardcorp1o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730457AbfIDNxZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 4 Sep 2019 09:53:25 -0400
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net [IPv6:2a02:6b8:0:1402::301])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 182CE2E1AF9;
        Wed,  4 Sep 2019 16:53:23 +0300 (MSK)
Received: from smtpcorp1p.mail.yandex.net (smtpcorp1p.mail.yandex.net [2a02:6b8:0:1472:2741:0:8b6:10])
        by mxbackcorp1g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id aEmyyOzLzc-rMC8F2bH;
        Wed, 04 Sep 2019 16:53:23 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1567605203; bh=tOkluSvMOilQtaQgeVN/jbLnmLXdvX3Fp9s5Z6P8s1g=;
        h=In-Reply-To:Message-ID:References:Date:To:From:Subject:Cc;
        b=Z4jm5Q2LTUYVSo8olrY0Quoi7AQsTBhZjF73yqtYmYod1nau/phdgy6bQwtVIC7rj
         788ePHQp13uvQW1vUeIf1xWUaY30sg+qS9qy1od1dkNufOcq1HIh0Z6xLrECdoAQoF
         GlBmDVdNCEbC2tjP/Z03EJTXlxSojcqYxr6uTv9Y=
Authentication-Results: mxbackcorp1g.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:c142:79c2:9d86:677a])
        by smtpcorp1p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id wlKkVkryLz-rMDao1Sr;
        Wed, 04 Sep 2019 16:53:22 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH v1 7/7] mm/mlock: recharge mlocked pages at culling by vmscan
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
Cc:     Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Date:   Wed, 04 Sep 2019 16:53:22 +0300
Message-ID: <156760520240.6560.4933207338618527335.stgit@buzz>
In-Reply-To: <156760509382.6560.17364256340940314860.stgit@buzz>
References: <156760509382.6560.17364256340940314860.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

If mlock cannot catch page in LRU then it isn't moved into unevictable lru.
These pages are 'culled' by reclaimer and moved into unevictable lru.
It seems pages locked with MLOCK_ONFAULT always go through this path.

Reclaimer calls try_to_unmap for already isolated pages, thus on this path
we could freely change page to owner of any mlock vma we found in rmap.

This patch passes flag TTU_LRU_ISOLATED into try_to_ummap to move pages
in mmlock_vma_page().

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 mm/vmscan.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index bf7a05e8a717..2060f254dd6b 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1345,7 +1345,8 @@ static unsigned long shrink_page_list(struct list_head *page_list,
 		 * processes. Try to unmap it here.
 		 */
 		if (page_mapped(page)) {
-			enum ttu_flags flags = ttu_flags | TTU_BATCH_FLUSH;
+			enum ttu_flags flags = ttu_flags | TTU_BATCH_FLUSH |
+					       TTU_LRU_ISOLATED;
 
 			if (unlikely(PageTransHuge(page)))
 				flags |= TTU_SPLIT_HUGE_PMD;

