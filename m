Return-Path: <cgroups+bounces-13829-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2BWfGFIUi2n5PQAAu9opvQ
	(envelope-from <cgroups+bounces-13829-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 10 Feb 2026 12:19:46 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A075211A0CF
	for <lists+cgroups@lfdr.de>; Tue, 10 Feb 2026 12:19:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68EDD30432F4
	for <lists+cgroups@lfdr.de>; Tue, 10 Feb 2026 11:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA0C3126C5;
	Tue, 10 Feb 2026 11:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jNziTu5b"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A662E093A
	for <cgroups@vger.kernel.org>; Tue, 10 Feb 2026 11:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770722382; cv=pass; b=paCrVdpo+LSkZycsG3onLSTYE8dt/bI7To4S4CVaF/ouIdS52/Uy87L3sDN5w31nOncAVd1DTDChtDM8mMT4ddIRs9jdZUpXjEp7OWxi3mfJ+/AIJh35rcvqn/3Q+R3xd5xcsgpakf+yf6gDgDxYAtOqVGq/LzHsSn7vHbrpmVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770722382; c=relaxed/simple;
	bh=ANohJG7Zl56/LXapQZ7F/3RohNWrnUF9yY0FduJmZc0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PxT7w0GfzVpYumZ0L0A2w7mpQF8RFaRDTyK8RjU1KtMyM9NH7y1KoQfNxXuVlJ9JVgoamaLpGypUWQX9RnvcKbIUZ5sn4cqjSY5j8XxlekPmIvvBJdJNC0P0j9TIaNh3bMAxbY/pRo22CXxo2xyN2gHJ+nnZvQJ6yeXfiXtPuJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jNziTu5b; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-658034ce0e3so1050891a12.3
        for <cgroups@vger.kernel.org>; Tue, 10 Feb 2026 03:19:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770722379; cv=none;
        d=google.com; s=arc-20240605;
        b=e0IeX3o0gMP0YU8u4rYeCs0SJmqXTccUALzEeDern/RXZFxflf8KqoEHJdj6+8Mfs0
         t6NkCPKM+qY3xpI1Zi/W83z19GxxspkemwOJT/TOdthLzfdejYJVaKfecLE8UMuL3uA4
         YZElszGw2BLfX9EtteNTagJ93HzZf+FHVQpCgjcuwjqUH7zWTX1CriAAlNgLEKFQ6eMm
         sO+E41MOq4/th1/jLp/LVtby0fNypkZ1DbzUFQZNwBRWrNtlHRQ75saBqZKfWW8GlW5E
         lIUtTGVNWJEEuZ8eNh4Uw7Z504h/zYJ33pTgSZzupMOYy0ER+/cd/ybyRTXg4XjRNaZ6
         Uqcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8yrMEKIEnaCuB3VkTkmV3NWEmJbbUoagnPHYQEzo5oU=;
        fh=lhuLO25HisRDel//hOeNZTmRKxwPuZZijj8m0zSAYfo=;
        b=VHK5JTgtXjlap6dCo/rFyBWsKdoPAE4CnKXur18i/JDx/8BYzngM4kos7jxm5nyb5U
         A4d5AMVul1zRHZALNV2u46wQIHPNmX7HP2Ow5jSdfpXkZqTxQ77h0jJmjRGOiOJI7WZQ
         +H7aH2e5LNg/+rP+kADjGE3gGQiVdqwyNQt8L7HIjjLW5vfRNPbBak4jYX71PZUMQdvn
         JPNAseMnadpr+gQ98jyjpRb5UPcd4YXupvIJRStJG3X341S1hB4wJ8EDlKEafIEhXNd7
         zFM8MkcIWoM/454ZzpzZM5/wci39CeT3P33rpOQB6PJkfCerrNVlace19Rj6TrpqriGV
         /rHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770722379; x=1771327179; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8yrMEKIEnaCuB3VkTkmV3NWEmJbbUoagnPHYQEzo5oU=;
        b=jNziTu5bfzD99XdC8zGZzXJiwgTLgJs9thhQKpg2SwmBlaVhAz6xAJphduXNtXpF8n
         x/PqlPk1R6h6BUB9imgMiyrYVYJeLQyjAYZI0r9+0z+C38qsBgFvctgcDh794PU5BSnf
         aoULglheQ6lXIDuE2i9tzvd4i9mHNe8OvVbFsRIyTCjWcPTUlZzqPV6zRoScy4hEXxiP
         6xNcVsCYqkNsODnSiHXhVnvCJgLq4GrCbL9Ms+E8fd2S2Bm7qhoCrPS4Fzt3PxAXu8py
         q/jbb0Om4PWzCzweUJZsV4JQksH8Z7K/KojbE1gY/FQT2BMC7ndB4I/iI6L485PPFLDw
         piaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770722379; x=1771327179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8yrMEKIEnaCuB3VkTkmV3NWEmJbbUoagnPHYQEzo5oU=;
        b=n7LOnOkfjmgkZwCxlGYj2zjC6GiBdOncPLtH0FVBPQEuaHDF+OAPomQlu/zdEHuiDy
         Qyc6lQQnG8H0Av+hD7059Xbd9QSEj4zW2bMB6XJIYZYzEYCIPTXPC2spGrJ4JQcgvCDj
         eUmogZQG1Yy+pa/BT/h0xFN05fSnNKIe2MaMe0DmFVC7AMniXkPcvUDfKKn5LdFcQfpQ
         u12/pAfW1UU2dc9yP29g4m/UCD1q6PAbDIA1Tj9s6dLZgvcyCFIsaFqOZopeuv4hWvF8
         UkJXgJn3oLOa1d+h2/QQXIK3OnKBkXW+bZb3TWk7mmdsDjjNDoysQ8ew8X6fKKcDO8Ez
         DmAw==
X-Forwarded-Encrypted: i=1; AJvYcCUzAZfD8OIRrcHMtMetnnY3f8yYGzFBpucQ9k6yc/o8BSyyTOktfegjTaQy7PJtAX75xOp9cSVP@vger.kernel.org
X-Gm-Message-State: AOJu0YyW5PMWy+xS59XyGrCL141gHsy+CQVCCB9dbQlQm7qD5QTIJh6h
	Fd7eDxphGfZhcxuQVBal2krwI3FNWaCl3+I3jiDAM8U0dwXbSQOT1nz/wwzbOp5us0a6Sw4D+PR
	HxympGzt8mXLr8MGi5V+ElhIkjeHyOVc=
X-Gm-Gg: AZuq6aIpAEmVQECJstlNIrenlVodhAAnFep21q97xGt1moTZSFjddcOKsZnbvZaUNa7
	P15LxeqPL/0R1Tv+0ICT9zJoYQx1Jy9lWIocAOsjN8yAoA9PqVPEXCGXmGBIGqg/G6y2//ZVlRx
	68mJyEjnHsku1B0DzSVtm1S/PD/5ZxL9D6n41lqKYUAg2eXAGyUEpzG5al4lvPCghsUPcI1EEwS
	2kbMmqeDVsKcVPCELg5vMnZvphECa9EVFxfXLWwuL1HYB23EYSyEQaNNwdK7Zvar1zizNMknpNW
	dLdLQNUXyR5vCAfltq9OUxzdAoWonJSGjafL69g=
X-Received: by 2002:a05:6402:1455:b0:658:e811:b983 with SMTP id
 4fb4d7f45d1cf-65984137097mr7626468a12.12.1770722378950; Tue, 10 Feb 2026
 03:19:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122112951.1854124-1-mjguzik@gmail.com> <CAGudoHErB_Dm8kTRDa8cNOe4aRgc6kAV0bnT90Pp_Uda+_DqDQ@mail.gmail.com>
 <uwuworxk3warxfnvr7g3gnrh5g7bnnkq5uhbsnoh42muv7zeax@y7ddpcbhwarw>
 <CAGudoHFaUjm7_Eh6VOOGvfscdekk7v2uNPjfLkZfAkR9aCA1Ew@mail.gmail.com>
 <roisfgpkd7tapp7cfjavmih2e2riwh2nczv4nqk25gik7of4pa@3ohyptw6nvb3> <jt6kzvdkp4obq7jszyt4muc5ktjjft2idbz3mzkknlxdch6iit@yeumuxzp6gbn>
In-Reply-To: <jt6kzvdkp4obq7jszyt4muc5ktjjft2idbz3mzkknlxdch6iit@yeumuxzp6gbn>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 10 Feb 2026 12:19:27 +0100
X-Gm-Features: AZwV_QgNTUimfm67FZWMQpYIoYtP54F-bX1LI1sfPsCGrFmd55YJCYGgxiMeJgQ
Message-ID: <CAGudoHHuG-SCgv+F23eScZTnkXxyYKV9xgCBbFntkEaK90hsEQ@mail.gmail.com>
Subject: Re: [PATCH v2] cgroup: avoid css_set_lock in cgroup_css_set_fork()
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: tj@kernel.org, hannes@cmpxchg.org, brauner@kernel.org, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-13829-lists,cgroups=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mjguzik@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,suse.com:email]
X-Rspamd-Queue-Id: A075211A0CF
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 11:43=E2=80=AFAM Michal Koutn=C3=BD <mkoutny@suse.c=
om> wrote:
>
> Hello Mateusz.
>

