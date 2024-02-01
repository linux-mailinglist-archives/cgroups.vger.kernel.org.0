Return-Path: <cgroups+bounces-1302-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD965846239
	for <lists+cgroups@lfdr.de>; Thu,  1 Feb 2024 22:02:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A5FBB23005
	for <lists+cgroups@lfdr.de>; Thu,  1 Feb 2024 21:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630E13D3A7;
	Thu,  1 Feb 2024 21:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f9+n7d1p"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9188F3CF6C
	for <cgroups@vger.kernel.org>; Thu,  1 Feb 2024 21:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706821339; cv=none; b=aZpalSOLMurdipqe8++3CVD0VntWObC6RAScyIf3InhsaVFbHNwkpiONnojwI4LQweJZPjiLRt5LqHkYXKmeW0Pcr8xD2ddS22wChXbMeKYcKwW5knB2pTY538hV9/3s8fU91yyo5IG+AA+gkA7bVZ3K/SosyDeMHtr07BYkQGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706821339; c=relaxed/simple;
	bh=0dfXP2IydAYbm2ze2LiRZyGi7712o8/4DN3sqKc38LI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=URcZMhgK7ivd5S8NN6gXRihqlQYKv8r/IF2kiM5uujYyehWeEuxmma1ABKDgXgZeR3FzGNEXHUM7TWCwQpNmwptmltxFpt35xoKqT/lGvfuRLL6rIBI/WFiqodhhxG6N+MkXXRLtgLcVg80y1pD/8ZXIsQoimdFFZKt6xA8M6Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f9+n7d1p; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6e125818649so828844a34.1
        for <cgroups@vger.kernel.org>; Thu, 01 Feb 2024 13:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706821336; x=1707426136; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jOZ2TseNRwk51MKJZKHvasS/mSGbsWbhCUKsCqe4rtM=;
        b=f9+n7d1pVe5IX5pOCgqB/gZExV6rwdURzZtcwPkThCGkfq9edDmyTdC7R7uK7j3TKI
         3jZVjUfTXKZ6lFmA+gwSWcB35Sj73Utsy6XA6/oeYRRumDylBRxIKnjQS2eTsVGbc7zK
         gRRlP7efVebnEwoduCmYZIm3LlOG6subE9e5yJA0oU/kwGw/U4v0bU3iWncYbJVs9Mqr
         T4SjU++mRYGX2cGrgL/9YAc8bm9vMBNHLYrTgdPb15pKzfRBWhd8wUXzXjh3mhaDhYIK
         NpKL50CrpPUZckEslY7QvKlFhNFhtpORJIaQjMxS4UqhJlH3anJe2YjXYgRPVg+0mQsS
         dCnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706821336; x=1707426136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jOZ2TseNRwk51MKJZKHvasS/mSGbsWbhCUKsCqe4rtM=;
        b=ij4lA8BDryMlwydi4BGmocvTYJBVUjCKVVqPMDjdkMeY+HDdIYt+THv6qraGdt3X0Y
         sWrgyf7gTZgmlkZX6NUMAPtzAr0KB1h67SOw5BXknbaqXKSi1qN6goAWXr4axRKloJZR
         hnYqWPs7+zXM5GDGg4IKQTBsaGEnTXDGYPNSeg1SBYVu8o/Asm2jAjbIteLh4KvgZb8Q
         dWTtniDWFmWTkUh1XWg0P9ByW+x7CuGEbOMBabIGUIR0GQw9LV5fTjyv01/SIsY7gm2w
         +IYI/0lNv3EB9/VAQN8crkMDVrlvVqh9ZSeczUAyPtaaOEqzNwzFJQMkf7OW14rrnXg7
         jCHQ==
X-Gm-Message-State: AOJu0YxiNq0PVht0/iAcmsqh9c0l9yLSTUGsr4+W0IHOtmtJY9klaUyv
	p7Y54Nhj9MCP6hxB9zug1oBjRDn14R/uAz+fC4ksTXEM6dB/dQJbi4AM/g5f0kD5v2HoOdzfgxJ
	/bC+78wzQ5xSQA6Hj3hXVS8A+bGj9pdZ8UmOKxlfCM1Xtw0GUudUn
X-Google-Smtp-Source: AGHT+IHCUKaSHtSi9u6hTQ7MDouhvCivlBO94D4qN5GxJ/UQSh2zmLA9mHcjhvIF66SjdJ8igcZQLuiLZksx2q8EZm0=
X-Received: by 2002:a05:6830:100d:b0:6e1:34d7:27b1 with SMTP id
 a13-20020a056830100d00b006e134d727b1mr6035791otp.8.1706821336502; Thu, 01 Feb
 2024 13:02:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126211927.1171338-1-tjmercier@google.com> <ufczw2a3urgi6pi6apzkic5zgquxy2mxls6g2tjfjjkttk3tni@yowqxhlqkz56>
In-Reply-To: <ufczw2a3urgi6pi6apzkic5zgquxy2mxls6g2tjfjjkttk3tni@yowqxhlqkz56>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Thu, 1 Feb 2024 13:02:04 -0800
Message-ID: <CABdmKX1b2GjrUmgTEq+tgwdYyqp_2qhs1G5AHBeKCNSfdbO8Eg@mail.gmail.com>
Subject: Re: [PATCH v2] mm: memcg: Don't periodically flush stats when memcg
 is disabled
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeelb@google.com>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, android-mm@google.com, 
	Minchan Kim <minchan@google.com>, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 6:26=E2=80=AFAM Michal Koutn=C3=BD <mkoutny@suse.com=
