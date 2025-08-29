Return-Path: <cgroups+bounces-9479-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FCCCB3BBBC
	for <lists+cgroups@lfdr.de>; Fri, 29 Aug 2025 14:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E3C3188EADC
	for <lists+cgroups@lfdr.de>; Fri, 29 Aug 2025 12:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB6D31AF01;
	Fri, 29 Aug 2025 12:52:34 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E581D61BB
	for <cgroups@vger.kernel.org>; Fri, 29 Aug 2025 12:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756471954; cv=none; b=As6vSluK2s/u25Dg2+ECvVdW01th2tyepwYDpjWkXRAxQAicAbSOo6YVzbMkJGfswoPbTmJl0p5tNEcimn6ohFdpffBZHJbQRvPMU4Zn0goiBfkvwGG3WdRUEBPqtHG/KFbJL5O5ZK5vgsnVaKWrtVE8MLeQTLo3rqQasj9Crto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756471954; c=relaxed/simple;
	bh=/qbUwsxB06qghuQc2GzfUZSKJ8iy0VOyR7N2gAreJsg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=dQhyo8875V3/lwIJa4Y54VMtVAO+msDLMcJWi3ommMp/+ELgN3sX1Rr2cKCMs/iRvyx3C+4r6VmTP0s/j1FHEyNDvsfmdjz2hbogoHNmE5VHP72Qk6K9Nj2oiLlPeo8AyI01kRYJK5YdfVakG1IbmzfLRpUhErS7KZbkUP3RDcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3f29a0a7643so6534745ab.2
        for <cgroups@vger.kernel.org>; Fri, 29 Aug 2025 05:52:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756471952; x=1757076752;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FVC6Z1Bfy5rCSHJEZH+Bw7ClURkPxPlN8Xea8cEX2Xs=;
        b=nV8HYxT3L5iCXzZEk2Mk0UM4S3TWiG75yOw8DO4YDFrGQOT1g9Vng2KKfABIjyo1M9
         bnyCLop5y2xxtlUsvFrhVgYZZI7evJ1LxuvUxRheXapQ5V4/Ic1grNTddCOlDVOSnxpp
         SWRo4Xx9Bsx8IkfjLrWo5H2ywLaQCWaEqCclucgusogKOJ4bygJKEvZI37iAYZUfJNQB
         g9ek5UbyRZThnOR/fd6nXyLGq0c+YYIEpXaTQwMP6b8rYdrlfYqFIWdqKaIiTnNDbWtH
         P/YCoOKwrvFakNEiS936vyDJYvf2svm7OI6K4PDYEoltNMwKmm0HeTTXX4QYBGbzBQv+
         hrhw==
X-Gm-Message-State: AOJu0YyvtFaxF/sQR5u9/MSc8N94cDb69bKIZOOfACXXKxFGK3T+IHy0
	UvCzSEEHg9f8Fg+rMVCsdTf2NJeBa+cdUlx5jCBrLiozEtlMbpiWjnV35FBSCwBLiTNCkEWEeSC
	pYnG0bqbzNsJkZ/VcLCAH4Hqu2mwcRX04f7o3/iMgbukCE+a7GL/Cw1xq+ow=
X-Google-Smtp-Source: AGHT+IHL6wQJMgblqkG2wDmm7fhnDSGUTWlZfzfi/aPZm/fMeAS0zUFvZjFC7REdMchpPSf9nIIhSxP9HJ0254xS7Q8G9Dv6FnC0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3803:b0:3f1:72c6:2c50 with SMTP id
 e9e14a558f8ab-3f172c62d17mr91163685ab.32.1756471951735; Fri, 29 Aug 2025
 05:52:31 -0700 (PDT)
Date: Fri, 29 Aug 2025 05:52:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68b1a28f.a00a0220.1337b0.0018.GAE@google.com>
Subject: [syzbot] Monthly cgroups report (Aug 2025)
From: syzbot <syzbot+list26a7aeaa369adf7a9a57@syzkaller.appspotmail.com>
To: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello cgroups maintainers/developers,

This is a 31-day syzbot report for the cgroups subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/cgroups

During the period, 2 new issues were detected and 1 were fixed.
In total, 9 issues are still open and 39 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 3949    Yes   possible deadlock in task_rq_lock
                  https://syzkaller.appspot.com/bug?extid=ca14b36a46a8c541b509
<2> 246     Yes   possible deadlock in console_flush_all (4)
                  https://syzkaller.appspot.com/bug?extid=d10e9d53059eb8aed654
<3> 105     No    WARNING in css_rstat_flush
                  https://syzkaller.appspot.com/bug?extid=7a605e85e5b5a7e4a5e3
<4> 69      No    BUG: unable to handle kernel paging request in percpu_ref_get_many (2)
                  https://syzkaller.appspot.com/bug?extid=3109abc43c8fcf15212b

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

