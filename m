Return-Path: <cgroups+bounces-7623-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90725A92B73
	for <lists+cgroups@lfdr.de>; Thu, 17 Apr 2025 21:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A680445F4A
	for <lists+cgroups@lfdr.de>; Thu, 17 Apr 2025 19:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344E61DE2AD;
	Thu, 17 Apr 2025 19:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="Pq/Xt1zU"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FDA13E41A
	for <cgroups@vger.kernel.org>; Thu, 17 Apr 2025 19:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744916656; cv=none; b=uSlUw/g+zESa2gdKRAPk4JmGPrElVMYLNCiN8/Gk9sNMrDdasWDxlDP+jikHUWceLJ8M11ZDkgBq5G+F9qpQ0wHmxS4hYyAcRpWovREmo4BA4b5Lufqe/Vicn+B+0UAxq2zucAHuz2FkHZht/bdg1XgvEIFcr/e/eDRPfEedK5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744916656; c=relaxed/simple;
	bh=cJI7eEInfWBGFTlEkOfJ7m4/J8g226i7EkrN81AXu4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KzneB8uaf40EAIBekC6KYMV9WFcGXT3BRRWbI8HdI6jf9yi1VdN2XC4wIHXU2rzsvpPX+WZchVxLqDmCzobtedKtU0phwBhRmjlod/pr+zamS3vjDispSymLIR/SsjzJZIuvGBGnFGkoGOCy1F1vd0x9dq1bw7bc1+ewA/0Cb+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=Pq/Xt1zU; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6f2c45ecaffso311876d6.2
        for <cgroups@vger.kernel.org>; Thu, 17 Apr 2025 12:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1744916652; x=1745521452; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cJI7eEInfWBGFTlEkOfJ7m4/J8g226i7EkrN81AXu4g=;
        b=Pq/Xt1zUbxoFKJHJY+IC0utuSVePeWNx6ZDP/rYyb0PWFmDMtRC7YxAP0jD9rrDFsq
         /QkvGWeVxGKOUvoZXTkYtRnML20Ak2Z6CSlDvmCW/t/jgaLj0uqq28QFWIfCMan/WPPp
         hVz2ONO1lewuWs/97xm+dZS6dQkILnbq77PaMrGAVTgL87bB8lNQ8MYIQnnBUjHqTBzF
         P0frmLF7D6h6eK3VWSWXd/yoNYaEtCBgSlN6Mkd2hAHOLqDllhZ6W+2JKUq/oj8758hg
         TBu1Vp5S066TaroBp8WhVY8fgP/BCHNbObvtqNjlIvPSqL7IH8HqknKPx/y6fRFWx983
         f/Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744916652; x=1745521452;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cJI7eEInfWBGFTlEkOfJ7m4/J8g226i7EkrN81AXu4g=;
        b=Z4Cn2SGnQxuEzOB4Z+Zcc0kh+Uqz3H3OyUA74PzsDYGm8jNW22v8MSsDmAcPFHznCM
         dTwYjD9rBOeHdm3wC7C6dNI/PA053NmrhNaaLwh7+gJBMBxQZhoARhsFBkG8wDg/xk6n
         xueLOgDRmsuMUrpY3D0Lgd/nw0UjEL2YCqxmT+y+4ImMZdLB9bHei/d0+vwg9mZHd9ys
         n7SOmWx5iPwtFpq9fAqZRyhGzgKnJy92tqKKFNVuIGRsnLLCQ+ofsL+VIbqcsKOp/PYt
         p2KuFb8C1wrhEFjb+ziBW+ZC1oAWmg48N4+QxpsjcvDMnm4dL2r3qPNfDwjLd+WH97EK
         My3w==
X-Forwarded-Encrypted: i=1; AJvYcCVQ+MF+TH2Ib/oAejkKXqyescLB/WHL2AK9De9W47eHsR67+NUEkvpE9SWMJj6/KO7Qf/xwzY5V@vger.kernel.org
X-Gm-Message-State: AOJu0YyvPc8HEq+3bXbBsKWjsWSNGZMDv62W3kRPyCdGUMUrcI5ghZGi
	msjL26lOaPiiSCVbZfUy3zfeNaphOEi/8oVumqbWyyqoHXbCg2UiqLVrFtFlnqY=
