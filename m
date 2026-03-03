Return-Path: <cgroups+bounces-14540-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iGjPKzU6pmnQMgAAu9opvQ
	(envelope-from <cgroups+bounces-14540-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 03 Mar 2026 02:32:37 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E709E1E7B44
	for <lists+cgroups@lfdr.de>; Tue, 03 Mar 2026 02:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2918430333BD
	for <lists+cgroups@lfdr.de>; Tue,  3 Mar 2026 01:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8C3373C05;
	Tue,  3 Mar 2026 01:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FvewXO6f"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927A9373C07
	for <cgroups@vger.kernel.org>; Tue,  3 Mar 2026 01:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772501552; cv=pass; b=LzOzGRpTkQ1FVVi60OuIxJh4cOvUnTTFVuET9Ghu1waW7GOIoN/SjatMTIb3JWBPXi1cZH7U1OeOG6Oyh2w9wVyFgKXLE7wBsBcMTnzg2zdXnBmfXHaFmcZaqYKMcXXc7ECxsZa92oksfU9Qli+eUYYNpX3KTzsPZbEKZuxjCcg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772501552; c=relaxed/simple;
	bh=9O5huNGn81F9m9IIaMfd7WFOguaWPDBt6/QvmqUgV4U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YcjTPY0Bxg8c34o3kKVYrUVPhmavgHYRxpyAzly+FlxDaXX80C7sARTh5y15y5Z6qhPODXz5K8I0vRoT9AgBw64NpikthbLjcJk6piw5kJmtw48ec/xK57lhlw7H19Mis3+RAk2R9SJeo1zn1AnhFVUXslJeEQCcJwPTXt88cfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FvewXO6f; arc=pass smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-3870dec27f4so23183181fa.1
        for <cgroups@vger.kernel.org>; Mon, 02 Mar 2026 17:32:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772501549; cv=none;
        d=google.com; s=arc-20240605;
        b=c6ejgtSdLrW/+ln7ISqxCEx//CZ2oqwCBy8KcJVExPktQ6zTrGCxmo53nWnnadlwkX
         C0c2u42Yg7ZDGOJbG2XzwdMZZ1fVdgmqSF2Oc+HxLjxpwfY8XMNgA5/ai6Hg4qpFZiXR
         m4LE3OPH8jeY7ZG+Yp5MrI1dPlvF1o8Ydiis5+7zG16MhJH0dlz7hiFncfcfT9MqTf9x
         WX89uCfJiSzEDpZTQ1rcHFkRvmppchlLeZYFot+M/WqL1zCXD+qKRsaFGdBzWTf8pVbC
         UhI4eH6vojmaS7UF44M06k0dL8w9eLaP66fza7L7L/VjXXMhSodESUQW+1i3Quk1THUv
         DEQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eoakOWJKYn107a0kMsccm0Mx3Of/ckC1/GrgnYDxGKs=;
        fh=JmmJM07+y722ziI0h69JDrmB+6BMa7/OGL7voSFb8Uo=;
        b=WzB2przRksLOb8u8aBVEre/rumzI7t/wr1fzudiAkR2iwwLK7FIK4AFJn9d1d/ASxp
         V+kWG24rQRVxW+qyRgIdAG/AUfb2+oD9vVNOHthRQSNf5mgsD2OSHJ/8xYBwMTqgKxYa
         IGbMlFB5Efaty4Mav+vR/5EvIN5zbdm0RtcnqAU6X6io2eJaV3g/+EtRx1ck+Z4jADPV
         WrRuSqjl4O7JPga4Yw45UpDC9fzd/Ecdi/966LZTbW8nvkkmt0gx21ztQNQvipV3zHLg
         pyfXikmJYsLf0XxxB5gsbMJ5CqYnx7b5aMEVFwvOUc82VvpTuQwkrnbRj7o12IYvrNqa
         LvdQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772501549; x=1773106349; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eoakOWJKYn107a0kMsccm0Mx3Of/ckC1/GrgnYDxGKs=;
        b=FvewXO6fR2LZ03pG8HmF1d4JgT2gffUi/kGL6/2daIp2CXte3rXyhBAQkvzH2yLZ4i
         sqsn0Zs7WHT6dbjgmYo1GuQT5uj3KkXb10bv+7817RtcWToQerk6viG/wxkMvz/BZcxe
         FcJaJTVB+1LHMTvFe2pzq0kXmQBRFHrheAWvc1iZcgBZyPbAQp2d23B5en2Pt/hgmHxG
         ACDskigrftqw7v9lHPDvq2iyGwLC8Uw5t84Y9bNoyfwP3ICVS/NBDjmXLafAk4//S5Un
         AOBqu1PQ+tqkGWUHb+y6zrb/skM6p+9/4v5bYRWG8pndiguDS+2cNXrgQOb853hLRZ7q
         6pZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772501549; x=1773106349;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eoakOWJKYn107a0kMsccm0Mx3Of/ckC1/GrgnYDxGKs=;
        b=Vr3CGh8Gf1uRMX2MlK0q3PM5vkHFZJksgXRJIjOUa0cwtjAoLVG3qKldawDFPw99hR
         OWJxVSinCIqcUwhedxD50/GRTYacJGw/n1roTYkVybOsbML0w8eY5ceyPp3MndfThFfV
         pBdsOXP5kQP3FQAk9I+iQIKLE+3B62i01g/pmmb1blp49axRY4xqvmj8eckAzgUg9ryg
         6o9WG01b2/RKexwyBTCSoGFucfx+OLc4iLVg6rUmHoipZYV0xk/5rpaaqO0OvYm15D1a
         JsODbZSOXFJyvGAjWFkZiHh3umxOKz8dmCwBiOZjVuSeb1wm+MGJ9IpWhg4TsrFoRVkr
         sVOA==
X-Forwarded-Encrypted: i=1; AJvYcCWieoYQQGWrgkMltfqBkSq2q2vplPstePWDjPugoO8RQU2EIt8nGCRfTZWOFlRmune8vxmL0pqU@vger.kernel.org
X-Gm-Message-State: AOJu0YyVHp6XbL1+C6BS5XeeOfnKWsHvdKRI6bCSLuPl8ltem+EaN9UQ
	Yo/BbxW6IgN6L0o7sfb/SMOot77RiBxcFq5Nnb1pJBrdjpKrfy8fdVygQN/tZwZ+Aq8KeI8HsWv
	nffsfXDdn2F9Jv86gGGbqKgz4g0iPg+0=
X-Gm-Gg: ATEYQzwFexPLnb8q4hcdk0DOlXQPD1AhEbwEaDh4wGHrBuDUrZ8mJpkM57ox4uRuD9u
	GOmYUhJqRZt6msyYBA8cYpPvqgkUyKdUF3uiD2ENreLjUPqfZmrKEQkznp82EcAdTjFiLWfwjoW
	hWq7HtQW7Q5TIYVnYpFSf6Q7O9qu7Mfr5aefRUkH33Zbien8/JSuZeLka0is99i+BgpStdNOune
	ccwXj9OslM/431DS8pQOc8XevUXqcOT3rfEPqwYr+XW2KpKecSp7ael5Tn40xid/sVxFVi6ThII
	pxb2
X-Received: by 2002:a2e:3a07:0:b0:385:beb9:dbfa with SMTP id
 38308e7fff4ca-38a1c432c1fmr1425651fa.22.1772501548568; Mon, 02 Mar 2026
 17:32:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122114242.72139-1-wujianyue000@gmail.com>
 <20260123150108.43443-1-wujianyue000@gmail.com> <20260123150108.43443-2-wujianyue000@gmail.com>
 <aaXoT17JoTv87l40@cmpxchg.org>
In-Reply-To: <aaXoT17JoTv87l40@cmpxchg.org>
From: Jianyue Wu <wujianyue000@gmail.com>
Date: Tue, 3 Mar 2026 09:32:16 +0800
X-Gm-Features: AaiRm51MvrbkG34tXAHZrRyVDvmG56_WfTWIft9w2fl79C3OS-RjjlQslYq1xHY
Message-ID: <CAJxJ_jgQLjW_C0h9Lf1BHWbn50miXvJ+rCKurooNzHBDA18ojw@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] mm: optimize stat output for 11% sys time reduce
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: akpm@linux-foundation.org, shakeel.butt@linux.dev, mhocko@kernel.org, 
	roman.gushchin@linux.dev, muchun.song@linux.dev, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, inwardvessel@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: E709E1E7B44
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14540-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[linux-foundation.org,linux.dev,kernel.org,kvack.org,vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wujianyue000@gmail.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,cmpxchg.org:email]
X-Rspamd-Action: no action

