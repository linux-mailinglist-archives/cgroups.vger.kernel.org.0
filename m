Return-Path: <cgroups+bounces-14999-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABXIJ8FkwWkjSwQAu9opvQ
	(envelope-from <cgroups+bounces-14999-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 23 Mar 2026 17:05:21 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 451232F78B2
	for <lists+cgroups@lfdr.de>; Mon, 23 Mar 2026 17:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB12E332E861
	for <lists+cgroups@lfdr.de>; Mon, 23 Mar 2026 15:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEAD93B3C08;
	Mon, 23 Mar 2026 15:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZjwIrys"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF9B3AE1BB
	for <cgroups@vger.kernel.org>; Mon, 23 Mar 2026 15:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774279992; cv=pass; b=jsvj0PeTmDtA3sGt9nfJtxBaIlnSXevyPNU/9PBht1Hl4gP8vyxasE0mwFb1AjpKnY2gqo+ev3jhV7cawcoTgwCPxJPZoV5LhVLRbapr4AbDdvjk81B0o72BUSxk7vWUsECOljBlX1S5slSCNIUNNQLASqDwCtxH7g82K03ek28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774279992; c=relaxed/simple;
	bh=arS6rKQpeugPn1Nw9evVWPQO6eJXSH50PWdiL/uU/vU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fxhon5PPKGXt9D0ioDZbX7FOSLqjSGUoP3eVtBEYqxIMlaNtjxqD8AgoaSPqL/n+x0c0WKG4VdrY++kt/AN5ohiWEUo1doifMjUQbg2128psInsEsG0h7xUT9mKTzv1QLQebo7X3yBToweXHl2yidte7YH8lGQx7luL4P5ErHbk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PZjwIrys; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-439b7c2788dso1899510f8f.1
        for <cgroups@vger.kernel.org>; Mon, 23 Mar 2026 08:33:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774279989; cv=none;
        d=google.com; s=arc-20240605;
        b=Awjh7CNcyxhRBP+gFHANrEeXBu2Ossn+SDZILelTgcL0FhdxkbWtjb9CJMhm5AjApq
         vjQtUPboetALGXg4Xl/CsT0bAdze26kHvHjabOXz5vbDHb6WCHqMaSbLbSfhXqMiUae2
         PGbp6s6COimIoecX6L+F4uZWpF5rd63WJJBkumU7cNZ7VdN8ZYfM3s+rUFJWNA41yxw+
         5ty+/euIBv0cLVeTiDNQGFePkAvWLdO0aehUCR9ILfjSGgna2Z6b0B2YCYrzicL3/gVX
         MhMDRdTEG1e0HPt3Bh2tDCwWVInn/YoxT+dkMZfPCO78xlq/OswBPNu2BzGyqBxhl4NO
         SUjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/8/EpSUMiobTzSVmJaDTjFNXTjCi0aA95G2967Wvfq8=;
        fh=AJFvbxuSdvwwD0XE0AYDGNf7oORDWt8v3FgFMv4kXDs=;
        b=TyUaJzEvYUjJDdlKpQciHshpJxFBwwzhW1kSeLW7AvqoTEMduUX686ujyw9eVigOc+
         YPpBNGASrw9ng11Aupp5gRXsrS3FvvvqRVfx7s0E34r0Bnn8sufgZFf/j6WM7Wf2ZrkY
         Es3AzyVHSHa1sENU5GyInl9In5xbmBp+5bk/XkUQXG/pBITxQNbxjMx2tRQYAUe25Yln
         ZeDTibCz+oH3FDUOm8I/YanHXmF+cC1D91THYjIofNAHmQy6Z4Ftd5g3TV9h1wz3cSsp
         db32qEXx58chMn/fN9sBjU3POjWTC1AA6xvEiMaaR4547Gjw03seJm5AeibeVgX7hkh/
         2EAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774279989; x=1774884789; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/8/EpSUMiobTzSVmJaDTjFNXTjCi0aA95G2967Wvfq8=;
        b=PZjwIrysaUY04YiNZGW8yIggnceuIonNG1kp4/viAwXQeNEO0i55lo5gOao1Kir4W1
         qSiSLZfnvNhXvJMt0m3lPixAJA4qcycSa7aLtudq2abTJlPQU6UkDE6+VF998QVu4gfA
         szeaamGx7JReHhnP4IGS4AKwMQlFNtzrWgE4m6CNDRLM/xNkfNk8cZmiVYF5uwswsHcw
         CbzP/Rj9rDtwdgLWpBlyskRdl9yUuev+DOYnb+8AKFFtYSolujcxkvJSTZJ+dJPY1p+u
         aVKZfOaAHRr52AX/pEAoJtx7ovftL7tBECTAYVLFKirg4T89MP/3nhIb9ujnh0eUsFcw
         id4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774279989; x=1774884789;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/8/EpSUMiobTzSVmJaDTjFNXTjCi0aA95G2967Wvfq8=;
        b=Wc4wGEJp6zDG1fTY+NyYQPowwkwfCLWtchT2DHiOIKLT9UpP1uGktNw7XneZ9tzdCX
         ZyUSWkczOTMkS1IoUazPF70dt+dtW3Cxa5bPE5OoXxqHYJtOLwD9t+nIf1tTyELzeVlR
         nAfw3P0aznBrgFrexRd6DdJSmYtx16P459GXR/InzRgpsEELJI3XGQyveBO/0BVWEGL5
         0zuYfiG6x4MpfGnf2W6INtkMPQVh7OKoBRGGjyhHO8ZT8AWeWASDpyQrw2tjJnX1q0Oi
         6pfHgLDxcekXDLRmJo1C4xfCbtnPMH9BU7jPmSucysRk8EmFPFvdO7tuQKaSOlb42/uY
         lenQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjC7c9ALH1hRFduDLDcIa9OQLN9U/jajOEFOuAy/1YkHL6Ut3NWvaJrjhtPHmEJeFksgKynd34@vger.kernel.org
X-Gm-Message-State: AOJu0YwO3zlRvPuhoMiKWNvqPFF7wIA1/VqgQZ1cq/DnerNhfgvwkHTs
	EufBvIctHDn4fPxO44CoUq0sKqfVgVhr+2+asI9MrAP0Nxmnbh4kHZ5z1EPG310ES1mebR+tExX
	7zbJCn3diErA6RSa93o7o1Iq0CMxIpiU=
X-Gm-Gg: ATEYQzzWfFwaFV5XkzAyPJXw5sZ95vvO4W0asxlF+D/XOElfaWq2KHlTyDoj4mTXcUH
	1kA9a7G1kOINnPTpQoVVOIbPvCOhdeAFE9Fyk1MzrWu3ucu/uxP4baT0JeBHdL7wr3AZZ36z1Xu
	kbNhIpAS20FU8JWyAFzJpZXgUenPbH0FabLdlhBs6hgPrS7WN/lmNXYJbWLF5rHax2xxneflPom
	R8m+3+WcoIrp5WG1ooRRZ1aIVmwLe9oqhmmbbJoq762D0cI8h7kjCm7jbOmPNNTWHA5/EGl8i4D
	WNO5I/4cMsiJIqTfQJwlwWcKfu3fmVz2P4vfmQfa0GOMhuLuZFca
X-Received: by 2002:a5d:5f84:0:b0:43b:4703:9de5 with SMTP id
 ffacd0b85a97d-43b642870f9mr18306704f8f.44.1774279988876; Mon, 23 Mar 2026
 08:33:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320192735.748051-1-nphamcs@gmail.com> <CAMgjq7AiUr_Ntj51qoqvV+=XbEATjr7S4MH+rgD32T5pHfF7mg@mail.gmail.com>
In-Reply-To: <CAMgjq7AiUr_Ntj51qoqvV+=XbEATjr7S4MH+rgD32T5pHfF7mg@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Mon, 23 Mar 2026 11:32:57 -0400
X-Gm-Features: AQROBzBAs5nRbrIlBu1cKcNEaCz87nNyEV8cMyR6rMkBGG9vg_P1d2ioQYJMLuk
Message-ID: <CAKEwX=PBjMVfMvKkNfqbgiw7o10NFyZBSB62ODzsqogv-WDYKQ@mail.gmail.com>
Subject: Re: [PATCH v5 00/21] Virtual Swap Space
To: Kairui Song <ryncsn@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14999-lists,cgroups=lfdr.de];
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
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 451232F78B2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026 at 6:09=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> On Sat, Mar 21, 2026 at 3:29=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wro=
te:
> > This patch series is based on 6.19. There are a couple more
> > swap-related changes in mainline that I would need to coordinate
> > with, but I still want to send this out as an update for the
> > regressions reported by Kairui Song in [15]. It's probably easier
> > to just build this thing rather than dig through that series of
> > emails to get the fix patch :)
> >
> > Changelog:
> > * v4 -> v5:
> >     * Fix a deadlock in memcg1_swapout (reported by syzbot [16]).
> >     * Replace VM_WARN_ON(!spin_is_locked()) with lockdep_assert_held(),
> >       and use guard(rcu) in vswap_cpu_dead
> >       (reported by Peter Zijlstra [17]).
> > * v3 -> v4:
> >     * Fix poor swap free batching behavior to alleviate a regression
> >       (reported by Kairui Song).
>

