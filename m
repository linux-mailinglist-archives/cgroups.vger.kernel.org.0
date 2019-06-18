Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1DE7499B4
	for <lists+cgroups@lfdr.de>; Tue, 18 Jun 2019 09:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725934AbfFRHCN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 18 Jun 2019 03:02:13 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46724 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725829AbfFRHCN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 18 Jun 2019 03:02:13 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5I67m9V165607
        for <cgroups@vger.kernel.org>; Tue, 18 Jun 2019 02:13:10 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2t6nt18ehf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <cgroups@vger.kernel.org>; Tue, 18 Jun 2019 02:13:10 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <cgroups@vger.kernel.org> from <rppt@linux.ibm.com>;
        Tue, 18 Jun 2019 07:13:08 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 18 Jun 2019 07:13:03 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5I6D2jD61210840
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jun 2019 06:13:02 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 79475A4040;
        Tue, 18 Jun 2019 06:13:02 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7A0E8A4051;
        Tue, 18 Jun 2019 06:13:01 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.53])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 18 Jun 2019 06:13:01 +0000 (GMT)
Date:   Tue, 18 Jun 2019 09:12:59 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, Qian Cai <cai@lca.pw>,
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
 <20190613121100.GB25164@rapoport-lnx>
 <20190617151252.GF16810@rapoport-lnx>
 <20190617163630.GH30800@fuggles.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617163630.GH30800@fuggles.cambridge.arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19061806-0008-0000-0000-000002F4A996
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061806-0009-0000-0000-00002261BF41
Message-Id: <20190618061259.GB15497@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-18_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=27 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=935 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906180050
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Jun 17, 2019 at 05:36:30PM +0100, Will Deacon wrote:
> Hi Mike,
> 
> On Mon, Jun 17, 2019 at 06:12:52PM +0300, Mike Rapoport wrote:
> > Andrew, can you please add the patch below as an incremental fix?
> > 
> > With this the arm64::pgd_alloc() should be in the right shape.
> > 
> > 
> > From 1c1ef0bc04c655689c6c527bd03b140251399d87 Mon Sep 17 00:00:00 2001
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > Date: Mon, 17 Jun 2019 17:37:43 +0300
> > Subject: [PATCH] arm64/mm: don't initialize pgd_cache twice
> > 
> > When PGD_SIZE != PAGE_SIZE, arm64 uses kmem_cache for allocation of PGD
> > memory. That cache was initialized twice: first through
> > pgtable_cache_init() alias and then as an override for weak
> > pgd_cache_init().
> > 
> > After enabling accounting for the PGD memory, this created a confusion for
> > memcg and slub sysfs code which resulted in the following errors:
> > 
> > [   90.608597] kobject_add_internal failed for pgd_cache(13:init.scope) (error: -2 parent: cgroup)
> > [   90.678007] kobject_add_internal failed for pgd_cache(13:init.scope) (error: -2 parent: cgroup)
> > [   90.713260] kobject_add_internal failed for pgd_cache(21:systemd-tmpfiles-setup.service) (error: -2 parent: cgroup)
> > 
> > Removing the alias from pgtable_cache_init() and keeping the only pgd_cache
> > initialization in pgd_cache_init() resolves the problem and allows
> > accounting of PGD memory.
> > 
> > Reported-by: Qian Cai <cai@lca.pw>
> > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > ---
> >  arch/arm64/include/asm/pgtable.h | 3 +--
> >  arch/arm64/mm/pgd.c              | 5 +----
> >  2 files changed, 2 insertions(+), 6 deletions(-)
> 
> Looks like this actually fixes caa841360134 ("x86/mm: Initialize PGD cache
> during mm initialization") due to an unlucky naming conflict!
> 
> In which case, I'd actually prefer to take this fix asap via the arm64
> tree. Is that ok?

I suppose so, it just won't apply as is. Would you like a patch against the
current upstream?

> Will

-- 
Sincerely yours,
Mike.

