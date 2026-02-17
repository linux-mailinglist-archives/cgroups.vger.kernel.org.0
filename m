Return-Path: <cgroups+bounces-13978-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mOxqGrXAlGkXHgIAu9opvQ
	(envelope-from <cgroups+bounces-13978-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 17 Feb 2026 20:25:41 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB8314F9D1
	for <lists+cgroups@lfdr.de>; Tue, 17 Feb 2026 20:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 747533006996
	for <lists+cgroups@lfdr.de>; Tue, 17 Feb 2026 19:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1799C294A10;
	Tue, 17 Feb 2026 19:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YLUQdFFs"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB9836A03D
	for <cgroups@vger.kernel.org>; Tue, 17 Feb 2026 19:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771356331; cv=pass; b=nK6TpzzxQjaljtate9YCgYUMGISZk17IWTNNgCoVsvqo1rV/LhVmBYPK/T9MVNCqcV6Wz9E4sIuJlFOcL9sUp7Wn3ROA/98V0mG3Ce+bDmdGuKt9iVl1cuby3DOSi5+8T+o3E5v9+O3E+WBSrfS7wI1kQnF+pMJlFjVch67YvJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771356331; c=relaxed/simple;
	bh=CwHGDX0I/MtzPYs24hZSqz0/ri7iZjm7LIBdNw2JZ84=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NntNr8ve91Q6oKHoxw4mcg0zBTSHu+DZn3CrmygEXpaXCm+Y2y3CFQIOF5JpMc0OGaAQ3HtuKoevF/sqJLdp9nev90m+6RcUj4/Juq+o+npjO0VunWKg79L6lpV31KlN3LbUzZ27IqLeH18ugNDptjgdkJSOAZ9HE8kpKk+uUfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YLUQdFFs; arc=pass smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-48373ad38d2so10175e9.0
        for <cgroups@vger.kernel.org>; Tue, 17 Feb 2026 11:25:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771356329; cv=none;
        d=google.com; s=arc-20240605;
        b=SybaL8emIKAoLLHFV3vatu8bnO6WVtK9zSM6vAjsdic/YcmdZv/fewQhkEiluKtLX8
         GccMuFbXaoKQ5t++hXfrdXiUBRvj9LR9mDjw0yb/Zuk4dq7XbJhV2Tivy7Nx/SESiXLf
         qekGJ3izvFj+h2v26d/NTYJUIcwB2friulvMpShs+HiDHl91xmAwzZt4U5LQwA9Y+e2V
         OVDWGC5nEQGA3weaEmMquTol38XrDRaNRss+uLFnA+F95x8HSSRySSK9H0aNGe2Ewlx7
         /ju/T0dFQw3/F3ARDLaSveT4YOu/EnbRO/G0gpW99IbCCBCq4FyMhGDyc5q26ByahQ8U
         87gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=agcE7U0hHa2jey3GOzRKRM6iuQj3YGWAyKNtM05bfZQ=;
        fh=Alu5r2efTyiLAvApTDcZ01d22AZR4avTJ+4VW8jEmH4=;
        b=FTJbJ21K0KC9+ay6SlrlZKFAATj6fsjiYSDNd20fhYpLwWPeqjtWodiXlOcoas79Yz
         YfZ/Dpvqr6T2mRXkE+1KQnn/+0wyn2xcdJTNGMxzNPSJA5SQrUo68rUNqDZgAOy7jl/X
         CTCLl0GirDbO6uw8OvDPYtt8XGfiuYLcy42PGE6JBXtMB9Ro+iBn2F6RNfqmbiQXpTMN
         /mg3HNcKjVnHREn/VW/F1F1w4JuSMPk2tp9exO+s4BrsP7BNVCZgbZS0OlkV/6oFGSOw
         oWGe1X98j7bmtgGcSmpN6y5YdJN6uE6VDQVLsZEof9Ty5jlM3m5+Rf4mVCmh1qmBWdZp
         XIng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771356329; x=1771961129; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=agcE7U0hHa2jey3GOzRKRM6iuQj3YGWAyKNtM05bfZQ=;
        b=YLUQdFFsTyOXTrY40ew8BHIq32mcq6K5svfB4COvXtVEpR7uq4sANs8O554Mi//+HO
         F3J+SX+s8cV5yD8cvWlXpNCpnoF8Oqb1jSgvJ79E9yBdzxOTG/fQ53/oG7H9U/aRDHa4
         jYVDh/x4xzU71NXig28Vp7g77AS4ajvMozT+AiD+j2jaFyiNVGZ8KctmdyBAxCrLndNY
         m2wtTnV3Gr744evEQSiqaMo70ylJ0aB8np754/Zav+6LLiw/Rn8f+UdBUmELWQJUVkC9
         1TyOh9OadTT2DF0hxIQ1Ak73zggfZP6iv/rEekM4TwZ7XO+WP3By6l3t5JayW5oVP9bZ
         j5vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771356329; x=1771961129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=agcE7U0hHa2jey3GOzRKRM6iuQj3YGWAyKNtM05bfZQ=;
        b=hPpvD4IE1W2MkVdocAIVVqf/lLlHsZlfb/qiTlKEDFOPYBwt6BWEwB4YoQwFCfeXwH
         gw6N+YK9Vmo/uphx32RKK1NaNOY4R9Vdj0UJh4YG4vx4YAIsMoCcUqTPcZNHXCzz+iFp
         v/kw8V2FUZMpX4DGfNL9jm4Dnfp3swY5bzSx0RKQFS6/RQO6hyLnfbhid4oXa32zSmjH
         +DS6lP2Wj63ATEJX2aXRcp3gktHbC10gy4V18XdG3iQnr+jQLA1zZXrasOYMjQYg3KHh
         53eMuAkS97uCYAEY0pSlYrn8BxcoeyyEwXgG4sdzio63CAKvvfWz4wXPQBc3jmttK2so
         YFrQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7SlFEFqgn04AXWocwWdGDZ/DCkhSFiG/Ew/Cn1sYgBi/VP5B217eFYdm00xUmNqzO5H2tG5bL@vger.kernel.org
X-Gm-Message-State: AOJu0YzVFxZ5Tb/gRfYDyjHUTgZfSQJpKeiHVIQmb819svZHkDTRPmGz
	RCX37yUCLY1hQM3vWrSzD+Ju22eKjIcCcSWa9JGoTqLnQVD8CEbV4KHEFsIzcfxH8hgyVMKOzRj
	2nsKyZqWESCgor98NYKAny/npLI1wE9kyD9tb/Kgx
X-Gm-Gg: AZuq6aK+SAbxRNV58UhE6xfs2eaabsZQiaA4U0kOlUFoRVvOe1k922R1D+hxHIJ2Amu
	gun8RRT9MdkqKgTRHNbpv2+/mxWSV+nv2hMmyQsrYkJAdCWG/L5gLhSF5SEYIbQGVFAIxvCrw/Y
	J7vMKYHxGkaQnwvguqS8WHzYEno4ILGMorjeaN0TxEv8aEQxq2avRl2MvaW9oYku5dMM+4d0PtY
	cCNZA/wxqVxi4tcMO17o16iP4KHX8diAlMa9no8JyDTT5ht29WbxeMwNDKtxnp1FJtxhSvHUtCu
	6Chpm+3yugroh4EPk2YUDSoZl2yX8CvunkVRJazen8OOn8733s6AB6W2hqFi3hsQpdLevg==
X-Received: by 2002:a05:600c:a218:b0:47b:e29f:c63f with SMTP id
 5b1f17b1804b1-4838883cf98mr866745e9.11.1771356328550; Tue, 17 Feb 2026
 11:25:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260212215814.629709-1-tjmercier@google.com> <aZQOK_xnxQn09qmP@slm.duckdns.org>
In-Reply-To: <aZQOK_xnxQn09qmP@slm.duckdns.org>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Tue, 17 Feb 2026 11:25:16 -0800
X-Gm-Features: AaiRm50sXuWpunQQOD6edntmpve7h-Rlruw-KS0KVWY35EyoF20ve32-aeJ4CtQ
Message-ID: <CABdmKX0o60fP+ub4w9PBqZ8_5fR-X3RBy1x+XVzekvQP4WAysg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] kernfs: Add inotify IN_DELETE_SELF, IN_IGNORED
 support for files
