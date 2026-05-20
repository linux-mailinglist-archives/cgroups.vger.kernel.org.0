Return-Path: <cgroups+bounces-16117-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0J11Et9hDWquwgUAu9opvQ
	(envelope-from <cgroups+bounces-16117-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 20 May 2026 09:25:19 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D1A588E73
	for <lists+cgroups@lfdr.de>; Wed, 20 May 2026 09:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC5D9300B12F
	for <lists+cgroups@lfdr.de>; Wed, 20 May 2026 07:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2D93630A3;
	Wed, 20 May 2026 07:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QKk1RhAe";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oa1rqCQF"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31BD2853E9
	for <cgroups@vger.kernel.org>; Wed, 20 May 2026 07:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779261741; cv=pass; b=tHA0pZTUkx0ju9ZeUmn3p92zIRq5ZKpF0PoeiaBZfcyNnuOEa5JfEp9/bd0Yp0pmqz3SxYci2U6g70nl/QeIVpLgXZpsQmBc5TRyP4GJ2F709xkCwqUVmJU5ZZxYhUexhJaHVhUIE8pq43LK7daT/Z5yb3MUDyC67R+aigKC5ag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779261741; c=relaxed/simple;
	bh=wupLUxHCLNIn82ENANfRaN7CKoGhY1WDOE+kOFYZXFk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hoeijJpuiDoJnW36p8VDPFAtTcaxGtSaW/N3dCbLy2pHQPC6KK/Pi0yZU7Rg4O9Cp8kPrnkDETSdaGWqkAkbctMtzLlvYHy+0XX+9C1WpKUepgjfz5Dr18Yy4VXZmFe7dydiTOMMpmyxn7/p6zXM3LEVkQaOLhi3opHHEiWFg5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QKk1RhAe; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Oa1rqCQF; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779261738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xx2spnpzWhoLag/qhNvFLWpyojrRWUzv888prY2ah/g=;
	b=QKk1RhAe86KEFCxpq6xUi5+LBqc3KLsDs4p7AAZhpsIECCSfverUE3SwhECabDgwbJidbW
	SD1sXUFUJCWclwbUm8f9kktlfY/873BFv89nCGM7OrI5t0L+WSIVo1xsX8uO4+qwSRUrqm
	n7FHmDtM6BzMRi9mw3/vkKSVYHhLTnA=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-thcU38AbNGqm7ucCyLVruQ-1; Wed, 20 May 2026 03:22:17 -0400
X-MC-Unique: thcU38AbNGqm7ucCyLVruQ-1
X-Mimecast-MFC-AGG-ID: thcU38AbNGqm7ucCyLVruQ_1779261737
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-7bd6fc10a42so85567747b3.2
        for <cgroups@vger.kernel.org>; Wed, 20 May 2026 00:22:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779261737; cv=none;
        d=google.com; s=arc-20240605;
        b=NdVONi4R5mv0mHhlDJn/FAYNaD3VftDgtG4TTOvv6Vcl8HdEiFPlEwDPcyanox2dnT
         GUh3Ii9+l0vuJNKIbaEvDLQPtI8Au+Rzxkb6tBjswxXyw5wE6VPkqm+x1ynlKq0Gbroc
         UAJRLGBjrd+Nupc9RunNvO8UIimw7Rc4XzTTjbP0Ej9YIlAQCPeTYWjFUMtF4ZfhmuyE
         n0r1/KbSE87QHIv5ypzIvJdStmYhqVHxNWYyAwe5wMBxmZbl/fBc0fIeQsNqviLEnz/h
         U6s6Mc72ldYmPPAtB4liIbECE40H4BXjyu3G+K1QfL3mO1rLA6uj7oa4g1kyjr9f6f4y
         78ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Xx2spnpzWhoLag/qhNvFLWpyojrRWUzv888prY2ah/g=;
        fh=yVRYGtYiPBoYhjlXW603U7jhEAch8hz4Iv6o0Bgz/MM=;
        b=GKEsy0VOASRmYEEpkB0FC8JSn00VchdtK5ddGtq8l45s06gYgdOlvTpn1EQDJ6M7jz
         f2tsHCpGlKnw1yjOOlGkBIViz8SjC3QtpOytzjNMiFKJ/jbLknQI0EHszsDYmROaxbcn
         /AhO8Uz8DwLp+Rk0pi8CHgFMIeoEW42MHkWx622NU1xZkBLQexODLMec6ptv382YiGdF
         OFwye3q95yhlbNdF1nI3yArtdySExdAKAfqrXjok7TluEZlEzjBrHTBXAeFQaFoqlbhP
         9RbtFf0qGj0kWfV216Cp8MFDIA5KkIUhJPBtr8XQLDw++r2+rV7LYFnyJEdYNkpCT44D
         o2Cw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779261737; x=1779866537; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xx2spnpzWhoLag/qhNvFLWpyojrRWUzv888prY2ah/g=;
        b=Oa1rqCQFPpAVZy+6jKuXMrN0EhcTbdd4X3A1SSvMMYf1L4IFO8RuLA9WFmxTGXdBsk
         xpVKlJvzsIYrwxFC5KJyLICyxBSCMgpltTU7ICbRKhahbxQB5bWCnByFWYfbsD29wlUK
         do2GE/AsWhvX+3vs5VHYbtQbLWxjdw/lTA5dxkR4sR01wW5HX6HX38U6F3WaCySqL3fm
         JvCX4nD49qrOE9yAB8eTteCzKaAbqYG/RFPmKeZ13omA4NlaUe6Gc5EFUcn/yjHdMri5
         EKO+n5m/p7Dm1eY6YCzZ6O5IIiKEcv1NGG22VscjRNJ6TeDHXADB8w5pKbHfKUmu7WOy
         SVOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779261737; x=1779866537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Xx2spnpzWhoLag/qhNvFLWpyojrRWUzv888prY2ah/g=;
        b=ABS8nXzSdEmHuLy2Svbiy0DNZnGAaXSam51ZwqZbaZjXTaqSVk2wZF3fizAXkHgl1a
         GEqUvX0QmyutJnRWVCs8SLKKllzVfK/j8T+Ss5HA86nNAOM1SbkTMKjwJnwMpj/8WYs+
         I6E4eSImLYJkA/0LalgLo8Y5QJrebIqslJfC0MYyIHxY410w9taocakg2YQ/NE6Fkxr8
         YM9pItvBykWo5ItlHmIwjJstYTr0jQ4rgr9x2FpzBZOp2VHBQhgWjyd9BTFb8ZnCywlf
         925eX/ESMLzkryLJJ1DViC2Y6x9NXv84sS7bmhyGKIvEDIDAsjg0n6VSWb2vBpm5Dhr8
         Knog==
X-Forwarded-Encrypted: i=1; AFNElJ9pztrkpEDvxx4+vkWZsjj4H6t4ZWZT55leSCrn7BwchHxkbpvsg17iffA9whCmnoD+398d8vcY@vger.kernel.org
X-Gm-Message-State: AOJu0Yznf9ZtS0b7db5o29WpVFIzQ+Icze39ACexiWHAATSCLtPdumCL
	xDg4aRZ4mSUsyuzssSlgbYcvI3nL7bShFM7jGueKrMPg3Pl3wXzEFS+oYLx6G4L5iwvvuPqhvMX
	OS5Gr1XhKKqKvI4FOOwlJ80yuuQG1GYkuPGRMH902JAoww4MyqVwcJFBDVlXJkBFLXWNiGUz2qV
	t1oOyIXpcBUG5XLmmU1KDjIM5W3GLN7vonSw==
X-Gm-Gg: Acq92OG773uLtZ1Sp5Gi7sQVzBVm+XTo8svWOujM68tz0HFOSuuGEz5EwHyzlX0Ta3Z
	lIemV3mHikeMq9rWBEdHU/X6It4xSxbNv+5BEqfQ2vepT0yz07DYKuNO+t0vI6mZsYmRSPJqgrm
	knINGmwjl1DK8iQug6i8yeumgB5riCW9xgX8Jz6qi5WB9JpfXpW4A81hGPx4Ae+c6XINhREjWGA
	VFc4w==
X-Received: by 2002:a05:690c:84:b0:7b5:88ec:91b0 with SMTP id 00721157ae682-7c95d1d9e08mr253826567b3.48.1779261736917;
        Wed, 20 May 2026 00:22:16 -0700 (PDT)
X-Received: by 2002:a05:690c:84:b0:7b5:88ec:91b0 with SMTP id
 00721157ae682-7c95d1d9e08mr253826267b3.48.1779261736472; Wed, 20 May 2026
 00:22:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519-cgroup-dmem-memcg-double-charge-v2-0-db4d1407062b@redhat.com>
 <20260519-cgroup-dmem-memcg-double-charge-v2-1-db4d1407062b@redhat.com>
In-Reply-To: <20260519-cgroup-dmem-memcg-double-charge-v2-1-db4d1407062b@redhat.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Wed, 20 May 2026 09:22:02 +0200
X-Gm-Features: AVHnY4KBhaLJ6-NKlQm0NilZQ57LVIjKu_pC_jcyJuZg3rPObvW4KXxjSx93n3c
Message-ID: <CADSE00L4R6PGtP6yGTZ6Ym=tvOZEYHRbuEtEu0BKX294HN6qXQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mm/memcontrol: add dmem charge/uncharge functions
To: Eric Chanudet <echanude@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Maarten Lankhorst <dev@lankhorst.se>, Maxime Ripard <mripard@kernel.org>, 
	Natalie Vock <natalie.vock@gmx.de>, Tejun Heo <tj@kernel.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, "T.J. Mercier" <tjmercier@google.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Maxime Ripard <mripard@redhat.com>, Dave Airlie <airlied@gmail.com>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16117-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[cmpxchg.org,kernel.org,linux.dev,linux-foundation.org,lankhorst.se,gmx.de,suse.com,lwn.net,linuxfoundation.org,vger.kernel.org,kvack.org,lists.freedesktop.org,google.com,amd.com,redhat.com,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aesteve@redhat.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A2D1A588E73
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 6:01=E2=80=AFPM Eric Chanudet <echanude@redhat.com>=
 wrote:
>
> Add mem_cgroup_dmem_charge() and mem_cgroup_dmem_uncharge() to allow
> dmem pool allocations to optionally be double-charged against the memory
> controller. Take the struct cgroup from the dmem pool's css as there is
> no convenient object exported to represent these allocations. These will
> resolve the effective memory css from that cgroup and perform the
> charge.
>
> Introduce a MEMCG_DMEM stat counter to memory.stat to make the cgroup's
> dmem charge visible.
>
> Signed-off-by: Eric Chanudet <echanude@redhat.com>

Reviewed-by: Albert Esteve <aesteve@redhat.com>

> ---
>  include/linux/memcontrol.h | 16 ++++++++++++
>  mm/memcontrol.c            | 65 ++++++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 81 insertions(+)
>
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index dc3fa687759b45748b2acee6d7f43da325eb50c1..8e1d49b87fb64e6114f3eb920=
293e14920290fe7 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -39,6 +39,7 @@ enum memcg_stat_item {
>         MEMCG_ZSWAP_B,
>         MEMCG_ZSWAPPED,
>         MEMCG_ZSWAP_INCOMP,
> +       MEMCG_DMEM,
>         MEMCG_NR_STAT,
>  };
>
> @@ -1872,6 +1873,21 @@ static inline bool mem_cgroup_zswap_writeback_enab=
led(struct mem_cgroup *memcg)
>  }
>  #endif
>
> +#if defined(CONFIG_MEMCG) && defined(CONFIG_CGROUP_DMEM)
> +bool mem_cgroup_dmem_charge(struct cgroup *cgrp, unsigned int nr_pages,
> +                           gfp_t gfp_mask);
> +void mem_cgroup_dmem_uncharge(struct cgroup *cgrp, unsigned int nr_pages=
);
> +#else
> +static inline bool mem_cgroup_dmem_charge(struct cgroup *cgrp,
> +                                         unsigned int nr_pages, gfp_t gf=
p_mask)
> +{
> +       return true;
> +}
> +static inline void mem_cgroup_dmem_uncharge(struct cgroup *cgrp,
> +                                           unsigned int nr_pages)
> +{
> +}
> +#endif
>
>  /* Cgroup v1-related declarations */
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index c03d4787d466803db49cdaa90e6d6ba426b7afe2..91a7ac16b6eac2d6c3700b688=
5a068bf8b640706 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -433,6 +433,7 @@ static const unsigned int memcg_stat_items[] =3D {
>         MEMCG_ZSWAP_B,
>         MEMCG_ZSWAPPED,
>         MEMCG_ZSWAP_INCOMP,
> +       MEMCG_DMEM,
>  };
>
>  #define NR_MEMCG_NODE_STAT_ITEMS ARRAY_SIZE(memcg_node_stat_items)
> @@ -1606,6 +1607,9 @@ static const struct memory_stat memory_stats[] =3D =
{
>  #ifdef CONFIG_NUMA_BALANCING
>         { "pgpromote_success",          PGPROMOTE_SUCCESS       },
>  #endif
> +#ifdef CONFIG_CGROUP_DMEM
> +       { "dmem",                       MEMCG_DMEM              },
> +#endif
>  };
>
>  /* The actual unit of the state item, not the same as the output unit */
> @@ -5909,6 +5913,67 @@ static struct cftype zswap_files[] =3D {
>  };
>  #endif /* CONFIG_ZSWAP */
>
> +#ifdef CONFIG_CGROUP_DMEM
> +/**
> + * mem_cgroup_dmem_charge - charge memcg for a dmem pool allocation
> + * @cgrp: cgroup of the dmem pool
> + * @nr_pages: number of pages to charge
> + * @gfp_mask: reclaim mode
> + *
> + * Charges @nr_pages to @memcg. Returns %true if the charge fit within
> + * @memcg's configured limit, %false if it doesn't.
> + */
> +bool mem_cgroup_dmem_charge(struct cgroup *cgrp, unsigned int nr_pages,
> +                           gfp_t gfp_mask)
> +{
> +       struct cgroup_subsys_state *mem_css;
> +       struct mem_cgroup *memcg;
> +
> +       /* CGROUP_DMEM and MEMCG guarantees this cannot be NULL. */
> +       mem_css =3D cgroup_get_e_css(cgrp, &memory_cgrp_subsys);
> +
> +       /* Use the memcg, if any, of the dmem cgroup. */
> +       memcg =3D mem_cgroup_from_css(mem_css);
> +       if (!memcg || mem_cgroup_is_root(memcg)) {
> +               css_put(mem_css);
> +               return false;
> +       }
> +
> +       if (try_charge_memcg(memcg, gfp_mask, nr_pages)) {
> +               css_put(mem_css);
> +               return false;
> +       }
> +
> +       mod_memcg_state(memcg, MEMCG_DMEM, nr_pages);
> +       css_put(mem_css);
> +       return true;
> +}
> +
> +/**
> + * mem_cgroup_dmem_uncharge - uncharge memcg from a dmem pool allocation
> + * @cgrp: cgroup of the dmem pool
> + * @nr_pages: number of pages to uncharge
> + */
> +void mem_cgroup_dmem_uncharge(struct cgroup *cgrp, unsigned int nr_pages=
)
> +{
> +       struct cgroup_subsys_state *mem_css;
> +       struct mem_cgroup *memcg;
> +
> +       /* CGROUP_DMEM and MEMCG guarantees this cannot be NULL. */
> +       mem_css =3D cgroup_get_e_css(cgrp, &memory_cgrp_subsys);
> +
> +       memcg =3D mem_cgroup_from_css(mem_css);
> +       if (!memcg || mem_cgroup_is_root(memcg)) {
> +               css_put(mem_css);
> +               return;
> +       }
> +
> +       mod_memcg_state(memcg, MEMCG_DMEM, -nr_pages);
> +       refill_stock(memcg, nr_pages);
> +       css_put(mem_css);
> +}
> +#endif /* CONFIG_CGROUP_DMEM */
> +
>  static int __init mem_cgroup_swap_init(void)
>  {
>         if (mem_cgroup_disabled())
>
> --
> 2.52.0
>


