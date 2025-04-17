Return-Path: <cgroups+bounces-7616-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6930AA9204D
	for <lists+cgroups@lfdr.de>; Thu, 17 Apr 2025 16:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D03063BDD49
	for <lists+cgroups@lfdr.de>; Thu, 17 Apr 2025 14:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6252528EC;
	Thu, 17 Apr 2025 14:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="2hvLYvtj"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C775B1C5D61
	for <cgroups@vger.kernel.org>; Thu, 17 Apr 2025 14:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744901648; cv=none; b=WZp+Ewj5pNrdm8Y3TRTUjD5sS73QTocSLkxqjmUj8+4eKqq5qd+4glSFYjG8TEIbQ6//Don1mSqkUY5f8R6dqmM9wblIrsqpRUpw6OmZ2HnhQIlmbKB++Ghxm+NEyQtpz7U3mIozZSRgjYK7mNrEI7rRzO16dn7xZTuJ7U+JzG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744901648; c=relaxed/simple;
	bh=y6Qdwi2fYnYO3ZDvo+FJR12z46j08PUlYp0fEVJVKJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F1yarPYy+DMUf3SmjitqoJv6I2wzk7rTTUVaMc+ZDRtvIWQM+IH8GZr61YkXHRHeAXvNwafIpswMI6UOyrAJnIJPvDsOHZKAx6E10JvbMtj4Y8A0jzY6YsmJUfo/H5c+GtbXIutgDxo9UXY6+wKUobyAmMk0r3dkjWX8eWS+WFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=2hvLYvtj; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4775ce8a4b0so13541301cf.1
        for <cgroups@vger.kernel.org>; Thu, 17 Apr 2025 07:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1744901645; x=1745506445; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=afIL/UiXUlFmHWbCDZq4bWploUK8mvFskJm951QNrQ8=;
        b=2hvLYvtjOBv8vXQJA0SPbdipUsOVKhtjTdU2m81yKA5oA9ku8/1Bfq370WyAHMbEFJ
         qo5h1hcx5CphXaXSumHjM03DM9JuoHU2Sil5cgNIgrQJf+l09ZKqONIp9EEqm0mBnr2g
         DZvHBmInvN5FXEy6UuDvsGR/w+JS/fpUdCcGmqi0ZGDXPOaHuN0yf7fUurN872jpm5bp
         hGi3KQOU7vlZk5cG1ZrbLP0ipJaLVyRR+b5aUlDb4ALOvQRzewFMAb5GLhUpSW1hEVTn
         hiaGl4YQ6NbCYjdgsZB9JqInnwMA1OExexMglt6xYn/Huwd5v1ESkQNoj/kizH8nMGXH
         80qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744901645; x=1745506445;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=afIL/UiXUlFmHWbCDZq4bWploUK8mvFskJm951QNrQ8=;
        b=EeQPUV/K9QBF53ZReJLGgvgbZb98xb3aPCkdZIbloXqTS5L+DQTWBTL2GW4Yvl/JgR
         oy2ZcJJKQEb1bhf4O6CaAu0ZRsUUOgTUHWKcQjfIe3ElCXFL3wG1X6lWh7au1Wdf+Wck
         hDU5Edd66Da179LSubHoVqPKAxLwuUuHn5thsmUNUGfbXcg6sTxzojnRTKUAfYtoIAyw
         QBY8DnhjTMedTWZxPUrSTP7Ku0XlkdrTXKde6FQ4CgDEg1DvirsUPEGFsKijeo6+fjVn
         nliHQXCVyZC7K9YjELGdkTWSy8GBr7ihSYb7dQDkVyv4Knp2wYPe5bAUqdRw8rQXkByM
         yUyg==
X-Forwarded-Encrypted: i=1; AJvYcCWkUm09vn4FU03y/SyN2AWFf/dIdXLxVqgZjOySMqHTddej1fXiZIEKW8dNHFErvBKw8IeDnNTk@vger.kernel.org
X-Gm-Message-State: AOJu0YzcILHsboSQ2fnDkVRaFXpp5pWFgBfZWS6AI24dE67P7H9BoCRc
	I9KX20t6NUr3cya4lRjLVEA++MCUuX5Do3ExmOonc5XfKhsIYU7Iu65Azmyep68=
X-Gm-Gg: ASbGnctNZgqlmPRiwWvBNjksG3fnf5iuP1HoERlCEUcZpiQVQfkkx5Tq26jLDUWV2kJ
	gm0e4MCm603WHkEF4s6WVedh48upbltjSJ5vm0tC+tID2F+ORKX3GR+9DY1xxVTXbvT4RdYDv/P
	34Nnml+lcw45Hf2y9+JZKd51IjwPzlV6BRTvl7iWFiI9zRx9AGuAAZgtORhlJIFZ8Mr1XFXB/co
	kWerqGjSmrDZzckD8DBj7mQC560WlId2Ev07mzK9tNrzYLwxYDF+adEIbyhsmEC6W9NRatFC87T
	CgLmUcSzvTdNK6Gr0ZGSGrOaE2w58vxWcjzhy1g=
X-Google-Smtp-Source: AGHT+IEU+XimTfphBnwnpBz5KDBLi0B/ZA6zQlSXL2AwZKrTMTjVWTzfNzzazFeEPgvFvBFjvH48xw==
X-Received: by 2002:ac8:6711:0:b0:476:bb72:f429 with SMTP id d75a77b69052e-47ad8119d76mr76603021cf.42.1744901645475;
        Thu, 17 Apr 2025 07:54:05 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:365a:60ff:fe62:ff29])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-47ae9c3299esm49721cf.17.2025.04.17.07.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 07:54:04 -0700 (PDT)
Date: Thu, 17 Apr 2025 10:54:03 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Muchun Song <songmuchun@bytedance.com>
Cc: mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, akpm@linux-foundation.org,
	david@fromorbit.com, zhengqi.arch@bytedance.com,
	yosry.ahmed@linux.dev, nphamcs@gmail.com, chengming.zhou@linux.dev,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, hamzamahfooz@linux.microsoft.com,
	apais@linux.microsoft.com
Subject: Re: [PATCH RFC 05/28] mm: thp: replace folio_memcg() with
 folio_memcg_charged()
Message-ID: <20250417145403.GH780688@cmpxchg.org>
References: <20250415024532.26632-1-songmuchun@bytedance.com>
 <20250415024532.26632-6-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415024532.26632-6-songmuchun@bytedance.com>

On Tue, Apr 15, 2025 at 10:45:09AM +0800, Muchun Song wrote:
> folio_memcg_charged() is intended for use when the user is unconcerned
> about the returned memcg pointer. It is more efficient than folio_memcg().
> Therefore, replace folio_memcg() with folio_memcg_charged().
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

