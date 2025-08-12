Return-Path: <cgroups+bounces-9090-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC1DB21FCC
	for <lists+cgroups@lfdr.de>; Tue, 12 Aug 2025 09:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDBC3682372
	for <lists+cgroups@lfdr.de>; Tue, 12 Aug 2025 07:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D302E1531F9;
	Tue, 12 Aug 2025 07:46:45 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC881E834B
	for <cgroups@vger.kernel.org>; Tue, 12 Aug 2025 07:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754984805; cv=none; b=bLnMF4BFXIZ67kwNxZTu0tS/y0YAA9K6+GLzj4xEtjN2WeSfvhHT2IlaStm9IMDyF3VxpWW50PYag7BmLvfY9Tz9IUbHIBGo884+B/kjt3Q2sHPG5EB+0HtW3t4UYBKTJfusJSHc8f1Hqc8GvnNkJfpkyWPRgHvM8xDZqLJGdio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754984805; c=relaxed/simple;
	bh=7veAhauFbzmeZ6VPaXhAIl+1EidQymqZFBkfOM5A+nY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=Yt0aXXK47/7Lkfge79z35ONkZmiKAllZ+DVJqDKUUDyACJU6u4045mAt4wiJMMv/TBm+GKYEE7jU9yC1IdK73SjZMhgsoJuNWdeaBtuCox+T4SR4zFcHBi4TPTCXRZTWvzdp54uot3MWRN3ko1P3/UOCC1FQMpy6R2+OXoEjYyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-8817ecc1b33so1197147839f.2
        for <cgroups@vger.kernel.org>; Tue, 12 Aug 2025 00:46:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754984803; x=1755589603;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Umk1YoadKdpa6fyzaimwqq35auuAfEV1rwGDtpJveWA=;
        b=Xi6tlDJCZK1PFcsYyVAylULYb3iIbpWpROTMmCUp13AyTT4I6FpwVq0ZuSqC6ZWPmU
         J3xOEw7C4z750gplmDwjCFiP3BJTuVBWm/SU7/ykLquAV+B+CJTwOabqq2x6CWWemaSz
         BqqUusc7F8M6Lp7nKnUFDNCvyK34loqdChkZvDmxFQELMPnNPW9NzkiSh/M+loXOHZQf
         LHDBa/Saajg+ptlp+5NyDFA83lb44BYKZofNL0kRhPBKDijPdYu1RUXQwV0GTzRXFKQ/
         jdzwMZVbQ8VCKCnN+F9lu8lT9/RGT4hJ89sVU1Xjmi0SUMaEHmkj0nsc9M2uC8Bvi6i7
         BjCg==
X-Forwarded-Encrypted: i=1; AJvYcCUOzTIi0u94uXwBnwBI8cOQjH42hxSu1EiS+fHVFc7LWk1qpzoR9I8jOqfOYgxoE7+h5gxh5K+V@vger.kernel.org
X-Gm-Message-State: AOJu0YyXZ3OWysE0E6/KR6v6JfLNIyGtZIHB7o3hAwziFrOyCETXcqmJ
	XJ8BdrlIF2xKh3EgRYeyxvfBIJDVwMe6h8CCZyC8QURGdTokuuETlBkXqxdlfKQG063K+jWUQlY
	rDGNbFNcDnJDNJEddnW60tMUx2MF4KNekw0Z1kEUoGnxDMp5Hz+G3yy1lVcw=
X-Google-Smtp-Source: AGHT+IGMO5NHQ7t/8SdMDmkMxxHOO+f+f98qggqnhfBOuHrFo4tBxoy7lI5+nUzI68F7dY4bFrEZVQmeL1OqGTmyoq+dADo+nkMr
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:7187:b0:881:9412:c917 with SMTP id
 ca18e2360f4ac-8841bcc009bmr501638939f.0.1754984803514; Tue, 12 Aug 2025
 00:46:43 -0700 (PDT)
Date: Tue, 12 Aug 2025 00:46:43 -0700
In-Reply-To: <20250811173116.2829786-1-kuniyu@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <689af163.050a0220.7f033.0112.GAE@google.com>
Subject: [syzbot ci] Re: net-memcg: Decouple controlled memcg from sk->sk_prot->memory_allocated.
From: syzbot ci <syzbot+cic0c8bc3087cfc855@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, almasrymina@google.com, cgroups@vger.kernel.org, 
	davem@davemloft.net, edumazet@google.com, geliang@kernel.org, 
	hannes@cmpxchg.org, horms@kernel.org, kuba@kernel.org, kuni1840@gmail.com, 
	kuniyu@google.com, linux-mm@kvack.org, martineau@kernel.org, 
	matttbe@kernel.org, mhocko@kernel.org, mkoutny@suse.com, 
	mptcp@lists.linux.dev, muchun.song@linux.dev, ncardwell@google.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, roman.gushchin@linux.dev, 
	shakeel.butt@linux.dev, tj@kernel.org, willemb@google.com
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot ci has tested the following series

[v2] net-memcg: Decouple controlled memcg from sk->sk_prot->memory_allocated.
https://lore.kernel.org/all/20250811173116.2829786-1-kuniyu@google.com
* [PATCH v2 net-next 01/12] mptcp: Fix up subflow's memcg when CONFIG_SOCK_CGROUP_DATA=n.
* [PATCH v2 net-next 02/12] mptcp: Use tcp_under_memory_pressure() in mptcp_epollin_ready().
* [PATCH v2 net-next 03/12] tcp: Simplify error path in inet_csk_accept().
* [PATCH v2 net-next 04/12] net: Call trace_sock_exceed_buf_limit() for memcg failure with SK_MEM_RECV.
* [PATCH v2 net-next 05/12] net: Clean up __sk_mem_raise_allocated().
* [PATCH v2 net-next 06/12] net-memcg: Introduce mem_cgroup_from_sk().
* [PATCH v2 net-next 07/12] net-memcg: Introduce mem_cgroup_sk_enabled().
* [PATCH v2 net-next 08/12] net-memcg: Pass struct sock to mem_cgroup_sk_(un)?charge().
* [PATCH v2 net-next 09/12] net-memcg: Pass struct sock to mem_cgroup_sk_under_memory_pressure().
* [PATCH v2 net-next 10/12] net: Define sk_memcg under CONFIG_MEMCG.
* [PATCH v2 net-next 11/12] net-memcg: Store MEMCG_SOCK_ISOLATED in sk->sk_memcg.
* [PATCH v2 net-next 12/12] net-memcg: Decouple controlled memcg from global protocol memory accounting.

and found the following issue:
kernel build error

Full report is available here:
https://ci.syzbot.org/series/6fc666d9-cfec-413c-a98c-75c91ad6c07d

***

kernel build error

tree:      net-next
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/netdev/net-next.git
base:      37816488247ddddbc3de113c78c83572274b1e2e
arch:      amd64
compiler:  Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
config:    https://ci.syzbot.org/builds/a5d5d856-2809-4eee-87ca-2cd1630214ae/config

net/tls/tls_device.c:374:8: error: call to undeclared function 'sk_should_enter_memory_pressure'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]

***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

