Return-Path: <cgroups+bounces-14387-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CrIDV5un2m/bwQAu9opvQ
	(envelope-from <cgroups+bounces-14387-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 22:49:18 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5075F19E04F
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 22:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AAB55301DD06
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 21:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886B9312816;
	Wed, 25 Feb 2026 21:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x0cFWIDR"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB661DB95E
	for <cgroups@vger.kernel.org>; Wed, 25 Feb 2026 21:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772056151; cv=pass; b=OTG+SjhBGp1jAsJ24pJkYazQxGcYVdxB7+YWovpcR03FX4de4dtFFMZ4wT2uwLetqp4eqEvvA9QPEot3H1scJ42sSjgs393LzL2nE9jv8Ye9qLO6yi6kbjRiitLTtHLxIOBnLFeRhOpTU1tPa6WJPkUoD+emXS9kh714RlpIMgM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772056151; c=relaxed/simple;
	bh=1wMsGZx+AUYYwahB0vAiy+RU6r/T2e2bYLqSeRkAwes=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DHZmjJnGUYdoRgdbQiWv1IXG8g9uH7RzfpDUjqAE7Ie3dD3/MMBX1oGWm8ToqjqtNOI7ja7bTw4dfA85yOjJcvN6vhgmaZYbr8v+z9MaFR31ESaQ7r2uaywzfZyv19H+wVMlbuINMYQZWu90ZYg5wcYKEJyGbWukdF/QRne1g6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x0cFWIDR; arc=pass smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-124a60cc9a1so3221c88.0
        for <cgroups@vger.kernel.org>; Wed, 25 Feb 2026 13:49:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772056149; cv=none;
        d=google.com; s=arc-20240605;
        b=dFzYXktL0277Qr8G+iaKqnHslMLTGZIKA7Ohj6rRMvr9kY7qAqx8dj8zmQYMtCFd4x
         eonvqF5RqXLmiaX7imDNhm/UEaXG5IwkOeajYejYDshCg2gJ+ND1OQxeRfk6svSrJKHE
         a8hE3sFdPqb8+IodOCZTQ+PCkw/ITUAcJNB9xaD5UCgoz9QVbgkf0iIwgHhlpYePoKFO
         Pquf7/jnOW36ujGZnThsnhJzFAm9JrgmRbP/LH8h5Sok4gsqTMcyJGy0QKOi1Wx6GRcr
         oaE+8YEDccGGrnZILBnkbwEG1kLojEU64nDLRUDQ+6dZV0ftq1mRARD6PjRtSqDLqWWM
         YRUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HXoXmRfzjD1O7tQISGhzwm/i4H3twNPVpoSuRz/6bJ0=;
        fh=jdCHyVeV22gPRPkC7ur2bVP5ps+emm+yvKqIcOPvzhs=;
        b=f3+TuZR2XjTp8NNtTA8au6b3J1XzAMTDAqcGIFDJLtA+J/7pBgwhSdbPckfYFzg5Jk
         2l+VnXUi7yLNt8V7Co4Y1YrsT4q1ivSq4skMNW5ybQlIKMPZeiPXd73P2KR3CDYGFBzA
         ixgpTqMmYa4xFGaEm2PsHTDTTOcPCV/j+ibe0EZ/VR05vpf+ZBn1JHwWyh+N5tz+GLyj
         TQBqD9nT03vXWpl/Sf2eBc7vjrMUwZRTi0qZDKX5llcgvmkhFwPZqIjsReO0AedZZjCs
         vodJf/oTAMrX6lKGLFJXtCMHARB93EeOU4hGkIN30MgcAgkOj3r0b7tL4eQK3DD2t6SV
         BZhA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772056149; x=1772660949; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HXoXmRfzjD1O7tQISGhzwm/i4H3twNPVpoSuRz/6bJ0=;
        b=x0cFWIDR2LVsAVIKUsYAopkvtc36IZYcOURNqZtkVVe5AGD6mfkb8UMeWN6XhId7he
         2dgRptG19a+0M+6zonJqLpA/l//gzzsT3ckrmO9VLQlfpt1JZVo48nGMnVP2kl7cIZaQ
         Bm8atFoGVTDS2cD4HIogQpFVcaeklV+WAj0Z+2Pofv0ZjBnvM0VAbya1BKXsjFyMbeo7
         qZgV/yYo9ZfxdjeiaSVzug7ibsHZBZ3Ue5D69uwPZ9yrMCtP3RxLLmM4i6k/0TrXFi1K
         2MqX7mpg0LmIqeY4Kza4FgzUkwUfswJ0OgUTYcuVh6EA6aDYh6oDwKq6m6Wh4rZJaEYT
         xLQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772056149; x=1772660949;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HXoXmRfzjD1O7tQISGhzwm/i4H3twNPVpoSuRz/6bJ0=;
        b=Rw4P/WMbwjF01K19THUwU5af07emjOYV+wmwO3EMkJMEc3QgaAu9TnVM4sfns0SaVJ
         eNn0Q4NjOuJC4DvN0wOVQJSBt/wsvqSRDbvRSZEj0fCNaQE8iY21Kq5a3OwQPcuJlGou
         IF6IQXrCXQefE+akZGrwqw07KfwL08dIsYVMrpky5EF88djcMhCWk+lnIbB7p0F2dHp/
         99FxFJfitRnxkpLDXTkk31DWr5ZPx92MhqLWmActyezIIAANnYs/zEQn1j5yg9xmxUvY
         V3+38B56KjxoC465K9/IuJsJTNi2nsSK0asOtTb35WHQ/zezhf5Crv9ihhTGYwbdYS4q
         EZiA==
X-Forwarded-Encrypted: i=1; AJvYcCXPAfuzhfXQlbSk8DR8u9cBYJdwwIiEkosTUSK6XHiTG5rvwwXct4TORVmP+NTSJUeLVPxlZl3F@vger.kernel.org
X-Gm-Message-State: AOJu0YzajHWrWhVxEqG4A8iPIv+I+ApHiAwxjd1GvtD5vsc9/HpqujAi
	0ayQ6Yha/+iFh9knqP1VTUMoP6I2D1EMbHMhXw3eSAzUuSCrp17AW1d5hwxyoUrobS4QatGzGpw
	bMEm/1bfpIrX6L/H0JeuW3DJNQz89jOg9zMgMU5FN
X-Gm-Gg: ATEYQzw4VMw0nCuZrLddgsCC0LD/zMKG3d1w0TCzWL31doDEi3C7x7WY9eVna3prUGV
	bXPHcX2ox4CdqBeJMg/qF0S/k2Q7qm25Rq3HBOTKzX/68+ytPzyHa/wuOqx6+HI4bK+w3cuc/R/
	YkuZPTpzehzok/ZwCNH4jLQURFUCIy8EzplEFO4vmQ9S5kf5UDDSyNOvOT8BUmMuvl4DFR4aZFM
	sa2UjaoAieV+M4w/8vnNQryCtkRp5cb+W25kIJkhslVHnb7Cln3/GDgiXCpts5luFAqSJ0ENqHI
	bC2/90iS
X-Received: by 2002:a05:7022:12b:b0:120:5719:624e with SMTP id
 a92af1059eb24-127899a14cfmr15007c88.21.1772056148334; Wed, 25 Feb 2026
 13:49:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225162319.315281-1-willy@infradead.org> <20260225162319.315281-4-willy@infradead.org>
In-Reply-To: <20260225162319.315281-4-willy@infradead.org>
From: Axel Rasmussen <axelrasmussen@google.com>
Date: Wed, 25 Feb 2026 13:48:32 -0800
X-Gm-Features: AaiRm530P1YSzLEa51H-zQeBl-pzcUCulY2BBR17FOdOE6KBI6RXiSrNhAIYtmY
Message-ID: <CAJHvVcgoCE_LSfQFk4W6mtFLeUrdc4JuvJr=5vv4mCsV5YFepw@mail.gmail.com>
Subject: Re: [PATCH 3/3] ptdesc: Account page tables to memcgs again
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14387-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axelrasmussen@google.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5075F19E04F
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 8:23=E2=80=AFAM Matthew Wilcox (Oracle)
<willy@infradead.org> wrote:
>
> Commit f0c92726e89f removed the accounting of page tables to memcgs.
> Reintroduce it.
>
> Fixes: f0c92726e89f (ptdesc: remove references to folios from __pagetable=
_ctor() and pagetable_dtor())
> Reported-by: Axel Rasmussen <axelrasmussen@google.com>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  include/linux/mm.h       | 15 +++++++++++++--
>  include/linux/mm_types.h |  6 +++---
>  2 files changed, 16 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 5be3d8a8f806..34bc6f00ed7b 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3519,21 +3519,32 @@ static inline unsigned long ptdesc_nr_pages(const=
 struct ptdesc *ptdesc)
>         return compound_nr(ptdesc_page(ptdesc));
>  }
>
> +static inline struct mem_cgroup *pagetable_memcg(const struct ptdesc *pt=
desc)
> +{
> +#ifdef CONFIG_MEMCG
> +       return ptdesc->pt_memcg;

I think this is buggy and we need to decode the "real" pointer from memcg_d=
ata?

I applied this series (cleanly) on top of torvalds/master
(7dff99b354601dd01829e1511711846e04340a69) and when I boot I get:

[    3.315420] BUG: kernel NULL pointer dereference, address: 0000000000000=
4e8
[    3.316955] #PF: supervisor read access in kernel mode
[    3.318100] #PF: error_code(0x0000) - not-present page
[    3.319302] PGD 0 P4D 0
[    3.319877] Oops: Oops: 0000 [#1] SMP NOPTI
[    3.320829] CPU: 2 UID: 0 PID: 157 Comm: systemd Not tainted
7.0.0-smp-DEV #2 PREEMPTLAZY
[    3.322665] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.17.0-debian-1.17.0-1 04/01/2014
[    3.324772] RIP: 0010:memcg_stat_mod+0x2c/0x90
[    3.325784] Code: 40 d6 0f 1f 44 00 00 55 41 56 53 48 89 cb 89 d5
48 85 ff 74 3d 66 90 48 63 86 c0 19 00 00 4c 8b b4 c7 90 08 00 00 49
83 c6 48 <49> 8b be a0 04 00 00 48 39 f7 75 2d 48 63 d3 8f
[    3.329919] RSP: 0018:ffff9b62c0817de0 EFLAGS: 00010206
[    3.331110] RAX: 0000000000000000 RBX: 0000000000000001 RCX: 00000000000=
00001
[    3.332718] RDX: 0000000000000025 RSI: ffff98d33fffdcc0 RDI: ffff98cc08b=
8d142
[    3.334322] RBP: 0000000000000025 R08: 0000000000007fff R09: ffffffff990=
79980
[    3.335917] R10: 0000000000017ffd R11: 00000000ffff7fff R12: ffff98cc031=
0c138
[    3.337522] R13: 00007ffc318c77d8 R14: 0000000000000048 R15: ffff98cc009=
e2280
[    3.339118] FS:  00007f2fffd3d400(0000) GS:ffff98d385556000(0000)
knlGS:0000000000000000
[    3.340915] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.342208] CR2: 00000000000004e8 CR3: 00000001089ad000 CR4: 00000000003=
50ef0
[    3.343804] Call Trace:
[    3.344383]  <TASK>
[    3.344872]  pgd_alloc+0x5d/0x1d0
[    3.345643]  mm_init+0x1df/0x3b0
[    3.346395]  alloc_bprm+0x10b/0x1c0
[    3.347231]  do_execveat_common+0x9b/0x300
[    3.348162]  __x64_sys_execve+0x41/0x60
[    3.349020]  do_syscall_64+0xe0/0x8a0
[    3.349860]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[    3.351009] RIP: 0033:0x7f30004f423b
[    3.351831] Code: 0f 1e fa 48 8b 05 85 1d 10 00 48 8b 10 e9 0d 00
00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 f3 0f 1e fa b8 3b 00 00
00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d c5 1a 10 08
[    3.356028] RSP: 002b:00007f2fff657e68 EFLAGS: 00000202 ORIG_RAX:
000000000000003b
[    3.357707] RAX: ffffffffffffffda RBX: 00007ffc318c6b90 RCX: 00007f30004=
f423b
[    3.359321] RDX: 00007ffc318c77d8 RSI: 00007ffc318c6e80 RDI: 00007ffc318=
c6e60
[    3.360894] RBP: 00007f2fff657ff0 R08: 00007ffc318c68c0 R09: 00000000000=
00000
[    3.362483] R10: 0000000000000008 R11: 0000000000000202 R12: 00007ffc318=
c68c0
[    3.364061] R13: 0000000000000040 R14: 0000000000000001 R15: 00007f2fff6=
57f20
[    3.365657]  </TASK>
[    3.366177] Modules linked in: xhci_pci xhci_hcd virtio_net
net_failover failover virtio_blk virtio_balloon uhci_hcd ohci_pci
ohci_hcd evdev ehci_pci ehci_hcd 9pnet_virtio 9p 9pnet netfs
[    3.369780] CR2: 00000000000004e8
[    3.370543] ---[ end trace 0000000000000000 ]---
[    3.371578] RIP: 0010:memcg_stat_mod+0x2c/0x90
[    3.372584] Code: 40 d6 0f 1f 44 00 00 55 41 56 53 48 89 cb 89 d5
48 85 ff 74 3d 66 90 48 63 86 c0 19 00 00 4c 8b b4 c7 90 08 00 00 49
83 c6 48 <49> 8b be a0 04 00 00 48 39 f7 75 2d 48 63 d3 8f
[    3.376675] RSP: 0018:ffff9b62c0817de0 EFLAGS: 00010206
[    3.377838] RAX: 0000000000000000 RBX: 0000000000000001 RCX: 00000000000=
00001
[    3.379437] RDX: 0000000000000025 RSI: ffff98d33fffdcc0 RDI: ffff98cc08b=
8d142
[    3.380994] RBP: 0000000000000025 R08: 0000000000007fff R09: ffffffff990=
79980
[    3.382586] R10: 0000000000017ffd R11: 00000000ffff7fff R12: ffff98cc031=
0c138
[    3.384188] R13: 00007ffc318c77d8 R14: 0000000000000048 R15: ffff98cc009=
e2280
[    3.385761] FS:  00007f2fffd3d400(0000) GS:ffff98d385556000(0000)
knlGS:0000000000000000
[    3.387554] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.388836] CR2: 00000000000004e8 CR3: 00000001089ad000 CR4: 00000000003=
50ef0
[    3.390449] Kernel panic - not syncing: Fatal exception
[    3.391806] Kernel Offset: 0x16200000 from 0xffffffff81000000
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[    3.394178] Rebooting in 10 seconds..

