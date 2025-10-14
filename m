Return-Path: <cgroups+bounces-10748-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC3CBDB4BC
	for <lists+cgroups@lfdr.de>; Tue, 14 Oct 2025 22:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6638420D32
	for <lists+cgroups@lfdr.de>; Tue, 14 Oct 2025 20:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC75B306B38;
	Tue, 14 Oct 2025 20:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LS3UfEh/"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31287279DC0
	for <cgroups@vger.kernel.org>; Tue, 14 Oct 2025 20:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760474571; cv=none; b=PgHu42dS5GoLGpxydesbHu9GIo6PGiAF4MKO+XtTMPCmh7xjMx7UMup/sC6aBV8kvtCPmSFvU55ALupDuhGzU4C0oPETEDtNSNpX7OTBp27H4XIWhDW8DdyXXHtCrL3HZwK28E/BXWCP2dn749CuAXW41LFHDazp4RwSJTWoMo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760474571; c=relaxed/simple;
	bh=X5Wkc3y5XxtvExrMi62ryXeDIWnD8jimxbR2ahS/QXM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c0hQyVM1q+KoB1FcSI+U9DfalkH2i/LJ2tIcbjLQmTGZ/u/eTD4oTnbxIrafdQnjawIWu8tM+9xXO6J3rSNf+q4vEqQ2ZRv8jvPqT7wagPKy88oT/A84FQhgeUQj4959KuGjI8BakUC9/NOwgLmU1Yncc49uFsrGxhxaQdQ3wxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LS3UfEh/; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-54aa5f70513so1491767e0c.2
        for <cgroups@vger.kernel.org>; Tue, 14 Oct 2025 13:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760474569; x=1761079369; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uockn1DmFA8ZAnlkgMjydfkJvdgnzoAnn5KXsE8LaOc=;
        b=LS3UfEh/IXL+QNpzFA/vbBJN7AiGYtMTk/HrMRPAb+DLvF0e7bzNJ41wpo7ULHql5Q
         g+eU/4egfAPwVoh6+pyrM2v3F3zAy4BNUuVLKizwpzOwTdJbENZhQWmuP3auRUwbqEvk
         XWAUP/pzuyKzg3MpnzWu26hcbY3kZy/ih0gGZYdJ0pAUh2ZQA0KGn1u5OEFBmADd0oKz
         QbjnjhpP5oQaF/LmNkpFvbzvQcABo23c01zv09vWAz4WJzofqfL+dJipQjWzV7NT+vF3
         1nLXbijPnEHCzfSF8VfCGBcRaEdvJ3xByZUwIPoeQKZ5cJezZ9HNVoDo2494cOcn9u6D
         zDMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760474569; x=1761079369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uockn1DmFA8ZAnlkgMjydfkJvdgnzoAnn5KXsE8LaOc=;
        b=SVwGuCtWqdSoyXGGBU4g4aQuAoHygGpyXXPRoOtIOeC/JLDS5LsClEJhgXQk9WVG/2
         BiZgBZkYOKRIKja7jX8vAxKWv1KYt1/veY3bgIFhEg/JndIXYRd5p2gWPkNf19sgH/D7
         AeNaLJ+XyZTNPdoAXPTcaFDk39WPNB2LZv4+bZCLaAWV7VFIpTcn+BbWJkWBVXZER4oe
         g8VVeQTvLyp/Cbo4sSZt+NP0YVoDOr+W9Dh7r6nydpIzzXQGz23lgT6gLwXon664R4wP
         K2AvgDj4cVnglSmt0FKCdRMe1Z3kSQCXH9EpJeGr2ayQNV+rztoEkDk26ICQ5SMd9oRX
         atpg==
X-Forwarded-Encrypted: i=1; AJvYcCWMd5WYpzjqza1sahhUuiwEJPoLQRN1VC920i8hlgjRpXyffK1mVu+jegD8FoNJh2IWu3nP3ht8@vger.kernel.org
X-Gm-Message-State: AOJu0YyujfEaJm4sg69iUw93gsuT8sUsmgly+AcfWKR4CSph8Qb1VKd8
	JGzvrcGerr75GQ4u8UNkPERp+mXCrv03RvChkMx7whfdV7SVP0NyR3SN3eiapw5EctlBoSTjZRC
	5f0yPsyDhO2vIToTBpLoj/qseWJH+R8szD9xH
