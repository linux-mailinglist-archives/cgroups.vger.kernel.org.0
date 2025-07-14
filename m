Return-Path: <cgroups+bounces-8730-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C39C6B04C74
	for <lists+cgroups@lfdr.de>; Tue, 15 Jul 2025 01:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 211194A69AF
	for <lists+cgroups@lfdr.de>; Mon, 14 Jul 2025 23:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACCCF279785;
	Mon, 14 Jul 2025 23:39:05 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7E922F76E
	for <cgroups@vger.kernel.org>; Mon, 14 Jul 2025 23:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752536345; cv=none; b=K521ZjZO6c03gChxyXtWBuTpqt1MHH7e/zLr4l1RCptdaZT6TTf3ZgMgc/Fd6su3mxIOURghu8xw0sRP69dLALYaLJuDu0ai72guUmVoybhee89s07f1BXbrAcxqhS7BmyRWJbIyDg3IRDxXp//JdUgCDfwx4iFfiq0eDcpwCJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752536345; c=relaxed/simple;
	bh=JA7JIyohv6KpJIi6c3GqiTQVtKiGdSnXxxLH47r7J40=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=n76hKpZGayAhrFdWUJqXuxqCVr5WlTPAHbqnqL9iiK4tJzo95AL1d95e6ltukPDf7+1zjBa4hXKjTlQeQtKBrU7rropBB/CiAGJIrGtHU+ck4f/MhsO6DNStJrerbPhHXTcWQPOQgLmn+8gaJ6URVQ9ybg075uXoTYqZ+v7+syA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-875bd5522e9so452300539f.2
        for <cgroups@vger.kernel.org>; Mon, 14 Jul 2025 16:39:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752536343; x=1753141143;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s/pz0JPSLrwcXULwEX8WsSET6ZklGL5HqsXo8ZbZ+FI=;
        b=R51IT42Ruaw9IU0kEEhgIh8U5C5O+3l6tuIRRQhKGznIg8ZVDzHEE65KeHptggZhoU
         mh+STjRlmGz1Svchxq6PuxH10nQs69O1KH8yf4WgWYBK40JmURIM4/gtnqF7V0RD/nIO
         WCgMtUT/DUPZ6rjAxQqZsWFgney/pFsAnqUBHmbDgY35d5ilaBp1EiKbPMhXhyoXOa1N
         59CXMwCooD6wiiAsUy+lMRCKa0zx9IxHYDcaw9ImL2hCctsuR6s0hFfMGrLhUoi6N+le
         6NIWClidm2nQtSe7LTNfTWSqv85wFJqLy0QOsLX+CGfk/8kf3At+sWgMxwi7G3i89rsB
         fBew==
X-Gm-Message-State: AOJu0YzR14RJJ6M2C3EhvIHPpNwFID4wBzOJRrE2FGCF9dbSFop64yFu
	32ZfY+PtpFCr9fLU1EIRtFkXv/b06rFXxaYM9WJaop1YLRCvkQT+WJTsPTRA1h5Ol+rsxMnoR7p
	Ggmq/wp/CdxGLkRK3kBCaXD3acBjs/IwYb5lyQYo1MMkwfGdACx0swDCc5fY=
X-Google-Smtp-Source: AGHT+IHNPx8IATVQPVtElxwALygbQqQ0jiz1LbPETazjmI4hxou9gdLHNtXOyxwUb9iJ/3mq1wLYBv977x2xRxgNM7Tfid9P98bc
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:7402:b0:873:35c8:16f9 with SMTP id
 ca18e2360f4ac-8797882781amr1362237939f.8.1752536343204; Mon, 14 Jul 2025
 16:39:03 -0700 (PDT)
Date: Mon, 14 Jul 2025 16:39:03 -0700
In-Reply-To: <9008807c-58c6-4b2d-b227-545882436ec6@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68759517.a70a0220.18f9d4.0010.GAE@google.com>
Subject: Re: [syzbot] [cgroups?] WARNING in css_rstat_exit
From: syzbot <syzbot+8d052e8b99e40bc625ed@syzkaller.appspotmail.com>
To: cgroups@vger.kernel.org, hannes@cmpxchg.org, inwardvessel@gmail.com, 
	linux-kernel@vger.kernel.org, mkoutny@suse.com, shakeel.butt@linux.dev, 
	syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file kernel/cgroup/cgroup.c
patch: **** unexpected end of file in patch



Tested on:

commit:         347e9f50 Linux 6.16-rc6
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=84eae426cbd8669c
dashboard link: https://syzkaller.appspot.com/bug?extid=8d052e8b99e40bc625ed
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16e3fd82580000


