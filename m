Return-Path: <cgroups+bounces-15880-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AExGDrxJBGrNGgIAu9opvQ
	(envelope-from <cgroups+bounces-15880-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 11:51:56 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AA29D530F6A
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 11:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA96A314BAA8
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 09:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3632F3F7AA8;
	Wed, 13 May 2026 09:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qW9VhFoa"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC34A3ED11F
	for <cgroups@vger.kernel.org>; Wed, 13 May 2026 09:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778665430; cv=pass; b=IvKVTVC2AROK28LaviXqdE/I/GC0nnyQ/6BRhkYg1iBn91SWVxBydUUZPnVpoiOKQbv6EGsjngI6ackzgGlZ2TmRbs403uBzD2eyZvCqBy27qfZaVfpYW+KHC72w4U/XBryfCK4fwe1rqJpdTm3bEb0J8q2/xuGNH/40mSJQbn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778665430; c=relaxed/simple;
	bh=Pazc5IEQ6Ii8C0abx/6Fmv8oKyqpgeJo2hE6eLXzNzA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WoCn9XVlRpj77Ui42832QHwPZT88yewKdljJkjBE0HrPQkbI1u5KSqladZ8o4xDiF9y73siaT1mr8Ar7PD+DFtktGxj6CBsytCF5gEjTQ4p+LBiHms5XfQwbBNzEAPLiIdawe7gvAABjn2eTNksNPhAaQC9Z9R2+z7w0s0txU74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qW9VhFoa; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-67e24b8ef55so9298530a12.1
        for <cgroups@vger.kernel.org>; Wed, 13 May 2026 02:43:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778665423; cv=none;
        d=google.com; s=arc-20240605;
        b=clEHLE4Nm81ENAc1YyAp3s6z6ugxDFq/sfFj/FhI+a7oiNSS9ywvq9JM8CVyhrDV86
         DFrpv96BzcfSpzFy90XIkImBmiR9g8IWYTqoBn9i4zBuv+ssMDab1XdKNsiW1XmcmgZm
         vqaKXOK30kD7P/vQeKkkv/OMJFAQUMQxVZOymU6qii5IfJDben46gtSI1fjcgzNDNo/0
         TEugzdF1PSG0gx7Cl8zcDHwRwS64nyCb5fkLz5/DmeQmSAR2g/4YwZ92KBx1a4IxbrjG
         Bzk2CELkTFvqg2xAM5hVW1F+dyhDYz54MEP7LN8M5rcbgBgFmAzpKhMFrld0gER7UjPa
         f1iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wmMKtZcN/YKaHu46Up+XNuhQQ85wQ9nB2tV/Ne4eHcw=;
        fh=+nEzYSdVbRsgzA60e6mp9pZjOa7kd5hh7RumRkHgfl0=;
        b=KZeyCxHIZtcTFtqEwgPbpGY3omBRRTGilHatSn0WcBnH1Mj+85FR9DJau46AIa4dgM
         ZrBxq0tc0G7WcbiBp0naELjoVv93O41qO0i5owpIBBF1A6B5phg9lf2Z9yYG/LvPmR4Q
         Yqko/8141D56J8oQZNy6hcYUIb3wDin9laxq0iX0mwozeToIXDnNUPNJtUD+zohvrZ9b
         QvnL6wp3Lml1cg+frCfUV31UjqAKZAHZaUXtMs+W0Gg/KmjCXzzs4mtkV66KCCSyTcol
         6AIx2SC6bKgvdnJ6e/RnpmOGCD4mUbfFZbINigKaAT1OW2TmUfvavypWBHM5mPpFKlgU
         tLPQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778665423; x=1779270223; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wmMKtZcN/YKaHu46Up+XNuhQQ85wQ9nB2tV/Ne4eHcw=;
        b=qW9VhFoaJXiqClZGa4zw1O6zWtk/x4n15hGljWEQVnGIUxNLz/XWY5a+SCDbKD6b48
         +u4HbqHJmsS0ExXkTsThABDvfIZz2ozBYLDLx6Quwz1uDtbZi0dc9awACKGHg9nFAR29
         yB8xMmp/ZBdxpikQL3ROQsl50n+lWRCW7H1dMG4KibX3c427+5iA3uKqMzYJ5QCdtemo
         W0kAyT6UY0I2IyPuvTXpS+7uvRLEo++j2BwuPp3WQldsUVN+zOqZdnTNaelERlmrIQzh
         zvykt0DJiEUx93Gbz/zUoISPYezZTtZJm/RLDc+vaZGZA0edsXKZJTW63Lj+izWAk+/M
         3W5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778665423; x=1779270223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wmMKtZcN/YKaHu46Up+XNuhQQ85wQ9nB2tV/Ne4eHcw=;
        b=DAxbSJEnS/yxOsxz0nr/i7V4W6GEwxL2rD1GQ3xbmN+PzTcITE/5GFea00WWLYtJv+
         ynMdQ+J/emc/BtUOEHxNQ0XcUTEsxzGjL26b+CW9Y+CILqMrF2rZfm4ZqQMOdCPodzLc
         0BHJDxuhoxH62KGpUPkH4+HlYRBsLoQGD4XfN+doQbXd2NE85AylkYxpXmd10EFpJlv1
         N78HTEalgyf5tibMi6lYsUc6CTRz/nwhn0GObMNigjxauB84weK8DOQtRRi/hzYJjIw6
         +bB3AVMbTLseU+TBIMQ0EyRJmQqI2LtTARcP+T7uf4Astc0xLUAoy5WaGDQkHCMznjHF
         /+5w==
X-Forwarded-Encrypted: i=1; AFNElJ+k7DH/XA8dGdR9cC2xGN1Qh/r5qIPFSh15EjG4g7grze0RgmtZXNcJlbUNSOE1nFI0Tl8n6D3Q@vger.kernel.org
X-Gm-Message-State: AOJu0YyESibmS5opONsIYd3unF53NNQNXRAg5wpiYH99Vw5SGsraiAij
	23Tuvq35QnIj29LOFGnKdOtE7E+DFa9UZJ8KMX7YjAntdK+pueaPA7KJrnZnL704dIqizgQRv13
	C6mpsR0hN/FJLuj5FG8Ixw8NwGl+QNoU=
X-Gm-Gg: Acq92OEuvX8hHuKDAxIJvWk4IuKbkePRwCLz2dR3xOY82nRtgNLFLXbNrEGgYjfA793
	zEaYwRcMuXIStN/t5k5cEK4L+pCNtj3lQw7Fxj7v2swYZvrFaPrq6W2a/js2ZNRfHIKrc2ej7xo
	rI6fmXpFebqbkQttSBy7PQWkKMQVdS2utaNYFhmH7PJnRGIzXDTmbrx8sNjpK1CU8otdeOKAvgu
	VJ6jZPoZAOza8pD4bb0StgNnjkfylqd73rRxqIJxKnwvZkYg9tChBjHxqg94o8SusrHE+WC0+Sn
	mVQaCJl+n5MI1osZeWaLc3JsC03lu8kGDu+E1taU
X-Received: by 2002:a05:6402:6da:b0:673:1d30:29b4 with SMTP id
 4fb4d7f45d1cf-6825770fb1fmr936393a12.23.1778665422620; Wed, 13 May 2026
 02:43:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421-swap-table-p4-v3-0-2f23759a76bc@tencent.com>
 <20260421-swap-table-p4-v3-7-2f23759a76bc@tencent.com> <CACePvbVnDrR6e7wvpF-nf1CWgoMdX4MTf7RSv2bCr28W6d8b2A@mail.gmail.com>
In-Reply-To: <CACePvbVnDrR6e7wvpF-nf1CWgoMdX4MTf7RSv2bCr28W6d8b2A@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 13 May 2026 17:43:05 +0800
X-Gm-Features: AVHnY4KF1TVWaerUh5LwgFhK1-31OyeB_KdLMQWvEcFWc1KpjNwa0lsVGQJryeY
Message-ID: <CAMgjq7BBQf62PuUG-=rX5T50PLb7WQW2QuSj=+n5eNcMZS080A@mail.gmail.com>
Subject: Re: [PATCH v3 07/12] mm, swap: support flexible batch freeing of
 slots in different memcgs
To: Chris Li <chrisl@kernel.org>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song <baohua@kernel.org>, 
	Hugh Dickins <hughd@google.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Youngjun Park <youngjun.park@lge.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, Dev Jain <dev.jain@arm.com>, 
	Lance Yang <lance.yang@linux.dev>, Michal Hocko <mhocko@suse.com>, Michal Hocko <mhocko@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Axel Rasmussen <axelrasmussen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: AA29D530F6A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15880-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kvack.org,linux-foundation.org,kernel.org,nvidia.com,linux.alibaba.com,google.com,huaweicloud.com,gmail.com,redhat.com,cmpxchg.org,lge.com,linux.dev,bytedance.com,vger.kernel.org,arm.com,suse.com];
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

