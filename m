Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8460E44C8C
	for <lists+cgroups@lfdr.de>; Thu, 13 Jun 2019 21:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729800AbfFMTol (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 13 Jun 2019 15:44:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58792 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729758AbfFMTol (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 13 Jun 2019 15:44:41 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5DJaiKs022453
        for <cgroups@vger.kernel.org>; Thu, 13 Jun 2019 15:44:40 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t3tmkngcv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <cgroups@vger.kernel.org>; Thu, 13 Jun 2019 15:44:39 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <cgroups@vger.kernel.org> from <rppt@linux.ibm.com>;
        Thu, 13 Jun 2019 20:44:37 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 13 Jun 2019 20:44:32 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5DJiVjb30933166
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jun 2019 19:44:31 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5E1755204F;
        Thu, 13 Jun 2019 19:44:31 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.204.162])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 2222252051;
        Thu, 13 Jun 2019 19:44:30 +0000 (GMT)
Date:   Thu, 13 Jun 2019 22:44:28 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Qian Cai <cai@lca.pw>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will.deacon@arm.com>, akpm@linux-foundation.org,
        Roman Gushchin <guro@fb.com>, catalin.marinas@arm.com,
        linux-kernel@vger.kernel.org, mhocko@kernel.org,
        linux-mm@kvack.org, vdavydov.dev@gmail.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH -next] arm64/mm: fix a bogus GFP flag in pgd_alloc()
References: <1559656836-24940-1-git-send-email-cai@lca.pw>
 <20190604142338.GC24467@lakrids.cambridge.arm.com>
 <20190610114326.GF15979@fuggles.cambridge.arm.com>
 <1560187575.6132.70.camel@lca.pw>
 <20190611100348.GB26409@lakrids.cambridge.arm.com>
 <20190613121100.GB25164@rapoport-lnx>
 <1560432156.5154.11.camel@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1560432156.5154.11.camel@lca.pw>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19061319-0008-0000-0000-000002F38C7A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061319-0009-0000-0000-00002260940A
Message-Id: <20190613194427.GC25164@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-13_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906130146
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Jun 13, 2019 at 09:22:36AM -0400, Qian Cai wrote:
> On Thu, 2019-06-13 at 15:11 +0300, Mike Rapoport wrote:
> > The log Qian Cai posted at [1] and partially cited below confirms that the
> > failure happens when *user* PGDs are allocated and the addition of
> > __GFP_ACCOUNT to gfp flags used by pgd_alloc() only uncovered another
> > issue.
> > 
> > I'm still failing to reproduce it with qemu and I'm not really familiar
> > with slub/memcg code to say anything smart about it. Will keep looking.
> > 
> > Note, that as failures start way after efi_virtmap_init() that allocates a
> > PGD for efi_mm, there are no real fixes required for the original series,
> > except that the check for mm == &init_mm I copied for some reason from
> > powerpc is bogus and can be removed.
> 
> Yes, there is more places are not happy with __GFP_ACCOUNT other than efi_mm.
> For example,

Here we allocate the pgd for a user process and it should be accounted.

Actually, the whole point of changing the gfp flags in arm64::pgd_alloc()
was to enable the accounting for memory occupied by user pgds, just like
x86 and powerpc do.

> [  132.786842][ T1501] kobject_add_internal failed for pgd_cache(49:systemd-
> udevd.service) (error: -2 parent: cgroup)
> [  132.795589][ T1889] CPU: 9 PID: 1889 Comm: systemd-udevd Tainted:
> G        W         5.2.0-rc4-next-20190613+ #8
> [  132.807356][ T1889] Hardware name: HPE Apollo
> 70             /C01_APACHE_MB         , BIOS L50_5.13_1.0.9 03/01/2019
> [  132.817872][ T1889] Call trace:
> [  132.821017][ T1889]  dump_backtrace+0x0/0x268
> [  132.825372][ T1889]  show_stack+0x20/0x2c
> [  132.829380][ T1889]  dump_stack+0xb4/0x108
> [  132.833475][ T1889]  pgd_alloc+0x34/0x5c
> [  132.837396][ T1889]  mm_init+0x27c/0x32c
> [  132.841315][ T1889]  dup_mm+0x84/0x7b4
> [  132.845061][ T1889]  copy_process+0xf20/0x24cc
> [  132.849500][ T1889]  _do_fork+0xa4/0x66c
> [  132.853420][ T1889]  __arm64_sys_clone+0x114/0x1b4
> [  132.858208][ T1889]  el0_svc_handler+0x198/0x260
> [  132.862821][ T1889]  el0_svc+0x8/0xc
> 
> > 
> > I surely can add pgd_alloc_kernel() to be used by the EFI code to make sure
> > we won't run into issues with memcg in the future.
> > 
> > [   82.125966] Freeing unused kernel memory: 28672K
> > [   87.940365] Checked W+X mappings: passed, no W+X pages found
> > [   87.946769] Run /init as init process
> > [   88.040040] systemd[1]: System time before build time, advancing clock.
> > [   88.054593] systemd[1]: Failed to insert module 'autofs4': No such file or
> > directory
> > [   88.374129] modprobe (1726) used greatest stack depth: 28464 bytes left
> > [   88.470108] systemd[1]: systemd 239 running in system mode. (+PAM +AUDIT
> > +SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT
> > +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD +IDN2 -IDN +PCRE2
> > default-hierarchy=legacy)
> > [   88.498398] systemd[1]: Detected architecture arm64.
> > [   88.506517] systemd[1]: Running in initial RAM disk.
> > [   89.621995] mkdir (1730) used greatest stack depth: 27872 bytes left
> > [   90.222658] random: systemd: uninitialized urandom read (16 bytes read)
> > [   90.230072] systemd[1]: Reached target Swap.
> > [   90.240205] random: systemd: uninitialized urandom read (16 bytes read)
> > [   90.251088] systemd[1]: Reached target Timers.
> > [   90.261303] random: systemd: uninitialized urandom read (16 bytes read)
> > [   90.271209] systemd[1]: Listening on udev Control Socket.
> > [   90.283238] systemd[1]: Reached target Local File Systems.
> > [   90.296232] systemd[1]: Reached target Slices.
> > [   90.307239] systemd[1]: Listening on udev Kernel Socket.
> > [   90.608597] kobject_add_internal failed for pgd_cache(13:init.scope)
> > (error: -2 parent: cgroup)
> > [   90.678007] kobject_add_internal failed for pgd_cache(13:init.scope)(error:
> > -2 parent: cgroup)
> > [   90.713260] kobject_add_internal failed for pgd_cache(21:systemd-tmpfiles-
> > setup.service) (error: -2 parent: cgroup)
> > [   90.820012] systemd-tmpfile (1759) used greatest stack depth: 27184 bytes
> > left
> > [   90.861942] kobject_add_internal failed for pgd_cache(13:init.scope) error:
> > -2 parent: cgroup)
> >  
> > > Thanks,
> > > Mark.
> > > 
> > 
> > [1] https://cailca.github.io/files/dmesg.txt
> > 

-- 
Sincerely yours,
Mike.

