Return-Path: <cgroups+bounces-15870-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IKHPMn4FBGoHCQIAu9opvQ
	(envelope-from <cgroups+bounces-15870-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 07:00:46 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E4252D60A
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 07:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C935030574AC
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 05:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F062937DAC8;
	Wed, 13 May 2026 05:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DhVfJ4Qu"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585DE3469E6
	for <cgroups@vger.kernel.org>; Wed, 13 May 2026 05:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778648443; cv=pass; b=p8Usv3CsSSwC6xy2b+tX7neOCdC4bu+oHC1qomkUX0bfFt1FjaLR+53yZin00Xqyc10+tOPCMYzt7EFwpR9l/pMnUSBLWRNN3oHRcQ8PylFTnNdQnxKT+9PDx1wJuxpemLvg0uLKFWHFq08KJnXkAQtcg7RbEZSCkDBV5p4K/MU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778648443; c=relaxed/simple;
	bh=e0YwQtjZXKrv0r21avIy6Ln3rZ12enWUWPCuaw/6J/Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TtmV5duhndyOuL34iOBqIjextzd2SiRVKiOH4hP7LBc1peCpjJXrWSmfmAdnOLm8/uBGgzGjjiUIhhdChyoiVFI7wqxYY7sSTItPXsdesloS6h6n2vUJFf14IScKkuZ3dE4/JzAund4e5hv86iVRBR1SQyKokPNTjkxiB8Xo7Uk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DhVfJ4Qu; arc=pass smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-12c19d23b19so10600613c88.0
        for <cgroups@vger.kernel.org>; Tue, 12 May 2026 22:00:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778648441; cv=none;
        d=google.com; s=arc-20240605;
        b=ccPAcEk+CY/ydPzfhB3oj5HymbVhJCc0FX+JdzFq/U+12swcwmAydyfoJnEaBUGZvQ
         hOQHzgf50vwagLIiLHIiEsneNj+Mp5xDI2UBUlLbLSU6P387jgSjiD8efHRwQ9acctsx
         lWVKqlWz7Cskf4d2lMJQ1xd7JaRG91Sr6J7HsZfPDPIgA1VZFa5FKJ65BKTWY8Tt0CiA
         AV93iYNGIcSwCiGS5Y8HcUUniB4lCqbj1mXoMUl/yAo7Pz6Uru913MMoLO0pI3fHgPsX
         yh0dHEAlA+XPKhaWfNkT7IRFLV8n0qfSw8wtMU2Sbn9QvOOnfiYUJgOqol2TWlX7FelJ
         2zhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ialh5CF8M6N7D+/TlC9BBlgojVjgWVwobVMdLR5uOtw=;
        fh=FJJtcTMHt/Hdb0GLuveXvMh8eneNOCfO9q7PheQsEuY=;
        b=Lp2tQXMrlvuSKKfhesNn403xd2foJ5urZrk/7xKykfg0H72zPfvY23oIQpo663bKiF
         n8T6lsZACrTawvCQVXhOzYkaasw9p4yDML/H8yKxvKkyVrbsqUHSMGouw17sLMBvI+dU
         YCKJ6n3PkgjLGxcnMFr4w0RC/c9VT62InGzdZ5HxJZAYWw0aBvNnHE1t59SZrh46ulh0
         oq11TrewqiNcgEID2Bq6+96Yicys/f7VT89ORk58la8tcC008mI9b3fppsOCJ2i5pQsa
         OaJl56RaT+xqe7j6E5/31kek4KGWbSyhnJLy457TeXFFgM/2uU92yaD8nTPT+uzZJCgD
         8r+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778648441; x=1779253241; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ialh5CF8M6N7D+/TlC9BBlgojVjgWVwobVMdLR5uOtw=;
        b=DhVfJ4Qu3nTQU82mnVHgko389BNN5VwTAx5Rb5QWJH9x9dZ2aywaJm/jjvd+LAw7je
         Ppt57ii4AcBMdfwQbCm2gXhENkOllzrqrw7sGEAayspzefj9fmBqahtQeOIQgqb/9TfZ
         EJYwubOK/eh2jsf74E4tZK6dtC2kB0Kf0F/wTC8vvRmcGNGtnos1vRL+1h4vbIX2C/zr
         5Wj5L3zsZRsG1ocFCNgZnctFS1+fY7T+uu30T6KWdmW3ZQGCiAbwwwi4H/ZnIHq4TRXa
         XmNP+8utwT7zOXZyqQLZNHUumB5Xua/A5l3wcPp0iCJrTG2gV32TT1k9yHbi8h6sYsER
         vhyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778648441; x=1779253241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ialh5CF8M6N7D+/TlC9BBlgojVjgWVwobVMdLR5uOtw=;
        b=LUgDGcAB1Al37UvgzdIVazgQ9fUGTUTjHtxCJKJ3rmLv8Ad7fdHFuBkudpWdefj/nm
         LJKArenPxIBzBIxjx212g/Tou2zS7j3Q0Ffnhix2q1SHM2ucr00n49YDjaBc9FOL0+yT
         vwxkFFRUVU3z5vwFLDvdjITJLO9Q1Cb8SKI2q0WAOYP1IoU+Sp75oJHPshccVSVT40WA
         e3vvE+yqAE3W4AoUU6NUTaC3+ajxDUI3/6phQaOeUSmPD7l63/sE73YzWbj7UEUWkm7t
         85MjOUlFUdXFBYGk252bUgpMC5PeXYgakTEhXRNo0oXzKJflDIHGe9pE9nH+KdpgTNKm
         zpgQ==
X-Forwarded-Encrypted: i=1; AFNElJ+Pi5sZYvt8pTEKw9pgchYgejo2kha+n/GQcL2R9wzl28SX2z01XvTl6IX7IVK7AcrKrFro5rf/@vger.kernel.org
X-Gm-Message-State: AOJu0YzLqBbegtPAKbWIaYdz+UdB32fJUSRww/TSE9CxgmTJgJbpJ3ec
	WGjkR/VbA5gw8TXgEo8Vmq0lsCRu/MVeNPUBrRX8+QUIUfQnxaDPZKpuYcTuM0ABRFWawpmnCMR
	M+1lDA6HOtTjxFd4Z5LSrUgdxqHuXrO/oJVrc4sE=
X-Gm-Gg: Acq92OGP4KkOMOBzYj5BAKyQf/F5x/PhQg1NXPamJt/ixJFJENrzHzH6zL0gmciAgIc
	dKfWY+xQdUAy81pfLqwbpGcuC/W3b48Dshk3XfuwrIzNnk1PtuQjue7VYlgT0B5YrFQsStcYEvF
	actFBeKYQB2fhElrQmz4K58EdqrJzu4er1N3wXSPumloO64oLEqXDNg/akyzhkanMktSoMPJHFo
	+JKauximM6MXT4eWlm/cIyo9+R9LdvaoLVrNmeesEi6Ah2noquonyy4hzGWp2V8Whse4fk7eBw/
	G8m//zRXbwDWKf1/ClsSKZjqvYFsiA0D6zFi/rFKHlGemL38OjJkvu+JlI/vpDLCp/RQK9oUT8t
	+umN7BUPfQXWJFZ+7Vn/dwH6rNOHa2GC+PVmljgkKh0MESg==
X-Received: by 2002:a05:7022:459c:b0:12a:6fb7:87e7 with SMTP id
 a92af1059eb24-1349a137970mr892003c88.0.1778648440762; Tue, 12 May 2026
 22:00:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511113104.563854162@infradead.org> <20260511120628.206700041@infradead.org>
 <CANDhNCp1rcNYg29Fe66G6cuqHhDyXQ0oqccheSwfMuiNV-7Bgw@mail.gmail.com>
In-Reply-To: <CANDhNCp1rcNYg29Fe66G6cuqHhDyXQ0oqccheSwfMuiNV-7Bgw@mail.gmail.com>
From: John Stultz <jstultz@google.com>
Date: Tue, 12 May 2026 22:00:27 -0700
X-Gm-Features: AVHnY4JZ7OEfV0KP0wzXxt-XZN7khInmOkUe9dtDMcMwY6KmfOc8tRERnnqIDX8
Message-ID: <CANDhNCqWJ=Q3LxazK_ioo_39aFfR+yVbPEV+MQHC8_QvadhuTg@mail.gmail.com>
Subject: Re: [PATCH v2 10/10] sched/eevdf: Move to a single runqueue
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@kernel.org, longman@redhat.com, chenridong@huaweicloud.com, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kprateek.nayak@amd.com, qyousef@layalina.io
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 23E4252D60A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15870-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jstultz@google.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:email,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 9:51=E2=80=AFPM John Stultz <jstultz@google.com> wr=
ote:
>
> On Mon, May 11, 2026 at 5:07=E2=80=AFAM Peter Zijlstra <peterz@infradead.=
org> wrote:
> >
> > Change fair/cgroup to a single runqueue.
> >
...
>
> I know Vincent was having some perf troubles with this patch, but
> booting on a 64 vCPU qemu environment, I'm seeing:
>
> [    5.688490] Oops: divide error: 0000 [#1] SMP NOPTI
> [    5.689457] CPU: 47 UID: 0 PID: 0 Comm: swapper/47 Not tainted
> 7.1.0-rc2-00026-g82a8ec6fb3f9 #38 PREEMPT(full)
> [    5.689457] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS 1.17.0-debian-1.17.0-1 04/01/2014
> [    5.689457] RIP: 0010:wakeup_preempt_fair+0x1b7/0x430
> [    5.689457] Code: 74 0b 48 8b 52 28 48 39 d0 48 0f 47 c2 48 8b b9
> 90 00 00 00 48 8b b1 08 01 00 00 48 81 ff 00 00 10 00 74 09 48 c1 e0
> 14 31 9
> [    5.689457] RSP: 0000:ffffc9000021fd70 EFLAGS: 00010046
> [    5.689457] RAX: 000002ab98000000 RBX: ffff8881b8e2db40 RCX: ffffffff8=
3022a80
> [    5.689457] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000=
0000000
> [    5.689457] RBP: 0000000000000001 R08: ffff88810cb14380 R09: ffffffff8=
3022b00
> [    5.689457] R10: 0000000000000000 R11: 0000000000000000 R12: 000000000=
0000002
> [    5.689457] R13: 0000000000000000 R14: ffff88810cb14300 R15: ffff8881b=
8e2da00
> [    5.689457] FS:  0000000000000000(0000) GS:ffff888235c2e000(0000)
> knlGS:0000000000000000
> [    5.689457] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    5.689457] CR2: 0000000000000000 CR3: 000000000304c001 CR4: 000000000=
0370ef0
> [    5.689457] Call Trace:
> [    5.689457]  <TASK>
> [    5.689457]  wakeup_preempt+0xa8/0xd0
> [    5.689457]  attach_one_task+0xec/0x150
> [    5.689457]  __schedule+0x1ad8/0x21c0
> [    5.689457]  schedule_idle+0x22/0x40
> [    5.689457]  cpu_startup_entry+0x29/0x30
> [    5.689457]  start_secondary+0xf7/0x100
> [    5.689457]  common_startup_64+0x13e/0x148
> [    5.689457]  </TASK>
> [    5.689457] Dumping ftrace buffer:
> [    5.689457]    (ftrace buffer empty)
> [    5.689457] ---[ end trace 0000000000000000 ]---
> [    5.689457] RIP: 0010:wakeup_preempt_fair+0x1b7/0x430
> [    5.689457] Code: 74 0b 48 8b 52 28 48 39 d0 48 0f 47 c2 48 8b b9
> 90 00 00 00 48 8b b1 08 01 00 00 48 81 ff 00 00 10 00 74 09 48 c1 e0
> 14 31 9
> [    5.689457] RSP: 0000:ffffc9000021fd70 EFLAGS: 00010046
> [    5.689457] RAX: 000002ab98000000 RBX: ffff8881b8e2db40 RCX: ffffffff8=
3022a80
> [    5.689457] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000=
0000000
> [    5.689457] RBP: 0000000000000001 R08: ffff88810cb14380 R09: ffffffff8=
3022b00
> [    5.689457] R10: 0000000000000000 R11: 0000000000000000 R12: 000000000=
0000002
> [    5.689457] R13: 0000000000000000 R14: ffff88810cb14300 R15: ffff8881b=
8e2da00
> [    5.689457] FS:  0000000000000000(0000) GS:ffff888235c2e000(0000)
> knlGS:0000000000000000
> [    5.689457] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    5.689457] CR2: 0000000000000000 CR3: 000000000304c001 CR4: 000000000=
0370ef0
> [    5.689457] Kernel panic - not syncing: Fatal exception
>
> Which I bisected down to this last patch in the series.
>
> faddr2line gave me:
> __calc_delta at kernel/sched/fair.c:290
> (inlined by) calc_delta_fair at kernel/sched/fair.c:300
> (inlined by) update_protect_slice at kernel/sched/fair.c:1070
> (inlined by) wakeup_preempt_fair at kernel/sched/fair.c:9193
>
> This usually trips as the ww_mutex selftest starts at bootup.
>
> Unfortunately I still see it with the add-on changes you proposed to K
> Prateek's feedback here.
>
> I'll try to narrow it down further tomorrow.

As karma would have it, this does seem to depend on CONFIG_SCHED_PROXY_EXEC=
. :)
I'm guessing the switch in calc_delta_fair() to use se->h_load is
uncovering something proxy isn't handling properly with that value.

But I'll have more tomorrow.

thanks
-john

