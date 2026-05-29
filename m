Return-Path: <cgroups+bounces-16454-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8L73CJ3cGWo4zggAu9opvQ
	(envelope-from <cgroups+bounces-16454-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 20:36:13 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B75B36074BF
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 20:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 80F923024A28
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 18:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8112A4218BA;
	Fri, 29 May 2026 18:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mBwPieSu"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0A3421F12
	for <cgroups@vger.kernel.org>; Fri, 29 May 2026 18:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780079756; cv=pass; b=kAiHZTJ/IvtugfyjRjHp9NgVlehnwSyunpUMtpFGnqzUfGRd21gwr9LSoHMaTy5bIzNzb5Qf/yE/tZrZyf2Cs5If+3LnMdr+3fJD/wXPe2zzMjCY4JhX+Pp6AZiDt62A5vv+L0dC3g7sWNfpUNgi0j5TlJdKskYu5ZlfiuPqx4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780079756; c=relaxed/simple;
	bh=vK/2H/jVXEqCp1jMN414Ej9lNs6wk5AuaI3B0pz0/qs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GrY9/PRjiyFzImFrc3dciXG2U/Ta8CBPqxfgsuCWDcNuHW3RcnGj+5YbrG/+RDWnbPV7QI1wQ0yIQNBIPQlHZpnhCB85yUE5Hqy+DhKXt0ZX5ppaxdB5oTHef8c6na7EC2pnx1XmF6yh4wSiNsUoCKDIGv4hD8MMAuB6wrRzrZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mBwPieSu; arc=pass smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-49050bfe053so47872475e9.3
        for <cgroups@vger.kernel.org>; Fri, 29 May 2026 11:35:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780079749; cv=none;
        d=google.com; s=arc-20240605;
        b=aHvXjPSlRgiYsEds0ALvEklIHTNuWKBffSL5he/b7y3L9Q9aHDL/9vkb4r+L6RS0lp
         sglQZKmnPxGaiFLQaUVjmO3wii1ak5YGIQN94+EA+tUE+nvC7rzqnlA3TFKUEVlRuqv8
         0bsCJP/yJfQDqHo9uzm3l3+VeIjwM4SD/n50gDhT4RT2kia0zyfzogw/w/K+lLH3agl7
         7rFa2QpZwDRg4/v3cZcxBUieYm8tep1HvKBpBcWuT6586uBBn74bKIt8AtSoqxR6xamP
         fcPPGfczpqWUmRV1h+rRSYldCHUV4FhNybtTtEhHeV5oTsr8IR24ds2fKyNTHaKUjEej
         +u5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MGl415x2fsqiOBBpTEJg/XXf8v3MH+BgP2tr0DmzY7M=;
        fh=qpcoEz+bFLn/CzKNUXoUoYVY04g378VWbXteeLFEM9A=;
        b=ltigp0al4WQm1rqM/lvEvd8rBRW9EwQx8I7XxKOci4iURyjtBnL1SphNhKLU4LyRGB
         STf4VOk8Ab0IJguPsCM4H/LfeCOWwXT1rZOBUKMP+i+1Ng8+9BMU+pU3yGWKNTnoc6lP
         hBLGS+Z/a9LmtHv1klbtYMTsryyIcxsbXH67gGgG5mHrL/RZ01O2BgYSuCif9QOlLMW9
         +nJ7NVEpS20d4bPKXCsJqjzFzb7cNxX3utRIEFg9sWGAn8JM5/RENYDb14QdCCWc2Oxd
         WCe/u7dktsByGC23YQWZ76uNSOjIVy/xnJBbo9WGu4Ppo0EkykxA33Mec9GisF1qaUyV
         uoyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780079749; x=1780684549; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MGl415x2fsqiOBBpTEJg/XXf8v3MH+BgP2tr0DmzY7M=;
        b=mBwPieSuuCxcja/f+bqNwaSLHOPMArpX74JM2+5oXDMYX7Dk/qYWVfB7Ko8UGmUvCK
         xX+/1nXKONg2gjl9Xr/c2xSGyT0EsC13Yo8hza5StiDvqUdJ/4hZtYGgdBOjKHrNUMPc
         VwIyDTCJvDKxyVorb+R/nYRweCCkMKxGoihhOzaxdNTK/tplZw0GDgTTgRMtOr/XQ2os
         6+ni7Q0fo0ZPpUxGsPjgT+CBuu9u/GbN0aUcK5cBZ0kECNkRX+Dwz2KJa2lM2PnYLDWz
         OvCthFpteoHUeHyCTjgLJ+3HLYHF2DwmFA6nT/nxqKxUBGMkUrEgXAxZ/XbFKPMxmRb0
         IQkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780079749; x=1780684549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MGl415x2fsqiOBBpTEJg/XXf8v3MH+BgP2tr0DmzY7M=;
        b=P2sX5FM3K9xUtXVkt/AVwsUF9S+uB0v67ipzznh2FsPOE5M6ZwhKYxalejxEDCeoEV
         y4IjKQWlKKaKxkp2lQmbozAZom97O9MpO2P2MO7EIVAUAyxKSdclZxsSvW182hOvyDg4
         mhr16IZW+7YqaC45SB5fEA6mIJc1zQko318+IGvFFekjZdR8d+PN/Tvc7s70Pdz5ZsWF
         j7yGPHQOF2Y/V0ZF7YgcGHpicsfv6s93s45cFCiq6PDNv6gGW9H2i59mOer9iaToVWVo
         hHkdy3DP7oW4+qh+6mFgx1uKM9ib68ERQx6HXEe6GYjThf4wR0uBTdfnzB2O/IVid1LN
         k6lw==
X-Forwarded-Encrypted: i=1; AFNElJ/iBgp3dv3RoITY2iRmQm5BtjkAvxLyJ9y2ZECS6K7iQ2DfdlDprMC3iwYl3JwfvJQsBDALtOSi@vger.kernel.org
X-Gm-Message-State: AOJu0YyTr0s3Mb5wL94il9Vhg9Subb5jywGpwjj8twKYfEIH/h2rlDPB
	8N8aqUKEjzwwR10rqCuSg2IJZB6Nq0hJZ5YMnVKpJdRYDPiuYywzSUKjE3gFObQI7nrDQPEISfA
	OBOiuOx9VNKSC+L+u+72/+Zqdcs+/v20=
X-Gm-Gg: Acq92OE19jGvPNPPzN41MBDB/iL6pA+04qxxZuZDCW9yi57Z6Luqek/XWAqmZ4MSFxu
	FMpcNunzA0eUFrWQ14TcSZwNIYyiVh75gSKR13e3YdSvVRtfbIYhHCyIfyIzAC/RQE1jLBobXaj
	vcj3T+TEc4EV3MwxNqJ9tOjvDzpqNymhz9jma9YK7oxAxD1SjiN71Ki/NAuegEUHtNAO/S+vFzN
	WBR8t9VG4gtglADkYCqEuBzmQGt4GQjwijpvXHk6usAwJTrFmCfDSOlRH3kP933p0HC7Sk2BOVy
	Fs8tKO9NYvqweK4NU8mLIomZWkGaOiKU5hJ9RT3Gm6qv2RiuJA==
X-Received: by 2002:a05:600c:4714:b0:490:53b0:9e53 with SMTP id
 5b1f17b1804b1-490a290bdfcmr14252835e9.1.1780079748969; Fri, 29 May 2026
 11:35:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_98CD9F78E48D08DC005A6471A13CFF28B60A@qq.com> <tencent_C78A02F3C41E15233C371816825C7DCF8708@qq.com>
In-Reply-To: <tencent_C78A02F3C41E15233C371816825C7DCF8708@qq.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Fri, 29 May 2026 11:35:37 -0700
X-Gm-Features: AVHnY4LFWwMiv9dobFO7ohhoACD8Hf7dh6YZvBHF6MmRjK_iIIRP5J0Z3jFSKQU
Message-ID: <CAKEwX=NUQb5b4T49dbRV0_41QYRRuLkQNUg+FVDpJiobCCCh7g@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/9] mm/zswap: expose range state for swapin policy
To: fujunjie <fujunjie1@qq.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	Alexandre Ghiti <alexghiti@meta.com>, Kairui Song <kasong@tencent.com>, 
	Usama Arif <usamaarif642@gmail.com>, Chris Li <chrisl@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosry@kernel.org>, 
	David Hildenbrand <david@kernel.org>, Hugh Dickins <hughd@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16454-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[qq.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[linux-foundation.org,kvack.org,meta.com,tencent.com,gmail.com,kernel.org,cmpxchg.org,google.com,linux.dev,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,qq.com:email]
X-Rspamd-Queue-Id: B75B36074BF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 29, 2026 at 5:19=E2=80=AFAM fujunjie <fujunjie1@qq.com> wrote:
>
> Large folio swapin needs to know whether a candidate swap range is fully
> backed by zswap before it can choose an order. That decision should stay
> in common swapin code, not inside zswap.
>
> Export two zswap facts for that caller: a lockless range occupancy snapsh=
ot
> and the current zswap reclaim-pressure state. The range state is
> advisory only. Writeback or invalidation can change the backend after the
> snapshot, so users must recheck before issuing large-folio IO.
>
> Signed-off-by: fujunjie <fujunjie1@qq.com>
> ---
>  include/linux/zswap.h | 26 +++++++++++++++++++++++++
>  mm/zswap.c            | 44 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 70 insertions(+)
>
> diff --git a/include/linux/zswap.h b/include/linux/zswap.h
> index 30c193a1207e..8f9aee97517c 100644
> --- a/include/linux/zswap.h
> +++ b/include/linux/zswap.h
> @@ -9,6 +9,18 @@ struct lruvec;
>
>  extern atomic_long_t zswap_stored_pages;
>
> +/*
> + * Advisory zswap occupancy snapshot for a swap range. This is not a com=
plete
> + * backend classifier; callers must recheck before depending on ALL_ZSWA=
P for
> + * large-folio IO.
> + */
> +enum zswap_range_state {
> +       ZSWAP_RANGE_NEVER_ENABLED,
> +       ZSWAP_RANGE_NO_ZSWAP,
> +       ZSWAP_RANGE_ALL_ZSWAP,
> +       ZSWAP_RANGE_MIXED,
> +};
> +
>  #ifdef CONFIG_ZSWAP
>
>  struct zswap_lruvec_state {
> @@ -27,6 +39,9 @@ struct zswap_lruvec_state {
>  unsigned long zswap_total_pages(void);
>  bool zswap_store(struct folio *folio);
>  int zswap_load(struct folio *folio);
> +enum zswap_range_state zswap_probe_range(swp_entry_t swp,
> +                                        unsigned int nr_pages);
> +bool zswap_pool_reclaim_pressure(void);
>  void zswap_invalidate(swp_entry_t swp);
>  int zswap_swapon(int type, unsigned long nr_pages);
>  void zswap_swapoff(int type);
> @@ -49,6 +64,17 @@ static inline int zswap_load(struct folio *folio)
>         return -ENOENT;
>  }
>
> +static inline enum zswap_range_state zswap_probe_range(swp_entry_t swp,
> +                                                      unsigned int nr_pa=
ges)
> +{
> +       return ZSWAP_RANGE_NEVER_ENABLED;
> +}
> +
> +static inline bool zswap_pool_reclaim_pressure(void)
> +{
> +       return false;
> +}
> +
>  static inline void zswap_invalidate(swp_entry_t swp) {}
>  static inline int zswap_swapon(int type, unsigned long nr_pages)
>  {
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 761cd699e0a3..da5297f7bd69 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -506,6 +506,19 @@ unsigned long zswap_total_pages(void)
>         return total;
>  }
>
> +/*
> + * Expose whether zswap reclaim pressure is active. This is a backend fa=
ct:
> + * zswap_check_limits() sets the state once the pool reaches the hard li=
mit and
> + * keeps it set until the pool falls below the accept threshold.
> + */
> +bool zswap_pool_reclaim_pressure(void)
> +{
> +       if (zswap_never_enabled())
> +               return false;
> +
> +       return READ_ONCE(zswap_pool_reached_full);
> +}
> +
>  static bool zswap_check_limits(void)
>  {
>         unsigned long cur_pages =3D zswap_total_pages();
> @@ -1559,6 +1572,37 @@ bool zswap_store(struct folio *folio)
>         return ret;
>  }
>
> +enum zswap_range_state zswap_probe_range(swp_entry_t swp,
> +                                        unsigned int nr_pages)
> +{
> +       unsigned int type =3D swp_type(swp);
> +       pgoff_t offset =3D swp_offset(swp);
> +       bool present =3D false, missing =3D false;
> +       unsigned int i;
> +
> +       /*
> +        * This is an advisory, lockless snapshot for common swapin admis=
sion.
> +        * Callers must recheck before depending on an all-zswap range fo=
r IO:
> +        * concurrent writeback or invalidation can change the backend st=
ate.
> +        */
> +       if (zswap_never_enabled())
> +               return ZSWAP_RANGE_NEVER_ENABLED;
> +
> +       for (i =3D 0; i < nr_pages; i++) {
> +               struct xarray *tree =3D swap_zswap_tree(swp_entry(type, o=
ffset + i));
> +
> +               if (xa_load(tree, offset + i))
> +                       present =3D true;
> +               else
> +                       missing =3D true;
> +
> +               if (present && missing)
> +                       return ZSWAP_RANGE_MIXED;
> +       }

Can we use xas_load() to make this check more efficient? IIUC,
xa_load() walks the tree every time.

(We used to use a bitmap here back in frontswap days. Good times....)

