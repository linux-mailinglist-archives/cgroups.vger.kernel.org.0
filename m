Return-Path: <cgroups+bounces-13546-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QFkOA5u5fGk0OgIAu9opvQ
	(envelope-from <cgroups+bounces-13546-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 30 Jan 2026 15:00:59 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 202B8BB6D9
	for <lists+cgroups@lfdr.de>; Fri, 30 Jan 2026 15:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C2C5F300D303
	for <lists+cgroups@lfdr.de>; Fri, 30 Jan 2026 14:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5BD3161AB;
	Fri, 30 Jan 2026 14:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bhwIw5kK"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B4330E82D
	for <cgroups@vger.kernel.org>; Fri, 30 Jan 2026 14:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769781654; cv=pass; b=GEXMT0wFncNpyJzaPX6dQ4b0f6++Hm70ORma4Sh4ZBW6LgeIsuYeyDv1ZjkCQ7k/a3HcLguDiCl1SGknxXKTkXO6BVPdQt9b2S7UDQNbjdUpwMvFiPtl5Cu3CCXnv5vBX4NAXdYmRR2B1JzQWlnXHymrtmHdVSFg9Bj3wOW1MqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769781654; c=relaxed/simple;
	bh=EuxjmqKleduipeidVWxiySOlmtsbbfNRbzRtx4jo0Z4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QQBSWzcLMiWGt53EaGiPjNA1xFyhLzycTI+IAQI9+jwJbNl7klIhaaXWnRFNzQEAKkR4HkeIAu0yKLz4mOC7Kaz5ZYTrXdLmWCUzE5WHkanAR35zKs0PXuwTOTjBtkyXswjaXJJjWRiTztbTBcftME5fLRwWM8gAwuTc3Vqq5fY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bhwIw5kK; arc=pass smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-89461ccc46eso34042076d6.2
        for <cgroups@vger.kernel.org>; Fri, 30 Jan 2026 06:00:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769781653; cv=none;
        d=google.com; s=arc-20240605;
        b=Oq1VgLcgyiHvskXT/AswjxQq95kX7+/0LyHiw0nMn/svTQFNixUfHxa7BOcVTvibqp
         31nmS/oBdII+BF+3G45Sd2muB6RWzzQmsPu6HzjPle1BlWGLr78iQkM2V7AHw3MnE4AX
         o4SPULPcP0wWuD0YbhyzS90YVR/7GPYIFWV3Y8aVHtMBNhMF14p0iWqeQBNguZ4duq/7
         sTnuFpqtxNeqPnv9MoDE1zkeTmwfDgr2c16fjlHzPn/kEQoAnUQYcd85QAHaZpM+HY3D
         t3hUiVaUtnJLqVQoMqnIDJbIc9FPRIRwgrrcN3MphFmGAxIPfxJXHNkTjgI9MotsZaY6
         swuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nM/SdAiqzbUu7ru7oIiet8XstWPtQwFu8sHUWw12G0Q=;
        fh=Yqdf1rDUSkhcCzSbOarTeP4gmqUBXnDpevveTJ021pc=;
        b=M/BO6Xkb5vCsoQTPqp+iDPi9SasdCFnfeBKRht3WCEjdTWeylXwkdG2OvvGchT6T6z
         XlaJb3375XU+93ZO52jbQuiCCQ08cw3OgUlGYpikjLCGFHTd6rUg75tBudwuHA9itghK
         q7TQXmaehg1tbpyGZtpemjfR+YJ0R1C4IgXMxzAEXpDT/WDgmg1UpAv7g9S1OeAQHRDI
         s4n2rueFbLq/AXlkCDkswIr7nnKyNLN0wgCCtHNHsghe5GtFoKjr9cWL+m23m8QQKvbC
         S+TmLTcvtU+lWtGvPAghOffh67X4rRE7idsJcrTztPI6Q53kz5ecNqGrvtogas2klLse
         tCtA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769781652; x=1770386452; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nM/SdAiqzbUu7ru7oIiet8XstWPtQwFu8sHUWw12G0Q=;
        b=bhwIw5kKiBvf6sk4gBj4U689xaZJmCHoTLJDXT7eK9OGl8yf8tYf4mdBivcZz2+sIE
         pRLnuOo0E0E3T/CWrJRWzqfvJfBT4VZL/6RAxjzvcNX6zr6b/8KLBnuxy45B3xLAacDV
         P/xbzcqKAr6ye/YZlR0MsOnJ9vh4xyVqu3fwdJQ1zmZnshWZSH0tyTKziab86Q6WQVlo
         NNR2p6CLTU57itJKo5K56HgHJqaf2MVenb0ac5V4PPcbj9oCMukw5aR56Ng1ocdOAwIG
         3r81J0CDDLma14xzrq0VG+/t3iWkjQTZ5TVXcm8rUiG9VS32iPjj3kYPB/xHvSGHSmA7
         8/wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769781652; x=1770386452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nM/SdAiqzbUu7ru7oIiet8XstWPtQwFu8sHUWw12G0Q=;
        b=TJjX8xuLPasqqjCG2hUv6EVK+3t1VCPJMJ0Ha1l0XcuFEV8E9TF5Ryk9VVMgXP/EV9
         OWyVmbmemv9rR9YpTC5/EK6c21TCKe9KxyFm7I/LVqP5hBYGcwgQoBnYhcS6LtcHnyDb
         V6365JWL/8TZNqDd2oOAvkOFSqe4TEY0eN6F9fvLAmQaIt/YrZd1I8aOEICerCdtaDU/
         J2lnM6hLPrxFCypEp5e9VlI1ypDJS7yPyvZH66QKU8Ywm4PltdJraB7wS5AOrBr73F1K
         e2c5G9ORidNl49/D8h79BcyhdsRRjwQup7er7C8Ym3h3klOkoPkhPfXBgTKAy+Q4x1NN
         Cciw==
X-Forwarded-Encrypted: i=1; AJvYcCV8Ypu1DYixPb4WCNUXL/nClKrE9WhLmxEUNeK5/qAxyXJTGjrzpivxjESUv2szKfX6iGISEOJb@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn8wZSmrkGPP9jwyldAVrLHbfe2+EHS8ffeI92BQSX7grJKskf
	e1gIkMHG5n5OU5Z7JH5Bz+HBtUQkFoFYRziDtuznXANjqotgF8k53q7isZ2RUP0a/htqmvzUhXc
	ErdLjJ/rvOu3UcmxdcS2Ilh4LYtv0iZc=
X-Gm-Gg: AZuq6aJjIRvuV4l5AbcbAT5ZAvuW/Yyg4D/yTv+gT9qq+pfSsgXPfqI06ZfRbv7W25I
	k2hoHSPhV8598navWCvAlFaCbkclvlDwq5PGhD42Pni/U3GiU3LI/1SClJAdhFANTOTqYLTQkZa
	+SIh6I0J6aStBNMYk6xKFNTbrZ41pxxLgNto9PV69FKb42FidIsujZ0BJar4E49l+HyTfQflP5p
	iIShE/Deo2M/RkuNh9Tx/51NFlE59bbkVOlxHudRYqaM0qlFY5zS6Rz4xVRpe5HiiQLMQiJ
X-Received: by 2002:ad4:5749:0:b0:894:6ff2:191c with SMTP id
 6a1803df08f44-894ea034885mr37076256d6.33.1769781652275; Fri, 30 Jan 2026
 06:00:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260130042925.2797946-1-shakeel.butt@linux.dev>
In-Reply-To: <20260130042925.2797946-1-shakeel.butt@linux.dev>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 30 Jan 2026 22:00:40 +0800
X-Gm-Features: AZwV_Qh8eUHpePAv_A_lOlwdp6GVUu1KAmqw4DrtwBjVbWAU-tLa-e42BVT3QeM
Message-ID: <CAGsJ_4xQhkEOe2Juqgy_3u7PNJ+hhby2qrpdf_X8YCuEwK8Yrw@mail.gmail.com>
Subject: Re: [PATCH v2] mm: khugepaged: fix NR_FILE_PAGES and NR_SHMEM in collapse_file()
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Rik van Riel <riel@surriel.com>, Song Liu <songliubraving@fb.com>, 
	Kiryl Shutsemau <kas@kernel.org>, Usama Arif <usamaarif642@gmail.com>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Lance Yang <lance.yang@linux.dev>, Matthew Wilcox <willy@infradead.org>, 
	Meta kernel team <kernel-team@meta.com>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13546-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,cmpxchg.org,surriel.com,fb.com,kernel.org,gmail.com,oracle.com,nvidia.com,linux.alibaba.com,redhat.com,arm.com,linux.dev,infradead.org,meta.com,kvack.org,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[21cnbao@gmail.com,cgroups@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 202B8BB6D9
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 12:29=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.d=
ev> wrote:
>
> In META's fleet, we observed high-level cgroups showing zero file memcg
> stats while their descendants had non-zero values. Investigation using
> drgn revealed that these parent cgroups actually had negative file stats,
> aggregated from their children.
>
> This issue became more frequent after deploying thp-always more widely,
> pointing to a correlation with THP file collapsing. The root cause is
> that collapse_file() assumes old folios and the new THP belong to the
> same node and memcg. When this assumption breaks, stats become skewed.
> The bug affects not just memcg stats but also per-numa stats, and not
> just NR_FILE_PAGES but also NR_SHMEM.
>
> The assumption breaks in scenarios such as:
>
> 1. Small folios allocated on one node while the THP gets allocated on a
>    different node.
>
> 2. A package downloader running in one cgroup populates the page cache,
>    while a job in a different cgroup executes the downloaded binary.
>
> 3. A file shared between processes in different cgroups, where one
>    process faults in the pages and khugepaged (or madvise(COLLAPSE))
>    collapses them on behalf of the other.
>
> Fix the accounting by explicitly incrementing stats for the new THP and
> decrementing stats for the old folios being replaced.
>
> Fixes: f3f0e1d2150b ("khugepaged: add support of collapse for tmpfs/shmem=
 pages")
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Thanks!

Reviewed-by: Barry Song <baohua@kernel.org>

> ---
>  mm/khugepaged.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)

