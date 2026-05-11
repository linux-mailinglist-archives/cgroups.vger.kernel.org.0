Return-Path: <cgroups+bounces-15741-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6ASRDlXBAWrKjQEAu9opvQ
	(envelope-from <cgroups+bounces-15741-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 13:45:25 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6E950D052
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 13:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 474F5301A931
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 11:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881F2374192;
	Mon, 11 May 2026 11:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="awtrweLH"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB55A79CD
	for <cgroups@vger.kernel.org>; Mon, 11 May 2026 11:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778499594; cv=none; b=ULqD4wy8qzzrf2Mc05m/ouG+DCLaWtSC09U5jb61v0K6uxEEEQmHKbgWqgKQhG8y20lvDleCZAc+nXXO9+msizwiP/135q5jvPRmNBUgINuRXR4rsB8lQM8hiS6TvgGt6rma7SJ2wN64C2Jm9P1Aag9ziPC/E2KgkiG72x6UTUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778499594; c=relaxed/simple;
	bh=JXwoxY9aO+DdJZo6FW5QgM56rkq1xPTTIDZwqNN6ABM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B78Y7BxOdZMI8dj4EDzS+YzcSE/33QP6RhCaBb2y7s1ShFPuYqYZolR1qsGxFjkzNrQDcYY+1d61a7HemQKEp4DnCoQ0ax90rptcZqgIc9t2JwXi6orMkC/EKcVwSD1AcCxNFyUk9SSgB+JRF3LTFI1rQaEizBpifHEwFbUNUoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=awtrweLH; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48896199cbaso38506005e9.1
        for <cgroups@vger.kernel.org>; Mon, 11 May 2026 04:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1778499591; x=1779104391; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JXwoxY9aO+DdJZo6FW5QgM56rkq1xPTTIDZwqNN6ABM=;
        b=awtrweLHbVfJ+6Bw9y4sECp2qtc+IrEupfd3CpIoOpE0Z3Z0sUOd+m/G+/IKQL713l
         rozCh97r0ERbJZI5AMmUiU7wg9ugEJyDfHOc7QeOzEGlhvlp3li7annLpI5vDiRZRWXi
         zRwUgc2o4pO6DRu/H3+Vl847g7KCc7CHRafUXphKNcDne6tQGRc0Re5fAv4bBFcSt0Jq
         LFuDRKryDDeydy3/fQOhOXv0r5WI3wuPbN+lHaFGpxBJqZUzf9jZzHa9B5wjEFKcwc1M
         ZW/+h7abq5nxSyYLoHJ3Ths2IUdjnA3ZzlZeziRjGMQygDdjQUcLRzBIor4DKvDFH5U5
         TmAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778499591; x=1779104391;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JXwoxY9aO+DdJZo6FW5QgM56rkq1xPTTIDZwqNN6ABM=;
        b=p7yYY4dQcKPXtDUjDDnlcwGmgv7hg4ujIVXNe0tMCZ65Zm/San7ReiTzLiEwKESqAr
         8TKUwcxCpUCeKBG/WN14CCD6j5XEqyteYC6t1fRVjc5I0NrxvWa+6o3aFYGk6tqqnZhu
         u5Bg3+XlffdTA7b7Sj7adRwHrS5q/dGv4V9a4B7FlhGJQYtAm7rhQ5R07RXJJ1W0G+9V
         YTQpher4YS07F8OqZP+zYod7C4TKBBLZiHY2wKEvSJP+AIm+NuOOSmaS5QISPpAdCK7E
         0TN1O9GCY297XHADRylZw8CFcTMilOG+70thuc2dHIvkf0uP8SwRVAdAmQpTQ7l5QEqV
         x3aQ==
X-Forwarded-Encrypted: i=1; AFNElJ+LcVMZzkR40/5MJNqXTLcqXdFB0rZuOxcEfmsG3vnQG2It9r8Aho8feafTIVRV4CUnApRkntEF@vger.kernel.org
X-Gm-Message-State: AOJu0YwqHYwrNljV/9Hh4zOSq90LH7pwFutHwW+e9izcNJE9nfvdR8ZW
	WyLPOOVVUqhC/30i858EzP/c9RcXY6trooKSDyvGBwJmX0Hs1/Vrb95Qv5wDLxuiLOg=
X-Gm-Gg: Acq92OHapnKB0FM5afnRHx8qJ/EsT4NrtRifJy7e6UHUlv/CUUPf6EfCK0aBeLZzc04
	R6CV0F0MhLX1iedTLs58oS/4KKzfazdOMRIIBYOnTzgjn1/VIkZ0aZH+dLbwc5AeZumTaMTKELZ
	JBsQJUYScKaPrBZbyqonkH9YRLzXKh66s0dWvJopVK9ljVNarUQeQNMzcA2A1c8jERNuRUvR7pn
	6qes8hmaX/NWA+14jEA6KM781SckB2uR2eTd01KcNVjLMEe9X8rMrwQHdwwGTiTglr9Oc92yee2
	8TmGUJwS9qW4HzQc6c0+XmMNQzK2YV98FgDr8cHFqcYCsakAeYCm/jz87jK/QEyA0NRtrT8Vu0J
	ZNBVxXtAndVP6C7/zk17meWiEHJ9hoORbrIlgW12pln6vTwIGghGqR7/sQo5q3AgJFKC4m7q5rz
	YP2fvFD9VIlcUOCn619vwT9yYIL+aSou5xjqp6TI0pJTxxAfXB
X-Received: by 2002:a05:600c:83c5:b0:488:c683:be89 with SMTP id 5b1f17b1804b1-48e51f2a759mr342964415e9.9.1778499591165;
        Mon, 11 May 2026 04:39:51 -0700 (PDT)
Received: from localhost.localdomain (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6db0b08asm83235955e9.8.2026.05.11.04.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 04:39:50 -0700 (PDT)
Date: Mon, 11 May 2026 13:39:48 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Hao Jia <jiahao.kernel@gmail.com>
Cc: akpm@linux-foundation.org, tj@kernel.org, hannes@cmpxchg.org, 
	shakeel.butt@linux.dev, mhocko@kernel.org, yosry@kernel.org, nphamcs@gmail.com, 
	chengming.zhou@linux.dev, muchun.song@linux.dev, roman.gushchin@linux.dev, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, Hao Jia <jiahao1@lixiang.com>
Subject: Re: [PATCH 0/3] mm/zswap: Implement per-cgroup proactive writeback
Message-ID: <agG-gNEclOVf-9WA@localhost.localdomain>
References: <20260511105149.75584-1-jiahao.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="o3jizhh4qfyisfpc"
Content-Disposition: inline
In-Reply-To: <20260511105149.75584-1-jiahao.kernel@gmail.com>
X-Rspamd-Queue-Id: 8A6E950D052
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15741-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,cmpxchg.org,linux.dev,gmail.com,vger.kernel.org,kvack.org,lixiang.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkoutny@suse.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[localhost.localdomain:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lixiang.com:email,suse.com:dkim]
X-Rspamd-Action: no action


--o3jizhh4qfyisfpc
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 0/3] mm/zswap: Implement per-cgroup proactive writeback
MIME-Version: 1.0

On Mon, May 11, 2026 at 06:51:46PM +0800, Hao Jia <jiahao.kernel@gmail.com>=
 wrote:
> From: Hao Jia <jiahao1@lixiang.com>
>=20
> Zswap currently writes back pages to backing swap devices reactively,
> triggered either by memory pressure via the shrinker or by the pool
> reaching its size limit. However, this reactive approach makes writeback
> timing indeterminate and can disrupt latency-sensitive workloads when
> eviction happens to coincide with a critical execution window.
>=20
> Furthermore, in certain scenarios, it is desirable to trigger writeback
> in advance to free up memory. For example, users may want to prepare for
> an upcoming memory-intensive workload by flushing cold memory to the
> backing storage when the system is relatively idle.

I can imagine the zswap writeout can come at the least possible
moment...

> To address these issues, this patch series introduces a per-cgroup
> interface that allows users to proactively write back cold compressed
> pages from zswap to the backing swap device.

=2E..but I see this series is not only per-cgroup proactive reclaim but
it's also age-based reclaim.

The per-cg consumption and limits (and regular memory reclaim) are all
measured in sizes. This age-based invocations don't seem commensurable
(e.g. how would users in practice determine what is the desired input to
here).

Could you explain more reasoning behind this design?

Thanks,
Michal

--o3jizhh4qfyisfpc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCagHAARsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+AisVgEAue3WyVVGY7GBg1v3Zt8e
eeD5pIl0nLnXPUEjlLTIJNUA/2WZU04Y/56uL4zU3y+755L6om2vsL3DmWWaCGB9
0zoN
=7Raz
-----END PGP SIGNATURE-----

--o3jizhh4qfyisfpc--

