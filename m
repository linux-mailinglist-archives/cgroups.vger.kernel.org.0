Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1EB04BF0AB
	for <lists+cgroups@lfdr.de>; Tue, 22 Feb 2022 05:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233891AbiBVD2i (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 21 Feb 2022 22:28:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240717AbiBVD2g (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 21 Feb 2022 22:28:36 -0500
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C6B22B1F
        for <cgroups@vger.kernel.org>; Mon, 21 Feb 2022 19:28:10 -0800 (PST)
Received: by mail-io1-f72.google.com with SMTP id w25-20020a6bd619000000b00640ddd0ad11so3549903ioa.2
        for <cgroups@vger.kernel.org>; Mon, 21 Feb 2022 19:28:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=jn1v1wrtUy0we1aF2ni8zoooQ45E+ro5had3wgyBV54=;
        b=Y/a6Rz/mU6Z7b6RJnmAXJ/69d0PFFOy4GlJqy2cWR3sA5MHiPhX/akCHCrJhFtMWPU
         JGv7U5LhLjmyd5iE90uFhm4d1EhS4WTJnm9pDbBsQcV+O40WXjBfrm4sT8IIxS04aD7E
         kVMWWhNIuxF0fA6ASPCi5MDydHErQhd9R5hJfiRROtTrG4/aWqBkKQYPGMb6W3Pxgzth
         tett96qF+dbArT20N14ryzv2C42cg1MJnlmTUBlQHsuu4f96R9MFF27GFXcTA2vxQhSQ
         o4P6A8fF6MU7lTKQnOmegW70aoTyisX7RucfQQh7NFetaIEPXl/8iMJU/M63KYDk1G6T
         uYJA==
X-Gm-Message-State: AOAM533ezp6tmpyzcLiOeM/2YeZG0y8DWL/RRLveR/KMzcmawfd4Cras
        KipwuGt7f9Iw3DyA9roI6I6EdCJy/SIOjhdn8bGMIU2GLWqz
X-Google-Smtp-Source: ABdhPJwvcdGWpoK/XmWmrt/RJmM7zJMzG1YEJtPZ2U2O45PYEbMt2BhVRCfFBhCzCJlCLVEnBbK1cFfhGL/cB+uriO9DuGX7UU0r
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a07:b0:2be:1b0:bd05 with SMTP id
 s7-20020a056e021a0700b002be01b0bd05mr19161773ild.211.1645500489485; Mon, 21
 Feb 2022 19:28:09 -0800 (PST)
Date:   Mon, 21 Feb 2022 19:28:09 -0800
In-Reply-To: <000000000000264b2a05d44bca80@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002752dc05d892f094@google.com>
Subject: Re: [syzbot] WARNING in cpuset_write_resmask
From:   syzbot <syzbot+568dc81cd20b72d4a49f@syzkaller.appspotmail.com>
To:     cgroups@vger.kernel.org, changbin.du@intel.com,
        christian.brauner@ubuntu.com, davem@davemloft.net,
        edumazet@google.com, hannes@cmpxchg.org, hkallweit1@gmail.com,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        lizefan.x@bytedance.com, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tj@kernel.org,
        yajun.deng@linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

syzbot has bisected this issue to:

commit e4b8954074f6d0db01c8c97d338a67f9389c042f
Author: Eric Dumazet <edumazet@google.com>
Date:   Tue Dec 7 01:30:37 2021 +0000

    netlink: add net device refcount tracker to struct ethnl_req_info

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15c42532700000
start commit:   e5313968c41b Merge branch 'Split bpf_sk_lookup remote_port..
git tree:       bpf-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17c42532700000
console output: https://syzkaller.appspot.com/x/log.txt?x=13c42532700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c40b67275bfe2a58
dashboard link: https://syzkaller.appspot.com/bug?extid=568dc81cd20b72d4a49f
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13bb97ce700000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12062c8e700000

Reported-by: syzbot+568dc81cd20b72d4a49f@syzkaller.appspotmail.com
Fixes: e4b8954074f6 ("netlink: add net device refcount tracker to struct ethnl_req_info")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
