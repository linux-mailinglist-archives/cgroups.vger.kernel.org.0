Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57D471F594A
	for <lists+cgroups@lfdr.de>; Wed, 10 Jun 2020 18:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbgFJQm1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 10 Jun 2020 12:42:27 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:32939 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbgFJQm1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 10 Jun 2020 12:42:27 -0400
Received: by mail-wm1-f66.google.com with SMTP id j198so5069105wmj.0;
        Wed, 10 Jun 2020 09:42:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ook+0bD6nDY7guFSHqX6ZWDJpxvAcnd7uAbxr86fzgA=;
        b=CKacqhAyf0TxQgaQC+am7iJo4KA+4beZCpQATGsUODSKFG1n6+gbMS+xITeM8efrf2
         RwNU2pKIuPTC7C9WesoJ95uX/dB4Y70hWeGDMWx1sviPw8BQ95HMEAhbzsJL0GD1hpN5
         fGUcX4Ru7nPsnzVlzBgp+odeGjcLgptUe1XN/mEshiCbyek/0bdIvsMq8SPGr3ORvM1B
         Iy9vuTSFRzXZJqloF8g9Q/w8XzaL5bYi0ZyzPQqOo8PMfFG+zafgX3fPEBid5DVP1wdp
         +DRAtXAbGizIqZHxwWeZYhDmCknpotKAom6da3nkkhU3Tnf+IZtx/CfFaIq7GBUyu+cW
         /pXQ==
X-Gm-Message-State: AOAM532Wdytrk+cKDPNS34GHiUTNpWKGBuW1zFNr4gZ5Lo4Nb57YbuQg
        HO15SBZpsvki7TfDKEpONt0iqnQT
X-Google-Smtp-Source: ABdhPJxmYRD6cZbJSPnxkRZsit0PruzpSfdFiZDIgh6S35E8QE1VmM5NhYom44xkETDEF/JI5xHTjQ==
X-Received: by 2002:a7b:c18a:: with SMTP id y10mr4245243wmi.73.1591807345411;
        Wed, 10 Jun 2020 09:42:25 -0700 (PDT)
Received: from localhost (ip-37-188-155-130.eurotel.cz. [37.188.155.130])
        by smtp.gmail.com with ESMTPSA id s7sm471331wrr.60.2020.06.10.09.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 09:42:24 -0700 (PDT)
Date:   Wed, 10 Jun 2020 18:42:22 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Joonsoo Kim <js1304@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 09/19] mm: memcontrol: switch to native NR_FILE_PAGES and
 NR_SHMEM counters
Message-ID: <20200610164222.GE20204@dhcp22.suse.cz>
References: <20200508183105.225460-1-hannes@cmpxchg.org>
 <20200508183105.225460-10-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508183105.225460-10-hannes@cmpxchg.org>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri 08-05-20 14:30:56, Johannes Weiner wrote:
> Memcg maintains private MEMCG_CACHE and NR_SHMEM counters. This
> divergence from the generic VM accounting means unnecessary code
> overhead, and creates a dependency for memcg that page->mapping is set
> up at the time of charging, so that page types can be told apart.
> 
> Convert the generic accounting sites to mod_lruvec_page_state and
> friends to maintain the per-cgroup vmstat counters of NR_FILE_PAGES
> and NR_SHMEM. The page is already locked in these places, so
> page->mem_cgroup is stable; we only need minimal tweaks of two
> mem_cgroup_migrate() calls to ensure it's set up in time.
> 
> Then replace MEMCG_CACHE with NR_FILE_PAGES and delete the private
> NR_SHMEM accounting sites.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> Reviewed-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

While looking at the code I've noticed that add_to_swap_cache resp.
__delete_from_swap_cache are accounting only to global counters.
Is there any reason for that? Not something that this patch is
responsible for of course but I am just wondering.
-- 
Michal Hocko
SUSE Labs
