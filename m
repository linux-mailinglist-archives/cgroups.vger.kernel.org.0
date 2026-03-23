Return-Path: <cgroups+bounces-15000-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MEtsBIOBwWl2TgQAu9opvQ
	(envelope-from <cgroups+bounces-15000-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 23 Mar 2026 19:08:03 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6122FAE85
	for <lists+cgroups@lfdr.de>; Mon, 23 Mar 2026 19:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF2AD3206AE0
	for <lists+cgroups@lfdr.de>; Mon, 23 Mar 2026 16:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624273C1974;
	Mon, 23 Mar 2026 16:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQw/Tj+l"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6B33BA238
	for <cgroups@vger.kernel.org>; Mon, 23 Mar 2026 16:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774284094; cv=pass; b=k1hfYXgrWiI93CtFO3mCMgb+LI6khcki2/pvaMv47zTwKQ2gG17yo+k7IsrRauYYnan5LIqo9eP+H0GkUaRoZuEcKKbLo4Ak3RYrEtz1hqqsgRYrNdl1BxuKFuhZDlcNawpCKKXTlKrcUl1vn1f2adbJycp8HWOJb6FBuS7wWkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774284094; c=relaxed/simple;
	bh=qfm+jxRDid/tXrKxPwqn57nuEjBnj1DDrZrU+wNae2E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lHyABpM9JcGIFC2e1X6eEF4kObEqqML/R98DJvv5oAIHopKPSTsn4XLrudHAGYR3+7vQELTvpZ9UfYmGhz6ULuzCM5BtF0Baw+6XFm8+bvKY3xo0Vm/TmqXGLfR7tgYSRCBw/GiucKjYyyuQ8Gkpou6cZNW7rJm1TwtrFv/p+x4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AQw/Tj+l; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-669462b0fecso544572a12.3
        for <cgroups@vger.kernel.org>; Mon, 23 Mar 2026 09:41:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774284090; cv=none;
        d=google.com; s=arc-20240605;
        b=CSi61upnCuLshN6PuZz488KY5TyQ/JflSxJ9E+k1BxrxdC711ULHTXwfgX0yka03YD
         /2o7AAdiVAAt1FtugjkgrQEaxNk44Pxk7IuJUDexzTVtYYHnFLpD55jNaYhFkRaA3zA+
         Z5axi/dcr9r+AWNqlL0TneIATR4dmAiZPeWC9aEvV5uYACARp5kJ5FXiJ/HleVckMP0v
         JPpR3cbNReQeKwwwNuyWfkW6sn8Vi0pPnsMeZxSj0mUoneGml7BeiADkVXN77webEa6e
         GCzAE6BW8Ja0eUqQjdkDszlAwLoR0Ghbbfl8LySXMMroF71eNO4dMI3RKw05rytMb0+D
         wwlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vmCa6NJatdq+42qe8sVhhvk4aoBatMqzy8mT5DZOBUc=;
        fh=J7McyCsMi/BOQfXbSJ1641YFnsiI/zQ0yL7mjZAOXso=;
        b=LffN2MhEHIDUmghMlQCblR+bh9hIy2N8PimQgUQyd01bpRNvzsLiS2ZzWgoDdCZSrq
         3FtjT7H/eX5uj3X6GRFDPSh8LtCzrrOzM52upKsY1QFVlr4VXbB64yVEsXxXHZKKwhwB
         upD/TNchcsiS8AficiWIssPDVwHf/ibUMDTKfk0kSo9Q2NEWHaGzrLxNsNhSYv0zDPd1
         pOrYTYsq5Vp/gWM/CPhkhWZ7uq0JCLBu+eP7Bc1Q5+oAciZhfYUhQzeeOjD2l3nQS4GQ
         yQ/OSYEJzZM41Og7hmTBn/QGGfBisZScWzOdno7VOo/eeRzdY5nUcBb0+D8XctEXHoBu
         GvKw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774284090; x=1774888890; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vmCa6NJatdq+42qe8sVhhvk4aoBatMqzy8mT5DZOBUc=;
        b=AQw/Tj+lI1htlIyduQK+LigMZe4ERziEeLn9lfuqmPjqbBpqoeZRLKp4k1oAAvbfwY
         vHjjcuo48HwT0/yCLIP/DM2xX8DfnBxfd24mR+HqP88YTe4n3uj9SkaHV2YKOejJz3Y5
         olgr6ZYJqiVHo9Y3fSwDb/cE9O60ZexePMb4qPWGnKphqQqnHUuchODbk5TEFJfugPJL
         OwboUfm0V38awswDw1iSbJZv+S4YeJJgiYXuhEH7E4M58WtUxYyWS9gI7ZDGWRgp0Wcl
         7uq9ChgUTp5SPI52gxLQxHooBcJj8toMw8+Yhtw07Mbl+xd5wfVzvj3fhhZicjXDUuSn
         ww0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774284090; x=1774888890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vmCa6NJatdq+42qe8sVhhvk4aoBatMqzy8mT5DZOBUc=;
        b=i9Lr5Ed5prFw4U3YmmA9Rjs6ZL2sAyY0qQms3j8keM+/225A1qPymkFFb08Mo4SmNp
         ZqBp0qI1ogp+J+R47w48Wc4U4l6wTvn6KSwop5fe0N5BFm0vJGtlr2pkMtFx4HgnMr2E
         8JC1BwivUSZRt6NtBC4eOef6hcU0NFJ+I/QUXhf2B5z5Geaizp2WwSCMTiX3Jvpp/XGD
         mYlZUu+Vp5Hil8ZmFzthsVVSEKUYuXF233bdQFzgzvlINGHJex6Y77h53Eg4B0JmH4MZ
         2v6VManE6m0MKf/CICGtr1ClhWomJgfmT9VmnfToSIRIf8xq+Dqy5Vbt6ez6JKpER5jK
         IZ2g==
X-Forwarded-Encrypted: i=1; AJvYcCVsdVhSnInZDEMsENwYq/6ABEcRyohNntEeBR35Or2vh7gOuswpj6uA9jAh+INYeMwzOdmAnCW+@vger.kernel.org
X-Gm-Message-State: AOJu0YyPp4yjn88me3k3AxK/B5E5hclEt3Q84Bh0DlOh5mkAMS1BHG97
	9a0KHy66QfPHYTyEH3Efvh4RU6QwtRgWbcyF+7YFnZzZgK4NfmY/xnp6Gde+IBL/prO+Ayz0x+U
	YS+fzj+5o8Wq17GLWXEpmkJTvA52u8iU=
X-Gm-Gg: ATEYQzxPBKWxDrh1X62Ya1mYHoVYOK4D9y7NBYctCA5qtrq4c9dl0B03QE1sXGYwjhd
	QNa3oaZB7HCB3Q4VBaiZSMBL/3+mQ57biVSwrJxN7yXHwlYr1cKxdjUgP9VoKgKqLv53RTRMy6S
	O9GYApnuLQXsjnny+a0xQIcag0D7iVoaboWor25L94oger7b9CUtQjyiVGReoVnum7u7wsgtpCk
	hy3TdjHkbkBJ15golXk7n/ESl7CFpJgYwJ6I8/dYOu5unMf7SQRfw7EuIlGdKy0U7EuurAhwyTW
	hHqYgsYna75yrDUZmr1PkRyp36pHB6Kdi0VH7+a9
X-Received: by 2002:a17:906:c398:b0:b97:1009:7536 with SMTP id
 a640c23a62f3a-b982f286a8fmr671723566b.15.1774284089391; Mon, 23 Mar 2026
 09:41:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320192735.748051-1-nphamcs@gmail.com> <CAMgjq7AiUr_Ntj51qoqvV+=XbEATjr7S4MH+rgD32T5pHfF7mg@mail.gmail.com>
 <CAKEwX=PBjMVfMvKkNfqbgiw7o10NFyZBSB62ODzsqogv-WDYKQ@mail.gmail.com>
In-Reply-To: <CAKEwX=PBjMVfMvKkNfqbgiw7o10NFyZBSB62ODzsqogv-WDYKQ@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Tue, 24 Mar 2026 00:40:52 +0800
X-Gm-Features: AQROBzD1kpskNn11W5HqnEfFhEQur5XfLuCkDmtbLopJRo-HyQHAInVqxx1Q2Xw
Message-ID: <CAMgjq7AzySv801qDxfc8mEkEsFDv4P=_qw0rNOTe0n+qy7Fz6A@mail.gmail.com>
Subject: Re: [PATCH v5 00/21] Virtual Swap Space
To: Nhat Pham <nphamcs@gmail.com>
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org, apopple@nvidia.com, 
	axelrasmussen@google.com, baohua@kernel.org, baolin.wang@linux.alibaba.com, 
	bhe@redhat.com, byungchul@sk.com, cgroups@vger.kernel.org, 
	chengming.zhou@linux.dev, chrisl@kernel.org, corbet@lwn.net, david@kernel.org, 
	dev.jain@arm.com, gourry@gourry.net, hannes@cmpxchg.org, hughd@google.com, 
	jannh@google.com, joshua.hahnjy@gmail.com, lance.yang@linux.dev, 
	lenb@kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-pm@vger.kernel.org, lorenzo.stoakes@oracle.com, 
	matthew.brost@intel.com, mhocko@suse.com, muchun.song@linux.dev, 
	npache@redhat.com, pavel@kernel.org, peterx@redhat.com, peterz@infradead.org, 
	pfalcato@suse.de, rafael@kernel.org, rakie.kim@sk.com, 
	roman.gushchin@linux.dev, rppt@kernel.org, ryan.roberts@arm.com, 
	shakeel.butt@linux.dev, shikemeng@huaweicloud.com, surenb@google.com, 
	tglx@kernel.org, vbabka@suse.cz, weixugc@google.com, 
	ying.huang@linux.alibaba.com, yosry.ahmed@linux.dev, yuanchu@google.com, 
	zhengqi.arch@bytedance.com, ziy@nvidia.com, kernel-team@meta.com, 
	riel@surriel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15000-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,linux-foundation.org,nvidia.com,google.com,kernel.org,linux.alibaba.com,redhat.com,sk.com,vger.kernel.org,linux.dev,lwn.net,arm.com,gourry.net,cmpxchg.org,gmail.com,kvack.org,intel.com,suse.com,infradead.org,suse.de,huaweicloud.com,suse.cz,bytedance.com,meta.com,surriel.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_GT_50(0.00)[53];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ryncsn@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,man7.org:url]
