Return-Path: <cgroups+bounces-1251-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A5984145E
	for <lists+cgroups@lfdr.de>; Mon, 29 Jan 2024 21:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE7881F238A4
	for <lists+cgroups@lfdr.de>; Mon, 29 Jan 2024 20:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F13C76040;
	Mon, 29 Jan 2024 20:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gB3wk/P9"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBE343ACD
	for <cgroups@vger.kernel.org>; Mon, 29 Jan 2024 20:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706560407; cv=none; b=ohO20JsKRk7yIIIXX7MMre21m/slSO9Yjpr9xcSOq8fzow0x4N5oPdfyN24yeTWd7JSlu1g5zJZ8txuFhcKQseaP23HRtUgGEPQQnIDYrvxV7mLHzoUNLAfTwpCuxoTEoDXDQkToMfGTl84id8emGBpuOioUBgHENHgaCWu+9rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706560407; c=relaxed/simple;
	bh=pJ4yjaXnu/gO8IJm2MvBxAL0/BI+WbXyDMVS9W9Dbmo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KHBohnyQjJIT5qANjrjCQtXT5UfInDOkVePHL5buawa82MxNd5wsze5yNKy+0MYWe6Ki7j56NRlksBNG5IhAgNvbwzbeznHKrB9jiGva2UHeJfmO6AaZZ4Hbc1m6h9lO1oUfDmQqNIAaT/Mbe+J5x4ep5wCSFr2AkdO1ejmmjv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gB3wk/P9; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a36126e7459so13948866b.2
        for <cgroups@vger.kernel.org>; Mon, 29 Jan 2024 12:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706560404; x=1707165204; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pJ4yjaXnu/gO8IJm2MvBxAL0/BI+WbXyDMVS9W9Dbmo=;
        b=gB3wk/P9wEUtpU8znzFN2zXCvGauNRQfwSvBqOsn7B/pCMM9Y8W96Zhzf5j48YpLBT
         F1nQ+FmH5+7u+OBDoAZL4M8kkU29fmfO7RmtTaDzI6eIB40hKrRFd7xVMUB751FQstzd
         VAFfDXaj+WJbcXCnl4IJL8P1WzS4HrQhHjKgbfF/pffpltSpJ+ESoMbS6RLnFzEt2Fqg
         PEHxa2nv5q1BPqcyOOVnBbqWfm5To8nSQcLjI5wvA51NWFiOS3MTy9i0p0EVCsy/1hJY
         MpBsADfVwTvGRycABRBlhlR/hrJFGbPNmCHAywCjfcvNwu3b+Nguw8fsyq7/loqRL3gV
         zheA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706560404; x=1707165204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pJ4yjaXnu/gO8IJm2MvBxAL0/BI+WbXyDMVS9W9Dbmo=;
        b=Dwffoyu3RhBeXpKTQKxhLRNJrP46JenXCQMDptJLfl2C5JDLUrRy5wsxVMVkXyS57D
         +76ZHLDWUTg+Y/rWaZYdhVALNAiderPO2dtyUE4sX/zGbkDjMiycsgTPMyELiNFXH7Vj
         0KKYZJeKJvZJUt5FessfNhZNQ+YCigDbOFQrXcBjgJ55JR6jZfhbja7xeqpfP34TAOi0
         wAuqAXUNfuv3EG4JmSEJ/HvecbmKNf+tgIBkEjCa4pJzsOCh7OwWwKiA3FeFwMjMMxLz
         gQ470bxbtPtgSYgYRIzStzwkubhYHGS6UO9W+QzZc81oMTMnMcX6BKEBWTF9dXD0Xs5D
         mUHA==
X-Gm-Message-State: AOJu0Ywc3oEa167heBkyEiE2+evj0dst6hhMnHj78xPo0MfKAcjKN/gB
	SU36Hcw6wPCV/LW/56ESvhmJ6S47GFMQKck7wmCTaNfwPkAerj8hUJN3Zu7tTnANpf4bQvdjKSb
	f1f0fQcbbG4euFq8uV2uOYylO10tTeUXeXWhW
X-Google-Smtp-Source: AGHT+IE5Y49hmyAaED7dNazRHrPEe+9T806rwtrpIsfdyTaOO/aJp+aibuVHQOAWlsNuez82H+FriMLx0X+jXVB+EsA=
X-Received: by 2002:a17:906:4ac6:b0:a35:2c1c:52ef with SMTP id
 u6-20020a1709064ac600b00a352c1c52efmr4959461ejt.15.1706560403622; Mon, 29 Jan
 2024 12:33:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126211927.1171338-1-tjmercier@google.com>
In-Reply-To: <20240126211927.1171338-1-tjmercier@google.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 29 Jan 2024 12:32:45 -0800
Message-ID: <CAJD7tkZX7ib4PfOaEEW_+UNe5erdU2cPwVZWyFSD1A6OJtTt9Q@mail.gmail.com>
Subject: Re: [PATCH v2] mm: memcg: Don't periodically flush stats when memcg
 is disabled
To: "T.J. Mercier" <tjmercier@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeelb@google.com>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, android-mm@google.com, 
	Minchan Kim <minchan@google.com>, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 1:19=E2=80=AFPM T.J. Mercier <tjmercier@google.com>=
 wrote:
>
> The root memcg is onlined even when memcg is disabled. When it's onlined
> a 2 second periodic stat flush is started, but no stat flushing is
> required when memcg is disabled because there can be no child memcgs.
> Most calls to flush memcg stats are avoided when memcg is disabled as a
> result of the mem_cgroup_disabled check added in 7d7ef0a4686a
> ("mm: memcg: restore subtree stats flushing"), but the periodic flushing
> started in mem_cgroup_css_online is not. Skip it.
>
> Fixes: aa48e47e3906 ("memcg: infrastructure to flush memcg stats")
> Reported-by: Minchan Kim <minchan@google.com>
> Signed-off-by: T.J. Mercier <tjmercier@google.com>
> Acked-by: Shakeel Butt <shakeelb@google.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Yosry Ahmed <yosryahmed@google.com>

Thanks!

