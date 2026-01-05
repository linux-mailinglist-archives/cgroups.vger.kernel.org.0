Return-Path: <cgroups+bounces-12920-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A8ACF30EC
	for <lists+cgroups@lfdr.de>; Mon, 05 Jan 2026 11:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 57B47300EA0A
	for <lists+cgroups@lfdr.de>; Mon,  5 Jan 2026 10:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3E2329C7F;
	Mon,  5 Jan 2026 10:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fkJ+oLdE"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78744329C6E
	for <cgroups@vger.kernel.org>; Mon,  5 Jan 2026 10:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767609712; cv=none; b=izl9Vl2S0VE9QLWUANf9j2RTRnjAFt0EKgBXWqGhCQd3nNrc3BctKI/YeOrU6v71UsbBs/DOPRG9itp1IU8LrD7EvdYk3vpZZHr2do5DkgMHLZgkcoNiTItk29gYAbBqLx5/6YQRPrBzVd/0X3kCFHXPer7VbtFL4gzmdJsEMlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767609712; c=relaxed/simple;
	bh=lBKaszxW7iInkpb50OvcIQyOuI0g/v2CfyebowKLROU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DZmAr/Yu3/fnKAzOPfqA4Eu4+9FDhaVODQ9Y61yAJylDrnrCQeQfGpqKpgM8vF4MhIk6i8GOBWZWA1vEIDjHLerwaUdK46Goqh/93t+dBSPhNET3WJmcl7gjpcbfHLIh7pZ5oLeJ01DltPB5KECU3So6cm/gTc/9x5TW0J7gYvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fkJ+oLdE; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-4775895d69cso59212755e9.0
        for <cgroups@vger.kernel.org>; Mon, 05 Jan 2026 02:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1767609709; x=1768214509; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cwRMgjJ1REBlPbGQlIl+XDgi97pxhpE8kH1QwnFxGm8=;
        b=fkJ+oLdEVCjcjuAPRlQmAczkBTSAaJKYtog0sHoU4qkbXE4qRAuTPIMaq77kT/cxDr
         NjeRJ7zDKxbCFvtMWjd2fFIa4NCi9MkzLK4zqUEgd/gDG6PZ4XpTXPFct6s+4OA6+qCN
         io15wSvOFvBRU1FilsWvVUvK3Nl8bZgZuqyrKYG1HGblwMpgAqp9EGg24uiOjwUWaMMg
         p6VWBTrq/ktFkys7IBCs1MYjzU/ixm/R75ab8roIQfBdR7/xNWzUZbSjGyzPqTmibfPr
         3FJKdzwxVPmEJ0Fb+7btEJSyyMrNK8t+ndsMAeDVe8L44ZKtGlx9Q/RKsC+T1EAIzyM5
         Ys8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767609709; x=1768214509;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cwRMgjJ1REBlPbGQlIl+XDgi97pxhpE8kH1QwnFxGm8=;
        b=IvpzCMI5SgFVzT5s9s29lU4/YMkhWbraOdApq4qwSiiKpwOFxXIceAz7BBEjpU9bZu
         WEB0jzEDHxYLAvydrNWAiVCAQsFS1es4fY3g4JhjvfVYieFhqd+zfJI8OGOvSNB/N7E0
         TtetZ+Nc6J9Kz3ZZT7wiSeNuqAgiMQ3t9kZ9relca79bp5sPProhCE62kS2piZxyQlqY
         F4CROVwjCHIpgmgJypWXYMBMut9KcUHOW/cakxpTRSnaFE1UZEoeZjxnVu0kQWXe31pq
         cLmJXvYLGafAFVfj/GaXTIjYXICq4boVT68iuUm33qVC8a0a9V5hh8Yqmzk3U4eMb99v
         fjSA==
X-Forwarded-Encrypted: i=1; AJvYcCWaKik3CiRb9OukOyZmzl6VHBMtQixRcyJZgw+pxjAW4TL2r6zWFR/ZZGOGQ/zSPpJvuTBBwBiT@vger.kernel.org
X-Gm-Message-State: AOJu0YzRolLifJAA51DhXXWo/07TkIVXUBBIiGMVTIv3/m95/Dlqb45/
	tvE9DVtuNjlfVtqsLUqS11p1XFNXjtL5gFjzEaJRh9Q1BJt95AcoCMffWCBi9G96H78=
X-Gm-Gg: AY/fxX7H/GBtJeqBdXe1WmxJdOyqCXgxIVWqM6gR9Qm6SF2c/RdoU8otaDWhZX0U29R
	ynJ7xOzgF0uHMmrUgFe6L2e+ulTambkIPI8/gmx1egAGXP3Gygxl6yvQc539sLCpiu3KrUcRMju
	fr69FJl9MO3V90zvqxtVt9YVvnNk3DIxyGfuVctTOqCcF1aAKenCZpn7ICBketc0uNbdtP8wsed
	DO5EtcYIqhpujC0i2HQJa6BhbseLEFA9yJVZZM+YEDhvRbAsFKRzCBEFYcnz2WN7AhPkdVw2r8B
	13Oy69V1/stKLwRboTgOhja94l6SH+Rqc0ybNum7qyqhc5+DqmEWZjKMgaT6Hd6dfSiXT3lCTD9
	CVzBeogbyduywLRiSIw67ErDdhmbeDDmip8SifPubKWMJbispHaQa7wAk88HnQ5e0uCoFi24MA2
	Q5Sj6rf4tNJ2YM4+jcbxW0QzTIu8fx4Rc=
