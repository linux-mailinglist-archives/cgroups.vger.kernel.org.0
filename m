Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 436FF1CFBAF
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2020 19:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729166AbgELRLU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 12 May 2020 13:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729091AbgELRLT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 12 May 2020 13:11:19 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C03D9C061A0F
        for <cgroups@vger.kernel.org>; Tue, 12 May 2020 10:11:18 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id y22so1759968qki.3
        for <cgroups@vger.kernel.org>; Tue, 12 May 2020 10:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=cCYa1ZUuTC13LtbQrvAYo1dPxTQq8AqzPdLUyVen7vw=;
        b=neN2wDg8OLy8/cjt4I+i0qG3mqej9995PklqhJYbRQnfixUOcw1SXAQyrPVvQAnDp8
         4ilTf0XCK+sY/l3O+hYgI2ONLuCPJlzEkqeiV1KTGBuY+MugI0RtPwVxWi2gd+FCV+dW
         G4r++ynTknG9XkJtdPHrwBI+fSjSuLIj9320MR3XdwRRDjgUGBgHKEpk6H4CFv8N+QS8
         BbPtcfyWye91qVj7QY7TBBKDlVRMLSfEDwX/Oe/fhsu9AM1RCdKtlvuYEJgnLTDs5n/h
         the3fajBq2wPFALVW+P3YQ7pnm9B2U01fBa4x06Hqlf904yRQmVC8pRv0KBKPiACEPle
         hrpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=cCYa1ZUuTC13LtbQrvAYo1dPxTQq8AqzPdLUyVen7vw=;
        b=DjgCJkoAZR3Bh1C/tqr2X/sq/XtXwn1vPAfk+/e+MTcFVNGq2UPAjDtrs45xeOwvXz
         ohGw4IFW5I3iovCXefGjAcL2DK4QdBrBB3Sr+Ycl3g2MMwNKjouVNjw6N36M2X41RZDV
         jr2Uovd44QCuZo7Tz7Fdaw2Qp+db2p8XdxUKwNmd0PRE+1TBl8OKZw6OYeJYw73ATvAC
         NZUrkgcyHS2XMOd+cGE4j+EknC99IeBHnntJfFZ/iHBNdn/qktZKY04R5fgNb3GK+F4L
         Jf4DIpzIH4tscyjGDRzdshy7Kl4IDvIufGn07QPa9zrieGgMb+cKYyHOQeyAZDVC0gzd
         kKQg==
X-Gm-Message-State: AGi0PuZbx1VKDZnwaV49aNoALOgRQSmON5erNfMWbDNd5V+QZkIO4ms2
        TqmIgrGU0incsPDbT5kOlR9pvA==
X-Google-Smtp-Source: APiQypK5kOz5MhTQkd2zcr5owUtt5S2utQcFoj6QCv0Xrdw4VqEqsfLHOoV9RtokIlAybhsuaGkLHA==
X-Received: by 2002:a37:6843:: with SMTP id d64mr21400457qkc.24.1589303477787;
        Tue, 12 May 2020 10:11:17 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id t12sm11182754qkt.77.2020.05.12.10.11.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2020 10:11:17 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH 12/19] mm: memcontrol: convert anon and file-thp to new
 mem_cgroup_charge() API
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <45AA36A9-0C4D-49C2-BA3C-08753BBC30FB@lca.pw>
Date:   Tue, 12 May 2020 13:11:15 -0400
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Joonsoo Kim <js1304@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Roman Gushchin <guro@fb.com>, Linux-MM <linux-mm@kvack.org>,
        cgroups@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        kernel-team@fb.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <76E2FF28-1CD8-4A96-B2E6-5EDF51F8E3AB@lca.pw>
References: <20200508183105.225460-1-hannes@cmpxchg.org>
 <20200508183105.225460-13-hannes@cmpxchg.org>
 <45AA36A9-0C4D-49C2-BA3C-08753BBC30FB@lca.pw>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