On Tue, Mar 3, 2026 at 3:43=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org>=
 wrote:
>
> On Fri, Jan 23, 2026 at 11:01:08PM +0800, Jianyue Wu wrote:
> > +void memcg_seq_buf_print_stat(struct seq_buf *s, const char *prefix,
> > +                           const char *name, char sep, u64 val)
> > +{
> > +     char num_buf[MEMCG_DEC_U64_MAX_LEN + 2];  /* +2 for separator and=
 newline */
> > +     int num_len;
> > +
> > +     /* Embed separator at the beginning */
> > +     num_buf[0] =3D sep;
> > +
> > +     /* Convert number starting at offset 1 */
> > +     num_len =3D num_to_str(num_buf + 1, sizeof(num_buf) - 2, val, 0);
> > +     if (num_len <=3D 0)
> > +             return;
> > +
> > +     /* Embed newline at the end */
> > +     num_buf[num_len + 1] =3D '\n';
> > +
> > +     if (prefix && *prefix && seq_buf_puts(s, prefix))
> > +             return;
> > +     if (seq_buf_puts(s, name))
> > +             return;
> > +     /* Output separator, value, and newline in one call */
> > +     seq_buf_putmem(s, num_buf, num_len + 2);
>
> You seem to be losing the \0 somewhere. I'm getting garbage at the end
> of memory.stat on mm-new:
>
>   [...]
>   thp_swpout_fallback 1212
>   hp_swpout_fallback 1212
>   hp_swpout_fallback 1054
>   907
>   1278
>
> Dropping this patch fixes the issue.

Sorry about that. I wasn't able to reproduce the issue on my side.
On a closer look, the change seems overly complicated and may not be
worth the risk.
Let's drop this patch for now.

