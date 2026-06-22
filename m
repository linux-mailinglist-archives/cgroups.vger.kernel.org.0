Return-Path: <cgroups+bounces-17141-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mHFDGCEyOWpAoQcAu9opvQ
	(envelope-from <cgroups+bounces-17141-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 22 Jun 2026 15:01:21 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E71B6AF9EA
	for <lists+cgroups@lfdr.de>; Mon, 22 Jun 2026 15:01:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=VhP3jxdu;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17141-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="cgroups+bounces-17141-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C93F6302D30E
	for <lists+cgroups@lfdr.de>; Mon, 22 Jun 2026 13:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5953AFD05;
	Mon, 22 Jun 2026 13:00:47 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f65.google.com (mail-qv1-f65.google.com [209.85.219.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B853AFAF9
	for <cgroups@vger.kernel.org>; Mon, 22 Jun 2026 13:00:44 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782133247; cv=pass; b=TcNaguq13IINqPvXS7TKUUqey22AbdFnHdiW/I9BmidgpRbOl1zf1j260bXrFSzU7V/coMcBkIVxi2AE+jiqyATn+ZFrt1z9gQ0OFXkLbzN9YdNEllXEQEThGOZjvGDRX7Wo8tnNArfYH733dNcCmKuHGGnlCJjZbtMi1reAaA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782133247; c=relaxed/simple;
	bh=U/u6QHQ9j4Y7kt1oumEyYu11r2G++KC0YCPd8rXeBwY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pbZ4d5Rt21CXM3yKG2W8i25XcRQvXxM8vGuzARyYASyyWiPJgxVE6TJjtYdv3p+0Y+OLBGNJt50bT7NB9o+okdxbrVgbJ1+l4WsTD8csdeQ2ufzbffORVl38kXwUqLW3c4VH6Er4T40AU7nfXaGMSI+hS46hMGwUAnSt1PDKRAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VhP3jxdu; arc=pass smtp.client-ip=209.85.219.65
Received: by mail-qv1-f65.google.com with SMTP id 6a1803df08f44-8dd94941c21so41226056d6.1
        for <cgroups@vger.kernel.org>; Mon, 22 Jun 2026 06:00:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782133243; cv=none;
        d=google.com; s=arc-20240605;
        b=iOdI4UsGKLlnFAbqOKQv0n25yrD0wkYn9vhdQoRmwvhrNZEtpok8IAF/oS/JtugHPI
         qn6vQs3VDPXCXsA7q7bvxxSUGCOTAiIjpLK4OnvBwfGLYYBM4pkAqRh5F96VY4amdbTP
         5HBhiWMRmFMVyUS1/eughO1+T5/ojnc2xa+R3imlfcdsS7XU8elGGgeFAIWiLaiVwGH9
         TqqSxnfbgU8/3WjrK60CmHiyDkWxW1GVp70+nnHNa6/vIkqyL+r4rH7HsEcUUxBkM8BM
         dAEy+yzgKppgdn/xxZ0Fuwv9XdyBa40AUpL8oRdEVE4jdJ2Vig2IZNQGm+a/eCCfwtFC
         CKsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/XBqbMNr66nfg94FNA4L5tcvQmnApC0ioReYsX0LRV0=;
        fh=pqzz4H3lcdnoMB/g8pqQobc8RP7qCPoE9AxqOcb/qbc=;
        b=P/ZaarOR4pCkHZYNFKw8jRMl1G2WiO3JSm/RP7Y7UhZui1QNg8OVPELiTOdvSc+ON+
         Gy2HHDNuD3z6zbVtL+qKE3iHnpyNCT1o/N/3qw7PKawgJvCQbSiA1yr/156b1QnvQFks
         S7AnkJrLSpvJCbPKB4Is7Ie9L24Gn6WTThRbgXH5puz4in4NesKUM8veyDHhCSzrtNaD
         WOMubJn6/V0uA/MF9KSmnLcrlBuxD77Hx2zwq/fXO6D+MHve7zOcsDJu98ykCXrsCtya
         8uNlVt11iWnOBiTKxLuEW4j0ecbnmvIqj742R0tLu56i8U1Dfj7bHs+CVtu8qxibOKAc
         5VsQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782133243; x=1782738043; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/XBqbMNr66nfg94FNA4L5tcvQmnApC0ioReYsX0LRV0=;
        b=VhP3jxduXWPzh9eoblPw0fZ8fnwBF5I6TYdw4MwBiIz5V78zX41eQu5aY69KvCQfFz
         CfqWruuXfxCDKseLro0cQ383iTJkldp0xlHbVsR48oDwnqKyUx1fu9nIWnZ0C2ZRo+dB
         hIne5yHfqhoOKtdcQeyeNgvhyHUGzayE1ov3b/hqZpNirseo/JwhcBWMMWAMhkSyNC+l
         xRPdPDCUi1/z2qNeHKruhbPYoknSa/FMDUTvjqXjGE+9Ga8cZWfoV6HFY+s1/APWi4UF
         Keg1F2GSM+hpxQ6QXIRVWQbN/QSVhJ7fVuAWbp8wR3s8GMRVXWYwZeCe6kcpWpb1z9Ds
         nyMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782133243; x=1782738043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/XBqbMNr66nfg94FNA4L5tcvQmnApC0ioReYsX0LRV0=;
        b=pkbZEsBns1NsVPQKocwxWzwMLAPn/21J59GeyR8FVf0ejlFjNsulUarKIBGFBEh2k0
         8qXXwf05ziE3O/yDjCFpBtqHa4if9oTovIFH5mtmih0/lps5NLltX3XFnSHCAJegJkJ1
         1roRe+pv6enUbjUplxVCXIUK+iJAHLWaA9C3gtHS9z0BoUwHiVVq75zhtmXHrNpZJBWs
         d/7QNf0MMmrB+rzeU0uW5FxHYuCwCP2PjSNxYAmmmnaX8fS9VbVBVh5vFYblhgxBXQCz
         M16hqp9LC7lnFJKejZPgMLWXa8wG1DkFUBviKKqhZGZH9UWBzhKq0nMMg4E6wFrJbDM3
         wt7A==
X-Forwarded-Encrypted: i=1; AHgh+RpZ7mj1KI1od2f/WSKD4JhJmPKyV56FwsrAiOgFsKzUyr3gdiknqXCkhgj6CweKYAJ66jWeODzY@vger.kernel.org
X-Gm-Message-State: AOJu0YzLFfk6tbhCSltAjqvstmT4cO2H+N6e4Rxlze9PK8rFFAudroDP
	WBBiHnHa68hHhnFBFFyajFtYK93A8ZqT6+LXXcXH5tTVmgAkLXMEeC1lnDSrZemcYIcrsE7KoVY
	7SeG7PNqRn3zDjk/NBUV2kd9/oL6G2Sc=
X-Gm-Gg: AfdE7cmwleV+pSxhjF7OG7S4QHIlrp0BA8CR2lkDhCBbPefAKkmcU7NCF9/kVhPwet+
	yVpqFNAQZL1ji1ze6zTROc3E+rlGJdpvE28HoeEc1UWppAQYDsr/YhBmtVC8FK1XzxkeTTfUKDJ
	71WG6SjLPC98jm/RpE/Pm5Z8jIL3IXA7dCYZ27I//3p8g0TmaCek3HD8dBmbPSZB97DnOP/bZgT
	j2VYs05GJ/c2KL1zKA7aqZ6FrKmd1ssTSz/OSBQHMrceZYuwTqoOZWt5swpd1xyWGqS5eH/1A==
X-Received: by 2002:a05:6214:1cc4:b0:8dd:ace4:6f17 with SMTP id
 6a1803df08f44-8de3bc0ade3mr239119376d6.10.1782133241777; Mon, 22 Jun 2026
 06:00:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHPqNmzgCY+sHOOG8YVrCFO-7oh6TBeL4SCHEcfVvH6J1SUVdg@mail.gmail.com>
 <airuQ36pKQ8x8CZk@linux.dev>
In-Reply-To: <airuQ36pKQ8x8CZk@linux.dev>
From: Longxing Li <coregee2000@gmail.com>
Date: Mon, 22 Jun 2026 21:00:38 +0800
X-Gm-Features: AVVi8CdwjZFcRa-oVlnafv4xlC1qYdc7VGGH_SFssuRNPccf47k7UE3k0Lmjy6A
Message-ID: <CAHPqNmwWp3p+PYb2HQsSmvDQ39OQ51byE30wYxVwaS1SOjQvhA@mail.gmail.com>
Subject: Re: [Kernel Bug] INFO: rcu detected stall in count_memcg_event_mm
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: syzkaller@googlegroups.com, hannes@cmpxchg.org, mhocko@kernel.org, 
	roman.gushchin@linux.dev, muchun.song@linux.dev, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:shakeel.butt@linux.dev,m:syzkaller@googlegroups.com,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:muchun.song@linux.dev,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER(0.00)[coregee2000@gmail.com,cgroups@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-17141-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[cgroups@vger.kernel.org:query timed out];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[coregee2000@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.dev:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1E71B6AF9EA

  Hi Shakeel,

  Thank you for the reply.

  This seems like a CPU starvation scenario. The reproduction triggers
extreme CPU contention where rcu_preempt kthread cannot get sufficient
CPU time to complete grace periods.
  1. The stall occurs in count_memcg_event_mm / get_obj_cgroup_from_current
  2. Both paths correctly hold RCU read-side locks
  3. The deadlock is: page fault =E2=86=92 dentry allocation =E2=86=92 memc=
g kmem
tracking =E2=86=92 RCU lookup =E2=86=92 need RCU grace period =E2=86=92 rcu=
_preempt starved
  4. This may require extreme stress to reproduce, and can be random

 We will try to reproduce with the latest kernel and report back if we
find any specific deficiency.

  Best regards,
  Longxing Li

Shakeel Butt <shakeel.butt@linux.dev> =E4=BA=8E2026=E5=B9=B46=E6=9C=8812=E6=
=97=A5=E5=91=A8=E4=BA=94 01:21=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Longxing,
>
> Thanks for the report.
>
> On Tue, Jun 09, 2026 at 07:57:56PM +0800, Longxing Li wrote:
> > Dear Linux kernel developers and maintainers,
> >
> > We would like to report a new kernel bug found by our tool. INFO: rcu
> > detected stall in count_memcg_event_mm. Details are as follows.
> >
> > Kernel commit: v5.15.189
>
> This is an old kernel, can you reproduce with the latest kernel? Also at =
the
> high level this seems like CPU starvation. Can you also describe your sys=
tem and
> the workload/test which is trigerring this issue?
>

