Return-Path: <cgroups+bounces-8732-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A79FAB04C99
	for <lists+cgroups@lfdr.de>; Tue, 15 Jul 2025 02:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0BEE3BD2EB
	for <lists+cgroups@lfdr.de>; Mon, 14 Jul 2025 23:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E21127A46E;
	Tue, 15 Jul 2025 00:00:06 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF352279787
	for <cgroups@vger.kernel.org>; Tue, 15 Jul 2025 00:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752537606; cv=none; b=BAmcz7QnCJRS6ytmV7/XO4wZDzp6TSNknORlIECMnpKh9cS2rvPPqgzQa2X12TdRFeCIeJf9MeX+A+ZHfJqQhv5DT84b2++FJzKe3wdZdk0+2jRTiehxrrxfj4wBw3VQ+1u+V91GTsLueRh+pNf8cpaz+fbjV/csOdKIov+AZTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752537606; c=relaxed/simple;
	bh=ez6QPF7zZsOFfsJ8n+1HyNnpGGsP2rHkUY01pkIl63o=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Lu66Hv8Lo3mtsL05qqxqRMBYatZ/2BxUPwiEb9WH1ILnBPG9c8rTQ5zrgRHbh4oZt5AgocTUl0xly5fah6Dbye0gBDiWXcGfI3lMSgznOO1q+6+xx66KWFsjmQdjxrjxVpxuIkAsZGm7bJHuPqjbmMsnPv1lWQdKUB5VN5ddGhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3df4022687eso55432735ab.1
        for <cgroups@vger.kernel.org>; Mon, 14 Jul 2025 17:00:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752537604; x=1753142404;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ugecHUs6ZUqF8Vti1XuTWNyS/mAPzmrzTFopoL7/38A=;
        b=O6Q+fAA1awGKC41++9JHdxea6J0QbJXA1pb4YXzrhHwL78dcXThyiTIWSS5yeCFPj8
         4Go+vi6nPYd1ReFSBEVpXjUs51mm/cHzXcz2dcOO7hlpU3MpGW5qLKbGIgpXATATDGuD
         xRWaBrqbFO0Y+lQ+C6uRLYH541rWTn1BGI1H4LA1igS5WRqO1IvBYQDCYSNLaD51hC4t
         yBilAQfRR7ZcOPP/W209l54XZ+pR9v1W1C8IFqbGjXaPl7zC4p8cGfdu3Tu1+f5UvheA
         R4JPwQGxcTJC08mrMiAa8ezNIG+qehjW8LPAIQ1d7f59PHR+RKHPZgP04opT6Ne/aep0
         jlPw==
X-Gm-Message-State: AOJu0YyqInmxtsYVQLGKzGxFnCe4BiA0RDbmfqeJpH66AHKXCGyjzQ3j
	6Jpc1iwbTKzINdyL/eTWwXosVxVjzO8b61ZQHqZncLycrfqv4t7mk5onaj9FzLRWvGdobByJt4y
	ZEqxpw3i11Ra2lE7u6We8eNMNdApMEtoU5/SgHjPwvZ55xyZ0uWGTcds57E8=
X-Google-Smtp-Source: AGHT+IHDw6UZRV+roLHMz9hyzZ+jp9boU/Gtd1+ISYFZjLUJDrwFmH6vMvUpUOitf5uZHLqD4I1D5n/woykmWqmJ+gitKgKY4U7T
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1065:b0:3de:e74:be13 with SMTP id
 e9e14a558f8ab-3e277b37e58mr14777985ab.0.1752537603874; Mon, 14 Jul 2025
 17:00:03 -0700 (PDT)
Date: Mon, 14 Jul 2025 17:00:03 -0700
In-Reply-To: <65df1f7e-9512-4527-bbe4-0cf10877f4ba@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68759a03.a70a0220.18f9d4.0013.GAE@google.com>
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
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=84eae426cbd8669c
dashboard link: https://syzkaller.appspot.com/bug?extid=8d052e8b99e40bc625ed
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1541718c580000


