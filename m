Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A261929ED7C
	for <lists+cgroups@lfdr.de>; Thu, 29 Oct 2020 14:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgJ2Nsd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 29 Oct 2020 09:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbgJ2Nsd (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 29 Oct 2020 09:48:33 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11323C0613D4
        for <cgroups@vger.kernel.org>; Thu, 29 Oct 2020 06:48:33 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id c11so3043920iln.9
        for <cgroups@vger.kernel.org>; Thu, 29 Oct 2020 06:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WFNPqdB5jHGGBEHL+rnu060Po3aIZBWj8JJqtrtzCqw=;
        b=DAcGYyY3yy6bEPMCse/zv8kYq0osDw9DEhzder1u5hu4vWU6KLbnIpt/PRWESkZo2b
         J53ORNNFdkGX7/8iboWcYF+sWf+cx255cx/fSP05y2zVy63YnWv2hSA1/jHEoQCOBoNE
         QPKu1NYlvinjvr52+/gNpsOwzw/VH1Txhk0S3o5aKBw3hPuciPXVbCgTO8J+22/VuE4P
         45LTOf0gwaqBCEE5evevAj1luJrtrVTgcUQwNJet5JiLSgb4zzAn2ZLdzn1XThBT/hGe
         jGKtSMh7Vkti3ff/+Is/kSnttkfyO6KKAjhf2Vg+TGWfCSbHPn3eEq/p1FkcJuqk2HIL
         QGJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WFNPqdB5jHGGBEHL+rnu060Po3aIZBWj8JJqtrtzCqw=;
        b=U8J37MRPEmxzXWHTm+rfp6hRLmGI9bB6oz+SgQTeYsADrTcZMQf8WaoFaFtoAi2S+s
         oM1LyHwXiBTK4dSCGjFiAMJ6sqV8oHewzauzSJzXbAsDvDyoAU9bJaVus0bn3dFp1BwI
         fq+YMYbq37HoJjEmUaOV3yp7t02Fi9T8pbFAnqUaajo1eU3+e6o7J/i7sybrpS5gpVxv
         1dZi0pcZO6VSUuUb6qkRp8ovtL4dhHgZEtQv5fwMpyqqI82zsR3P6wHNjK8oG/a5/Cof
         NK4zsuSP5u+zzL6Ys+6Tbq+WwgKeRGq3eFliEQ7bNKkiXspWoVwWq1j6e3QhvXtVAk4w
         aPJQ==
X-Gm-Message-State: AOAM532SzeZKaPe6VcO3eWDHp1X18o94mgoTzNgNynfOUhCXAcdDXD1L
        ioLP3TBIPFItfkil0tGbVe8zAA==
X-Google-Smtp-Source: ABdhPJwyU663WFwny2hER4CbTcvb5I0TjApvdvoCKdiTQm+aeG10b0w5naP9BYmat8SVRnpBsWoCxQ==
X-Received: by 2002:a92:d3c1:: with SMTP id c1mr3319480ilh.271.1603979312398;
        Thu, 29 Oct 2020 06:48:32 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:536c])
        by smtp.gmail.com with ESMTPSA id b1sm2533970iog.14.2020.10.29.06.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 06:48:31 -0700 (PDT)
Date:   Thu, 29 Oct 2020 09:46:48 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, willy@infradead.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com,
        kirill@shutemov.name, alexander.duyck@gmail.com,
        rong.a.chen@intel.com, mhocko@suse.com, vdavydov.dev@gmail.com,
        shy828301@gmail.com, Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v20 02/20] mm/memcg: bail early from swap accounting if
 memcg disabled
Message-ID: <20201029134648.GC599825@cmpxchg.org>
References: <1603968305-8026-1-git-send-email-alex.shi@linux.alibaba.com>
 <1603968305-8026-3-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1603968305-8026-3-git-send-email-alex.shi@linux.alibaba.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Oct 29, 2020 at 06:44:47PM +0800, Alex Shi wrote:
> If we disabled memcg by cgroup_disable=memory, page->memcg will be NULL
> and so the charge is skipped and that will trigger a warning like below.
> Let's return from the funcs earlier.
> 
>  anon flags:0x5005b48008000d(locked|uptodate|dirty|swapbacked)
>  raw: 005005b48008000d dead000000000100 dead000000000122 ffff8897c7c76ad1
>  raw: 0000000000000022 0000000000000000 0000000200000000 0000000000000000
>  page dumped because: VM_WARN_ON_ONCE_PAGE(!memcg)
> ...
>  RIP: 0010:vprintk_emit+0x1f7/0x260
>  Code: 00 84 d2 74 72 0f b6 15 27 58 64 01 48 c7 c0 00 d4 72 82 84 d2 74 09 f3 90 0f b6 10 84 d2 75 f7 e8 de 0d 00 00 4c 89 e7 57 9d <0f> 1f 44 00 00 e9 62 ff ff ff 80 3d 88 c9 3a 01 00 0f 85 54 fe ff
>  RSP: 0018:ffffc9000faab358 EFLAGS: 00000202
>  RAX: ffffffff8272d400 RBX: 000000000000005e RCX: ffff88afd80d0040
>  RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000202
>  RBP: ffffc9000faab3a8 R08: ffffffff8272d440 R09: 0000000000022480
>  R10: 00120c77be68bfac R11: 0000000000cd7568 R12: 0000000000000202
>  R13: 0057ffffc0080005 R14: ffffffff820a0130 R15: ffffc9000faab3e8
>  ? vprintk_emit+0x140/0x260
>  vprintk_default+0x1a/0x20
>  vprintk_func+0x4f/0xc4
>  ? vprintk_func+0x4f/0xc4
>  printk+0x53/0x6a
>  ? xas_load+0xc/0x80
>  __dump_page.cold.6+0xff/0x4ee
>  ? xas_init_marks+0x23/0x50
>  ? xas_store+0x30/0x40
>  ? free_swap_slot+0x43/0xd0
>  ? put_swap_page+0x119/0x320
>  ? update_load_avg+0x82/0x580
>  dump_page+0x9/0xb
>  mem_cgroup_try_charge_swap+0x16e/0x1d0
>  get_swap_page+0x130/0x210
>  add_to_swap+0x41/0xc0
>  shrink_page_list+0x99e/0xdf0
>  shrink_inactive_list+0x199/0x360
>  shrink_lruvec+0x40d/0x650
>  ? _cond_resched+0x14/0x30
>  ? _cond_resched+0x14/0x30
>  shrink_node+0x226/0x6e0
>  do_try_to_free_pages+0xd0/0x400
>  try_to_free_pages+0xef/0x130
>  __alloc_pages_slowpath.constprop.127+0x38d/0xbd0
>  ? ___slab_alloc+0x31d/0x6f0
>  __alloc_pages_nodemask+0x27f/0x2c0
>  alloc_pages_vma+0x75/0x220
>  shmem_alloc_page+0x46/0x90
>  ? release_pages+0x1ae/0x410
>  shmem_alloc_and_acct_page+0x77/0x1c0
>  shmem_getpage_gfp+0x162/0x910
>  shmem_fault+0x74/0x210
>  ? filemap_map_pages+0x29c/0x410
>  __do_fault+0x37/0x190
>  handle_mm_fault+0x120a/0x1770
>  exc_page_fault+0x251/0x450
>  ? asm_exc_page_fault+0x8/0x30
>  asm_exc_page_fault+0x1e/0x30
> 
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Reviewed-by: Roman Gushchin <guro@fb.com>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Acked-by: Hugh Dickins <hughd@google.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: cgroups@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

This should go in before the previous patch that adds the WARN for it.
