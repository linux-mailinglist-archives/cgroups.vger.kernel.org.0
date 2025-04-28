Return-Path: <cgroups+bounces-7865-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B3FA9EA16
	for <lists+cgroups@lfdr.de>; Mon, 28 Apr 2025 09:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1FB718952BD
	for <lists+cgroups@lfdr.de>; Mon, 28 Apr 2025 07:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9B92376E4;
	Mon, 28 Apr 2025 07:54:32 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6742356C6
	for <cgroups@vger.kernel.org>; Mon, 28 Apr 2025 07:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745826872; cv=none; b=YUxyJP+w/MVjyALTEdVsEItZb0LkNKZK2TKlW4y19dtyLF/R52IhBA2f/R3zgRfqqQOR+UIATWLGSPWmGxmfDHyA1FbYtlcfWBgxtJ5oX78WkQvfOT7nyHGsa9LRSLXBzDV1aDgf99iwl9eh2R9tfP3M3hS3u3mLTL+sUgorOnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745826872; c=relaxed/simple;
	bh=51AoXsXVp7yiHR185Rby8tv3yG4dzn89op8/N9TGwsg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Xfn3Inpx3JjGEw+QdNqzAMfG5SfdOIMrvrb5AZIf/LN6sXsXGcoSun9bxg8IjzH0uHkcVSOcbj+CjveiiPUpASn03aFLa7w2cegtWpL6CaRUBGVTNQFBXraGH7Bof1qtnmrQIf7m4d1rsp4t0CfU7c2T2oYs6YGcjXN5MNISo+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-85e4f920dacso338234739f.2
        for <cgroups@vger.kernel.org>; Mon, 28 Apr 2025 00:54:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745826870; x=1746431670;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B3mQV4GgW9ucfCGH5ohcvWSs8E4D8ePWgUerNiBqhAs=;
        b=gmFLpf5SfLILeNAg2u7S6v2UIsQq/VP4CubveI3hxAEpqkb856tquknTwR9ALpyen9
         SvOPxkqkK/7qvxn4oGBNPavZBUMDfD/LTPwLUQZxC1GjLghCbAb0f69RvHNGMoN8MNrD
         V3YQRExkMpsQSORgdqIM/LPJgQwF8JPSMzF/21vMN4s8Y8q/oAEpfxLubGpIZqtuhOE4
         TiOqK67hsGOWPRzuPvRC7iUjtHh8LengwLSvDPFFtpIX5QUVcQsbdaef68sEmon1d5O+
         msxFaQxx9HvHN/4ayCUWzGS2DGfcakUthr6UbXjq+i1cAWtrLYybSEqKIahxQNdb6i3H
         npjw==
X-Gm-Message-State: AOJu0YyZn/E9Uyq2HPKj9bsvYN/igrhibJ5PZ8R27dnRHkHzy1snKV50
	5PXchA45/BrzDy28zIdAjK/SZcki+jRyywT9WdyZCcRgmTbhz3cCI+LTNo3puJ9I2RxecTPvWGp
	FuYq2MXV42iQftel3tYI0xFH+pHW/RSZp4JZOtDZtiQcROheYs09wDfw=
X-Google-Smtp-Source: AGHT+IHVAcxNFeITuhMUgOArHuMxEJhyad2kWanyw0wZTdzwPho1YpgTg1bCztAQ38J2oogBJ7vXZxoDWmE/Pz9gyxGF71xsm6aR
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:26ca:b0:861:7237:9021 with SMTP id
 ca18e2360f4ac-8645cc87ae0mr1163470439f.3.1745826870203; Mon, 28 Apr 2025
 00:54:30 -0700 (PDT)
Date: Mon, 28 Apr 2025 00:54:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <680f3436.a70a0220.23e4d2.002d.GAE@google.com>
Subject: [syzbot] Monthly cgroups report (Apr 2025)
From: syzbot <syzbot+listd6e9f2d108f77c2e22b7@syzkaller.appspotmail.com>
To: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello cgroups maintainers/developers,

This is a 31-day syzbot report for the cgroups subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/cgroups

During the period, 0 new issues were detected and 0 were fixed.
In total, 8 issues are still open and 38 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 4982    Yes   possible deadlock in console_flush_all (3)
                  https://syzkaller.appspot.com/bug?extid=18cfb7f63482af8641df
<2> 3902    Yes   possible deadlock in task_rq_lock
                  https://syzkaller.appspot.com/bug?extid=ca14b36a46a8c541b509
<3> 838     Yes   possible deadlock in console_lock_spinning_enable (5)
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

