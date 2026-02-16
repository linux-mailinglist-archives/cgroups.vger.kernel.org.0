Return-Path: <cgroups+bounces-13963-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +GwdI+axkmlTwgEAu9opvQ
	(envelope-from <cgroups+bounces-13963-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 16 Feb 2026 06:57:58 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF58514109F
	for <lists+cgroups@lfdr.de>; Mon, 16 Feb 2026 06:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 728EA300DE37
	for <lists+cgroups@lfdr.de>; Mon, 16 Feb 2026 05:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F712EBBB2;
	Mon, 16 Feb 2026 05:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g+wSirIu";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="s2KY2H0q"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3971C3BEB
	for <cgroups@vger.kernel.org>; Mon, 16 Feb 2026 05:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771221466; cv=none; b=OewPsS1t/KjkZxSkqDWqy4CYTg8u19/XXge6DGfC4SEQebTnOwhXRxb1KjXZ+2ffyHW0LpmcNsrF+AYkT2XXMckkIocPMCzCSxQon3mX21kCi/ntw8hKMXK4lG3J/6hwcAt1oeU9UvIONopHXC5N+REgVXl84d4LakCbB3XJi2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771221466; c=relaxed/simple;
	bh=wWnfOB1B5YKfXsdFiqtFASOV/4+VeW++dnsO0qW7FOw=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:References:
	 In-Reply-To:Content-Type; b=RR98tm4U5WDzGBwyE3oPu09dp2LDE6dRuWSF8EiA3hAVXIMNB59aDVeFJGA161a6KBAbXPPjBYnl8IeJM0xIk6L5P8lOvmrIBdK9hfptp3NQeYCdIE1mLf97KsTsPSCGsdRrwhU1aTGVl5XQJfKaatVWLi5PqSbqJ8us7HpJR4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g+wSirIu; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=s2KY2H0q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771221463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NnnrJaLSjYHr2sUH7bUQNDm3xvewf5fG9DccOqiXpl0=;
	b=g+wSirIuD3g2akqzdi6lUbVdjohzGhzfJmBrw9X+IG4m6OTytAdO1jd8cmKoKEkyCRP+cR
	E7AaHfY4HLSPYLS2vOTfFUeJQrjinpwIDR843oiyMbE0ikiLFcue8YAqNy+hrU5Tgv+yDZ
	39yqU0GYw/Ml/SdEq5boziF0shipHV4=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-342-Koz0oizYMtqIzgovHsThog-1; Mon, 16 Feb 2026 00:57:40 -0500
X-MC-Unique: Koz0oizYMtqIzgovHsThog-1
X-Mimecast-MFC-AGG-ID: Koz0oizYMtqIzgovHsThog_1771221460
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-896fbdb9968so227052806d6.1
        for <cgroups@vger.kernel.org>; Sun, 15 Feb 2026 21:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771221460; x=1771826260; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:user-agent:mime-version:date:message-id:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NnnrJaLSjYHr2sUH7bUQNDm3xvewf5fG9DccOqiXpl0=;
        b=s2KY2H0qF58zaAqkXOpjsk6+cIpxVLH76srl2yON0XCHsB3ufM3JcA2pmyxE/RWyUE
         cdsHSbyyBJiCy/bXTx0wLDZkdxxpwDEmC3QcM0Aj0hOaRcBopdElqx5p7Hv+ti24VNEE
         HDz4ElN4W34hZ/Tgn1qKldy3iDWG9sEfor5Moy/dntItXZTUbC5srgUzVBVRmA9So08y
         pr7Qu2Esn58goXVZDbT08ND9nG3YUtPUkkP/uyQ3bLbD4VX4QKeu5vEieSqJ4uqrbzle
         GOMat4vysByj1GkWqUsNrPGep93u6FidOu52RJNHBY+bgcRpqCqA4w64GKWS8dspwRdH
         NGAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771221460; x=1771826260;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NnnrJaLSjYHr2sUH7bUQNDm3xvewf5fG9DccOqiXpl0=;
        b=PwuQMP+T1ZH4t1u/KZMhrADUZFfjuZpKRyks4o8+qstI/kQ45272kZWgIWcNoC//9p
         VwbLT7zwckEq+xscjJlVdHi+m6lbjMhqYLCOV39JN4PaxBzVcnvUg8BJQ2K8zAviBa+h
         sfinVp6nXwERUfq8QbO64ygRboVHvwoFGdU8EAHCFHTkj4ZuQ5I5w3ke1ZQdRM+A3ay0
         m3SgVbf3FRlOkZPfJcEsy2bz2my+JDhuF4U57cNmM9NQajczUi8oFOizHw0TNuHM/7/B
         r6XHBeCJSHv2MeUQ2pL2izTJ9RBjHoW0iobdTgNmo9Oc6hEQty/2FQOkTiWhZiZa6LKt
         hYpg==
X-Forwarded-Encrypted: i=1; AJvYcCWubacurs7cu3HuTwrKs9efWcBI4xUxb68ecbC5O7/X1S7ML4R2Bv/MEoommHj9BAUnnhvNVgr/@vger.kernel.org
X-Gm-Message-State: AOJu0YzS7/6lwOO6glFsjbfdcqeQ4jBfU9zVfsks2LwjLjP4BAjRk1+t
	0OXDRT5kioqTo78jJIsaF5PjFcZNI0W+UbJ+K5IW0Yd1hhT8KVC7qq4G2ZeUzthQzhNReef4+qp
	bOj/f6/w069PqGVERKhXPyKeINZd2r7etsGuznNv+glfQ3ZiNrFAPg+RgqHY=
X-Gm-Gg: AZuq6aLbEb83gTOUECyXRkn7T6gVzycJuv5f2etZlMWT1wvHksLUeCd7TE9Harenapi
	Mnq4topcJ2xxPz4Pb6gNoMiZvVHmUu8hhgtXkVYyEuOt1auPvTP36w2mz40SIJF1Tf5qOPyGd+U
	rAlPiiUjU2uGM2UyPiBcF7nfKsnlXZ12wGgVP5wsRYJXdBm6Zo9xih7WP881c9JHYlBXakW8pMG
	PxH17liZq65k/N7qjJA4mtWQrC0U6d68Clq/+AHJDXd0VEOkY32eUQruGcJIOGTL1CNzIUGK3+4
	0rbQmbrcUUIoF+r+tXzdafgfbdlkKOJ5cXnChvaDE7EoHJw8UUb3yfrtpDryo5IxFc5I/XlBRUN
	ieCUFC88dQ+vCQBhozxyj3zwcgfl6ffnNU0Z0+U/SNgEGYUZb91HGhWgxrROodX73O+QC
X-Received: by 2002:a05:620a:720d:b0:8cb:40ca:2f8c with SMTP id af79cd13be357-8cb40ca31e4mr956509585a.31.1771221459897;
        Sun, 15 Feb 2026 21:57:39 -0800 (PST)
X-Received: by 2002:a05:620a:720d:b0:8cb:40ca:2f8c with SMTP id af79cd13be357-8cb40ca31e4mr956509185a.31.1771221459456;
        Sun, 15 Feb 2026 21:57:39 -0800 (PST)
Received: from ?IPV6:2601:600:947f:f020:85dc:d2b2:c5ee:e3c4? ([2601:600:947f:f020:85dc:d2b2:c5ee:e3c4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8971cd8b330sm146306406d6.29.2026.02.15.21.57.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Feb 2026 21:57:38 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <544a0eb5-3c03-463b-911b-6f3b8037f8e1@redhat.com>
Date: Mon, 16 Feb 2026 00:57:37 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [cgroups?] general protection fault in
 rebuild_sched_domains_locked
To: syzbot <syzbot+460792609a79c085f79f@syzkaller.appspotmail.com>,
 cgroups@vger.kernel.org, chenridong@huaweicloud.com, hannes@cmpxchg.org,
 linux-kernel@vger.kernel.org, mkoutny@suse.com,
 syzkaller-bugs@googlegroups.com, tj@kernel.org
References: <6992351f.050a0220.2757fb.0035.GAE@google.com>
Content-Language: en-US
In-Reply-To: <6992351f.050a0220.2757fb.0035.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=a512b4a06724b76a];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13963-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,appspotmail.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[llong@redhat.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups,460792609a79c085f79f];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: DF58514109F
X-Rspamd-Action: no action

On 2/15/26 4:05 PM, syzbot wrote:
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    37a93dd5c49b Merge tag 'net-next-7.0' of git://git.kernel...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1649d073980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a512b4a06724b76a
> dashboard link: https://syzkaller.appspot.com/bug?extid=460792609a79c085f79f
> compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=152086e6580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=139c2eef980000
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/0dedaafff2ad/disk-37a93dd5.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/aa7fae081497/vmlinux-37a93dd5.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/9096b39b53e1/bzImage-37a93dd5.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+460792609a79c085f79f@syzkaller.appspotmail.com
>
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
> R13: 00007fe00de15fac R14: 00007fe00de15fa0 R15: 00007fe00de15fa0
>   </TASK>
> Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] SMP KASAN PTI
> KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
> CPU: 1 UID: 0 PID: 5994 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/24/2026
> RIP: 0010:bitmap_subset include/linux/bitmap.h:433 [inline]
> RIP: 0010:cpumask_subset include/linux/cpumask.h:836 [inline]
> RIP: 0010:rebuild_sched_domains_locked+0x2aa/0x980 kernel/cgroup/cpuset.c:967
> Code: 7d 05 00 41 83 c4 01 89 de 48 83 c5 08 44 89 e7 e8 fb 76 05 00 41 39 dc 0f 8d 4c 04 00 00 e8 fd 7c 05 00 48 89 e8 48 c1 e8 03 <42> 80 3c 30 00 0f 85 1d 06 00 00 48 8b 04 24 48 23 45 00 31 ff 44
> RSP: 0018:ffffc90003ecfbc0 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000020
> RDX: ffff888028de0000 RSI: ffffffff8200f003 RDI: ffffffff8df14f28
> RBP: 0000000000000000 R08: 0000000000000cc0 R09: 00000000ffffffff
> R10: ffffffff8e7d95b3 R11: 0000000000000001 R12: 0000000000000000
> R13: 00000000000f4240 R14: dffffc0000000000 R15: 0000000000000000
> FS:  000055555c694500(0000) GS:ffff8881246a5000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000001b2f463fff CR3: 000000003704c000 CR4: 00000000003526f0
> Call Trace:
>   <TASK>
>   rebuild_sched_domains_cpuslocked kernel/cgroup/cpuset.c:983 [inline]
>   rebuild_sched_domains+0x21/0x40 kernel/cgroup/cpuset.c:990
>   sched_rt_handler+0xb5/0xe0 kernel/sched/rt.c:2911
>   proc_sys_call_handler+0x47f/0x5a0 fs/proc/proc_sysctl.c:600
>   new_sync_write fs/read_write.c:595 [inline]
>   vfs_write+0x6ac/0x1070 fs/read_write.c:688
>   ksys_write+0x12a/0x250 fs/read_write.c:740
>   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>   do_syscall_64+0x106/0xf80 arch/x86/entry/syscall_64.c:94
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fe00db9bf79
> Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fff27bcda88 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 00007fe00de15fa0 RCX: 00007fe00db9bf79
> RDX: 00000000000000f6 RSI: 0000200000000000 RDI: 0000000000000003
> RBP: 00007fff27bcdaf0 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
> R13: 00007fe00de15fac R14: 00007fe00de15fa0 R15: 00007fe00de15fa0
>   </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:bitmap_subset include/linux/bitmap.h:433 [inline]
> RIP: 0010:cpumask_subset include/linux/cpumask.h:836 [inline]
> RIP: 0010:rebuild_sched_domains_locked+0x2aa/0x980 kernel/cgroup/cpuset.c:967
> Code: 7d 05 00 41 83 c4 01 89 de 48 83 c5 08 44 89 e7 e8 fb 76 05 00 41 39 dc 0f 8d 4c 04 00 00 e8 fd 7c 05 00 48 89 e8 48 c1 e8 03 <42> 80 3c 30 00 0f 85 1d 06 00 00 48 8b 04 24 48 23 45 00 31 ff 44
> RSP: 0018:ffffc90003ecfbc0 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000020
> RDX: ffff888028de0000 RSI: ffffffff8200f003 RDI: ffffffff8df14f28
> RBP: 0000000000000000 R08: 0000000000000cc0 R09: 00000000ffffffff
> R10: ffffffff8e7d95b3 R11: 0000000000000001 R12: 0000000000000000
> R13: 00000000000f4240 R14: dffffc0000000000 R15: 0000000000000000
> FS:  000055555c694500(0000) GS:ffff8881246a5000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000001b2f463fff CR3: 000000003704c000 CR4: 00000000003526f0
> ----------------
> Code disassembly (best guess), 1 bytes skipped:
>     0:	05 00 41 83 c4       	add    $0xc4834100,%eax
>     5:	01 89 de 48 83 c5    	add    %ecx,-0x3a7cb722(%rcx)
>     b:	08 44 89 e7          	or     %al,-0x19(%rcx,%rcx,4)
>     f:	e8 fb 76 05 00       	call   0x5770f
>    14:	41 39 dc             	cmp    %ebx,%r12d
>    17:	0f 8d 4c 04 00 00    	jge    0x469
>    1d:	e8 fd 7c 05 00       	call   0x57d1f
>    22:	48 89 e8             	mov    %rbp,%rax
>    25:	48 c1 e8 03          	shr    $0x3,%rax
> * 29:	42 80 3c 30 00       	cmpb   $0x0,(%rax,%r14,1) <-- trapping instruction
>    2e:	0f 85 1d 06 00 00    	jne    0x651
>    34:	48 8b 04 24          	mov    (%rsp),%rax
>    38:	48 23 45 00          	and    0x0(%rbp),%rax
>    3c:	31 ff                	xor    %edi,%edi
>    3e:	44                   	rex.R

The cpuset.c:967 is:

     966         for (i = 0; i < ndoms; ++i) {
     967                 if (WARN_ON_ONCE(!cpumask_subset(doms[i], 
cpu_active_mask)))
     968                         return;

The oops was caused by accessing doms[i] which was kmalloc'ed in 
generate_sched_domains() by calling alloc_sched_domains() in 
kernel/sched/topology.c. Looking at the console log just before the 
oops, I saw

[  124.398850][ T5994] FAULT_INJECTION: forcing a failure.
[  124.398850][ T5994] name failslab, interval 1, probability 0, space 
0, times 1
[  124.434865][ T5994] CPU: 1 UID: 0 PID: 5994 Comm: syz.0.17 Not 
tainted syzkaller #0 PREEMPT(full)
[  124.434909][ T5994] Hardware name: Google Google Compute 
Engine/Google Compute Engine, BIOS Google 01/24/2026
[  124.434936][ T5994] Call Trace:
[  124.434947][ T5994]  <TASK>
[  124.434959][ T5994]  dump_stack_lvl+0x100/0x190
[  124.435026][ T5994]  should_fail_ex.cold+0x5/0xa
[  124.435062][ T5994]  ? rebuild_sched_domains_locked+0x51/0x980
[  124.435113][ T5994]  should_failslab+0xc2/0x120
[  124.435153][ T5994]  __kmalloc_noprof+0xe0/0x850
[  124.435195][ T5994]  rebuild_sched_domains_locked+0x51/0x980
[  124.435266][ T5994]  rebuild_sched_domains+0x21/0x40
[  124.435314][ T5994]  sched_rt_handler+0xb5/0xe0
[  124.435359][ T5994]  proc_sys_call_handler+0x47f/0x5a0
[  124.435413][ T5994]  ? __pfx_proc_sys_call_handler+0x10/0x10
[  124.435475][ T5994]  vfs_write+0x6ac/0x1070
[  124.435511][ T5994]  ? __pfx_proc_sys_write+0x10/0x10
[  124.435562][ T5994]  ? __pfx_vfs_write+0x10/0x10
[  124.435597][ T5994]  ? __pfx_do_sys_openat2+0x10/0x10
[  124.435664][ T5994]  ksys_write+0x12a/0x250
[  124.435696][ T5994]  ? __pfx_ksys_write+0x10/0x10
[  124.435730][ T5994]  ? do_user_addr_fault+0x8d6/0x12f0
[  124.435787][ T5994]  do_syscall_64+0x106/0xf80
[  124.435834][ T5994]  ? clear_bhb_loop+0x40/0x90
[  124.435875][ T5994]  entry_SYSCALL_64_after_hwframe+0x77/0x7f

So it looks like the oops may be expected. It may not be a bug in the 
cpuset AFAICS.

Cheers,
Longman


