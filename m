Return-Path: <cgroups+bounces-17142-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jos3O4M/OWrypAcAu9opvQ
	(envelope-from <cgroups+bounces-17142-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 22 Jun 2026 15:58:27 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB526B0170
	for <lists+cgroups@lfdr.de>; Mon, 22 Jun 2026 15:58:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=IjsWRrCd;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17142-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17142-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 706F83012B23
	for <lists+cgroups@lfdr.de>; Mon, 22 Jun 2026 13:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF8C3B47E0;
	Mon, 22 Jun 2026 13:58:00 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f68.google.com (mail-qv1-f68.google.com [209.85.219.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCADC3B47FB
	for <cgroups@vger.kernel.org>; Mon, 22 Jun 2026 13:57:58 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782136679; cv=pass; b=D2EvHjQzFOxUaI/dswVVgMkiu3PYF84o/6vbtGQ7aJZ2RV6fSaOJwIVLVXiwuFAWuv+2+PHX5zleh4cebttaCN1mxLeaAiAvIjS3YuupaBBRD7e2cLzvrMy4Fu9nvZBrC30va5kDr6x7y2JYmTEqso42ZCchVkoJzrT0ra30iL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782136679; c=relaxed/simple;
	bh=xeMpY+tk3EL3AURtT5iX5a36Otp7aF4EWRfjAZ2BcQE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GLnvtnpnwRtXa1/3FluE/PQaDx3CqUgl1e1bs5STKvQlcHe9q7sh6eLoY2tT8YFxS1C4jymuzJoIM1pfAn/R4hYu9qS4dfytgmG0WKGlWEuZ/ntcHg6dTlwUPih5CsLS0zXf4NRhhPDKSVmRI0pP8diCRR2GzUd5ksSbiZQNpIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IjsWRrCd; arc=pass smtp.client-ip=209.85.219.68
Received: by mail-qv1-f68.google.com with SMTP id 6a1803df08f44-8e066990ff9so23133096d6.0
        for <cgroups@vger.kernel.org>; Mon, 22 Jun 2026 06:57:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782136678; cv=none;
        d=google.com; s=arc-20240605;
        b=G00Nq2lQMp+F8DDnZoIaphP0Zz6HcxSO6/b3jEqzQU4dXYfStkzWlzXucDB7wlnV2f
         Yqya/2kPTFw5Jwvt4+Easmn71e/R7jP2x6UUV6p1Dw2fVXn97v+Sk3feqkteS2M9hkmq
         ziX3+TqjIHsoUofGRfK1IezrS6Jg5k4k/mgrI5DEd/SnHaRSrtzsVs4LGhRqc2+9Ubqb
         hxekltWC4saYNRfbu5XaJ6nYXm6Ps9c//F4Cemtm4nhT2Kf6tGPMtEw9RcKlB0+V7STL
         aw5MJkdK4OfdHCayukxs1Ahe43nG4TfdPMPhd3odprd1TklKOE48JRVD6+t7129zyjuA
         1plQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jUnr3UAYtHqhk2E+w2G6vTfkxYd1Vit1UxH4n5RRjf8=;
        fh=gzNUFSNtAnkh6Et92mS9j5kSsx2vFxOuQnseaVeDcZw=;
        b=eHFHBa5kzioJO8sjU2eR9vZ3wr0I0x1ZPER9Ta3/qPw5UibKfYW4iyJMk271CVwVzv
         NMpGuJY8BjVifj7LdLgSVBlV7eiOkJiiGnpVCZxhl295pXEEmffce/zrHcT/cXXybILa
         QEZ21fkta8kW0+Wb3V4cs2zFrX+NMXJC2GbKciRzLlZOYYeEg78Mko7Vew+l0sSg1vFX
         xtoamMmDte5HRsrmZ84Iez6o2DhS3V/EEUiYKuxNSs2WhoSN1aSwAE82KOxb9GvASj4A
         uB01qDGGFx7GScaLGHmQd2Grn1mO90HeecoR91kWMc1fQVhXhaOxUNfspTC1NRN/LErH
         Mcyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782136678; x=1782741478; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jUnr3UAYtHqhk2E+w2G6vTfkxYd1Vit1UxH4n5RRjf8=;
        b=IjsWRrCdacX/MicQEqZTM2y5oLK23AEFzMHaIpj9OgNVXd/D7tjvI4//uDc3gBohxo
         x8FLYybTwVFli2KVuLUSNggge4B1NRMJQDHDuJtqj4l9IyzfxcbBz1QwB1Rs4uYj+bBG
         4i+xtDxniFJNS0oO+ttii2LPlVROAAo9Hx6Q+dhqG9iLbN4KeYUiuJCLSuPegiwYkPsL
         NBe+DqdQGrEejpkBngFvzJkgXVCZGqO+YjC+b9XsQOLVJCPnQlm3HFjAnjw74cc6sWvT
         bDz9yAs2Ph/J3TFPEHNUHCoWjW2nSXc45vw1+/WXy0A/8Ns61U4MaQiNCq7dS/uoSfuH
         L1PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782136678; x=1782741478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jUnr3UAYtHqhk2E+w2G6vTfkxYd1Vit1UxH4n5RRjf8=;
        b=PcQhF4iTwe9/sasHNDAbD64X63NWXjG27zKYAvTI8IOIAkUJnVC8q88pfD9mOo8Ex/
         B2vVCqheUpyM8aAqWPGFYgCsNlfMhy/Y+/IgfqW5NEg4kcdu6Mlp5HMrVoAoBsoNLRfX
         1obOFqWfeTPkcRyeUPRe81sJ9ZKnym2qmhHVEB9txuPmaAs3EeYvNNhOzRXh+H0kl/oA
         HDCh1l3PS7oi+/wtTE8B+nkASsv+vNhkdtXRrv7ObI3t/xJXILQyaWfbh1Bk+3tH89+L
         b1lX/NGztOqBOY2vhwHdEmQfa0/pi+VLIucAL1Zvt3MDqkWbcG8sKQVTeUXTY6OyYo1j
         gkWw==
X-Forwarded-Encrypted: i=1; AHgh+Rr37UD6rc3v8JAeu4qTMPC+duYqL/lNhOnpNrsxR8SRGUrPR2s6RMbwN8aYV1iNykiji0BBWjL5@vger.kernel.org
X-Gm-Message-State: AOJu0YxRnQJ1q1h6VqvNJrpGUREglVyuS68ZCKW3UuwCnvNdeaU5Pq+z
	nXkNPbMoBjZKyMw66kdGxNiijOvAJ4XM/LfpSKwLbdeMtc/3+qKn2nL/PBkwTdN8Y904v8XhPyH
	QJC4uoi4fUj1u/8kVtkeQsKlrr0yhIZo=
X-Gm-Gg: AfdE7cnkro4wLjmH/MuMvmD66rPlWVDvBWL7ea3Bmq5lcSR/G0B/FxM/IW28ST8EdnM
	g64wYwvIbKShadgo6WuwrwQBs9G/H7iFk9wVgDUdhoPj8HPL5BYUMdMvRBqU/Jh7aH1p/DS/9Ve
	S6tdHlP/opSC+QNIKKCIey6RddOM1Y6rcFpp1c84wRii+cBapvvTTJ4a+3Q9NFVjDcGUPqSSS6e
	4IHvZO/CsNEFo6Uz/Rbx1ksTm9mwG5dUFYCZNk5XepOp3caT6fXqDZzV29VM4nhqcd6VaYU+/zi
	Q6pU+BhP
X-Received: by 2002:a05:6214:da4:b0:8cd:b7e4:624c with SMTP id
 6a1803df08f44-8de4d73cee7mr173289026d6.34.1782136677801; Mon, 22 Jun 2026
 06:57:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHPqNmxGfjsKGEJJaSCrJqoU9WHY3q8CX1oTA7GV5BBHvDzgpg@mail.gmail.com>
 <aigMzVNsQpz_J0oQ@localhost.localdomain> <CAHPqNmwdh5Je=hrvEVzK90j91h2kOqXDmF1vz9UTtfcn1LUO1A@mail.gmail.com>
 <ailmCVEqnnQZ7ClA@localhost.localdomain>
In-Reply-To: <ailmCVEqnnQZ7ClA@localhost.localdomain>
From: Longxing Li <coregee2000@gmail.com>
Date: Mon, 22 Jun 2026 21:57:54 +0800
X-Gm-Features: AVVi8CftPDQQA8SY9Vpm3QjicJ8EayV64sWkgH-6GCMpob1T9VfIPiOrJ-nBgII
Message-ID: <CAHPqNmwzQ2EzunYOBF9MgrW4bpU=PrcROcqUiV2Z0CRHQrNb4g@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:mkoutny@suse.com,m:syzkaller@googlegroups.com,m:tj@kernel.org,m:hannes@cmpxchg.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17142-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,mail.gmail.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8EB526B0170

Hi Michal,
  Thank you for the reply.
  We will check this problem on the latest kernel to see if it's been
fixed, and will report back if we find any more valuable things to
discuss.

  Best regards,
  Longxing Li

Michal Koutn=C3=BD <mkoutny@suse.com> =E4=BA=8E2026=E5=B9=B46=E6=9C=8810=E6=
=97=A5=E5=91=A8=E4=B8=89 21:28=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, Jun 10, 2026 at 03:11:41PM +0800, Longxing Li <coregee2000@gmail.=
com> wrote:
> > sorry for not containing full information in last email. the config[1]
> > and report[2] are as follows. CONFIG_PROVE_LOCKING is not enabled in
> > our config.
>
> Thanks.
>
> > INFO: task systemd:1 blocked for more than 143 seconds.
> >       Not tainted 7.0.6 #1
> > "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this messag=
e.
> > task:systemd         state:D stack:20616 pid:1     tgid:1     ppid:0
> >    task_flags:0x400100 flags:0x00080001
> > Call Trace:
> >  <TASK>
> >  context_switch kernel/sched/core.c:5298 [inline]
> >  __schedule+0x1006/0x5f00 kernel/sched/core.c:6911
> >  __schedule_loop kernel/sched/core.c:6993 [inline]
> >  schedule+0xe7/0x3a0 kernel/sched/core.c:7008
> >  cgroup_drain_dying+0x1ed/0x360 kernel/cgroup/cgroup.c:6294
> >  cgroup_rmdir+0x38/0x300 kernel/cgroup/cgroup.c:6309
> >  kernfs_iop_rmdir+0x10a/0x180 fs/kernfs/dir.c:1311
> >  vfs_rmdir fs/namei.c:5344 [inline]
> >  vfs_rmdir+0x340/0x860 fs/namei.c:5317
> >  filename_rmdir+0x3be/0x510 fs/namei.c:5399
> >  __do_sys_rmdir fs/namei.c:5422 [inline]
> >  __se_sys_rmdir fs/namei.c:5419 [inline]
> >  __x64_sys_rmdir+0x47/0x90 fs/namei.c:5419
> >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >  do_syscall_64+0x11b/0xf80 arch/x86/entry/syscall_64.c:94
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Hm, hm, this kinds fits 93618edf75383 ("cgroup: Defer css percpu_ref
> kill on rmdir until cgroup is depopulated")
> which got into stable 7.0.9.
> Can you reproduce even with that (or newer) kernel?
>
> Michal