X-Gm-Gg: ASbGnctdYMaRFJg+OhR1C/+RYL/Wdj6srDtxvFhTjcjJMpFK/Z2tDlopHPCbY0053O9
	soLF5rUdRPilqH8ZoWcnYpiOSX+yxKCSehuiBGGhX5vexB+X71jxUPylJN2v0Z1T+FeOfNuySOT
	Q+XdVIZXXluLGOcl2ilALZ4vmJor/oHNgaI1imZ1+7iKwXB/6TWGKgsSgVTC/tUmuiV737aWpIO
	V+5wI1K+9IPfTm/APQco8O/najAWKu9zzNLhRi2fTifjsvShXpCjSp9JojHmJCqRAzJUq8djCNL
	uqmzCYwfupLAV24sIXNJItISPE43xZ86Fh2TzcM=
X-Google-Smtp-Source: AGHT+IHo1/OeUWXRZqjMpfiF2mmdicEw+dSXUeYDfk/KKmjmWEdY5WOrK1z4XGfQVAL63dV519TDfw==
X-Received: by 2002:a05:6214:2aae:b0:6e8:fee2:aae6 with SMTP id 6a1803df08f44-6f2c46bd7ccmr1552706d6.41.1744916652188;
        Thu, 17 Apr 2025 12:04:12 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:cbb0:8ad0:a429:60f5])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f2c2af5b28sm2348286d6.10.2025.04.17.12.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 12:04:11 -0700 (PDT)
Date: Thu, 17 Apr 2025 15:04:04 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Kairui Song <ryncsn@gmail.com>
Cc: Muchun Song <muchun.song@linux.dev>,
	Muchun Song <songmuchun@bytedance.com>, mhocko@kernel.org,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	akpm@linux-foundation.org, david@fromorbit.com,
	zhengqi.arch@bytedance.com, yosry.ahmed@linux.dev,
	nphamcs@gmail.com, chengming.zhou@linux.dev,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, hamzamahfooz@linux.microsoft.com,
	apais@linux.microsoft.com, yuzhao@google.com
Subject: Re: [PATCH RFC 00/28] Eliminate Dying Memory Cgroup
Message-ID: <20250417190404.GA205562@cmpxchg.org>
References: <20250415024532.26632-1-songmuchun@bytedance.com>
 <CAMgjq7BAfh-op06++LEgXf4UM47Pp1=ER+1WvdOn3-6YYQHYmw@mail.gmail.com>
 <F9BDE357-C7DA-4860-A167-201B01A274FC@linux.dev>
 <CAMgjq7D+GXce=nTzxPyR+t6YZSLWf-8eByo+0NpprQf61gXjPA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMgjq7D+GXce=nTzxPyR+t6YZSLWf-8eByo+0NpprQf61gXjPA@mail.gmail.com>

On Fri, Apr 18, 2025 at 02:22:12AM +0800, Kairui Song wrote:
> On Tue, Apr 15, 2025 at 4:02 PM Muchun Song <muchun.song@linux.dev> wrote:
> We currently have some workloads running with `nokmem` due to objcg
> performance issues. I know there are efforts to improve them, but so
> far it's still not painless to have. So I'm a bit worried about
> this...

That's presumably more about the size and corresponding rate of slab
allocations. The objcg path has the same percpu cached charging and
uncharging, direct task pointer etc. as the direct memcg path. Not
sure the additional objcg->memcg indirection in the slowpath would be
noticable among hierarchical page counter atomics...

> This is a problem indeed, but isn't reparenting a rather rare
> operation? So a slow async worker might be just fine?

That could be millions of pages that need updating. rmdir is no fast
path, but that's a lot of work compared to flipping objcg->memcg and
doing a list_splice().

We used to do this in the past, if you check the git history. That's
not a desirable direction to take again, certainly not without hard
data showing that objcg is an absolute no go.