ouch, terribly sorry for "hurry up and wait". real life suddenly got
in the way and I have not looked into this since

> On Thu, Jan 29, 2026 at 02:22:32PM +0100, Michal Koutn=C3=BD <mkoutny@sus=
e.com> wrote:
> > And I'm wondering whether removal only in cgroup_css_set_fork() improve=
s
> > parallelism because the tasks (before patching) are queued on the first
> > css_set_lock, serialized through the first critical section and when
> > they arrive to the second critical section in cgroup_post_fork() their
> > arrival rate is already reduced because they had to pass through the
> > first critical section. Hence the 2nd pass through the critical section
> > should be less contended (w/out waiting).
>

it improves parallelism because total hold time goes down.

first, there is a little less work to do with the lock in the first
place even absent any contention

second, there is less total overhead in terms of bouncing the lock and
the cachelines used by the code protected by it. note any contention
means the bouncing already happens

you can see the second effect in my patch which does not reduce the
amount of work per se, but merely avoids a case where someone is
halfway through alloc_pid and has to wait

Ignoring some single-threaded overhead from the atomics in rwlock I
very much expect scalability to be about the same as with the seqlock,
but only because of the bottlenecks elsewhere.

While I don't understand why would you go for rwlock here, I'm not
going to protest -- it still moves the css lock out of the picture.

