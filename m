Return-Path: <cgroups+bounces-10701-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CC0BD65F9
	for <lists+cgroups@lfdr.de>; Mon, 13 Oct 2025 23:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A91C34F33D8
	for <lists+cgroups@lfdr.de>; Mon, 13 Oct 2025 21:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD8C2D193C;
	Mon, 13 Oct 2025 21:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YKDFaieF"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80D91547D2
	for <cgroups@vger.kernel.org>; Mon, 13 Oct 2025 21:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760391219; cv=none; b=M4XUMKqH6lhaLdugFBqP7RvzZ61oIjxdbcRuZ9xkXb9enaFDKS7YA45NnLi1eGmsdlbweFinoe3XXROlG64upDI0KdvKc8cxtVFC2pwEGNZ670ljXOZ8qa7w/bXr+3CgHocbInvC6yoZLq3zaVU91sgYqkirys83o+Mfn71B504=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760391219; c=relaxed/simple;
	bh=KtbfqF6QABNLG4G4ZFBgbcYtAla65oYtsrqmOimMNi8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M1o4nVNMVCmZMGw0eTVbFLoMrPHIAOJO2GSAEfhNWUZsEPRWf14AV+O/T8u2SFMdSDjJuuqdVZZU/J1oun8GmAcPE+i0caQmwEpDECqs2FfpPs/0evlB5MIYKMu21dBWXWrXJwzBOggvBUIkEL57x32unGbsuGhSPRwZ7tscH1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YKDFaieF; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3ece0e4c5faso4427675f8f.1
        for <cgroups@vger.kernel.org>; Mon, 13 Oct 2025 14:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760391216; x=1760996016; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ZUcfu/lY1a0PBj+NQhiKBcjA+Mj4IzkP02rncu56NU=;
        b=YKDFaieFsQEEuljMWqCM8ez9KuRvDVU7L2WT5xZ8WwErLqpAKwFLtBdqd4wt39MnTe
         qhs9Dzh1yGAzn/8xH5HLivs4khjh3nrjJluqLcN9wNXWO3rFxD28Us3SSpdkrgb1Ph9f
         pwqPByB7WX6464x+Z1WdCgisUbCZclfuzp/P54oSkxuPwwXG3m8U99iTeiKmXaT2KXX+
         V3jcnzd9Zyx/A7ShsBKBFByQUWhgeEGQVKUz7cEDhDUKKAzGJSA+rfxF9YPbi0YwS1WD
         iC9QxcQmvX3Pcb6PxrzS/J+5tnP4Afg789iGmwOLb8W5PqYh6o99kTKczXi/Kne5hNvs
         LkZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760391216; x=1760996016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ZUcfu/lY1a0PBj+NQhiKBcjA+Mj4IzkP02rncu56NU=;
        b=rNU3jasQvjwzyKbC02Qf1N/Al9Bot9i0SPs0rV8r/8cmz8u5aiS/ul8tnLKgn27hdW
         EiM8XmEWx1jOZGCh3GUU+4X09k4AfYEzRUssJ5wjTL4z3obIBMOd6mFqKKI0Z6aysjon
         PW54A6Bz73oRwSthGwGBSIbEWhWuegC48NoA+Hq57p0Rzj4X9vySOB4S16E5Jx9+tCAO
         sxU1hevb8v0+5Cge+zFGqmaHlGEMvlecakGxi7NypwvuqbgrErYjNyH52hPr1v2x6fIL
         bN+QzV93DztHVeUXVy5xxXxb0YhkUGtEPMbt1/gpaw7nP5C9wCSdKwTXyhA3U1PpZXt2
         tyMQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/auTgtmiPmCs8ajCLX5haZoEHS4uA5f8D//khO1JKMPTlRcCJn5r9uzIVmoQt/uEb4ynsWgJg@vger.kernel.org
X-Gm-Message-State: AOJu0Yww6j8oWa2VgNhDuAJKRNK2pZ73v5aSEtwUEm05jwJlkbemNBoT
	mzrwtmMTe5yQabDUG9ZJIw7djGhp4wIbIP/qsDu2L5jZqwSax5XwHDonL3yCkizdXEfgB9iIeTi
	eNBBG+7iC6dWdkjOLz/Uz7UyHY0v5aXk=
X-Gm-Gg: ASbGncsqibwyliLthFN/ynvkTgOYfwaArroJ9IwTb9V9YeagZqWndP1LwxPMBFiZpcS
	RXyuMCpfaX2RNUGjowfHRKjG5J7UWbi1Is+dsRxRkEy+9Sg0w2IFX5DPps0dPCpayYB1kgxCKVK
	uiutrfu+OgACKCdNUlmiDB3R6M3HhjROLlRU6fw80NG2VK3JsaoedrwAro3INbX5ZQL46Ff7h/I
	MIhEh9R8oXmwXzU9940DLwRUkCXu0DKFrHZCCROuO0HQOQoJnxtCTmXVjdCerGscdZVhQ==
