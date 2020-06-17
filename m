Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 480F81FC93C
	for <lists+cgroups@lfdr.de>; Wed, 17 Jun 2020 10:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725894AbgFQItb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 17 Jun 2020 04:49:31 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:33209 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbgFQItb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 17 Jun 2020 04:49:31 -0400
Received: by mail-ej1-f67.google.com with SMTP id n24so1474433ejd.0;
        Wed, 17 Jun 2020 01:49:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nicun5v32ytOl5kIX9jbwdnRFPXaMshWANgztjN0gQE=;
        b=TDHSa1IvxQM2exPW/6kiHC0/iIIK38Vvsm3w0WV7GSCrx20wrY6E7yXU95JZz/ypUJ
         NjzZEs3/QGvG7wL+nENE2ezfss4nFSfbrV93QtWu/COcPKRKis1bxRDEeAHAttClFoKi
         LXqQoCLbItri0CTxFRa4xGT9CpnjTJ/hEeaO8iSyUyDE+dIpdvlWW9DT0sveWcnjpftD
         WvOvPHhqERoOmpUd2VrilLPfzJNoff7/x1Fc+vNu6q/etnBnsGyfQwas2eZ5ssrYDS+a
         rVjCFmriDDMVi/9bSE9z9Jl1VlLcqam8fzVX3EqU0YSKCJ/3c2JG+fpSmJSG/XnZZDtc
         IzSQ==
X-Gm-Message-State: AOAM530Ug5VrE0sKyt7PHXvrqTeaP8rmZ8OeUZSKoBTefx6tF8ge+ZR4
        N0gUmYRCk2wVhmuBp52a1SE=
X-Google-Smtp-Source: ABdhPJwLXbtfdC+OVNbOEj3EtrmJW3BBo2ccpq+fDPSsytr30ENIzevd8Z1hLY9Ogbx4/7A1JClSWA==
X-Received: by 2002:a17:906:b845:: with SMTP id ga5mr6509647ejb.300.1592383769411;
        Wed, 17 Jun 2020 01:49:29 -0700 (PDT)
Received: from localhost (ip-37-188-158-19.eurotel.cz. [37.188.158.19])
        by smtp.gmail.com with ESMTPSA id a24sm12795625ejc.109.2020.06.17.01.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 01:49:28 -0700 (PDT)
Date:   Wed, 17 Jun 2020 10:49:27 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Joonsoo Kim <js1304@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH for 5.8] mm: do_swap_page fix up the error code instantiation
Message-ID: <20200617084927.GK9499@dhcp22.suse.cz>
References: <20200508183105.225460-1-hannes@cmpxchg.org>
 <20200508183105.225460-17-hannes@cmpxchg.org>
 <20200611093523.GB20450@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200611093523.GB20450@dhcp22.suse.cz>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

I hope I haven't missed anything but the patch should be the following.

From acd488c22b4bb2ee42526be8ca67145d5127b014 Mon Sep 17 00:00:00 2001
From: Michal Hocko <mhocko@suse.com>
Date: Wed, 17 Jun 2020 10:40:47 +0200
Subject: [PATCH] mm: do_swap_page fix up the error code

do_swap_page returns error codes from the VM_FAULT* space. try_charge
might return -ENOMEM, though, and then do_swap_page simply returns 0
which means a success.

We almost never return ENOMEM for GFP_KERNEL single page charge. Except
for async OOM handling (oom_disabled v1). So this needs translation to
VM_FAULT_OOM otherwise the the page fault path will not notify the
userspace and wait for an action.

Fixes: 4c6355b25e8b ("mm: memcontrol: charge swapin pages on instantiation")
Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 mm/memory.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index dc7f3543b1fd..d944b7946b27 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3140,8 +3140,10 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 				err = mem_cgroup_charge(page, vma->vm_mm,
 							GFP_KERNEL);
 				ClearPageSwapCache(page);
-				if (err)
+				if (err) {
+					err = VM_FAULT_OOM;
 					goto out_page;
+				}
 
 				lru_cache_add(page);
 				swap_readpage(page, true);
-- 
2.26.2

-- 
Michal Hocko
SUSE Labs
