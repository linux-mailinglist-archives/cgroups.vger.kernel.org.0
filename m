Return-Path: <cgroups+bounces-15869-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yCDkGRsEBGoHCQIAu9opvQ
	(envelope-from <cgroups+bounces-15869-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 06:54:51 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E37C52D595
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 06:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E1DBC309BDBF
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 04:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA753921FB;
	Wed, 13 May 2026 04:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QBABgl0n"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17A4386567
	for <cgroups@vger.kernel.org>; Wed, 13 May 2026 04:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778647915; cv=pass; b=kw7wSery2Bt3nh6ANz3ops+nYA3YJum2Nr2rVjh+jPdYW0uccXcwmGNsWbJwuqunEXSoITIYYazWB3uWcAp1IUJXpt3i7/I6HEkfRdB0eKMzSENDek3A/csBhHNIACt2cbGa1yu0axzr/Ld1tOLauUlADoIpeWrfl8+ulaRwCZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778647915; c=relaxed/simple;
	bh=AaxCTn3XEMJVR4Ev5p48pb0AuttSPtBKkWeLmFha8B8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pmqT1NaXqLWXVZOsWdYKGRDM3qeF9mIjwCst6547kM7GGiVLhxaZRWTY8uL3pIZXwxDzsgSr2/1C4rIPVABYAeqjRpe+tz62Ls5eL9fAvoWlUPnyq/GFQuSYetXwEoiP3lgAoLv1y3/rRaC9GFOYehIZmF3Abcd1x0q/NYJbd24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QBABgl0n; arc=pass smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-130c9dcbd25so5886431c88.1
        for <cgroups@vger.kernel.org>; Tue, 12 May 2026 21:51:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778647912; cv=none;
        d=google.com; s=arc-20240605;
        b=XFGP5tufb3mK2Wbrcu0X+4PkpmHRynhay+Qd9PWMTsRbxmi1QDklJKXG5Ztd+yg7QV
         sNl1GjGz/egGSkfeqaA5/WT38CjkdqnT/p1xUwbMx/YPIHPebQdKH0YIdpWpAKPck00D
         casX9PbGf5LjGA9uyvLDz65GAFHyH8zVDghaYjh71pOZd9Xi2Lmi5QxRke1Sh7CPcQLz
         56CMnvooPIK7jIUaLmMZm/HaMlI4C+da0S/sI8Uw4m2xp9H2QY0Jv1jxC0W1D59gazKA
         b0UbWeXTFtwMHX5lFmOKDTtqzotCAKhOgYoevmzjCPCAA6ehYnLhRGCXKNdJ3hS8Tqd8
         sxKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lKCkGRY/zUwmLFY0OJILI5axH2rS2C3J4QcU3nePJsU=;
        fh=z7704wast/XfYT70CbFWJUMSaYx4YxwN6skHGkB3FRI=;
        b=guraoosnMH0RaWOyZlnfOCprSZOoSAdmjGoVjm6QdcibutJRUVGH6dr55TXAmXlabK
         aRZsd6zb5FrkNllTGcS8FDJNdvfWdozlKVzXN9UMLV1D35oTPFq9f6cmJ4xN/t1dd2LW
         5k+eildNpS0L51wlcviuteOGqvd6mosD7hvrtsi2geXrE3Ypjk0Bbg7Q5eti/wlZwsuB
         JqXLfqDdCNYdU+/vCpkcltOCee4k52Yj7/hq1AJBkzf0Qm5UUemlSGZ3Hs9U9XR30vdC
         DkfIXdz/xztSpsq+qxr4c5c0ge/aZRYTz29SS/Oj3abFNGKoGSQ87BPA43vJo96rx2oe
         j3eA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778647912; x=1779252712; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lKCkGRY/zUwmLFY0OJILI5axH2rS2C3J4QcU3nePJsU=;
        b=QBABgl0nOjR6W2JZLVLT1P/XcHmYcZ75oxzAd+ABzsOKgLgHhUlHlEyRrRu5ZvapWw
         b3CT94p8+RctfMR2zlG3ReAoma5fL4trkSApcCtstMu9hrIGbkqJfhF/osJeYV5DRznE
         RUDxnpNuSV9v/AQ0KIu9le3t4XbGJil62zjxsB0ZzRZp7GGVY4Zm0PhbQkpO422e7EsF
         I9S3YwJgLEmegZ7U+g19GwaV1c35oV+Jn/LU7TyOFftNwEsDE2/TSLbycVYq1DRT54yg
         dDF9YWGSSlSyxFdO40vwmXSoMZyVO/nN9hspSfAaYlXpSam+nWO17sAUL4sorby4XSGr
         WDtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778647912; x=1779252712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lKCkGRY/zUwmLFY0OJILI5axH2rS2C3J4QcU3nePJsU=;
        b=BxMiqVjpTmfkqvRKVW17zrPG1Bu/Yn7h39SqyDjQ0XWfV6gcEqAI7QQP7agpKSdgjE
         EgM5LfZiNp+eCZtoDsIDClJPI3vfvb3y8W3Ay/vOKpXgjutB8gyPOJHVgaGLKmrf0CTj
         nE8PmGRnbu3P6liwaDyIFRnPml2okgfM6UdnJmZAxtX36hxs7pZXN/RME+/B09VQJ3Rw
         79ab49GE6vJ/o80FYJyvc9bt+tCtYdBervjt8UCcZkUZOCo2dQt/I/MmKySXifhYigg+
         0uhbGhoX9bObiU4AhWP7/4AuZ0TXx/jroe/uhbNhwfa7fR8GFTK4TCbMIUHF9so5NiwY
         54vw==
X-Forwarded-Encrypted: i=1; AFNElJ/KSDg8QFuWx86yQusb/PQ8KLrEHGTL2W3wNALjcEj6qzIn7vGf9OyQ7JKA2MLWLP0U8uOCqcGU@vger.kernel.org
X-Gm-Message-State: AOJu0YwOudriYB9HM3+Xny31agtqMblxuvvYScknfsCYvn+rYx4RRyBy
	cQEPvgjVFXSNiA5LgV1gxcOu45gtwBrNWsMDz+LN2JjZgUUFeDpFCq6gOWyOVAVnSWfWepuVKow
	NRTKReYLwsczkLZ47OHHNkeqrDOkJmPIMsxeU3igj3cVO/LR5hjbI9BnQIg==
X-Gm-Gg: Acq92OEawfaKdjbg0OUyjilPd1orY3g411g4bz/Sr9fsyyUecf9sdpJ/k30YcHtVX3f
	F+ItwpOU2HuKuaABXkJ3vFxm4r9bOdMMClBUhnom9Inw+6OQVEmU9zN1OBCrC1mStPRQkbIATo/
	OXPOPLQTQYCH5AL1IiDJ0NqJfm78orVkWvIz/hNvTnjQsyg15fkTsKAempDexxI63jEHGtTYT3J
	Fd2JgeL+qAliWYrW10mpWrnWHa4s6rvSWdsgQQ/U04LAOf1KfalRGKO2u9Ii7OOG8qJfhuICgmv
	dv+NDOWflofzJYMkPMyP1xEyHLDveWbqOJxfHK81rL1LWBpZm17LOx6TVWwVUvnEkjfAcHsr4xv
	DaRRbF6ckIFTtHlTelBg3nBoTGDSnt/mlMIWG4n1YC/2epw==
X-Received: by 2002:a05:7022:f417:b0:119:e569:f874 with SMTP id
 a92af1059eb24-1341ebd8a0bmr1129650c88.17.1778647911464; Tue, 12 May 2026
 21:51:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511113104.563854162@infradead.org> <20260511120628.206700041@infradead.org>
In-Reply-To: <20260511120628.206700041@infradead.org>
From: John Stultz <jstultz@google.com>
Date: Tue, 12 May 2026 21:51:38 -0700
X-Gm-Features: AVHnY4L25cYKARzq6-C9KiYc1pGHRfXmYm8DBD_ny0nc2C1D4bjjzKtwSgaY6Eg
Message-ID: <CANDhNCp1rcNYg29Fe66G6cuqHhDyXQ0oqccheSwfMuiNV-7Bgw@mail.gmail.com>
Subject: Re: [PATCH v2 10/10] sched/eevdf: Move to a single runqueue
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@kernel.org, longman@redhat.com, chenridong@huaweicloud.com, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kprateek.nayak@amd.com, qyousef@layalina.io
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 1E37C52D595
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15869-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,infradead.org:email]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 5:07=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> Change fair/cgroup to a single runqueue.
>
> Infamously fair/cgroup isn't working for a number of people; typically
> the complaint is latencies and/or overhead. The latency issue is due
> to the intermediate entries that represent a combination of tasks and
> thereby obfuscate the runnability of tasks.
>
> The approach here is to leave the cgroup hierarchy as is; including
> the intermediate enqueue/dequeue but move the actual EEVDF runqueue
> outside. This means things like the shares_weight approximation are
> fully preserved.
>
> That is, given a hierarchy like:
>
>         R
>         |
>         se--G1
>             / \
>       G2--se   se--G3
>      / \           |
> T1--se se--T2      se--T3
>
> This is fully maintained for load tracking, however the EEVDF parts of
> cfs_rq/se go unused for the intermediates and are instead connected
> like:
>
>      _R_
>     / | \
>    T1 T2 T3
>
> Since the effective weight of the entities is determined by the
> hierarchy, this gets recomputed on enqueue,set_next_task and tick.
>
> Notably, the effective weight (se->h_load) is computed from the
> hierarchical fraction: se->load / cfs_rq->load.
>
> Since EEVDF is now exclusive operating on rq->cfs, it needs to
> consider cfs_rq->h_nr_queued rather than cfs_rq->nr_queued. Similarly,
> only tasks can get delayed, simplifying some of the cgroup cleanup.
>
> One place where additional information was required was
> set_next_task() / put_prev_task(), where we need to track 'current'
> both in the hierarchical sense (cfs_rq->h_curr) and in the flat sense
> (cfs_rq->curr).
>
> As a result of only having a single level to pick from, much of the
> complications in pick_next_task() and preemption go away.
>
> Since many of the hierarchical operations are still there, this won't
> immediately fix the performance issues, but hopefully it will fix some
> of the latency issues.
>
> TODO: split struct cfs_rq / struct sched_entity
> TODO: try and get rid of h_curr
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

