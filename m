Return-Path: <cgroups+bounces-3190-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B51909DE2
	for <lists+cgroups@lfdr.de>; Sun, 16 Jun 2024 16:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 816F01F217C3
	for <lists+cgroups@lfdr.de>; Sun, 16 Jun 2024 14:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27DF6F9EC;
	Sun, 16 Jun 2024 14:05:06 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965EEDDAB
	for <cgroups@vger.kernel.org>; Sun, 16 Jun 2024 14:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718546706; cv=none; b=fb7osHKd6gfWeQ/X8SPU52q+KU30xqqSehTkSLax0z5L695C4RpM/eS6YJNrosdhzXNP1LgzbvW5jEzKFdZO3kB0QOG6nhkHzpSTteQGFPtz35O1WC2pbsfrOKNhRvC5W52Qwk6scW6dcare3EY+6S0zq9DVUWPCPfxYCFvWYBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718546706; c=relaxed/simple;
	bh=6io00tG+BXXD/bjavj6Wc0ZSI2uXwoyQQXTJiFre6ec=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=DwhrreXd0jOjh3YawckWtFHjjtp1XYXY9QJrp0RnBzL/DN9hOZMExkj2QPB56aI+dO8wYCGPRiQQWIrRSW9MNB7ZCLMUU06j82U/A5uNJRSj8TmfF/ORtwgYor6hM6b+45YIz5oakHs9vDO525kn1YGZ0uoaAeWcS8DQXdnnbe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7eb7cf84c6cso439047939f.0
        for <cgroups@vger.kernel.org>; Sun, 16 Jun 2024 07:05:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718546704; x=1719151504;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DLcaaWng2TQ/H+FaOLphi+VM/bKUwUbvtr6FoaGnNrI=;
        b=Lqbk8Y5TkmJSk3bUpCu1J33FxMqECkgu7hFUREheX9Iq7t7YIh8m8ZkIYrMnJ3GxGx
         cfIkw37i2jGyWyvq4ci7I06k5/twpXKsVRDuJBwyR76VrJMnq6TnCLYOVV1DBkwPKqe7
         I8AX+Wea6VeGCmDRH9zvzeERkyQqsB+/iSKm0bvQV1rfQLfq/SxaNwNPNDA33Qt+Q3tF
         7uGPYDHeVeqTy3UUoQR4y8/+Xqh6watbSS2mV4+eEcADOWihAIWOy525aZ80hanbxax4
         Etjp+JkoTGE/3If5jcMSKweAFbAB6L/+BGfpQylLXDO6z7Csbn9BPBAz5DiClYOgh8Zn
         0zOA==
X-Forwarded-Encrypted: i=1; AJvYcCXdw0qM/pDNSGdua+zmVNkW+IYkQoY7E7ifaWfBTKSAF5ahMMcgEhd7VepDZ/hOpCXdrzKCO2iwzYSow9QAdIEOsTE7w6R2Xw==
X-Gm-Message-State: AOJu0YxJid2ifoupUcy6E2ZGIXqwql1CObDDPHN46l+wFFX4tzGC3sOJ
	ClqxEWoRaiMN9Xu9jjMsvR3JfV8tfdo+BOGggLlv+TvEP/2JP0+fuxvLFo1sjRjGX69RIBMFjSz
	ilfkAKP9hGIIDc1i+ntbfhJDQOWcM603uARzeGtkqhRduIBtsaM55EWE=
X-Google-Smtp-Source: AGHT+IGHyeFtvlt+ImnEUgnwm5dEInqksvU32QABvMV0/yconOjWp25/ZCqoFaDWtWWVmgcbKMIB0yhITZPgs6UzpCsDR8a/2Hhl
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:150f:b0:7eb:78b4:faff with SMTP id
 ca18e2360f4ac-7ebeb62c796mr20918739f.3.1718546703860; Sun, 16 Jun 2024
 07:05:03 -0700 (PDT)
Date: Sun, 16 Jun 2024 07:05:03 -0700
In-Reply-To: <00000000000041df050616f6ba4e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d05580061b025528@google.com>
Subject: Re: [syzbot] [mm?] possible deadlock in __mmap_lock_do_trace_start_locking
From: syzbot <syzbot+6ff90931779bcdfc840c@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, cgroups@vger.kernel.org, hannes@cmpxchg.org, 
	hawk@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, lizefan.x@bytedance.com, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, netdev@vger.kernel.org, 
	rostedt@goodmis.org, syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 21c38a3bd4ee3fb7337d013a638302fb5e5f9dc2
Author: Jesper Dangaard Brouer <hawk@kernel.org>
Date:   Wed May 1 14:04:11 2024 +0000

    cgroup/rstat: add cgroup_rstat_cpu_lock helpers and tracepoints

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16695261980000
start commit:   36534d3c5453 tcp: use signed arithmetic in tcp_rtx_probe0_..
git tree:       bpf
final oops:     https://syzkaller.appspot.com/x/report.txt?x=15695261980000
console output: https://syzkaller.appspot.com/x/log.txt?x=11695261980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=333ebe38d43c42e2
dashboard link: https://syzkaller.appspot.com/bug?extid=6ff90931779bcdfc840c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1585acfa980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17bdb7ee980000

Reported-by: syzbot+6ff90931779bcdfc840c@syzkaller.appspotmail.com
Fixes: 21c38a3bd4ee ("cgroup/rstat: add cgroup_rstat_cpu_lock helpers and tracepoints")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