X-Rspamd-Queue-Id: 6A6122FAE85
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026 at 11:33=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrot=
e:
>
> On Mon, Mar 23, 2026 at 6:09=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wr=
ote:
> >
> > On Sat, Mar 21, 2026 at 3:29=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> w=
rote:
> > > This patch series is based on 6.19. There are a couple more
> > > swap-related changes in mainline that I would need to coordinate
> > > with, but I still want to send this out as an update for the
> > > regressions reported by Kairui Song in [15]. It's probably easier
> > > to just build this thing rather than dig through that series of
> > > emails to get the fix patch :)
> > >
> > > Changelog:
> > > * v4 -> v5:
> > >     * Fix a deadlock in memcg1_swapout (reported by syzbot [16]).
> > >     * Replace VM_WARN_ON(!spin_is_locked()) with lockdep_assert_held(=
),
> > >       and use guard(rcu) in vswap_cpu_dead
> > >       (reported by Peter Zijlstra [17]).
> > > * v3 -> v4:
> > >     * Fix poor swap free batching behavior to alleviate a regression
> > >       (reported by Kairui Song).
> >
>
> Hi Kairui! Thanks a lot for the testing big boss :) I will focus on
> the regression in this patch series - we can talk more about
> directions in another thread :)

Hi Nhat,

