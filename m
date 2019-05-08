Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90C2917E82
	for <lists+cgroups@lfdr.de>; Wed,  8 May 2019 18:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728738AbfEHQwC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 8 May 2019 12:52:02 -0400
Received: from mail-it1-f198.google.com ([209.85.166.198]:58318 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728731AbfEHQwB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 8 May 2019 12:52:01 -0400
Received: by mail-it1-f198.google.com with SMTP id p23so2664767itc.7
        for <cgroups@vger.kernel.org>; Wed, 08 May 2019 09:52:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=0mythnzPfhPVWyHlhf2vS5jhrjHuHUNNfUDlg+aYw9A=;
        b=hUfyTkZ68Y1Th1FtaGCIIHswny3asnTYtn5bdCU8h/5ZzBNo9xBgoZxtbf1T1zZVa0
         /ytWz+41C6NEgiimWVvWy7nS212q9hZuSeLHr3P3sQe9g1PVyCfBHSF7q3JPoqiq9acO
         BOBCIYpTbjUCAslllZ4sD878qf1v9stf+8pW+ytG5v9e6zjuCbOg7dl8rcbYg3W96J26
         lktRrg+V/sD10rtuLUCn0y9JEmG5MFV5MRqizGN65isPBri58sq3zHcKIB8h0/Rl5idD
         1KDX/9GxwvFCqwBr4VW4cV2yfvZ5lCxZJIYWZWFjLfSydYcurnFPq7HqCMrrm0uIXF18
         ZWYw==
X-Gm-Message-State: APjAAAXc6sRNKb0Ljzb1D/ywHICc8g6YxsXfBkEef1KXyYuxwoPK2QQg
        LuuF5iU4JTEfcqKFrSZvcDHM2bLzUF6BiJFqWaExOI3O4kRI
X-Google-Smtp-Source: APXvYqzn8EGCMk5VzujP7HVqRUmMSRCGOcAA/AZcz33of0OiGm4u2Q+CbAdIyc3cECPxBabsd8wQ6BLVyHwoK22/ZFtvHA6zWcpP
MIME-Version: 1.0
X-Received: by 2002:a02:b088:: with SMTP id v8mr30068575jah.21.1557334320874;
 Wed, 08 May 2019 09:52:00 -0700 (PDT)
Date:   Wed, 08 May 2019 09:52:00 -0700
In-Reply-To: <000000000000a573da058858083c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fe103805886326ea@google.com>
Subject: Re: WARNING in cgroup_exit
From:   syzbot <syzbot+f14868630901fc6151d3@syzkaller.appspotmail.com>
To:     alexander.h.duyck@intel.com, amritha.nambiar@intel.com,
        andriy.shevchenko@linux.intel.com, ast@kernel.org,
        bpf@vger.kernel.org, cgroups@vger.kernel.org, daniel@iogearbox.net,
        davem@davemloft.net, dmitry.torokhov@gmail.com,
        f.fainelli@gmail.com, guro@fb.com, hannes@cmpxchg.org,
        idosch@mellanox.com, kafai@fb.com, linux-kernel@vger.kernel.org,
        lizefan@huawei.com, netdev@vger.kernel.org, sfr@canb.auug.org.au,
        songliubraving@fb.com, syzkaller-bugs@googlegroups.com,
        tj@kernel.org, tyhicks@canonical.com, wanghai26@huawei.com,
        yhs@fb.com, yuehaibing@huawei.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

syzbot has bisected this bug to:

commit e42940e8559c8bbffa8286cc78067c75eb42b374
Author: Stephen Rothwell <sfr@canb.auug.org.au>
Date:   Tue May 7 01:03:30 2019 +0000

     Merge remote-tracking branch 'rdma/for-next'

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1746b4e8a00000
start commit:   00c3bc00 Add linux-next specific files for 20190507
git tree:       linux-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=14c6b4e8a00000
console output: https://syzkaller.appspot.com/x/log.txt?x=10c6b4e8a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=63cd766601c6c9fc
dashboard link: https://syzkaller.appspot.com/bug?extid=f14868630901fc6151d3
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10fcf758a00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1202ffa4a00000

Reported-by: syzbot+f14868630901fc6151d3@syzkaller.appspotmail.com
Fixes: e42940e8559c ("Merge remote-tracking branch 'rdma/for-next'")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
