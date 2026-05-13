Return-Path: <cgroups+bounces-15903-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KFN1AHq6BGplNQIAu9opvQ
	(envelope-from <cgroups+bounces-15903-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 19:52:58 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 048335385D8
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 19:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 060D03002933
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 17:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77BF04DC55F;
	Wed, 13 May 2026 17:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y7kf4qd7"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B827D366DA5
	for <cgroups@vger.kernel.org>; Wed, 13 May 2026 17:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778694482; cv=pass; b=eb+FrUitxhktfBhmMIlNHomSNvWave2i5e7ni5ZCBgxrI/rbs9Bcum+TihYFFzY56HRLVnfsRs+Kko0P11WdDXeTdNDuw2xhtHcQy6G+Jg+F0V2cZiFqNR3A/wAAhlZcnSfnRORCkmHSFdOqzUC13JruN/LJDxHsbfWnREORm9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778694482; c=relaxed/simple;
	bh=Pysld0qz/u7+Om47AUToLAVgBgJB+b3uf6kXac9/v3w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NL6EEwfpWjImkAK2XXR5SSOUthWAUKFrzRByHJk/fd8fFkjqp5qLDKWrfv67NVjJHjX4/5VQdyaVoMfGjeWH060moaRdYH/ir8G8bL3RKyuEKzsxqWu2RsNu5uQpu3U4RO/b1zF/UYXmFiZGQo4Cw6BE7gon1ePc489beYPHF4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y7kf4qd7; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-676a89de629so640884a12.1
        for <cgroups@vger.kernel.org>; Wed, 13 May 2026 10:48:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778694479; cv=none;
        d=google.com; s=arc-20240605;
        b=If8yyubz8FraikHd6lEd3UiY94Gr5KdukKeg5JaOb2X24G5ofo+f+Djl7bKrvg1/eK
         G6pW6VcESkf0KgtQbmDlZ5Nljw4guIHn2laK9eTSN8mMLKM5riSkR3X6WPmLxb3tbFkA
         h4ixtXdNVmLuPXzxX/LYlL3pj6/zbZpxkwP8SLWczuZ265UppoJHNs1eGV97JIV8hBU1
         CeKLTprNBrRLGvEgQb8YOTz17N0YJJ1335sjw3y0AJLevoVEd38zwus520ibfqJzxVAc
         GSBHmnqMnp8gsQRjII7kBb/0gZq5l5waTtt2UD9RlTvMwP5g2Ip+j7Wgrhn+y8t5ofZ9
         Q2Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kFQ+R+QRNZc2dL4tMIvV6mJSpqASOAKS6Pd7xj8Z6hk=;
        fh=OeSwLDc1AufsHag62pKNCaJLGh3pWSBjHsHsjLMUgfI=;
        b=TrI6ejqATkN+Miwq2t5i+X9CH54sStBjtXdqbkzUVal+q4whhi6u/4b/ugB0tFomnS
         opKOkinwCy0kDxXyxGyJ8tPjhZ2UWyJ8did/QhxKWksdi7g/N3osZOSVUmJM/eHancY0
         X1YUgjKgPKIVa2V4IyS4fNZgEi4T6cNGt56NGZcROCBij1oRxhAEkcR8zxxIfozCmLF0
         BUbaC6nL/elpevQ2503EJ+O8dJC4zWXFF6Jkx2dGUwJ1J5cLJ5XfMI6lYYPHyVHgHz2u
         KyjlEVrxT59pHddmmR7FhJyVYXWdfv85x56gPdBDRwB/45ovGUwZPU0PUGAoxqOnD7Wb
         mN3g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778694479; x=1779299279; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kFQ+R+QRNZc2dL4tMIvV6mJSpqASOAKS6Pd7xj8Z6hk=;
        b=Y7kf4qd7zjJ6+ulQuCLPha1jVo6mcXq9RNW1dCVgd42+5DApzbIVhuYbGUb+DhA6bs
         NZDLfoxSBNcEsJaPFZkyhxcBgFZ/o0kb3P2dYvSd2ZQrG9nttkRBSKV26MPLC48Mk+H7
         ud+VqUAcj1J5EDKkzk4y0EiZ0ISiyxgMnd/fObNaC7xa6hUYzOf8KR8z0H/p+szjwDlD
         8sCeUyJ48QHvHUwP25nhbpkAvNwUTtIxsZtPhsywbE7yGVR8QcL05S1j69VClY5J/Dgi
         k3/R+TXCKYCFqRTV/k+LlgwjmJJCyxV6+pT3WaXrcVZxkfKyWFL8OnVwJIN2BWPynUHY
         dHBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778694479; x=1779299279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kFQ+R+QRNZc2dL4tMIvV6mJSpqASOAKS6Pd7xj8Z6hk=;
        b=tDDNp7DZN/mh7/9CHHdkonAmeBR4ra1HGDSbLxahKjZLrNK2Oxgmnw96mxh/+xiaZb
         MFmIK4zeCJlVotEW0wxBkCYa24CIwWXm2EFbptWyIhrH8GabsCiV/3rdeUCQuYh+ue5S
         J0EMHp4xlAQ1+BF5XqD5E16FPcyoQupY9aF13tbfSB1HB54is0Gn+oWFS0PQSo1jwMht
         2YJevOHbkH+uEXWff6a4+VMJHMypx53wzyiPYWNpPH+JXx5ZwkTsPZWrfQ21sOn52cVT
         swMSO9VMo98kIN0BSuz+yQ3yz7+NtJOXuqz/nkkZ+4NaX9cX4SZX1D7h2+eHJr66fHH2
         TkWw==
X-Forwarded-Encrypted: i=1; AFNElJ+rI8ak0u/d9X8TjBSND9l/qiLRRFsELybyMhI4TsvZvY+mQqFe/OJy6BcDg/rgdNZb/qWbFb8C@vger.kernel.org
X-Gm-Message-State: AOJu0YyebxvJY0lTXxJxB/dCrx9y6oZ+DNlknlOsxchILtOXHsFdXkQS
	49xsIJc0dKSzXtPUy136CEB9hpcpeSe62RNhcptE8uq2TFSbXfFso2FaWtDjA8h2HtTvNOICMA+
	XoSQAbXSVSEAAz+6C35Jx1QJOJ/k+b2g=
X-Gm-Gg: Acq92OHp+Dj0Yy2wvuono1HUuWgfmNaX2THQF+CdmKLeWQtI5UY+HlEXMuKZ0EIochn
	N8RfI3B+wDvUVetqI1P5/7J1vRJKxKksMeVKli6+sLa/Wo/v0HOt//zcJsJcv7cf25TGiRh07+w
	2clpTaACr/hgzQJugnsww+qkh3ih2MuhI057dDi4im4znZGylUpFb3c1RgotAb8uwHFGwVJ/ZBD
	ZscOdEXTJ4HXWULY8YPU5/rDee4f4+Y8clUn8ZJceTmJ4hfplPryxiXDrCfcLW14BE108GKCt6+
	1TrOKG1AKEbdtuaMz3JrPc+b6YoZBq6Q/+bJgH2e
X-Received: by 2002:a17:907:6d23:b0:bc4:f44f:e145 with SMTP id
 a640c23a62f3a-bd3dfb61d1emr269747266b.16.1778694478941; Wed, 13 May 2026
 10:47:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421-swap-table-p4-v3-0-2f23759a76bc@tencent.com>
 <20260421-swap-table-p4-v3-12-2f23759a76bc@tencent.com> <CACePvbUSqkw+5MFFfvwWe9RUs4xUuAzzEkBYOcQ4eB6e7kNonQ@mail.gmail.com>
In-Reply-To: <CACePvbUSqkw+5MFFfvwWe9RUs4xUuAzzEkBYOcQ4eB6e7kNonQ@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Thu, 14 May 2026 01:47:21 +0800
X-Gm-Features: AVHnY4Icxwv_YCrITnlE3l5KbQwkwqxk4IPI9AHQl56N8wd0xj8GUUVymRN36mo
Message-ID: <CAMgjq7CfrFGNAsqc-Zjv+iGni2GADw-TkBeudaAe-+XVFJxpcg@mail.gmail.com>
Subject: Re: [PATCH v3 12/12] mm, swap: merge zeromap into swap table
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
X-Rspamd-Queue-Id: 048335385D8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15903-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid,tencent.com:email]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 1:04=E2=80=AFAM Chris Li <chrisl@kernel.org> wrote:
>
> On Tue, Apr 21, 2026 at 8:16=E2=80=AFAM Kairui Song via B4 Relay
> <devnull+kasong.tencent.com@kernel.org> wrote:
> >
> > From: Kairui Song <kasong@tencent.com>
> >
> > By allocating one additional bit in the swap table entry's flags field
> > alongside the count, we can store the zeromap inline
> >
> > For certain 32-bit archs, there might not be enough bits in the swap
> > table to contain both PFN and flags. Therefore, conditionally let each
> > cluster have a zeromap field at build time, and use that instead of the
> > swap table for these archs. A few macros were moved to different header=
s
> > for build time struct definition.
>
> It might be worthwhile to mention the user-visible impact. For 64 bit
> systems. The zeromap will store in the swap table, avoiding zeromap
> allocation. It reduces the allocated memory. That is the happy path.
> For certain 32-bit architectures, if the swapfile cluster is not fully
> used, it will use less memory for zeromap. The empty cluster does not
> allocate a zeromap. We still save memory. In the worst case, all
> cluster are fully populated. We will use memory similar to the
> previous zeromap implementation.

