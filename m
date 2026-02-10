Return-Path: <cgroups+bounces-13833-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cDy6GypTi2kMUAAAu9opvQ
	(envelope-from <cgroups+bounces-13833-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 10 Feb 2026 16:47:54 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E2AB811CB66
	for <lists+cgroups@lfdr.de>; Tue, 10 Feb 2026 16:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 05D9D305A49C
	for <lists+cgroups@lfdr.de>; Tue, 10 Feb 2026 15:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1190381712;
	Tue, 10 Feb 2026 15:45:50 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547D71CFBA
	for <cgroups@vger.kernel.org>; Tue, 10 Feb 2026 15:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770738350; cv=none; b=g5DvgOztuJYDILPUDuSTQuK4C2eEsd7vT2LOuBC7UyDKY/ThclUTMQW5Vn1hzc16lGwnSXd1mDJEjqbEJrV4OTn9PU9Te/uuJUKpZP+790yGQon+pFfO1/rIaiUt26W7zSavcOyE9LHhn3MfYiwSNf+xSkhTLy2+/83Go0+AFCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770738350; c=relaxed/simple;
	bh=JAEKzDPjAbshWtKnNxJk09xXOVyfSE3QNBnq1GJYJsY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=mSDcABqiwYbX7NqN7Z4JxF3/UHQo32iUO6pYEqQyszA3pPgY5tDxF1lFy3v3DyZEhK5aP5CMqyM/ulSkjs+I+bCrE2iAouTTvltih0v4Fk7xooQ/4l2z2nmvOu7RD1Ivs9cHbTWYwO8n+hdIGf16SQmYWHomm8MSa+FcTtC4hzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7cfcc8890d2so23530724a34.0
        for <cgroups@vger.kernel.org>; Tue, 10 Feb 2026 07:45:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770738348; x=1771343148;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=umYiyPeqfv4hz6b8WdCAw8Mf6WoinfgY1PV/QiXW0KY=;
        b=gY6pZd7T7OyvEWgHzSXBo5rMfPty/0mpOqFHWkoo7SQOTfTjRBHEN1HPxsWNaPDp4s
         Jgiv9M7/nn8aRiaf/9On60GTh3iOw9LXss5ms/osGI3Aj8qDFSMeNaKYdDTA/9B4GsD+
         jobvTrD2vEkXyrRSzeSdDJpp3Co/QYO0wizMdbFeekuLWsW/exJA7c4TJsxxlrfHTWjU
         k5Yvs3AxJD5n+7Lm/WjV4OjWvYLg+f9BdtWhyub9fd5ZlnYztdnlmzGCBI3MXaLLu1+7
         rdBpFoRO5EjfSnCkxXpezvHOnjmf3Hs19+F0LbzBe7zXFW1XvvZcwyXOFm6AUYjsLcJa
         vi0w==
X-Forwarded-Encrypted: i=1; AJvYcCWEzM8qyhtkgElyXxaR0r+smQIVoBoyFddVH66cZpBikvgWjNqhpGHXi0ViadJWpClSjDaWEmXa@vger.kernel.org
X-Gm-Message-State: AOJu0YzBKGK1W4BfNykAF/DbVhZdhgMXZoETzJMgGP6Nj6F5NhQQUAJf
	Lbq0iHcydVb0fQ/f1QfHgL6ggev/xQZi7rlVukI3v4nxSyu1SGSnOu6qNph/Fb1XuLwBS8lQfb+
	IQVHx81QfejT1ZcAsmgubm+6Kp/G1RpAlQ8HEDut42eYFZD/ZduvyUIVGBs4=
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:818b:b0:66d:ecba:b3f4 with SMTP id
 006d021491bc7-672e62cc5a8mr1455324eaf.31.1770738348353; Tue, 10 Feb 2026
 07:45:48 -0800 (PST)
Date: Tue, 10 Feb 2026 07:45:48 -0800
In-Reply-To: <20260208215839.87595-1-nphamcs@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <698b52ac.a70a0220.2c38d7.0076.GAE@google.com>
Subject: [syzbot ci] Re: Virtual Swap Space
From: syzbot ci <syzbot+ci0e6a00c2d76396f3@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, axelrasmussen@google.com, baohua@kernel.org, 
	bhe@redhat.com, cgroups@vger.kernel.org, chengming.zhou@linux.dev, 
	chrisl@kernel.org, christophe.leroy@csgroup.eu, gourry@gourry.net, 
	hannes@cmpxchg.org, huang.ying.caritas@gmail.com, hughd@google.com, 
	jannh@google.com, joshua.hahnjy@gmail.com, kasong@tencent.com, 
	kernel-team@meta.com, len.brown@intel.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-pm@vger.kernel.org, lorenzo.stoakes@oracle.com, 
	mhocko@kernel.org, muchun.song@linux.dev, npache@redhat.com, 
	nphamcs@gmail.com, osalvador@suse.de, pavel@kernel.org, peterx@redhat.com, 
	pfalcato@suse.de, rafael@kernel.org, riel@surriel.com, 
	roman.gushchin@linux.dev, ryan.roberts@arm.com, shakeel.butt@linux.dev, 
	shikemeng@huaweicloud.com, viro@zeniv.linux.org.uk, weixugc@google.com, 
	yosry.ahmed@linux.dev, yuanchu@google.com, zhengqi.arch@bytedance.com
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13833-lists,cgroups=lfdr.de,ci0e6a00c2d76396f3];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[linux-foundation.org,google.com,kernel.org,redhat.com,vger.kernel.org,linux.dev,csgroup.eu,gourry.net,cmpxchg.org,gmail.com,tencent.com,meta.com,intel.com,kvack.org,oracle.com,suse.de,surriel.com,arm.com,huaweicloud.com,zeniv.linux.org.uk,bytedance.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[42];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,syzbot.org:url,googlegroups.com:email,googlesource.com:url]
X-Rspamd-Queue-Id: E2AB811CB66
X-Rspamd-Action: no action

