Return-Path: <cgroups+bounces-3396-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9263F91A568
	for <lists+cgroups@lfdr.de>; Thu, 27 Jun 2024 13:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EE451F21BB6
	for <lists+cgroups@lfdr.de>; Thu, 27 Jun 2024 11:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10F3148833;
	Thu, 27 Jun 2024 11:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vT5853zB"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E71A149009
	for <cgroups@vger.kernel.org>; Thu, 27 Jun 2024 11:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719488069; cv=none; b=hj4E9Lnwxxcfy4z9bd1ntWLlbrg2KsjKysVJYMxYV7WSLQ7XaZNMzPQTWyTafMYtvKCpQUhyqB7PW1W4aOR5HBmv0oleyLZwPtT0Zp9Mf3UWCoAGWrm5wuCz8z3flu97ElFQBtYE/iUuRATeqiAXFhW6IzGYWLHJS0eHoGtCl18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719488069; c=relaxed/simple;
	bh=s8a9qgL/3vgvPX/ppRhRnHkCxACMcsTSLyLHX8PPUEE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RZRadTtp4U/Nvuvm2kB81/VtKryI085USXP97wgzrhwsNPiUjFxMgtAjllMz6/UQk2OJnW2tn/APaBIqArg1OEkYx+FQTUHySYLVsoTyxrcNVkCuJ0xyPm2+YkoWFLwvhRiDGFFQHUy4eGeF/8Nb+glGGsYl8rPs7rwEftjbkhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vT5853zB; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a72420e84feso703222666b.0
        for <cgroups@vger.kernel.org>; Thu, 27 Jun 2024 04:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719488066; x=1720092866; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s8a9qgL/3vgvPX/ppRhRnHkCxACMcsTSLyLHX8PPUEE=;
        b=vT5853zBjNlpzirf1SaHUidFyVTMqdNtTw5GSCMLHfJkf3HMkj3PYKR0oLoFokegN9
         PUKWAspsD0kK/hP6d711dPfauRepyVFUoxfKVfVNG9cdzK29pxOHU0JsY0BCBXNlwzha
         r9/xSPRd5IK6SMuFcsNTHTEhrt5oqcQIvaG4vmO5UlxTfEB9LhS7ytPsn3q4YAx/2v+5
         T8BfpYit9mLfWkgN8iWkTE7Pnc5q3YS8kCB/w1/TOMQD55XpQy7J3fAIcFLZJ8FWNpyL
         wImrhBORQLJKPX3ggvbT8pGcdZ3wGYeZIUyO+iKX1jCf/3seFQFpRUvBMKIQaGJzU7wR
         Qk5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719488066; x=1720092866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s8a9qgL/3vgvPX/ppRhRnHkCxACMcsTSLyLHX8PPUEE=;
        b=Jr4UFjnFsZUyytUTGEqRaTxbhFWQeX+u4BTbCj/VlblS6CGSexdPu4DiJ1ZEe0T29M
         X5+FfG5Ffsx0Mn1P5LzNSHLN/SyjV+MRms+aamZDH6qZEi7d+qWqUfWh80lVjoN9k6a3
         RQnFemEH7B1qVDXbOQnwvIhJirCeaOWXfyBF/ef8jwj2CrBEUJigSdGn6rREtk4ppoIl
         7o7jKy7iD/MlerVtjsqJ7ZpzVsJXRhH42I0rENLffWYfEzHTT1VdmqQ0S20K5zaJzdZp
         hhX/CYCB3nvGq6cFIvzWG49gBP11M1NyGaEvuGQC65+WMXsU9lQWlAPaZbouwDW3dqmA
         JbtA==
X-Forwarded-Encrypted: i=1; AJvYcCVLJJ85RC7A/j7NauxoCZySJrYhKWC2VWmxJ+VoGCKzAz16n3DCpIzuxoarQZMicOP2Tw9Wo7c9Kyo+JgXBmn1TXmyyh90jJQ==
X-Gm-Message-State: AOJu0Yx70t4zF1jAydgGAZfgNkzrvFqxy42HXngAK2+jmz80LPny826Z
	QDkmVbmdY6HzE22HM3IpaLOB1fPJjCq4GjEGkAVjpeDKcS9t8CYmvjhhrjOuU47qnuuUKkMpsxG
	KBFb6bU0ibNf5GVTU2mo4qAekzQgobeQmZZwJ
X-Google-Smtp-Source: AGHT+IHLyPYvXfGlogID2l+7RlQpARx4A0v7by2uAHcT47lAr9k/vY5ZKFTIohicwN5WPwQIYzSAZXmKPR4lkQUUe/s=
X-Received: by 2002:a17:907:7782:b0:a6f:56d2:8f0d with SMTP id
 a640c23a62f3a-a7245ba3ba8mr1149592966b.17.1719488065900; Thu, 27 Jun 2024
 04:34:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240626094232.2432891-1-xiujianfeng@huawei.com> <Zn0RGTZxrEUnI1KZ@tiehlicka>
In-Reply-To: <Zn0RGTZxrEUnI1KZ@tiehlicka>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 27 Jun 2024 04:33:50 -0700
Message-ID: <CAJD7tkZfkE6EyDAXetjSAKb7Zx2Mw-2naUNHRK=ihegZyZ2mHA@mail.gmail.com>
Subject: Re: [PATCH -next] mm: memcg: remove redundant seq_buf_has_overflowed()
To: Michal Hocko <mhocko@suse.com>
Cc: Xiu Jianfeng <xiujianfeng@huawei.com>, hannes@cmpxchg.org, roman.gushchin@linux.dev, 
	shakeel.butt@linux.dev, muchun.song@linux.dev, akpm@linux-foundation.org, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 12:13=E2=80=AFAM Michal Hocko <mhocko@suse.com> wro=
te:
>
> On Wed 26-06-24 09:42:32, Xiu Jianfeng wrote:
> > Both the end of memory_stat_format() and memcg_stat_format() will call
> > WARN_ON_ONCE(seq_buf_has_overflowed()). However, memory_stat_format()
> > is the only caller of memcg_stat_format(), when memcg is on the default
> > hierarchy, seq_buf_has_overflowed() will be executed twice, so remove
> > the reduntant one.
>
> Shouldn't we rather remove both? Are they giving us anything useful
> actually? Would a simpl pr_warn be sufficient? Afterall all we care
> about is to learn that we need to grow the buffer size because our stats
> do not fit anymore. It is not really important whether that is an OOM or
> cgroupfs interface path.

Is it possible for userspace readers to break if the stats are
incomplete? If yes, I think WARN_ON_ONCE() may be prompted to make it
easier to catch and fix before deployment.

