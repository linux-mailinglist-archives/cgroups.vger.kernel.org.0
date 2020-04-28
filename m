Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A33B81BCE7B
	for <lists+cgroups@lfdr.de>; Tue, 28 Apr 2020 23:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbgD1VRG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 28 Apr 2020 17:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726386AbgD1VRD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 28 Apr 2020 17:17:03 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31904C03C1AC
        for <cgroups@vger.kernel.org>; Tue, 28 Apr 2020 14:17:03 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id 59so81591qva.13
        for <cgroups@vger.kernel.org>; Tue, 28 Apr 2020 14:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WE6fRMNAlJdivHdtcAIHzYCELiaeahloDmul9mg0d04=;
        b=Tqpge43yY2XClplBd6Cuaaz88Fy6z2Qetea0T++CdEVcloY1WyqWjq9GfNzvdloNf+
         QCyDC7llMs9FBzVbURzA6D2Q7zKZX469Z0F+4Nio7TMivfGJKk8UlmDymTXKq+4dgRsO
         BKbEtWpnzOKtWZMiirCI3Ybp9zHdbKYkkOj3efyJeOoZQARwk13IewUWv53ivh3bZHLE
         2sI3P6Qod7o/TOvQCgAECFhN2fPYIXf0l1/OaiDqILqzJXcoiR4TfBzmdOZ880OwlFop
         grO3SdOEeWLC3XC9c3Td6B2frG8r/+tjxUjk9EGVq9WX7g1l58zDfeurHDEdNkYGStkr
         ciSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WE6fRMNAlJdivHdtcAIHzYCELiaeahloDmul9mg0d04=;
        b=MQ/MHNHo8jdsGqZOBD2CQVVYodYxqbkbJEn9KmN50v1gJlX/kl+czhOyDsLqZstzQZ
         2gbx0XbRhETkrQ7rcf9faebNdRk7Q5Q0vXRR4obiipP5zcsAePc9ErwjXf30cafIcA8R
         wXpY1YZ51I6Ic9OynfkmVV4R4mMRf/dSJYP04YkW72H+xSf/Ao9JM7sq60gTU7/Yp3SJ
         JSZz2wCjJhuIMLHEuF9s4m0geK6GIsgUKqZmcRO+wHAP72F9mtQa2hrAzFleoiYeG8yg
         MKscI8lksAQVWhMMSYRe1/ywAwkwYDc87vpCHQt49ujcc9XRIXPCm0kRIHKIUBUECnHX
         fpKQ==
X-Gm-Message-State: AGi0Pua9O+F9TiO14w6+qjOvY0hvwiT441bqt+OM0ZaXyCVwGbda1ne6
        BzTTN7GD/4Bhb/Qb3QsQ8oeb6w==
X-Google-Smtp-Source: APiQypJWl8lRQzqib+jNVx+26p3v6+O+XdKVsDcIn39jYHtyA8sdXsPU0dP7yEIFCdl0sSPFRPzytQ==
X-Received: by 2002:a0c:8ecf:: with SMTP id y15mr30805391qvb.44.1588108622306;
        Tue, 28 Apr 2020 14:17:02 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id u7sm14035646qkj.51.2020.04.28.14.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 14:17:01 -0700 (PDT)
Date:   Tue, 28 Apr 2020 17:16:51 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Chris Down <chris@chrisdown.name>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>,
        Yafang Shao <laoar.shao@gmail.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm, memcg: Avoid stale protection values when cgroup
 is above protection
Message-ID: <20200428211651.GA400178@cmpxchg.org>
References: <cover.1588092152.git.chris@chrisdown.name>
 <d454fca5d6b38b74d8dc35141e8519b02089a698.1588092152.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d454fca5d6b38b74d8dc35141e8519b02089a698.1588092152.git.chris@chrisdown.name>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Apr 28, 2020 at 07:26:47PM +0100, Chris Down wrote:
> From: Yafang Shao <laoar.shao@gmail.com>
> 
> A cgroup can have both memory protection and a memory limit to isolate
> it from its siblings in both directions - for example, to prevent it
> from being shrunk below 2G under high pressure from outside, but also
> from growing beyond 4G under low pressure.
> 
> Commit 9783aa9917f8 ("mm, memcg: proportional memory.{low,min} reclaim")
> implemented proportional scan pressure so that multiple siblings in
> excess of their protection settings don't get reclaimed equally but
> instead in accordance to their unprotected portion.
> 
> During limit reclaim, this proportionality shouldn't apply of course:
> there is no competition, all pressure is from within the cgroup and
> should be applied as such. Reclaim should operate at full efficiency.
> 
> However, mem_cgroup_protected() never expected anybody to look at the
> effective protection values when it indicated that the cgroup is above
> its protection. As a result, a query during limit reclaim may return
> stale protection values that were calculated by a previous reclaim cycle
> in which the cgroup did have siblings.
> 
> When this happens, reclaim is unnecessarily hesitant and potentially
> slow to meet the desired limit. In theory this could lead to premature
> OOM kills, although it's not obvious this has occurred in practice.
> 
> Fixes: 9783aa9917f8 ("mm, memcg: proportional memory.{low,min} reclaim")
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Signed-off-by: Chris Down <chris@chrisdown.name>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Roman Gushchin <guro@fb.com>
> 
> [hannes@cmpxchg.org: rework code comment]
> [hannes@cmpxchg.org: changelog]
> [chris@chrisdown.name: fix store tear]
> [chris@chrisdown.name: retitle]

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
