Return-Path: <cgroups+bounces-10517-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C59D0BB4101
	for <lists+cgroups@lfdr.de>; Thu, 02 Oct 2025 15:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D27B19E1166
	for <lists+cgroups@lfdr.de>; Thu,  2 Oct 2025 13:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5001E311C1F;
	Thu,  2 Oct 2025 13:35:07 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E94729ACC5
	for <cgroups@vger.kernel.org>; Thu,  2 Oct 2025 13:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759412107; cv=none; b=ZFDTxoMjVjUmnr6s4+xexRCrYEwI5z4CMOZ2SiJTKlCnPdB1HlUCXVBBtpHlzNWrR3oQlijrSCNkIuR7ybwXP5h9MjDWJfcy6zK4wpxoKxb+x+qugEwQfyCL7jer/84Wc1eEDZw4LxLdfiOe1ezMkZTtBrqD27/JodfRFLVSut4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759412107; c=relaxed/simple;
	bh=nawsYGieFIT9F5gaofrxj9YLOzYeIyfDFWO/gGppFPg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=LbbFOTNqUelZbKXj63FeQXubUdeIcXYefqpFYnqDezGbS6qkIQ507Pb+RXyqW7/xpopFfst6Beqh8wTWZU/Dx3tbTWATBFbtLE75pHQRUot13dhL9oAvXIYbMBbyDYZY1un/dreRNvdzRD6cAuDv6zCC5uGwcoAXl39nPsnfNeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-4256ef4eea3so11252745ab.1
        for <cgroups@vger.kernel.org>; Thu, 02 Oct 2025 06:35:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759412103; x=1760016903;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H2bZMOz+oKVSx+PlpEBINf9QeMZAUdNl6Bv+63J9ZJc=;
        b=hqDuva7XuqrV+6AzP6NlH0UyLu/VjguTt4mLYJM+BOWD++E7PNeGcJxm1WwtNs1H61
         XP0NFACAIbiuYw4wY/KVKM956wCH+npgPJPRmcAJEHiSng9sVZXMG4WxVocGL7DLzZ+P
         Ee27rKDm1oiAFHKqfFlISYjsi9TJwLEa42zD2FdKV81Cf7yEDaD/aLNyVgLl9Czo/bBl
         BMpjfr9j6gtdZFVBLNZ+EQWmqzAihd7ZDltchRYRndMAU4gktUwFjPVcPIHw8ToZ3ybF
         wWMyZ3a5gpHA9er96+pCfTgSgGDB/GyLp8I0XMc+2DVbxoKnfqzbDdbUaRhzycCO7Zzo
         v0fA==
X-Forwarded-Encrypted: i=1; AJvYcCU3IVsSEouMnZAcmOhC9AMA3lZClTSw4tiAHDw+PWncpVLNjK4Z2psCHIa4jImsXuHXliC8oHuI@vger.kernel.org
X-Gm-Message-State: AOJu0YxfEUoMhdZIyy0bKhAoID2o6vKnH/24tDtKOzHjMhJYHwRU/QVd
	jZ27mDZiZHXfvB0Us4o4LSXYSXeSB3b3/BA9udRw0GemDw+hEOuDbcb9Iadxkuz5udafn2H6RT2
	v1+tSlfAFJa7vMs6iZpncYeezuRLn3cifJfnyk86iFzlHb94HmDKibGnZYMU=
X-Google-Smtp-Source: AGHT+IEQRq/93P1vlQQW6gk27vSZbUYibORnozKjfZjrhOWDxoyWlapnF/W8MSX0jIwjw9gXTkTNpSFyTUz+21o3FyrLcLLpbSex
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:23c8:b0:42d:7d2e:2bff with SMTP id
 e9e14a558f8ab-42d81687a6fmr82693985ab.22.1759412103562; Thu, 02 Oct 2025
 06:35:03 -0700 (PDT)
Date: Thu, 02 Oct 2025 06:35:03 -0700
In-Reply-To: <68dc3ade.a70a0220.10c4b.015c.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68de7f87.a00a0220.102ee.00a5.GAE@google.com>
Subject: Re: [syzbot] [fs?] WARNING in free_mnt_ns
From: syzbot <syzbot+7d23dc5cd4fa132fb9f3@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, anna-maria@linutronix.de, brauner@kernel.org, 
	cgroups@vger.kernel.org, cminyard@mvista.com, cyphar@cyphar.com, 
	davem@davemloft.net, djwong@kernel.org, edumazet@google.com, 
	frederic@kernel.org, hannes@cmpxchg.org, hdanton@sina.com, horms@kernel.org, 
	jack@suse.cz, jlayton@kernel.org, joel.granados@kernel.org, kuba@kernel.org, 
	kuniyu@google.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mawupeng1@huawei.com, mkoutny@suse.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, sd@queasysnail.net, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, tj@kernel.org, 
	viro@zeniv.linux.org.uk, wei.liu@kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit be5f21d3985f00827e09b798f7a07ebd6dd7f54a
Author: Christian Brauner <brauner@kernel.org>
Date:   Wed Sep 17 10:28:08 2025 +0000

    ns: add ns_common_free()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=124fb6e2580000
start commit:   50c19e20ed2e Merge tag 'nolibc-20250928-for-6.18-1' of git..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=114fb6e2580000
console output: https://syzkaller.appspot.com/x/log.txt?x=164fb6e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f1ac8502efee0ee
dashboard link: https://syzkaller.appspot.com/bug?extid=7d23dc5cd4fa132fb9f3
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15842092580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=132946e2580000

Reported-by: syzbot+7d23dc5cd4fa132fb9f3@syzkaller.appspotmail.com
Fixes: be5f21d3985f ("ns: add ns_common_free()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

