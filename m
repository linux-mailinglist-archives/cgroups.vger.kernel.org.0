Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2C06DE886
	for <lists+cgroups@lfdr.de>; Wed, 12 Apr 2023 02:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjDLAe5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 11 Apr 2023 20:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjDLAe4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 11 Apr 2023 20:34:56 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B115E18D
        for <cgroups@vger.kernel.org>; Tue, 11 Apr 2023 17:34:55 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id j7-20020a17090a738700b0023f803081beso2846455pjg.3
        for <cgroups@vger.kernel.org>; Tue, 11 Apr 2023 17:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681259695; x=1683851695;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yIObXy3lJVLQ0GKopS+iRwrSvJGFvWWAFvhX3UspfPI=;
        b=DWINJdlLfA7bsA3GGGY3QqMkyHn4mFlvS/JIo4iW0TMLRVhU/gf7C1saDLJbgiMhyg
         1THSZqOvBE7mYalurr5DpB+0FcS448x6UlzZq4LCxUvT+p2BGmyTy5YgE1NSEM0zIhIU
         6wS+/+aKooKm7FQuVCzrBtZANDFi3UgfGVf65QRiGlph2U7sNmmMEdxB2T5rc3YOUyH9
         a1aiSVB8pFxOvsKL9KHKoN8NmzVNyhvUSpVMDYIvCLA0wxF0ldBH57sG0T1+qRafWsYh
         RbheDirj59ekdDNu91/r2Fz5vIwhgUWTsLc5GdFJJ3XkuToj6EsUXeRczct0dZdBnYn6
         +2ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681259695; x=1683851695;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yIObXy3lJVLQ0GKopS+iRwrSvJGFvWWAFvhX3UspfPI=;
        b=hEBM2ZSSma354jj3DPknxcxf3H/8B8FShaFxZXz5NSw7A/DBKt4iBxZc/PnWhyXeHi
         DWozXi39onwaE7TNTmiHTbFXZHRVSnaQs1rNRKpxetYHPAczbzJlfqSNa14QkrI2NiML
         31+jz9ZbQItyrVBKX1CHCFiFB5ABN6hLJ1m7hnkjRF0cjvz7fubyQzkCCr0VWUdvjMWX
         CaEYn6GqdE+x2EZjtEtiPOKuzaTyatNLv+WuUEXG094/rlSSogy8w0b/mgqyq3l7ZxGL
         YbVIkpftJ71Dx5nuJK2/VL7iX6/ErcoeV34HXtG3Htcw6/M3k499gmtg+Z+Ujfh8nv6u
         8cJQ==
X-Gm-Message-State: AAQBX9ejP+8ZoH3e3DtBIGnSR86WalD3AFrwCq3DAnAdzt4Fu8yCbZne
        wcsPya3lcB6oaQ1GkWtR4OCvB+STFzkxZWaD
X-Google-Smtp-Source: AKy350bMPGOuTtC/tLxXXEyVhUgKXAV7Whj3PXHOQqxTopMLnwLa+FPGHFw97ryFAaI88njczksy337TS65Hlll6
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a17:90a:5a02:b0:246:69ca:85d6 with SMTP
 id b2-20020a17090a5a0200b0024669ca85d6mr4048479pjd.2.1681259694873; Tue, 11
 Apr 2023 17:34:54 -0700 (PDT)
Date:   Wed, 12 Apr 2023 00:34:51 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Message-ID: <20230412003451.4018887-1-yosryahmed@google.com>
Subject: [PATCH] memcg: page_cgroup_ino() get memcg from the page's folio
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, cgroups@vger.kernel.org,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

In a kernel with added WARN_ON_ONCE(PageTail) in page_memcg_check(), we
observed a warning from page_cgroup_ino() when reading
/proc/kpagecgroup. This warning was added to catch fragile reads of
a page memcg. Make page_cgroup_ino() get memcg from the page's folio
using folio_memcg_check(): that gives it the correct memcg for each page
of a folio, so is the right fix.

Note that page_folio() is racy, the page's folio can change from under
us, but the entire function is racy and documented as such.

I dithered between the right fix and the safer "fix": it's unlikely but
conceivable that some userspace has learnt that /proc/kpagecgroup gives
no memcg on tail pages, and compensates for that in some (racy) way: so
continuing to give no memcg on tails, without warning, might be safer.

But hwpoison_filter_task(), the only other user of page_cgroup_ino(),
persuaded me. It looks as if it currently leaves out tail pages of the
selected memcg, by mistake: whereas hwpoison_inject() uses compound_head()
and expects the tails to be included. So hwpoison testing coverage has
probably been restricted by the wrong output from page_cgroup_ino() (if
that memcg filter is used at all): in the short term, it might be safer
not to enable wider coverage there, but long term we would regret that.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---

This is based on a patch originally written by Hugh Dickins and retains
most of the original commit log:
https://lore.kernel.org/linux-mm/20230313083452.1319968-1-yosryahmed@google.com/

The patch was changed to use folio_memcg_check(page_folio(page)) instead
of page_memcg_check(compound_head(page)) based on discussions with
Matthew Wilcox; where he stated that callers of page_memcg_check()
should stop using it due to the ambiguity around tail pages -- instead
they should use folio_memcg_check() and handle tail pages themselves.

I dropped Michal's Ack as the only line in the patch was changed, but
the patch should be functionally the same.

---
 mm/memcontrol.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 5abffe6f8389..fec3c4fd9c1c 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -395,7 +395,8 @@ ino_t page_cgroup_ino(struct page *page)
 	unsigned long ino = 0;
 
 	rcu_read_lock();
-	memcg = page_memcg_check(page);
+	/* page_folio() is racy here, but the entire function is racy anyway */
+	memcg = folio_memcg_check(page_folio(page));
 
 	while (memcg && !(memcg->css.flags & CSS_ONLINE))
 		memcg = parent_mem_cgroup(memcg);
-- 
2.40.0.577.gac1e443424-goog

