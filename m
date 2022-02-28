Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6991F4C62CA
	for <lists+cgroups@lfdr.de>; Mon, 28 Feb 2022 07:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbiB1GKZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 28 Feb 2022 01:10:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbiB1GKZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 28 Feb 2022 01:10:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB305F258;
        Sun, 27 Feb 2022 22:09:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BF3ACB80E25;
        Mon, 28 Feb 2022 06:09:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10692C340F1;
        Mon, 28 Feb 2022 06:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1646028584;
        bh=ntKdtcU1juj+MTKalehAxm9wVv/ZFIUKyu9HCPrRBsE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IzEis12xQ2W/u3ivCICTkdEQHfJ/CwCv4cUGmbh85egPesemCln2XPrga7g0/3D1H
         Y9MI5y8id5DjmrJzEwIgsuQuiWHqDNKD/NynTUXwyvZPTPFHzfl2RduRTat6YFHGMr
         cLTNXAuKoUP4erBpq+xK36lXshrrChYsHidFAtBg=
Date:   Sun, 27 Feb 2022 22:09:43 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     syzbot <syzbot+a526c269335f529d25c8@syzkaller.appspotmail.com>
Cc:     cgroups@vger.kernel.org, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-next@vger.kernel.org, mhocko@kernel.org,
        roman.gushchin@linux.dev, sfr@canb.auug.org.au,
        syzkaller-bugs@googlegroups.com,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [syzbot] linux-next test error: WARNING in
 __mod_memcg_lruvec_state
Message-Id: <20220227220943.490fb7b5f7c57d872f9523cb@linux-foundation.org>
In-Reply-To: <000000000000c7fde605d8e6b085@google.com>
References: <000000000000c7fde605d8e6b085@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

(cc bigeasy)

                        WARN_ON_ONCE(!irqs_disabled());

in __mod_memcg_lruvec_state(), methinks.

On Fri, 25 Feb 2022 23:23:23 -0800 syzbot <syzbot+a526c269335f529d25c8@syzkaller.appspotmail.com> wrote:

> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    06aeb1495c39 Add linux-next specific files for 20220225
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=17a69c8e700000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=8d8bf144f45f9b3
> dashboard link: https://syzkaller.appspot.com/bug?extid=a526c269335f529d25c8
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+a526c269335f529d25c8@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 3590 at mm/memcontrol.c:749 __mod_memcg_lruvec_state+0x1ab/0x220
> Modules linked in:
> CPU: 1 PID: 3590 Comm: syz-fuzzer Not tainted 5.17.0-rc5-next-20220225-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:__mod_memcg_lruvec_state+0x1ab/0x220
> Code: bb 23 92 0e 48 c7 c7 e0 b6 d9 89 e8 af d9 95 07 65 c7 05 f4 c8 37 7e 00 00 00 00 48 83 c4 08 5b 5d 41 5c 41 5d 41 5e 41 5f c3 <0f> 0b e9 a6 fe ff ff 4c 89 f6 48 c7 c7 60 63 ee 8b e8 8f d3 45 02
> RSP: 0000:ffffc900039efbc0 EFLAGS: 00010202
> RAX: 0000000000000206 RBX: 0000000000000200 RCX: ffffffff81aafa53
> RDX: 1ffff1100218fa8d RSI: 000000000000001c RDI: ffff888010c7d468
> RBP: ffff888010c7d000 R08: 0000000000000001 R09: ffffffff8ba144e7
> R10: fffffbfff174289c R11: 0000000000000001 R12: 000000000000001c
> R13: ffff88813fe38000 R14: ffff88813fe38000 R15: ffff88813fffa000
> FS:  000000c0001d2c90(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000c000e00000 CR3: 000000001cfb0000 CR4: 00000000003506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  __mod_lruvec_page_state+0x1e5/0x3e0
>  page_add_new_anon_rmap+0x2e5/0x930
>  do_huge_pmd_anonymous_page+0x102c/0x2350
>  __handle_mm_fault+0x2a66/0x4110
>  handle_mm_fault+0x1c8/0x790
>  do_user_addr_fault+0x489/0x11c0
>  exc_page_fault+0x9e/0x180
>  asm_exc_page_fault+0x1e/0x30
> RIP: 0033:0x465e33
> Code: 00 00 c5 fe 6f 06 c5 fe 6f 4e 20 c5 fe 6f 56 40 c5 fe 6f 5e 60 48 81 c6 80 00 00 00 c5 fd e7 07 c5 fd e7 4f 20 c5 fd e7 57 40 <c5> fd e7 5f 60 48 81 c7 80 00 00 00 48 81 eb 80 00 00 00 77 b5 0f
> RSP: 002b:000000c0003533b8 EFLAGS: 00010202
> RAX: 000000c000db4000 RBX: 0000000000423fe0 RCX: 000000c001224000
> RDX: 000000c001224001 RSI: 000000c000990020 RDI: 000000c000dfffa0
> RBP: 000000c000353418 R08: 000000c000db4000 R09: 0000000000000000
> R10: 0000000000000020 R11: 0000000000000206 R12: 000000c000243f18
> R13: 000000000000002e R14: 000000c0000001a0 R15: 0000000000000000
>  </TASK>
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
