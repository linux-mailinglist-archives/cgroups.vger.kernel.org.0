Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE3648914
	for <lists+cgroups@lfdr.de>; Mon, 17 Jun 2019 18:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbfFQQgf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 17 Jun 2019 12:36:35 -0400
Received: from foss.arm.com ([217.140.110.172]:55962 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725863AbfFQQgf (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 17 Jun 2019 12:36:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A67528;
        Mon, 17 Jun 2019 09:36:34 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D6AFA3F718;
        Mon, 17 Jun 2019 09:36:32 -0700 (PDT)
Date:   Mon, 17 Jun 2019 17:36:30 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, Qian Cai <cai@lca.pw>,
        akpm@linux-foundation.org, Roman Gushchin <guro@fb.com>,
        catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
        mhocko@kernel.org, linux-mm@kvack.org, vdavydov.dev@gmail.com,
        hannes@cmpxchg.org, cgroups@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH -next] arm64/mm: fix a bogus GFP flag in pgd_alloc()
Message-ID: <20190617163630.GH30800@fuggles.cambridge.arm.com>
References: <1559656836-24940-1-git-send-email-cai@lca.pw>
 <20190604142338.GC24467@lakrids.cambridge.arm.com>
 <20190610114326.GF15979@fuggles.cambridge.arm.com>
 <1560187575.6132.70.camel@lca.pw>
 <20190611100348.GB26409@lakrids.cambridge.arm.com>
 <20190613121100.GB25164@rapoport-lnx>
 <20190617151252.GF16810@rapoport-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617151252.GF16810@rapoport-lnx>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Mike,

On Mon, Jun 17, 2019 at 06:12:52PM +0300, Mike Rapoport wrote:
> Andrew, can you please add the patch below as an incremental fix?
> 
> With this the arm64::pgd_alloc() should be in the right shape.
> 
> 
> From 1c1ef0bc04c655689c6c527bd03b140251399d87 Mon Sep 17 00:00:00 2001
> From: Mike Rapoport <rppt@linux.ibm.com>
> Date: Mon, 17 Jun 2019 17:37:43 +0300
> Subject: [PATCH] arm64/mm: don't initialize pgd_cache twice
> 
> When PGD_SIZE != PAGE_SIZE, arm64 uses kmem_cache for allocation of PGD
> memory. That cache was initialized twice: first through
> pgtable_cache_init() alias and then as an override for weak
> pgd_cache_init().
> 
> After enabling accounting for the PGD memory, this created a confusion for
> memcg and slub sysfs code which resulted in the following errors:
> 
> [   90.608597] kobject_add_internal failed for pgd_cache(13:init.scope) (error: -2 parent: cgroup)
> [   90.678007] kobject_add_internal failed for pgd_cache(13:init.scope) (error: -2 parent: cgroup)
> [   90.713260] kobject_add_internal failed for pgd_cache(21:systemd-tmpfiles-setup.service) (error: -2 parent: cgroup)
> 
> Removing the alias from pgtable_cache_init() and keeping the only pgd_cache
> initialization in pgd_cache_init() resolves the problem and allows
> accounting of PGD memory.
> 
> Reported-by: Qian Cai <cai@lca.pw>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  arch/arm64/include/asm/pgtable.h | 3 +--
>  arch/arm64/mm/pgd.c              | 5 +----
>  2 files changed, 2 insertions(+), 6 deletions(-)

Looks like this actually fixes caa841360134 ("x86/mm: Initialize PGD cache
during mm initialization") due to an unlucky naming conflict!

In which case, I'd actually prefer to take this fix asap via the arm64
tree. Is that ok?

Will
