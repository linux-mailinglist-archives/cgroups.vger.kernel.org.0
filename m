Return-Path: <cgroups+bounces-8652-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3961DAEC7C6
	for <lists+cgroups@lfdr.de>; Sat, 28 Jun 2025 16:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C6F017C537
	for <lists+cgroups@lfdr.de>; Sat, 28 Jun 2025 14:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CAD5246BA4;
	Sat, 28 Jun 2025 14:44:30 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D83C13B5AE
	for <cgroups@vger.kernel.org>; Sat, 28 Jun 2025 14:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751121870; cv=none; b=GNPdW1kGV+ItvBOyAcaALcqFwKiMMKxyvqcPpkoFtTy9kkuZy/klBzy4734GkCRiBZYVLDEzjyOgjrHMr/KNP/0IV132QukPpEyr0/tunEN3S0OtKmC37a5FStDujmR3yT5wM96SnEOYgx1UYtv1AWMiW7DUeDcy9lTAIK6ib88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751121870; c=relaxed/simple;
	bh=LKKcI/g4wEGKKlALVyktoAsOdP8fNQaeNmSsEulzJrA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=LmgW1h/m9ednNQ+R+AVIs9iQewu7RsNdMYuGQZCJddnerybQj/y7b7XRuIM2p5mPezEg2Vy0f2LVY2IWUlH02DGzrqR6zF5hBJ0Zobl2biueyGEL53YHiuNCyPcsoj2FmRg1Howd7o/zv5I7w7jBqxVZU625hpyNLR+b0L8fw+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3ddd97c04f4so42540885ab.2
        for <cgroups@vger.kernel.org>; Sat, 28 Jun 2025 07:44:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751121868; x=1751726668;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fTzNunO4rfG0fdB04phZ0ETjFxrQY1IFOAPqwxnBfHg=;
        b=lpAL4U4L4pcSUGJbFW4KlfpSFUS4/BQWRNd8xvzcRAKDiTWWqESfzVhH1+83LWtdJi
         CzkRR9Sm10hDmSzxtqbAIQ5LYk4LNS+QoA1KxuR7qcaXhJxcMzEN6s1TZ7iWNtB0UtyX
         0lR9/nmpz3UduDvQusO6rQ/jXQEpVCIM6R2L/UVs91XJjYOe2zZ9Jm5Buxpr6XvWavVq
         khJxDPEN6PjNIXIUjYZJTy+AAJgcyXvuWYSiohF6qmBQnC/xCW4Aou54VGw0V/cKIHUq
         6vr+ZwsCypQeg7KEwj5ARoE4Sjx3OGHax0R/a7HS2ngiR3et+OL/R/ED3gInL5CSjFup
         X0Ew==
X-Gm-Message-State: AOJu0YwZZxlUQcPgZEZfNSMns1gc0n0Qxlqk77oihrzniWIKfeMNcCDH
	zEJOxk5cmqU/9nXUzlXap/cb4RuXPgdZdQxa46GI48yu7KcWbe19z7jL9a6yaO7jrcqmSxDv84O
	nBjFTnqfKKxj/sVlQXFZKP37zarzk3Nc8I9Tu/WflP6Ot4n/3MnIt6pfcTLs=
X-Google-Smtp-Source: AGHT+IFGNIUoyjIVkiQ/X1QGq48lDsVBwYiB/qjNy7sKa/EEiDX4c0THu7Y8I1BqGRan7zFFLrgLia40oBa+pVfBkKeCpdLmKANQ
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:4416:20b0:3df:5309:e962 with SMTP id
 e9e14a558f8ab-3df5309ec82mr37521915ab.19.1751121868218; Sat, 28 Jun 2025
 07:44:28 -0700 (PDT)
Date: Sat, 28 Jun 2025 07:44:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <685fffcc.a70a0220.2f4de1.000e.GAE@google.com>
Subject: [syzbot] Monthly cgroups report (Jun 2025)
From: syzbot <syzbot+listd2f490173279536fd88e@syzkaller.appspotmail.com>
To: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello cgroups maintainers/developers,

This is a 31-day syzbot report for the cgroups subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/cgroups

During the period, 3 new issues were detected and 0 were fixed.
In total, 10 issues are still open and 38 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 3931    Yes   possible deadlock in task_rq_lock
                  https://syzkaller.appspot.com/bug?extid=ca14b36a46a8c541b509
<2> 18      No    WARNING in css_rstat_flush
                  https://syzkaller.appspot.com/bug?extid=7a605e85e5b5a7e4a5e3
<3> 14      No    BUG: unable to handle kernel paging request in percpu_ref_get_many (2)
                  https://syzkaller.appspot.com/bug?extid=3109abc43c8fcf15212b
<4> 10      Yes   BUG: unable to handle kernel paging request in css_rstat_flush
                  https://syzkaller.appspot.com/bug?extid=36ca05bdc071f7ba8f75

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

