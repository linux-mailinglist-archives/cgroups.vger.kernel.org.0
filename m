Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13F6D2A82BD
	for <lists+cgroups@lfdr.de>; Thu,  5 Nov 2020 16:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731586AbgKEPzS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 5 Nov 2020 10:55:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731560AbgKEPzS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 5 Nov 2020 10:55:18 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D192C0613CF
        for <cgroups@vger.kernel.org>; Thu,  5 Nov 2020 07:55:18 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id k9so1580018qki.6
        for <cgroups@vger.kernel.org>; Thu, 05 Nov 2020 07:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=A3JA9WEFpRuCAbhY2DBNk/bNA/HrXMr9AT46oTgaBJc=;
        b=iE2JW9bLmeyDb8+yOQGwPSMgBWXGejaZMqGA4cvyWkomZy8WrhWPWjVl/6AlmObyKl
         iUvEVobpJggmpeNwPzM0+B4lsSQYI0RGUFGlU+GaKYmNYjeL7RlgXRaOU5vu7BpLmKLz
         b6d5uerULC4QbQ4GTFrYFH9vVziu7NUf2IOv/Gqw+8Yi0bHtTQ2zd7xuJsn5ieVGqJ2/
         8bSXkOZyKtBcrYstoI8nMWWG9zuCuNjvIPHMT/g+lWlruh+BRNpQUCAGXi18LnRPKpgz
         W1KIdVcHHWs2RqTY3NHosrKq8wStbQjj0A16XDgRpYAQMnPZifnI/1QB6PdcMzllpXjs
         ruhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=A3JA9WEFpRuCAbhY2DBNk/bNA/HrXMr9AT46oTgaBJc=;
        b=kjSQvXtfa0tGWzQkVfYJ2v0i+PiGS17tN8wz54+Udel5mDssen2PjV90Kzly4AuTha
         wjrNZ1NgCTvVVMrLDLNyb9MoPH3Q7kkGVrb7dtbjAhtEX1sA2IQgS2WI+H9fcsD6DgR3
         SEu0fQMbs84MHuCQBJ8ILe5aYCvIlv7+uSlzmbutRuNT9mM/05PDOK7YuomjdchlaOoL
         EpuX51Na24RsJfAWQ5bYrwRTK5FSa8jRqTP2ETf91msH/mJSXRh+vPKnBwo/ZzaQWuBX
         5h6n5A4XuQ8FjbK4v5XJgAey7wV2cSb6FhDX6F0tYfniYLwGPwq6R4QUQepLQMj+p9Xo
         DaXQ==
X-Gm-Message-State: AOAM5308IDV3+ZJIw5uxde3c1pDvYTNu40zr4frVJ1obAI2Ac/19hbsL
        FuNJ01cfvBgHEFXPnBS1H+KAGIckuRE7PA==
X-Google-Smtp-Source: ABdhPJwcraIqbJ3b5alyPraU5Bj9UQ/pjTE9hZ55uU+SAxXYsxTVO0mKKnn9bGpqnpigK5ac/u/Spw==
X-Received: by 2002:a37:4ca:: with SMTP id 193mr2715271qke.346.1604591717689;
        Thu, 05 Nov 2020 07:55:17 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:fc05])
        by smtp.gmail.com with ESMTPSA id k15sm1133883qtq.11.2020.11.05.07.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 07:55:16 -0800 (PST)
Date:   Thu, 5 Nov 2020 10:53:31 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Hui Su <sh_def@163.com>
Cc:     mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, shakeelb@google.com, guro@fb.com,
        laoar.shao@gmail.com, chris@chrisdown.name,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] mm/memcontrol:rewrite mem_cgroup_page_lruvec()
Message-ID: <20201105155331.GE744831@cmpxchg.org>
References: <20201104142516.GA106571@rlk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104142516.GA106571@rlk>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Nov 04, 2020 at 10:25:16PM +0800, Hui Su wrote:
> mem_cgroup_page_lruvec() in memcontrol.c and
> mem_cgroup_lruvec() in memcontrol.h is very similar
> except for the param(page and memcg) which also can be
> convert to each other.
> 
> So rewrite mem_cgroup_page_lruvec() with mem_cgroup_lruvec().
> 
> Signed-off-by: Hui Su <sh_def@163.com>

Nice.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
