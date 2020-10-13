Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B09E28D478
	for <lists+cgroups@lfdr.de>; Tue, 13 Oct 2020 21:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbgJMT2T (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 13 Oct 2020 15:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbgJMT2T (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 13 Oct 2020 15:28:19 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75112C0613D0
        for <cgroups@vger.kernel.org>; Tue, 13 Oct 2020 12:28:18 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id y14so391245pfp.13
        for <cgroups@vger.kernel.org>; Tue, 13 Oct 2020 12:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=XGODVd8VkNSh8S84Wy0CghHqd0aFoaKdhs2B2qvJRwU=;
        b=QJDFWLm9JSrh/of7EIAurbQWhS26t3KiBiOYedmnmy5W/mdATsMGEThFkfuueGBiuD
         yUx1IWye8xXZ5sZSqRsm7uTgnhlhfgCInmdC1BBsnn3PuEIBlmJNZsAgXq9S7zqq0S+k
         zpgr/O1j/KEq5Hw+fxDBQIwzBRl+pO5bhGB5/7QtKTCJD+aD13xRuYup8hwes+FPXZ8b
         mHxg4A0iKwEsTeY5xl8BTKeTkxO4qwYgfcqQw1zOCb2g+eBsH/TGzwa8Knmrs+DjzrRa
         zBVL/4EvNgN+SEuUAdMs2M80hAWa/LAyVCDi8dhXt9t33NkGO9eMsNnF7GkJT+mRbIrA
         e/FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=XGODVd8VkNSh8S84Wy0CghHqd0aFoaKdhs2B2qvJRwU=;
        b=tfjF7L/S+V3DTWWKMTENtRjkHB9TmUx6zk8PJDw9lwTbKP8vxMU8YM9k9NR9PYg5Ky
         HNeCwAZjLkyYvV0zT5arqAKi2HH6MEqKHk9Wovi6aaBAeT/jGZRRygvcOlmXdKphQvsz
         uRfhG/5UEGGsTZQYP0cmzog8RnsyFt4js+OASRPrjMt1oJq9hcqmR42N7tF+jZZNt+ic
         CqwlRqDNOfXP+zPt0l6abPU81OOU+y+3VrVsvsCW2P3yZbQgK2ip+eIepDNcTeXQAHMU
         ulhVHuYrVaNo0OymS7RVDNqrX6zUaS97sNi2NPw3GHTckcrD1z5aYXWa3mqJwsyrbJfZ
         q8BQ==
X-Gm-Message-State: AOAM531At8/lEasO3iFAmHWdY6yr8mHe6woi2+a1wp274cvqFNvGuLzc
        zSCIouFn5uQr1TmW/gGtFUhxPg==
X-Google-Smtp-Source: ABdhPJy2evLKaGL1nBwO+26TFfdymcOWCpNx62svTg8d0nxs5ceQ34ZURql6eqJr6Kw1O+7SRZw3Nw==
X-Received: by 2002:a05:6a00:44:b029:152:8967:1b2a with SMTP id i4-20020a056a000044b029015289671b2amr1158045pfk.48.1602617297742;
        Tue, 13 Oct 2020 12:28:17 -0700 (PDT)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id s23sm413493pgl.47.2020.10.13.12.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 12:28:16 -0700 (PDT)
Date:   Tue, 13 Oct 2020 12:28:15 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Muchun Song <songmuchun@bytedance.com>
cc:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, cl@linux.com, penberg@kernel.org,
        iamjoonsoo.kim@lge.com, shakeelb@google.com, guro@fb.com,
        vbabka@suse.cz, laoar.shao@gmail.com, chris@chrisdown.name,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] mm: memcontrol: Remove unused mod_memcg_obj_state()
In-Reply-To: <20201013153504.92602-1-songmuchun@bytedance.com>
Message-ID: <alpine.DEB.2.23.453.2010131228021.2883230@chino.kir.corp.google.com>
References: <20201013153504.92602-1-songmuchun@bytedance.com>
User-Agent: Alpine 2.23 (DEB 453 2020-06-18)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, 13 Oct 2020, Muchun Song wrote:

> Since commit:
> 
>   991e7673859e ("mm: memcontrol: account kernel stack per node")
> 
> There is no user of the mod_memcg_obj_state(). This patch just remove
> it. Also rework type of the idx parameter of the mod_objcg_state()
> from int to enum node_stat_item.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Acked-by: David Rientjes <rientjes@google.com>