X-Gm-Gg: ASbGnctHrWwcizrGUL7jI8OxAFDEDkdH8ZerO8l0oftu3Z2+z4ftJ+1VVo80Thl1cIG
	A5ZiflL44UVgpCQk2/7ZhIR6dH0U+6EI9hS1EZrbSy7ws6fO25EHSSt1BbHe79NPEeQAQUZlKuy
	c9fXivYQKz9SWgfSBju27DGUfHpbItVC01Stu+HQ9VOO046iIkpHT8rswNKnwzJkrptl3I/aVJK
	x8g2XnEPZi499oF15OBWNOCcrn0tnBiYuZkvvrYmxNb2DuC9UoVgocvXEtxJV5WqO4f
X-Google-Smtp-Source: AGHT+IEnsr51HAAycnl5TJWtojVCtdeDbTLi5HrOIWN/EM0aj7tT4qSjlzWUR1EkpvLjmCuZMzthdHU4KSmPdfVDcS0=
X-Received: by 2002:a05:6102:1516:b0:5d5:f6ae:38d5 with SMTP id
 ada2fe7eead31-5d5f6ae3b8bmr6904190137.42.1760474568697; Tue, 14 Oct 2025
 13:42:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909065349.574894-1-liulei.rjpt@vivo.com> <CAMgjq7Ca6zOozixPot3j5FP_6A8h=DFc7yjHKp2Lg+qu7gNwMA@mail.gmail.com>
 <CAGsJ_4xiTteQECtUNBo+eC9uu8R3CgVT2rpvGCGdFqc3psSnWQ@mail.gmail.com> <fe38e328-5e64-44b2-9e62-f764c4b307bd@vivo.com>
In-Reply-To: <fe38e328-5e64-44b2-9e62-f764c4b307bd@vivo.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 15 Oct 2025 04:42:36 +0800
X-Gm-Features: AS18NWDkw8474qAcz1fNrydjfJ00yxfFAbDaJ_VQwKfXsjjmOArAdgWL5vP-vUY
Message-ID: <CAGsJ_4xdvGjZ9YZnc0mk3bDfPCwxdpF_5bhcbca09j=-KBM9Mg@mail.gmail.com>
Subject: Re: [PATCH v0 0/2] mm: swap: Gather swap entries and batch async release
To: Lei Liu <liulei.rjpt@vivo.com>
Cc: Kairui Song <ryncsn@gmail.com>, Michal Hocko <mhocko@suse.com>, 
	David Rientjes <rientjes@google.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, David Hildenbrand <david@redhat.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Brendan Jackman <jackmanb@google.com>, Zi Yan <ziy@nvidia.com>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Chen Yu <yu.c.chen@intel.com>, 
	Hao Jia <jiahao1@lixiang.com>, "Kirill A. Shutemov" <kas@kernel.org>, 
	Usama Arif <usamaarif642@gmail.com>, Oleg Nesterov <oleg@redhat.com>, 
	Christian Brauner <brauner@kernel.org>, Mateusz Guzik <mjguzik@gmail.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Fushuai Wang <wangfushuai@baidu.com>, 
	"open list:MEMORY MANAGEMENT - OOM KILLER" <linux-mm@kvack.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>
> Hi Barry
>
> Thank you for your question. Here is the issue we are encountering:
>
> Flame graph of time distribution for douyin process exit (~400MB swapped)=
:
> do_notify_resume         3.89%
> get_signal               3.89%
> do_signal_exit           3.88%
> do_exit                  3.88%
> mmput                    3.22%
> exit_mmap                3.22%
> unmap_vmas               3.08%
> unmap_page_range         3.07%
> free_swap_and_cache_nr   1.31%****
> swap_entry_range_free    1.17%****
> zram_slot_free_notify    1.11%****

If 1.11/1.31, or 85% of free_swap_and_cache_nr, comes from zram_free,
it=E2=80=99s clear that the swap/mm core is not the right place for this op=
timization.

As it involves too much complexity=E2=80=94for example, synchronization bet=
ween
swapoff and your new threads.

> zram_free_hw_entry_dc    0.43%
> free_zspage[zsmalloc]    0.09%

Thanks
Barry

