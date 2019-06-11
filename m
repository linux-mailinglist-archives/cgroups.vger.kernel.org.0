Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF333CBF1
	for <lists+cgroups@lfdr.de>; Tue, 11 Jun 2019 14:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387563AbfFKMlb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 11 Jun 2019 08:41:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41140 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728111AbfFKMlb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 11 Jun 2019 08:41:31 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5BCVvlg134767
        for <cgroups@vger.kernel.org>; Tue, 11 Jun 2019 08:41:30 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t2b6n4jn3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <cgroups@vger.kernel.org>; Tue, 11 Jun 2019 08:41:29 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <cgroups@vger.kernel.org> from <rppt@linux.ibm.com>;
        Tue, 11 Jun 2019 13:41:27 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 11 Jun 2019 13:41:23 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5BCfM8E56688832
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jun 2019 12:41:22 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CC6FB11C052;
        Tue, 11 Jun 2019 12:41:22 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A368411C050;
        Tue, 11 Jun 2019 12:41:21 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.204.69])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 11 Jun 2019 12:41:21 +0000 (GMT)
Date:   Tue, 11 Jun 2019 15:41:19 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Qian Cai <cai@lca.pw>, Will Deacon <will.deacon@arm.com>,
        akpm@linux-foundation.org, catalin.marinas@arm.com,
        linux-kernel@vger.kernel.org, mhocko@kernel.org,
        linux-mm@kvack.org, vdavydov.dev@gmail.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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
x-cbid: 19061112-0028-0000-0000-000003794EFF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061112-0029-0000-0000-000024393D13
Message-Id: <20190611124118.GA4761@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-11_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=60 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906110086
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

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

Sorry for the delay, I'm mostly offline these days.

I wanted to understand first what is the reason for the failure. I've tried
to reproduce it with qemu, but I failed to find a bootable configuration
that will have PGD_SIZE != PAGE_SIZE :(

Qian Cai, can you share what is your environment and the kernel config?
 
> Thanks,
> Mark.
> 

-- 
Sincerely yours,
Mike.

