Return-Path: <cgroups+bounces-16455-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4LV5MfzgGWpmzggAu9opvQ
	(envelope-from <cgroups+bounces-16455-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 20:54:52 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E2086078E2
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 20:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AF0D030E1CF1
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 18:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A3A421EED;
	Fri, 29 May 2026 18:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQbUEr4z"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F402347DD52
	for <cgroups@vger.kernel.org>; Fri, 29 May 2026 18:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780079874; cv=pass; b=J1x8+W/bGGVJbuaMmzLIqkckA0XqrkDbJYXw0+xqdsBwsYL0T2/Xwsha6zlaF4PnA/XGqgPVC1qd9WXHgKbd0w32eUGeksGUL6sA56DCwqDQ8LlVphJlVlbEGV20noDaQQ0ouviuduqX/VdUrFahsKvobgV3iyb5zMbDu5eE2cY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780079874; c=relaxed/simple;
	bh=qPKJA6D0LGn2/u2ZczUNgOn1T0csWMFeqaa7i0inBkA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IDpWelkXZx30HjgUWdsYOpPakRa5QGfJvXyHnUAf/g5Ssjg312vpWQRL9+WIoNsXCPTNEM828A5eEIrMfwlAVeN7fLfdZ2FOZK2O6becmUF72Z5pS+XuJ4Z37Yow3rfyYB4lVYIvjdwdgJHjbCO9tcqWYxqSLDXxOvkdFqlQ5j8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AQbUEr4z; arc=pass smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-45ef5146b56so475268f8f.0
        for <cgroups@vger.kernel.org>; Fri, 29 May 2026 11:37:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780079869; cv=none;
        d=google.com; s=arc-20240605;
        b=icmzWjN27Df+hQIsGeUo5f2RHMAy1VTVpCRWLzyLojb0JtAAIx7ufvJhZTeeYmLb5E
         xLJ0SdimNgDEkSe80T21tqDQmv+JbHPPy6TOKu104V+5u0OOvIBHnMJjpbWl4gzErJY2
         lwZzEhQAz59l+tqPabNk+BvZZdL1zbz6nfP7SIZ5fPasdNQ5dKoW60yDfOhRr1qfKKH0
         i84VXz3rw2PNrjSHhA6+Z18YIZG8iSRpqdXqYoQTBeHw900Fbh36zda9UhTO0+xc5ioH
         3r3JbWL9ZdLcp6934+Uf1FGXuOuMJbHbOPH/mC3uHKu2c2c9h6DJajwOJTkfA6M6NJAo
         nVBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OyyGXznH756Ari3cnm0vtA8k1/gvoDt7hkckKPbPwiA=;
        fh=/KnrhA7lIUnlzEZWInhR5OVDrtRGt9hcG+WQUCnnYyU=;
        b=aR0nbnxCAahXDz91EoSmNouj5HcFPEAROTHbSi1cIQJpTgEFszSltBbyEpr7ZKCWUf
         jWQUvuMVG9jjgCldx29yKAz6o7a9oB3K/DxTIVhGKzMAo1cEkXtcdy9bO7newWlkmmar
         cwGYrchGDtJ4UySOyzZ/ZM4n1bRAoGwwarkVrQ+CRBIiBlOsdEq7M8XGYKkxxkkHA96Y
         P+HdMJ701Xzah0i4o4LhTixPzW0zfcKzh1qtetrpVD67zdJ2dqBkTR7ViwYa2XfbiG8A
         fG2JGLJZiCSoMXizWr+zLXqqhbfqwz9daPPKggO6kXhDN6vq+HVcDf4Q1EUtEpCNtCaF
         C5YQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780079869; x=1780684669; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OyyGXznH756Ari3cnm0vtA8k1/gvoDt7hkckKPbPwiA=;
        b=AQbUEr4zvVZ/nguQeLQ3Qh1zs3AJ4x9y18qs3Q+JAj35dN2Trthe0fDslCPfk2Xr1b
         PT/5lkoh7E9X7m6M47pbOYdVjlLQeBWKeW8DX2TvPSb7cBHrYGtA2nIyGJZPtQJlaSB2
         QinvZHV3UOte1BzpxqKAjH92BWDYZhZlRPsOAeVlYzSMeRiLdxFoX9jAdbCwsfnvHWCs
         5C3Rw09+KOty23+yleM4YRey/fmnM2JzNVlwwKpuHdgG7EqMw4GApihVm2Le+/HeWRpf
         banIVfiuc6WJOokMRaTGv/xaf9YG+kw3z4X3IewZvLKdxL3a/wuePYgu0acBJZbdD8tE
         HUjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780079869; x=1780684669;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OyyGXznH756Ari3cnm0vtA8k1/gvoDt7hkckKPbPwiA=;
        b=fsCl7g6SRmV7DHDOwKgsndiLyHi2wM1keXvIG6rL/0ADmU9EA7JkWeUnCnlPZ0jtB1
         9VSiiqKJwL66K4JTmbXOmbx+19dOq0qN9v/dWJTGebQxGYzO/BkW+fE/Ma1vEv6Rh1Ep
         jB9RCNxPj5Z6wv/iTekh0wQMhL3Ro9ji6mQX5isQNyRVaCCg/WjwYq/FuFcfgrIBkkJb
         2Tc5M9tMOwR8jFNIFIQ6+wNrpsmuncqSxpOGrVV15XB4NeaaZteMMsrWoj8CR97xbpKv
         3kr3BXhGktsmCy865x2EOjbywM5VugJ8DK8k30Er4u/uowbip/wcGwL5SLhlvGjpJbBG
         criw==
X-Forwarded-Encrypted: i=1; AFNElJ9GePlFd2f8NjMyymriwBILmBDgN9g+qrzZ/IxfL84zzP4Fo/R1/IlgqvB2F3dRxq5XAgqKtNjf@vger.kernel.org
X-Gm-Message-State: AOJu0YypSVWWU5ohvo+200BUYGltVa+3k9P7r+9OyR1IB9Y0L+7J2Oqb
	VgmlFptdw9Osg+OR1dXoZcKC50BeKWQB2QP838eA7W0e3VltuF9fLJgVF0kM/oi+GwiKlSCf43t
	8jOSmsZIMNV92SOXLarCJNHW/ROMFpM44Oyzv
X-Gm-Gg: Acq92OHjPauqk5stkZ7g88cL/40P+dkbqQd5ah8OPq9a0IGADwYZ+X5Dsxy6MDHr9Li
	OLpvTM3b+jqds3KdslS4+xHGr94ZKV71UANC/K5W7DMrs3zV5n7CXZRi/dgYcI9xLerM/yXv+Jl
	qMi0Lvn3m0qQLSdCDpgCbDpB017GEekhrCchMCYnrueQcEjGpK9J94+l5cptSlclJcC1fWzbQkm
	B7pxrGz0IpHkI0ruSvrMNPLJJ9wbXvUIfy5ANLEu1aTnZj9hOvMHm9qWH4lvAErTeW57GNYbSVG
	o3Jo6Ej0+fQDv8JhbpkmugDGZPUpLKc/0rfOXMitniIpqL0zYw==
X-Received: by 2002:a05:6000:2213:b0:45e:f3b2:1228 with SMTP id
 ffacd0b85a97d-45ef3b21526mr4824550f8f.3.1780079869239; Fri, 29 May 2026
 11:37:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_98CD9F78E48D08DC005A6471A13CFF28B60A@qq.com> <tencent_0F6F682C60B99E9E0F1553E6BF3D86468409@qq.com>
In-Reply-To: <tencent_0F6F682C60B99E9E0F1553E6BF3D86468409@qq.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Fri, 29 May 2026 11:37:37 -0700
X-Gm-Features: AVHnY4LiJVKg25l_5m8B9ErXgvZXvx5mC7FyBxv00LQERNLD-kc9M0aLPYUH4f8
Message-ID: <CAKEwX=NDfJud3FM4Y+Ek3RtTtwi2aXWeDCujNxh2ReUEq-m4oA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 9/9] docs: mm: update THP swapin counter descriptions
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16455-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,qq.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 6E2086078E2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 29, 2026 at 5:19=E2=80=AFAM fujunjie <fujunjie1@qq.com> wrote:
>
> The THP swapin counter descriptions still describe large swapin as
> coming only from non-zswap swap devices. Update them now that
> zswap-backed large folio swapin can also increment swpin.
>
> Also describe policy and backend rejection as swpin_fallback cases,
> since speculative zswap large swapin can intentionally fall back before
> doing large IO.
>
> Signed-off-by: fujunjie <fujunjie1@qq.com>
> ---
>  Documentation/admin-guide/mm/transhuge.rst | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/a=
dmin-guide/mm/transhuge.rst
> index 23f8d13c2629..59b7a0d09243 100644
> --- a/Documentation/admin-guide/mm/transhuge.rst
> +++ b/Documentation/admin-guide/mm/transhuge.rst
> @@ -667,13 +667,14 @@ zswpout
>         piece without splitting.
>
>  swpin
> -       is incremented every time a huge page is swapped in from a non-zs=
wap
> -       swap device in one piece.
> +       is incremented every time a huge page is swapped in from swap or
> +       zswap in one piece.
>
>  swpin_fallback
> -       is incremented if swapin fails to allocate or charge a huge page
> -       and instead falls back to using huge pages with lower orders or
> -       small pages.
> +       is incremented if swapin cannot use a huge page and instead falls
> +       back to using huge pages with lower orders or small pages. This c=
an
> +       happen because allocation or charging fails, or because policy or
> +       backend state rejects a speculative large swapin.

I think we should add separate zswpin and zswpin fallback counter for
THP rather than overloading swpin. We already do that for zswpout vs
swpout.

