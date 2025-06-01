Return-Path: <cgroups+bounces-8406-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D33AAC9F59
	for <lists+cgroups@lfdr.de>; Sun,  1 Jun 2025 18:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75632174BCE
	for <lists+cgroups@lfdr.de>; Sun,  1 Jun 2025 16:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5961DAC92;
	Sun,  1 Jun 2025 16:21:05 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6F03FBA7
	for <cgroups@vger.kernel.org>; Sun,  1 Jun 2025 16:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748794865; cv=none; b=AgBSpLKgkSzR7gOGuyqcZRl1Hk8yyW2jZfZEFTUzQK9srK43Dw+xv3fptEyNE9iLWbuPbfsF8weqOOsiO6W+aPb3n8hGEoPQglkbXOWjacdg7DagOfo9ffiWSjBRDUWA6gpZg5Fof3I6MxPMNKz3XwfRbIC5sXdBB7R410cGI1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748794865; c=relaxed/simple;
	bh=h6QoMpVGGZVy60Ef1tMLb7Ks9v3/ZkdGVQ1zpckE/E8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=jpY4TyxYNAmYfr/tIeDUGvL+m8iC8XfkqvoGfHW6fBB3/eSWGNBgyw5fOa3MFpKfpfBhCMxTGeRGkj05B02am1zHuH+/Ry1HAW0XmsUvvU5HfS710o5befrd/j9CXg7z5OHN7LZ3XfOnHTzRBc7++C3cIKOtj1O+3cNj85B+hrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-86d126eabcbso202125639f.3
        for <cgroups@vger.kernel.org>; Sun, 01 Jun 2025 09:21:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748794862; x=1749399662;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BxRCzM24gglLIr7E2yldOZZAcHs1wVBwC6JZOlmfhD8=;
        b=rkyDzEpw3Mnah5H5gQsHqkY00bCMmuJPt1klAaVtKz1FG6hwnZPPpWWm8p+FOiMLuE
         237qXIbNDbdDdskLJDTrrsWhIuMBge0ULlMdz94NBVMpGmZlu6RFzJU5Y5zSu/ty6oqz
         lTvQxzXLGg9WxGHQioy9EEhvSBBm+r3YwRLt6GHvJJQvDCJPfyn+lTaaVS7viUetTv1p
         9Z38TwfL/2GatORBgs5cJ18rUl1zoOZD3WmRxaduA4WUnFLNwdv12mYjFU6/DwftLVnZ
         Fc92VPRK+4rwpTxMgiGoWRoTZCQGM1OWaS0Ky6ODonbupEIJa4N1WNR09fBpfkpPlsDX
         iiPg==
X-Forwarded-Encrypted: i=1; AJvYcCX34tKoube4OziO1buHRo+f4Rwsrf06r+wj2tkP7aHdL0T6TSIov0hucdzRuVV+co1W+lYFeDN+@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/WB+/75Axg0tNdA0cCno+KnauSo/6cVzKSTtjbEW2iEE6H6Bd
	pqovjYuLlLmHoBLSCvZssPp5Ky3abyjiiRm+LMNV9SUgBtizsl7UISnSKtBwj2KKH5d/KmjmAL0
	hiVU+QqOmlRG+nK2tlDAYIhju8ZKKF+v+zygk5dpJSSS19mPlCR7hiK0Ku54=
X-Google-Smtp-Source: AGHT+IE6dM+Sri1ig2zWdcwsj1cdNpnH6D5Ew7GCODMXRc5foiZExQDqXF9qiWibFIJGCE3VMwNQPSukaY5jbkheuww0vE49Df77
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aa6:b0:3ce:8ed9:ca94 with SMTP id
 e9e14a558f8ab-3dd99c2898cmr107808385ab.14.1748794862401; Sun, 01 Jun 2025
 09:21:02 -0700 (PDT)
Date: Sun, 01 Jun 2025 09:21:02 -0700
In-Reply-To: <6751e769.050a0220.b4160.01df.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <683c7dee.a00a0220.d8eae.0032.GAE@google.com>
Subject: Re: [syzbot] [cgroups?] general protection fault in __cgroup_rstat_lock
From: syzbot <syzbot+31eb4d4e7d9bc1fc1312@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, andrii@kernel.org, ast@kernel.org, 
	axboe@kernel.dk, bpf@vger.kernel.org, cgroups@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, hannes@cmpxchg.org, 
	haoluo@google.com, hawk@kernel.org, inwardvessel@gmail.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, josef@toxicpanda.com, 
	kpsingh@kernel.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, martin.lau@linux.dev, 
	mhocko@kernel.org, mkoutny@suse.com, muchun.song@linux.dev, mykolal@fb.com, 
	netdev@vger.kernel.org, roman.gushchin@linux.dev, sdf@fomichev.me, 
	shakeel.butt@linux.dev, shuah@kernel.org, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, tj@kernel.org, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit a97915559f5c5ff1972d678b94fd460c72a3b5f2
Author: JP Kobryn <inwardvessel@gmail.com>
Date:   Fri Apr 4 01:10:48 2025 +0000

    cgroup: change rstat function signatures from cgroup-based to css-based

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12ca4c82580000
start commit:   932fc2f19b74 Merge branch 'irq-save-restore'
git tree:       bpf-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=50c7a61469ce77e7
dashboard link: https://syzkaller.appspot.com/bug?extid=31eb4d4e7d9bc1fc1312
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=161cdfc0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12dfc8df980000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: cgroup: change rstat function signatures from cgroup-based to css-based

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