> On May 12, 2020, at 10:38 AM, Qian Cai <cai@lca.pw> wrote:
>=20
>=20
>=20
>> On May 8, 2020, at 2:30 PM, Johannes Weiner <hannes@cmpxchg.org> =
wrote:
>>=20
>> With the page->mapping requirement gone from memcg, we can charge =
anon
>> and file-thp pages in one single step, right after they're allocated.
>>=20
>> This removes two out of three API calls - especially the tricky =
commit
>> step that needed to happen at just the right time between when the
>> page is "set up" and when it's "published" - somewhat vague and fluid
>> concepts that varied by page type. All we need is a freshly allocated
>> page and a memcg context to charge.
>>=20
>> v2: prevent double charges on pre-allocated hugepages in khugepaged
>>=20
>> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
>> Reviewed-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
>> ---
>> include/linux/mm.h      |  4 +---
>> kernel/events/uprobes.c | 11 +++--------
>> mm/filemap.c            |  2 +-
>> mm/huge_memory.c        |  9 +++------
>> mm/khugepaged.c         | 35 ++++++++++-------------------------
>> mm/memory.c             | 36 ++++++++++--------------------------
>> mm/migrate.c            |  5 +----
>> mm/swapfile.c           |  6 +-----
>> mm/userfaultfd.c        |  5 +----
>> 9 files changed, 31 insertions(+), 82 deletions(-)
> []
>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>>=20
>> @@ -1198,10 +1193,11 @@ static void collapse_huge_page(struct =
mm_struct *mm,
>> out_up_write:
>> 	up_write(&mm->mmap_sem);
>> out_nolock:
>> +	if (*hpage)
>> +		mem_cgroup_uncharge(*hpage);
>> 	trace_mm_collapse_huge_page(mm, isolated, result);
>> 	return;
>> out:
>> -	mem_cgroup_cancel_charge(new_page, memcg);
>> 	goto out_up_write;
>> }
> []
>=20
> Some memory pressure will crash this new code. It looks like somewhat =
racy.

Reverted the whole series fixed the crash, i.e.,

git revert --no-edit 6070efb8e52b..c986ddf58a95

There is a minor conflict during reverting due to another linux-next =
commit,

2a6b525f0de1 (=E2=80=9Ckhugepaged: do not stop collapse if less than =
half PTEs are referenced=E2=80=9D)

which is trivial to resolve,