> I was still curious about this, so I tried own measurement.
> I ran your clone'ing will-it-scale testcase [1].
> Basically it was
>         clone_processes -s 1000 -t 40
> on a 40 CPUs/80 SMTs machine.
> I watched for the `total:` iteration counts reported by wis
> periodically.
>
> 6.18.8-0-default (baseline :=3D stable + pidmap patches [2][3])
>   2.9383e+05 =C2=B1 1135.5
>
> 6.18.8-1.g886f4c4-default (baseline + rwlock impl (previous message))
>   2.9363e+05 =C2=B1 1219.8
>
> 6.18.8-1.gb21e8f8-default (baseline + seqcount impl (your patch))
>   2.9147e+05 =C2=B1 1125.6
>
> So I could not reproduce any non-random change with this css_set_lock
> split (I consider even the apparent difference between implementations
> rather random).

This is going to depend on the scale you test on. I was testing on
south of 32. But I also got a miniscule win from removing css set lock
as the problem for me, instead everything shifted to tasklist.

Per my other e-mail tasklist lock retains the terrible 3-times locking
and it is doing rather expensive work while holding it. It is
plausible it happens to be at the top at that scale, but that's only
an argument for fixing it. Even if you don't see the css thing at the
top at the moment, it will be there once someone(tm) sorts out the
tasklist problem.

>
> At this point, I should look into profiles whether the bottleneck is
> really css_set_lock in cgroup_post_fork() but I'm sharing what I have,
> glad for your possible insights.
>
> Regards,
> Michal
>
> [1] Only clone_process variant, clone_threads randomly hung.
>     will-it-scale/glibc (2.42-3.1) likely doesn't work well with the
>     cancellation/(no) join (but I got hangs even with pthread cleanup
>     handlers that joined the child thread)
>
>     #0  futex_wait (futex_word=3D0x7ffff7ffd840 <_rtld_local+2112>, expec=
ted=3D2, private=3D0) at ../sysdeps/nptl/futex-internal.h:146
>     #1  __GI___lll_lock_wait_private (futex=3D0x7ffff7ffd840 <_rtld_local=
+2112>) at lowlevellock.c:34
>     #2  0x00007ffff7c98d69 in __GI___nptl_deallocate_stack (pd=3D0x7ffff7=
ab16c0) at nptl-stack.c:113
>     ...
>     #5  0x00000000004029ca in kill_tasks () at main.c:151
>
> [2] https://lore.kernel.org/linux-mm/20251206131955.780557-1-mjguzik@gmai=
l.com/
> [3] Those patched improved the metric about some 10% (but I haven't
>     measured this difference so thoroughly).