Hi Kairui! Thanks a lot for the testing big boss :) I will focus on
the regression in this patch series - we can talk more about
directions in another thread :)

> I tested the v5 (including the batched-free hotfix) and am still
> seeing significant regressions in both sequential and concurrent swap
> workloads
>
> Thanks for the update as I can see It's a lot of thoughtful work.
> Actually I did run some tests already with your previously posted
> hotfix based on v3. I didn't update the result because very
> unfortunately, I still see a major performance regression even with a
> very simple setup.
>
> BTW there seems a simpler way to reproduce that, just use memhog:
> sudo mkswap /dev/pmem0; sudo swapon /dev/pmem0; time memhog 48G; sudo swa=
poff -a
>
> Before:
> (I'm using fish shell on that test machine so this is fish time format):
> ________________________________________________________
> Executed in   20.80 secs    fish           external
>    usr time    5.14 secs    0.00 millis    5.14 secs
>    sys time   15.65 secs    1.17 millis   15.65 secs
> ________________________________________________________
> Executed in   21.69 secs    fish           external
>    usr time    5.31 secs  725.00 micros    5.31 secs
>    sys time   16.36 secs  579.00 micros   16.36 secs
> ________________________________________________________
> Executed in   21.86 secs    fish           external
>    usr time    5.39 secs    1.02 millis    5.39 secs
>    sys time   16.46 secs    0.27 millis   16.46 secs
>
> After:
> ________________________________________________________
> Executed in   30.77 secs    fish           external
>    usr time    5.16 secs  767.00 micros    5.16 secs
>    sys time   25.59 secs  580.00 micros   25.59 secs
> ________________________________________________________
> Executed in   37.47 secs    fish           external
>    usr time    5.48 secs    0.00 micros    5.48 secs
>    sys time   31.98 secs  674.00 micros   31.98 secs
> ________________________________________________________
> Executed in   31.34 secs    fish           external
>    usr time    5.22 secs    0.00 millis    5.22 secs
>    sys time   26.09 secs    1.30 millis   26.09 secs
>
> It's obviously a lot slower.
>
> pmem may seem rare but SSDs are good at sequential, and memhog uses
> the same filled page and backend like ZRAM has extremely low overhead
> for same filled pages. Results with ZRAM are very similar, and many
> production workloads have massive amounts of samefill memory.
>
> For example on the Android phone I'm using right now at this moment:
> # cat /sys/block/zram0/mm_stat
> 4283899904 1317373036 1370259456        0 1475977216   116457  1991851
>    87273  1793760
> ~450M of samefill page in ZRAM, we may see more on some server
> workload. And I'm seeing similar memhog results with ZRAM, pmem is
> just easier to setup and less noisy. also simulates high speed
> storage.

Interesting. Normally "lots of zero-filled page" is a very beneficial
case for vswap. You don't need a swapfile, or any zram/zswap metadata
overhead - it's a native swap backend. If production workload has this
many zero-filled pages, I think the numbers of vswap would be much
less alarming - perhaps even matching memory overhead because you
don't need to maintain a zram entry metadata (it's at least 2 words
per zram entry right?), while there's no reverse map overhead induced
(so it's 24 bytes on both side), and no need to do zram-side locking
:)

