Return-Path: <cgroups+bounces-16797-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QH8kH90OKWo5PgMAu9opvQ
	(envelope-from <cgroups+bounces-16797-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 10 Jun 2026 09:14:37 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75247666867
	for <lists+cgroups@lfdr.de>; Wed, 10 Jun 2026 09:14:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ZCvLnEJw;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16797-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16797-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CF962302E5DD
	for <lists+cgroups@lfdr.de>; Wed, 10 Jun 2026 07:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C7538655D;
	Wed, 10 Jun 2026 07:11:54 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f66.google.com (mail-qv1-f66.google.com [209.85.219.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F358E386575
	for <cgroups@vger.kernel.org>; Wed, 10 Jun 2026 07:11:52 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781075514; cv=pass; b=h7J1SbCSb9vNNwfetZ9BPprZ7V0i8oKDenQTRX0Q/WhqTFxouAKXhPbRX47Kt43bJxde6pcpTfnClej5U8f4gZ5V0QxDTLMRbiZwEre+v7fxgKh9NuAlRtGSjsQ1P9FujXn/BJn9fJLoHZj18kb8H1wsgcETmuWsi3Ccfxth7V8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781075514; c=relaxed/simple;
	bh=OOBl4r2K+H5MCU+kqmD8fkEkBhXTvYhkdVbUONu3i3k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bO/VUvlB9ZHe5G2o51hAm4BTkl4kjjiGdsNImxe/kw3xrxXneUKKqm7IWkxXzMcPQJMuFrlfXVMldxY/DvgrYHwNxKXFZw0IYaESy5OxP+J625If3SabAWwITLLrZcpMf21yBezTZYBO+p8+iUeg4FFjcNgd8OW4hH1bbJLhlkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZCvLnEJw; arc=pass smtp.client-ip=209.85.219.66
Received: by mail-qv1-f66.google.com with SMTP id 6a1803df08f44-8ccda0ac4fcso65273646d6.2
        for <cgroups@vger.kernel.org>; Wed, 10 Jun 2026 00:11:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781075512; cv=none;
        d=google.com; s=arc-20240605;
        b=GN2OJMYoeZmINQ8cyz7ESnOAXExldcqoARG0W2NhnyxFCd2bs3+ute1it0cjJK5Nfu
         sF8oPtbta5PyiVJVQsk2xScxD9JLGyFjFoNDOgz0eUJnPGFn2z0bZJvNQ7ns05sMTvJx
         8X/IESRz3pmmVGwjPaWiIGwFdyrayUg+irjm4NniUVuFhHPfx5dSu4hGk5UW3UZvZPht
         oJvCJ+4YI5zj0QiCCWkRRIDyywIskSoJRhhOIA0ZoKQbyBqtetGF6qHMheZr1SpwEO6R
         f6khSNKgjiEHp/G6xMiR2khxP1yoeFizNw9ujosz4gYxWbcM8La94eGWsGNVpyDMsh5L
         BKnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+Wq1Eb2Bd1DGovO0OKoTQZ3mhvX7ezknz00wtb7hve8=;
        fh=RKOm85blgSQEJ21eLAQStxOSFFjX6BS2sLExxApiWRk=;
        b=MFCMzQ0V2V1YY+ydSzKoNUnLyB0p5WvpRBBVu2qxJL3hX1nYuBnCuUX/4Gl4faros3
         G2T8TYOVXKLbI+7gpnCegncN0YoD9VKpVM3agMQIfUR09h4Nox8tOZrqsCbHnZSq5hqA
         505SmdnN4vNEoULS1rs8ferzn4uYAND0hIVz1UgtmE0WQX9Cln6rseI9aVVOjTwDFDS7
         KZ2CfKms9csby+BK0V2viqv+kMReE8fxeUS/skOaGFLtyMjdIip2KKvYAPHB+Zpe1rBh
         aYkBbQPyTajsP38aPDfjuZvZA1Uvi04/pP3hHi9khxl8YUETKbfSRjELPJgdZHfTe95Z
         guCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781075512; x=1781680312; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Wq1Eb2Bd1DGovO0OKoTQZ3mhvX7ezknz00wtb7hve8=;
        b=ZCvLnEJwc/xtpSSQnFMpnwlca2aF5Z3nMqblW4r5o9HA5hh5mKQXgh1YRmqkPls4Pr
         c63WO22L1D+WXqH+LuU4hgx4zyyZX5PFBZjpXTXeYkVJJEKb+TFjXtmLb15wNlSWOGmw
         t8pyjFq+2STp4BrbhlfG1pCtKaxtomgP9z46SgZuSI18jP6VA2CYqXs46W8H9+rt1hl3
         3p4IIvH4K+K6UGBAGhxzgAb53PEDwHlu+UgGS0uQlN+o/WY0xcepS07vgSn3Up9ARL2s
         yDhsmK8qqtpyqnXUxNQP2f4lXaOJlBQSkIjxeDfIQhGBWUa5Cxf0am47rfuEy8yt3NQf
         Jncg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781075512; x=1781680312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+Wq1Eb2Bd1DGovO0OKoTQZ3mhvX7ezknz00wtb7hve8=;
        b=Oqz6ucXqgZkUe3ImFm+Wlh0qIn3TWQFf+izWd5xT6qvpPKuiQICEyxKDBsaf+jqA6w
         ogF9OVa0oEu26FmlVytLP3S1IBd5kAbIg1Ddyt+hdRliyJoX2xwk+cS4mfoZNWmQwKD0
         +UU3cq/gz2vmjrLncQW+bf3zOIyykpanvzlR65/q2tiT1HN88s7wdeddP3DwqqVJMyDF
         BDeK/SOVBZPMJEyRGC1PbLmhCNRoo6WXv/KjhGR5ZwOBFpyETsuYwr6JVxdcs7YJOC78
         XVoJMex0r6Po7YGDRiys7csgk9jRaIkR1IHd8WaqnExm343zrJY+HxkXNaSezy689vHJ
         AlZg==
X-Forwarded-Encrypted: i=1; AFNElJ9drstMOyAZBSjDgD/A/uAcEpZDRjdcMqSNbT3E9IhGXWQyKBMHFNeRHB9HpnpBT1pxY7d6h153@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh1pPBloS5eN3g3w7vnubl3DbCgQaS+TQ5qv+Cwaw3U8o2d+XZ
	s90xgbM96Qih3jj31zSh5PCJd5i8ShAFfDZ+ickH0TchVJ+3sVJhLzHF9ZKPs7NAssTzXKKaogi
	BwT4RO1MXhlZxx/ln/Zr0JwgK05QEF8E=
X-Gm-Gg: Acq92OFCPq4JXPT4O6eLbVeiJron9Ae2Se2BrMMNkWpIJoPr46zPuFmLBZQNHozi14u
	IYra/2rBDWjxICZKuz8BruQn/jLV37xLHFO74nc73rLV0SWvKc2+fP6tWsZ9BUqBZU3x37HMiAy
	gf0ueuBEKcuze2DE1HYoAcKVRzUDmqro8P0nSDnnAOJ5lPBQuoNslpJaxTHwpvW5zA5iOVnAlhO
	IqcHcEJTeWnboRrXxSjeh1HOVDJPc/JyodtxQFKrRn/lV8ZPXxd8VwR/6BZMdmM8cHrqErJT3Bp
	zDQLCBOLKIkN2KTNBqVUec3+lVV7aKU=
X-Received: by 2002:a05:6214:212b:b0:8ce:3868:6700 with SMTP id
 6a1803df08f44-8cf1d82f62amr93944196d6.34.1781075511820; Wed, 10 Jun 2026
 00:11:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHPqNmxGfjsKGEJJaSCrJqoU9WHY3q8CX1oTA7GV5BBHvDzgpg@mail.gmail.com>
 <aigMzVNsQpz_J0oQ@localhost.localdomain>
In-Reply-To: <aigMzVNsQpz_J0oQ@localhost.localdomain>
From: Longxing Li <coregee2000@gmail.com>
Date: Wed, 10 Jun 2026 15:11:41 +0800
X-Gm-Features: AVVi8CdlwSvysGvLTy7U1sBQE0nHSzuWKq1GX3gujI1BZFdLHAaa7v3OIgRex-o
Message-ID: <CAHPqNmwdh5Je=hrvEVzK90j91h2kOqXDmF1vz9UTtfcn1LUO1A@mail.gmail.com>
Subject: Re: [Kernel Bug] INFO: task hung in cgroup_drain_dying
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: syzkaller@googlegroups.com, tj@kernel.org, hannes@cmpxchg.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:mkoutny@suse.com,m:syzkaller@googlegroups.com,m:tj@kernel.org,m:hannes@cmpxchg.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16797-lists,cgroups=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER(0.00)[coregee2000@gmail.com,cgroups@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[coregee2000@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mail.gmail.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 75247666867

sorry for not containing full information in last email. the config[1]
and report[2] are as follows. CONFIG_PROVE_LOCKING is not enabled in
our config.

[1] https://drive.google.com/file/d/1Bx2unEf-QntjVi8g6Zw7QNO6OP4cjGO_/view?=
usp=3Ddrive_link

[2] https://drive.google.com/file/d/1riFUIPWojkYVZu0B5BW8uVPocUWwibqN/view?=
usp=3Dsharing

and report plain text is as follows:

INFO: task systemd:1 blocked for more than 143 seconds.
      Not tainted 7.0.6 #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:systemd         state:D stack:20616 pid:1     tgid:1     ppid:0
   task_flags:0x400100 flags:0x00080001
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5298 [inline]
 __schedule+0x1006/0x5f00 kernel/sched/core.c:6911
 __schedule_loop kernel/sched/core.c:6993 [inline]
 schedule+0xe7/0x3a0 kernel/sched/core.c:7008
 cgroup_drain_dying+0x1ed/0x360 kernel/cgroup/cgroup.c:6294
 cgroup_rmdir+0x38/0x300 kernel/cgroup/cgroup.c:6309
 kernfs_iop_rmdir+0x10a/0x180 fs/kernfs/dir.c:1311
 vfs_rmdir fs/namei.c:5344 [inline]
 vfs_rmdir+0x340/0x860 fs/namei.c:5317
 filename_rmdir+0x3be/0x510 fs/namei.c:5399
 __do_sys_rmdir fs/namei.c:5422 [inline]
 __se_sys_rmdir fs/namei.c:5419 [inline]
 __x64_sys_rmdir+0x47/0x90 fs/namei.c:5419
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x11b/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb6c32a61c7
RSP: 002b:00007fff90d2bc98 EFLAGS: 00000202 ORIG_RAX: 0000000000000054
RAX: ffffffffffffffda RBX: 000055c177d80fb0 RCX: 00007fb6c32a61c7
RDX: 00007fb6c3387be0 RSI: 0000000000000000 RDI: 000055c177eb1300
RBP: 00007fb6c35eb2da R08: 0000000000000000 R09: 0000000000000001
R10: 0000000000000100 R11: 0000000000000202 R12: 0000000000000000
R13: 00007fb6c2ddb6c8 R14: 0000000000000001 R15: 0000000000000000
 </TASK>

Showing all locks held in the system:
3 locks held by systemd/1:
 #0: ffff8880294f8420 (sb_writers#10){.+.+}-{0:0}, at:
filename_rmdir+0x2cc/0x510 fs/namei.c:5388
 #1: ffff888034d16e98 (&type->i_mutex_dir_key#6/1){+.+.}-{4:4}, at:
inode_lock_nested include/linux/fs.h:1073 [inline]
 #1: ffff888034d16e98 (&type->i_mutex_dir_key#6/1){+.+.}-{4:4}, at:
__start_dirop fs/namei.c:2929 [inline]
 #1: ffff888034d16e98 (&type->i_mutex_dir_key#6/1){+.+.}-{4:4}, at:
start_dirop fs/namei.c:2940 [inline]
 #1: ffff888034d16e98 (&type->i_mutex_dir_key#6/1){+.+.}-{4:4}, at:
filename_rmdir+0x318/0x510 fs/namei.c:5392
 #2: ffff8880386d7888 (&type->i_mutex_dir_key#6){++++}-{4:4}, at:
inode_lock include/linux/fs.h:1028 [inline]
 #2: ffff8880386d7888 (&type->i_mutex_dir_key#6){++++}-{4:4}, at:
vfs_rmdir fs/namei.c:5329 [inline]
 #2: ffff8880386d7888 (&type->i_mutex_dir_key#6){++++}-{4:4}, at:
vfs_rmdir+0xef/0x860 fs/namei.c:5317
6 locks held by kworker/u4:0/12:
3 locks held by kworker/u4:1/13:
1 lock held by khungtaskd/25:
 #0: ffffffff8e5e6ce0 (rcu_read_lock){....}-{1:3}, at:
rcu_lock_acquire include/linux/rcupdate.h:312 [inline]
 #0: ffffffff8e5e6ce0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock
include/linux/rcupdate.h:850 [inline]
 #0: ffffffff8e5e6ce0 (rcu_read_lock){....}-{1:3}, at:
debug_show_all_locks+0x36/0x1c0 kernel/locking/lockdep.c:6775
1 lock held by kcompactd0/28:
3 locks held by kworker/u4:3/45:
2 locks held by kworker/0:2/49:
3 locks held by kworker/u4:6/597:
3 locks held by kworker/u4:8/3491:
2 locks held by systemd-journal/5166:
2 locks held by systemd-udevd/5178:
1 lock held by in:imklog/9177:
4 locks held by sshd/9696:
2 locks held by syz-fuzzer/32911:
2 locks held by syz-executor.6/9754:
2 locks held by syz-executor.7/9774:
1 lock held by syz-executor.2/9812:
1 lock held by syz-executor.1/9902:
2 locks held by syz-executor.14/10080:
2 locks held by syz-executor.9/10842:
1 lock held by syz-executor.15/11893:
 #0: ffffffff8e5f25f8 (rcu_state.exp_mutex){+.+.}-{4:4}, at:
exp_funnel_lock+0x1a3/0x3b0 kernel/rcu/tree_exp.h:343
3 locks held by kworker/0:8/13140:
 #0: ffff88801b8a6948 ((wq_completion)events){+.+.}-{0:0}, at:
process_one_work+0x139e/0x1c60 kernel/workqueue.c:3263
 #1: ffffc9000cd37d08 (free_ipc_work){+.+.}-{0:0}, at:
process_one_work+0x938/0x1c60 kernel/workqueue.c:3264
 #2: ffffffff8e5f25f8 (rcu_state.exp_mutex){+.+.}-{4:4}, at:
exp_funnel_lock+0x1a3/0x3b0 kernel/rcu/tree_exp.h:343
2 locks held by kworker/0:10/13232:
3 locks held by kworker/u4:10/13343:
3 locks held by kworker/u4:12/14656:
1 lock held by syz-executor.13/24672:
3 locks held by kworker/u4:5/45131:
3 locks held by kworker/u4:9/46406:
3 locks held by kworker/u4:13/46990:
3 locks held by kworker/u4:16/46993:
2 locks held by syz-executor.8/48198:
3 locks held by kworker/u4:17/53143:
4 locks held by kworker/u4:18/53144:
2 locks held by systemd-rfkill/53174:
2 locks held by syz-executor.7/53471:
2 locks held by kworker/u4:20/53472:
3 locks held by kworker/u4:21/53476:
3 locks held by kworker/u4:22/53479:
3 locks held by kworker/u4:24/53484:
3 locks held by kworker/u4:25/53488:
2 locks held by kworker/0:19/53491:
2 locks held by systemd-udevd/53495:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 25 Comm: khungtaskd Not tainted 7.0.6 #1 PREEMPT(full)
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/=
2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1b0 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x2a0/0x350 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x29c/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:161 [inline]
 __sys_info lib/sys_info.c:157 [inline]
 sys_info+0x133/0x180 lib/sys_info.c:165
 check_hung_uninterruptible_tasks kernel/hung_task.c:346 [inline]
 watchdog+0xeac/0x11e0 kernel/hung_task.c:515
 kthread+0x38d/0x4a0 kernel/kthread.c:436
 ret_from_fork+0x942/0xe50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Michal Koutn=C3=BD <mkoutny@suse.com> =E4=BA=8E2026=E5=B9=B46=E6=9C=889=E6=
=97=A5=E5=91=A8=E4=BA=8C 20:58=E5=86=99=E9=81=93=EF=BC=9A
>
> Hello Longxing.
>
> On Tue, Jun 09, 2026 at 07:42:06PM +0800, Longxing Li <coregee2000@gmail.=
com> wrote:
> > We would like to report a new kernel bug found by our tool. INFO: task
> > hung in cgroup_drain_dying. Details are as follows.
>
> Thanks but I see no attachment.
>
> (Greater if you could add description as plaintext [1])
>
> > Kernel commit: v7.0.6
> > Kernel config: see attachment
>
> Do you have lockdep enabled (CONFIG_PROVE_LOCKING)? That may help
> debugging here.
>
> Thanks,
> Michal
>
> [1] https://docs.kernel.org/process/email-clients.html#general-preference=
s
>