> +#else
> +       return NULL;
> +#endif
> +}
> +
>  static inline void __pagetable_ctor(struct ptdesc *ptdesc)
>  {
>         pg_data_t *pgdat =3D NODE_DATA(memdesc_nid(ptdesc->pt_flags));
> +       struct mem_cgroup *memcg =3D pagetable_memcg(ptdesc);
>
>         __SetPageTable(ptdesc_page(ptdesc));
> -       mod_node_page_state(pgdat, NR_PAGETABLE, ptdesc_nr_pages(ptdesc))=
;
> +       memcg_stat_mod(memcg, pgdat, NR_PAGETABLE, ptdesc_nr_pages(ptdesc=
));
>  }
>
>  static inline void pagetable_dtor(struct ptdesc *ptdesc)
>  {
>         pg_data_t *pgdat =3D NODE_DATA(memdesc_nid(ptdesc->pt_flags));
> +       struct mem_cgroup *memcg =3D pagetable_memcg(ptdesc);
>
>         ptlock_free(ptdesc);
>         __ClearPageTable(ptdesc_page(ptdesc));
> -       mod_node_page_state(pgdat, NR_PAGETABLE, -ptdesc_nr_pages(ptdesc)=
);
> +       memcg_stat_mod(memcg, pgdat, NR_PAGETABLE, -ptdesc_nr_pages(ptdes=
c));

Re: the RCU read lock discussion, I spotted that too. I'm also not
100% clear on whether or not it's required. folio_memcg says:

"For a kmem folio a caller should hold an rcu read lock to protect
memcg associated with a kmem folio from being released."

But on the other hand get_mem_cgroup_from_folio seems to think it's
fine to unconditionally call folio_memcg without an RCU read lock, it
seems to think we only need one whilst acquiring a reference, and once
we have that we can unlock. (Not that that helps us greatly, I don't
think we want ptdecs to hold a reference for their entire lifetime.)


>  }
>
>  static inline void pagetable_dtor_free(struct ptdesc *ptdesc)
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 3cc8ae722886..e9b1da04938a 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -564,7 +564,7 @@ FOLIO_MATCH(compound_head, _head_3);
>   * @ptl:              Lock for the page table.
>   * @__page_type:      Same as page->page_type. Unused for page tables.
>   * @__page_refcount:  Same as page refcount.
> - * @pt_memcg_data:    Memcg data. Tracked for page tables here.
> + * @pt_memcg:         Memcg that this page table belongs to.
>   *
>   * This struct overlays struct page for now. Do not modify without a goo=
d
>   * understanding of the issues.
> @@ -602,7 +602,7 @@ struct ptdesc {
>         unsigned int __page_type;
>         atomic_t __page_refcount;
>  #ifdef CONFIG_MEMCG
> -       unsigned long pt_memcg_data;
> +       struct mem_cgroup *pt_memcg;


>  #endif
>  };
>
> @@ -617,7 +617,7 @@ TABLE_MATCH(rcu_head, pt_rcu_head);
>  TABLE_MATCH(page_type, __page_type);
>  TABLE_MATCH(_refcount, __page_refcount);
>  #ifdef CONFIG_MEMCG
> -TABLE_MATCH(memcg_data, pt_memcg_data);
> +TABLE_MATCH(memcg_data, pt_memcg);
>  #endif
>  #undef TABLE_MATCH
>  static_assert(sizeof(struct ptdesc) <=3D sizeof(struct page));
> --
> 2.47.3
>