So I was surprised to see that it's not working out very well here. I
checked the implementation of memhog - let me know if this is wrong
place to look:

https://man7.org/linux/man-pages/man8/memhog.8.html
https://github.com/numactl/numactl/blob/master/memhog.c#L52

I think this is what happened here: memhog was populating the memory
0xff, which triggers the full overhead of a swapfile-backed swap entry
because even though it's "same-filled" it's not zero-filled! I was
following Usama's observation - "less than 1% of the same-filled pages
were non-zero" - and so I only handled the zero-filled case here:

https://lore.kernel.org/all/20240530102126.357438-1-usamaarif642@gmail.com/

This sounds a bit artificial IMHO - as Usama pointed out above, I
think most samefilled pages are zero pages, in real production
workloads. However, if you think there are real use cases with a lot
of non-zero samefilled pages, please let me know I can fix this real
quick. We can support this in vswap with zero extra metadata overhead
- change the VSWAP_ZERO swap entry type to VSWAP_SAME_FILLED, then use
the backend field to store that value. I can send you a patch if
you're interested.

>
> I also ran the previous usemem matrix, which seems better than V3 but
> still pretty bad:
> Test: usemem --init-time -O -n 1 56G, 16G mem, 48G swap, avgs of 8 run.
> Before:
> Throughput (Sum): 528.98 MB/s Throughput (Mean): 526.113333 MB/s Free
> Latency: 3037932.888889
> After:
> Throughput (Sum): 453.74 MB/s Throughput (Mean): 454.875000 MB/s Free
> Latency: 5001144.500000 (~10%, 64% slower)
>
> I'm not sure why our results differ so much =E2=80=94 perhaps different L=
RU
> settings, memory pressure ratios, or THP/mTHP configs? Here's my exact
> config in the attachment. Also includes the full log and info, with
> all debug options disabled for close to production. I ran it 8 times
> and just attached the first result log, it's all similar anyway, my
> test framework reboot the machine after each test run to reduce any
> potential noise.

Ohh interesting - I see that you're testing with MGLRU. I can give that a t=
ry.

I'm not enabling THP/mTHP, but I don't see that you're enabling it
either - there's some 2MB swpout but that seems incidental.

Another difference is the swap backend:

1. Regarding pmem backend - I'm not sure if I can get my hands on one
of these, but if you think SSD has the same characteristics maybe I
can give that a try? The problem with SSD is for some reason variance
tends to be pretty high, between iterations yes, but especially across
reboots. Or maybe zram?

2. What about the other numbers below? Are they also on pmem? FTR I
was running most of my benchmarks on zswap, except for one kernel
build benchmark on SSD.

3. Any other backends and setup you're interested in?

BTW, sounds like you have a great benchmark suite - is it open source
somewhere? If not, can you share it with us :) Vswap aside, I think
this would be a good suite to run all swap related changes for every
swap contributor.

Once again, thank you so much for your engagement, Kairui. Very much
appreciated - I owe you a beverage of your choice whenever we meet.
And have a great rest of your day :)