> Interesting. Normally "lots of zero-filled page" is a very beneficial
> case for vswap. You don't need a swapfile, or any zram/zswap metadata
> overhead - it's a native swap backend. If production workload has this
> many zero-filled pages, I think the numbers of vswap would be much
> less alarming - perhaps even matching memory overhead because you
> don't need to maintain a zram entry metadata (it's at least 2 words
> per zram entry right?), while there's no reverse map overhead induced
> (so it's 24 bytes on both side), and no need to do zram-side locking
> :)
>
> So I was surprised to see that it's not working out very well here. I
> checked the implementation of memhog - let me know if this is wrong
> place to look:
>
> https://man7.org/linux/man-pages/man8/memhog.8.html
> https://github.com/numactl/numactl/blob/master/memhog.c#L52
>
> I think this is what happened here: memhog was populating the memory
> 0xff, which triggers the full overhead of a swapfile-backed swap entry
> because even though it's "same-filled" it's not zero-filled! I was
> following Usama's observation - "less than 1% of the same-filled pages
> were non-zero" - and so I only handled the zero-filled case here:
>
> https://lore.kernel.org/all/20240530102126.357438-1-usamaarif642@gmail.co=
m/
>
> This sounds a bit artificial IMHO - as Usama pointed out above, I
> think most samefilled pages are zero pages, in real production
> workloads. However, if you think there are real use cases with a lot

