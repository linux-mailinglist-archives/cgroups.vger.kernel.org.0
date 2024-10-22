Return-Path: <cgroups+bounces-5178-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E69E19AA13A
	for <lists+cgroups@lfdr.de>; Tue, 22 Oct 2024 13:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B1741F2477C
	for <lists+cgroups@lfdr.de>; Tue, 22 Oct 2024 11:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A8619B5AC;
	Tue, 22 Oct 2024 11:38:35 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D529819AD86
	for <cgroups@vger.kernel.org>; Tue, 22 Oct 2024 11:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729597115; cv=none; b=r6B3jmURCkll1jLbcCXnjtT2jRwUca6O+SX6pcI0PCppNwBAdPx6VH374VUoL8pqQVEsHj/2PflzxxiMvFEZ1s+ctl6wxufGRX1H7wW2paHwIPwZMumPebaxPpsA800/HqQ8aS2OMLp8Q7GaDWuCioQwyZJfHQIPC9UG004lJJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729597115; c=relaxed/simple;
	bh=aLBckF07mkjO60Kkz61QCu2+ek57S2l8PjSQYDAI5ao=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=tkRPyknzX2Kl13v/c7mjiuQeDQo+IaT7InGUm3gH75FjT7tcbPhEKo72UHMWGvSToBOW0ab6e3/F24JKBo2KyYi53SCX2LNGvw6gCaX/BETOgRvJujZSZXgc8tdfUPbTOzOg8SFx5cQ5fCoqFS6REDbfnHCRCFEj6L5QPmzEcYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3b7129255so53502285ab.2
        for <cgroups@vger.kernel.org>; Tue, 22 Oct 2024 04:38:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729597113; x=1730201913;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ouSLg3Ywt/0X+H9vWv6sMqAnUnp/8br5o1Ob9ipfFN4=;
        b=Ak+lr2W8TdGhxeRCluhw7+geUq7GeyOlpcYXOKZDPj7G6FbQ4aK+L4XBjVkv6xCJHO
         N9x26MqcCvdmsBQyaOk8BhEbRj9ACtB+CWhHBihi/PXLcqUOKAz3NpHV4GYPPbfMwF0v
         r/etsgiOIBDN9IcA5u7vcvjAN7Ikt/jIS+yYcmVD0Ra5d80eCsOv5N4GFElURqdfrt4F
         701mSArKKafzr9/A72l8XqjteIkUGQvwsASHe2BKHYcEKxEqzoakxRFsKARssOmMjv0l
         vE1wWl49xJnK7j/lC2ayVCBmJhxySDht9sy/tBHPmI1LHbOgWdECoQKnIjK7a7FFC6B2
         h8gw==
X-Gm-Message-State: AOJu0Yx9a9qF3bwEQPSptmufnF3O0vD3C+tU58QIz87YDXHC4uHOcaBQ
	nbNd6Kngb7KPY1xMy9d/SsOq4GJqwMGdddiwGMiiokcU7y4hXhhsk6xOamA69VW6XdEzMQS3Ziq
	+wUPOfpqxnb6QXoT3oovbyO+r2hQv679Gj3FQXgcoxHHryZZMnn982tc=
X-Google-Smtp-Source: AGHT+IE3pkqG3W1GjwJfvFFXB+gff8e7Fh4t9+OSbjt329ZL6nPvFVEzDDUEErjXgMMmJaxUpGZAW97QKS6HSljIljBS85PjRzqc
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c248:0:b0:3a3:f95f:2dd with SMTP id
 e9e14a558f8ab-3a3f95f0594mr89939355ab.19.1729597112998; Tue, 22 Oct 2024
 04:38:32 -0700 (PDT)
Date: Tue, 22 Oct 2024 04:38:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67178eb8.050a0220.10f4f4.011b.GAE@google.com>
Subject: [syzbot] Monthly cgroups report (Oct 2024)
From: syzbot <syzbot+list3160ce3179308d795218@syzkaller.appspotmail.com>
To: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello cgroups maintainers/developers,

This is a 31-day syzbot report for the cgroups subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/cgroups

During the period, 0 new issues were detected and 0 were fixed.
In total, 6 issues are still open and 38 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 2627    Yes   possible deadlock in console_flush_all (3)
                  https://syzkaller.appspot.com/bug?extid=18cfb7f63482af8641df
<2> 998     Yes   possible deadlock in task_rq_lock
                  https://syzkaller.appspot.com/bug?extid=ca14b36a46a8c541b509
<3> 35      Yes   possible deadlock in console_lock_spinning_enable (5)
                  https://syzkaller.appspot.com/bug?extid=622acb507894a48b2ce9

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

