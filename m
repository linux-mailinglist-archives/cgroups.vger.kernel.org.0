Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C297743AFC
	for <lists+cgroups@lfdr.de>; Thu, 13 Jun 2019 17:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732357AbfFMPZM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 13 Jun 2019 11:25:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44632 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731584AbfFMMLO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 13 Jun 2019 08:11:14 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5DC3K2p110615
        for <cgroups@vger.kernel.org>; Thu, 13 Jun 2019 08:11:12 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2t3ncbaf3p-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <cgroups@vger.kernel.org>; Thu, 13 Jun 2019 08:11:12 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <cgroups@vger.kernel.org> from <rppt@linux.ibm.com>;
        Thu, 13 Jun 2019 13:11:10 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 13 Jun 2019 13:11:05 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5DCB4pl49152030
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jun 2019 12:11:04 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 43EDFA4040;
        Thu, 13 Jun 2019 12:11:04 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 063E1A4055;
        Thu, 13 Jun 2019 12:11:03 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.204.162])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 13 Jun 2019 12:11:02 +0000 (GMT)
Date:   Thu, 13 Jun 2019 15:11:01 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Qian Cai <cai@lca.pw>, Will Deacon <will.deacon@arm.com>,
        akpm@linux-foundation.org, Roman Gushchin <guro@fb.com>,
        catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
        mhocko@kernel.org, linux-mm@kvack.org, vdavydov.dev@gmail.com,
        hannes@cmpxchg.org, cgroups@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH -next] arm64/mm: fix a bogus GFP flag in pgd_alloc()
References: <1559656836-24940-1-git-send-email-cai@lca.pw>
 <20190604142338.GC24467@lakrids.cambridge.arm.com>
 <20190610114326.GF15979@fuggles.cambridge.arm.com>
 <1560187575.6132.70.camel@lca.pw>
 <20190611100348.GB26409@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190611100348.GB26409@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19061312-0028-0000-0000-00000379FAD3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061312-0029-0000-0000-00002439F36A
Message-Id: <20190613121100.GB25164@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-13_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=7 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906130095
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

(added Roman)

On Tue, Jun 11, 2019 at 11:03:49AM +0100, Mark Rutland wrote:
> On Mon, Jun 10, 2019 at 01:26:15PM -0400, Qian Cai wrote:
> > On Mon, 2019-06-10 at 12:43 +0100, Will Deacon wrote:
> > > On Tue, Jun 04, 2019 at 03:23:38PM +0100, Mark Rutland wrote:
> > > > On Tue, Jun 04, 2019 at 10:00:36AM -0400, Qian Cai wrote:
> > > > > The commit "arm64: switch to generic version of pte allocation"
> > > > > introduced endless failures during boot like,
> > > > > 
> > > > > kobject_add_internal failed for pgd_cache(285:chronyd.service) (error:
> > > > > -2 parent: cgroup)
> > > > > 
> > > > > It turns out __GFP_ACCOUNT is passed to kernel page table allocations
> > > > > and then later memcg finds out those don't belong to any cgroup.
> > > > 
> > > > Mike, I understood from [1] that this wasn't expected to be a problem,
> > > > as the accounting should bypass kernel threads.
> > > > 
> > > > Was that assumption wrong, or is something different happening here?
> > > > 
> > > > > 
> > > > > backtrace:
> > > > >   kobject_add_internal
> > > > >   kobject_init_and_add
> > > > >   sysfs_slab_add+0x1a8
> > > > >   __kmem_cache_create
> > > > >   create_cache
> > > > >   memcg_create_kmem_cache
> > > > >   memcg_kmem_cache_create_func
> > > > >   process_one_work
> > > > >   worker_thread
> > > > >   kthread
> > > > > 
> > > > > Signed-off-by: Qian Cai <cai@lca.pw>
> > > > > ---
> > > > >  arch/arm64/mm/pgd.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/arch/arm64/mm/pgd.c b/arch/arm64/mm/pgd.c
> > > > > index 769516cb6677..53c48f5c8765 100644
> > > > > --- a/arch/arm64/mm/pgd.c
> > > > > +++ b/arch/arm64/mm/pgd.c
> > > > > @@ -38,7 +38,7 @@ pgd_t *pgd_alloc(struct mm_struct *mm)
> > > > >  	if (PGD_SIZE == PAGE_SIZE)
> > > > >  		return (pgd_t *)__get_free_page(gfp);
> > > > >  	else
> > > > > -		return kmem_cache_alloc(pgd_cache, gfp);
> > > > > +		return kmem_cache_alloc(pgd_cache, GFP_PGTABLE_KERNEL);
> > > > 
> > > > This is used to allocate PGDs for both user and kernel pagetables (e.g.
> > > > for the efi runtime services), so while this may fix the regression, I'm
> > > > not sure it's the right fix.
> > > > 
> > > > Do we need a separate pgd_alloc_kernel()?
> > > 
> > > So can I take the above for -rc5, or is somebody else working on a different
> > > fix to implement pgd_alloc_kernel()?
> > 
> > The offensive commit "arm64: switch to generic version of pte allocation" is not
> > yet in the mainline, but only in the Andrew's tree and linux-next, and I doubt
> > Andrew will push this out any time sooner given it is broken.
> 
> I'd assumed that Mike would respin these patches to implement and use
> pgd_alloc_kernel() (or take gfp flags) and the updated patches would
> replace these in akpm's tree.
> 
> Mike, could you confirm what your plan is? I'm happy to review/test
> updated patches for arm64.

