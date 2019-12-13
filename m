Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36CB111EB7D
	for <lists+cgroups@lfdr.de>; Fri, 13 Dec 2019 21:05:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729009AbfLMUFW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 13 Dec 2019 15:05:22 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45263 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728991AbfLMUFW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 13 Dec 2019 15:05:22 -0500
Received: by mail-qt1-f193.google.com with SMTP id l12so34146qtq.12
        for <cgroups@vger.kernel.org>; Fri, 13 Dec 2019 12:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AGxRnEh5CXFWXGLun9RvFBMrbc3Csuo1hFkC8taJ9Ao=;
        b=fi8pocFAG1MtH+wrS/RwicUEW6vUdIGEjPL2lsSHOLPBs6UThnygqIyuQc95xton9e
         Yxoneci0+u6nu3ovdvs2nwA6RCfIMHAvQP7WkJLiEs9uazqRsxy1GzWplPGcynkU2vEK
         m7juwjZ8BwyfJRwNzTstai0DRHVpUgvjzk1Q5uqS/8LJE0nHMg3ldrRcWLKuHAHLT9dG
         VlArpH8BK+h7UwtXjWpyLxEFn8kV0wny/tRfB8fOru0yd0avuJOpcJRwpsLKPK0y/1/z
         q1OAdPQzLYkV9FLa/Gez/xOtKcg1Uv+ldtQ5Z2yWXT1+Sl1YJ5Vol1E4IiG9H3W6XsSS
         WQAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AGxRnEh5CXFWXGLun9RvFBMrbc3Csuo1hFkC8taJ9Ao=;
        b=SsejcHbKxcWRRKv9IbMMax/JET0Bl8Y7Wo6CMMqK6HL5/gc/bYxrzEYFsAr29fXQZN
         pSIANXsHUC1JyKtM/fWJ7CWjhxCy5Adgnpu9lUR7XNDx0VmJxIV3voKBrHUa8rWclV1E
         rmBA4SeYKZE8QOt/uMdeqWswlQ/OkPgagg2qz5aP5eObgpEC+iTIbuyOmzc6F0cLKoiL
         7ufFvJ+6V6G89Q9044jZMvHtIgm8F6aQxMkQj5xJ16fXqahoJPTIR8fzTQoeuEfNsrGm
         KdZniZKy/SCZ8m330PU11+9gNi9BFMlKXeQH+/qtHgLKAr2/mQ7XjXBW4S1HijbGMlbj
         EDZg==
X-Gm-Message-State: APjAAAV7rNcNH0R6UKf7QCVb8uQYXbw9OGDrtFJVwDRreZa86/zUgdlD
        48OhwQAgMs+AvQrkjX9xQ0JZcb1IBOE=
X-Google-Smtp-Source: APXvYqyt8/F7dcovN6ml4CYTmL9Z4Gv+D5IHB1cNmx/2gV7w9evyzyCC0M4BYf6Eo/p0Bvy7I4PQQA==
X-Received: by 2002:aed:24ec:: with SMTP id u41mr4951304qtc.220.1576267520991;
        Fri, 13 Dec 2019 12:05:20 -0800 (PST)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id f23sm3092385qke.104.2019.12.13.12.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 12:05:20 -0800 (PST)
Date:   Fri, 13 Dec 2019 15:05:19 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Tejun Heo <tj@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 3/3] mm: memcontrol: recursive memory.low protection
Message-ID: <20191213200519.GA168988@cmpxchg.org>
References: <20191213192158.188939-1-hannes@cmpxchg.org>
 <20191213192158.188939-4-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191213192158.188939-4-hannes@cmpxchg.org>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Dec 13, 2019 at 02:21:58PM -0500, Johannes Weiner wrote:
> +	if (cgrp_dfl_root.flags & CGRP_ROOT_MEMORY_RECURSIVE_PROT) {
> +		unsigned long unclaimed;
> +		/*
> +		 * If the children aren't claiming (all of) the
> +		 * protection afforded to them by the parent,
> +		 * distribute the remainder in proportion to the
> +		 * (unprotected) size of each cgroup. That way,
> +		 * cgroups that aren't explicitly prioritized wrt each
> +		 * other compete freely over the allowance, but they
> +		 * are collectively protected from neighboring trees.
> +		 *
> +		 * We're using unprotected size for the weight so that
> +		 * if some cgroups DO claim explicit protection, we
> +		 * don't protect the same bytes twice.
> +		 */
> +		unclaimed = parent_effective - siblings_protected;
> +		unclaimed *= usage - protected;
> +		unclaimed /= parent_usage - siblings_protected;

Brainfart I noticed just after sending it out - naturally. If there is
unclaimed protection in the parent, but the children use exactly how
much they claim, this will div0. We have to check for usage that isn't
explicitly protected in the child to which to apply the float. Fixlet
below. Doesn't change the overall logic, though.

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 2e352cd6c38d..8d7e9490740b 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6328,21 +6328,24 @@ static unsigned long effective_protection(unsigned long usage,
 	 */
 	ep = protected;
 
-	if (cgrp_dfl_root.flags & CGRP_ROOT_MEMORY_RECURSIVE_PROT) {
+	/*
+	 * If the children aren't claiming (all of) the protection
+	 * afforded to them by the parent, distribute the remainder in
+	 * proportion to the (unprotected) size of each cgroup. That
+	 * way, cgroups that aren't explicitly prioritized wrt each
+	 * other compete freely over the allowance, but they are
+	 * collectively protected from neighboring trees.
+	 *
+	 * We're using unprotected size for the weight so that if some
+	 * cgroups DO claim explicit protection, we don't protect the
+	 * same bytes twice.
+	 */
+	if (!(cgrp_dfl_root.flags & CGRP_ROOT_MEMORY_RECURSIVE_PROT))
+		return ep;
+
+	if (usage > protected && parent_effective > siblings_protected) {
 		unsigned long unclaimed;
-		/*
-		 * If the children aren't claiming (all of) the
-		 * protection afforded to them by the parent,
-		 * distribute the remainder in proportion to the
-		 * (unprotected) size of each cgroup. That way,
-		 * cgroups that aren't explicitly prioritized wrt each
-		 * other compete freely over the allowance, but they
-		 * are collectively protected from neighboring trees.
-		 *
-		 * We're using unprotected size for the weight so that
-		 * if some cgroups DO claim explicit protection, we
-		 * don't protect the same bytes twice.
-		 */
+
 		unclaimed = parent_effective - siblings_protected;
 		unclaimed *= usage - protected;
 		unclaimed /= parent_usage - siblings_protected;
