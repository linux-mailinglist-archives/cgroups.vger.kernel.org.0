Return-Path: <cgroups+bounces-461-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B60C7EEAAB
	for <lists+cgroups@lfdr.de>; Fri, 17 Nov 2023 02:25:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD04E1C20829
	for <lists+cgroups@lfdr.de>; Fri, 17 Nov 2023 01:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC555137E;
	Fri, 17 Nov 2023 01:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091A0129
	for <cgroups@vger.kernel.org>; Thu, 16 Nov 2023 17:25:06 -0800 (PST)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1ce5d31e709so3857955ad.3
        for <cgroups@vger.kernel.org>; Thu, 16 Nov 2023 17:25:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700184305; x=1700789105;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RJo6nMVJndBB899kUvGypW1akG0rhdJo5ej1y6RnVs8=;
        b=rzGGeT0pVBxgHoCavI2dDdWbk6hdpschqjvRE41yXjJSeEizmqzNj1zXPsVzMiVtd2
         ZzlN5/4Ypjweu7ixXl/8V7tAtDuGnCFaOX61HiPcV3/IxS8kXu4yDMydYdM69rl03Ymd
         d2vatzaK0m/qblEwvK5y5dXIkiS72UHY7FQ7mqETNBpjk1e4AgcmsmO1XevjI2Ux5x7y
         c0xsRR/lENmZU2A5b1zDjhEDP54JusSPVDNblqtcno6y4GZB2DIb+K4jH2e6eKBYc5zr
         olFYCk9w3dp1nBKl3UnD4YCvamYdxdkaAj/a/RuiYMUrKCHbP4rD6TaggfUICIBmyw5U
         lhlA==
X-Gm-Message-State: AOJu0YzN+iMjsvLHi4VBXptuo6CrPnDXs2V8G0T7gyfP3SFe7ZsFxzP7
	kY4HT9e0K5EFcM/pXDvVmguGZzzRN3hEde7UzKnIoRfl+Pu8
X-Google-Smtp-Source: AGHT+IEZQ7oXyxiWxmK+3mMIwuVi6kepyoGWFMrMJQaY2uJPqBt2+V4JzH085Nym1mQ8E5BzfIOpvnSSsyjKyBqYg+qJJuLDlN0A
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a17:903:2681:b0:1ce:1892:2fb1 with SMTP id
 jf1-20020a170903268100b001ce18922fb1mr2611444plb.0.1700184305580; Thu, 16 Nov
 2023 17:25:05 -0800 (PST)
Date: Thu, 16 Nov 2023 17:25:05 -0800
In-Reply-To: <000000000000f5b0d0060a430995@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009642b4060a4f017f@google.com>
Subject: Re: [syzbot] [cgroups?] possible deadlock in cgroup_free
From: syzbot <syzbot+cef555184e66963dabc2@syzkaller.appspotmail.com>
To: boqun.feng@gmail.com, brauner@kernel.org, cgroups@vger.kernel.org, 
	hannes@cmpxchg.org, linux-kernel@vger.kernel.org, lizefan.x@bytedance.com, 
	longman@redhat.com, michael.christie@oracle.com, mingo@redhat.com, 
	mst@redhat.com, oleg@redhat.com, peterz@infradead.org, 
	syzkaller-bugs@googlegroups.com, tj@kernel.org, wander@redhat.com, 
	will@kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 2d25a889601d2fbc87ec79b30ea315820f874b78
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Sun Sep 17 11:24:21 2023 +0000

    ptrace: Convert ptrace_attach() to use lock guards

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=130edb3f680000
start commit:   f31817cbcf48 Add linux-next specific files for 20231116
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=108edb3f680000
console output: https://syzkaller.appspot.com/x/log.txt?x=170edb3f680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f59345f1d0a928c
dashboard link: https://syzkaller.appspot.com/bug?extid=cef555184e66963dabc2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13fd7920e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17d80920e80000

Reported-by: syzbot+cef555184e66963dabc2@syzkaller.appspotmail.com
Fixes: 2d25a889601d ("ptrace: Convert ptrace_attach() to use lock guards")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

