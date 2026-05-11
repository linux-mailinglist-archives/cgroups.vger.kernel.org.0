Return-Path: <cgroups+bounces-15759-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBt+C9jrAWpHmQEAu9opvQ
	(envelope-from <cgroups+bounces-15759-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 16:46:48 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A404451081A
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 16:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E702F301BF59
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 14:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C8E3FE664;
	Mon, 11 May 2026 14:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IX17E5e/"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424A73F0A88
	for <cgroups@vger.kernel.org>; Mon, 11 May 2026 14:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778510288; cv=pass; b=DQpOLXRTPhs0GxmalueUSpOsrTIhpoKrnw6AhlgedS6gYvl9NSBpG3m15PhFff12RQC1kzd3SrN9KQi4RB0Zc1TX5ujMMJkdIjuokUQciIuqO1NaUxjqah59QXjccfGu/ZeN4FM60pzjDIOnBek1hVsz9OOUwgE5xQWJd3BbkYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778510288; c=relaxed/simple;
	bh=iZ8NM1SOxPEuR5EgmO8bQ4STsBJsTQQQqi5kX9RG3iA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J8NK1Lwvj8er3bf/RmUp6vUhAXsKVvOmr8jYi6FcQCP1WyqnmmJ1CmwkF3tkCRYe4D1vqhgrLZilbe47QvOuDLiJn5fkeb505k4W7j8H2nv15UPf0L3KOcnF6ZEOtDoNMUZqJnakb7alPysd01oWb3FoLFBa7NB1Mr+ofVrGzEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IX17E5e/; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-67bce1840f1so6904989a12.3
        for <cgroups@vger.kernel.org>; Mon, 11 May 2026 07:38:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778510286; cv=none;
        d=google.com; s=arc-20240605;
        b=bSLEc9H7+CXt6hvJ97Q4/nh+s2Bqc3XOS/1dF3k11D9QzUwe8ZeWpUxNXqVI8jOeTS
         fGQwTeazBpbmcTp4UCpjsPk03hltcwWE+kg0MtwDu7oGMYcNA2/5BWASQE5oazAYA8cF
         Fph4fPI5+aemtqaiLr8XkRc+FXS/S0y7M0tJ+zFnkn9Qg6Epvpo8cSCMpbOmYxpWfGBL
         th8PAcO+qBKiTX8J0tsLPF2SioT1IW3orudnXuIb2sLAGNwubyfr2sbk2KEFEyexwPeQ
         8U2LJi6lsTJZQLeHK9AhEV4NaLo5NIW9Mahw5HtOP0/Q+DiLJGBvRntwSUsNv8yLOz7n
         41bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9ZiESKaSmHrhzXZAuFxzd9+gmYiqDerEKwxgDPEPT7E=;
        fh=t/mgwp/K4CyDyclAOT8hcZzxadFDJfC82K+qPaetl30=;
        b=NxJcJ4Vy7N11W2NdbAdkWlznUDsCvAHLWjDTDj8YCcnQcPWxEw3KAVLkZJ0X7BU/Vx
         V91ZQhtnRPvt1Dk+EKTdYw7jGNLRGj/ICVRGCsCEyJ/CKVR4cEkWVNK+/rtCbZGOuG/N
         pWmq2ajySMEQZyfU7cEov9i2EoKV13EnOBH5DdQqvcMJzdGKtafKbZX25xxgbW7/5Aut
         bs/bmLB0ntEo/6RttETueU2b7TBZP5S3yGtmY37L0tKxOeqFDLINZ4aMkX8iB1ZX0ffu
         DprkhpcJkJlx7lUdipR0tlfPhmLnxY8+Wn+43N9oAhPKJojNrO13Z4qgzgi+okp58Wnl
         DEwA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778510286; x=1779115086; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ZiESKaSmHrhzXZAuFxzd9+gmYiqDerEKwxgDPEPT7E=;
        b=IX17E5e/Jku0vP0tR7FDLM6jW3gjL80csssxl8pgl7rTv5UgdaWb1Yu2Xq+QEvkW7S
         yTQ65FIcCwrGY4Xs6DRBy/+IDlXYrdEnRBGsL6omheeWvhZ/1+dv4FD+VpWZb+tFP84Z
         UswhSxkjzrAgwe6fyC+pyc8g00Ir06pu72yAZ04x/EJ37TkpboPkWWft345Pm2AvvDEQ
         bOFmnVsV7MwabJpNHPkamVHl1vRnX2GURghwN2e+t/I4M3zTMXEv8N8f/TjBUe2OWZuo
         F06pxx49mhgt+ErCMvhM0BCD4508LgMCLHdisiF8TaiOi9B69+Bh1vN+CMhtqHw98FCk
         T94w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778510286; x=1779115086;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9ZiESKaSmHrhzXZAuFxzd9+gmYiqDerEKwxgDPEPT7E=;
        b=Y4J2u47+Q7dnaBzRNtAeX8+e22QSc50FDOcGRr5G/YQv94qHY8vi8+9vybY2wOnxCN
         +1uZUcq4LZh/f/cJmD0NiAdJhRzeeHGUUNzHZ9EIF96oU5QFPpdIMZ5UIimiMR5iUld+
         mma0RdsIExXCeSXfHyHc6IVmWrtH6BBr8sTUO4/blK8gJyzDTsBTnWBJX+8aJ1Lf376p
         xMMVk4YYguRZ/9qdyRpzJqsHKDo9gQiySFeiY3U0TlCx0ZBo8xP/oWitp9WNDxag/gK4
         hdHCt4M2gUiYEdHxiKaXYckOZte7Gi0Z8AkH6MYBefkbTGTa3bpFTfYUibV8bGxHG7tA
         kTMA==
X-Forwarded-Encrypted: i=1; AFNElJ88oxXuZmG9mb8StOp4vahqZN/eJCwDxnFY+IgOXtdb8fq66jRsAWFTZ2DeJW02d0NoYSEHUhqD@vger.kernel.org
X-Gm-Message-State: AOJu0YwaSk9MWljKT2ccaza1JxVMW0aTLPjPUoTjUDkrj7OXixFCkzvo
	1JaLrESiS5aKu4mukGspwPeFewk/riXm36jFvV9YYg8F/tAfD+xzm8oCUOM5dYRSzP/oMUkiihS
	qrbikQbf6RFww5u/zKYcsb3XAoDWyquE=
X-Gm-Gg: Acq92OEgfv0zMLUDw84TY1YSelgNJTD5UcdZFc52rNgkc3yB9thSn0XBtvHolXIgTJD
	VEUvXsUf5Ig7wlGUxjaRBIXq8OTmy5GPcESw30/CVi/WnDlCxHFff/EV78sUvMm/amGGzSQ4DAf
	MxSxBO8Q9/0FjyY+FUJWeXFrJCKHzGEdR9a1fXfisJlF8VM+SsAu9vfKkK8u4XPqxXS7OrHxDz/
	GnzvSZB266x/3C8nYQBNy4r7dSEk2enYGlwpdifemDPdmrKwEmJUPtfPGIgFE+SZkQ10iVgGKmq
	yZf/7Dm5XqxPcyqhWVGTtY1qPniVtChcXJBmVbAv
X-Received: by 2002:a05:6402:3488:b0:67e:2498:dcd3 with SMTP id
 4fb4d7f45d1cf-67e2498e469mr9847674a12.10.1778510285464; Mon, 11 May 2026
 07:38:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421-swap-table-p4-v3-0-2f23759a76bc@tencent.com>
 <20260421-swap-table-p4-v3-5-2f23759a76bc@tencent.com> <675e9027-9fb5-47b5-9a2d-c9a416a27d0d@kernel.org>
In-Reply-To: <675e9027-9fb5-47b5-9a2d-c9a416a27d0d@kernel.org>
From: Kairui Song <ryncsn@gmail.com>
Date: Mon, 11 May 2026 22:37:29 +0800
X-Gm-Features: AVHnY4J-RB-ZDfdS6FAfBEaq19cvRhvZlma3LO8yAi80-MrE3Vte83LIs6YuJlc
Message-ID: <CAMgjq7DegMz2ZEHOhHkAqDEWDuCSZ7Ktsxw1ibDY8axFzRRGnQ@mail.gmail.com>
Subject: Re: [PATCH v3 05/12] mm, swap: unify large folio allocation
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song <baohua@kernel.org>, 
	Hugh Dickins <hughd@google.com>, Chris Li <chrisl@kernel.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Baoquan He <bhe@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Youngjun Park <youngjun.park@lge.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, Dev Jain <dev.jain@arm.com>, 
	Lance Yang <lance.yang@linux.dev>, Michal Hocko <mhocko@suse.com>, Michal Hocko <mhocko@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Axel Rasmussen <axelrasmussen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: A404451081A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15759-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kvack.org,linux-foundation.org,nvidia.com,linux.alibaba.com,kernel.org,google.com,huaweicloud.com,gmail.com,redhat.com,cmpxchg.org,lge.com,linux.dev,bytedance.com,vger.kernel.org,arm.com,suse.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ryncsn@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,tencent.com:email]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 8:58=E2=80=AFPM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> On 4/21/26 08:16, Kairui Song via B4 Relay wrote:
