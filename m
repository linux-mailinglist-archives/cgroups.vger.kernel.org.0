Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA7980776
	for <lists+cgroups@lfdr.de>; Sat,  3 Aug 2019 19:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbfHCRmr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 3 Aug 2019 13:42:47 -0400
Received: from nwk-aaemail-lapp02.apple.com ([17.151.62.67]:42714 "EHLO
        nwk-aaemail-lapp02.apple.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725886AbfHCRmr (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 3 Aug 2019 13:42:47 -0400
Received: from pps.filterd (nwk-aaemail-lapp02.apple.com [127.0.0.1])
        by nwk-aaemail-lapp02.apple.com (8.16.0.27/8.16.0.27) with SMTP id x73Hg31I061797;
        Sat, 3 Aug 2019 10:42:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com; h=sender : content-type
 : mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=20180706;
 bh=bRkkC/ntl093lal8PH707LIzyeDQRUxXglb6XCpCp5g=;
 b=atDS6defcl+FOy7rii078Ax6ErNtRNuaV05osswNbt377/LhCv9iReo3Ig5SL0oohxEX
 34pTSV/vqUCGQjeDwxeQ9bto2hQzvkBJOJy+mJXEXlHfamDJ+U/phgU8vC8qwq5rgzWT
 CKQFCVwA7VKDxEFHTZuQwmuf+jA14sKY/gDZuuvJ/IrER4xGmxld46m0Vn/x6/KYLiYP
 9ONqVEcP4T97iAIRtBVlRqKRHUppPyreqPgx9S3A6wCJhKDrxjIFd/FXQXJy7tqcc2tM
 EGLJe05byUEnw0MN+z4t155hWgN3dE5X5nyKqTLt1Ir5nNyl7bvu1cUsvEnefiY+9aHs TQ== 
Received: from ma1-mtap-s01.corp.apple.com (ma1-mtap-s01.corp.apple.com [17.40.76.5])
        by nwk-aaemail-lapp02.apple.com with ESMTP id 2u56ujx5h7-17
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Sat, 03 Aug 2019 10:42:40 -0700
Received: from nwk-mmpp-sz11.apple.com
 (nwk-mmpp-sz11.apple.com [17.128.115.155]) by ma1-mtap-s01.corp.apple.com
 (Oracle Communications Messaging Server 8.0.2.4.20190507 64bit (built May  7
 2019)) with ESMTPS id <0PVO00L5I96Z2T40@ma1-mtap-s01.corp.apple.com>; Sat,
 03 Aug 2019 10:42:38 -0700 (PDT)
Received: from process_milters-daemon.nwk-mmpp-sz11.apple.com by
 nwk-mmpp-sz11.apple.com
 (Oracle Communications Messaging Server 8.0.2.4.20190507 64bit (built May  7
 2019)) id <0PVO00K0095HH200@nwk-mmpp-sz11.apple.com>; Sat,
 03 Aug 2019 10:42:37 -0700 (PDT)
X-Va-A: 
X-Va-T-CD: 2af4e3c096f98bec7d308668f2184085
X-Va-E-CD: b03d5acee32fc9f0c9dfd3776592dc73
X-Va-R-CD: 1835f3c54d533384876758843bc94ede
X-Va-CD: 0
X-Va-ID: 25033930-1b8f-487f-8f89-4f239138e815
X-V-A:  
X-V-T-CD: 2af4e3c096f98bec7d308668f2184085
X-V-E-CD: b03d5acee32fc9f0c9dfd3776592dc73
X-V-R-CD: 1835f3c54d533384876758843bc94ede
X-V-CD: 0
X-V-ID: 8093249f-89b7-424f-898d-6a35440e7308
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,,
 definitions=2019-08-03_09:,, signatures=0
Received: from [17.150.210.108] (unknown [17.150.210.108])
 by nwk-mmpp-sz11.apple.com
 (Oracle Communications Messaging Server 8.0.2.4.20190507 64bit (built May  7
 2019)) with ESMTPSA id <0PVO008PZ95GJO50@nwk-mmpp-sz11.apple.com>; Sat,
 03 Aug 2019 10:41:41 -0700 (PDT)
Content-type: text/plain; charset=utf-8
MIME-version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: Possible mem cgroup bug in kernels between 4.18.0 and 5.3-rc1.
From:   Masoud Sharbiani <msharbiani@apple.com>
In-reply-to: <d7efccf4-7f07-10da-077d-a58dafbf627e@I-love.SAKURA.ne.jp>
Date:   Sat, 03 Aug 2019 10:41:40 -0700
Cc:     Michal Hocko <mhocko@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>, hannes@cmpxchg.org,
        vdavydov.dev@gmail.com, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Content-transfer-encoding: quoted-printable
Message-id: <77568CFC-280C-4C0F-85FC-92F1212BC6FC@apple.com>
References: <5659221C-3E9B-44AD-9BBF-F74DE09535CD@apple.com>
 <20190802074047.GQ11627@dhcp22.suse.cz>
 <7E44073F-9390-414A-B636-B1AE916CC21E@apple.com>
 <20190802144110.GL6461@dhcp22.suse.cz>
 <5DE6F4AE-F3F9-4C52-9DFC-E066D9DD5EDC@apple.com>
 <20190802191430.GO6461@dhcp22.suse.cz>
 <A06C5313-B021-4ADA-9897-CE260A9011CC@apple.com>
 <f7733773-35bc-a1f6-652f-bca01ea90078@I-love.SAKURA.ne.jp>
 <d7efccf4-7f07-10da-077d-a58dafbf627e@I-love.SAKURA.ne.jp>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-03_09:,,
 signatures=0
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



> On Aug 3, 2019, at 8:51 AM, Tetsuo Handa =
<penguin-kernel@I-love.SAKURA.ne.jp> wrote:
>=20
> Masoud, will you try this patch?

Gladly.
It looks like it is working (and OOMing properly).


>=20
> By the way, is /sys/fs/cgroup/memory/leaker/memory.usage_in_bytes =
remains non-zero
> despite /sys/fs/cgroup/memory/leaker/tasks became empty due to memcg =
OOM killer expected?
> Deleting big-data-file.bin after memcg OOM killer reduces some, but =
still remains
> non-zero.

Yes. I had not noticed that:

[ 1114.190477] oom_reaper: reaped process 1942 (leaker), now =
anon-rss:0kB, file-
rss:0kB, shmem-rss:0kB
./test-script.sh: line 16:  1942 Killed                  ./leaker -p =
10240 -c 100000

[root@localhost laleaker]# cat  =
/sys/fs/cgroup/memory/leaker/memory.usage_in_bytes
3194880
[root@localhost laleaker]# cat  =
/sys/fs/cgroup/memory/leaker/memory.limit_in_bytes
536870912
[root@localhost laleaker]# rm -f big-data-file.bin
[root@localhost laleaker]# cat  =
/sys/fs/cgroup/memory/leaker/memory.usage_in_bytes
2838528

Thanks!
Masoud

PS: Tried hand-back-porting it to 4.19-y and it didn=E2=80=99t work. I =
think there are other patches between 4.19.0 and 5.3 that could be =
necessary=E2=80=A6


>=20
> ----------------------------------------
> =46rom 2f92c70f390f42185c6e2abb8dda98b1b7d02fa9 Mon Sep 17 00:00:00 =
2001
> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Date: Sun, 4 Aug 2019 00:41:30 +0900
> Subject: [PATCH] memcg, oom: don't require __GFP_FS when invoking =
memcg OOM killer
>=20
> Masoud Sharbiani noticed that commit 29ef680ae7c21110 ("memcg, oom: =
move
> out_of_memory back to the charge path") broke memcg OOM called from
> __xfs_filemap_fault() path. It turned out that try_chage() is retrying
> forever without making forward progress because =
mem_cgroup_oom(GFP_NOFS)
> cannot invoke the OOM killer due to commit 3da88fb3bacfaa33 ("mm, oom:
> move GFP_NOFS check to out_of_memory"). Regarding memcg OOM, we need =
to
> bypass GFP_NOFS check in order to guarantee forward progress.
>=20
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Reported-by: Masoud Sharbiani <msharbiani@apple.com>
> Bisected-by: Masoud Sharbiani <msharbiani@apple.com>
> Fixes: 29ef680ae7c21110 ("memcg, oom: move out_of_memory back to the =
charge path")
> ---
> mm/oom_kill.c | 5 +++--
> 1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index eda2e2a..26804ab 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -1068,9 +1068,10 @@ bool out_of_memory(struct oom_control *oc)
> 	 * The OOM killer does not compensate for IO-less reclaim.
> 	 * pagefault_out_of_memory lost its gfp context so we have to
> 	 * make sure exclude 0 mask - all other users should have at =
least
> -	 * ___GFP_DIRECT_RECLAIM to get here.
> +	 * ___GFP_DIRECT_RECLAIM to get here. But mem_cgroup_oom() has =
to
> +	 * invoke the OOM killer even if it is a GFP_NOFS allocation.
> 	 */
> -	if (oc->gfp_mask && !(oc->gfp_mask & __GFP_FS))
> +	if (oc->gfp_mask && !(oc->gfp_mask & __GFP_FS) && =
!is_memcg_oom(oc))
> 		return true;
>=20
> 	/*
> --=20
> 1.8.3.1
>=20
>=20

