Return-Path: <cgroups+bounces-13300-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6407BD392A7
	for <lists+cgroups@lfdr.de>; Sun, 18 Jan 2026 05:21:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E8E6530142F3
	for <lists+cgroups@lfdr.de>; Sun, 18 Jan 2026 04:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB363093DD;
	Sun, 18 Jan 2026 04:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bls05Lgy"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3CB1DB54C
	for <cgroups@vger.kernel.org>; Sun, 18 Jan 2026 04:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768710089; cv=none; b=R7iRlWdRRhzkCwIETdhgIIKfn13DjxHHEsrBNh+Dapvvk1pYgWdYH20AFespD5ciFsmhhNERR3WBzWoYswY51OdJou4sKL3LX9K1VqwuV/MRidyV0FLsDH/eKS9hh6YGVLRF+On3rWmRfsyJfIGy0vXpeQJiKTnHKbKH8TQ2I/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768710089; c=relaxed/simple;
	bh=ukI+kEOj/cGQyyCjyPxQSuABT/N914Wao8s+5zzCDWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oXTxMlJ3P67w3EOnJiv5HJw6h8s/9Jpbnb2c8xwPlebM3OxgDf2pTLzEqDqFgV84mjpLSCPFs2hE5awnjtdcWBs9mU9o8Dg/2qfG9UgUgCRNWxO5x/KaxZENHBPl9IFkAa9kduAmEz6XCUE8vMbkIBzThHETdoLj+09mfn55+rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bls05Lgy; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-6466d8fd383so2973238d50.2
        for <cgroups@vger.kernel.org>; Sat, 17 Jan 2026 20:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768710087; x=1769314887; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jvMq2ABTBLrDp9blsAOvXWpoeYwpBXEHUIYBa0P2DU0=;
        b=Bls05LgyXFXjXmV60d9ysOFf5u9rGUe98f+YXDMl/WruhmdlXLtQIgEXisbPyxbOH4
         VfEsCXAvevKpKQnL9/8HZQFzLom3AeOeB61ndyPHdWmodEhvLyuwajcUVBs7wnRHjFlZ
         AZa0s/Q+vxjdCo2yDdGBEqR7fMEeTXGDO458UG4iYj2fZcu1oArypSBaDGSKBz6651yr
         yk6hHmqN/EhrulS0/U6vsDt3FhWDod+NJp9/GDTQdkz5D1remW/m/dRoGD+jFGIo7Vfx
         HQU2o0RleeiUHLcRR+kyiCJ2hraDi7SzbHU3ux0+m/1xx6zUoY07+MwHJi6nonL9t2+L
         9vrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768710087; x=1769314887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jvMq2ABTBLrDp9blsAOvXWpoeYwpBXEHUIYBa0P2DU0=;
        b=EG8Nhs9BSA8Hk6o4yWMvx7ZpI2uYa+S4B0QWzieLRlBYr/bGgIfJGHNbSnRd7hwly/
         nJoJzEyZ2gyBSLA65aYQrQhIRgAzhQs1oEAq3FKXq0eXYSH7LSiqQK3Nw7ilZIKLEyIW
         hvwTCuhIqP07N1Ynd8MVMG3tlfiG55Y228RTC25L7nQ5DVZAppBSDDNssbdam9W5/Er9
         HG8jphr6AU3koUBIPRzsAsAb0HDuDcp1nobINmfC6aAR9dmFcPrDBDoOtA9XS2+fH9Va
         fs6E4CO7uHtrD6ScPJbrL6XVKyewclB+HEwqqKCnYL/y1VgRD66RgqjWC/1BFneac1AH
         1NVA==
X-Forwarded-Encrypted: i=1; AJvYcCVmO8X9aqlUR9iNYyJ75MRDNRwxL0w7yL1cXVLtmk0ukHflaNDq21QbV2fTojmIdiKuTyVxpd0R@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8bvXGCqNBThc+hq8b6AJFl0vcvseUv0QuAgbdERUQlZkKcgSt
	DY48xOGk/RiNAzdMEKET5YkBinYqGwswFvaLB1En/cQjsXszXXFrgc0guINEMD92lxXgBsPhF+2
	CXlqY5nUhaWfrVyDd9VYzxrEH54eLnVo=
