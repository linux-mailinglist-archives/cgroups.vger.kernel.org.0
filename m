Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA3EFAF64
	for <lists+cgroups@lfdr.de>; Wed, 13 Nov 2019 12:13:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727737AbfKMLNO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 13 Nov 2019 06:13:14 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:43732 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727211AbfKMLNN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 13 Nov 2019 06:13:13 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id xADBClhW112048;
        Wed, 13 Nov 2019 05:12:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1573643567;
        bh=h9xEOipiMSBQ/v/YefGIqpw3Ed/kooHBIiXxYAocdes=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=eb/OYO8tj7OL/hoc9y3kkSLZGYRPSyauoFl0nvlZLkXSLlidkeIxHd59CWgIUGvmS
         f41UP9EQPfOwc3bknot3JcxNWnVoXdx1kH0vghsv5OZtmGAGX+xJOVurxDKIZfOqfQ
         uIhR+z2uveXNHrJHmT3yP7lRV07R5t8uCqWjipW8=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xADBClMx003439
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 Nov 2019 05:12:47 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 13
 Nov 2019 05:12:29 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 13 Nov 2019 05:12:29 -0600
Received: from [172.24.190.215] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xADBChi1006071;
        Wed, 13 Nov 2019 05:12:44 -0600
Subject: Re: [PATCH 5/6] blk-cgroup: reimplement basic IO stats using cgroup
 rstat
To:     Tejun Heo <tj@kernel.org>, <axboe@kernel.dk>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lizefan@huawei.com>,
        <hannes@cmpxchg.org>, <kernel-team@fb.com>,
        Dan Schatzberg <dschatzberg@fb.com>, Daniel Xu <dlxu@fb.com>
References: <20191107191804.3735303-1-tj@kernel.org>
 <20191107191804.3735303-6-tj@kernel.org>
From:   Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <cd3ebcee-6819-a09b-aeba-de6817f32cde@ti.com>
Date:   Wed, 13 Nov 2019 16:43:44 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191107191804.3735303-6-tj@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,