> wrote:
>
> On Fri, Jan 26, 2024 at 09:19:25PM +0000, "T.J. Mercier" <tjmercier@googl=
e.com> wrote:
> > The root memcg is onlined even when memcg is disabled. When it's online=
d
> > a 2 second periodic stat flush is started, but no stat flushing is
> > required when memcg is disabled because there can be no child memcgs.
> > Most calls to flush memcg stats are avoided when memcg is disabled as a
> > result of the mem_cgroup_disabled check added in 7d7ef0a4686a
> > ("mm: memcg: restore subtree stats flushing"), but the periodic flushin=
g
> > started in mem_cgroup_css_online is not. Skip it.
>
> Have you tried
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -6099,6 +6099,9 @@ int __init cgroup_init(void)
>         cgroup_unlock();
>
>         for_each_subsys(ss, ssid) {
> +               if (!cgroup_ssid_enabled(ssid))
> +                       continue;
> +
>                 if (ss->early_init) {
>                         struct cgroup_subsys_state *css =3D
>                                 init_css_set.subsys[ss->id];
> @@ -6118,9 +6121,6 @@ int __init cgroup_init(void)
>                  * disabled flag and cftype registration needs kmalloc,
>                  * both of which aren't available during early_init.
>                  */
> -               if (!cgroup_ssid_enabled(ssid))
> -                       continue;
> -
>                 if (cgroup1_ssid_disabled(ssid))
>                         pr_info("Disabling %s control group subsystem in =
v1 mounts\n",
>                                 ss->legacy_name);
> ?
> I'm asking about a try because I'm not sure whether this does not blow
> up due to something missing. But I think disabled controllers would not
> need to be (root-)onlined at all.
>
> Thanks,
> Michal

Hi Michal,

It does blow up, but not how I was expecting. There's a null pointer
dereference inside find_css_set when trying to get a css pointer for
the memory controller, I think because the allocation in
cgroup_init_subsys is skipped:

[    9.591766] BUG: kernel NULL pointer dereference, address: 0000000000000=
000
[    9.591909] #PF: supervisor read access in kernel mode
[    9.592023] #PF: error_code(0x0000) - not-present page
[    9.592138] PGD 0 P4D 0
[    9.592199] Oops: 0000 [#1] PREEMPT SMP PTI
[    9.592289] CPU: 1 PID: 1 Comm: init Tainted: G            E
6.7.0-mainline-maybe-dirty #1
[    9.592490] Hardware name: emulation qemu-x86/qemu-x86, BIOS
2023.07-rc6-gb8315a3184b2-ab11347395 07/01/2023
[    9.592731] RIP: 0010:find_css_set+0x5c3/0x7a0
[    9.592850] Code: 20 69 cf b2 4e 8b 3c 33 48 c7 c7 1d 3b 41 b2 4c
89 fe e8 10 b0 f7 00 49 8b b4 24 a0 00 00 00 4e 8d 24 2b 49 81 c4 b0
fc ff ff <49> 8b 0f 4c 01 e9 48 c7 c7 c4 c0 46 b2 4c 89 e2 e8 e8 af f7
00 49
[    9.593251] RSP: 0018:ffffb6218000bb90 EFLAGS: 00010087
[    9.593370] RAX: 0000000000000021 RBX: ffff99181044a200 RCX: 4f5e789f089=
a0c00
[    9.593554] RDX: ffffb6218000ba50 RSI: ffffffffb2448284 RDI: ffffffffb2c=
91950
[    9.593735] RBP: ffffb6218000bc28 R08: 0000000000000fff R09: ffffffffb2c=
79950
[    9.593909] R10: 0000000000002ffd R11: 0000000000000004 R12: ffff9918104=
4a2d8
[    9.594102] R13: 0000000000000428 R14: 0000000000000020 R15: 00000000000=
00000
[    9.594291] FS:  00007f3d2f986fc8(0000) GS:ffff99182bd00000(0000)
knlGS:0000000000000000
[    9.594467] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    9.594610] CR2: 0000000000000000 CR3: 00000001001d8001 CR4: 00000000003=
70eb0
[    9.594818] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[    9.595007] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[    9.595178] Call Trace:
[    9.595237]  <TASK>
[    9.595297]  ? __die_body+0x5e/0xb0
[    9.595392]  ? __die+0x9e/0xb0
[    9.595481]  ? page_fault_oops+0x35f/0x3d0
[    9.595574]  ? do_user_addr_fault+0x6ab/0x780
[    9.595690]  ? prb_read_valid+0x28/0x60
[    9.595782]  ? exc_page_fault+0x83/0x220
[    9.595874]  ? asm_exc_page_fault+0x2b/0x30
[    9.595966]  ? find_css_set+0x5c3/0x7a0
[    9.596059]  cgroup_migrate_prepare_dst+0x75/0x2b0
[    9.596194]  cgroup_attach_task+0x293/0x450
[    9.596305]  ? cgroup_attach_task+0xb6/0x450
[    9.596449]  __cgroup_procs_write+0xef/0x1a0
[    9.596589]  cgroup_procs_write+0x16/0x30
[    9.596733]  cgroup_file_write+0x9d/0x260
[    9.596840]  kernfs_fop_write_iter+0x145/0x1e0
[    9.596981]  vfs_write+0x276/0x2e0
[    9.597092]  ksys_write+0x73/0xe0
[    9.597198]  __x64_sys_write+0x1a/0x30
[    9.597303]  do_syscall_64+0x5a/0x100
[    9.597430]  entry_SYSCALL_64_after_hwframe+0x6e/0x76


But there are also calls to mem_cgroup_css_from_folio that I think
would cause a different null pointer deref even if we had the css but
no root_mem_cgroup. There seems to be an assumption that we'll have a
memcg to charge against even when the controller is disabled. To me it
looks like that's to simplify the possible combinations of
CONFIG_MEMCG and memcg being boot-time disabled or not.

Best,
T.J.

