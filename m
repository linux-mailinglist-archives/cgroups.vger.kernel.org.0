Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26546526586
	for <lists+cgroups@lfdr.de>; Fri, 13 May 2022 17:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381642AbiEMPBc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 13 May 2022 11:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381805AbiEMPBF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 13 May 2022 11:01:05 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144E13ED35;
        Fri, 13 May 2022 07:59:33 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id n18so8191328plg.5;
        Fri, 13 May 2022 07:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iQkNXkMlycq0VUrhSvL25PiSVyr4BABvBfQJy7TRO1E=;
        b=BdUwUxjuY8blvDl1M0G3ebioLHzHFo/SdHfq4waRnAMJZmeNz/c/PHGaFt1H//rf0s
         QTTBCvWywsASi7F4NWzqHocotgIKx2cD1xxSjNMQXxY/cE1wiyuzb1SIkroWrdxb6dd9
         lF0wCYi1PZYuIf+HBjpvmXghlj588Dqw2Qr5150lOxMTcREbAH0H2pZNIVTVdchzbKUH
         OD17ZFp+QfA8pNkxYrEvRQHr5W7l+GZl/eKWzm4EmrJimZn1gFY9AvqswGM0ApfaxDlM
         WwqwWvF6Dja+8JQJt26ceC7t6Y6lwJ0NUhQ40/gJckAEK2mAJtD0iIdf9krXJo+ylq3G
         8auA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iQkNXkMlycq0VUrhSvL25PiSVyr4BABvBfQJy7TRO1E=;
        b=ddO1kfPT6mqICmsRhiUHkm9PcWhdWQC+M525xCPcS7Y4eAjrp9t4H1GzPvX7OSr4Sw
         Oz4jv7BBB/T8i7oCthGqUrttflQ6YR5jtpjk2J4rtzn74/3GTf7R47Szp8X4zGmN5kME
         2d//gYpvJqELwy2bNrVxbvBVdeFo5oT/8AdzUJhJybCyraYGevGVx9D8UdMwPGkktNzb
         Bh0g6dvD4hyTABYqTESieLVmQw66Nb8vdhEUB1EZiXhJit3Cini+bRuSNHcOfuNKx6xd
         xnnOf/O5btcIVLuSlvAfdxGkgnhFdjr9ifRGrGvnwoHBW233RAH0902Lh0qvL3EUrz1W
         0fIQ==
X-Gm-Message-State: AOAM531447BiztF/t5/S1FqxGbgdMgfOwWs9RzY5yiVJiFAnikYUWCbM
        EK9IDg2FsRvw96XtPRQIokestIw5fsZyE+3S
X-Google-Smtp-Source: ABdhPJxb+6l5jOmYav5Xjhtq0BxJWbX4MhhJrZYghHiyQkWwD6Wr9kONvPNJVWmZWm+23poiptxsPw==
X-Received: by 2002:a17:90b:33ce:b0:1dc:690e:acef with SMTP id lk14-20020a17090b33ce00b001dc690eacefmr16336081pjb.121.1652453972665;
        Fri, 13 May 2022 07:59:32 -0700 (PDT)
Received: from DIDI-C02G33EXQ05D.xiaojukeji.com ([111.194.46.158])
        by smtp.gmail.com with ESMTPSA id z6-20020a170903018600b0015eb200cc00sm2011747plg.138.2022.05.13.07.59.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 May 2022 07:59:32 -0700 (PDT)
From:   Yahu Gao <gaoyahu19@gmail.com>
To:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org
Subject: [PATCH 0/1] block,iocost: fix potential kernel NULL
Date:   Fri, 13 May 2022 22:59:27 +0800
Message-Id: <20220513145928.29766-1-gaoyahu19@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

There is a kernel NULL during ioc_pd_init. And the scene have analysed as
follow:
ioc_pd_init
    ...
    for (tblkg = blkg; tblkg; tblkg = tblkg->parent) {
        struct ioc_gq *tiocg = blkg_to_iocg(tblkg);
        // tiocg = pd_to_iocg(blkg_to_pd(blkg, &blkcg_policy_iocost));
                               ^ returns NULL after first iteration
        iocg->ancestors[tiocg->level] = tiocg;
    }


[ 5837.883640] BUG: unable to handle kernel NULL pointer dereference at 00000000000001d0
[ 5837.930538] PGD 0 P4D 0
[ 5837.945644] Oops: 0000 [#1] SMP NOPTI
[ 5837.967541] CPU: 57 PID: 66239 Comm: bash Kdump: loaded Not tainted  #1
[ 5838.010240] Hardware name:
 5838.051901] RIP: 0010:ioc_pd_init+0x12b/0x1a0
[ 5838.077940] Code: 48 8b 45 28 48 8b 00 8b 80 3c 01 00 00 41 89 84 24 d0 01 00 00 48 85 ed 74 28 48 63 0d 8e 3e f1 00 48 83 c1 4c 48 8b 44 cd 00 <48> 63 90 d0 01 00 00 49 89 84 d4 d8 01 00 00 48 8b 6d 38 48 85 ed
[ 5838.190361] RSP: 0018:ffffbf43629abce0 EFLAGS: 00010086
[ 5838.221618] RAX: 0000000000000000 RBX: ffff9c6d9f97f000 RCX: 000000000000004f
[ 5838.264315] RDX: 0000000000000003 RSI: 0000000000000001 RDI: ffff9c2dc1ddc738
[ 5838.307007] RBP: ffff9c6de4809000 R08: 0000000000000000 R09: ffffdf433f1c63a8
[ 5838.349701] R10: 00000000000000ec R11: 00000000000000ec R12: ffff9c2dc1ddc600
[ 5838.392392] R13: 0000000000000000 R14: 0000000000000000 R15: ffffffff8bf256c0
[ 5838.435085] FS:  00007fd943e90100(0000) GS:ffff9c2dffc40000(0000) knlGS:0000000000000000
[ 5838.483499] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033ize
[ 5838.517866] CR2: 00000000000001d0 CR3: 0000003f338b8001 CR4: 00000000007606e0
[ 5838.560562] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 5838.603253] DR3: 0000000000000000 DR6: 009a8000fffe0ff0 DR7: 0000000000000400
[ 5838.645946] PKRU: 55555554
[ 5838.662103] Call Trace:
[ 5838.676723]  blkcg_activate_policy+0x107/0x2b0
[ 5838.706937]  blk_iocost_init+0x1af/0x240
[ 5838.730387]  ioc_qos_write+0x311/0x410
[ 5838.752798]  ? do_filp_open+0xa7/0x100
[ 5838.775212]  cgroup_file_write+0x8a/0x150
[ 5838.799181]  ? __check_object_size+0xa8/0x16b
[ 5838.825239]  kernfs_fop_write+0x116/0x190
[ 5838.849210]  vfs_write+0xa5/0x1a0
[ 5838.869015]  ksys_write+0x4f/0xb0
[ 5838.888830]  do_syscall_64+0x5b/0x1a0
[ 5838.910724]  entry_SYSCALL_64_after_hwframe+0x65/0xca
[ 5838.940937] RIP: 0033:0x7fd94336eb28