syzbot ci has tested the following series

[v3] Virtual Swap Space
https://lore.kernel.org/all/20260208215839.87595-1-nphamcs@gmail.com
* [PATCH v3 01/20] mm/swap: decouple swap cache from physical swap infrastructure
* [PATCH v3 02/20] swap: rearrange the swap header file
* [PATCH v3 03/20] mm: swap: add an abstract API for locking out swapoff
* [PATCH v3 04/20] zswap: add new helpers for zswap entry operations
* [PATCH v3 05/20] mm/swap: add a new function to check if a swap entry is in swap cached.
* [PATCH v3 06/20] mm: swap: add a separate type for physical swap slots
* [PATCH v3 07/20] mm: create scaffolds for the new virtual swap implementation
* [PATCH v3 08/20] zswap: prepare zswap for swap virtualization
* [PATCH v3 09/20] mm: swap: allocate a virtual swap slot for each swapped out page
* [PATCH v3 10/20] swap: move swap cache to virtual swap descriptor
* [PATCH v3 11/20] zswap: move zswap entry management to the virtual swap descriptor
* [PATCH v3 12/20] swap: implement the swap_cgroup API using virtual swap
* [PATCH v3 13/20] swap: manage swap entry lifecycle at the virtual swap layer
* [PATCH v3 14/20] mm: swap: decouple virtual swap slot from backing store
* [PATCH v3 15/20] zswap: do not start zswap shrinker if there is no physical swap slots
* [PATCH v3 16/20] swap: do not unnecesarily pin readahead swap entries
* [PATCH v3 17/20] swapfile: remove zeromap bitmap
* [PATCH v3 18/20] memcg: swap: only charge physical swap slots
* [PATCH v3 19/20] swap: simplify swapoff using virtual swap
* [PATCH v3 20/20] swapfile: replace the swap map with bitmaps

and found the following issue:
possible deadlock in vswap_iter

Full report is available here:
https://ci.syzbot.org/series/b9defda6-daec-4c41-bbf9-7d3b7fabd7cb

***

possible deadlock in vswap_iter

tree:      bpf
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/bpf/bpf.git
base:      05f7e89ab9731565d8a62e3b5d1ec206485eeb0b
arch:      amd64
compiler:  Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
config:    https://ci.syzbot.org/builds/f444cfbe-4ce0-4917-94aa-3a8bd96ee376/config
C repro:   https://ci.syzbot.org/findings/7b8c50b1-47d6-42e0-bcfc-814e7b3bb596/c_repro
syz repro: https://ci.syzbot.org/findings/7b8c50b1-47d6-42e0-bcfc-814e7b3bb596/syz_repro

loop0: detected capacity change from 0 to 764
============================================
WARNING: possible recursive locking detected
syzkaller #0 Not tainted
--------------------------------------------
syz-executor625/5806 is trying to acquire lock:
ffff88811884c018 (&cluster->lock){+.+.}-{3:3}, at: spin_lock include/linux/spinlock.h:351 [inline]
ffff88811884c018 (&cluster->lock){+.+.}-{3:3}, at: vswap_iter+0xfa/0x1b0 mm/vswap.c:274

but task is already holding lock:
ffff88811884c018 (&cluster->lock){+.+.}-{3:3}, at: spin_lock_irq include/linux/spinlock.h:376 [inline]
ffff88811884c018 (&cluster->lock){+.+.}-{3:3}, at: swap_cache_lock_irq+0xe2/0x190 mm/vswap.c:1586

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&cluster->lock);
  lock(&cluster->lock);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

3 locks held by syz-executor625/5806:
 #0: ffff888174bc2800 (&mm->mmap_lock){++++}-{4:4}, at: mmap_read_lock include/linux/mmap_lock.h:391 [inline]
 #0: ffff888174bc2800 (&mm->mmap_lock){++++}-{4:4}, at: madvise_lock+0x152/0x2e0 mm/madvise.c:1789
 #1: ffff88811884c018 (&cluster->lock){+.+.}-{3:3}, at: spin_lock_irq include/linux/spinlock.h:376 [inline]
 #1: ffff88811884c018 (&cluster->lock){+.+.}-{3:3}, at: swap_cache_lock_irq+0xe2/0x190 mm/vswap.c:1586
 #2: ffffffff8e55a360 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #2: ffffffff8e55a360 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:867 [inline]
 #2: ffffffff8e55a360 (rcu_read_lock){....}-{1:3}, at: vswap_cgroup_record+0x40/0x290 mm/vswap.c:1925

stack backtrace:


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

