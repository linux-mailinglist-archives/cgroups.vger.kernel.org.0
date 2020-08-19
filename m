Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0433624940B
	for <lists+cgroups@lfdr.de>; Wed, 19 Aug 2020 06:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgHSE10 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 19 Aug 2020 00:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725275AbgHSE10 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 19 Aug 2020 00:27:26 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05BD5C061389;
        Tue, 18 Aug 2020 21:27:26 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id m7so20485714qki.12;
        Tue, 18 Aug 2020 21:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=T7hUYa5UogPv6sBfCV0FhXNPQBfOPqefw0rv85aPgto=;
        b=Eoxng6/BeOd5C+j6fxh7qVKG8VAHJChogDv9BN+ih1vUiDUYa428vI1Qr+RZbHjb+F
         z3PDkhrTAEWMFXQqqS47dXG8H6GuVtMQfIdV1JByxC7hytaIGD/THiPJiKiGDitv9Mu4
         SF3IEcMaQ/mNQsTxJY6Sja8V162q2FroarImRxmS5HP5urBApgHmPQxX4t9Ai+lsXxSG
         OYKZmN1fuUCZoYCc/WUjYKRxEgh+BdWg8jQZdErGjvVfvxnfHHrBPVrpqC0lZKb0eTR+
         n58O8F+j9uYedxQzKWsfe2axi/nAxCbseEV93iRLNiPzCtPxbpaHLF8Aslyd2pM2RZa+
         82Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=T7hUYa5UogPv6sBfCV0FhXNPQBfOPqefw0rv85aPgto=;
        b=KoL8ge48AW/9G+BOCxudCDwSTM4W9GKAwlyE86d1I6dnc7vZVA0r6bmpXlXCTZ0wlO
         tGze5/NnzPN+0ARy2IBRbx4o9s1kxwZweqfyMgDYC8lc7aiP+/j4x775jlD4YngCD1v8
         r5d19Rc8WNjArALVkHUQB9z0uGVHEDgwBhUO3LrZrfF0A8RbDNJOZFR9dFWdfs+3wEMJ
         l75AWnRYRxt/lYPXRq/88vfd0uIHf43W0+KXOEn+v3Z7/P2aY6VOL2xr2i0MnnkMnJoe
         +sqwMbcbkOtSDVjIKDwaEhYvsptOBW6/IsLwZ1gV14trlNNjJSHjB0go3fpf3ohl1vqw
         Ta1Q==
X-Gm-Message-State: AOAM530mmyYVNV8M/cUS9uerxrzMlGUFt4Tkz+gBYLPk+f0vyRJOAp4B
        xNCw3zzJ1lnhO4CwlXKEerU=
X-Google-Smtp-Source: ABdhPJwjewQd6K+YoPWRo0i16OTkUs6Abew8umKdDVBaSIhn0FBlk9jhcWGGDVzESBeD13fateK8hQ==
X-Received: by 2002:a37:bd46:: with SMTP id n67mr20703006qkf.190.1597811245192;
        Tue, 18 Aug 2020 21:27:25 -0700 (PDT)
Received: from localhost.localdomain ([2001:470:b:9c3:9e5c:8eff:fe4f:f2d0])
        by smtp.gmail.com with ESMTPSA id w58sm27335636qth.95.2020.08.18.21.27.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Aug 2020 21:27:24 -0700 (PDT)
Subject: [RFC PATCH v2 3/5] mm: Add explicit page decrement in exception
 path for isolate_lru_pages
From:   Alexander Duyck <alexander.duyck@gmail.com>
To:     alex.shi@linux.alibaba.com
Cc:     yang.shi@linux.alibaba.com, lkp@intel.com, rong.a.chen@intel.com,
        khlebnikov@yandex-team.ru, kirill@shutemov.name, hughd@google.com,
        linux-kernel@vger.kernel.org, alexander.duyck@gmail.com,
        daniel.m.jordan@oracle.com, linux-mm@kvack.org,
        shakeelb@google.com, willy@infradead.org, hannes@cmpxchg.org,
        tj@kernel.org, cgroups@vger.kernel.org, akpm@linux-foundation.org,
        richard.weiyang@gmail.com, mgorman@techsingularity.net,
        iamjoonsoo.kim@lge.com
Date:   Tue, 18 Aug 2020 21:27:22 -0700
Message-ID: <20200819042722.23414.2654.stgit@localhost.localdomain>
In-Reply-To: <20200819041852.23414.95939.stgit@localhost.localdomain>
References: <20200819041852.23414.95939.stgit@localhost.localdomain>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Alexander Duyck <alexander.h.duyck@linux.intel.com>

In isolate_lru_pages we have an exception path where if we call
get_page_unless_zero and that succeeds, but TestClearPageLRU fails we call
put_page. Normally this would be problematic but due to the way that the
calls are ordered and the fact that we are holding the LRU lock we know
that the caller must be holding another reference for the page. Since we
can assume that we can replace the put_page with a call to
put_page_testzero contained within a WARN_ON. By doing this we should see
if we ever leak a page as a result of the reference count somehow hitting
zero when it shouldn't, and can avoid the overhead and confusion of using
the full put_page call.

Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---
 mm/vmscan.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 5bc0c2322043..3ebe3f9b653b 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1688,10 +1688,13 @@ static unsigned long isolate_lru_pages(unsigned long nr_to_scan,
 
 			if (!TestClearPageLRU(page)) {
 				/*
-				 * This page may in other isolation path,
-				 * but we still hold lru_lock.
+				 * This page is being isolated in another
+				 * thread, but we still hold lru_lock. The
+				 * other thread must be holding a reference
+				 * to the page so this should never hit a
+				 * reference count of 0.
 				 */
-				put_page(page);
+				WARN_ON(put_page_testzero(page));
 				goto busy;
 			}
 