To: Tejun Heo <tj@kernel.org>
Cc: gregkh@linuxfoundation.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, shuah@kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[cgroups];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tjmercier@google.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-13978-lists,cgroups=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Queue-Id: 8CB8314F9D1
X-Rspamd-Action: no action

On Mon, Feb 16, 2026 at 10:43=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> On Thu, Feb 12, 2026 at 01:58:11PM -0800, T.J. Mercier wrote:
> > This series adds support for IN_DELETE_SELF and IN_IGNORED inotify
> > events to kernfs files.
> >
> > Currently, kernfs (used by cgroup and others) supports IN_MODIFY events
> > but fails to notify watchers when the file is removed (e.g. during
> > cgroup destruction). This forces userspace monitors to maintain resourc=
e
> > intensive side-channels like pidfds, procfs polling, or redundant
> > directory watches to detect when a cgroup dies and a watched file is
> > removed.
> >
> > By generating IN_DELETE_SELF events on destruction, we allow watchers t=
o
> > rely on a single watch descriptor for the entire lifecycle of the
> > monitored file, reducing resource usage (file descriptors, CPU cycles)
> > and complexity in userspace.
> >
> > The series is structured as follows:
> > Patch 1 refactors kernfs_elem_attr to support arbitrary event types.
> > Patch 2 implements the logic to generate DELETE_SELF and IGNORED events
> >         on file removal.
> > Patch 3 adds selftests to verify the new behavior.
>
> The patchset looks good to me.
>
> Acked-by: Tejun Heo <tj@kernel.org>
>
> Thanks.
>
> --
> tejun

Thanks Tejun.

Amir would prefer I remove the new DELETE event support and keep only
the part for DELETE_SELF + IGNORED since adding only DELETE would
create an asymmetry with the missing CREATE support. So I will plan to
do that in V3 for this series.

Thanks,
T.J.

