Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB88921D474
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2020 13:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbgGMLFA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 Jul 2020 07:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729252AbgGMLE7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 13 Jul 2020 07:04:59 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADEC1C061755
        for <cgroups@vger.kernel.org>; Mon, 13 Jul 2020 04:04:58 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id n2so13123973edr.5
        for <cgroups@vger.kernel.org>; Mon, 13 Jul 2020 04:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=nN3m2m7pEWJxxgE22EVhuHKcD4TrCFPuvsPIp3KGX9k=;
        b=RqGITRMKNmMiYRdu6+vlFczkTYWFJp1c6+1yOC3ohAOzxc8vpAusqQEaQ0E2axiD3D
         QON4GHysm7Te5zUXV4Lz0GiISjc4xgU5T3b391ZpRcwJGbZ1amHXgAgqFQDjhLNJfgyG
         eX0sdzLY1TPzVvZ6Y5DHPyyoWITelQBhUSBaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=nN3m2m7pEWJxxgE22EVhuHKcD4TrCFPuvsPIp3KGX9k=;
        b=cLp4r5NCAAxX5sZhwCt+LXKB5zHotev1PrfWa+WCGvyPUptJKbR9spbr/+JP9t2gke
         3z4KvCQBFFDUHWHGJGveTRpVCr6qTSd48J36N2EIr5Hx8TogSXx7rrPTsu6xBr+kIruL
         oWTZTfW90LB3+5N/TF5Qp9tuUpyju5m9Yk9Elht+unCV0Bfoem74hEEi0fl3N6/OUq/E
         ew1fx+/418tJpwoUXnpbRu3AQzKJuijfct5B3XGk9F0ZdfLD36TfGWO7xl29RDNyOaJE
         5dWCb9oZo9U9mIeK7TSOCh0BakTSABNe/ahehjD+Ix+iZhv11Mclyt8OgT70389onUm9
         uLlQ==
X-Gm-Message-State: AOAM533dVXjuXjxHLmEZ/v4n2mzpDxl/gJX1eJm0Sx6mQ0j5R6pzUXiS
        fnU644OQUynK4gxM4jKoeV9Cpw==
X-Google-Smtp-Source: ABdhPJxJ/mazTAbJfCnV5ZLs6gKzw7Mb01cM+wDRYPldnGl3iBlU+mkR/ggy29bNiaIxfIFLSI4DFw==
X-Received: by 2002:a50:b5e3:: with SMTP id a90mr50641671ede.381.1594638297371;
        Mon, 13 Jul 2020 04:04:57 -0700 (PDT)
Received: from localhost ([2620:10d:c093:400::5:ef88])
        by smtp.gmail.com with ESMTPSA id j21sm11395375edq.20.2020.07.13.04.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 04:04:56 -0700 (PDT)
Date:   Mon, 13 Jul 2020 12:04:56 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>,
        Yafang Shao <laoar.shao@gmail.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] mm, memcg: memory.{low,min} reclaim fix & cleanup
Message-ID: <cover.1594638158.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.14.5 (2020-06-23)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This series contains a fix for a edge case in my earlier protection
calculation patches, and a patch to make the area overall a little more
robust to hopefully help avoid this in future.

Changes in v4:

- Fix premature OOM when checking protection on root memcg. Thanks
  Naresh and Michal for helping debug.

Chris Down (1):
  mm, memcg: Decouple e{low,min} state mutations from protection checks

Yafang Shao (1):
  mm, memcg: Avoid stale protection values when cgroup is above
    protection

 include/linux/memcontrol.h | 95 ++++++++++++++++++++++++++++++++------
 mm/memcontrol.c            | 36 ++++++---------
 mm/vmscan.c                | 20 +++-----
 3 files changed, 103 insertions(+), 48 deletions(-)

-- 
2.27.0

