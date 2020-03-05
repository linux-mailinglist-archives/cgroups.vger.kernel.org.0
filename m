Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5879917AE2B
	for <lists+cgroups@lfdr.de>; Thu,  5 Mar 2020 19:36:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725974AbgCESgR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 5 Mar 2020 13:36:17 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46541 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgCESgR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 5 Mar 2020 13:36:17 -0500
Received: by mail-wr1-f67.google.com with SMTP id n15so2931952wrw.13
        for <cgroups@vger.kernel.org>; Thu, 05 Mar 2020 10:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=NuoA3fuPswQR3q6MZEyPSq0NTYh8WVfp4GhRULEWRIY=;
        b=RR6nLtANxW9IiN4v3USYLxGNCnrYUqcerZ41dSbNfgtylvE//xJdTrZEBL+kNgm39E
         GW38qiN3bLqBFwcftKaWbuQrsZfUGSiWHD1yTQOF/wl6lElGraB+5LU/2usxQN+DFhcE
         oci1LJb9PY8XkR1F4BEGDEgap7+++0Iv12xcc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=NuoA3fuPswQR3q6MZEyPSq0NTYh8WVfp4GhRULEWRIY=;
        b=sH4IW7Q16lssxVwLHE89z8s8DIMePwsjagLgoVH15VkDEaaX3IzphelKjTiVpE7Z6F
         R+evfpxDYbqCvrpPXLpeW/aCwIYYEw1w8BatzZVAxgzSIpXKn0U3T/X5D1m8npFrvel1
         HwsIKMbJmepYc1CSkIvcckZHWMt6D0LC4oSuM9hiKUPDl68yvDIIIY/ysyp4jXYzm2R+
         kBisWF5LeXCKwMpNuQ+usdSDDTZmyheQDxYMqIzs43LjIO3F4sWqcxNC98aCZ+EVVrbN
         MmEy4EO3r4A1KNCmRH/EwvFWATm8qqHs0yoKxPbnQBp8fQxEBUVJXUjiwa4ZykBENQM5
         yxdA==
X-Gm-Message-State: ANhLgQ3kg7NILi2xI75SJwz86WBi1w6vDrBuOC+QifrdApnmr99s0vIl
        m/Jx4sIyORiNa3A4zrNLDekFaHs9er+MRA==
X-Google-Smtp-Source: ADFU+vtdNZNZmPNSsajXjWtBz/3Labc+zWb3NvUh2WOyO/hINkn6LFD5bSu91HFy6qp5a616NzYT4w==
X-Received: by 2002:a05:6000:100d:: with SMTP id a13mr258226wrx.330.1583433375392;
        Thu, 05 Mar 2020 10:36:15 -0800 (PST)
Received: from localhost ([2620:10d:c092:180::1:6808])
        by smtp.gmail.com with ESMTPSA id x17sm5432831wrt.31.2020.03.05.10.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 10:36:15 -0800 (PST)
Date:   Thu, 5 Mar 2020 18:36:14 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2] mm: Make mem_cgroup_id_get_many() __maybe_unused
Message-ID: <20200305183614.GB752201@chrisdown.name>
References: <20200305164354.48147-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200305164354.48147-1-vincenzo.frascino@arm.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Vincenzo Frascino writes:
>mem_cgroup_id_get_many() is currently used only when MMU or MEMCG_SWAP
>configuration options are enabled. Having them disabled triggers the
>following warning at compile time:
>
>linux/mm/memcontrol.c:4797:13: warning: ‘mem_cgroup_id_get_many’ defined
>but not used [-Wunused-function]
> static void mem_cgroup_id_get_many(struct mem_cgroup *memcg, unsigned
> int n)
>
>Make mem_cgroup_id_get_many() __maybe_unused to address the issue.
>
>Cc: Johannes Weiner <hannes@cmpxchg.org>
>Cc: Michal Hocko <mhocko@kernel.org>
>Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
>Cc: Andrew Morton <akpm@linux-foundation.org>
>Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

Thanks, I didn't notice you've already posted it before replying on v1 :-)

Acked-by: Chris Down <chris@chrisdown.name>

>---
> mm/memcontrol.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
>diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>index d09776cd6e10..2b9533ed52f5 100644
>--- a/mm/memcontrol.c
>+++ b/mm/memcontrol.c
>@@ -4794,7 +4794,8 @@ static void mem_cgroup_id_remove(struct mem_cgroup *memcg)
> 	}
> }
>
>-static void mem_cgroup_id_get_many(struct mem_cgroup *memcg, unsigned int n)
>+static void __maybe_unused mem_cgroup_id_get_many(struct mem_cgroup *memcg,
>+						  unsigned int n)
> {
> 	refcount_add(n, &memcg->id.ref);
> }
>-- 
>2.25.1
>
>
