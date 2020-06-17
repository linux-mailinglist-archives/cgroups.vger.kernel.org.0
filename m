Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 711DC1FC967
	for <lists+cgroups@lfdr.de>; Wed, 17 Jun 2020 11:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbgFQJCo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 17 Jun 2020 05:02:44 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65]:46902 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgFQJCn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 17 Jun 2020 05:02:43 -0400
Received: by mail-ej1-f65.google.com with SMTP id p20so1441080ejd.13;
        Wed, 17 Jun 2020 02:02:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aPLbKCcLFxl1OYczOtRfssOCjY0N1FBAdnF/euGOa8U=;
        b=F0z1PNtOaVlORtP8Yo9r67u5bU9fonGlJDeequnlfveUR1zxcdX+Pl0qNawxFdiXVB
         7pZeEkKQgVoOeEJ4rmgt5wf0Wpae9nwr915Z9OpH/Pr/IN3vUTjOzOxDSstZBQBTN0ne
         q2rIs1bq5keKORwAWHbVzB+Pdkf6/AB2FfjWPqGeDhx55peOQJNL+tmiCPAbhTOu9KWi
         Fe/nZQh/OjfhBESga0AjrZ6Jd2fp6xuhfXaY/WSVFN3inTvG1nxYCXWkkcVEWoNf9GbB
         f7fEPlkS6Z3PrYhkOt6qBa+LDJ/aL9J19WT/kVpgdApliGB31xRcir9cXTOi76ZmCyWX
         Iqcw==
X-Gm-Message-State: AOAM530ObgalcNIcNnCAZ0VuNYvyCweBujF/aaEyjZQ9WvrhdVsL/Ylk
        0HXQBUM1oS9XkgK9kayH9Ew=
X-Google-Smtp-Source: ABdhPJz9cRH3gFwGsBLpKSYu/Sr7jAiuc3F/XaPoq0AFgqX1mWyTqW7nax4d9owsvqFpOA9HCu0BOw==
X-Received: by 2002:a17:906:f53:: with SMTP id h19mr6420723ejj.491.1592384561419;
        Wed, 17 Jun 2020 02:02:41 -0700 (PDT)
Received: from localhost (ip-37-188-158-19.eurotel.cz. [37.188.158.19])
        by smtp.gmail.com with ESMTPSA id z10sm12950424ejb.9.2020.06.17.02.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 02:02:40 -0700 (PDT)
Date:   Wed, 17 Jun 2020 11:02:38 +0200
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
Subject: Re: [PATCH for 5.8] mm: do_swap_page fix up the error code
 instantiation
Message-ID: <20200617090238.GL9499@dhcp22.suse.cz>
References: <20200508183105.225460-1-hannes@cmpxchg.org>
 <20200508183105.225460-17-hannes@cmpxchg.org>
 <20200611093523.GB20450@dhcp22.suse.cz>
 <20200617084927.GK9499@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617084927.GK9499@dhcp22.suse.cz>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Damn, I forgot to commit my last change (s@err@ret@). Sorry about the
noise.

From 50297dd026ebf71fe901e1945a9ce1e8d8aa083b Mon Sep 17 00:00:00 2001
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
index dc7f3543b1fd..1c632faa2611 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3140,8 +3140,10 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 				err = mem_cgroup_charge(page, vma->vm_mm,
 							GFP_KERNEL);
 				ClearPageSwapCache(page);
-				if (err)
+				if (err) {
+					ret = VM_FAULT_OOM;
 					goto out_page;
+				}
 
 				lru_cache_add(page);
 				swap_readpage(page, true);
-- 
2.26.2

-- 
Michal Hocko
SUSE Labs
