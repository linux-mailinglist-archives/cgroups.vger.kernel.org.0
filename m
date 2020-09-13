Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAE81268079
	for <lists+cgroups@lfdr.de>; Sun, 13 Sep 2020 19:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbgIMRJU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 13 Sep 2020 13:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725969AbgIMRJR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 13 Sep 2020 13:09:17 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB265C061788
        for <cgroups@vger.kernel.org>; Sun, 13 Sep 2020 10:09:16 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id s13so8523964wmh.4
        for <cgroups@vger.kernel.org>; Sun, 13 Sep 2020 10:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NHSyG/ZtG9S0n0YZM7cSzTFQ+FkKUxE2tX0ghcDmfZ0=;
        b=kXjiBqYL6OViT3ewAjh9aCHJsTXRTaC9OZ01erzxJzAY0iuwHOa6mBt/6RPf+22jJd
         g+UbRQyTmu2YclZLlFGpfI5q/gvpZ+Fu5Z73vb11F0o9mGNsGXQvXPXxKQod18U4WBU1
         HxqWnKX+7mSCl2lhKU7uexA73WmMS93491Q9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NHSyG/ZtG9S0n0YZM7cSzTFQ+FkKUxE2tX0ghcDmfZ0=;
        b=gLAQoxV8GHUbFnCqWau+PKlxAprPJHo2bnESZHShMzcbj/C8o9odfr4lRplu4CxuHC
         K505qqKUu6EiUWZzIznIjXo5pmYdQgxPUnsvnu4HZ8HofJI73DXaJ+vAuVLLd8QprK4Z
         K5mcqFnNInpkWic1/I11KT0Fl4y3sxvzX7NQk/guA7nScx/PI+BF9/kJkL4OdJUUTNJ+
         eE95ApKyYPeRE/RpWcVnyKTbBEljccfl6AzUeQJU8z7YD5l5MkSInyivEujAACTVBGDx
         a5dEyamYAKpyn1VMTwhCdFSP2t22LuTbTsTM4A0hk2vvu01gJK/9HPIgncMq10AjRH8H
         dZVA==
X-Gm-Message-State: AOAM533Iz31BwbSJONmJ5fTIjN9DJRJpXX49lQDXWswSKrVIjXuonY6O
        uiAAIomAY+zM04QJaSsJCimTjw==
X-Google-Smtp-Source: ABdhPJwL1luvqQq2GdA/kvbVc2X5wQ2OPvXWO9D/pL7y3epijMqdaCQIrgYZQ16AcG8kZ+Tp9tpJIA==
X-Received: by 2002:a1c:6555:: with SMTP id z82mr11236947wmb.101.1600016954047;
        Sun, 13 Sep 2020 10:09:14 -0700 (PDT)
Received: from localhost ([2a01:4b00:8432:8a00:63de:dd93:20be:f460])
        by smtp.gmail.com with ESMTPSA id q18sm15870487wre.78.2020.09.13.10.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2020 10:09:13 -0700 (PDT)
Date:   Sun, 13 Sep 2020 18:09:13 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     tj@kernel.org, lizefan@huawei.com, hannes@cmpxchg.org,
        corbet@lwn.net, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, shakeelb@google.com, guro@fb.com,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v3] mm: memcontrol: Add the missing numa_stat interface
 for cgroup v2
Message-ID: <20200913170913.GB2239582@chrisdown.name>
References: <20200913070010.44053-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200913070010.44053-1-songmuchun@bytedance.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Muchun Song writes:
>In the cgroup v1, we have a numa_stat interface. This is useful for
>providing visibility into the numa locality information within an
>memcg since the pages are allowed to be allocated from any physical
>node. One of the use cases is evaluating application performance by
>combining this information with the application's CPU allocation.
>But the cgroup v2 does not. So this patch adds the missing information.
>
>Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>Suggested-by: Shakeel Butt <shakeelb@google.com>
>Reported-by: kernel test robot <lkp@intel.com>

This is a feature patch, why does this have LKP's Reported-by?
