Return-Path: <cgroups+bounces-6247-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35790A1A49E
	for <lists+cgroups@lfdr.de>; Thu, 23 Jan 2025 14:03:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEBB63A58BE
	for <lists+cgroups@lfdr.de>; Thu, 23 Jan 2025 13:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F419E20F083;
	Thu, 23 Jan 2025 13:03:28 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF4A2010E1
	for <cgroups@vger.kernel.org>; Thu, 23 Jan 2025 13:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737637408; cv=none; b=h0MKrbJywRob4ipXJFrYESj2x+GHsSQQ8gHr7R77Y0XYyvkcDCK0Z14+Ibdh+gS8k6QUxdkYHnfuPF/xWHaQPluUKPTo/tp01JMfdmmFC00r/UgwLlMo96uWD7MVsIfKDCTO0NQDAuBns3MQsrlyNaITrKnzVoHRWeEu91F6QW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737637408; c=relaxed/simple;
	bh=xFrc0XGioDG8qsZT1FzbBNstEw/CWP35Z5b/gXbIRZ0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=cVzbyyrUIcPROZWdNUTBriUQvrXl7kqliMIdCqTQKUvoJPEQuvIi3XJBmwb9kjLKrfJ5SbPFCbCG60YpVed6Ncq6q0PBZ/j9YNon0tVHlZFcQRht+TgEpz8+wYAlW3fdlGd7YDSl01YP1okmNDEYZvG3iTuG7N+g0z01gMvVndE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a7e39b48a2so14499405ab.0
        for <cgroups@vger.kernel.org>; Thu, 23 Jan 2025 05:03:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737637406; x=1738242206;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fSa9JoQMqS9vbvFlWJ894QM5X2SN+b7DP7faQ6IUwtc=;
        b=oaT6SIsBzbig4dBPHBpSgg/UMzCKQMZKW34YPpOssdWRUK0wpVgV1B76Lu1mEUU8zG
         QN9v4Qt0VTj+KuVFhqvUyY1QYAllbtdJSnbHvqA4mzKL2w9CowbqcTc4OsjsDfE1xjSp
         GR0MXXtprpL5JCmiiCMXvScLC/XGZiyCyHyLwN+Xjj3Vf8xNI7TtF7hHpL7kvh1NDrUs
         D+H0+9ErUNchEHWMq81Q9gwdZtI1/4jDip0SEnMDJ6O+xdUY+PQx8j2n+iOLvZkJnFLY
         QQn7sq/do9qqa+sFDW6zAUCEkQCmP4gQJj7f1hvdmd4acFrfq+xtjZaYqTwtlqwaaVNi
         SQSg==
X-Gm-Message-State: AOJu0YwBaiw2eab9UemKMyLIEkYrncpU7vqqKfgLufj4dwOOcGnexJXm
	kk+jEk7IHRmOLqbmc++CqiAlSECYUWfTscDIQ0bU7bR6UKq2OAM06IwIxFvEn2h0QDaEXJYx840
	pzeUdK5uhh1UCEcw+DvUs4R1Pn/TpN+6ejWuwfZYo56XBvdxfUdbErpw=
X-Google-Smtp-Source: AGHT+IHuCC7sCrGhjOg3n47WIKQaxSCUAeUvUBDJSaBaZbcFEDsewFcmvtvyxBIyff1wmsxCQmJcKMFx3EnHuG5ZRSCL0ncgM+Oh
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1f84:b0:3cf:b26f:ff7c with SMTP id
 e9e14a558f8ab-3cfb2700234mr72100735ab.5.1737637406278; Thu, 23 Jan 2025
 05:03:26 -0800 (PST)
Date: Thu, 23 Jan 2025 05:03:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67923e1e.050a0220.2eae65.0007.GAE@google.com>
Subject: [syzbot] Monthly cgroups report (Jan 2025)
From: syzbot <syzbot+list3ab542a45f2fd1d6188c@syzkaller.appspotmail.com>
To: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello cgroups maintainers/developers,

This is a 31-day syzbot report for the cgroups subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/cgroups

During the period, 0 new issues were detected and 0 were fixed.
In total, 6 issues are still open and 38 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 3782    Yes   possible deadlock in console_flush_all (3)
                  https://syzkaller.appspot.com/bug?extid=18cfb7f63482af8641df
<2> 2295    Yes   possible deadlock in task_rq_lock
                  https://syzkaller.appspot.com/bug?extid=ca14b36a46a8c541b509
<3> 5       Yes   general protection fault in __cgroup_rstat_lock
                  https://syzkaller.appspot.com/bug?extid=31eb4d4e7d9bc1fc1312

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