> > From: Kairui Song <kasong@tencent.com>
> >
> > Now that direct large order allocation is supported in the swap cache,
> > both anon and shmem can use it instead of implementing their own method=
s.
> > This unifies the fallback and swap cache check, which also reduces the
> > TOCTOU race window of swap cache state: previously, high order swapin
> > required checking swap cache states first, then allocating and falling
> > back separately. Now all these steps happen in the same compact loop.
> >
> > Order fallback and statistics are also unified, callers just need to
> > check and pass the acceptable order bitmask.
> >
> > There is basically no behavior change. This only makes things more
> > unified and prepares for later commits. Cgroup and zero map checks can
> > also be moved into the compact loop, further reducing race windows and
> > redundancy
> >
>
> You should spell out the rename from swapin_folio() to swapin_entry() [an=
d why
> it is done].
>
> swapin_readahead() vs. swapin_entry() looks a bit odd, fiven that both co=
nsume
> an entry.

Yes, the current status is a bit odd, about two years ago I also
wanted to name it `swapin_direct()`.
https://lore.kernel.org/linux-mm/20240326185032.72159-3-ryncsn@gmail.com/

But actually ZRAM or shmem would also benefit from supporting unified
readahead like this:
https://lore.kernel.org/linux-mm/20240102175338.62012-6-ryncsn@gmail.com/

So calling it `swapin_entry` seems more future-proof. At some point in
the future we might remove `swapin_readahead`. All swapin operations
could have a unified or at least a per-device readahead policy like
the one in the link above, instead of the current policy where the
caller must decide whether to perform readahead.

But any suggestion on naming is welcome :)

> >  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> >  /*
> >   * Check if the PTEs within a range are contiguous swap entries
> > @@ -4642,8 +4622,6 @@ static bool can_swapin_thp(struct vm_fault *vmf, =
pte_t *ptep, int nr_pages)
> >        */
> >       if (unlikely(swap_zeromap_batch(entry, nr_pages, NULL) !=3D nr_pa=
ges))
> >               return false;
> > -     if (unlikely(non_swapcache_batch(entry, nr_pages) !=3D nr_pages))
> > -             return false;
> >
>
> This should also be pointed out in the patch description. (and why it is =
ok)

Right, the check is now resolved by the swap cache layer, so the
caller no longer needs to check it. I'll describe that in the commit
message.

Thanks!

