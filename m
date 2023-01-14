Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D36C66AC2B
	for <lists+cgroups@lfdr.de>; Sat, 14 Jan 2023 16:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjANPiO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 14 Jan 2023 10:38:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjANPiN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 14 Jan 2023 10:38:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD4065A5;
        Sat, 14 Jan 2023 07:38:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6E393B80927;
        Sat, 14 Jan 2023 15:38:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB5C8C433EF;
        Sat, 14 Jan 2023 15:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673710688;
        bh=JXHJI/vALvMFcDnpVAFxYL7PlVxvOiIcfp5zkC2Fk4I=;
        h=From:To:Cc:Subject:Date:From;
        b=gWHhydnw/HkxbN64vo7DJZkFwTq65xhJ8A52vT3Xj3LAnx0cotI+d2mJQERNQknSE
         zirwVTsd2bsnZYOubAhevZtRZbJQbibjgvmXsWiozJkKA/pH/VJv2ZmvvuHbjEHHJV
         ktMz2VAj3U6tcKaVnbYml0oR28rPt0Y7wRsnkC+gfsBx7izmPemU8qaIvI0BwteeNu
         0G84VJLXKVQLq8LQdsJM8f+8q1wMvpo1io4GWnmTo84hiBGKyJ+hv8WXyzDgr1RoO5
         /maviwNg0/zSrojwE1LJ6LgMYwt2/EXL78/aXgEl7cQEgPS66ZksGXbBCe8Qn7CGr+
         EkZp9xcF32FsA==
From:   Sasha Levin <sashal@kernel.org>
To:     tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
        paolo.valente@linaro.org, jack@suse.cz
Cc:     khazhy@google.com, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>
Subject: [RFC] block, bfq: use-after-free with bfq <==> cgroup interactions
Date:   Sat, 14 Jan 2023 10:38:01 -0500
Message-Id: <20230114153801.3932380-1-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

I've observed the follow use after free after commit 64dc8c732f5c
("block, bfq: fix possible uaf for 'bfqq->bic'"):

