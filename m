Return-Path: <cgroups+bounces-12446-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F57DCC9997
	for <lists+cgroups@lfdr.de>; Wed, 17 Dec 2025 22:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6DD81301D674
	for <lists+cgroups@lfdr.de>; Wed, 17 Dec 2025 21:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65B830CD9E;
	Wed, 17 Dec 2025 21:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="Wzti7MCH"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A178286400
	for <cgroups@vger.kernel.org>; Wed, 17 Dec 2025 21:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766006899; cv=none; b=REDGS6PB/kbAcz67CkneJLgFcl5LvwNlxKfgOKMgyNbJ9mfqyXhJO5Byq7jNsM8uSujPl5Mt0++wjAUsRby9ULb2BAq9X/2XtURF2nwmxE+9dLSG0VlBeEZwFUmyVceoaPYbW+ZVi2POlqCLh5dxz3zLMSdhGyL+RD/dex7KEYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766006899; c=relaxed/simple;
	bh=Xyu8zUJSd+HIGqmgafU7morYh3mmKD9Qgz3LcoaZziE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QAZRCO8tH34SVK3EvWU+Q3keycFc0RuOdyhSg+8/340KmDXSs6BhTHERYvhBpZ50hkXngWX34+oCb+Hbw/aI2YWkl0EnfOBNYJTDyX/Ap0pqHdeHQnKl0XHlv6mGxyK9xEPIIOACzpbGMktzQHXZd3cUOf6QUWdCUITCgNUA2gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=Wzti7MCH; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4ed9c19248bso55890761cf.1
        for <cgroups@vger.kernel.org>; Wed, 17 Dec 2025 13:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1766006896; x=1766611696; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kd2WcobjQdnwsk8zN1EwNDl7xZ4zvUhbh6TmBYqAKCA=;
        b=Wzti7MCHNMT5DWTyyV12gRAZC61Tr9UVtOXJ6v6yjezlEIfzY+tBiqRsgLKN19Q0Dc
         cWxcioZzaTJUHk+kEq8E9Zez7IYSXONQpPcqB1aInUe85ykEvCLZae7HXvlwBfYmOyil
         sZ21fsxFm8AFYHYluG9MWxRZ5bkEgJ8KBzrazuQ1tzkg8eRP94+DyKI8Cgtu8d8NVSdP
         +NrIoWeUwzKZC4+zmtAf8sElKagR8B4sc0R6JNrJYkEKMl3qSV2sZPKGojlLFyj/mWms
         sbhNPKs05FybfLy6Mh9n85TifeZDNw8LkIs5g9GxO6GUW8AzFamSEhJVNw7NnB8l3Q+R
         ShIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766006896; x=1766611696;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kd2WcobjQdnwsk8zN1EwNDl7xZ4zvUhbh6TmBYqAKCA=;
        b=p6cNGeKdPlzQuarHrZCO+B4pSUdmdsoYjbXfur9BhHAkdTt4EFyGQas+VuxjJYv8Vv
         1XNFsixXh8L/15SJyrHGOtOS88bZcn27sDvKJojs6itfQE2VCH7AO6XwYk/cL0xTre8c
         t7xv7CWjK1fWyJegv93zofiODlPBF1NNVFRuYdttlt4QoCNxSKL+nC+Bs4elAzuclwoV
         JEVo8Daps6j9vmbk6shwYLSXbLcJj3yT/dK4x05xVWjp6TpyZ6dMQjNOFmOd+BlOiQCw
         Dfk0bxXjUhqzGFfzY6Mc8zVWn2x6Z78qnbTCFxTA25rL2eYDJE1tqhuyD+rYi5EfUnII
         vMuw==
X-Forwarded-Encrypted: i=1; AJvYcCWgJyqIDwDSpmoVvrhKFY4Yb81LTNr7SvNwI0BsPo9Xw2CZiYsesEZdMF0vgCXPiK8u11+f7F9y@vger.kernel.org
X-Gm-Message-State: AOJu0YwQWNyw2rtmoQayqcwSq8XD37cK9q36NIpMj7tTHh4Bnwl3waNd
	myqWf+rxgrDAcAnJgGf2hkRC561b0Ml2Q79Pl3H/RmWlfnyv4AkDWxGhSC5wtjP1WMY=
X-Gm-Gg: AY/fxX6zQVy0GZA5sYQ7LDznrrZuv217B9wQpc/9LNt/XW5EcY1REt6Av1ja1mpeekM
	eSQPm8f3nKjok1bhtbMn39VzDpYQeFb8kMcdnyJgPwQQRF2f8x7+a72TUaS4/T3cZssqLQjOR+L
	DjkKflwVVz6lbjY7nAUIJY9/PWJQZWxCD+P16DZYYimd2Atl5Y6uYsqTOTz8YDTsLYa6rtna6AE
	hwoCpQl3SnDH+c0o2ITt/Xwcnh8C/bAYmzN8dmf3ahckHxN9pEHqzFqEsom7lUZsSjdp7LcHlde
	T1g5ivFYf0xHUxQyGbCMORmM7NEXJM/gD2V+3JiyDJxxtWz+KupRY38BVvbWd2a0xs2AGMmSiTh
	z08Q5R7+OlxpDwKFujHg0qzQL9EUSwwPeunQNbw8MCRBntbyMuCT40JkhAnptKqqk2c0wK3j6Jo
	Uz7/xJNsx2DA==
X-Google-Smtp-Source: AGHT+IHK1mtmutqg6y/0hzjFEZWVKJiT38oIxOrMBicUN/5fclSvNdPVw1dIIFG4MX76NHiSFnTZwA==
X-Received: by 2002:ac8:664a:0:b0:4f1:e8d2:6335 with SMTP id d75a77b69052e-4f1e8d268ebmr148928131cf.77.1766006895940;
        Wed, 17 Dec 2025 13:28:15 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:929a:4aff:fe16:c778])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4f360751619sm1247261cf.12.2025.12.17.13.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 13:28:15 -0800 (PST)
Date: Wed, 17 Dec 2025 16:28:14 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: hughd@google.com, mhocko@suse.com, roman.gushchin@linux.dev,
	shakeel.butt@linux.dev, muchun.song@linux.dev, david@kernel.org,
	lorenzo.stoakes@oracle.com, ziy@nvidia.com, harry.yoo@oracle.com,
	imran.f.khan@oracle.com, kamalesh.babulal@oracle.com,
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
	chenridong@huaweicloud.com, mkoutny@suse.com,
	akpm@linux-foundation.org, hamzamahfooz@linux.microsoft.com,
	apais@linux.microsoft.com, lance.yang@linux.dev, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v2 07/28] mm: memcontrol: return root object cgroup for
 root memory cgroup
Message-ID: <aUMgbirV5dNpuBoM@cmpxchg.org>
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
 <3e454b151f3926dbd67d5df6dc2b129edd927101.1765956025.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e454b151f3926dbd67d5df6dc2b129edd927101.1765956025.git.zhengqi.arch@bytedance.com>

On Wed, Dec 17, 2025 at 03:27:31PM +0800, Qi Zheng wrote:
> From: Muchun Song <songmuchun@bytedance.com>
> 
> Memory cgroup functions such as get_mem_cgroup_from_folio() and
> get_mem_cgroup_from_mm() return a valid memory cgroup pointer,
> even for the root memory cgroup. In contrast, the situation for
> object cgroups has been different.
> 
> Previously, the root object cgroup couldn't be returned because
> it didn't exist. Now that a valid root object cgroup exists, for
> the sake of consistency, it's necessary to align the behavior of
> object-cgroup-related operations with that of memory cgroup APIs.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

