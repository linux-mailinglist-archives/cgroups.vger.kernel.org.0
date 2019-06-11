Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 525D23CC64
	for <lists+cgroups@lfdr.de>; Tue, 11 Jun 2019 15:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389499AbfFKNCi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 11 Jun 2019 09:02:38 -0400
Received: from foss.arm.com ([217.140.110.172]:60956 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388131AbfFKNCi (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 11 Jun 2019 09:02:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E8EE344;
        Tue, 11 Jun 2019 06:02:37 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0D24B3F557;
        Tue, 11 Jun 2019 06:02:35 -0700 (PDT)
Date:   Tue, 11 Jun 2019 14:02:33 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Qian Cai <cai@lca.pw>, Will Deacon <will.deacon@arm.com>,
        akpm@linux-foundation.org, catalin.marinas@arm.com,
        linux-kernel@vger.kernel.org, mhocko@kernel.org,
        linux-mm@kvack.org, vdavydov.dev@gmail.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH -next] arm64/mm: fix a bogus GFP flag in pgd_alloc()
Message-ID: <20190611130233.GD29008@lakrids.cambridge.arm.com>
References: <1559656836-24940-1-git-send-email-cai@lca.pw>
 <20190604142338.GC24467@lakrids.cambridge.arm.com>
 <20190610114326.GF15979@fuggles.cambridge.arm.com>
 <1560187575.6132.70.camel@lca.pw>
 <20190611100348.GB26409@lakrids.cambridge.arm.com>
 <20190611124118.GA4761@rapoport-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190611124118.GA4761@rapoport-lnx>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jun 11, 2019 at 03:41:19PM +0300, Mike Rapoport wrote:
> On Tue, Jun 11, 2019 at 11:03:49AM +0100, Mark Rutland wrote:
> > On Mon, Jun 10, 2019 at 01:26:15PM -0400, Qian Cai wrote:
> > > On Mon, 2019-06-10 at 12:43 +0100, Will Deacon wrote:
> > > > On Tue, Jun 04, 2019 at 03:23:38PM +0100, Mark Rutland wrote:
> > > > > On Tue, Jun 04, 2019 at 10:00:36AM -0400, Qian Cai wrote:
> > > > > > The commit "arm64: switch to generic version of pte allocation"
> > > > > > introduced endless failures during boot like,
> > > > > > 
> > > > > > kobject_add_internal failed for pgd_cache(285:chronyd.service) (error:
> > > > > > -2 parent: cgroup)
> > > > > > 
> > > > > > It turns out __GFP_ACCOUNT is passed to kernel page table allocations
> > > > > > and then later memcg finds out those don't belong to any cgroup.
> > > > > 
> > > > > Mike, I understood from [1] that this wasn't expected to be a problem,
> > > > > as the accounting should bypass kernel threads.
> > > > > 
> > > > > Was that assumption wrong, or is something different happening here?
> > > > > 
> > > > > > 
> > > > > > backtrace:
> > > > > >   kobject_add_internal
> > > > > >   kobject_init_and_add
> > > > > >   sysfs_slab_add+0x1a8
> > > > > >   __kmem_cache_create
> > > > > >   create_cache
> > > > > >   memcg_create_kmem_cache
> > > > > >   memcg_kmem_cache_create_func
> > > > > >   process_one_work
> > > > > >   worker_thread
> > > > > >   kthread
> > > > > > 
> > > > > > Signed-off-by: Qian Cai <cai@lca.pw>
> > > > > > ---
> > > > > >  arch/arm64/mm/pgd.c | 2 +-
> > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > > 
> > > > > > diff --git a/arch/arm64/mm/pgd.c b/arch/arm64/mm/pgd.c
> > > > > > index 769516cb6677..53c48f5c8765 100644
> > > > > > --- a/arch/arm64/mm/pgd.c
> > > > > > +++ b/arch/arm64/mm/pgd.c
> > > > > > @@ -38,7 +38,7 @@ pgd_t *pgd_alloc(struct mm_struct *mm)
> > > > > >  	if (PGD_SIZE == PAGE_SIZE)
> > > > > >  		return (pgd_t *)__get_free_page(gfp);
> > > > > >  	else
> > > > > > -		return kmem_cache_alloc(pgd_cache, gfp);
> > > > > > +		return kmem_cache_alloc(pgd_cache, GFP_PGTABLE_KERNEL);
> > > > > 
> > > > > This is used to allocate PGDs for both user and kernel pagetables (e.g.
> > > > > for the efi runtime services), so while this may fix the regression, I'm
> > > > > not sure it's the right fix.
> > > > > 
> > > > > Do we need a separate pgd_alloc_kernel()?
> > > > 
> > > > So can I take the above for -rc5, or is somebody else working on a different
> > > > fix to implement pgd_alloc_kernel()?
> > > 
> > > The offensive commit "arm64: switch to generic version of pte allocation" is not
> > > yet in the mainline, but only in the Andrew's tree and linux-next, and I doubt
> > > Andrew will push this out any time sooner given it is broken.
> > 
> > I'd assumed that Mike would respin these patches to implement and use
> > pgd_alloc_kernel() (or take gfp flags) and the updated patches would
> > replace these in akpm's tree.
> > 
> > Mike, could you confirm what your plan is? I'm happy to review/test
> > updated patches for arm64.
> 
> Sorry for the delay, I'm mostly offline these days.
> 
> I wanted to understand first what is the reason for the failure. I've tried
> to reproduce it with qemu, but I failed to find a bootable configuration
> that will have PGD_SIZE != PAGE_SIZE :(

This is the case with 48-bit VA and 64K pages. In that case we have
three levels of table, and the PGD is 1/16th of a page, as it only needs
to resolve 9 bits of virtual address rather than 13.

If you build defconfig + ARM64_64K_PAGES=y, that should be the case:

[mark@lakrids:~/src/linux]% usekorg 8.1.0 aarch64-linux-objdump -d arch/arm64/mm/pgd.o     

arch/arm64/mm/pgd.o:     file format elf64-littleaarch64


Disassembly of section .text:

0000000000000000 <pgd_alloc>:
   0:   a9bf7bfd        stp     x29, x30, [sp, #-16]!
   4:   90000000        adrp    x0, 0 <pgd_alloc>
   8:   5281b801        mov     w1, #0xdc0                      // #3520
   c:   910003fd        mov     x29, sp
  10:   f9400000        ldr     x0, [x0]
  14:   94000000        bl      0 <kmem_cache_alloc>
  18:   a8c17bfd        ldp     x29, x30, [sp], #16
  1c:   d65f03c0        ret

0000000000000020 <pgd_free>:
  20:   a9bf7bfd        stp     x29, x30, [sp, #-16]!
  24:   90000000        adrp    x0, 0 <pgd_alloc>
  28:   910003fd        mov     x29, sp
  2c:   f9400000        ldr     x0, [x0]
  30:   94000000        bl      0 <kmem_cache_free>
  34:   a8c17bfd        ldp     x29, x30, [sp], #16
  38:   d65f03c0        ret

Disassembly of section .init.text:

0000000000000000 <pgd_cache_init>:
   0:   a9bf7bfd        stp     x29, x30, [sp, #-16]!
   4:   52804002        mov     w2, #0x200                      // #512
   8:   d2800004        mov     x4, #0x0                        // #0
   c:   910003fd        mov     x29, sp
  10:   2a0203e1        mov     w1, w2
  14:   52a00083        mov     w3, #0x40000                    // #262144
  18:   90000000        adrp    x0, 0 <pgd_cache_init>
  1c:   91000000        add     x0, x0, #0x0
  20:   94000000        bl      0 <kmem_cache_create>
  24:   90000001        adrp    x1, 0 <pgd_cache_init>
  28:   a8c17bfd        ldp     x29, x30, [sp], #16
  2c:   f9000020        str     x0, [x1]
  30:   d65f03c0        ret

Thanks,
Mark.
