Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BADF34C65CC
	for <lists+cgroups@lfdr.de>; Mon, 28 Feb 2022 10:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234377AbiB1Jls (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 28 Feb 2022 04:41:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234372AbiB1Jls (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 28 Feb 2022 04:41:48 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33543657B9;
        Mon, 28 Feb 2022 01:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=K1HgFtbE1kLZa+V59uyLK4T/jY6J7IZE1EzN8l8FpIM=; b=2P8WU/IEmqKdXPm15SQLHHORTC
        RoIFzZI3fiQ3VLEVV3iFKNHgV6TURqiCidTMWVro3/cIS9lvv//Vhw4UP4bH2j3Yb3ACS2cZGeg9+
        O88UcioX187BzUeeTTJ317jqm6CAUJCLcfsMmTkHfr/dZlcqSrRX4AHInpixdk2EvRKDEuSs3WZQI
        yJYkQo5/qzTysL5Sw6UVPWB3x60lTwZAD/TMSJM041cRTOI75fZl08QUzjRYldWoTL1rfCqpUfrqa
        TAfdwqSLQpZeQo/6BjW9t0SVWWg7hvHpHB0NdkEnH9aWZ0j0G7nDQDeWQqkkT+3iH8R+wI7YMHU9Z
        ABSfhnUQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nOcWT-00BI0K-Ev; Mon, 28 Feb 2022 09:40:53 +0000
Date:   Mon, 28 Feb 2022 01:40:53 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Yu Kuai <yukuai3@huawei.com>, tj@kernel.org, axboe@kernel.dk,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Subject: Re: [PATCH v9] block: cancel all throttled bios in del_gendisk()
Message-ID: <YhyYpWHGVhs3J/dk@infradead.org>
References: <20220210115637.1074927-1-yukuai3@huawei.com>
 <YhuyBgZSS6m/Mwu6@infradead.org>
 <Yhxnkg0AEaj36t+a@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yhxnkg0AEaj36t+a@T590>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Feb 28, 2022 at 02:11:30PM +0800, Ming Lei wrote:
> > FYI, this crashed left rigt and center when running xfstests with
> > traces pointing to throtl_pending_timer_fn.
> 
> Can you share the exact xfstests test(fs, test)? Or panic log?
> 
> I can't reproduce it when running './check -g auto' on XFS, meantime
> tracking throtl_pending_timer_fn().

From a quick run using f2fs:

generic/081 files ... [  316.487861] run fstests generic/081 at 2022-02-28 09:38:40
[  318.291133] F2FS-fs (dm-3): Found nat_bits in checkpoint
[  318.298016] F2FS-fs (dm-3): Mounted with checkpoint version = 526422b7
[  318.363888] device-mapper: snapshots: Invalidating snapshot: Unable to allocate exceptio.
[  318.540023] general protection fault, probably for non-canonical address 0x6b6b6b6b6b6b6I
[  318.541556] CPU: 0 PID: 13947 Comm: dmsetup Not tainted 5.17.0-rc2+ #1074
[  318.542514] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/24
[  318.543695] RIP: 0010:__lock_acquire+0x5b4/0x1de0
[  318.544351] Code: 89 84 24 40 09 00 00 0f 87 2a 05 00 00 3b 05 17 c7 b2 03 41 bf 01 00 03
[  318.546881] RSP: 0000:ffffc90000003cf8 EFLAGS: 00010002
[  318.547610] RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000001
[  318.548556] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 6b6b6b6b6b6b6bf3
[  318.549497] RBP: 6b6b6b6b6b6b6bf3 R08: 0000000000000001 R09: 0000000000000001
[  318.550438] R10: 0000000000000001 R11: 0000000000000000 R12: ffff8880117c8040
[  318.551378] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[  318.552323] FS:  0000000000000000(0000) GS:ffff88813bc00000(0000) knlGS:0000000000000000
[  318.553380] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  318.554119] CR2: 00007f54883c9028 CR3: 0000000012a52000 CR4: 00000000000006f0
[  318.555036] Call Trace:
[  318.555360]  <IRQ>
[  318.555630]  lock_acquire+0xd6/0x300
[  318.556099]  ? throtl_pending_timer_fn+0x69/0xa50
[  318.556709]  ? _raw_spin_lock_irq+0x4f/0x60
[  318.557252]  ? throtl_pd_offline+0x60/0x60
[  318.557783]  _raw_spin_lock_irq+0x40/0x60
[  318.558303]  ? throtl_pending_timer_fn+0x69/0xa50
[  318.558915]  throtl_pending_timer_fn+0x69/0xa50
[  318.559485]  ? throtl_pd_offline+0x60/0x60
[  318.560003]  ? throtl_pd_offline+0x60/0x60
[  318.560520]  call_timer_fn+0x9f/0x2c0
[  318.560985]  __run_timers.part.0+0x1fc/0x2f0
[  318.561524]  ? lock_is_held_type+0xe4/0x140
[  318.562055]  run_timer_softirq+0x2c/0x60
[  318.562550]  __do_softirq+0x174/0x512
[  318.563016]  __irq_exit_rcu+0xdf/0x130
[  318.563491]  irq_exit_rcu+0x5/0x20
[  318.563926]  sysvec_apic_timer_interrupt+0xa2/0xd0
[  318.564529]  </IRQ>
[  318.564800]  <TASK>
[  318.565072]  asm_sysvec_apic_timer_interrupt+0x12/0x20