X-Google-Smtp-Source: AGHT+IECWsjB7/txmP0HgeKCwDbI9pUM7KK9bH4s4kvyNVTIeeHKMkgEpS+/DUbzMvFUyCv6YG466w==
X-Received: by 2002:a05:600c:46ce:b0:477:fcb:226b with SMTP id 5b1f17b1804b1-47d1953c020mr533903055e9.2.1767609708647;
        Mon, 05 Jan 2026 02:41:48 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4327778e27bsm66477762f8f.12.2026.01.05.02.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 02:41:48 -0800 (PST)
Date: Mon, 5 Jan 2026 11:41:46 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com, 
	roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev, david@kernel.org, 
	lorenzo.stoakes@oracle.com, ziy@nvidia.com, harry.yoo@oracle.com, imran.f.khan@oracle.com, 
	kamalesh.babulal@oracle.com, axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, 
	chenridong@huaweicloud.com, akpm@linux-foundation.org, hamzamahfooz@linux.microsoft.com, 
	apais@linux.microsoft.com, lance.yang@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, Muchun Song <songmuchun@bytedance.com>, 
	Qi Zheng <zhengqi.arch@bytedance.com>, Yosry Ahmed <yosry.ahmed@linux.dev>
Subject: Re: [PATCH v2 27/28] mm: memcontrol: eliminate the problem of dying
 memory cgroup for LRU folios
Message-ID: <prqhodx7wc3cbrlh7tqf632b3gpcciwmn5n22qqv7c7rbtsoy3@lsnd7rtdhfmh>
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
 <c08f964513f9eb6a04f80f1a900e3494a99b7e0d.1765956026.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ku7l4vetqokv5nol"
Content-Disposition: inline
In-Reply-To: <c08f964513f9eb6a04f80f1a900e3494a99b7e0d.1765956026.git.zhengqi.arch@bytedance.com>


--ku7l4vetqokv5nol
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 27/28] mm: memcontrol: eliminate the problem of dying
 memory cgroup for LRU folios
MIME-Version: 1.0

Hi Qi.

On Wed, Dec 17, 2025 at 03:27:51PM +0800, Qi Zheng <qi.zheng@linux.dev> wro=
te:

> @@ -5200,22 +5238,27 @@ int __mem_cgroup_try_charge_swap(struct folio *fo=
lio, swp_entry_t entry)
>  	unsigned int nr_pages =3D folio_nr_pages(folio);
>  	struct page_counter *counter;
>  	struct mem_cgroup *memcg;
> +	struct obj_cgroup *objcg;
> =20
>  	if (do_memsw_account())
>  		return 0;
> =20
> -	memcg =3D folio_memcg(folio);
> -
> -	VM_WARN_ON_ONCE_FOLIO(!memcg, folio);
> -	if (!memcg)
> +	objcg =3D folio_objcg(folio);
> +	VM_WARN_ON_ONCE_FOLIO(!objcg, folio);
> +	if (!objcg)
>  		return 0;
> =20
> +	rcu_read_lock();
> +	memcg =3D obj_cgroup_memcg(objcg);
>  	if (!entry.val) {
>  		memcg_memory_event(memcg, MEMCG_SWAP_FAIL);
> +		rcu_read_unlock();
>  		return 0;
>  	}
> =20
>  	memcg =3D mem_cgroup_id_get_online(memcg);
> +	/* memcg is pined by memcg ID. */
> +	rcu_read_unlock();
> =20
>  	if (!mem_cgroup_is_root(memcg) &&
>  	    !page_counter_try_charge(&memcg->swap, nr_pages, &counter)) {

Later there is:
	swap_cgroup_record(folio, mem_cgroup_id(memcg), entry);

As per the comment memcg remains pinned by the ID which is associated
with a swap slot, i.e. theoretically time unbound (shmem).
(This was actually brought up by Yosry in stats subthread [1])

I think that should be tackled too to eliminate the problem completely.

As I look at the code, these memcg IDs (private [2]) could be converted
to objcg IDs so that reparenting applies also to folios that are
currently swapped out. (Or convert to swap_cgroup_ctrl from the vector
of IDs to a vector of objcg pointers, depending on space.)

Thanks,
Michal

[1] https://lore.kernel.org/r/ebdhvcwygvnfejai5azhg3sjudsjorwmlcvmzadpkhexo=
eq3tb@5gj5y2exdhpn
[2] https://lore.kernel.org/r/20251225232116.294540-1-shakeel.butt@linux.dev

--ku7l4vetqokv5nol
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaVuVXBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AhVZQD9G+b2BIoTwqzZNowZZZOP
dajgCA4XQo1Byl6VDL330nMA/21a9Ksyc7ayU/0C92yKZNkp4ovGmd3u2y3uH3X9
E6AA
=CzoF
-----END PGP SIGNATURE-----

--ku7l4vetqokv5nol--