I know Vincent was having some perf troubles with this patch, but
booting on a 64 vCPU qemu environment, I'm seeing:

[    5.688490] Oops: divide error: 0000 [#1] SMP NOPTI
[    5.689457] CPU: 47 UID: 0 PID: 0 Comm: swapper/47 Not tainted
7.1.0-rc2-00026-g82a8ec6fb3f9 #38 PREEMPT(full)
[    5.689457] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.17.0-debian-1.17.0-1 04/01/2014
[    5.689457] RIP: 0010:wakeup_preempt_fair+0x1b7/0x430
[    5.689457] Code: 74 0b 48 8b 52 28 48 39 d0 48 0f 47 c2 48 8b b9
90 00 00 00 48 8b b1 08 01 00 00 48 81 ff 00 00 10 00 74 09 48 c1 e0
14 31 9
[    5.689457] RSP: 0000:ffffc9000021fd70 EFLAGS: 00010046
[    5.689457] RAX: 000002ab98000000 RBX: ffff8881b8e2db40 RCX: ffffffff830=
22a80
[    5.689457] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000000=
00000
[    5.689457] RBP: 0000000000000001 R08: ffff88810cb14380 R09: ffffffff830=
22b00
[    5.689457] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000000=
00002
[    5.689457] R13: 0000000000000000 R14: ffff88810cb14300 R15: ffff8881b8e=
2da00
[    5.689457] FS:  0000000000000000(0000) GS:ffff888235c2e000(0000)
knlGS:0000000000000000
[    5.689457] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    5.689457] CR2: 0000000000000000 CR3: 000000000304c001 CR4: 00000000003=
70ef0
[    5.689457] Call Trace:
[    5.689457]  <TASK>
[    5.689457]  wakeup_preempt+0xa8/0xd0
[    5.689457]  attach_one_task+0xec/0x150
[    5.689457]  __schedule+0x1ad8/0x21c0
[    5.689457]  schedule_idle+0x22/0x40
[    5.689457]  cpu_startup_entry+0x29/0x30
[    5.689457]  start_secondary+0xf7/0x100
[    5.689457]  common_startup_64+0x13e/0x148
[    5.689457]  </TASK>
[    5.689457] Dumping ftrace buffer:
[    5.689457]    (ftrace buffer empty)
[    5.689457] ---[ end trace 0000000000000000 ]---
[    5.689457] RIP: 0010:wakeup_preempt_fair+0x1b7/0x430
[    5.689457] Code: 74 0b 48 8b 52 28 48 39 d0 48 0f 47 c2 48 8b b9
90 00 00 00 48 8b b1 08 01 00 00 48 81 ff 00 00 10 00 74 09 48 c1 e0
14 31 9
[    5.689457] RSP: 0000:ffffc9000021fd70 EFLAGS: 00010046
[    5.689457] RAX: 000002ab98000000 RBX: ffff8881b8e2db40 RCX: ffffffff830=
22a80
[    5.689457] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000000=
00000
[    5.689457] RBP: 0000000000000001 R08: ffff88810cb14380 R09: ffffffff830=
22b00
[    5.689457] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000000=
00002
[    5.689457] R13: 0000000000000000 R14: ffff88810cb14300 R15: ffff8881b8e=
2da00
[    5.689457] FS:  0000000000000000(0000) GS:ffff888235c2e000(0000)
knlGS:0000000000000000
[    5.689457] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    5.689457] CR2: 0000000000000000 CR3: 000000000304c001 CR4: 00000000003=
70ef0
[    5.689457] Kernel panic - not syncing: Fatal exception

Which I bisected down to this last patch in the series.

faddr2line gave me:
__calc_delta at kernel/sched/fair.c:290
(inlined by) calc_delta_fair at kernel/sched/fair.c:300
(inlined by) update_protect_slice at kernel/sched/fair.c:1070
(inlined by) wakeup_preempt_fair at kernel/sched/fair.c:9193

This usually trips as the ww_mutex selftest starts at bootup.

Unfortunately I still see it with the add-on changes you proposed to K
Prateek's feedback here.

I'll try to narrow it down further tomorrow.

thanks
-john

