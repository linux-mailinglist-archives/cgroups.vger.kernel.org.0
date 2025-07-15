Return-Path: <cgroups+bounces-8734-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5330DB04D30
	for <lists+cgroups@lfdr.de>; Tue, 15 Jul 2025 03:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 973654A4A40
	for <lists+cgroups@lfdr.de>; Tue, 15 Jul 2025 01:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6CB4155A4E;
	Tue, 15 Jul 2025 01:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dRlJ3ZHA"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A98126F0A;
	Tue, 15 Jul 2025 01:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752541558; cv=none; b=cLbbuiNA/qhNJK1P5MAh2Uuw5g4gfvdBuqWLbGpWxUKjRbBGxtXyBMmIaMPpDgkPf+QX1s2DCoKZr1Fgqkqs7DqIjWn3iJ/OdQPa610ph5T+Hw2xsgizQnYXMcpNy6L+pEGUPzEL5Bq2IRcrhLHMWyujD1MpZ1712L7UtP8IfOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752541558; c=relaxed/simple;
	bh=A0hTniH+x2RIlsxY6IltL1S3FhpsKebbrS5Zlojgpj8=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:References:
	 From:In-Reply-To; b=ImHn8qApu6ds7o1TTeABRxOQVAZq1+xKvw/WExrHG83ZvsNe2OoTulPMbfUJL53TN8Ljzzovr6NbQ3radgcH68NEeoAIAWxso+wpPOCnikn0ozmQShEZ9ihgyVxKn8phnp62piuvA629e4ewYlSfKmnJ/+yapabTFnD7XYj5M3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dRlJ3ZHA; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-23636167b30so44684965ad.1;
        Mon, 14 Jul 2025 18:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752541556; x=1753146356; darn=vger.kernel.org;
        h=in-reply-to:from:content-language:references:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DsNuysHnySjHGZ38v+Y2t/hE8tvgCHyG5LyTja2e5ak=;
        b=dRlJ3ZHAdBtu2Uqt2LFUyjLYOgDWH/Vq+gpCcUdCEvSQYizft6NCFgDIUjGyPa2Thj
         0vCA140Yn2Ids0G6b+ncc+kFqGu9pLrv5JsTM5q7vTOF1wrlppqAyJwGBPA87EV6NAbq
         +XqReiPuE7fedbXdej4+/74iN74XYcVqDkzn1R/UojtmsW8COO73/kTYGh5VzOFcQU2m
         PJp37pfip5eevd0U/32gSx0vAEihswi+ZqXXODIWIpeLDB60o8YZLzNMrkyGu+8ZZ4M7
         HXjQsKRCelIjNlG/ZSRiM1h55lLotAhYSy+EeGwmwcZyYXQluxy/mPF/7aLlngeGVB76
         tGzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752541556; x=1753146356;
        h=in-reply-to:from:content-language:references:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DsNuysHnySjHGZ38v+Y2t/hE8tvgCHyG5LyTja2e5ak=;
        b=QbESPE+8A8PpQP6BcVcinp28dmuDDqHfYY35Qvn749dHpmmefbBBsCklgfPF3XAJTz
         6lzRUckGnSWMozRi5jCA0zx4khINB2Itm32nNwwm8W17xmvOteCTF33rntR/gfG9wrG4
         +Fd6W9bgEL6JsiFDd6sKjAyBLx28HdcFGDMiatwGjbJJRRQ/3/9c1NVAPgEcYGbR7E4u
         7Qj4UqLKCe+wr423r9UxydA//fxB4C5tloO9N09J9ZLBu9r/AitesB78F4HInMHAyqzk
         HgXgU4uiKVPRePCBRFgVbPQRUTKZr/C+Y7ZRSK60ug+VpCQ0FcCpDXPRBYs8DPKrHb3H
         ftFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAwq3Wnl4TT6cpF76ChFy4r8Y4hCEgC4FG9qMBkcsxY7Xx2tnCi1upkCe4s2uHLQ7/MKlfGq4rzfz+IdO5@vger.kernel.org, AJvYcCWToVAhA1OkwExkSFB/uqo6cfjEq7ZTNvtoJTV7R8hdCKxvyRRqCYWoXbaIlA3BOIeTQ0YGDyJK@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfd83WO4sSsQYb30H7pnRAF3r/qU62UejdQjvcXBvtpQjdB8jx
	Rjhk5jxJKeGZOaBz7mSHssy1Za9OnkIgI85ypFo469xNQqa7mApe04yh