On Fri, May 8, 2026 at 12:01=E2=80=AFPM Chris Li <chrisl@kernel.org> wrote:
>
> On Tue, Apr 21, 2026 at 7:16=E2=80=AFAM Kairui Song via B4 Relay
> <devnull+kasong.tencent.com@kernel.org> wrote:
> >
> > From: Kairui Song <kasong@tencent.com>
> >
> > Instead of requiring the caller to ensure all slots are in the same
> > memcg, make the function handle different memcgs at once.
> >
> > This is both a micro optimization and required for removing the memcg
> > lookup in the page table layer, so it can be unified at the swap layer.
> >
> > We are not removing the memcg lookup in the page table in this commit.
> > It has to be done after the memcg lookup is deferred to the swap layer.
> >
> > Signed-off-by: Kairui Song <kasong@tencent.com>
>
> Overall, it looks good. Some nitpicks follow.
>
> Acked-by: Chris Li <chrisl@kernel.org>
>
> > ---
> >  mm/swapfile.c | 33 +++++++++++++++++++++++++++++----
> >  1 file changed, 29 insertions(+), 4 deletions(-)
> >
> > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > index e1ad77a69e54..8d3d22c463f3 100644
> > --- a/mm/swapfile.c
> > +++ b/mm/swapfile.c
> > @@ -1872,21 +1872,46 @@ void __swap_cluster_free_entries(struct swap_in=
fo_struct *si,
> >                                  unsigned int ci_start, unsigned int nr=
_pages)
> >  {
> >         unsigned long old_tb;
> > +       unsigned int type =3D si->type;
> > +       unsigned short id =3D 0, id_cur;
>
> Nitpick: I'm tempted to rename a few variables to improve my
> understanding. Feel free to keep it as it is.
>
> id -> batch_id

Good idea.

>
> Nitpick: This line confused me a bit. Two offsets are mentioned here:
> "offset + ci_offset". One would assume that ci_offset is the offset of
> the ci, and the offset is the incremental one. It is the other way
> around.

This intermediate swap entry usage will be gone soon in a next commit
so I think it should be fine either way.

>
> > +               id_cur =3D lookup_swap_cgroup_id(entry);
> > +               if (id !=3D id_cur) {
> > +                       if (id)
> > +                               mem_cgroup_uncharge_swap(swp_entry(type=
, offset + ci_batch),
> > +                                                        ci_off - ci_ba=
tch);
>
> With the above rename, this become:
> "... swp_entry(type, ci_offset + batch_off)," ; This combined the
> offset turn into the swap entry.
> "ci_off - batch_off". That is the running length from the beginning of ba=
tch.
>
> > +                       id =3D id_cur;
> > +                       ci_batch =3D ci_off;
> > +               }
> >         } while (++ci_off < ci_end);
> >
> > -       mem_cgroup_uncharge_swap(swp_entry(si->type, offset), nr_pages)=
;
> > -       swap_range_free(si, offset, nr_pages);
> > +       if (id) {
>
> This becomes `if (batch_id)`, meaning if we have pending batching, we
> flush the current batch.

This part does look better. Thnaks!

>
> Chris
>

