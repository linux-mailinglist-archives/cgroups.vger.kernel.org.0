Return-Path: <cgroups+bounces-995-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD1381C40B
	for <lists+cgroups@lfdr.de>; Fri, 22 Dec 2023 05:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 204DE1F22E03
	for <lists+cgroups@lfdr.de>; Fri, 22 Dec 2023 04:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B51211C;
	Fri, 22 Dec 2023 04:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SHe3X716"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6401223D0
	for <cgroups@vger.kernel.org>; Fri, 22 Dec 2023 04:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d3e4637853so93455ad.0
        for <cgroups@vger.kernel.org>; Thu, 21 Dec 2023 20:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703219900; x=1703824700; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ww/u4bAQ2Y0urQrjCtL64yN7zVP/okgR7qn5HpVAFSs=;
        b=SHe3X7168OnlyIrHuaeAWPWYx9D3cIP0cRQd98+PrBIIpSQL7mWZPGZBcr0gua4URV
         I7nqu4PlzfYYG/+o5EzquNDFcHdq3CUWBkqdvPO7BW2f3ZfEGnumF5KosCWcRJhXhS6p
         Tah85LUiQy7K9vuKPH9UOkUxgCyLnU7OMu7SzSfiH4qC4EK9/QEMWicgnK+VEFSxDhxX
         viuyYr+Ak1yQHS2yeE67/+z+rwKt8ne/DSx4DXkcdet7Jb62SgltAx0aK+ZFIh7cjoqw
         Zp9LJue9hBMDw+AmQncYjXpPx6orgSptGgPpGQvjjcN37Ty+ntEmQeFM5pH0ias0xKEU
         kqhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703219900; x=1703824700;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ww/u4bAQ2Y0urQrjCtL64yN7zVP/okgR7qn5HpVAFSs=;
        b=YPlt3RI2UK6cYGHr/iXKlaniLjtpKH266durJKtw2/apJtd47dhkWzsOZlfFNwikfZ
         3ifEddHNReBiBCJmtRul+8l31+066JL9uWDlSmGDDq3QGdjY4gevjV271lMCSHtiY5v+
         lUkkUf00ak+K62anzRgegf1oBTpIj1+61NSz7ooKU+X1bRD+gDnexgRPehEyhgB/tWZm
         /+vicmx0Bfc2xb1ObBqYRe/226D7fz50J+Jv5xOhOS9joQLr6u5Yq6TD/5EyaziYLW/6
         P03/08JjiijHtoeUOZklk0lR7kron1rvgyn3h6XW4HAacTcsM8EsQGfQCPa+lw4+1lkc
         Elnw==
X-Gm-Message-State: AOJu0YyOEzEiISCKqLssXLyWfvNSbP4qJBr1pNydbfs93iQe6ILivOYl
	BQPi9jEHgMqYCkfybKhQs7zH9IdQxt9x
X-Google-Smtp-Source: AGHT+IHBjK0SqtOtb+hamlc4XkwVzg2/DpYv4vz/gouGDTKu655TryYuGDXIKkyuDfeNG5JgbcxVyQ==
X-Received: by 2002:a17:903:41cd:b0:1d4:f4:bd18 with SMTP id u13-20020a17090341cd00b001d400f4bd18mr94730ple.20.1703219899500;
        Thu, 21 Dec 2023 20:38:19 -0800 (PST)
Received: from [2620:0:1008:15:184:1476:510:6ea1] ([2620:0:1008:15:184:1476:510:6ea1])
        by smtp.gmail.com with ESMTPSA id jw13-20020a056a00928d00b006d977f70cd5sm1772209pfb.23.2023.12.21.20.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 20:38:18 -0800 (PST)
Date: Thu, 21 Dec 2023 20:38:18 -0800 (PST)
From: David Rientjes <rientjes@google.com>
To: Dan Schatzberg <schatzberg.dan@gmail.com>
cc: Johannes Weiner <hannes@cmpxchg.org>, 
    Roman Gushchin <roman.gushchin@linux.dev>, 
    Yosry Ahmed <yosryahmed@google.com>, Huan Yang <link@vivo.com>, 
    linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org, 
    Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>, 
    Jonathan Corbet <corbet@lwn.net>, Michal Hocko <mhocko@kernel.org>, 
    Shakeel Butt <shakeelb@google.com>, Muchun Song <muchun.song@linux.dev>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    Kefeng Wang <wangkefeng.wang@huawei.com>, SeongJae Park <sj@kernel.org>, 
    "Vishal Moola (Oracle)" <vishal.moola@gmail.com>, 
    Nhat Pham <nphamcs@gmail.com>, Yue Zhao <findns94@gmail.com>
Subject: Re: [PATCH v5 1/2] mm: add defines for min/max swappiness
In-Reply-To: <20231220152653.3273778-2-schatzberg.dan@gmail.com>
Message-ID: <d8a0ce24-7fa3-6bba-c900-4a9e4675e5ea@google.com>
References: <20231220152653.3273778-1-schatzberg.dan@gmail.com> <20231220152653.3273778-2-schatzberg.dan@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 20 Dec 2023, Dan Schatzberg wrote:

> We use the constants 0 and 200 in a few places in the mm code when
> referring to the min and max swappiness. This patch adds MIN_SWAPPINESS
> and MAX_SWAPPINESS #defines to improve clarity. There are no functional
> changes.
> 
> Signed-off-by: Dan Schatzberg <schatzberg.dan@gmail.com>

Acked-by: David Rientjes <rientjes@google.com>

