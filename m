Return-Path: <cgroups+bounces-12036-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AA127C62CC2
	for <lists+cgroups@lfdr.de>; Mon, 17 Nov 2025 08:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 644AD4E4BDB
	for <lists+cgroups@lfdr.de>; Mon, 17 Nov 2025 07:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717EA31B12D;
	Mon, 17 Nov 2025 07:50:31 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F6431328D
	for <cgroups@vger.kernel.org>; Mon, 17 Nov 2025 07:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763365831; cv=none; b=KdizW7ARfS8XSTM8c2K0ma5gxw9S2YpMVQKcNoNXKUDV1irnsEMzIp3WSEvIHTATB8GEtkckVZjG7CsVvvIkygf1ydxBq1INvMNKsjxXVbs3760JDuAPZsS+6QgE8id6xjOEagzfXzVWb2GYpa5jbo3yv+qrYajIw6O87wXJ+eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763365831; c=relaxed/simple;
	bh=+sd0KnnNQ2cwZxw9eCcANa1tTRuCo10+Y+yiT4SGSb0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=f3uI9UX8b+oDpC/21E7JWdpvqqKfZdrZg3afmk8aRuH6ktMRd1PcLWsAuR0lYtV1aGMBu5e5WK8FrhNiCj8M2Jit6r2YmTVDbFk1hKLaivTLMOmGHo4VxJ6hpnJEqfKbdyu2b+pR18eSE31JpD7JwsdkMgKregdzwEiPEJc+UMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-9486920a552so1080060039f.3
        for <cgroups@vger.kernel.org>; Sun, 16 Nov 2025 23:50:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763365828; x=1763970628;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ooRTuhsEORDSL3frIEoQULvRD+/K+BkQObWppYxa3Zw=;
        b=nM1csffjfoQbO7n4N2/25hWXvo7hhrcJbEHCRccvJIuYQw1kZagwseuZIjDhcazwX1
         8Sci+z4QGwAAEBzYSR/kTKqL3QeKsrQIDzrqZKCPxIp22j7FCLjfYSoO2YhQ/90Na88P
         0lCIsHSLiXPTioR0ObI2d/fPpaFOV16FLcyEQptBWTl84jjd4+klV/6vfDeDYFzfpJ/2
         sTvF+GnfOjf4PC1XuJno72vzb4JGigxt6hAaMtIxNwPKp736G0ApeJ9RXMCywpHHscms
         1bOA2oarb58jII8kqhbpNmOwkUV/BK8kxQXYf7kPGAQi8MiK02NUvlc4HyfzxTBLIDgN
         /xbQ==
X-Gm-Message-State: AOJu0Yy8XIkwkMD8UAOiEUQlsNkGOQfBxkDDn28ACKAihjmhTPnKKh7c
	XTfyj8vyxTrzZ07ociXGkliFr2O61D9pYTf2xP65gD8Y+kF7jL7Ap/3HuWihZYNgSGIZ2G0B1Iy
	G5hyc/dHaU8VIB4XqJfRNeHJi4E4YOU8ikOQIyOy/9vVKz4jfRMxZbKleg7g=
X-Google-Smtp-Source: AGHT+IGrmyxzAfcp5MeX9GJZpl5rm5ZA6juxq4lTRywNf22rjfibV4wm8Ljtfh4PX3mEU1/o/BuNAfqudDfX/S0PYW5WrjEkx42i
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:23c1:b0:434:96ea:ff6a with SMTP id
 e9e14a558f8ab-43496eb00a5mr106422575ab.35.1763365828594; Sun, 16 Nov 2025
 23:50:28 -0800 (PST)
Date: Sun, 16 Nov 2025 23:50:28 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <691ad3c4.a70a0220.f6df1.0006.GAE@google.com>
Subject: [syzbot] Monthly cgroups report (Nov 2025)
From: syzbot <syzbot+list1e50ec37c611885fc7fd@syzkaller.appspotmail.com>
To: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello cgroups maintainers/developers,

This is a 31-day syzbot report for the cgroups subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/cgroups

During the period, 2 new issues were detected and 0 were fixed.
In total, 8 issues are still open and 40 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 3971    Yes   possible deadlock in task_rq_lock
                  https://syzkaller.appspot.com/bug?extid=ca14b36a46a8c541b509
<2> 876     Yes   possible deadlock in console_flush_all (4)
                  https://syzkaller.appspot.com/bug?extid=d10e9d53059eb8aed654
<3> 1       No    WARNING in cgroup_file_release
                  https://syzkaller.appspot.com/bug?extid=da9171e60819297fc1d3

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

