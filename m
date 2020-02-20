Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58050166A24
	for <lists+cgroups@lfdr.de>; Thu, 20 Feb 2020 23:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729150AbgBTWCn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 20 Feb 2020 17:02:43 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44973 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727656AbgBTWCm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 20 Feb 2020 17:02:42 -0500
Received: by mail-qk1-f195.google.com with SMTP id j8so14436qka.11
        for <cgroups@vger.kernel.org>; Thu, 20 Feb 2020 14:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Qs+LhNiBMIj9A7PLEkqadpwwdn4t7ZJVTcZjDGn03PM=;
        b=1sM+flAalAjdf9H+ABF4RBpnc7mgf/EB1PkQ3GIvPhatEPuYG/+kZZYytUx2breYo9
         oBS4Cz3/NHUDHKrF1wClmlsU2wMQWRh9jUeUVFlKDnYU1XDy2DbPjMAN6/dFKk+WparC
         n2mnFSbEJsFPwZS1Vkfj9gnphTLnT9mqRYcdYb3mcnuK5c108UQ0b24WLrAoGSNFpyha
         iPLMyEc4PN5W+kfi2o4BOepzuEVVQ0MwF8HwWATiYKm8p4b2uSETdNaNTVOHwu7ULX5K
         9cl6gc557oQYGhjYLQyYi1BtFt0PWyzSVcxVJSRFwVQAzbgf64CESMf7EXkdNMTvkNc/
         T1Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Qs+LhNiBMIj9A7PLEkqadpwwdn4t7ZJVTcZjDGn03PM=;
        b=pgLUDND3W8pkf00VE7AUD7yO3V8YX8c+n1WhGg1ELdB9m83AKLqOOfcBBhG/O1FIJ2
         /NKKnHV5yA4Se1ayjVDUvNUFYqI101dvzjXvwftYvucM6I3b0xnkqD2nsi2rvXchiHDl
         DKgZGazT5/w3bG2epvC7BlikvzeSxTa5Tf6d3zgCtkEUvuEeKmPU/LjJXCgZFk2ucACV
         FXRIA2d8rfgfxTnk2lVCmq8G6ubS9wzoHY7kf4JizyVgA5M5HC/Kfsl30mzzDOxysoWw
         yZXPn39qWK+nZfKns2PAZiHocsQkq6eunRXygBqG57XbyXgxdJ+GqR3sYZpix3GPi/kC
         ioFg==
X-Gm-Message-State: APjAAAXDljwFrabe5fkQKF5hU7n7rlWE1Q+DmxksX0wt6ojJ2/lq7h4B
        1HUuTjlj+siR8bMKd7GZIHj3og==
X-Google-Smtp-Source: APXvYqzeLjYnxMcLPrrXE8eCyXI/Ol0Il3CHL5hbzaE2ieHBb3/wY1MEQ7PKwGJEA0oW/FVjRgCOZA==
X-Received: by 2002:a05:620a:1037:: with SMTP id a23mr29030822qkk.82.1582236160287;
        Thu, 20 Feb 2020 14:02:40 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::1:3504])
        by smtp.gmail.com with ESMTPSA id e16sm518875qkl.32.2020.02.20.14.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 14:02:39 -0800 (PST)
Date:   Thu, 20 Feb 2020 17:02:38 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Dan Schatzberg <schatzberg.dan@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Chris Down <chris@chrisdown.name>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        "open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" 
        <linux-mm@kvack.org>
Subject: Re: [PATCH v3 3/3] loop: Charge i/o to mem and blk cg
Message-ID: <20200220220238.GB68937@cmpxchg.org>
References: <cover.1582216294.git.schatzberg.dan@gmail.com>
 <78060dcbf6578b4da6081f9f48b24b33726c5083.1582216295.git.schatzberg.dan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78060dcbf6578b4da6081f9f48b24b33726c5083.1582216295.git.schatzberg.dan@gmail.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Feb 20, 2020 at 11:51:53AM -0500, Dan Schatzberg wrote:
> The current code only associates with the existing blkcg when aio is
> used to access the backing file. This patch covers all types of i/o to
> the backing file and also associates the memcg so if the backing file is
> on tmpfs, memory is charged appropriately.
> 
> This patch also exports cgroup_get_e_css so it can be used by the loop
> module.
> 
> Signed-off-by: Dan Schatzberg <schatzberg.dan@gmail.com>

The cgroup bits look good to me.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
