Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA2F7877C9
	for <lists+cgroups@lfdr.de>; Thu, 24 Aug 2023 20:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240925AbjHXS2R (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 24 Aug 2023 14:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242930AbjHXS1w (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 24 Aug 2023 14:27:52 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7280110EF
        for <cgroups@vger.kernel.org>; Thu, 24 Aug 2023 11:27:50 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-99bed101b70so6572766b.3
        for <cgroups@vger.kernel.org>; Thu, 24 Aug 2023 11:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692901669; x=1693506469;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6VQI2arQ3T8Zuo3bYqi/ZJM70kurY6TmTLTqSHF1D5c=;
        b=l8LQu/3QZmiHJldYlGPTwDXTrjtgjGHyp2JEm7UPgVVUXF7Jtrs+teQVgqR70AS7cO
         +sJUvziRM0kUnIJ55yN2GFAk1jf+8+o8MLAu+2fnBhkHErxDmekHm/nTGr+lmSS4ic7x
         EPcOeswDh9Rh2dFnFbXv7ii75gSwFPaUWGvUSbt9J1Td30WBqxDO9Jb1r0M9ZXNOhbUJ
         vKcu5VdKXJM2mZhUwEjX25LwlPVD4MvSl6xLOjfmbyDyUW77L9DGAc9V8+J5hnzmRSaD
         64xg8QO0N0ebKsKaUKbuRxV/k+EcX4qnbY61ODko4/g0tsqU9XPduXGlVMSiEzvWd1vo
         US9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692901669; x=1693506469;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6VQI2arQ3T8Zuo3bYqi/ZJM70kurY6TmTLTqSHF1D5c=;
        b=LHxxNjiXceQbi9HZEP1W3a0+6V/svhjuIaQDsVW9lQ3i0ab9se29V6GruyyTwH+d3K
         pp7OhBUtaNLmOEWgGOkWQiI0YSf+92QLS1Bd1IU+8b7OozGlE0zJiVKjrJkI7bWTxPbN
         J0ZEy5fNBrJM/1035KVqvGdCyzvaXak7BEGuWthh+N23jb/78x7kZrH+f+mDi6jCnxDP
         QMjgJ6f3RSUcpK2A0i2bDA77/9bckRW3o19wYIjlfXlK8XMirAj9Zq/cx5HFQRlCTfXD
         CJPe7R3crLwfyeN1gvKEEOrdYJivxIqI46kyyS849ob1zefznlk6jRgExdVtUloaD7kF
         tjZw==
X-Gm-Message-State: AOJu0YxSILEr5VULHzw6rsVHSA5UDzauJetwRWSWRTjkbF7zoaUMBDHN
        UMrQ+7IPLR9ub2U/C69AoIeS3CC8r6JKNSbzZi2G4dhPL6tFGKeo6R+UDhkB
X-Google-Smtp-Source: AGHT+IHk9NCvYhC5eiFbvJ/jj1wxy1Motzs67oqcqyBusNDaNyO8HqEAYWMrIkygqRbYEYypXJCnLmZRSuXy1RCTjHE=
X-Received: by 2002:a17:906:31c1:b0:99d:a6b9:fd04 with SMTP id
 f1-20020a17090631c100b0099da6b9fd04mr12651681ejf.46.1692901668671; Thu, 24
 Aug 2023 11:27:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230822024901.2412520-1-liushixin2@huawei.com>
 <CAJD7tkZkYsopuqGH_Lo=kE4=HO33wmvK6mXhuq4p_KZ6pYuXtw@mail.gmail.com>
 <50c49baf-d04a-f1e3-0d0e-7bb8e22c3889@huawei.com> <ZOYFydIp3q8BNrEa@dhcp22.suse.cz>
 <CAJD7tkYivogrRtAx8a+EPfjRqQNgoOZFZyG8rC91E_hW6pdTEw@mail.gmail.com> <14e15f31-f3d3-4169-8ed9-fb36e57cf578@huawei.com>
In-Reply-To: <14e15f31-f3d3-4169-8ed9-fb36e57cf578@huawei.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 24 Aug 2023 11:27:12 -0700
Message-ID: <CAJD7tkZAfgncV+KbKr36=eDzMnT=9dZOT0dpMWcurHLr6Do+GA@mail.gmail.com>
Subject: Re: [PATCH v2] mm: vmscan: reclaim anon pages if there are swapcache pages
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        wangkefeng.wang@huawei.com, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Type: multipart/mixed; boundary="0000000000009a92ca0603af62f5"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

--0000000000009a92ca0603af62f5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2023 at 8:39=E2=80=AFPM Liu Shixin <liushixin2@huawei.com> =
wrote:
>
>
>
> On 2023/8/23 23:29, Yosry Ahmed wrote:
> > On Wed, Aug 23, 2023 at 6:12=E2=80=AFAM Michal Hocko <mhocko@suse.com> =
wrote:
> >> On Wed 23-08-23 10:00:58, Liu Shixin wrote:
> >>>
> >>> On 2023/8/23 0:35, Yosry Ahmed wrote:
> >>>> On Mon, Aug 21, 2023 at 6:54=E2=80=AFPM Liu Shixin <liushixin2@huawe=
i.com> wrote:
> >>>>> When spaces of swap devices are exhausted, only file pages can be r=
eclaimed.
> >>>>> But there are still some swapcache pages in anon lru list. This can=
 lead
> >>>>> to a premature out-of-memory.
> >>>>>
> >>>>> This problem can be fixed by checking number of swapcache pages in
> >>>>> can_reclaim_anon_pages(). For memcg v2, there are swapcache stat th=
at can
> >>>>> be used directly. For memcg v1, use total_swapcache_pages() instead=
, which
> >>>>> may not accurate but can solve the problem.
> >>>> Interesting find. I wonder if we really don't have any handling of
> >>>> this situation.
> >>> I have alreadly test this problem and can confirm that it is a real p=
roblem.
> >>> With 9MB swap space and 10MB mem_cgroup limit=EF=BC=8Cwhen allocate 1=
5MB memory,
> >>> there is a probability that OOM occurs.
> >> Could you be more specific about the test and the oom report?
> > I actually couldn't reproduce it using 9MB of zram and a cgroup with a
> > 10MB limit trying to allocate 15MB of tmpfs, no matter how many
> > repetitions I do.
> The following is the printout of the testcase I used. In fact, the probab=
ility
> of triggering this problem is very low. You can adjust the size of the sw=
ap
> space to increase the probability of recurrence.
>

I was actually trying to reproduce this in the worst way possible:
- Tmpfs is really eager to remove pages from the swapcache once they
are swapped in and added to the page cache, unlike anon.
- With zram we skip the swapcache in the swap fault path for non-shared pag=
es.

I tried again with anonymous pages on a disk swapfile and I can
reliably reproduce the problem with the attached script. It basically
sets up 6MB of disk swap, creates a cgroup with 10MB limit, and runs
an allocator program. The program allocates 13MB and writes to them
twice (to induce refaults), and repeats this 100 times.

Here is an OOM log:

alloc_anon invoked oom-killer: gfp_mask=3D0xcc0(GFP_KERNEL), order=3D0,
oom_score_adj=3D0
[ 1974.205755] CPU: 252 PID: 116849 Comm: alloc_anon Tainted: G
   O       6.5.0-smp-DEV #21
[ 1974.205758] Hardware name: Google, Inc.
Arcadia_IT_80/Arcadia_IT_80, BIOS 12.22.0 06/14/2023
[ 1974.205759] Call Trace:
[ 1974.205761]  <TASK>
[ 1974.205764]  dump_stack_lvl+0x5d/0x90
[ 1974.205770]  dump_stack+0x14/0x20
[ 1974.205772]  dump_header+0x52/0x230
[ 1974.205775]  oom_kill_process+0x103/0x200
[ 1974.205777]  out_of_memory+0x3ae/0x590
[ 1974.205779]  mem_cgroup_out_of_memory+0x110/0x150
[ 1974.205782]  try_charge_memcg+0x3f9/0x760
[ 1974.205784]  ? __folio_alloc+0x1e/0x40
[ 1974.205787]  charge_memcg+0x3d/0x180
[ 1974.205788]  __mem_cgroup_charge+0x2f/0x70
[ 1974.205790]  do_pte_missing+0x7e8/0xd10
[ 1974.205792]  handle_mm_fault+0x6a5/0xaa0
[ 1974.205795]  do_user_addr_fault+0x387/0x560
[ 1974.205798]  exc_page_fault+0x67/0x120
[ 1974.205799]  asm_exc_page_fault+0x2b/0x30
[ 1974.205802] RIP: 0033:0x40ee89
[ 1974.205804] Code: fe 7f 40 40 c5 fe 7f 40 60 48 83 c7 80 48 81 fa
00 01 00 00 76 2b 48 8d 90 80 00 00 00 48 83 e2 c0 c5 fd 7f 02 c5 fd
7f 40
[ 1974.205806] RSP: 002b:00007ffe9bf6a2d8 EFLAGS: 00010283
[ 1974.205808] RAX: 00000000007286c0 RBX: 00007ffe9bf6a4e8 RCX: 00000000007=
286c0
[ 1974.205809] RDX: 0000000001215fc0 RSI: 0000000000000001 RDI: 00000000012=
28640
[ 1974.205810] RBP: 00007ffe9bf6a310 R08: 0000000000b20951 R09: 00000000000=
00000
[ 1974.205811] R10: 00000000004a21e0 R11: 0000000000749000 R12: 00007ffe9bf=
6a4c8
[ 1974.205812] R13: 000000000049e6f0 R14: 0000000000000001 R15: 00000000000=
00001
[ 1974.205815]  </TASK>
[ 1974.205815] memory: usage 10240kB, limit 10240kB, failcnt 4480498
[ 1974.205817] swap: usage 6140kB, limit 9007199254740988kB, failcnt 0
[ 1974.205818] Memory cgroup stats for /a:
[ 1974.205895] anon 5222400
[ 1974.205896] file 0
[ 1974.205896] kernel 106496
[ 1974.205897] kernel_stack 0
[ 1974.205897] pagetables 45056
[ 1974.205898] sec_pagetables 0
[ 1974.205898] percpu 12384
[ 1974.205898] sock 0
[ 1974.205899] vmalloc 0
[ 1974.205899] shmem 0
[ 1974.205900] zswap 0
[ 1974.205900] zswapped 0
[ 1974.205900] file_mapped 0
[ 1974.205901] file_dirty 0
[ 1974.205901] file_writeback 122880
[ 1974.205902] swapcached 5156864
[ 1974.205902] anon_thp 2097152
[ 1974.205902] file_thp 0
[ 1974.205903] shmem_thp 0
[ 1974.205903] inactive_anon 9396224
[ 1974.205904] active_anon 925696
[ 1974.205904] inactive_file 0
[ 1974.205904] active_file 0
[ 1974.205905] unevictable 0
[ 1974.205905] slab_reclaimable 1824
[ 1974.205906] slab_unreclaimable 7728
[ 1974.205906] slab 9552
[ 1974.205907] workingset_refault_anon 5220628
[ 1974.205907] workingset_refault_file 0
[ 1974.205907] workingset_activate_anon 212458
[ 1974.205908] workingset_activate_file 0
[ 1974.205908] workingset_restore_anon 110673
[ 1974.205909] workingset_restore_file 0
[ 1974.205909] workingset_nodereclaim 0
[ 1974.205910] pgscan 15788241
[ 1974.205910] pgsteal 5222782
[ 1974.205910] pgscan_kswapd 0
[ 1974.205911] pgscan_direct 15786393
[ 1974.205911] pgscan_khugepaged 1848
[ 1974.205912] pgsteal_kswapd 0
[ 1974.205912] pgsteal_direct 5222044
[ 1974.205912] pgsteal_khugepaged 738
[ 1974.205913] pgfault 5298719
[ 1974.205913] pgmajfault 692459
[ 1974.205914] pgrefill 350803
[ 1974.205914] pgactivate 140230
[ 1974.205914] pgdeactivate 350803
[ 1974.205915] pglazyfree 0
[ 1974.205915] pglazyfreed 0
[ 1974.205916] zswpin 0
[ 1974.205916] zswpout 0
[ 1974.205916] thp_fault_alloc 125
[ 1974.205917] thp_collapse_alloc 2
[ 1974.205917] Tasks state (memory values in pages):
[ 1974.205918] [  pid  ]   uid  tgid total_vm      rss pgtables_bytes
swapents oom_score_adj name
[ 1974.205919] [ 116849]     0 116849     3059     1722    53248
1024             0 alloc_anon
[ 1974.205922] oom-kill:constraint=3DCONSTRAINT_MEMCG,nodemask=3D(null),cpu=
set=3D/,mems_allowed=3D0-1,oom_memcg=3D/a,task_memcg=3D/a,task=3Dalloc_anon=
,pid=3D10
[ 1974.205929] Memory cgroup out of memory: Killed process 116849
(alloc_anon) total-vm:12236kB, anon-rss:6888kB, file-rss:0kB,
shmem-rss:0kB,0

It shows that we are using 10MB of memory and 6MB of swap, but that's
because the ~5MB of memory in the swapcache are doubling as both
memory and swap if I understand correctly.

I could not reproduce the problem with this patch (but perhaps I
didn't try hard enough).

--0000000000009a92ca0603af62f5
Content-Type: text/x-sh; charset="US-ASCII"; name="repro.sh"
Content-Disposition: attachment; filename="repro.sh"
Content-Transfer-Encoding: base64
Content-ID: <f_llphuy0t1>
X-Attachment-Id: f_llphuy0t1

IyEvYmluL2Jhc2gKClNXQVBGSUxFPSIuL3N3YXBmaWxlIgpDR1JPVVA9Ii9zeXMvZnMvY2dyb3Vw
L2EiCgpkZCBpZj0vZGV2L3plcm8gb2Y9JFNXQVBGSUxFIGJzPTFNIGNvdW50PTYKY2htb2QgMDYw
MCAkU1dBUEZJTEUKbWtzd2FwICRTV0FQRklMRQpzd2Fwb24gJFNXQVBGSUxFCgpta2RpciAkQ0dS
T1VQCmVjaG8gMTBtID4gJENHUk9VUC9tZW1vcnkubWF4CihlY2hvIDAgPiAkQ0dST1VQL2Nncm91
cC5wcm9jcyAmJiAuL2FsbG9jX2Fub24gMTUgMTAwKQpybWRpciAkQ0dST1VQCgpzd2Fwb2ZmICRT
V0FQRklMRQpybSAtZiAkU1dBUEZJTEUK
--0000000000009a92ca0603af62f5
Content-Type: application/octet-stream; name="alloc_anon.c"
Content-Disposition: attachment; filename="alloc_anon.c"
Content-Transfer-Encoding: base64
Content-ID: <f_llphuy0j0>
X-Attachment-Id: f_llphuy0j0

I2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxzdGRsaWIuaD4KI2luY2x1ZGUgPHN5cy9tbWFu
Lmg+CiNpbmNsdWRlIDxzdHJpbmcuaD4KI2luY2x1ZGUgPGVyci5oPgoKI2RlZmluZSBNQl9UT19C
WVRFUyh4KSAoeCA8PCAyMCkKCmludCBtYWluKGludCBhcmdjLCBjaGFyICoqYXJndikKewoJaW50
IGl0ZXJhdGlvbnM7CglzaXplX3QgbGVuOwoJdm9pZCAqYnVmOwoKCWlmIChhcmdjICE9IDMpCgkJ
ZXJyKC0xLCAiV3JvbmcgbnVtYmVyIG9mIGFyZ3MiKTsKCglsZW4gPSAoc2l6ZV90KWF0b2koYXJn
dlsxXSk7CglsZW4gPSBNQl9UT19CWVRFUyhsZW4pOwoKCWl0ZXJhdGlvbnMgPSBhdG9pKGFyZ3Zb
Ml0pOwoKCWZvciAoaW50IGkgPSAwOyBpIDwgaXRlcmF0aW9uczsgaSsrKSB7CgkJYnVmID0gbWFs
bG9jKGxlbik7CgkJaWYgKGJ1ZiA9PSBNQVBfRkFJTEVEKQoJCQllcnIoLTEsICJtYWxsb2MgZmFp
bGVkIik7CgkJbWVtc2V0KGJ1ZiwgMSwgbGVuKTsKCQltZW1zZXQoYnVmLCAyLCBsZW4pOwoJCWZy
ZWUoYnVmKTsKCX0KCXJldHVybiAwOwp9Cg==
--0000000000009a92ca0603af62f5--
