Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA9A66B7137
	for <lists+cgroups@lfdr.de>; Mon, 13 Mar 2023 09:35:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjCMIfL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 Mar 2023 04:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbjCMIe4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 13 Mar 2023 04:34:56 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7931D22C97
        for <cgroups@vger.kernel.org>; Mon, 13 Mar 2023 01:34:55 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id x63-20020a17090a6c4500b00237731465feso4437862pjj.8
        for <cgroups@vger.kernel.org>; Mon, 13 Mar 2023 01:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678696495;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zeDiTo83CJOPfROIycQGpKJpY/woSMBEn4wJ2l9Oc3A=;
        b=VJLAMhtXlqTwGgXDKCTVn6HNH8J7Yb49JpBXa71bKEU+b8UV7Pfw4XnV3NJlgObfWR
         dsMVPpiYzyL+5/bmZeKIlzocq5lZDLUEIdEzYQ+l+SjF9mGT9Pqh276648bG03w2Bf4L
         zwYel8rQA26f0lY3rYcJALEiOuEu8HsNuNgUPyCu7rrMjImD34V9QNoVfiGc4Pn4ZgnY
         BHyEoGPJcoEqbfOwQd0dGFuvXoVeikT40ffzVLYSDDPFqOOfwnu2rb9l7QedPR2tVVK9
         JpY7HwxqXLi30xpw6Hyawjr8gHfVwVGmTu5K+o7/00SdSoYGb9i2i2o+s3cx6qjv9IAS
         Xcfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678696495;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zeDiTo83CJOPfROIycQGpKJpY/woSMBEn4wJ2l9Oc3A=;
        b=nVDpzFslEd6d5Ky4TT7GHFi4uhJbceJXNNhNs1zXVJS4vR1uq357VD80EDn0PCXVxh
         DSHgnCBEFhLngWoyhTh45PUdpd2+U5TReBBWVuWboUokpSPfEp8pQZNB9dBE78WAakPj
         nM6XU8M8wOEZIQ65wp4/IcMTyxyPB5Ok7SQn9RUubY21CIch9uv3xh7vGwMyv5zk92uN
         Med4PVw6fJcmTE1a8D53H7oNI+dLBvmtuy0xaz3LvKIkjaoWy09icD4qH2xvwg54zQ5A
         HxMctqBw23z/fo8NJjEOeNrGz0qZ8lnghr4pafFLgHYKGlbSv9J02bAGQFDS2AqcE/Iq
         vqXQ==
X-Gm-Message-State: AO0yUKW9fuaux3Q/TvDNXzvdVgDpGC9mVttu1z7v+Te5pw3InHtd3zIm
        H2+CUw2p9i/wI75W8jizOQGmKKtOu0kzNzXb
X-Google-Smtp-Source: AK7set9OUIQAsvRTAEvPqTliBW1Ilddgmbr1TQ3J16ta65gCass7E536/3xMeEut+bm9A05Eebs7dxH2HOAPck4r
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a62:8484:0:b0:5a9:d579:6902 with SMTP
 id k126-20020a628484000000b005a9d5796902mr3305591pfd.0.1678696494930; Mon, 13
 Mar 2023 01:34:54 -0700 (PDT)
Date:   Mon, 13 Mar 2023 08:34:52 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230313083452.1319968-1-yosryahmed@google.com>
Subject: [PATCH] memcg: page_cgroup_ino() get memcg from compound_head(page)
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
        Vladimir Davydov <vdavydov.dev@gmail.com>
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

From: Hugh Dickins <hughd@google.com>

In a kernel with added WARN_ON_ONCE(PageTail) in page_memcg_check(), we
observed a warning from page_cgroup_ino() when reading
/proc/kpagecgroup. This warning was added to catch fragile reads of
a page memcg. Make page_cgroup_ino() get memcg from compound_head(page):
that gives it the correct memcg for each subpage of a compound page,
so is the right fix.

I dithered between the right fix and the safer "fix": it's unlikely but
conceivable that some userspace has learnt that /proc/kpagecgroup gives
no memcg on tail pages, and compensates for that in some (racy) way: so
continuing to give no memcg on tails, without warning, might be safer.

But hwpoison_filter_task(), the only other user of page_cgroup_ino(),
persuaded me.  It looks as if it currently leaves out tail pages of the
selected memcg, by mistake: whereas hwpoison_inject() uses compound_head()
and expects the tails to be included.  So hwpoison testing coverage has
probably been restricted by the wrong output from page_cgroup_ino() (if
that memcg filter is used at all): in the short term, it might be safer
not to enable wider coverage there, but long term we would regret that.

Signed-off-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---

(Yosry: Alternatively, we could modify page_memcg_check() to do
 page_folio() like its sibling page_memcg(), as page_cgroup_ino() is the
 only remaining caller other than print_page_owner_memcg(); and it already
 excludes pages that have page->memcg_data = 0)

---
 mm/memcontrol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 5abffe6f8389..e3a55295725e 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -395,7 +395,7 @@ ino_t page_cgroup_ino(struct page *page)
 	unsigned long ino = 0;
 
 	rcu_read_lock();
-	memcg = page_memcg_check(page);
+	memcg = page_memcg_check(compound_head(page));
 
 	while (memcg && !(memcg->css.flags & CSS_ONLINE))
 		memcg = parent_mem_cgroup(memcg);
-- 
2.40.0.rc1.284.g88254d51c5-goog

