Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19B371B46F8
	for <lists+cgroups@lfdr.de>; Wed, 22 Apr 2020 16:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbgDVOPR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 22 Apr 2020 10:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbgDVOPR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 22 Apr 2020 10:15:17 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0007AC03C1A9
        for <cgroups@vger.kernel.org>; Wed, 22 Apr 2020 07:15:16 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id m67so2424677qke.12
        for <cgroups@vger.kernel.org>; Wed, 22 Apr 2020 07:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2AHRqHxCmiwXN0EhIIrAV3drjpQwspXxC+Tz9XMuy+8=;
        b=VLtSM6Koh1mVxNBgBhq8VK6hkxnm5iP4u8LwHu4YoEamL6IKzwJK/2XCY2SPIIUV4u
         GV/woLeRdv25GnvF+55c1C4P++fkDZSgXVjb52MTaJouMwu9F91R6If5DHztrDOlG9HX
         MxMe9/Rq4jraUSbZ573bLYVdjdE5LdlzjtkvBOq66+m1e731htK/YGa7Mce8vbVes7IM
         a4aR3P4DZFPZaplzX0VH6EPEUedbOYb7kfKTTyPu45TmFGiRyFm4jtGVy8hpDADMIBt6
         alB77TrenVgS8DRyVj+i8G13iqIQ1UilqQzAlIPARK/fXUMZ7e+TUIkT6l+qnS74DTx9
         6cWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2AHRqHxCmiwXN0EhIIrAV3drjpQwspXxC+Tz9XMuy+8=;
        b=b7tpXrYkxkXz6rRZMRHtApi6C9DB7+qsrbCiHqcZqy6Kf6MtvYd+iVgABHN0wtq2BM
         DqePLRdWbHXPhduAT0JLCdoWLit8iu2QUOGdr9QoZxdMFQ6jPuYL85UxwYUa9uWfF5Vi
         rBZr8KN9siJmoK4ffCwwBKaEIHa9e/9TL7BVTX8Fe5I8AMstFNTCajB8EL7bEE0kG4Qk
         GTAGbxTe3ykufmt/CtO8JHYZSJo6rFbG6TVgYZHpGfHQCowRsJoOgohWrcKfDWJp61wN
         JWPMMVd7ZFxJJk2D2pO34j2q5bSqXylntriXaSaR1tSormPLvoH+wuBth4qHiC7/oWhS
         Pt7A==
X-Gm-Message-State: AGi0Pua0tFFGzzc/PSCsZpgNZ8672s12bM5x6blPVailFLtO6drvC2hM
        YfzJKe0y1Ox5+G+cp8AfPexHYw==
X-Google-Smtp-Source: APiQypIpFwZ6xRcDUjNpNjbl9DC5AXrbUOKqEaSnjdAoizt4ou0aHuSym0pI9O45//9nbdVc7cio5Q==
X-Received: by 2002:a37:bd81:: with SMTP id n123mr2442188qkf.57.1587564916161;
        Wed, 22 Apr 2020 07:15:16 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::921])
        by smtp.gmail.com with ESMTPSA id k58sm4153577qtf.40.2020.04.22.07.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 07:15:15 -0700 (PDT)
Date:   Wed, 22 Apr 2020 10:15:14 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Tejun Heo <tj@kernel.org>, Shakeel Butt <shakeelb@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Kernel Team <kernel-team@fb.com>,
        Chris Down <chris@chrisdown.name>,
        Cgroups <cgroups@vger.kernel.org>
Subject: Re: [PATCH 0/3] memcg: Slow down swap allocation as the available
 space gets depleted
Message-ID: <20200422141514.GA362484@cmpxchg.org>
References: <20200417225941.GE43469@mtj.thefacebook.com>
 <CALvZod6M4OsM-t8m_KX9wCkEutdwUMgbP9682eHGQor9JvO_BQ@mail.gmail.com>
 <20200420164740.GF43469@mtj.thefacebook.com>
 <20200420170318.GV27314@dhcp22.suse.cz>
 <20200420170650.GA169746@mtj.thefacebook.com>
 <20200421110612.GD27314@dhcp22.suse.cz>
 <20200421142746.GA341682@cmpxchg.org>
 <20200421161138.GL27314@dhcp22.suse.cz>
 <20200421165601.GA345998@cmpxchg.org>
 <20200422132632.GG30312@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422132632.GG30312@dhcp22.suse.cz>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Apr 22, 2020 at 03:26:32PM +0200, Michal Hocko wrote:
> That being said I believe our discussion is missing an important part.
> There is no description of the swap.high semantic. What can user expect
> when using it?

Good point, we should include that in cgroup-v2.rst. How about this?

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index bcc80269bb6a..49e8733a9d8a 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1370,6 +1370,17 @@ PAGE_SIZE multiple when read back.
 	The total amount of swap currently being used by the cgroup
 	and its descendants.
 
+  memory.swap.high
+	A read-write single value file which exists on non-root
+	cgroups.  The default is "max".
+
+	Swap usage throttle limit.  If a cgroup's swap usage exceeds
+	this limit, allocations inside the cgroup will be throttled.
+
+	This slows down expansion of the group's memory footprint as
+	it runs out of assigned swap space. Compare to memory.swap.max,
+	which stops swapping abruptly and can provoke kernel OOM kills.
+
   memory.swap.max
 	A read-write single value file which exists on non-root
 	cgroups.  The default is "max".