X-Gm-Gg: ASbGncsrzpQE4p/xRqUvKo56J9Ae95KJ9hqvH6+5RhC7lOcbfmJEYy20v+lJvdSbYhK
	vDLV62AlLjQ9/AT4ykLenAFESDJy2MhAupVOL1ArLHQVgRLn0uGkCBxnxeZvntAZ0x8ETmoHSa8
	J55lhtdHmhgw1PqMLM8tyXNnyvILKkXn+sWJwWxC46Z/b4FFZLXlFB55wdHIoRlPZ3+AsIKN7vz
	OxJu1nuT0p0EZPdk8VSbF+XcYKx1PE8F4eOPmp3mJhhedv3FL+0BgYYR6HTgCBGrMFDbGsZTQ3l
	IuT2WoPreIWnlGKP+Z6B9bzKn4Xz1mZVqf0iNfCEjppZTXZOi/hCTHYqnU3UvOqyMN8/d+VHCxa
	0cyTwuI+3YfGviR/vkedKHYfwurxzxqZB4SXdlRzqvLK908cbrqQKC3hAUkyTbJ/yETpZ
X-Google-Smtp-Source: AGHT+IHOb37KOMro1alwRUBbaMR92TAotAWUceH7nrnWTECpzpr3Kf8iAkU4P2gXq/jf3ssI1PeiEQ==
X-Received: by 2002:a17:902:a50f:b0:235:6f7:b918 with SMTP id d9443c01a7336-23dee0b4b3dmr161892975ad.28.1752541555895;
        Mon, 14 Jul 2025 18:05:55 -0700 (PDT)
Received: from [192.168.1.117] (c-67-180-10-175.hsd1.ca.comcast.net. [67.180.10.175])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4322b2dsm100995485ad.92.2025.07.14.18.05.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 18:05:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------EL3r9i77dQiHK2Wt8EcndV4y"
Message-ID: <2b10ba94-7113-4b27-80bb-fd4ef7508fda@gmail.com>
Date: Mon, 14 Jul 2025 18:05:50 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [cgroups?] WARNING in css_rstat_exit
To: syzbot <syzbot+8d052e8b99e40bc625ed@syzkaller.appspotmail.com>,
 cgroups@vger.kernel.org, hannes@cmpxchg.org, linux-kernel@vger.kernel.org,
 mkoutny@suse.com, syzkaller-bugs@googlegroups.com, tj@kernel.org
References: <6874b1d8.a70a0220.3b380f.0051.GAE@google.com>
Content-Language: en-US
From: JP Kobryn <inwardvessel@gmail.com>
In-Reply-To: <6874b1d8.a70a0220.3b380f.0051.GAE@google.com>

This is a multi-part message in MIME format.
--------------EL3r9i77dQiHK2Wt8EcndV4y
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

#syz test

On 7/14/25 12:29 AM, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    5d5d62298b8b Merge tag 'x86_urgent_for_v6.16_rc6' of git:/..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=11dabd82580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=84eae426cbd8669c
> dashboard link: https://syzkaller.appspot.com/bug?extid=8d052e8b99e40bc625ed
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=162c47d4580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/d2d0d46a0e87/disk-5d5d6229.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/0bf6381177a8/vmlinux-5d5d6229.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/2f3ae8f165f2/bzImage-5d5d6229.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+8d052e8b99e40bc625ed@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 9 at kernel/cgroup/rstat.c:497 css_rstat_exit+0x368/0x470 kernel/cgroup/rstat.c:497
> Modules linked in:
> CPU: 0 UID: 0 PID: 9 Comm: kworker/0:0 Not tainted 6.16.0-rc5-syzkaller-00276-g5d5d62298b8b #0 PREEMPT(full)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
> Workqueue: cgroup_destroy css_free_rwork_fn
> RIP: 0010:css_rstat_exit+0x368/0x470 kernel/cgroup/rstat.c:497
> Code: 00 00 00 fc ff df 48 c1 ea 03 80 3c 02 00 0f 85 0e 01 00 00 49 c7 85 70 05 00 00 00 00 00 00 e9 00 ff ff ff e8 d9 09 07 00 90 <0f> 0b 90 e9 3e ff ff ff e8 cb 09 07 00 90 0f 0b 90 e9 30 ff ff ff
> RSP: 0018:ffffc900000e7bc0 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: ffff8881404a4e00 RCX: ffff888124720000
> RDX: ffff88801e298000 RSI: ffffffff81b45507 RDI: ffffffff8df37da0
> RBP: ffff8881404a4e08 R08: 0000000000000005 R09: 0000000000000007
> R10: 0000000000000000 R11: 0000000000000001 R12: ffff8881404a4e20
> R13: 0000000000000000 R14: 0000000000000003 R15: dffffc0000000000
> FS:  0000000000000000(0000) GS:ffff888124720000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000000 CR3: 0000000034892000 CR4: 00000000003526f0
> Call Trace:
>   <TASK>
>   css_free_rwork_fn+0x80/0x12e0 kernel/cgroup/cgroup.c:5449
>   process_one_work+0x9cf/0x1b70 kernel/workqueue.c:3238
>   process_scheduled_works kernel/workqueue.c:3321 [inline]
>   worker_thread+0x6c8/0xf10 kernel/workqueue.c:3402
>   kthread+0x3c2/0x780 kernel/kthread.c:464
>   ret_from_fork+0x5d7/0x6f0 arch/x86/kernel/process.c:148
>   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>   </TASK>
> 
> 
> ---
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.