X-Gm-Gg: AY/fxX5nBtFkpeA+nScoDKmOhw/gZcvSzzNh2Il+T6d/BcIJg5s1qxLZUCt9jAVh0nf
	AQT6LYKOf4ffDZIfjsGzIZWG4xBZWEHCrNy8aR8rnKJRNgnmhCFuZXIvF+rjeXe/nor9goUH7/m
	3W9b9LQGYkMwIUv3/VrfR7SZZqKGdUe6C0ahivNFfqTtCsgLVQMURvJp2piM8ZJX88ih/owZ1gY
	et/xA/tOk2pcc7dmPa6kYmE2lWZDdQcaTyTlTqS1Vjb+AH3LwUFShDOAwkxe1901DQAkVJGdCuy
	8Twul1F9aIYNvJBYGM2lmGLZVLgwuuqJfdh6ThV9NGLELQp3ACrFn1Canqc=
X-Received: by 2002:a05:690e:1302:b0:63f:9a63:46e5 with SMTP id
 956f58d0204a3-64916485743mr6337211d50.28.1768710086767; Sat, 17 Jan 2026
 20:21:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <696b56b1.050a0220.3390f1.0007.GAE@google.com> <20260117165722.6dc25d72fd58254cb89e711b@linux-foundation.org>
In-Reply-To: <20260117165722.6dc25d72fd58254cb89e711b@linux-foundation.org>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Sun, 18 Jan 2026 09:51:15 +0530
X-Gm-Features: AZwV_QixRjSHf6Sj2BD4t0Ssbbsgw1OyPwSQbE8CQ4kPIPXAspb8klvrwkVJpOY
Message-ID: <CADhLXY6ACKeyLrjARTTdfWyrvUdLbtD-wXiQvsvhsbGjwmUqDA@mail.gmail.com>
Subject: Re: [syzbot] [cgroups?] [mm?] WARNING in memcg1_swapout
To: Andrew Morton <akpm@linux-foundation.org>
Cc: syzbot <syzbot+079a3b213add54dd18a7@syzkaller.appspotmail.com>, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev, 
	syzkaller-bugs@googlegroups.com, Johannes Weiner <hannes@cmpxchg.org>, 
	Muchun Song <muchun.song@linux.dev>, Minchan Kim <minchan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 18, 2026 at 6:27=E2=80=AFAM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Sat, 17 Jan 2026 01:30:25 -0800 syzbot <syzbot+079a3b213add54dd18a7@sy=
zkaller.appspotmail.com> wrote:
>
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    0f853ca2a798 Add linux-next specific files for 20260113
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D14f7259a580=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D8d6e5303d96=
e21b5
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D079a3b213add5=
4dd18a7
> > compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7=
976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D167ef9225=
80000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D16d295fa580=
000
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/480cd223f3f6/d=
isk-0f853ca2.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/1ca2f0dbb7cc/vmli=
nux-0f853ca2.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/60a0fef5805b=
/bzImage-0f853ca2.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+079a3b213add54dd18a7@syzkaller.appspotmail.com
>
> Thanks.
>
> > ------------[ cut here ]------------
> > WARNING: mm/memcontrol-v1.c:642 at memcg1_swapout+0x6c2/0x8d0 mm/memcon=
trol-v1.c:642, CPU#0: syz.4.233/6746
>
> That's
>
>         VM_WARN_ON_ONCE(oldid !=3D 0);
>
> which was added by Deepanshu's "mm/swap_cgroup: fix kernel BUG in
> swap_cgroup_record".
>
> This patch has Fixes: 1a4e58cce84e ("mm: introduce MADV_PAGEOUT"),
> which is six years old.  For some reason it has no cc:stable.
>
> Deepanshu's patch has no reviews.
>
> So can I please do the memcg maintainer summoning dance here?  We have a
> repeatable BUG happening in mainline Linux.
>

Hi Andrew,

I checked the git blame output for commit 0f853ca2a798:

Line 763: memcg1_swapout(folio, swap);
Line 764: __swap_cache_del_folio(ci, folio, swap, shadow);
                    (d7a7b2f91f36b - Kairui Song, 2026-01-13 02:33:36 +0800=
)

Kairui's reordering patch appears to have been merged on Jan 13.
The syzbot report is also from Jan 13, likely from earlier in the
day before the reordering patch was merged.

So this report is from before the fix. The warning should not appear
in linux-next builds after Jan 13.

Thanks,

Deepanshu

