Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B59A53F9B80
	for <lists+cgroups@lfdr.de>; Fri, 27 Aug 2021 17:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233912AbhH0PNH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 27 Aug 2021 11:13:07 -0400
Received: from smtp4-g21.free.fr ([212.27.42.4]:23054 "EHLO smtp4-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233816AbhH0PNH (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 27 Aug 2021 11:13:07 -0400
Received: from bender.morinfr.org (unknown [82.64.86.27])
        by smtp4-g21.free.fr (Postfix) with ESMTPS id 43B1F19F5A6;
        Fri, 27 Aug 2021 17:11:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=morinfr.org
        ; s=20170427; h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=06iKxfQtqJXVLpRlR7LWKmLmFcpIOGMecFYnWhLpQEE=; b=Wa6SCVBVJZ0cLWpcPda/VQ+9HY
        1imhfnBlVTUYXXAelZoLnKRwDBip33ZVvuuQs14d0H/0uUdQd216nfoucw8bYeLPS53nIEOXZN+RN
        WTLedplPpvJzZp2zcfUKonyWm+niy2wPuMYKHVreHDNW9hIMOTWwJXco611tPWffGEmU=;
Received: from guillaum by bender.morinfr.org with local (Exim 4.92)
        (envelope-from <guillaume@morinfr.org>)
        id 1mJdWE-0007N1-V5; Fri, 27 Aug 2021 17:11:47 +0200
Date:   Fri, 27 Aug 2021 17:11:46 +0200
From:   Guillaume Morin <guillaume@morinfr.org>
To:     Mina Almasry <almasrymina@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Cc:     cgroups@vger.kernel.org
Subject: [BUG] potential hugetlb css refcounting issues
Message-ID: <20210827151146.GA25472@bender.morinfr.org>
Mail-Followup-To: Mina Almasry <almasrymina@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, cgroups@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,

After upgrading to 5.10 from 5.4 (though I believe that these issues are
still present in 5.14), we noticed some refcount count warning
pertaining a corrupted reference count of the hugetlb css, e.g

[  704.259734] percpu ref (css_release) <= 0 (-1) after switching to atomic
[  704.259755] WARNING: CPU: 23 PID: 130 at lib/percpu-refcount.c:196 percpu_ref_switch_to_atomic_rcu+0x127/0x130
[  704.259911] CPU: 23 PID: 130 Comm: ksoftirqd/23 Kdump: loaded Tainted: G           O      5.10.60 #1
[  704.259916] RIP: 0010:percpu_ref_switch_to_atomic_rcu+0x127/0x130
[  704.259920] Code: eb b1 80 3d 37 4f 0a 01 00 0f 85 5d ff ff ff 49 8b 55 e0 48 c7 c7 38 57 0d 94 c6 05 1f 4f 0a 01 01 49 8b 75 e8 e8 a9 e5 c1 ff <0f> 0b e9 3b ff ff ff 66 90 55 48 89 e5 41 56 49 89 f6 41 55 49 89
[  704.259922] RSP: 0000:ffffb19b4684bdd0 EFLAGS: 00010282
[  704.259924] RAX: 0000000000000000 RBX: 7ffffffffffffffe RCX: 0000000000000027
[  704.259926] RDX: 0000000000000000 RSI: ffff9a81ffb58b40 RDI: ffff9a81ffb58b48
[  704.259927] RBP: ffffb19b4684bde8 R08: 0000000000000003 R09: 0000000000000001
[  704.259929] R10: 0000000000000003 R11: ffffb19b4684bb70 R12: 0000370946a03b50
[  704.259931] R13: ffff9a72c9ceb860 R14: 0000000000000000 R15: ffff9a72c42f4000
[  704.259933] FS:  0000000000000000(0000) GS:ffff9a81ffb40000(0000) knlGS:0000000000000000
[  704.259935] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  704.259936] CR2: 0000000001416318 CR3: 000000011e1ac003 CR4: 00000000003706e0
[  704.259938] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  704.259939] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  704.259941] Call Trace:
[  704.259950]  rcu_core+0x30f/0x530
[  704.259955]  rcu_core_si+0xe/0x10
[  704.259959]  __do_softirq+0x103/0x2a2
[  704.259964]  ? sort_range+0x30/0x30
[  704.259968]  run_ksoftirqd+0x2b/0x40
[  704.259971]  smpboot_thread_fn+0x11a/0x170
[  704.259975]  kthread+0x10a/0x140
[  704.259978]  ? kthread_create_worker_on_cpu+0x70/0x70
[  704.259983]  ret_from_fork+0x22/0x30

The box would soon crash due to some GPF or NULL pointer deference
either in cgroups_destroy or in the kill_css path. We confirmed the
issue was specific to the hugetlb css by manually disabling its use and
verifying that the box then stayed up and happy.

I believe there might be 2 distinct bugs leading to this. I am not
familiar with the cgroup code so I might be off base here. I did my best
to track this and understand the logic. Any feedback will be welcome.

I have not provided patches because if I am correct, they're fairly
trivial and since I am unfamiliar with this code, I am afraid they could
not be that helpful.  But I could provide them if anybody is interested.

1. Since e9fe92ae0cd2, hugetlb_vm_op_close() decreases the refcount of
the css (if present) through the hugetlb_cgroup_uncharge_counter() call
if a resv map is set on the vma and the owner flag is present (i.e
private mapping).  In the most basic case, the corresponding refcount
increase is done in hugetlb_reserve_pages().
However when sibling vmas are opened, hugetlb_vm_op_open() is called,
the resv map reference count is increased (if vma_resv_map(vma) is not
NULL for private mappings), but not for a potential resv->css (i.e if
resv->css != NULL).
When these siblings vmas are closed, the refcount will still be
decreased once per such vma, leading to an underflow and premature
release (potentially use after free) of the hugetlb css.  The fix would
be to call css_get() if resv->css != NULL in hugetlb_vm_op_open()

2. After 08cf9faf75580, __free_huge_page() decrements the css refcount
for _each_ page unconditionally by calling
hugetlb_cgroup_uncharge_page_rsvd().
But a per-page reference count is only taken *per page* outside the
reserve case in alloc_huge_page() (i.e
hugetlb_cgroup_charge_cgroup_rsvd() is called only if deferred_reserve
is true).  In the reserve case, there is only one css reference linked
to the resv map (taken in hugetlb_reserve_pages()).
This also leads to an underflow of the counter.  A similar scheme to
HPageRestoreReserve can be used to track which pages were allocated in
the deferred_reserve case and call hugetlb_cgroup_uncharge_page_rsvd()
only for these during freeing.

HTH,

Guillaume.

-- 
Guillaume Morin <guillaume@morinfr.org>