Will add this to commit message.

> > +/*
> > + * Return the count of contiguous swap entries that share the same
> > + * zeromap status as the starting entry. If is_zerop is not NULL,
> > + * it will return the zeromap status of the starting entry.
> > + *
> > + * Context: Caller must ensure the cluster containing the entries
> > + * that will be checked won't be freed.
> > + */
> > +static int swap_zeromap_batch(swp_entry_t entry, int max_nr,
> > +                             bool *is_zerop)
> > +{
> > +       bool is_zero;
> > +       struct swap_cluster_info *ci =3D __swap_entry_to_cluster(entry)=
;
> > +       unsigned int ci_start =3D swp_cluster_offset(entry), ci_off, ci=
_end;
> > +
> > +       ci_off =3D ci_start;
> > +       ci_end =3D ci_off + max_nr;
>
> Should we check ci_end less than the cluster's end and complain if not?

Currently, we only call this function for folio->swap with
folio_nr_pages as the max_nr, so this scenario should never occur, but
a sanity check is always good to have. It might be even better to
convert this whole function to work on a folio basis later, since a
locked swap cache folio has much better restraint on its swap entries.
This can be done later as a clean up.

>
> It seems using a for loop can be simpler. The loop index serves as a
> counter as well.
> Totally untested code:
>
> int i;
> rcu_read_lock();
> is_zero =3D __swap_table_test_zero(ci, ci_start);
> for (i =3D1; i < max_nr ; i++)
>        if  (is_zero !=3D  __swap_table_test_zero(ci, ci_start + i))
>                  break;
> rcu_read_unlock();
> if (is_zerop)
>      *is_zerop =3D is_zero;
> return i;
>

Thanks! Looks good, it's more compact indeed.

