Return-Path: <cgroups+bounces-11691-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 852CCC43FBE
	for <lists+cgroups@lfdr.de>; Sun, 09 Nov 2025 15:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 46ADB4E4A62
	for <lists+cgroups@lfdr.de>; Sun,  9 Nov 2025 14:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439E52FC030;
	Sun,  9 Nov 2025 14:11:06 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B572FB62C
	for <cgroups@vger.kernel.org>; Sun,  9 Nov 2025 14:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762697466; cv=none; b=TeiuiUIqJ4fVVGVsk+iDIiFeQV/bxJul3T0FeYrLM5gPBKr/NGOdeDNtrtz4RxHhIIbtimsE9vxmmM/v3v4C8WLqtoQR20iz5A38DnAMF/4/l3ipOImqDrmYzzeI7fsuBR1m/iHYkrIrBfmaQe2W/HudazOqWkBIdrjcRWsb8r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762697466; c=relaxed/simple;
	bh=y6Dy/w1K3XpX2uFUEe+rBJFRb32lSDcExJhalbXQ5aU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Y/w1/AxX+7WY7BhFaSvhgemO8ev10MvndxDe2EeME6lldTYFg32HvmOap1wdQI49OtCHgu8Cr3lCG07BWChrsx3qZOuiA3fi+V8ePK/Wa6s2Wvk0CPSsM7C18H1A8ehUlaNlVg7BkkjQOpOWUGMzWmTwcs/qJrE9hOCPsK3+oK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-433817220f5so148005ab.1
        for <cgroups@vger.kernel.org>; Sun, 09 Nov 2025 06:11:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762697462; x=1763302262;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m02kWE5lhyrzZgApWthbB6kQBtAUB+gmZPn3Dt1ZsD4=;
        b=go35LgrJDlwXsnslAzXmaC71uA8ekJrsrEWWnZECjlobGqdtvVCx+NZU8iISBe80iL
         LFOvxBqwXx2Wv7p2rAoIojPyFH/f9QaDOL17sZLO+uflWWsinmXz60k09fsUj4Xr2i83
         S0IFmrPWYxtWPk+px4fI7YVf5ejrWjPAeuthwYnT8SnNauZd2yjW6A972zJ+8m4glOkP
         B7Hhrc5ah9/k4bNdsmN6LNeVvsEqBMRBmZ+Xy3gjKqvCWenXg6VqHYX8RJEM+38n4N93
         FrierTSFgCzxwkz57b6CQmcfRGVnxZqtjL2ZNIQEKe9uyxFoTC+0pxPxzpSq9FgPDYN2
         aNCg==
X-Forwarded-Encrypted: i=1; AJvYcCVhyxYLld2SxKP+K3df5La+kOSFj747WW1kHa2zmor1vqGe+IklszQY2mRAwZNkwJAc2QJd/Cgk@vger.kernel.org
X-Gm-Message-State: AOJu0Yywh6xHtdccDJIjjANXNXMHdTJ3fJRSHqFyFND8DCRooNLr/jc8
	VXCT0frXeD+EOkLKNSDViBkkvc9H+mm+XXAn8eA//78BYVWOob4wkc15JZSt1Xg6JURamhjXt1w
	MJahldWjnPcvaxf+LJ3cBd3K57krf3aRuqVZLS6254/1TJlO9wBYiTVgLlLI=
X-Google-Smtp-Source: AGHT+IEw+SyBMcsmvsru2ydmWiAer57ckBKlQAwl2f1WWyRnepHiN7uVkkXdan4vghsxm/ZOPYzm213l8SerzWDt7Il3Poc2ozLJ
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:4417:20b0:433:7d0b:b377 with SMTP id
 e9e14a558f8ab-4337d0bb530mr14752975ab.15.1762697462239; Sun, 09 Nov 2025
 06:11:02 -0800 (PST)
Date: Sun, 09 Nov 2025 06:11:02 -0800
In-Reply-To: <20251109-lesung-erkaufen-476f6fb00b1b@brauner>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6910a0f6.a70a0220.22f260.00b8.GAE@google.com>
Subject: Re: [syzbot] [fs?] WARNING in destroy_super_work
From: syzbot <syzbot+1957b26299cf3ff7890c@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, anna-maria@linutronix.de, bpf@vger.kernel.org, 
	brauner@kernel.org, bsegall@google.com, cgroups@vger.kernel.org, 
	david@redhat.com, dietmar.eggemann@arm.com, frederic@kernel.org, 
	hannes@cmpxchg.org, jack@suse.cz, jsavitz@redhat.com, juri.lelli@redhat.com, 
	kees@kernel.org, liam.howlett@oracle.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-security-module@vger.kernel.org, lorenzo.stoakes@oracle.com, 
	mgorman@suse.de, mhocko@suse.com, mingo@redhat.com, mjguzik@gmail.com, 
	mkoutny@suse.com, oleg@redhat.com, paul@paul-moore.com, peterz@infradead.org, 
	rostedt@goodmis.org, rppt@kernel.org, sergeh@kernel.org, surenb@google.com, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, tj@kernel.org, 
	vbabka@suse.cz, vincent.guittot@linaro.org, viro@zeniv.linux.org.uk, 
	vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+1957b26299cf3ff7890c@syzkaller.appspotmail.com
Tested-by: syzbot+1957b26299cf3ff7890c@syzkaller.appspotmail.com

Tested on:

commit:         241462cd ns: fixes for namespace iteration and active ..
git tree:       https://github.com/brauner/linux.git namespace-6.19.fixes
console output: https://syzkaller.appspot.com/x/log.txt?x=11e1517c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f1b1a45727d1f117
dashboard link: https://syzkaller.appspot.com/bug?extid=1957b26299cf3ff7890c
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

