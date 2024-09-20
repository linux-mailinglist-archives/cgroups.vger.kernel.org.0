Return-Path: <cgroups+bounces-4924-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A929297DAA5
	for <lists+cgroups@lfdr.de>; Sat, 21 Sep 2024 00:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C899282D23
	for <lists+cgroups@lfdr.de>; Fri, 20 Sep 2024 22:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFCDA18D65F;
	Fri, 20 Sep 2024 22:45:22 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4944C187325
	for <cgroups@vger.kernel.org>; Fri, 20 Sep 2024 22:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726872322; cv=none; b=XnSw0ArbIt4M2EDtGY6Zu1HmHuvvmc1RCEuY/kE3a6rmHoFWr5n1ILV4dWahlYt3/y8idSvETyIt75SnAtYO88V1NYjXnnq4VeW2nHZnUCPScQ/eKHcsyupbhkb9c1rOxU0wi7QORkYm+vEbMf2ZSU/AAJGNrjOSNQnTmim+GPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726872322; c=relaxed/simple;
	bh=eta5Fc9Y+6a/5oMPLsomajKDvYS1cKOPfTjY1UsPG6A=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=mkXgRquXH9Wcsp195yBoTdbFeZr/G05riiaKAWjs+pNGUmpnjIc2KhT6878Lp034+R7wMvVRD0q8aJZGFO90X/oBGRlIFUNkayzXxXfxPrL5Rp/ja/v7SC/TSVhTj3xDaX+bn6pD/0LgxgnIc9SOGpHh48fcHikMRn4KmhDNk8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a0ce8cf657so7956655ab.1
        for <cgroups@vger.kernel.org>; Fri, 20 Sep 2024 15:45:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726872320; x=1727477120;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=joh3pehkJFQ/sQ2EiiPr8j4k+Jc50WReW9rhSgTJIrs=;
        b=XgHSF1TtWqkJ9xJ+/Nz2mFjrOrEzioKUeJmwMmtEynKytGnFLh/BejgNCrVrmFLgT3
         zk1XL3D9sv3T1J7oPbbf+lvPmBCexjqiTueRWVqAepYN/ngglAEG1bX9uMH9VwIMm2da
         u3AZbjyujBNvUpX5SnMUZk2lcJjDTPTafIvtAJY3uhDlPj9V7fMJ7w4bT8LgkRhWy4Ls
         e1DJishh8ejIip7MhGeql5uizrCr0FAx4rTcioNRhBH5YbxBdrzOuyeURFuwXJhLbYPb
         F9Z1+eH+d57pc37dzAV3d2jWhK4BRnuF0J4MceYTsIoedM+AUQ66MKtgvG3zPDmeCJRo
         H+hw==
X-Gm-Message-State: AOJu0Yw+1F5uOxob7HgqXJi5QjaR7wni98+ad+sPh6GDaI3FFN+MqGaK
	1ZIEDyIn8cRPGDsxBzk7NJNp8kDtRC57cgpALpfbJdpAXs88AubXEmbLnPahBt7PIcdUePKYNhp
	U+nc2m8NalKQKtuWq0UcLb8ucf+XwYCden9rtRX+Fm6S0JBFUr7cnhEw=
X-Google-Smtp-Source: AGHT+IGsinVff1sLKMdNLDGhsqC03PzSGBwOSCgbfPCA79JmMGWFm/j+SeqrDrSI6ffXqOtgugebWHvl+pcWMvg+l9jc5FsoxQSx
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c26e:0:b0:3a0:a71b:75ee with SMTP id
 e9e14a558f8ab-3a0c8d13104mr47938005ab.19.1726872320312; Fri, 20 Sep 2024
 15:45:20 -0700 (PDT)
Date: Fri, 20 Sep 2024 15:45:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66edfb00.050a0220.3195df.0019.GAE@google.com>
Subject: [syzbot] Monthly cgroups report (Sep 2024)
From: syzbot <syzbot+list888f35116218f9d000a7@syzkaller.appspotmail.com>
To: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello cgroups maintainers/developers,

This is a 31-day syzbot report for the cgroups subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/cgroups

During the period, 2 new issues were detected and 0 were fixed.
In total, 7 issues are still open and 37 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 776     Yes   possible deadlock in task_rq_lock
                  https://syzkaller.appspot.com/bug?extid=ca14b36a46a8c541b509
<2> 4       No    possible deadlock in obj_cgroup_charge
                  https://syzkaller.appspot.com/bug?extid=57765728d598e67e505a
<3> 1       No    possible deadlock in refill_stock
                  https://syzkaller.appspot.com/bug?extid=dfd0410e573d2afac470

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