[  114.277139] BUG: unable to handle page fault for address: ffff9edd3a529f58
[  114.284173] #PF: supervisor read access in kernel mode
[  114.289338] #PF: error_code(0x0000) - not-present page
[  114.294478] PGD a661c01067 P4D a661c01067 PUD c03f1c2067 PMD c03efef067 PTE 800ffffe85ad6060
[  114.302947] Oops: 0000 [#1] SMP DEBUG_PAGEALLOC NOPTI
[  114.308000] CPU: 153 PID: 4171 Comm: udevd Tainted: G        W   5.15.88-dbg-DEV #5
[  114.316215] Hardware name: Google, Inc.
                          Arcadia_IT_80/Arcadia_IT_80, BIOS 34.2.2 10/03/2022
[  114.329301] RIP: 0010:bic_set_bfqq (./block/bfq-iosched.c:392)
[  114.333599] Code: 38 5d c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00
0f 1f 44 00 00 55 48 89 e5 53 48 89 fb 89 d0 48 8b 4c c7 38 48 85 c9
74 14 <48> 39 99 98 01 00 00 75 0b 48 c7 81 98 01 00 00 00 00 00 00 48
89
All code
========
   0:   38 5d c3                cmp    %bl,-0x3d(%rbp)
   3:   66 2e 0f 1f 84 00 00    cs nopw 0x0(%rax,%rax,1)
   a:   00 00 00
   d:   0f 1f 40 00             nopl   0x0(%rax)
  11:   0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
  16:   55                      push   %rbp
  17:   48 89 e5                mov    %rsp,%rbp
  1a:   53                      push   %rbx
  1b:   48 89 fb                mov    %rdi,%rbx
  1e:   89 d0                   mov    %edx,%eax
  20:   48 8b 4c c7 38          mov    0x38(%rdi,%rax,8),%rcx
  25:   48 85 c9                test   %rcx,%rcx
  28:   74 14                   je     0x3e
  2a:*  48 39 99 98 01 00 00    cmp    %rbx,0x198(%rcx)         <-- trapping instruction
  31:   75 0b                   jne    0x3e
  33:   48 c7 81 98 01 00 00    movq   $0x0,0x198(%rcx)
  3a:   00 00 00 00
  3e:   48                      rex.W
  3f:   89                      .byte 0x89

Code starting with the faulting instruction
===========================================
   0:   48 39 99 98 01 00 00    cmp    %rbx,0x198(%rcx)
   7:   75 0b                   jne    0x14
   9:   48 c7 81 98 01 00 00    movq   $0x0,0x198(%rcx)
  10:   00 00 00 00
  14:   48                      rex.W
  15:   89                      .byte 0x89
[  114.352382] RSP: 0018:ffffb94be342b5b8 EFLAGS: 00010086
[  114.357607] RAX: 0000000000000001 RBX: ffff9edd3a4f5f08 RCX: ffff9edd3a529dc0
[  114.364730] RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffff9edd3a4f5f08
[  114.371856] RBP: ffffb94be342b5c0 R08: 0000000000000000 R09: 0000000000000001
[  114.378989] R10: 00000000000a0027 R11: ffffffff9f6c9500 R12: 0000000000000060
[  114.386120] R13: ffff9edd3a529dc0 R14: ffff9edd3a4f5f08 R15: ffff9edcd12d3800
[  114.393252] FS:  00007fa7ab3e5740(0000) GS:ffff9f3a8e440000(0000) knlGS:0000000000000000
[  114.401340] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  114.407086] CR2: ffff9edd3a529f58 CR3: 000000011006e004 CR4: 0000000000370ee0
[  114.414255] Call Trace:
[  114.416706]  <TASK>
[  114.418821] bfq_bic_update_cgroup (././include/linux/blk-cgroup.h:401 ./block/bfq-cgroup.c:286 ./block/bfq-cgroup.c:774)
[  114.425087] bfq_bio_merge (./block/bfq-iosched.c:?)
[  114.430599] __blk_mq_sched_bio_merge (./block/blk-mq-sched.c:383)
[  114.436950] blk_mq_submit_bio (./block/blk-mq.c:2220)
[  114.442776] __submit_bio (./block/blk-core.c:928)
[  114.448262] submit_bio_noacct (././include/linux/bio.h:618 ./block/blk-core.c:1009 ./block/blk-core.c:1038)
[  114.454181] submit_bio (./block/blk-core.c:1101)
[  114.459338] ext4_io_submit (./fs/ext4/page-io.c:383)
[  114.464824] ext4_writepages (./fs/ext4/inode.c:?)
[  114.470692] ? do_writepages (./mm/page-writeback.c:2364)
[  114.476440] ? lock_is_held_type (./kernel/locking/lockdep.c:5365 ./kernel/locking/lockdep.c:5665)
[  114.482468] ? lock_is_held_type (./kernel/locking/lockdep.c:5365 ./kernel/locking/lockdep.c:5665)
[  114.488477] do_writepages (./mm/page-writeback.c:2364)
[  114.494048] ? wbc_attach_and_unlock_inode (./fs/fs-writeback.c:719)
[  114.500948] filemap_fdatawrite_wbc (./mm/filemap.c:400)
[  114.507125] filemap_flush (./mm/filemap.c:? ./mm/filemap.c:439 ./mm/filemap.c:466)
[  114.512526] ext4_alloc_da_blocks (./fs/ext4/inode.c:?)
[  114.518555] ext4_rename2 (./fs/ext4/namei.c:? ./fs/ext4/namei.c:4191)
[  114.524124] ? down_write_nested (./kernel/locking/rwsem.c:1643)
[  114.530038] ? lock_two_nondirectories (./fs/inode.c:1044)
[  114.536471] vfs_rename (./fs/namei.c:4680)
[  114.541785] do_renameat2 (./fs/namei.c:?)
[  114.547307] __x64_sys_rename (./fs/namei.c:4877 ./fs/namei.c:4875 ./fs/namei.c:4875)
[  114.552988] do_syscall_64 (./arch/x86/entry/common.c:50 ./arch/x86/entry/common.c:80)
[  114.558389] ? sysvec_call_function_single (./arch/x86/kernel/smp.c:243)
[  114.565209] entry_SYSCALL_64_after_hwframe (./arch/x86/entry/entry_64.S:118)
[  114.572083] RIP: 0033:0x7fa7ab490327

The proposed fix is based purely on an observation that earlier in the
same function the call order is reversed where we first bic_set_bfqq()
and only then bfq_release_process_ref().

And thus, this explanation is only a "how" and not a "why", which is why
the patch is going out as an RFC.

Fixes: 64dc8c732f5c ("block, bfq: fix possible uaf for 'bfqq->bic'")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/bfq-cgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 1b2829e99dad..cec4d88f6de7 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -770,9 +770,9 @@ static void __bfq_bic_change_cgroup(struct bfq_data *bfqd,
 				 * bfqq now so that we cannot merge bio to a
 				 * request from the old cgroup.
 				 */
+				bic_set_bfqq(bic, NULL, true);
 				bfq_put_cooperator(sync_bfqq);
 				bfq_release_process_ref(bfqd, sync_bfqq);
-				bic_set_bfqq(bic, NULL, true);
 			}
 		}
 	}
-- 
2.35.1

