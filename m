Return-Path: <cgroups+bounces-4537-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD0F961D07
	for <lists+cgroups@lfdr.de>; Wed, 28 Aug 2024 05:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A38421C211C6
	for <lists+cgroups@lfdr.de>; Wed, 28 Aug 2024 03:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC01C143C63;
	Wed, 28 Aug 2024 03:31:05 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB6714287
	for <cgroups@vger.kernel.org>; Wed, 28 Aug 2024 03:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724815865; cv=none; b=TXY2RjwEtDBZBsm1/j+7OrdThOIbbrDd0iYTlGi8MmqVoz+LFMOmFf93+dOHiwrnd9FGdNrzvDWgPx43pTVmiLr/BR9M7nrd7FyTKyuU1yYkZKy4xlU3S38UR8d/a6zOpypFD7HB1T6qLvC4g6y4DF5nHFQCFYH/0mWdTGn5RBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724815865; c=relaxed/simple;
	bh=rGfTbjB/IrseFEx3IwAHyLUhBJHgnuEKuPFplJBEDm8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Xmm0GjgICZHDGVutnDnSZcUiQy1SE6xoNwRvxu90aQ5XAF7pPBteLCQH26YeZORzmMAjnjFQ7QzGJDClLle7vPl2ICLfd/QzrDhIFEJolv26qFnHzEg5bCo9+OcZoFnXQMaVGfdsmW+XqzA/a5sOYvYovzCeYHIXd4F2jp8159I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-81f8edd7370so732951739f.1
        for <cgroups@vger.kernel.org>; Tue, 27 Aug 2024 20:31:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724815862; x=1725420662;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vu5uJIf/8g8dj3Yf1bX3ohQRMUDAmS7B1nSWGrngtyA=;
        b=w6z6a50Wq/YABSVcacsBG4KsmylrPuQ/gf73T4nd+WnZGwC+rgtxkUnwbkjMYLkYLZ
         VSrqzNWcnj25H8qcOBMnHybLyP6ph/AzAlzvuG5xLXtD/rU/V0qT4LGDg1qDD1ermCBI
         DttFLu6Ej31b0eK/1ZEMtLemqqJ8FEw44HzancIKdmFitr4eRUswoJLueiCncqo4uvWR
         Z0QGFuv4V6jBqLwo02bwhZADdm2CANrV04QS8feRLyHHFatQmXm5mDYUbdA8fQD6MUU5
         aH2QkVTjiWARz90G+V3GJ0epzxGDxYPeFsAv4GhAv1h78l8tV0AU5IcYQ5nJoIYwGTwQ
         x9ag==
X-Forwarded-Encrypted: i=1; AJvYcCXdrZs3VNjqO+f+9vqYCTedwtbzxQ+0suz8eJI2d2NiItK0UrfAn3UH4wF3QiFRtV7LfIx18bFG@vger.kernel.org
X-Gm-Message-State: AOJu0YxY5SFeR7MxO9WOwaZtQFhjifyYawCFQSuJtBQMq2wPPXeKbmaF
	SUKSVHDm60CB7sTcHuCHL2UU/G265Fc0IBleHGza1pz+MyuBya1BuW3bWRFEbtyizD5jN5YG7bD
	mYaXQuJuEQrka+lae4MYwN0V/LxY2+cUN00iPh6lk984gg7RK/BBo9wE=
X-Google-Smtp-Source: AGHT+IEq8u5/q/T/KHaia+Jqn7A0HsIJt8R9RZERwYw9F9VvKOGMfK5bKs62RG9i16fQQ3jpz+ESgjyw7fdzdoTzuweYCtivkz/x
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:7306:b0:4bd:4861:d7f8 with SMTP id
 8926c6da1cb9f-4cec4f922cbmr24918173.4.1724815862301; Tue, 27 Aug 2024
 20:31:02 -0700 (PDT)
Date: Tue, 27 Aug 2024 20:31:02 -0700
In-Reply-To: <00000000000041df050616f6ba4e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c69eb60620b5fc4b@google.com>
Subject: Re: [syzbot] [mm?] possible deadlock in __mmap_lock_do_trace_start_locking
From: syzbot <syzbot+6ff90931779bcdfc840c@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, axelrasmussen@google.com, 
	cgroups@vger.kernel.org, hannes@cmpxchg.org, hawk@kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, lizefan.x@bytedance.com, 
	longman@redhat.com, mathieu.desnoyers@efficios.com, mhiramat@kernel.org, 
	netdev@vger.kernel.org, penguin-kernel@I-love.SAKURA.ne.jp, 
	penguin-kernel@i-love.sakura.ne.jp, rostedt@goodmis.org, 
	syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 7d6be67cfdd4a53cea7147313ca13c531e3a470f
Author: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date:   Fri Jun 21 01:08:41 2024 +0000

    mm: mmap_lock: replace get_memcg_path_buf() with on-stack buffer

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1412f697980000
start commit:   36534d3c5453 tcp: use signed arithmetic in tcp_rtx_probe0_..
git tree:       bpf
kernel config:  https://syzkaller.appspot.com/x/.config?x=333ebe38d43c42e2
dashboard link: https://syzkaller.appspot.com/bug?extid=6ff90931779bcdfc840c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1585acfa980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17bdb7ee980000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: mm: mmap_lock: replace get_memcg_path_buf() with on-stack buffer

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