--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@@ -1091,8 -1000,8 +1093,9 @@@ static void collapse_huge_page(struct m
         * If it fails, we release mmap_sem and jump out_nolock.
         * Continuing to collapse causes inconsistency.
         */
 -      if (!__collapse_huge_page_swapin(mm, vma, address, pmd, =
referenced)) {
 +      if (unmapped && !__collapse_huge_page_swapin(mm, vma, address,
 +                                                   pmd, referenced)) {
+               mem_cgroup_cancel_charge(new_page, memcg, true);
                up_read(&mm->mmap_sem);
                goto out_nolock;
        }


>=20
> if (!page->mem_cgroup)
>=20
> where page =3D=3D NULL in mem_cgroup_uncharge().
>=20
> [ 2244.414421][  T726] BUG: Kernel NULL pointer dereference on read at =
0x0000002c
> [ 2244.414454][  T726] Faulting instruction address: =
0xc0000000004f7e44
> [ 2244.414467][  T726] Oops: Kernel access of bad area, sig: 11 [#1]
> [ 2244.414488][  T726] LE PAGE_SIZE=3D64K MMU=3DRadix SMP NR_CPUS=3D256 =
DEBUG_PAGEALLOC NUMA PowerNV
> [ 2244.414501][  T726] Modules linked in: brd ext4 crc16 mbcache jbd2 =
loop kvm_hv kvm ip_tables x_tables xfs sd_mod bnx2x ahci tg3 libahci =
libphy mdio libata firmware_class dm_mirror dm_region_hash dm_log dm_mod
> [ 2244.414556][  T726] CPU: 11 PID: 726 Comm: khugepaged Not tainted =
5.7.0-rc5-next-20200512+ #8
> [ 2244.414579][  T726] NIP:  c0000000004f7e44 LR: c0000000004df95c =
CTR: c0000000001c1400
> [ 2244.414600][  T726] REGS: c000001a2398f6e0 TRAP: 0300   Not tainted =
 (5.7.0-rc5-next-20200512+)
> [ 2244.414630][  T726] MSR:  9000000000009033 =
<SF,HV,EE,ME,IR,DR,RI,LE>  CR: 24000244  XER: 20040000
> [ 2244.414656][  T726] CFAR: c0000000004df958 DAR: 000000000000002c =
DSISR: 40000000 IRQMASK: 0=20
> [ 2244.414656][  T726] GPR00: c0000000004df95c c000001a2398f970 =
c00000000168a700 fffffffffffffff4=20
> [ 2244.414656][  T726] GPR04: ffffffffffffffff c000000000bd0980 =
0000000000000005 0000000000000080=20
> [ 2244.414656][  T726] GPR08: 0000001ffc030000 0000000000000001 =
0000000000000000 c00000000152bb58=20
> [ 2244.414656][  T726] GPR12: 0000000024000222 c000001fffff5680 =
c0000001d818ce00 c0000001d818cd00=20
> [ 2244.414656][  T726] GPR16: 0000000000000000 c000001a2398fce0 =
fe7fffffffffefff fffffffffffffe7f=20
> [ 2244.414656][  T726] GPR20: c000201320aa53c8 000000000000001e =
0000000000000017 c00020047636b868=20
> [ 2244.414656][  T726] GPR24: 0000000000000000 0000000000000000 =
c000000001756080 c000001a2398fce0=20
> [ 2244.414656][  T726] GPR28: c000001a2398fa20 00007ffeeda00000 =
c000200f28547928 c000200f28547880=20
> [ 2244.414865][  T726] NIP [c0000000004f7e44] =
mem_cgroup_uncharge+0x34/0xb0
> mem_cgroup_uncharge at mm/memcontrol.c:6563
> [ 2244.414895][  T726] LR [c0000000004df95c] =
collapse_huge_page+0x24c/0x1000
> collapse_huge_page at mm/khugepaged.c:1197
> [ 2244.414924][  T726] Call Trace:
> [ 2244.414940][  T726] [c000001a2398f970] [0000000000000001] 0x1 =
(unreliable)
> [ 2244.414970][  T726] [c000001a2398f9c0] [c0000000004df814] =
collapse_huge_page+0x104/0x1000
> collapse_huge_page at mm/khugepaged.c:1064 (discriminator 10)
> [ 2244.414991][  T726] [c000001a2398faf0] [c0000000004e0f84] =
khugepaged_scan_pmd+0x874/0xc70
> [ 2244.415021][  T726] [c000001a2398fbf0] [c0000000004e2a90] =
khugepaged+0x900/0x1920
> [ 2244.415043][  T726] [c000001a2398fdb0] [c000000000155aa4] =
kthread+0x1c4/0x1d0
> [ 2244.415075][  T726] [c000001a2398fe20] [c00000000000cb28] =
ret_from_kernel_thread+0x5c/0x74
> [ 2244.415095][  T726] Instruction dump:
> [ 2244.415113][  T726] 384228f0 7c0802a6 60000000 f821ffb1 e92d0c70 =
f9210048 39200000 3d22ffec=20
> [ 2244.415146][  T726] 3929f9f4 81290000 2f890000 409d0048 <e9230038> =
2fa90000 419e003c 7c0802a6=20
> [ 2244.415181][  T726] ---[ end trace 3488eb8818913a26 ]---

