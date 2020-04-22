Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A48941B3794
	for <lists+cgroups@lfdr.de>; Wed, 22 Apr 2020 08:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbgDVGhH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 22 Apr 2020 02:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbgDVGhH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 22 Apr 2020 02:37:07 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18824C03C1A6;
        Tue, 21 Apr 2020 23:37:07 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id g2so555379plo.3;
        Tue, 21 Apr 2020 23:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5sPywIAZDU2flYyDIq+uLr1t/vlUGNE5qQ6q2icgX/U=;
        b=iuvvnEZydRgcq1Z4TUJreYmlRt+sDrNv+6pNyoY30/hH0jp9bzYa4PgigR0HeZigW/
         UeUbY4E+IqKrpvjloRy8LUuBHCH0mo5ESeOr1ieFkeMods47eHkBBwA3ZZ5cGFQgjJnW
         mfaw0JE185YwVfJ/9AOZQDjc69yc8QcivrulSEbX4VKZKUyS/aVx2FQKOgfERe7SqKoI
         /xTBhLF92vinPrne/b96oDFEbEx8S/kA7U86CV/5GjXMVsYn1gs9LR7SFEhPxJr5QGAb
         PEJwNERbqxn4DZM7azcgmaOFn+S03cJb9L+KVrjYxeMVI4pPkk5ogMeU/NNkvICMN4cD
         6KAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5sPywIAZDU2flYyDIq+uLr1t/vlUGNE5qQ6q2icgX/U=;
        b=DRP6wqn0a843/oyVgQcWnG9IpTy3PFsTCFVOZylxeuPN1iHQfE5czp0nZrrWjfbzJJ
         clbaIJKPATwHVsFCEVdtMoTppvWcSzivDCq1NaoKcCHOirce85lA8KOeeHn5CXREaVPk
         Gmh+OwygR9jJx8Nh65t4+lf5LMH2n00Tgmi1W8nVZfdEVHZhipD2UyiIbtfai9Zq5Uhc
         xFoVIEJSWOBPXg+3kZbuHKWKfaDyr94mlpUt80GT84Dewvx9kuG0/yR1WGkeGqXQ1zj2
         bgh8P4eS0Knzn7CMS4mEViC6/kXXuoWQTouyygCDmXk0PQ84kd+4WIqiTk7T5nSVLbxj
         npuA==
X-Gm-Message-State: AGi0PubxLzpkX8KkusWPyg0RyBFYmEAdBgz5shf7OROFaP+fO9704rG5
        IHZ3jLTqdLidikNRc0gGKX0=
X-Google-Smtp-Source: APiQypJNXtE7bUPN3v1Q8dfxJQoVTDfXRiXQy28zJ6pB+c1zUue2V9J3jQ1XysYPJeECJnlHZSxzAA==
X-Received: by 2002:a17:902:a513:: with SMTP id s19mr25897949plq.84.1587537426575;
        Tue, 21 Apr 2020 23:37:06 -0700 (PDT)
Received: from js1304-desktop ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id r10sm4144366pgh.23.2020.04.21.23.37.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Apr 2020 23:37:06 -0700 (PDT)
Date:   Wed, 22 Apr 2020 15:37:00 +0900
From:   Joonsoo Kim <js1304@gmail.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Shakeel Butt <shakeelb@google.com>,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 03/18] mm: memcontrol: drop @compound parameter from
 memcg charging API
Message-ID: <20200422063659.GC6780@js1304-desktop>
References: <20200420221126.341272-1-hannes@cmpxchg.org>
 <20200420221126.341272-4-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420221126.341272-4-hannes@cmpxchg.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Apr 20, 2020 at 06:11:11PM -0400, Johannes Weiner wrote:
> The memcg charging API carries a boolean @compound parameter that
> tells whether the page we're dealing with is a hugepage.
> mem_cgroup_commit_charge() has another boolean @lrucare that indicates
> whether the page needs LRU locking or not while charging. The majority
> of callsites know those parameters at compile time, which results in a
> lot of naked "false, false" argument lists. This makes for cryptic
> code and is a breeding ground for subtle mistakes.
> 
> Thankfully, the huge page state can be inferred from the page itself
> and doesn't need to be passed along. This is safe because charging
> completes before the page is published and somebody may split it.
> 
> Simplify the callsites by removing @compound, and let memcg infer the
> state by using hpage_nr_pages() unconditionally. That function does
> PageTransHuge() to identify huge pages, which also helpfully asserts
> that nobody passes in tail pages by accident.
> 
> The following patches will introduce a new charging API, best not to
> carry over unnecessary weight.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
