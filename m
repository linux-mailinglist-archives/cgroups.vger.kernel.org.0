Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E03F13F9E53
	for <lists+cgroups@lfdr.de>; Fri, 27 Aug 2021 19:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235700AbhH0Rv5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 27 Aug 2021 13:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbhH0Rv5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 27 Aug 2021 13:51:57 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F59CC061757;
        Fri, 27 Aug 2021 10:51:08 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id j2so4413733pll.1;
        Fri, 27 Aug 2021 10:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=c65PIoZtXrK5fG5yv9bS73WbrNpIpRgBV7KDj6Yda9o=;
        b=IdBLcrm3jZpcZrU/u1e8c49BCTkbf1fL9uye8pgEDvFivomEZ9CkjJScQHaslx8MRm
         Z6ks5DWfj9tf0yvzUXn43NlaS9EfJwcKUVcLkq4Fsg4leSe/mR+pAC7EsMr6gXo4QgGn
         4oWayV3tbdmwUCY5PZbZwTkREOjQIy+dZjVa4VbMu3KZf4tjv2j9UGMw1oWQB2aDAer9
         v1j/drh3EWQe92JJWBb2osEz1CcA6O/fPmWIJqrI7Rg26DcZ5kOdV8Y5P0KAmE47EJwe
         lQeUASFfUjFpg/jfmeKvlS81m/BhLeF/vUPhalCfuaspJz6FMd2QpFM22zcvLMeej0s/
         0ENg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=c65PIoZtXrK5fG5yv9bS73WbrNpIpRgBV7KDj6Yda9o=;
        b=mNgJbHzV5gHtxofo39efx6zPNEQD/5+WVGt3lYUl7oZ6F1e8P7bkKDLS3n/I/HHoF6
         HNj1PiSgPwtTqHkRdAi7WDYjmyaftlHiTsV5dQ1UgyHnnaF3uciyHVxErZsSpMSTylFL
         ZJ2sstgHapBjJ78PweAyyz/V2LJ/O4yd4mjE8YP1DbJP6H+Z9a2XuNiQw8NMQcVQPCMP
         uTZMed2lsLSKC3zFxX0e13RmgLZJ7R8OAl4+kOlnKMy3YM1Gmp780W4YfQzjn/at8I3a
         At2iYf9aQmHfodDC4PWdlYB/7aErJLE1pcUDhPCJnf3UKQ+KIYKCXWuHXlFtDt5Qli9f
         G0RQ==
X-Gm-Message-State: AOAM5318uYBP0Tn5qE6AXkd4AN21PxMLDRb/0pCItZfMxJIMVS+v5Mb9
        bGki15TxbU6ccAy1OxymzMQ=
X-Google-Smtp-Source: ABdhPJyKNuu8YFmP/NPLRgOuwuUnXHyKeo4iR4oHDHkmWjX/1Z1MzYQdwhYdQpEOpx4nLT91WlP8lQ==
X-Received: by 2002:a17:90a:5d8b:: with SMTP id t11mr12169346pji.136.1630086667376;
        Fri, 27 Aug 2021 10:51:07 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id e18sm6462549pfv.172.2021.08.27.10.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 10:51:07 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 27 Aug 2021 07:51:05 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] cgroup: Avoid compiler warnings with no subsystems
Message-ID: <YSkmCVwLvfusqtmA@slm.duckdns.org>
References: <20210827150424.2729274-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210827150424.2729274-1-keescook@chromium.org>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Aug 27, 2021 at 08:04:24AM -0700, Kees Cook wrote:
> +	if (CGROUP_SUBSYS_COUNT > 0 && ss)

Can we encapsulate this in a macro so that it's clear (or at least
consolidated) why we need these without adding a comment in each spot?

Thanks.

-- 
tejun
