Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E213D35723
	for <lists+cgroups@lfdr.de>; Wed,  5 Jun 2019 08:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbfFEGrC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 5 Jun 2019 02:47:02 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:34221 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbfFEGrB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 5 Jun 2019 02:47:01 -0400
Received: by mail-io1-f70.google.com with SMTP id m1so18372347iop.1
        for <cgroups@vger.kernel.org>; Tue, 04 Jun 2019 23:47:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=0DTPebv5NG8S97eb6NYfGtH6s2XhZbJcgpOSN9G3WRc=;
        b=oDO2sw6g6TheLEJ38IkYS5Ihh3d507IrplTu1sQ22hhQeLKY1/NS2G9jPfiootUotE
         wg721wQh4lbKt77juDRMwqdnYGedbHQkLZA8KXyLVuc9oHHlNXQoiH5i8WN4lqIf4Tho
         AbCXdpfUIlHZGm6AoCH+SOvDTBERIioQ0HoOE2aoUiTw2Pzy/jMyKVS/VCt2POpAJhtr
         iZkZDLipMrhkQvKm2wgVc0SaPeum5iRhCo4YQadCOISMu1X6mMdTaVKkPZY9dDx9cFMi
         kJKHKn+M6IjkQCRUSkfsmXw/cXF1WiAAnRNhy9O/nTE9W7GXNPEEqbmZ1iUQrIFcrJQO
         cz5w==
X-Gm-Message-State: APjAAAVk27jJKEgvc11kIiT7guB0NyYI58fLb0L7f1qc/5dUHuXQTv5V
        XZmBGNbZ9gJXRSKUuv3dVERRloEhUsE520egtc7Ro/X1WEUR
X-Google-Smtp-Source: APXvYqxcRwKznu5s/WF30ioOt1OAX+adyD0fCRP3X69hk9R87NnszpPYpCAzlAXH7mBu0a2hct/HG73f5mTEx1ANoDYrvg/aI0Iv
MIME-Version: 1.0
X-Received: by 2002:a24:2b8f:: with SMTP id h137mr7710740ita.162.1559717221001;
 Tue, 04 Jun 2019 23:47:01 -0700 (PDT)
Date:   Tue, 04 Jun 2019 23:47:00 -0700
In-Reply-To: <00000000000097025d058a7fd785@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e878a9058a8df684@google.com>
Subject: Re: KASAN: slab-out-of-bounds Read in css_task_iter_advance
From:   syzbot <syzbot+9343b7623bc03dc680c1@syzkaller.appspotmail.com>
To:     ast@kernel.org, bpf@vger.kernel.org, cgroups@vger.kernel.org,
        daniel@iogearbox.net, hannes@cmpxchg.org, kafai@fb.com,
        linux-kernel@vger.kernel.org, lizefan@huawei.com,
        netdev@vger.kernel.org, oleg@redhat.com, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, tj@kernel.org, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

syzbot has bisected this bug to:

commit b636fd38dc40113f853337a7d2a6885ad23b8811
Author: Tejun Heo <tj@kernel.org>
Date:   Fri May 31 17:38:58 2019 +0000

     cgroup: Implement css_task_iter_skip()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1256fcd2a00000
start commit:   56b697c6 Add linux-next specific files for 20190604
git tree:       linux-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1156fcd2a00000
console output: https://syzkaller.appspot.com/x/log.txt?x=1656fcd2a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4248d6bc70076f7d
dashboard link: https://syzkaller.appspot.com/bug?extid=9343b7623bc03dc680c1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=102ab292a00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15f0e27ca00000

Reported-by: syzbot+9343b7623bc03dc680c1@syzkaller.appspotmail.com
Fixes: b636fd38dc40 ("cgroup: Implement css_task_iter_skip()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
