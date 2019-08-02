Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF027FBE9
	for <lists+cgroups@lfdr.de>; Fri,  2 Aug 2019 16:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbfHBOSX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 2 Aug 2019 10:18:23 -0400
Received: from nwk-aaemail-lapp02.apple.com ([17.151.62.67]:58474 "EHLO
        nwk-aaemail-lapp02.apple.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727485AbfHBOSX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 2 Aug 2019 10:18:23 -0400
Received: from pps.filterd (nwk-aaemail-lapp02.apple.com [127.0.0.1])
        by nwk-aaemail-lapp02.apple.com (8.16.0.27/8.16.0.27) with SMTP id x72EHBMP005504;
        Fri, 2 Aug 2019 07:18:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com; h=sender : content-type
 : mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=20180706;
 bh=2TtxIQqEcQn+lObu8KFXWWIUpGphNyUfyHDO93O7QvY=;
 b=VKB8e4M8vJ8xElL5VcYsUsjf0mb9bFMm5UAqisLnJyWsQjXxGbj9etZVYIhaJtM2q7Vk
 YZLbfGclM6chXEAaMA0P/QHCKAL29n1JC/1d040c3Lp+P/mVjHbYiIN0QWbOvOkeEYdb
 qVjFyzbjfz6Kym9h0q94adCOhkCbbnvLYUD54b9F1niOwQunYkmuHciT3AM7j0yASAhP
 Sm2FUpLDIt9hvM79EMoJt7Mr+50UMAc+lFhxQM1+i4Wlyr9GEl3cXsHlLTaN//xkYmB/
 F3N6B3J/b5mzTrQsD5QBIevWZke+jC1hppiXMVJCil9fur3SsD5WuTOhnpV64YY1TSrg 8Q== 
Received: from mr2-mtap-s02.rno.apple.com (mr2-mtap-s02.rno.apple.com [17.179.226.134])
        by nwk-aaemail-lapp02.apple.com with ESMTP id 2u2p72pbfg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Fri, 02 Aug 2019 07:18:19 -0700
Received: from nwk-mmpp-sz11.apple.com
 (nwk-mmpp-sz11.apple.com [17.128.115.155]) by mr2-mtap-s02.rno.apple.com
 (Oracle Communications Messaging Server 8.0.2.4.20190507 64bit (built May  7
 2019)) with ESMTPS id <0PVM00EEV52JVZ40@mr2-mtap-s02.rno.apple.com>; Fri,
 02 Aug 2019 07:18:19 -0700 (PDT)
Received: from process_milters-daemon.nwk-mmpp-sz11.apple.com by
 nwk-mmpp-sz11.apple.com
 (Oracle Communications Messaging Server 8.0.2.4.20190507 64bit (built May  7
 2019)) id <0PVM00F004J8MZ00@nwk-mmpp-sz11.apple.com>; Fri,
 02 Aug 2019 07:18:19 -0700 (PDT)
X-Va-A: 
X-Va-T-CD: d66bf338104d7316df20fe4640a3b0ba
X-Va-E-CD: b03d5acee32fc9f0c9dfd3776592dc73
X-Va-R-CD: 1835f3c54d533384876758843bc94ede
X-Va-CD: 0
X-Va-ID: fc083513-02ff-4ce2-885c-103e48753e84
X-V-A:  
X-V-T-CD: d66bf338104d7316df20fe4640a3b0ba
X-V-E-CD: b03d5acee32fc9f0c9dfd3776592dc73
X-V-R-CD: 1835f3c54d533384876758843bc94ede
X-V-CD: 0
X-V-ID: ab3ee819-e4d3-4ca5-96aa-c7ef1969d272
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,,
 definitions=2019-08-02_06:,, signatures=0
Received: from [17.150.223.234] (unknown [17.150.223.234])
 by nwk-mmpp-sz11.apple.com
 (Oracle Communications Messaging Server 8.0.2.4.20190507 64bit (built May  7
 2019)) with ESMTPSA id <0PVM0043452IHJ50@nwk-mmpp-sz11.apple.com>; Fri,
 02 Aug 2019 07:18:19 -0700 (PDT)
Content-type: text/plain; charset=utf-8
MIME-version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: Possible mem cgroup bug in kernels between 4.18.0 and 5.3-rc1.
From:   Masoud Sharbiani <msharbiani@apple.com>
In-reply-to: <20190802074047.GQ11627@dhcp22.suse.cz>
Date:   Fri, 02 Aug 2019 07:18:17 -0700
Cc:     gregkh@linuxfoundation.org, hannes@cmpxchg.org,
        vdavydov.dev@gmail.com, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Content-transfer-encoding: quoted-printable
Message-id: <7E44073F-9390-414A-B636-B1AE916CC21E@apple.com>
References: <5659221C-3E9B-44AD-9BBF-F74DE09535CD@apple.com>
 <20190802074047.GQ11627@dhcp22.suse.cz>
To:     Michal Hocko <mhocko@kernel.org>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-02_06:,,
 signatures=0
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

=20

> On Aug 2, 2019, at 12:40 AM, Michal Hocko <mhocko@kernel.org> wrote:
>=20
> On Thu 01-08-19 11:04:14, Masoud Sharbiani wrote:
>> Hey folks,
>> I=E2=80=99ve come across an issue that affects most of 4.19, 4.20 and =
5.2 linux-stable kernels that has only been fixed in 5.3-rc1.
>> It was introduced by
>>=20
>> 29ef680 memcg, oom: move out_of_memory back to the charge path=20
>=20
> This commit shouldn't really change the OOM behavior for your =
particular
> test case. It would have changed MAP_POPULATE behavior but your usage =
is
> triggering the standard page fault path. The only difference with
> 29ef680 is that the OOM killer is invoked during the charge path =
rather
> than on the way out of the page fault.
>=20
> Anyway, I tried to run your test case in a loop and leaker always ends
> up being killed as expected with 5.2. See the below oom report. There
> must be something else going on. How much swap do you have on your
> system?

I do not have swap defined.=20
-m


>=20
> [337533.314245] leaker invoked oom-killer: =
gfp_mask=3D0x100cca(GFP_HIGHUSER_MOVABLE), order=3D0, oom_score_adj=3D0
> [337533.314250] CPU: 3 PID: 23793 Comm: leaker Not tainted 5.2.0-rc7 =
#54
> [337533.314251] Hardware name: Dell Inc. Latitude E7470/0T6HHJ, BIOS =
1.5.3 04/18/2016
> [337533.314252] Call Trace:
> [337533.314258]  dump_stack+0x67/0x8e
> [337533.314262]  dump_header+0x51/0x2e9
> [337533.314265]  ? preempt_count_sub+0xc6/0xd2
> [337533.314267]  ? _raw_spin_unlock_irqrestore+0x2c/0x3e
> [337533.314269]  oom_kill_process+0x90/0x11d
> [337533.314271]  out_of_memory+0x25c/0x26f
> [337533.314273]  mem_cgroup_out_of_memory+0x8a/0xa6
> [337533.314276]  try_charge+0x1d0/0x782
> [337533.314278]  ? preempt_count_sub+0xc6/0xd2
> [337533.314280]  mem_cgroup_try_charge+0x1a1/0x207
> [337533.314282]  __add_to_page_cache_locked+0xf9/0x2dd
> [337533.314285]  ? memcg_drain_all_list_lrus+0x125/0x125
> [337533.314286]  add_to_page_cache_lru+0x3c/0x96
> [337533.314288]  pagecache_get_page.part.7+0x1d6/0x240
> [337533.314290]  filemap_fault+0x267/0x54a
> [337533.314292]  ext4_filemap_fault+0x2d/0x41
> [337533.314294]  ? ext4_page_mkwrite+0x3cd/0x3cd
> [337533.314296]  __do_fault+0x47/0xa7
> [337533.314297]  __handle_mm_fault+0xaaa/0xf9d
> [337533.314300]  handle_mm_fault+0x174/0x1c3
> [337533.314303]  __do_page_fault+0x309/0x412
> [337533.314305]  do_page_fault+0x10b/0x131
> [337533.314307]  ? page_fault+0x8/0x30
> [337533.314309]  page_fault+0x1e/0x30
> [337533.314311] RIP: 0033:0x55a806ef8503
> [337533.314313] Code: 48 89 c6 48 8d 3d 28 0c 00 00 b8 00 00 00 00 e8 =
73 fb ff ff c7 45 ec 00 00 00 00 eb 36 8b 45 ec 48 63 d0 48 8b 45 c8 48 =
01 d0 <0f> b6 00 0f be c0 01 45 e4 8b 45 ec 25 ff 0f 00 00 85 c0 75 10 =
8b
> [337533.314314] RSP: 002b:00007ffcf6734730 EFLAGS: 00010206
> [337533.314316] RAX: 00007f2228f74000 RBX: 0000000000000000 RCX: =
0000000000000000
> [337533.314317] RDX: 0000000000487000 RSI: 000055a806efc260 RDI: =
0000000000000000
> [337533.314318] RBP: 00007ffcf6735780 R08: 0000000000000000 R09: =
00007ffcf67345fc
> [337533.314319] R10: 0000000000000000 R11: 0000000000000246 R12: =
000055a806ef8120
> [337533.314320] R13: 00007ffcf6735860 R14: 0000000000000000 R15: =
0000000000000000
> [337533.314322] memory: usage 524288kB, limit 524288kB, failcnt =
1240247
> [337533.314323] memory+swap: usage 2592556kB, limit =
9007199254740988kB, failcnt 0
> [337533.314324] kmem: usage 7260kB, limit 9007199254740988kB, failcnt =
0
> [337533.314325] Memory cgroup stats for /leaker: cache:80KB =
rss:516948KB rss_huge:0KB shmem:0KB mapped_file:0KB dirty:0KB =
writeback:0KB swap:2068268KB inactive_anon:258520KB active_anon:258412KB =
inactive_file:32KB active_file:12KB unevictable:0KB
> [337533.314332] Tasks state (memory values in pages):
> [337533.314333] [  pid  ]   uid  tgid total_vm      rss pgtables_bytes =
swapents oom_score_adj name
> [337533.314404] [  23777]     0 23777      596      400    36864       =
 4             0 sh
> [337533.314407] [  23793]     0 23793   655928   126942  5226496   =
519670             0 leaker
> [337533.314408] =
oom-kill:constraint=3DCONSTRAINT_MEMCG,nodemask=3D(null),oom_memcg=3D/leak=
er,task_memcg=3D/leaker,task=3Dleaker,pid=3D23793,uid=3D0
> [337533.314412] Memory cgroup out of memory: Killed process 23793 =
(leaker) total-vm:2623712kB, anon-rss:506500kB, file-rss:1268kB, =
shmem-rss:0kB
> [337533.418036] oom_reaper: reaped process 23793 (leaker), now =
anon-rss:0kB, file-rss:0kB, shmem-rss:0kB
> --=20
> Michal Hocko
> SUSE Labs

