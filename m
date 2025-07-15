Return-Path: <cgroups+bounces-8735-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 681A3B04D67
	for <lists+cgroups@lfdr.de>; Tue, 15 Jul 2025 03:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A28F33B7C59
	for <lists+cgroups@lfdr.de>; Tue, 15 Jul 2025 01:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56061C1F22;
	Tue, 15 Jul 2025 01:27:07 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C264839FD9
	for <cgroups@vger.kernel.org>; Tue, 15 Jul 2025 01:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752542827; cv=none; b=aFthQYoEqn/SdeqiRvovGJGI+ve9lq08xOcX5cQogh2nZrV3Frs9secUS6c+m2KH9/g1L8aSx+eCBOxADxDb+yvVnnX3dKTvWOs18QSerdZ3aCSiAhsEQbpObjIZFLHoxf5iZ8TJ/LcXPXQ6aSrTCygURzeW0Hz0sFPET/3VdcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752542827; c=relaxed/simple;
	bh=o4ynSAGx3+TTcBXiUL2Rxh4BKd+kJlEP+kAE4q3Ea14=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Y6ymeF9Q40CjzsjRAFon732bRyWcwr2QL3+kPrG6AxSaGdKDqRvgykXGwH078fBAA+zlM02Va6T3KDvI2y1UWwRorYf/5SKc4SgSefqeB1i0329biT+GCnS3ZasrnFzyDOb4reuzfuXB6BDiy5vaQ14w3kuAF9UiA5nQvUzWTiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-86d126265baso462454939f.0
        for <cgroups@vger.kernel.org>; Mon, 14 Jul 2025 18:27:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752542825; x=1753147625;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BoH4lg9vmmUdD5h4nj7VuM+JBKpdp1mdWhKXqK4cfQo=;
        b=Ot9IHeuyqVodl1jUMnQIDKWI5VuuwvcNXIIfGvzjkwPP0m/XSJ4elwdtVqqEODY0TJ
         y7HKRsjBfc/ZhBElfrEngkS7bC4pxD/x+GOssWWjkCMKmnSm6EtbYCycwa03BojJy7Rv
         N2mBFCqScD1T1YTPtC8RbmXSp8hSC3KRWngq8Vf34faYBp4F62OZjktpgD/M2ZcuZTrR
         2M6f634FZ3+EJZv32hDCHjkeMUCmRfCmyer2Wtqukmii+eqWAaMZjBd5pxn/E5BZ/f1G
         d/Wikkdjdvd/Ai4xPFXalGRCYES+q3yQUKJftsWLok4lrFNrCxzYsY1INHyUjC+yHKJO
         E4EA==
X-Gm-Message-State: AOJu0YxzeWs0Xn0Zk8nvKBczT0vyOmSeYgWobFkkPer/GQS2ZNvvEgW8
	4ec7Cezvt4F05OjiIdljAFI+I/n63Wuy5VIRXdpbNXZyf9ROZOE3NjgAl33Bk+LhBd+SRm+oVtp
	IaLvgMEFBTmgb4N/X36KoFkNODtVQYNTt1EtnjZs/lPB8QqdApbvg/DH2a2A=
X-Google-Smtp-Source: AGHT+IGKTOLuJOVlRv5UaPjainSyWmIZZsr625vMyc3G9RqrxZrlKxujZjM2/vVurFaUVJdOgFLVKf/Kn94gU6kWDpZIl+0xBqVU
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2c85:b0:862:ba37:eb0e with SMTP id
 ca18e2360f4ac-87977fedcdbmr1760914239f.12.1752542825042; Mon, 14 Jul 2025
 18:27:05 -0700 (PDT)
Date: Mon, 14 Jul 2025 18:27:05 -0700
In-Reply-To: <2b10ba94-7113-4b27-80bb-fd4ef7508fda@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6875ae69.a70a0220.18f9d4.0016.GAE@google.com>
Subject: Re: [syzbot] [cgroups?] WARNING in css_rstat_exit
From: syzbot <syzbot+8d052e8b99e40bc625ed@syzkaller.appspotmail.com>
To: cgroups@vger.kernel.org, hannes@cmpxchg.org, inwardvessel@gmail.com, 
	linux-kernel@vger.kernel.org, mkoutny@suse.com, 
	syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+8d052e8b99e40bc625ed@syzkaller.appspotmail.com
Tested-by: syzbot+8d052e8b99e40bc625ed@syzkaller.appspotmail.com

Tested on:

commit:         347e9f50 Linux 6.16-rc6
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16a80382580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=693e2f5eea496864
dashboard link: https://syzkaller.appspot.com/bug?extid=8d052e8b99e40bc625ed
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1025718c580000

Note: testing is done by a robot and is best-effort only.

