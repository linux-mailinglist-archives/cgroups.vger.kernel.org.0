Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B25F27C6F9B
	for <lists+cgroups@lfdr.de>; Thu, 12 Oct 2023 15:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379009AbjJLNrb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 12 Oct 2023 09:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378999AbjJLNrb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 12 Oct 2023 09:47:31 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434BED7
        for <cgroups@vger.kernel.org>; Thu, 12 Oct 2023 06:47:29 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d9a3e0f8872so1293531276.0
        for <cgroups@vger.kernel.org>; Thu, 12 Oct 2023 06:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697118448; x=1697723248; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DuNnrzJ8TZmFHgla38IiJAHz6vdp6e7COdPQWBTgcM4=;
        b=nR/y+VBzi0jiHJNjW8yVfFrbqED5ry/ioJeRII6NAE7EZiCyYHU1UmimB5Zq6FS+l6
         VdpWcYeu20nBHvfjW1Y4I1noXfmJa2jpeu0fr8BYy3gcHKx76Rs2mmlmpP3i/nz1tZpf
         9YHgiUW5eiq6A2ZEarhxKxNk3QAOBxNwVyxRI3/WRmgzwf6vGkv/u/mA0gPwi8NO6q43
         RlLHZZwirBfluc9CxkRH3XeGC63IfZSXOR9WX+HZAnvN++R9h72B6WzkHTfv0FsSiasd
         NWjaxDx7K2PvzvO+ijxEb5LChYv6uvhiacWLIt9mfYwAat6NqTkPKI6QzjL4H+NhrEEn
         ypiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697118448; x=1697723248;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DuNnrzJ8TZmFHgla38IiJAHz6vdp6e7COdPQWBTgcM4=;
        b=vsEyqvkErUgvIrvN6Pklv7C8GK7lcMnz0sS75XhVre78DqKujEku92Ti+Whfj6W8fz
         eZhEQgJuPaWbztaHYH1Eh0KqCt1AbFy95tGMDqveXi0JO7heEZP0sUoiKS98aBtSz1IM
         euMSJEBRGdKZUntBtjYZ3sBFsiuPKMYqMi9qkbbx5JK01g3nGQE3NuXxsSEkwoENqRpS
         OlSN9BxoFI9+uO496rXRtgShzTUb4X9SQ9wuXwhIstD8ppftlgpc4eh816PI5svseVx+
         +CxWN84n4mJtGM05+C14kBj8+9F/mfJdZhBauHa+r5JynI0pTaTvQgJmx8oXARRzTPxm
         7y7Q==
X-Gm-Message-State: AOJu0Yzh7MFAkMp/IA5hwESMTdKhOM0V70cBtKU5s+B/e/vcT0h8jtK/
        y6RqymPCL6ehtO3D4fo2ydFUJaSEncenOQ==
X-Google-Smtp-Source: AGHT+IHlGLl/qOBcvQE1T9yTdJkdQCvfutpS5ddEMVcRVWVA0zoP6o3SbVnxF2bJCEkg5g01fezxTlP8Eb01LQ==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a5b:5c9:0:b0:d8b:737f:8240 with SMTP id
 w9-20020a5b05c9000000b00d8b737f8240mr472636ybp.0.1697118448415; Thu, 12 Oct
 2023 06:47:28 -0700 (PDT)
Date:   Thu, 12 Oct 2023 13:47:26 +0000
In-Reply-To: <20231010000929.450702-5-roman.gushchin@linux.dev>
Mime-Version: 1.0
References: <20231010000929.450702-1-roman.gushchin@linux.dev> <20231010000929.450702-5-roman.gushchin@linux.dev>
Message-ID: <20231012134726.kx3rcm7vkgxe3nib@google.com>
Subject: Re: [PATCH v2 4/5] mm: kmem: scoped objcg protection
From:   Shakeel Butt <shakeelb@google.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Dennis Zhou <dennis@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Oct 09, 2023 at 05:09:28PM -0700, Roman Gushchin wrote:
> Switch to a scope-based protection of the objcg pointer on slab/kmem
> allocation paths. Instead of using the get_() semantics in the
> pre-allocation hook and put the reference afterwards, let's rely
> on the fact that objcg is pinned by the scope.
> 
> It's possible because:
> 1) if the objcg is received from the current task struct, the task is
>    keeping a reference to the objcg.
> 2) if the objcg is received from an active memcg (remote charging),
>    the memcg is pinned by the scope and has a reference to the
>    corresponding objcg.
> 
> Signed-off-by: Roman Gushchin (Cruise) <roman.gushchin@linux.dev>

Other than one nit below:

Acked-by: Shakeel Butt <shakeelb@google.com>

> ---
>  include/linux/memcontrol.h |  6 +++++
>  mm/memcontrol.c            | 47 ++++++++++++++++++++++++++++++++++++--
>  mm/slab.h                  | 10 +++-----
>  3 files changed, 54 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 277690af383d..0e53b890f063 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -1769,6 +1769,12 @@ bool mem_cgroup_kmem_disabled(void);
>  int __memcg_kmem_charge_page(struct page *page, gfp_t gfp, int order);
>  void __memcg_kmem_uncharge_page(struct page *page, int order);
>  
> +/*
> + * The returned objcg pointer is safe to use without additional
> + * protection within a scope, refer to the implementation for the
> + * additional details.
> + */

Let's add the definition of scope in the above comment as well like
set_active_memcg and slab memcg hooks.