On 08/11/19 12:48 AM, Tejun Heo wrote:
> blk-cgroup has been using blkg_rwstat to track basic IO stats.
> Unfortunately, reading recursive stats scales badly as itinvolves
> walking all descendants.  On systems with a huge number of cgroups
> (dead or alive), this can lead to substantial CPU cost when reading IO
> stats.
> 
> This patch reimplements basic IO stats using cgroup rstat which uses
> more memory but makes recursive stat reading O(# descendants which
> have been active since last reading) instead of O(# descendants).
> 
> * blk-cgroup core no longer uses sync/async stats.  Introduce new stat
>   enums - BLKG_IOSTAT_{READ|WRITE|DISCARD}.
> 
> * Add blkg_iostat[_set] which encapsulates byte and io stats, last
>   values for propagation delta calculation and u64_stats_sync for
>   correctness on 32bit archs.
> 
> * Update the new percpu stat counters directly and implement
>   blkcg_rstat_flush() to implement propagation.
> 
> * blkg_print_stat() can now bring the stats up to date by calling
>   cgroup_rstat_flush() and print them instead of directly summing up
>   all descendants.
> 
> * It now allocates 96 bytes per cpu.  It used to be 40 bytes.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: Dan Schatzberg <dschatzberg@fb.com>
> Cc: Daniel Xu <dlxu@fb.com>
> ---

I bisected a Kernel OOPs issue to this patch on linux-next. Any idea why
this is happening? Here is the log:

[   32.033025] 8<--- cut here ---
[   32.036136] Unable to handle kernel paging request at virtual address
2e83803c
[   32.043637] pgd = 75330198
[   32.046360] [2e83803c] *pgd=00000000
[   32.050008] Internal error: Oops: 5 [#1] SMP ARM
[   32.054647] Modules linked in:
[   32.057724] CPU: 0 PID: 780 Comm: (systemd) Tainted: G        W
  5.4.0-rc7-next-20191113 #172
[   32.066893] Hardware name: Generic AM33XX (Flattened Device Tree)
[   32.073026] PC is at cgroup_rstat_updated+0x30/0xe8
[   32.077939] LR is at generic_make_request_checks+0x3d4/0x748
[   32.083621] pc : [<c01e6f50>]    lr : [<c04af820>]    psr: a0040013
[   32.089912] sp : ed9b3b78  ip : 2e838000  fp : ed826c00
[   32.095156] r10: 00001000  r9 : 00000000  r8 : ff7ff428
[   32.100402] r7 : c0d05148  r6 : c0d0554c  r5 : c0c8b9ec  r4 : edb26180
[   32.106954] r3 : 2e838000  r2 : 2e838000  r1 : 00000000  r0 : eda32000
[   32.113510] Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM
Segment none
[   32.120674] Control: 10c5387d  Table: adac0019  DAC: 00000051
[   32.126444] Process (systemd) (pid: 780, stack limit = 0x5087843c)
[   32.132648] Stack: (0xed9b3b78 to 0xed9b4000)
[   32.137022] 3b60:
  edb26180 eee19550
[   32.145237] 3b80: 2e838000 c0d05148 ff7ff428 c04af820 00000004
00000800 0074e7f8 00000000
[   32.153452] 3ba0: a0040093 c08d1798 00000000 80040093 00002000
00000008 00000007 edb8168c
[   32.161667] 3bc0: 00000000 00000000 ffffe000 71b97da9 00000022
edb26180 c0d05148 00000008
[   32.169882] 3be0: c0d05148 00000001 00000000 edb26180 00000000
c04b0ad8 00000000 00000000
[   32.178097] 3c00: edb81a00 ed826c00 ed826cc4 71b97da9 c0de2c7c
edb26180 c0d05148 00000008
[   32.186312] 3c20: 00000001 00000001 00000000 0005fcfd 00000000
c04b0de0 c0de2c88 edb81600
[   32.194526] 3c40: ed826800 0005fcfd 00000000 c04ce968 00001000
c0d05148 edb26180 efd29a84
[   32.202741] 3c60: 00000000 00000000 0005fcfd 71b97da9 ed9b3c7b
00001000 00000001 00000001
[   32.210956] 3c80: 00000001 00000001 00000000 0005fcfd 00000000
c039bdb0 20040013 00000001
[   32.219170] 3ca0: 00000001 00000000 0005fcfd 00000000 ed9b3cc0
00000001 efd29a84 00000000
[   32.227385] 3cc0: 00000000 ed9b3e04 edb26180 ec8421b0 00000001
ec842100 0000000c ec8422b8
[   32.235600] 3ce0: 0005fcfd 00000000 00000fff 00000000 ee2a7b40
00080000 00000000 00112cca
[   32.243814] 3d00: ec8422bc c02983e0 0005fcfd 00000000 00000000
00000001 00000000 00000008
[   32.252028] 3d20: 0005fcfd 00000000 00000000 eef82400 00000010
00000000 00000004 ed9b3e88
[   32.260242] 3d40: 00000000 ed9b3d68 00000000 00000003 00000000
c0d05148 60040013 c01837f4
[   32.268457] 3d60: 00000000 71b97da9 00000000 00000001 00000001
c03783bc ec8422b8 ed9b3e04
[   32.276671] 3d80: ed9b3e04 00000001 ec8422bc c0378404 00000001
00000000 ec8421b0 c0255360
[   32.284886] 3da0: eeee0000 ed9d2180 ed9b3da8 ed9b3da8 ed9b3db0
ed9b3db0 00000000 71b97da9
[   32.293101] 3dc0: 00000000 00000001 00000001 00000000 00000003
ed9b3e04 00000000 00112cca
[   32.301316] 3de0: ec8422bc c025563c 00112cca 00000000 00000000
00000001 ec8422b8 ed9d2180
[   32.309531] 3e00: ed9b3dfc ed9b3e04 ed9b3e04 71b97da9 ec8422b8
ed9d21e8 ed9d2180 ec8422b8
[   32.317746] 3e20: 00000000 00000001 ffffffff 00000000 ed9d2180
c0255b8c 00000003 00000001
[   32.325961] 3e40: ec8421b0 ed9b3f00 00000000 00000000 ec8422b8
c024b73c 00000001 beba6ca0
[   32.334175] 3e60: c0d05148 00000000 00000000 beba6ca0 ed9b3ee8
ed9d2180 00000051 00000000
[   32.342389] 3e80: ed9d21e8 00000001 ffffffff 00000fff 000081a4
00000001 000003e8 000003e8
[   32.350604] 3ea0: 00000000 00000000 00000000 71b97da9 000000d2
ed9d2180 c0d05148 00000000
[   32.358819] 3ec0: 00000000 ed9b3f78 00001000 00000000 00000000
c02bdb6c 00001000 00020000
[   32.367033] 3ee0: 0058b9c8 00001000 00000004 00000000 00001000
ed9b3ee0 00000001 00000000
[   32.375248] 3f00: ed9d2180 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[   32.383463] 3f20: 00000000 00000000 00000000 71b97da9 0058b9c8
00000001 00001000 ed9b3f78
[   32.391678] 3f40: ed9d2180 00000000 00000000 c02bdc78 00000000
eda3ce1c eda3cc00 ed9d2180
[   32.399893] 3f60: ed9d2180 c0d05148 0058b9c8 00001000 ed9b2000
c02bdf68 00000000 00000000
[   32.408107] 3f80: 000005e8 71b97da9 005868d8 b6c02f41 000005e8
00000003 c0101204 00000003
[   32.416322] 3fa0: 00000000 c01011e0 005868d8 b6c02f41 00000007
0058b9c8 00001000 00000000
[   32.424537] 3fc0: 005868d8 b6c02f41 000005e8 00000003 0000000a
beba6e88 00000000 00000000
[   32.432753] 3fe0: 00000000 beba6d24 b6c037e1 b6c3e4b8 40040030
00000007 00000000 00000000
[   32.440982] [<c01e6f50>] (cgroup_rstat_updated) from [<c04af820>]
(generic_make_request_checks+0x3d4/0
x748)
[   32.450770] [<c04af820>] (generic_make_request_checks) from
[<c04b0ad8>] (generic_make_request+0x1c/0x
2e4)
[   32.460468] [<c04b0ad8>] (generic_make_request) from [<c04b0de0>]
(submit_bio+0x40/0x1b4)
[   32.468686] [<c04b0de0>] (submit_bio) from [<c039bdb0>]
(ext4_mpage_readpages+0x704/0x904)
[   32.476995] [<c039bdb0>] (ext4_mpage_readpages) from [<c0378404>]
(ext4_readpages+0x48/0x50)
[   32.485481] [<c0378404>] (ext4_readpages) from [<c0255360>]
(read_pages+0x50/0x154)
[   32.493175] [<c0255360>] (read_pages) from [<c025563c>]
(__do_page_cache_readahead+0x1d8/0x1f8)
[   32.501914] [<c025563c>] (__do_page_cache_readahead) from
[<c0255b8c>] (page_cache_sync_readahead+0xa0
/0xf4)
[   32.511799] [<c0255b8c>] (page_cache_sync_readahead) from
[<c024b73c>] (generic_file_read_iter+0x75c/0
xc40)
[   32.521594] [<c024b73c>] (generic_file_read_iter) from [<c02bdb6c>]
(__vfs_read+0x138/0x1bc)
[   32.530073] [<c02bdb6c>] (__vfs_read) from [<c02bdc78>]
(vfs_read+0x88/0x114)
[   32.537241] [<c02bdc78>] (vfs_read) from [<c02bdf68>]
(ksys_read+0x54/0xd0)
[   32.544237] [<c02bdf68>] (ksys_read) from [<c01011e0>]
(__sys_trace_return+0x0/0x20)
[   32.552010] Exception stack(0xed9b3fa8 to 0xed9b3ff0)
[   32.557085] 3fa0:                   005868d8 b6c02f41 00000007
0058b9c8 00001000 00000000
[   32.565300] 3fc0: 005868d8 b6c02f41 000005e8 00000003 0000000a
beba6e88 00000000 00000000
[   32.573512] 3fe0: 00000000 beba6d24 b6c037e1 b6c3e4b8
[   32.578591] Code: ee073fba e7962101 e5903168 e0823003 (e593303c)
[   32.584889] ---[ end trace 08d6b7172e3ff29b ]---
[   32.797983] 8<--- cut here ---
[   32.801090] Unable to handle kernel paging request at virtual address
2e83803c
[   32.808421] pgd = f285aa90
[   32.811140] [2e83803c] *pgd=00000000
[   32.814739] Internal error: Oops: 5 [#2] SMP ARM
[   32.819378] Modules linked in:
[   32.822453] CPU: 0 PID: 527 Comm: login Tainted: G      D W
5.4.0-rc7-next-20191113 #172
[   32.831273] Hardware name: Generic AM33XX (Flattened Device Tree)
[   32.837406] PC is at cgroup_rstat_updated+0x30/0xe8
[   32.842320] LR is at generic_make_request_checks+0x3d4/0x748
[   32.848002] pc : [<c01e6f50>]    lr : [<c04af820>]    psr: a0070013
[   32.854292] sp : edbdfb78  ip : 2e838000  fp : eda49c00
[   32.859537] r10: 00001000  r9 : 00000000  r8 : ff7fff60
[   32.864782] r7 : c0d05148  r6 : c0d0554c  r5 : c0c8b9ec  r4 : edd8c6c0
[   32.871335] r3 : 2e838000  r2 : 2e838000  r1 : 00000000  r0 : ed9dec00
[   32.877891] Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM
Segment none
[   32.885056] Control: 10c5387d  Table: adb40019  DAC: 00000051
[   32.890826] Process login (pid: 527, stack limit = 0x1deade48)
[   32.896681] Stack: (0xedbdfb78 to 0xedbe0000)
[   32.901056] fb60:
  edd8c6c0 eee19550
[   32.909271] fb80: 2e838000 c0d05148 ff7fff60 c04af820 c0d0554c
c01023dc 0074e7f8 00000000
[   32.917487] fba0: 0000000a ffff979f 00400100 71b97da9 ee81ba00
ffffe000 00000000 c0d0554c
[   32.925702] fbc0: c0c90e7c 00000000 c0d0554c 71b97da9 00000001
edd8c6c0 c0d05148 00000008
[   32.933916] fbe0: c0d05148 00000001 00000000 edd8c6c0 00000000
c04b0ad8 00000000 c0101aec
[   32.942130] fc00: 00000000 00000000 00001000 71b97da9 edd8c6c0
edd8c6c0 c0d05148 00000008
[   32.950345] fc20: 00000001 00000001 00000000 0005fba9 00000000
c04b0de0 c04a8f24 c04a8340
[   32.958560] fc40: 20070013 ffffffff 00000051 bf000000 00001000
c0d05148 edd8c6c0 efd47fac
[   32.966775] fc60: 00000000 00000000 0005fba9 71b97da9 edbdfc7b
00001000 00000001 00000001
[   32.974990] fc80: 00000001 00000001 00000000 0005fba9 00000000
c039bdb0 20070013 00000001
[   32.983204] fca0: 00000001 00000000 0005fba9 00000000 edbdfcc0
00000001 efd47fac 00000000
[   32.991418] fcc0: 00000000 edbdfe04 edd8c6c0 ec85dd70 00000001
ec85dcc0 0000000c ec85de78
[   32.999633] fce0: 0005fba9 00000000 00000fff 00000000 ee2a7b40
00080000 00000000 00112cca
[   33.007848] fd00: ec85de7c c02983e0 0005fba9 00000000 00000000
00000001 00000000 00000008
[   33.016061] fd20: 0005fba9 00000000 00000000 eef82400 00000010
00000000 00000004 edbdfe88
[   33.024276] fd40: 00000000 edbdfd68 00000000 00000003 00000000
c0d05148 60070013 c01837f4
[   33.032491] fd60: 00000000 71b97da9 00000000 00000001 00000001
c03783bc ec85de78 edbdfe04
[   33.040705] fd80: edbdfe04 00000001 ec85de7c c0378404 00000001
00000000 ec85dd70 c0255360
[   33.048919] fda0: eeee0000 ed952d80 edbdfda8 edbdfda8 edbdfdb0
edbdfdb0 00000000 71b97da9
[   33.057134] fdc0: 00000000 00000001 00000001 00000000 00000003
edbdfe04 00000000 00112cca
[   33.065348] fde0: ec85de7c c025563c 00112cca 00000000 00000000
00000001 ec85de78 ed952d80
[   33.073563] fe00: edbdfdfc edbdfe04 edbdfe04 71b97da9 ec85de78
ed952de8 ed952d80 ec85de78
[   33.081777] fe20: 00000000 00000001 ffffffff 00000000 ed952d80
c0255b8c 00000003 00000001
[   33.089992] fe40: ec85dd70 edbdff00 00000000 00000000 ec85de78
c024b73c 00000001 00000041
[   33.098206] fe60: ffffe000 00000000 00000000 00000000 edbdfee8
ed952d80 00000000 00000000
[   33.106422] fe80: ed952de8 00000001 ffffffff 00000fff edbdfe8c
71b97da9 000003e8 00000004
[   33.114637] fea0: edbdff70 c0d05148 00000001 71b97da9 edbde000
ed952d80 c0d05148 00000000
[   33.122852] fec0: 00000000 edbdff78 000003e8 00000000 00000000
c02bdb6c 000003e8 00020000
[   33.131066] fee0: 000365a8 000003e8 00000004 00000000 000003e8
edbdfee0 00000001 00000000
[   33.139280] ff00: ed952d80 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[   33.147495] ff20: 00000000 00000000 00000000 71b97da9 000365a8
00000001 000003e8 edbdff78
[   33.155709] ff40: ed952d80 00000000 00000000 c02bdc78 00000000
edd7721c edd77000 ed952d80
[   33.163923] ff60: ed952d80 c0d05148 000365a8 000003e8 edbde000
c02bdf68 00000000 00000000
[   33.172137] ff80: 00000000 71b97da9 000003e8 be9bb7ac 00000000
00000003 c0101204 00000003
[   33.180353] ffa0: 00000000 c01011e0 000003e8 be9bb7ac 00000004
000365a8 000003e8 00000000
[   33.188567] ffc0: 000003e8 be9bb7ac 00000000 00000003 00000004
000365a8 b6d74d64 00000000
[   33.196782] ffe0: 00000000 be9bb704 b6f7516c b6ef64b8 60070030
00000004 00000000 00000000
[   33.205010] [<c01e6f50>] (cgroup_rstat_updated) from [<c04af820>]
(generic_make_request_checks+0x3d4/0
x748)
[   33.214800] [<c04af820>] (generic_make_request_checks) from
[<c04b0ad8>] (generic_make_request+0x1c/0x
2e4)
[   33.224495] [<c04b0ad8>] (generic_make_request) from [<c04b0de0>]
(submit_bio+0x40/0x1b4)
[   33.232714] [<c04b0de0>] (submit_bio) from [<c039bdb0>]
(ext4_mpage_readpages+0x704/0x904)
[   33.241023] [<c039bdb0>] (ext4_mpage_readpages) from [<c0378404>]
(ext4_readpages+0x48/0x50)
[   33.249509] [<c0378404>] (ext4_readpages) from [<c0255360>]
(read_pages+0x50/0x154)
[   33.257203] [<c0255360>] (read_pages) from [<c025563c>]
(__do_page_cache_readahead+0x1d8/0x1f8)
[   33.265943] [<c025563c>] (__do_page_cache_readahead) from
[<c0255b8c>] (page_cache_sync_readahead+0xa0
/0xf4)
[   33.275826] [<c0255b8c>] (page_cache_sync_readahead) from
[<c024b73c>] (generic_file_read_iter+0x75c/0
xc40)
[   33.285621] [<c024b73c>] (generic_file_read_iter) from [<c02bdb6c>]
(__vfs_read+0x138/0x1bc)
[   33.294099] [<c02bdb6c>] (__vfs_read) from [<c02bdc78>]
(vfs_read+0x88/0x114)
[   33.301268] [<c02bdc78>] (vfs_read) from [<c02bdf68>]
(ksys_read+0x54/0xd0)
[   33.308264] [<c02bdf68>] (ksys_read) from [<c01011e0>]
(__sys_trace_return+0x0/0x20)
[   33.316038] Exception stack(0xedbdffa8 to 0xedbdfff0)
[   33.321112] ffa0:                   000003e8 be9bb7ac 00000004
000365a8 000003e8 00000000
[   33.329327] ffc0: 000003e8 be9bb7ac 00000000 00000003 00000004
000365a8 b6d74d64 00000000
[   33.337540] ffe0: 00000000 be9bb704 b6f7516c b6ef64b8
[   33.342619] Code: ee073fba e7962101 e5903168 e0823003 (e593303c)
[   33.348850] ---[ end trace 08d6b7172e3ff29c ]---

Thanks,
Faiz