I vaguely remember some workloads like Java or some JS engine
initialize their heap with fixed value, same fill might not be that
common but not a rare thing, it strongly depends on the workload.

> of non-zero samefilled pages, please let me know I can fix this real
> quick. We can support this in vswap with zero extra metadata overhead
> - change the VSWAP_ZERO swap entry type to VSWAP_SAME_FILLED, then use
> the backend field to store that value. I can send you a patch if
> you're interested.

Actually I don't think that's the main problem. For example, I just
wrote a few lines C bench program to zerofill ~50G of memory
and swapout sequentially:

Before:
Swapout: 4415467us
Swapin: 49573297us

After:
Swapout: 4955874us
Swapin: 56223658us

And vmstat:
cat /proc/vmstat | grep zero
thp_zero_page_alloc 0
thp_zero_page_alloc_failed 0
swpin_zero 12239329
swpout_zero 21516634

There are all zero filled pages, but still slower. And what's more, a
more critical issue, I just found the cgroup and global swap usage
accounting are both somehow broken for zero page swap,
maybe because you skipped some allocation? Users can
no longer see how many pages are swapped out. I don't think you can
break that, that's one major reason why we use a zero entry instead of
mapping to a zero readonly page. If that is acceptable, we can have
a very nice optimization right away with current swap.

That's still just an example. bypassing the accounting and still
slower is not a good sign. We should focus on the generic
performance and design.

Yet this is just another new found issue, there are many other parts
like the folio swap allocation may still occur even if a lower device
can no longer accept more whole folios, which I'm currently
unsure how it will affect swap.

> 1. Regarding pmem backend - I'm not sure if I can get my hands on one
> of these, but if you think SSD has the same characteristics maybe I
> can give that a try? The problem with SSD is for some reason variance
> tends to be pretty high, between iterations yes, but especially across
> reboots. Or maybe zram?

Yeah, ZRAM has a very similar number for some cases, but storage is
getting faster and faster and swap occurs through high speed networks
too. We definitely shouldn't ignore that.

> 2. What about the other numbers below? Are they also on pmem? FTR I
> was running most of my benchmarks on zswap, except for one kernel
> build benchmark on SSD.
>
> 3. Any other backends and setup you're interested in?
>
> BTW, sounds like you have a great benchmark suite - is it open source
> somewhere? If not, can you share it with us :) Vswap aside, I think
> this would be a good suite to run all swap related changes for every
> swap contributor.

I can try to post that somewhere, really nothing fancy just some
wrapper to make use of systemd for reboot and auto test. But all test
steps I mentioned before are already posted and publically available.