X-Google-Smtp-Source: AGHT+IHlObtCjPy8HAxyLJKUgyqBPTd1YCFgsUa+Y+27KX2893URbWswd2YijWA4M7gHzOuw6MrNZ5TM7a4jhudubqU=
X-Received: by 2002:a05:6000:2c0e:b0:408:d453:e40c with SMTP id
 ffacd0b85a97d-4266726d9famr14296862f8f.25.1760391215858; Mon, 13 Oct 2025
 14:33:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202510101652.7921fdc6-lkp@intel.com> <692b6230-db0c-4369-85f0-539aa1c072bb@suse.cz>
In-Reply-To: <692b6230-db0c-4369-85f0-539aa1c072bb@suse.cz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 13 Oct 2025 14:33:24 -0700
X-Gm-Features: AS18NWDZt8nn8SNzaUniYFQxsv0RyUfuDnFuvS487pngygUdhSUHcYIgCPrXOLo
Message-ID: <CAADnVQJLD7+7aySxv+NtS9LMFgj-O=RhSjkF3b-X3ngwzU2K4Q@mail.gmail.com>
Subject: Re: [linus:master] [slab] af92793e52: BUG_kmalloc-#(Not_tainted):Freepointer_corrupt
To: Vlastimil Babka <vbabka@suse.cz>
Cc: kernel test robot <oliver.sang@intel.com>, Alexei Starovoitov <ast@kernel.org>, oe-lkp@lists.linux.dev, 
	kbuild test robot <lkp@intel.com>, LKML <linux-kernel@vger.kernel.org>, 
	Harry Yoo <harry.yoo@oracle.com>, kasan-dev <kasan-dev@googlegroups.com>, 
	"open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>, linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 7:58=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 10/10/25 10:39, kernel test robot wrote:
> >
> >
> > Hello,
> >
> > kernel test robot noticed "BUG_kmalloc-#(Not_tainted):Freepointer_corru=
pt" on:
> >
> > commit: af92793e52c3a99b828ed4bdd277fd3e11c18d08 ("slab: Introduce kmal=
loc_nolock() and kfree_nolock().")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> >
> > [test failed on      linus/master ec714e371f22f716a04e6ecb2a24988c92b26=
911]
> > [test failed on linux-next/master 0b2f041c47acb45db82b4e847af6e17eb66cd=
32d]
> > [test failed on        fix commit 83d59d81b20c09c256099d1c15d7da2196958=
1bd]
> >
> > in testcase: trinity
> > version: trinity-i386-abe9de86-1_20230429
> > with following parameters:
> >
> >       runtime: 300s
> >       group: group-01
> >       nr_groups: 5
> >
> >
> >
> > config: i386-randconfig-012-20251004
> > compiler: gcc-14
> > test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m=
 16G
> >
> > (please refer to attached dmesg/kmsg for entire log/backtrace)
> >
> >
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new ve=
rsion of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > | Closes: https://lore.kernel.org/oe-lkp/202510101652.7921fdc6-lkp@inte=
l.com
>
> Does this fix it?
> ----8<----
> From 5f467c4e630a7a8e5ba024d31065413bddf22cec Mon Sep 17 00:00:00 2001
> From: Vlastimil Babka <vbabka@suse.cz>
> Date: Mon, 13 Oct 2025 16:56:28 +0200
> Subject: [PATCH] slab: fix clearing freelist in free_deferred_objects()
>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/slub.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/mm/slub.c b/mm/slub.c
> index f9f7f3942074..080d27fe253f 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -6377,15 +6377,16 @@ static void free_deferred_objects(struct irq_work=
 *work)
>                 slab =3D virt_to_slab(x);
>                 s =3D slab->slab_cache;
>
> +
> +               /* Point 'x' back to the beginning of allocated object */
> +               x -=3D s->offset;
>                 /*
>                  * We used freepointer in 'x' to link 'x' into df->object=
s.
>                  * Clear it to NULL to avoid false positive detection
>                  * of "Freepointer corruption".
>                  */
> -               *(void **)x =3D NULL;
> +               set_freepointer(s, x, NULL);
>
> -               /* Point 'x' back to the beginning of allocated object */
> -               x -=3D s->offset;
>                 __slab_free(s, slab, x, x, 1, _THIS_IP_);

Thanks for the fix!
Acked-by: Alexei Starovoitov <ast@kernel.org>

The bot spotted it with CONFIG_SLAB_FREELIST_HARDENED=3Dy.
It wasn't part of my tests. Sorry.

