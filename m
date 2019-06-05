Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA858366DB
	for <lists+cgroups@lfdr.de>; Wed,  5 Jun 2019 23:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfFEVdx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 5 Jun 2019 17:33:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51290 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726502AbfFEVdx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 5 Jun 2019 17:33:53 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x55LWgYP105076
        for <cgroups@vger.kernel.org>; Wed, 5 Jun 2019 17:33:52 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2sxn691fyy-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <cgroups@vger.kernel.org>; Wed, 05 Jun 2019 17:33:51 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <cgroups@vger.kernel.org> from <rppt@linux.ibm.com>;
        Wed, 5 Jun 2019 22:33:50 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 5 Jun 2019 22:33:46 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x55LXjbm54984766
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 Jun 2019 21:33:45 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ABD83A405F;
        Wed,  5 Jun 2019 21:33:45 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 80203A4054;
        Wed,  5 Jun 2019 21:33:44 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.207.19])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed,  5 Jun 2019 21:33:44 +0000 (GMT)
Date:   Thu, 6 Jun 2019 00:33:42 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Qian Cai <cai@lca.pw>, akpm@linux-foundation.org,
        catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, mhocko@kernel.org,
        linux-mm@kvack.org, vdavydov.dev@gmail.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH -next] arm64/mm: fix a bogus GFP flag in pgd_alloc()
References: <1559656836-24940-1-git-send-email-cai@lca.pw>
 <20190604142338.GC24467@lakrids.cambridge.arm.com>
 <20190604143020.GD24467@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190604143020.GD24467@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19060521-0020-0000-0000-000003469105
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19060521-0021-0000-0000-00002199A1F4
Message-Id: <20190605213342.GA7023@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-05_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=60 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906050136
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jun 04, 2019 at 03:30:20PM +0100, Mark Rutland wrote:
> On Tue, Jun 04, 2019 at 03:23:38PM +0100, Mark Rutland wrote:
> > On Tue, Jun 04, 2019 at 10:00:36AM -0400, Qian Cai wrote:
> > > The commit "arm64: switch to generic version of pte allocation"
> > > introduced endless failures during boot like,
> > > 
> > > kobject_add_internal failed for pgd_cache(285:chronyd.service) (error:
> > > -2 parent: cgroup)
> > > 
> > > It turns out __GFP_ACCOUNT is passed to kernel page table allocations
> > > and then later memcg finds out those don't belong to any cgroup.
> > 
> > Mike, I understood from [1] that this wasn't expected to be a problem,
> > as the accounting should bypass kernel threads.
> > 
> > Was that assumption wrong, or is something different happening here?
> > 
> > > backtrace:
> > >   kobject_add_internal
> > >   kobject_init_and_add
> > >   sysfs_slab_add+0x1a8
> > >   __kmem_cache_create
> > >   create_cache
> > >   memcg_create_kmem_cache
> > >   memcg_kmem_cache_create_func
> > >   process_one_work
> > >   worker_thread
> > >   kthread
> > > 
> > > Signed-off-by: Qian Cai <cai@lca.pw>
> > > ---
> > >  arch/arm64/mm/pgd.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/arm64/mm/pgd.c b/arch/arm64/mm/pgd.c
> > > index 769516cb6677..53c48f5c8765 100644
> > > --- a/arch/arm64/mm/pgd.c
> > > +++ b/arch/arm64/mm/pgd.c
> > > @@ -38,7 +38,7 @@ pgd_t *pgd_alloc(struct mm_struct *mm)
> > >  	if (PGD_SIZE == PAGE_SIZE)
> > >  		return (pgd_t *)__get_free_page(gfp);
> > >  	else
> > > -		return kmem_cache_alloc(pgd_cache, gfp);
> > > +		return kmem_cache_alloc(pgd_cache, GFP_PGTABLE_KERNEL);
> > 
> > This is used to allocate PGDs for both user and kernel pagetables (e.g.
> > for the efi runtime services), so while this may fix the regression, I'm
> > not sure it's the right fix.
> 
> I see that since [1], pgd_alloc() was updated to special-case the
> init_mm, which is not sufficient for cases like:
> 
> 	efi_mm.pgd = pgd_alloc(&efi_mm)
> 
> ... which occurs in a kthread.
> 
> So let's have a pgd_alloc_kernel() to make that explicit.

I've hit "send" before seeing this one :)

Well, to be completely on the safe side an explicit pgd_alloc_kernel()
sounds right. Then it won't be subject to future changes in memcg and will
always "Do The Right Thing".
 
> Thanks,
> Mark.
> 

-- 
Sincerely yours,
Mike.

