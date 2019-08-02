Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31CD47E765
	for <lists+cgroups@lfdr.de>; Fri,  2 Aug 2019 03:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388609AbfHBBJM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 1 Aug 2019 21:09:12 -0400
Received: from nwk-aaemail-lapp03.apple.com ([17.151.62.68]:53710 "EHLO
        nwk-aaemail-lapp03.apple.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388503AbfHBBJM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 1 Aug 2019 21:09:12 -0400
Received: from pps.filterd (nwk-aaemail-lapp03.apple.com [127.0.0.1])
        by nwk-aaemail-lapp03.apple.com (8.16.0.27/8.16.0.27) with SMTP id x7216YSp009658;
        Thu, 1 Aug 2019 18:09:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com; h=sender : content-type
 : mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=20180706;
 bh=drG7RStAbcUpg1ySgICya3sFQbgf6rO85leWpHI7014=;
 b=oMyvDKxcNZrMvM4Ukk4XI6a4Od3nh/DclH4Qgru3mtTjRdLXb/BGQ13kJzlevP5w7Nwp
 aUf9p4XQf5O95ycs3s091kJmxb2GvcoxNHRbWTeTSQuFrfPbLazZ5bcjmPBKSeNEHJIJ
 uBUTkrzyX2mWHbt1F+ZEgI2fxegDSW5B+rocVqFDqI82FpsDHMjLBj4Nu72z3I03OSQ4
 l4BtGZrCbIsIP6B47uwaQzeUb2uHNpz1KDb2Mdlp8yJxppGUpYCajTCymXdKgjTbiaxS
 3/EI1/O+YhfyWTRMRiPhi34k1NhO5k1u8/21u1v4xyXzGAq5W7Ghv3wfowiPMceGDotD +Q== 
Received: from mr2-mtap-s02.rno.apple.com (mr2-mtap-s02.rno.apple.com [17.179.226.134])
        by nwk-aaemail-lapp03.apple.com with ESMTP id 2u2qm52re2-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Thu, 01 Aug 2019 18:09:06 -0700
Received: from nwk-mmpp-sz11.apple.com
 (nwk-mmpp-sz11.apple.com [17.128.115.155]) by mr2-mtap-s02.rno.apple.com
 (Oracle Communications Messaging Server 8.0.2.4.20190507 64bit (built May  7
 2019)) with ESMTPS id <0PVL0083G4J48VA0@mr2-mtap-s02.rno.apple.com>; Thu,
 01 Aug 2019 18:09:04 -0700 (PDT)
Received: from process_milters-daemon.nwk-mmpp-sz11.apple.com by
 nwk-mmpp-sz11.apple.com
 (Oracle Communications Messaging Server 8.0.2.4.20190507 64bit (built May  7
 2019)) id <0PVL005004HJ5T00@nwk-mmpp-sz11.apple.com>; Thu,
 01 Aug 2019 18:09:04 -0700 (PDT)
X-Va-A: 
X-Va-T-CD: 7e5a4a8cbd5d1b3a9de5dc9e235184f7
X-Va-E-CD: b03d5acee32fc9f0c9dfd3776592dc73
X-Va-R-CD: 1835f3c54d533384876758843bc94ede
X-Va-CD: 0
X-Va-ID: 35ed4500-f8d3-4ddd-bea2-cf28a9e881dc
X-V-A:  
X-V-T-CD: 7e5a4a8cbd5d1b3a9de5dc9e235184f7
X-V-E-CD: b03d5acee32fc9f0c9dfd3776592dc73
X-V-R-CD: 1835f3c54d533384876758843bc94ede
X-V-CD: 0
X-V-ID: c68c04a0-5568-4de0-b763-5895b1bf54f6
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,,
 definitions=2019-08-01_10:,, signatures=0
Received: from [17.150.208.190] (unknown [17.150.208.190])
 by nwk-mmpp-sz11.apple.com
 (Oracle Communications Messaging Server 8.0.2.4.20190507 64bit (built May  7
 2019)) with ESMTPSA id <0PVL000CW4IJNP90@nwk-mmpp-sz11.apple.com>; Thu,
 01 Aug 2019 18:08:43 -0700 (PDT)
Content-type: text/plain; charset=utf-8
MIME-version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: Possible mem cgroup bug in kernels between 4.18.0 and 5.3-rc1.
From:   Masoud Sharbiani <msharbiani@apple.com>
In-reply-to: <20190801181952.GA8425@kroah.com>
Date:   Thu, 01 Aug 2019 18:08:42 -0700
Cc:     mhocko@kernel.org, hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-transfer-encoding: quoted-printable
Message-id: <7EE30F16-A90B-47DC-A065-3C21881CD1CC@apple.com>
References: <5659221C-3E9B-44AD-9BBF-F74DE09535CD@apple.com>
 <20190801181952.GA8425@kroah.com>
To:     Greg KH <gregkh@linuxfoundation.org>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-01_10:,,
 signatures=0
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



> On Aug 1, 2019, at 11:19 AM, Greg KH <gregkh@linuxfoundation.org> =
wrote:
>=20
> On Thu, Aug 01, 2019 at 11:04:14AM -0700, Masoud Sharbiani wrote:
>> Hey folks,
>> I=E2=80=99ve come across an issue that affects most of 4.19, 4.20 and =
5.2 linux-stable kernels that has only been fixed in 5.3-rc1.
>> It was introduced by
>>=20
>> 29ef680 memcg, oom: move out_of_memory back to the charge path=20
>>=20
>> The gist of it is that if you have a memory control group for a =
process that repeatedly maps all of the pages of a file with repeated =
calls to:
>>=20
>>   mmap(NULL, pages * PAGE_SIZE, PROT_WRITE|PROT_READ, =
MAP_FILE|MAP_PRIVATE, fd, 0)
>>=20
>> The memory cg eventually runs out of memory, as it should. However,
>> prior to the 29ef680 commit, it would kill the running process with
>> OOM; After that commit ( and until 5.3-rc1; Haven=E2=80=99t =
pinpointed the
>> exact commit in between 5.2.0 and 5.3-rc1) the offending process goes
>> into %100 CPU usage, and doesn=E2=80=99t die (prior behavior) or fail =
the mmap
>> call (which is what happens if one runs the test program with a low
>> ulimit -v value).
>>=20
>> Any ideas on how to chase this down further?
>=20
> Finding the exact patch that fixes this would be great, as then I can
> add it to the 4.19 and 5.2 stable kernels (4.20 is long end-of-life, =
no
> idea why you are messing with that one...)
>=20
> thanks,
>=20
> greg k-h



Allow me to issue a correction:=20
Running this test on linux master =
<629f8205a6cc63d2e8e30956bad958a3507d018f> correctly terminates the =
leaker app with OOM.=20
However, running it a second time (after removing the memory cgroup, and =
allowing the test script to run it again), causes this:

 kernel:watchdog: BUG: soft lockup - CPU#7 stuck for 22s! [leaker1:7193]


[  202.511024] CPU: 7 PID: 7193 Comm: leaker1 Not tainted 5.3.0-rc2+ #8
[  202.517378] Hardware name: <redacted>
[  202.525554] RIP: 0010:lruvec_lru_size+0x49/0xf0
[  202.530085] Code: 41 89 ed b8 ff ff ff ff 45 31 f6 49 c1 e5 03 eb 19 =
48 63 d0 4c 89 e9 48 8b 14 d5 20 b7 11 b5 48 03 8b 88 00 00 00 4c 03 34 =
11 <48> c7 c6 80 c5 40 b5 89 c7 e8 29 a7 6f 00 3b 05 57 9d 24 01 72 d1
[  202.548831] RSP: 0018:ffffa7c5480df620 EFLAGS: 00000246 ORIG_RAX: =
ffffffffffffff13
[  202.556398] RAX: 0000000000000000 RBX: ffff8f5b7a1af800 RCX: =
00003859bfa03bc0
[  202.563528] RDX: ffff8f5b7f800000 RSI: 0000000000000018 RDI: =
ffffffffb540c580
[  202.570662] RBP: 0000000000000001 R08: 0000000000000000 R09: =
0000000000000004
[  202.577795] R10: ffff8f5b62548000 R11: 0000000000000000 R12: =
0000000000000004
[  202.584928] R13: 0000000000000008 R14: 0000000000000000 R15: =
0000000000000000
[  202.592063] FS:  00007ff73d835740(0000) GS:ffff8f6b7f840000(0000) =
knlGS:0000000000000000
[  202.600149] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  202.605895] CR2: 00007f1b1c00e428 CR3: 0000001021d56006 CR4: =
00000000001606e0
[  202.613026] Call Trace:
[  202.615475]  shrink_node_memcg+0xdb/0x7a0
[  202.619488]  ? shrink_slab+0x266/0x2a0
[  202.623242]  ? mem_cgroup_iter+0x10a/0x2c0
[  202.627337]  shrink_node+0xdd/0x4c0
[  202.630831]  do_try_to_free_pages+0xea/0x3c0
[  202.635104]  try_to_free_mem_cgroup_pages+0xf5/0x1e0
[  202.640068]  try_charge+0x279/0x7a0
[  202.643565]  mem_cgroup_try_charge+0x51/0x1a0
[  202.647925]  __add_to_page_cache_locked+0x19f/0x330
[  202.652800]  ? __mod_lruvec_state+0x40/0xe0
[  202.656987]  ? scan_shadow_nodes+0x30/0x30
[  202.661086]  add_to_page_cache_lru+0x49/0xd0
[  202.665361]  iomap_readpages_actor+0xea/0x230
[  202.669718]  ? iomap_migrate_page+0xe0/0xe0
[  202.673906]  iomap_apply+0xb8/0x150
[  202.677398]  iomap_readpages+0xa7/0x1a0
[  202.681237]  ? iomap_migrate_page+0xe0/0xe0
[  202.685424]  read_pages+0x68/0x190
[  202.688829]  __do_page_cache_readahead+0x19c/0x1b0
[  202.693622]  ondemand_readahead+0x168/0x2a0
[  202.697808]  filemap_fault+0x32d/0x830
[  202.701562]  ? __mod_lruvec_state+0x40/0xe0
[  202.705747]  ? page_remove_rmap+0xcf/0x150
[  202.709846]  ? alloc_set_pte+0x240/0x2c0
[  202.713775]  __xfs_filemap_fault+0x71/0x1c0
[  202.717963]  __do_fault+0x38/0xb0
[  202.721280]  __handle_mm_fault+0x73f/0x1080
[  202.725467]  ? __switch_to_asm+0x34/0x70
[  202.729390]  ? __switch_to_asm+0x40/0x70
[  202.733318]  handle_mm_fault+0xce/0x1f0
[  202.737158]  __do_page_fault+0x231/0x480
[  202.741083]  page_fault+0x2f/0x40
[  202.744404] RIP: 0033:0x400c20
[  202.747461] Code: 45 c8 48 89 c6 bf 32 0e 40 00 b8 00 00 00 00 e8 76 =
fb ff ff c7 45 ec 00 00 00 00 eb 36 8b 45 ec 48 63 d0 48 8b 45 c8 48 01 =
d0 <0f> b6 00 0f be c0 01 45 e4 8b 45 ec 25 ff 0f 00 00 85 c0 75 10 8b
[  202.766208] RSP: 002b:00007ffde95ae460 EFLAGS: 00010206
[  202.771432] RAX: 00007ff71e855000 RBX: 0000000000000000 RCX: =
000000000000001a
[  202.778558] RDX: 0000000001dfd000 RSI: 000000007fffffe5 RDI: =
0000000000000000
[  202.785692] RBP: 00007ffde95af4b0 R08: 0000000000000000 R09: =
00007ff73d2a520d
[  202.792823] R10: 0000000000000002 R11: 0000000000000246 R12: =
0000000000400850
[  202.799949] R13: 00007ffde95af590 R14: 0000000000000000 R15: =
0000000000000000


Further tests show that this also happens if one waits long enough on  =
5.3-rc1 as well.
So I don=E2=80=99t think we have a fix in tree yet.=20

Cheers,
Masoud

