Return-Path: <cgroups+bounces-11237-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 957EBC12C3D
	for <lists+cgroups@lfdr.de>; Tue, 28 Oct 2025 04:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0FAE1887DA2
	for <lists+cgroups@lfdr.de>; Tue, 28 Oct 2025 03:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75ABB38DD8;
	Tue, 28 Oct 2025 03:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mr0pPjTK"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CB719E968
	for <cgroups@vger.kernel.org>; Tue, 28 Oct 2025 03:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761622283; cv=none; b=fJNVxMl6uPUUtXi5o+h/X2B1eS6QmBs4Yf50tSFGB7Nb9cabGxhWi9ocohOGam/KMjjsbfiGYbqZvk+wSebEt1jAg6a3I8ZAGgMENJQr2rFxeBxf3hpkFFAuOXaB4vyCBJY5McWLXMoo3y8GOCQkIth4HV0SHVwNR3clTnQFMvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761622283; c=relaxed/simple;
	bh=/WJvY11yZe5DNuh0SmLl84KhyrfL2n7Y6FVCkvFsiMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Njll4cR5Ue49qXwGWEx2qL1Y//HJx3kEqjjn19hi/Y3ChNMdsy8ULIP/RbEo6Th1iA1kRiOOuJIfpYo7pqoyqG2dZpH+23bG0kq8JbWufIXgVywztJXO2+JiYwlFWhKPvd+BDt7vGB3mLipKdNPW2m8iGisEedLI7xkt34zOfeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mr0pPjTK; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-292fd52d527so55057815ad.2
        for <cgroups@vger.kernel.org>; Mon, 27 Oct 2025 20:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1761622281; x=1762227081; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/WJvY11yZe5DNuh0SmLl84KhyrfL2n7Y6FVCkvFsiMg=;
        b=mr0pPjTKpqmKglIs4NbjktC22qUtAQDnv5F7niBoXR9XL6cq0j8BGWDf1xYaQ4GzNp
         ZqMtTTTmHGkW8/iZTQR2hgm67vDtkBS9v//LIu7KXOPI1zV+hB8mEHSdopPUyvAcVWZo
         M/lxNmOSp4JvdjK/7ouP+R64DZCKANW/dXJI8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761622281; x=1762227081;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/WJvY11yZe5DNuh0SmLl84KhyrfL2n7Y6FVCkvFsiMg=;
        b=ofUarTBx7+2a+0zy/EPvXVZsj2yKZl3DkCZ8mwYoNZpyPWECbdcPy8GKUEKI1zWkwL
         CCt3gu9bGlxWGBkOYqvNokx7GZ0mreSLmZekrvI+EA6ZqI8AqcdoAxao9JG04meHuHSK
         p+LHmFz5C3+6nKVBF/kpHZhUDGXnE/5LMg/b4UeIenEymP7yAZE0s2UOSm5E81vgfjwb
         Wv/s9vsKP2jhmVoDhSQchM7yJ7Ol4OQOw2cqc2d9RqxJO94uAhPrzlCQOUt47OAYyfiq
         KzRjMV99sZwCd7YXpalpswpjzZh8XO1hP8bsumZgQOCgnCYMC80o7FepdtYmirQT0cXS
         S0Sw==
X-Forwarded-Encrypted: i=1; AJvYcCUHZ03K6kLshWWcO8GHWsKg2aJFY3R1zuVPZAfY7PTa7P19XinxAdiV3BbYuGr+5USb13SowFFL@vger.kernel.org
X-Gm-Message-State: AOJu0YyBwwKP0vypat5XLYT9njV9Z4vWRmRa7YeOc6xGJEHRRSa7T8mr
	Ap9FGWk4xo+n85IcPmQhA+DIV0fqblb/0qwy5XIix2Z7oZ8qvodP9wubbTiZaVr7Kw==
X-Gm-Gg: ASbGncureHdtGSc9nXODUmQxjhcqcmucAXTvOoPKTgGVPNPsMqaTdxQ9OfHSoFNdCsS
	wuKNjFzWPeS/+f3rey2Sl3MNApNjRSHobEqGd4Eww0q4ZSNMMwYk+Fh0S4Y3XeMnyiFWZ7wuTV+
	bd0PVIczgdXP9ERToSmtOukaaXIO2VUUzHEZ8MWri3E5wqGtJzXkoguIbJnkpiw/UzauV1Y14ak
	5qkZvJRXLHDGY2HQH/KBbhL3C9+rjys2vIF1Uh8G0/CHx9EBxyHwLmJ42eCt0pBqfSND2WpQoqO
	N38JZCtKSfLE+un9yNtDVa2sEPJQCaP030MW9Gk6YxNea+1iWfJz+JoqClOtz8zLhFoaJNG4UML
	T2lD9NGdzee81ON2BaFq5DQHbxW9bFPxI575MAcVcVdzKg8cHsz9fvpRalpje/lViSPXFwTj9QV
	DbIyE7
X-Google-Smtp-Source: AGHT+IG4vfR0LE0WG8LCYJmEN31gkl7hCsYmhmgxpsNHn1XBOsYb/cbkA/Iv5cZPqQ3IQLRXV2PyoQ==
X-Received: by 2002:a17:902:dacd:b0:290:af0e:1183 with SMTP id d9443c01a7336-294cb6746c8mr22090685ad.51.1761622280960;
        Mon, 27 Oct 2025 20:31:20 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:2c65:61c5:8aa8:4b47])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf4a53sm100342125ad.6.2025.10.27.20.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 20:31:20 -0700 (PDT)
Date: Tue, 28 Oct 2025 12:31:12 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Nhat Pham <nphamcs@gmail.com>
Cc: jinji zhong <jinji.z.zhong@gmail.com>, minchan@kernel.org, 
	senozhatsky@chromium.org, philipp.reisner@linbit.com, lars.ellenberg@linbit.com, 
	christoph.boehmwalder@linbit.com, corbet@lwn.net, tj@kernel.org, hannes@cmpxchg.org, 
	mkoutny@suse.com, axboe@kernel.dk, mhocko@kernel.org, roman.gushchin@linux.dev, 
	shakeel.butt@linux.dev, akpm@linux-foundation.org, terrelln@fb.com, dsterba@suse.com, 
	muchun.song@linux.dev, linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com, 
	linux-doc@vger.kernel.org, cgroups@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-mm@kvack.org, zhongjinji@honor.com, liulu.liu@honor.com, feng.han@honor.com, 
	YoungJun Park <youngjun.park@lge.com>
Subject: Re: [RFC PATCH 0/3] Introduce per-cgroup compression priority
Message-ID: <4tqwviq3dmz2536eahhxxw6nj24tbg5am57yybgmmwcf4vtwdn@s7f4n2yfszbe>
References: <cover.1761439133.git.jinji.z.zhong@gmail.com>
 <CAKEwX=MqsyWki+DfzePb3SwXWTZ_2tcDV-ONBQu62=otnBXCiQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKEwX=MqsyWki+DfzePb3SwXWTZ_2tcDV-ONBQu62=otnBXCiQ@mail.gmail.com>

On (25/10/27 15:46), Nhat Pham wrote:
> Another alternative is to make this zram-internal, i.e add knobs to
> zram sysfs, or extend the recomp parameter. I'll defer to zram
> maintainers and users to comment on this :)

I think this cannot be purely zram-internal, we'd need some "hint"
from upper layers which process/cgroup each particular page belongs
to and what's its priority.

