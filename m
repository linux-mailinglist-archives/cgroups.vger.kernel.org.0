Return-Path: <cgroups+bounces-1781-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7073C85EB13
	for <lists+cgroups@lfdr.de>; Wed, 21 Feb 2024 22:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 106141F28087
	for <lists+cgroups@lfdr.de>; Wed, 21 Feb 2024 21:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3874412DDAF;
	Wed, 21 Feb 2024 21:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="TvKM5Qjm"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B6512DDAC
	for <cgroups@vger.kernel.org>; Wed, 21 Feb 2024 21:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708551080; cv=none; b=QgJLPXAuFRgkDLNhGFpklQRKz5ZJVUsdPhVpqFLKMgRtjCpgp9BAJLp7CtyjYEbbrMN7ID0t60fu24DxWvpsEhQctXQrEanGhHyU+satIqejgtS5ek6pgxz+ndX9flf5nW8ZZiRbb+47M9YeQWwn7wwEk65R4B5038Fine0ClNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708551080; c=relaxed/simple;
	bh=gFsioKErNguGb0UXfpCehO3mOIaCj+gYffuxZggc6lc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T8Awf/6kA3a/kJ9fAf+ghx/p1cX2HvelGnh8biyUoISElU/JtNeIoJpf+3MLvitJqegPjvDHtOiKbTTbo9OkLhly/ylOQZQJlFCJsDPYziW4B4oGh/LqS8e1B4PVP9USO7HXDL6MsP9W/ExZYDMSpCRQgX/sQ3i2hKoy25/QzEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=TvKM5Qjm; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-42e323a2e39so1644731cf.1
        for <cgroups@vger.kernel.org>; Wed, 21 Feb 2024 13:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1708551076; x=1709155876; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gFsioKErNguGb0UXfpCehO3mOIaCj+gYffuxZggc6lc=;
        b=TvKM5QjmE9xrfDQJ0zweQnLEld1ypTjdep3yzcgaY30WwpzHdpmS5OdggDnbCVaKgl
         1JI/zHkJI7W6/zh4E+3JMqzlHbFQqqjxdhIdIhzoFfy9vEkG0Ut4sFjJAWQIxQfVcLLI
         ugE17rbvStlLf4KlWm7GZ4w0Y23sSuKIgk/Gp0ewW1tpB1IW3EUUNBOK2S0IvZMhQBAV
         Fljy92n/Wd4jpdvCPDYvSWZFTUCreb0Gt1ia9PFfu8yiO4DmpffOnJASQG1dxoO8YQMc
         KUK3XFt3/8JyqXNqZ/Q+U1IaLjSKpwN+bGASvPMOF6g+KRYRa0s4joCrPuQI+G3jREI1
         +i+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708551076; x=1709155876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gFsioKErNguGb0UXfpCehO3mOIaCj+gYffuxZggc6lc=;
        b=P2Dr/kuupsiBal2HYrymnYGh+mTYwaxLN+KajuOU6maFRgHKHm1dkDaav4czO3Ia3F
         F9lWjgWTZduCvM9xYSFVzyzk7om/gudAL/svKKTa3VOuycRYb8LBtoWE1U/9OB5ibf95
         nYPzgCRp+n+4NT3DQRQsO3ifvx6rRwvEheXLZHy7jXmrrXO4dTLUV5MgetDFkFMNBduV
         vW3VNviVdqIvd/QLwtENvwOHMd2GuCMfoxMTxtsrVpRfNNfR2mHRi/C1rSRwzI5SwgwJ
         bJSc4g8ZuPbUEJmP3iR9RCeLnMDvKErt+Dyk6AjSCgLJQIn8YBhuDxIVc3A5I7ILqadv
         xs6g==
X-Forwarded-Encrypted: i=1; AJvYcCV+tH0bTP0slLrsji363pQM0RLaxO1hU4Z8iKILvgUn+7w/zi6LkMRVE9BESgk6PLRv3Win03B38euNUTNboLtbfDH9V1BmVA==
X-Gm-Message-State: AOJu0YxzSOkawhjmBF+v1+ZNLZtVe12xzW+KitzMnQJGCwbK2k9nxkka
	tBflaWDej7+vmensdOmT3Ues762f2SPbSezz7mecHAPeqoXuFBY9BKEUAQ1OnWopYfxwjEOQ+R8
	bG5nxbdRygfTe4gYXD7kKW9bddsLXfppnDKGhTQ==
X-Google-Smtp-Source: AGHT+IFO5Z7BsmHAefImdCXlOf9v/A1DymY9rKzrFG6F8X6fIh9MpYHyGC/yHJX92pP0BH/FzDecR0AIIxui9aAjnNM=
X-Received: by 2002:ac8:570f:0:b0:42c:78fd:e4fa with SMTP id
 15-20020ac8570f000000b0042c78fde4famr1316065qtw.32.1708551075946; Wed, 21 Feb
 2024 13:31:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221194052.927623-1-surenb@google.com> <20240221194052.927623-8-surenb@google.com>
In-Reply-To: <20240221194052.927623-8-surenb@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 21 Feb 2024 16:30:39 -0500
Message-ID: <CA+CK2bDOiV8xwig1pDdTVjkO4KhK+jJ0wXAtNon1ZXQGviih4A@mail.gmail.com>
Subject: Re: [PATCH v4 07/36] mm: introduce slabobj_ext to support slab object extensions
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com, 
	vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com, 
	peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, 
	rppt@kernel.org, paulmck@kernel.org, yosryahmed@google.com, yuzhao@google.com, 
	dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com, 
	keescook@chromium.org, ndesaulniers@google.com, vvvvvv@google.com, 
	gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, bristot@redhat.com, vschneid@redhat.com, cl@linux.com, 
	penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, 
	glider@google.com, elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, kernel-team@android.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arch@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 2:41=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> Currently slab pages can store only vectors of obj_cgroup pointers in
> page->memcg_data. Introduce slabobj_ext structure to allow more data
> to be stored for each slab object. Wrap obj_cgroup into slabobj_ext
> to support current functionality while allowing to extend slabobj_ext
> in the future.
>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