--------------EL3r9i77dQiHK2Wt8EcndV4y
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-cgroup-make-sure-css_rstat_init-is-called-before-css.patch"
Content-Disposition: attachment;
 filename*0="0001-cgroup-make-sure-css_rstat_init-is-called-before-css.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSAzODEyMzViOWYyYWE1MDBiNmUyOTcxZTk4ZWE4NGVkYzEwN2NkMWQ4IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKUCBLb2JyeW4gPGlud2FyZHZlc3NlbEBnbWFpbC5j
b20+CkRhdGU6IE1vbiwgMTQgSnVsIDIwMjUgMTY6NDU6NTUgLTA3MDAKU3ViamVjdDogW1BB
VENIXSBjZ3JvdXA6IG1ha2Ugc3VyZSBjc3NfcnN0YXRfaW5pdCgpIGlzIGNhbGxlZCBiZWZv
cmUgY3NzX3JzdGF0X2V4aXQoKQoKVGVzdCBhZ2FpbnN0IHN5emJvdCByZXByby4KClNpZ25l
ZC1vZmYtYnk6IEpQIEtvYnJ5biA8aW53YXJkdmVzc2VsQGdtYWlsLmNvbT4KLS0tCiBrZXJu
ZWwvY2dyb3VwL2Nncm91cC5jIHwgMTEgKysrKysrKy0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA3
IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEva2VybmVsL2Nn
cm91cC9jZ3JvdXAuYyBiL2tlcm5lbC9jZ3JvdXAvY2dyb3VwLmMKaW5kZXggYTcyM2I3ZGM2
ZTRlLi5lNmM1Yzk5OGVhZDYgMTAwNjQ0Ci0tLSBhL2tlcm5lbC9jZ3JvdXAvY2dyb3VwLmMK
KysrIGIva2VybmVsL2Nncm91cC9jZ3JvdXAuYwpAQCAtNTY2OSw2ICs1NjY5LDEyIEBAIHN0
YXRpYyBzdHJ1Y3QgY2dyb3VwX3N1YnN5c19zdGF0ZSAqY3NzX2NyZWF0ZShzdHJ1Y3QgY2dy
b3VwICpjZ3JwLAogCiAJaW5pdF9hbmRfbGlua19jc3MoY3NzLCBzcywgY2dycCk7CiAKKwll
cnIgPSBjc3NfcnN0YXRfaW5pdChjc3MpOworCWlmIChlcnIpIHsKKwkJc3MtPmNzc19mcmVl
KGNzcyk7CisJCWdvdG8gZXJyX291dDsKKwl9CisKIAllcnIgPSBwZXJjcHVfcmVmX2luaXQo
JmNzcy0+cmVmY250LCBjc3NfcmVsZWFzZSwgMCwgR0ZQX0tFUk5FTCk7CiAJaWYgKGVycikK
IAkJZ290byBlcnJfZnJlZV9jc3M7CkBAIC01Njc4LDEwICs1Njg0LDYgQEAgc3RhdGljIHN0
cnVjdCBjZ3JvdXBfc3Vic3lzX3N0YXRlICpjc3NfY3JlYXRlKHN0cnVjdCBjZ3JvdXAgKmNn
cnAsCiAJCWdvdG8gZXJyX2ZyZWVfY3NzOwogCWNzcy0+aWQgPSBlcnI7CiAKLQllcnIgPSBj
c3NfcnN0YXRfaW5pdChjc3MpOwotCWlmIChlcnIpCi0JCWdvdG8gZXJyX2ZyZWVfY3NzOwot
CiAJLyogQGNzcyBpcyByZWFkeSB0byBiZSBicm91Z2h0IG9ubGluZSBub3csIG1ha2UgaXQg
dmlzaWJsZSAqLwogCWxpc3RfYWRkX3RhaWxfcmN1KCZjc3MtPnNpYmxpbmcsICZwYXJlbnRf
Y3NzLT5jaGlsZHJlbik7CiAJY2dyb3VwX2lkcl9yZXBsYWNlKCZzcy0+Y3NzX2lkciwgY3Nz
LCBjc3MtPmlkKTsKQEAgLTU2OTcsNiArNTY5OSw3IEBAIHN0YXRpYyBzdHJ1Y3QgY2dyb3Vw
X3N1YnN5c19zdGF0ZSAqY3NzX2NyZWF0ZShzdHJ1Y3QgY2dyb3VwICpjZ3JwLAogZXJyX2Zy
ZWVfY3NzOgogCUlOSVRfUkNVX1dPUksoJmNzcy0+ZGVzdHJveV9yd29yaywgY3NzX2ZyZWVf
cndvcmtfZm4pOwogCXF1ZXVlX3JjdV93b3JrKGNncm91cF9kZXN0cm95X3dxLCAmY3NzLT5k
ZXN0cm95X3J3b3JrKTsKK2Vycl9vdXQ6CiAJcmV0dXJuIEVSUl9QVFIoZXJyKTsKIH0KIAot
LSAKMi40Ny4xCgo=

--------------EL3r9i77dQiHK2Wt8EcndV4y--

