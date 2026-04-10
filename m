Return-Path: <cgroups+bounces-15206-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNuRBTvK2GmkiAgAu9opvQ
	(envelope-from <cgroups+bounces-15206-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 10 Apr 2026 12:00:27 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F83F3D5568
	for <lists+cgroups@lfdr.de>; Fri, 10 Apr 2026 12:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CEE8B303FF95
	for <lists+cgroups@lfdr.de>; Fri, 10 Apr 2026 09:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2B536E46E;
	Fri, 10 Apr 2026 09:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="SICDvlBv"
X-Original-To: cgroups@vger.kernel.org
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256F932D7F8;
	Fri, 10 Apr 2026 09:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775814389; cv=none; b=jrV0LJJHmeyxe0eifE29g/0QvcGaq1hENWHyKLMrokbpSAtpfAZfUFQ2i8cLeQ6enS977wTaVy4gmjGM5UZCrz/qLZaZNGiEqaISuDGKJC3lk9zPNDVOghG3cxJqjW6DESEm/D4iZFAOzZ7S2Z/OXx8UjpjC6BvtwL4ghqxEfg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775814389; c=relaxed/simple;
	bh=RDj4KN9VX+qJcrgVVFyxD2e1ZEF9ww8NOQ/IHZthGzc=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=fcPLwNgcDrtS22/FQaijDrnPOcAJUig37X2TwL+SftOSX8nfjU1+GMvYFMy2xB2eSEGl1N0RPre32DswoPk1uKxk2C5DlWoXFmFuXOjgELdY8nhDLNGfojsQJdFiNxzsPNyZMOdy+Rdg7Cr4aeBAyrJ+4KhZ9drOcF7o/sjUBtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=SICDvlBv; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1775814377; bh=jeNH6Y0edL5ZR5HF5723S4Ka15CNgNsIlGhIRcCDD3g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SICDvlBvnCMqQt7lZn7r4jFSWsydyer7zuZW5JVqjU8zTrG946CGQGeGxVhu9o9lO
	 Pf2tgXOeayvNSVeDcvbJcTb5nLyT7wOCaRz+SoYtopclroN/WQfdSBijjXYnDPZDha
	 Upz8VK/k4Yi2qSusjNC8IKDpQmf1pN85zvM8MUYo=
Received: from lxu-ped-host.. ([111.198.231.89])
	by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
	id B41B3CEE; Fri, 10 Apr 2026 17:45:01 +0800
X-QQ-mid: xmsmtpt1775814301tkp9pi3ue
Message-ID: <tencent_90482DC16CB494F8EB1AEDE6CDD87B3A6F0A@qq.com>
X-QQ-XMAILINFO: NbgegmlEc3Juro3w4CktlfwiZsrg9sJ+IaXIPEFjJntpqxG0N7MXEFEobm+zzJ
	 J/aqjJLhR0qIlOJrX0CY6CkmZkFA3GQX+9vVuKqmX9iYlREyZZdjXsps+NU6/lkevLo8Y2tVRsIL
	 q/N+HaHBi95R7A5zoAMqdkrGELEgh8UYnXLmyGacBHsKEfy19/k6E5WJ53ooHo23OedpzHows64z
	 Y5Su1Am1ektpiLIyOwor9ezYF/6j+x/JRHrRPT1QaWQ7MgVG98blUcAGjNZaOVtU9JcwgiitRsSv
	 ewSZSFF6nVoqKkIdTC8uT6P1M2KxdJMCaFRY3ydXpwZkhlYQg0z1t7PaxHiKMTdD6VNCeG9ILbTZ
	 kKnynYkt4BrbpVQliLBsvPBKcMLAKGpzhCdhgASWdIwbkdEiR5z8pxaNFm87EbPGzy3bZ2NPX8AP
	 5aIDole/R9kdOF3hjioVJ37w+RIPMeAIw342pfrY8rqbVB+voLvAG7EagGUlaLAeCd+iy0l/ek/N
	 LP7Fwq1DxX4RP2lqDsljabAHqBIxgbOND8wfITc60YFGRWyfMb3l3TCrbcqdr+nOmVexQnY/iJaI
	 69aUMxk9GfhKaVMdQ2zO8AXUE9PA6HyskBTmw1u7KvuAXHFWkMnSV+Sz0BVjsFHHgC7wEPs67pIY
	 bvZBmxm5HiECtoaN7FR7X8YUs+RSTHz62Kww5N7PSySbodFQk8ltozUd8hGr7u+LsaAd7WTb20wB
	 ouPe7l+5shohwonJxbwkWut6U4GY1LzDx6qx6DP1gWJMarWUqxdJtLWyv27O9r049sIq3e6iQZS3
	 87oqdoLyHYFPhBE/WtvKjHsrpxrvWVDc392Wdm//3tjnTcT3ORZOA+/lx51W0mlPyjDKT2ttXhfY
	 yYjnZ2P3cJTcUPKrHET1w91ksF5CK0ynxIXrHmWZHddVSGVrM14YfxzxiPu9fkivp1WzgRlmtmVa
	 Dl+BOf5errf2sfibBc8Y7QKCRWqrZplLHmRFW/EDyymxFHrXw7TezXwz00H4LWbZPpCkNmjHflbQ
	 kOR+ZfDJ0PAm3RWJe+M4Q/F+mr8Rg=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
From: Edward Adam Davis <eadavis@qq.com>
To: chenridong@huaweicloud.com
Cc: cgroups@vger.kernel.org,
	eadavis@qq.com,
	hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org,
	mkoutny@suse.com,
	syzbot+33e571025d88efd1312c@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	tj@kernel.org
Subject: Re: [PATCH] sched/psi: fix race between file release and pressure write
Date: Fri, 10 Apr 2026 17:45:02 +0800
X-OQ-MSGID: <20260410094501.140667-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <dde2339e-fd2d-448c-9f2c-d852571b67de@huaweicloud.com>
References: <dde2339e-fd2d-448c-9f2c-d852571b67de@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qq.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[qq.com:s=s201512];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-15206-lists,cgroups=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,qq.com,cmpxchg.org,suse.com,syzkaller.appspotmail.com,googlegroups.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[eadavis@qq.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[qq.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[qq.com];
	TAGGED_RCPT(0.00)[cgroups,33e571025d88efd1312c];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qq.com:dkim,qq.com:email,qq.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,syzkaller.appspot.com:url,appspotmail.com:email]
X-Rspamd-Queue-Id: 5F83F3D5568
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 10 Apr 2026 17:00:55 +0800, Chen Ridong wrote:
> > A potential race condition exists between pressure write and cgroup file
> > release regarding the priv member of struct kernfs_open_file, which
> > triggers the uaf reported in [1].
> > 
> > The scope of the cgroup_mutex protection in pressure write has been
> > expanded to prevent the uaf described in [1].
> > 
> > [1]
> > BUG: KASAN: slab-use-after-free in pressure_write+0xa4/0x210 kernel/cgroup/cgroup.c:4011
> > Call Trace:
> >  pressure_write+0xa4/0x210 kernel/cgroup/cgroup.c:4011
> >  cgroup_file_write+0x36f/0x790 kernel/cgroup/cgroup.c:4311
> >  kernfs_fop_write_iter+0x3b0/0x540 fs/kernfs/file.c:352
> > 
> > Allocated by task 9352:
> >  cgroup_file_open+0x90/0x3a0 kernel/cgroup/cgroup.c:4256
> >  kernfs_fop_open+0x9eb/0xcb0 fs/kernfs/file.c:724
> >  do_dentry_open+0x83d/0x13e0 fs/open.c:949
> > 
> > Freed by task 9353:
> >  cgroup_file_release+0xd6/0x100 kernel/cgroup/cgroup.c:4283
> >  kernfs_release_file fs/kernfs/file.c:764 [inline]
> >  kernfs_drain_open_files+0x392/0x720 fs/kernfs/file.c:834
> >  kernfs_drain+0x470/0x600 fs/kernfs/dir.c:525
> > 
> > Fixes: 0e94682b73bf ("psi: introduce psi monitor")
> > Reported-by: syzbot+33e571025d88efd1312c@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=33e571025d88efd1312c
> > Tested-by: syzbot+33e571025d88efd1312c@syzkaller.appspotmail.com
> > Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> > ---
> >  kernel/cgroup/cgroup.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> 
> Hi Edward,
> 
> Thank you for fixing this issue. The patch looks plausible, but the root cause
> is not entirely clear from the diff alone. Could you please add more details to
> the commit message explaining how the issue occurs and why this change resolves it?
Consider the following scenario involving execution on two separate CPUs:

   CPU0					CPU1
   ====					====
					vfs_rmdir()
					kernfs_iop_rmdir()
					cgroup_rmdir()
					cgroup_kn_lock_live()
					cgroup_destroy_locked()
					cgroup_addrm_files()
					cgroup_rm_file()
					kernfs_remove_by_name()
					kernfs_remove_by_name_ns()
 vfs_write()				__kernfs_remove()
 new_sync_write()			kernfs_drain()
 kernfs_fop_write_iter()		kernfs_drain_open_files()
 cgroup_file_write()			kernfs_release_file()
 pressure_write()			cgroup_file_release()
 ctx = of->priv;
					kfree(ctx);
 					of->priv = NULL;
					cgroup_kn_unlock()
 cgroup_kn_lock_live()
 if (ctx->psi.trigger)  // here, trigger uaf for ctx, that is of->priv

The cgroup_rmdir() is protected by the cgroup_mutex, it also safeguards
the memory deallocation of of->priv performed within cgroup_file_release().
However, the operations involving of->priv executed within pressure_write()
are not entirely covered by the protection of cgroup_mutex. Consequently,
if the code in pressure_write(), specifically the section handling the
ctx variable executes after cgroup_file_release() has completed, a uaf
vulnerability involving of->priv is triggered.

Therefore, the issue can be resolved simply by extending the scope of
the cgroup_mutex lock within pressure_write() to encompass all code
paths involving of->priv, thereby properly synchronizing the race condition
occurring between cgroup_file_release() and pressure_write().

Edward
BR


