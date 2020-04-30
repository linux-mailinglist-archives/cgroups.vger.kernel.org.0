Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6801BFF5D
	for <lists+cgroups@lfdr.de>; Thu, 30 Apr 2020 16:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbgD3O50 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 30 Apr 2020 10:57:26 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39387 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726447AbgD3O5Z (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 30 Apr 2020 10:57:25 -0400
Received: by mail-wr1-f66.google.com with SMTP id b11so7310940wrs.6;
        Thu, 30 Apr 2020 07:57:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=v2KXeJSGOxCLOqzZkZj8Dvo069WYxW+Vtn6eKg9tlBc=;
        b=n0+5AMvaXwqlZgIbw9lEMVJx/hFkZjiRjmbUax79APlGhjiCXxBNgk2nK//4CXr5Bj
         1Sdvy4Q6h41Ey453v3h/jiQ4QejYYiNHDDBVjX7yl3EVXPk1n/uDRWoHLsqZfVpI1NE1
         afpwuIQxv3aFpQhpycPX5i+e+yhDCSc7re85OLKs87xNoHMZJ4WGnW0U4vl1pmbl5hBj
         1Q+vawu5LPbvRi7sFDoHGGOWI/InwvUdw51yqcm9KpalH1Sg22YOa/rxgOyj/h5z+SwC
         aneKde02qhjjNA+d31B+PKkQjxnB0uDGxIbkM6yjuGc/XEqWz/hxrKb8RzjLUGArLzH5
         Lyhw==
X-Gm-Message-State: AGi0PublSnNH18JyZ6Abls56+5LPTzCO2mXC3DVFJHhfHDSZmXRptMAV
        N6Wo9+2TUzZppKO7DG56d3Q=
X-Google-Smtp-Source: APiQypLyWBXOMWcM+U9JdSkAcZTAgQc1udSZa6plGTugiQm7hdsGILpSL6SjvdwK93UEObl5KKxM2w==
X-Received: by 2002:a5d:6107:: with SMTP id v7mr4171383wrt.270.1588258644136;
        Thu, 30 Apr 2020 07:57:24 -0700 (PDT)
Received: from localhost (ip-37-188-183-9.eurotel.cz. [37.188.183.9])
        by smtp.gmail.com with ESMTPSA id 74sm4681829wrk.30.2020.04.30.07.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 07:57:22 -0700 (PDT)
Date:   Thu, 30 Apr 2020 16:57:21 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Chris Down <chris@chrisdown.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Yafang Shao <laoar.shao@gmail.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm, memcg: Avoid stale protection values when cgroup
 is above protection
Message-ID: <20200430145721.GF12655@dhcp22.suse.cz>
References: <cover.1588092152.git.chris@chrisdown.name>
 <d454fca5d6b38b74d8dc35141e8519b02089a698.1588092152.git.chris@chrisdown.name>
 <20200429101510.GA28637@dhcp22.suse.cz>
 <20200429140330.GA5054@cmpxchg.org>
 <20200429150414.GI28637@dhcp22.suse.cz>
 <20200429165627.GA24768@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429165627.GA24768@cmpxchg.org>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 29-04-20 12:56:27, Johannes Weiner wrote:
[...]
> I think to address this, we need a more comprehensive solution and
> introduce some form of serialization. I'm not sure yet how that would
> look like yet.

Yeah, that is what I've tried to express earlier and that is why I would
rather go with an uglier workaround for now and think about a more
robust effective values calculation on top.
 
> I'm still not sure it's worth having a somewhat ugly workaround in
> mem_cgroup_protection() to protect against half of the bug. If you
> think so, the full problem should at least be documented and marked
> XXX or something.

Yes, this makes sense to me. What about the following?
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 1b4150ff64be..50ffbc17cdd8 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -350,6 +350,42 @@ static inline unsigned long mem_cgroup_protection(struct mem_cgroup *memcg,
 	if (mem_cgroup_disabled())
 		return 0;
 
+	/*
+	 * There is no reclaim protection applied to a targeted reclaim.
+	 * We are special casing this specific case here because
+	 * mem_cgroup_protected calculation is not robust enough to keep
+	 * the protection invariant for calculated effective values for
+	 * parallel reclaimers with different reclaim target. This is
+	 * especially a problem for tail memcgs (as they have pages on LRU)
+	 * which would want to have effective values 0 for targeted reclaim
+	 * but a different value for external reclaim.
+	 *
+	 * Example
+	 * Let's have global and A's reclaim in parallel:
+	 *  |
+	 *  A (low=2G, usage = 3G, max = 3G, children_low_usage = 1.5G)
+	 *  |\
+	 *  | C (low = 1G, usage = 2.5G)
+	 *  B (low = 1G, usage = 0.5G)
+	 *
+	 * For the global reclaim
+	 * A.elow = A.low
+	 * B.elow = min(B.usage, B.low) because children_low_usage <= A.elow
+	 * C.elow = min(C.usage, C.low)
+	 *
+	 * With the effective values resetting we have A reclaim
+	 * A.elow = 0
+	 * B.elow = B.low
+	 * C.elow = C.low
+	 *
+	 * If the global reclaim races with A's reclaim then
+	 * B.elow = C.elow = 0 because children_low_usage > A.elow)
+	 * is possible and reclaiming B would be violating the protection.
+	 *
+	 */
+	if (memcg == root)
+		return 0;
+
 	if (in_low_reclaim)
 		return READ_ONCE(memcg->memory.emin);
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 05b4ec2c6499..df88a22f09bc 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6385,6 +6385,14 @@ enum mem_cgroup_protection mem_cgroup_protected(struct mem_cgroup *root,
 
 	if (!root)
 		root = root_mem_cgroup;
+
+	/*
+	 * Effective values of the reclaim targets are ignored so they
+	 * can be stale. Have a look at mem_cgroup_protection for more
+	 * details.
+	 * TODO: calculation should be more robust so that we do not need
+	 * that special casing.
+	 */
 	if (memcg == root)
 		return MEMCG_PROT_NONE;
 

> In practice, I doubt this matters all that much because limit reclaim
> and global reclaim tend to occur in complementary
> containerization/isolation strategies, not heavily simultaneously.

I would expect that as well but this is always hard to tell.

-- 
Michal Hocko
SUSE Labs
