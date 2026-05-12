Return-Path: <cgroups+bounces-15849-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCeSMbs/A2rO2AEAu9opvQ
	(envelope-from <cgroups+bounces-15849-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 16:56:59 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2C1523165
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 16:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3DF1030A52EE
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 14:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD93346AC4;
	Tue, 12 May 2026 14:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qmwyoDa6"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D323264D9
	for <cgroups@vger.kernel.org>; Tue, 12 May 2026 14:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778597363; cv=pass; b=DaM1z/CZCOIwWuwQjGZyltWUrAoP0wHGzPA6xDATAAJCggfxUA7nVf34QccXXpZA4i1+dW8c30WqEO5WRsG9x42hY4y1lZkWZuiFqZTm+Ssy2FLo6ng6GO/cYW3fsZ0+C8jEkt7cxNBZkV3wLs+fKm/RPPn6LTSnnHcp/J7zZak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778597363; c=relaxed/simple;
	bh=2RmbmMCZ33TuuII4wRWk86PcnWvE3msSig3I+wv4KS0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YDvEzl5ry5bZTBa5JXP2y2eMTW4ehz92HTjYQrH0Pvg2CyZ+F6MgEx5J5fdwoZ/KXqdn4II1o8ZLIoJIUeOdfsZrNbskWS4/A+ON1tHScfmiiXoMbrCE1NiZzs5ksnk/c4VRheWXp37emvbE9x/LviBFafjRgxXQPOBxLIYhXkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qmwyoDa6; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-67bce1840f1so8797900a12.3
        for <cgroups@vger.kernel.org>; Tue, 12 May 2026 07:49:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778597360; cv=none;
        d=google.com; s=arc-20240605;
        b=hQC6lyKeseoe3akzzAW4QXdcau8Wzbsa7esVYM2gXbDqV6gXDyK976cetJQigCfwYk
         T5Aj3l6z9xKzku21PrpsRviT/T6mhY/128qJVgYdqnl7grOY7S112KddhMhKc7noHB3b
         7IVRkfwPc0hPGwzlZBS7or5Z013srehBMlAmGfUz/JmYkFJ/nwH1l7KVNgpmLsANAyZK
         Pz3L1gPJvUhUagPsArdpnAYEc5yA8J02YEt++vUlImZ5iFuLoT5+9IZj5cux4kff0ClI
         5XQjiydA40umCI2WUHnlY/qha7DW+zRBUYCCRdrmDiV3cGmOTh6upKq7kSEMjy8GLno5
         C3VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=B9eMKwfG9wGO309ZVEQXdjdoVqLMWRmUPakAKUCaz6k=;
        fh=O/N++yrD3PKM62MfjvyfhLW9rqixOwlqJWGMy0LgAew=;
        b=CVlv/JaPT42/3kO+wv8Ns7c+ddFpe4xJQt8eTlJYdgbsYwEY697uG5zV7hE7U3IgF7
         SSTVLL8WYB29PxM7GMjnq5Io7UlHIH1RANu9OCCdJadI/7ad/MgoPoc/OuBUn1teET1a
         aFbzbDRpMAw9UQM8av0RgkrF3l37rYXUblrwLj5akjtUbTzdD+aGzFpXIrY9DfaYfU7/
         z2MzzcXyajupRGyCa9wO28R5Kp2VGSCXeIIQVlbt/0tRMHpZx8Jkdc2EQYOt9+k3KU0g
         41HTCFqP0U7bWvH33o6Iou5IkKgaTuW7HYFwKyg1fdkTy0AhDvuA09DBzGG20hGFDwue
         PdYw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778597360; x=1779202160; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B9eMKwfG9wGO309ZVEQXdjdoVqLMWRmUPakAKUCaz6k=;
        b=qmwyoDa6nJ81e7s71CDw9PToKnDQIYsxL0pzqUnXUk4iUMrAU8T74SG8IHbFUNde2j
         0PBkdkPQZYbIaEGsjFJ6HR31lfIVpUeomVMlSsfvjqXj/gfglX1I96QoHUjIU/u1xOTP
         qj9GVwad7TVdgD45Vp558LCHCdeGeIs3S9TSvxz2OSw37gdOGWIGn3A9l4aDThvzk0DB
         loCnfJH/ZO0x5gH30l0XEWep7FOWstK/zJ6Lr4Bp5vBvGEcvptFTWrQyPu7RZy6y9lO+
         MbwletGIf2jO2O9xxc3pL1T6UhbRnihNzhNyE7J9RCNxCwer0o25MDxm6FaNqeSEMhU2
         4bQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778597360; x=1779202160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B9eMKwfG9wGO309ZVEQXdjdoVqLMWRmUPakAKUCaz6k=;
        b=K51Arl8CQxnvc8zI896z5Uj5oOfY6QOLxu6M1d7doMgIQbntdtTHZrZLxkUXEi2hN9
         2wRmhnerhgf7P7ckbqXz4KCdByUfmE3npJJnAIlGrALirCSegQ0rLjg+RTQcpn045LGt
         Ksk6xhrt4OSZc7MblgJ5ZdVPPEA+G8gpoAwMrF2XFsYxs0os6D6sDUFLuXjSBdb6RXrS
         toS7cfwaaPP2XOFUnrGEJeftmynTICf6GJmo295HTeSM8ZFGweqYmAo4KO01gLdhB3pv
         Yf5PmBvGYcNvp1p2xRXUDaaql4kkRsPRjuIyoDTelen4dYYO86jgVpWn0L5gTz6qq9YQ
         5L4A==
X-Forwarded-Encrypted: i=1; AFNElJ8ltYAK/TWyMHGU2cz9uYUBVYmRM27KO8pmTc+TbyfTw3mTLQLC9JIr3fNpuV/mXeojUs8FNJ7v@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn0ueoTa0iFFMyWB45ACNWaNP2Lo5fbAdiXre+4dhvU3PWDH3k
	GFpxva9QbDmWKuTnexps8+mns3FXl2/y08ahcM8HqO+S1sdQ/32gKjWHppH3bMbs+AcesFmlY3t
	HiJXE2ORtP9NCmB+GecjHjRjDt7WK+us=
X-Gm-Gg: Acq92OHMPwfYA5pk3bDvpO+cIbOGwVjCG87cwxj/L3wsFkq28bFv/muu3te7LX0psjY
	nyeKIFFsiSPnsSc3I2T6GSLdDTGUhfZP/M679gEKdvOHjVf+G0FrkuVD+ts+6KfN03E7ns9RfVj
	gRDASrHLKmc3BU61jVJD3dZ3eSTL1bXsUhbMegpm+VfbgdEzzZF2dlB/pFSfspgdK4GCi8dypzE
	L58goEMNzutOMWPKiQDrBc2WBhN823HSqA15ECyqpnZAMll6SE5BOcqtgu8XktxA1/DKqFuwCtl
	CfpPMgeVgSf1/NYh8Dik0feX4iQgzZtwNtRKdIh5
X-Received: by 2002:a05:6402:2355:b0:672:be92:e913 with SMTP id
 4fb4d7f45d1cf-680cf83c072mr2060165a12.17.1778597359924; Tue, 12 May 2026
 07:49:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421-swap-table-p4-v3-0-2f23759a76bc@tencent.com>
 <20260421-swap-table-p4-v3-2-2f23759a76bc@tencent.com> <CACePvbX3Bead1Ea+UJfUAq0e4JNJ0P+yN0=zf5rhdPsH8y9PUg@mail.gmail.com>
In-Reply-To: <CACePvbX3Bead1Ea+UJfUAq0e4JNJ0P+yN0=zf5rhdPsH8y9PUg@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Tue, 12 May 2026 22:48:43 +0800
X-Gm-Features: AVHnY4JdtaVoMXwP_A9u3LZ_KiSSDXJ3HTWun5ui6FrfOFhsETe7YmM2uJ8JsU4
Message-ID: <CAMgjq7A2EfY65NHbLtcAOPT8Ry0WPgiMJK92LuDMLjpKm3FdQQ@mail.gmail.com>
Subject: Re: [PATCH v3 02/12] mm, swap: move common swap cache operations into
 standalone helpers
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
X-Rspamd-Queue-Id: 3D2C1523165
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15849-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tencent.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Wed, May 6, 2026 at 10:46=E2=80=AFPM Chris Li <chrisl@kernel.org> wrote:
>
> On Tue, Apr 21, 2026 at 8:16=E2=80=AFAM Kairui Song via B4 Relay
> <devnull+kasong.tencent.com@kernel.org> wrote:
> >
> > From: Kairui Song <kasong@tencent.com>
> >
> > Move a few swap cache checking, adding, and deletion operations
> > into standalone helpers to be used later. And while at it, add
> > proper kernel doc.
> >
> > No feature or behavior change.
> >
> > Signed-off-by: Kairui Song <kasong@tencent.com>
>
> Acked-by: Chris Li <chrisl@kernel.org>
>
>
> > ---
> >  mm/swap_state.c | 141 ++++++++++++++++++++++++++++++++++++++----------=
--------
> >  1 file changed, 95 insertions(+), 46 deletions(-)
> >
> > diff --git a/mm/swap_state.c b/mm/swap_state.c
> > index 204a9499d50c..3da285a891b2 100644
> > --- a/mm/swap_state.c
> > +++ b/mm/swap_state.c
> > @@ -137,8 +137,42 @@ void *swap_cache_get_shadow(swp_entry_t entry)
> >         return NULL;
> >  }
> >
> > -void __swap_cache_add_folio(struct swap_cluster_info *ci,
> > -                           struct folio *folio, swp_entry_t entry)
> > +/**
> > + * __swap_cache_add_check - Check if a range is suitable for adding a =
folio.
> > + * @ci: The locked swap cluster.
> > + * @ci_off: Range start offset.
> > + * @nr: Number of slots to check.
> > + * @shadow: Returns the shadow value if one exists in the range.
> > + *
> > + * Check if all slots covered by given range have a swap count >=3D 1.
> > + * Retrieves the shadow if there is one.
> > + *
> > + * Context: Caller must lock the cluster.
> > + */
> > +static int __swap_cache_add_check(struct swap_cluster_info *ci,
> > +                                 unsigned int ci_off, unsigned int nr,
> > +                                 void **shadow)
> > +{
> > +       unsigned int ci_end =3D ci_off + nr;
> > +       unsigned long old_tb;
> > +
>
> Nitpick: Can add lockdep_assert_held(&ci->lock);
>
> Can check ci_end < SWAPFILE_CLUSTER and bail out on error.

Ack.

>
> > +       if (unlikely(!ci->table))
> > +               return -ENOENT;
> > +       do {
> > +               old_tb =3D __swap_table_get(ci, ci_off);
> > +               if (unlikely(swp_tb_is_folio(old_tb)))
> > +                       return -EEXIST;
> > +               if (unlikely(!__swp_tb_get_count(old_tb)))
> > +                       return -ENOENT;
> > +               if (swp_tb_is_shadow(old_tb))
> > +                       *shadow =3D swp_tb_to_shadow(old_tb);
>
> Nitpick: You can create a local variable for the shadow and assign it
> at the end. Because it is a pointer, the compiler can't optimize the
> store away.

This part will be reworked very soon but using a local variable here
is good for an intermediate commit.

> Chris


Thanks.