The log Qian Cai posted at [1] and partially cited below confirms that the
failure happens when *user* PGDs are allocated and the addition of
__GFP_ACCOUNT to gfp flags used by pgd_alloc() only uncovered another
issue.

I'm still failing to reproduce it with qemu and I'm not really familiar
with slub/memcg code to say anything smart about it. Will keep looking.

Note, that as failures start way after efi_virtmap_init() that allocates a
PGD for efi_mm, there are no real fixes required for the original series,
except that the check for mm == &init_mm I copied for some reason from
powerpc is bogus and can be removed.

I surely can add pgd_alloc_kernel() to be used by the EFI code to make sure
we won't run into issues with memcg in the future.

[   82.125966] Freeing unused kernel memory: 28672K
[   87.940365] Checked W+X mappings: passed, no W+X pages found
[   87.946769] Run /init as init process
[   88.040040] systemd[1]: System time before build time, advancing clock.
[   88.054593] systemd[1]: Failed to insert module 'autofs4': No such file or directory
[   88.374129] modprobe (1726) used greatest stack depth: 28464 bytes left
[   88.470108] systemd[1]: systemd 239 running in system mode. (+PAM +AUDIT
+SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT
+GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD +IDN2 -IDN +PCRE2
default-hierarchy=legacy)
[   88.498398] systemd[1]: Detected architecture arm64.
[   88.506517] systemd[1]: Running in initial RAM disk.
[   89.621995] mkdir (1730) used greatest stack depth: 27872 bytes left
[   90.222658] random: systemd: uninitialized urandom read (16 bytes read)
[   90.230072] systemd[1]: Reached target Swap.
[   90.240205] random: systemd: uninitialized urandom read (16 bytes read)
[   90.251088] systemd[1]: Reached target Timers.
[   90.261303] random: systemd: uninitialized urandom read (16 bytes read)
[   90.271209] systemd[1]: Listening on udev Control Socket.
[   90.283238] systemd[1]: Reached target Local File Systems.
[   90.296232] systemd[1]: Reached target Slices.
[   90.307239] systemd[1]: Listening on udev Kernel Socket.
[   90.608597] kobject_add_internal failed for pgd_cache(13:init.scope) (error: -2 parent: cgroup)
[   90.678007] kobject_add_internal failed for pgd_cache(13:init.scope)(error: -2 parent: cgroup)
[   90.713260] kobject_add_internal failed for pgd_cache(21:systemd-tmpfiles-setup.service) (error: -2 parent: cgroup)
[   90.820012] systemd-tmpfile (1759) used greatest stack depth: 27184 bytes left
[   90.861942] kobject_add_internal failed for pgd_cache(13:init.scope) error: -2 parent: cgroup)
 
> Thanks,
> Mark.
> 

[1] https://cailca.github.io/files/dmesg.txt

-- 
Sincerely yours,
Mike.

