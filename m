Return-Path: <cgroups+bounces-7039-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67BB8A5FA37
	for <lists+cgroups@lfdr.de>; Thu, 13 Mar 2025 16:41:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 667EA8804CA
	for <lists+cgroups@lfdr.de>; Thu, 13 Mar 2025 15:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7F0269D19;
	Thu, 13 Mar 2025 15:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="HLiOYxiE"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EFA269B0F
	for <cgroups@vger.kernel.org>; Thu, 13 Mar 2025 15:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741880360; cv=none; b=SMy1aZJD7LZkz9/DwTba9RxU85Zma+gP6bvJArcOsB6zoY9z2SCz9QvjMXV5DhQkNLijynmAOhyaXqtcWoJcziShJGKlwqyVeH85d3FJzV+ir9Pm7aGiWY7yQCud9qpFOBVEnphBAZEIRdr4paQXk8rwG1vjq3LTRpccbQEb63U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741880360; c=relaxed/simple;
	bh=AR08GzHkg4EOEhm5hqQkERNAecmAfz4v0HsYwbyhxgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W/4d3RRuFk2SqKFd1QxKwWoV7GMhbcBN3eCXUqOrxVStIPWKwQpphIww+YOCiHZR4kBWWqlYGJiVEPXwqUgQsRZdaMzBO2FxrytRszK5KhbtPWTC1b84bi9zC8KI0FMNYFQ0i69T36BLqgOf6rr0MHIUIQrQeYYrfJZwaDaIDlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=HLiOYxiE; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7c560c55bc1so107447885a.1
        for <cgroups@vger.kernel.org>; Thu, 13 Mar 2025 08:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1741880355; x=1742485155; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZOmUK0wijuW6dxDYXHnP7n0DJ9/LVG75PLhj+DBDca0=;
        b=HLiOYxiEJhBTGVn0ZG/7cENuniguCrLozlad0dnFx//60Vy5N4mFoIw2u1CaRc4lz9
         hn7VlOqkvr6a6/XjUDJsrGf3HOqoKZoeQjq1opakugmUBO2C9Evw3IyT/OgUKfciZqT6
         XxvkZsMsNxd8VxJxlXjB0KVE/OuismGz/FO/Au+lmjm4uso1h9d+vfbWTsC4u3lbfslM
         wYxIfTF8yxK6VqwPjUWc4E29UKHjjEcNZh2g3snSl6pqQHZtj9uU9TlImUpuviBRksOi
         Lou9vgdG671zTjdSb8AOvrR3BLC2p1JoOActdAyMl+JeYqIi0LJTK/rkdVtqJ3Sun959
         vDpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741880355; x=1742485155;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZOmUK0wijuW6dxDYXHnP7n0DJ9/LVG75PLhj+DBDca0=;
        b=Wur+ZDx9zwHliTM4THNMbKT4kfma9aVAJ+nBGDMmwZXCo3loTyUa+n14+2sua/It67
         3fBzw8Lt+S1/gFoFL4LoOerGQR4xwHl9Uc6fWuyTZiy0X9cl5hdhsCULY5wxuFLoLTht
         GJv6XbLflgYv4S70RhwXUJWWJ1FZ17XldP6SSAe5E49an+tle2FgqNUXcOTX9Oh+nKDR
         8id7CXsR7ybRfeitx7ihmtFjlIZaBh8EvykZPbN/Aay49rQC4hJzhDfQYAmSnSHETm6s
         CiUFgb4E8ilwedRLvhSGvsgdXhUzm3okv3wPCmGiYFr/BbJp4yB0gWHNWYAy0cAbU8s/
         drRw==
X-Forwarded-Encrypted: i=1; AJvYcCXUnlxFduGsf93Cq0MhaHJHwAy/FEsnWjx0c5Tl6YnJ/ORV4Mi+Ix/itE9PN43KaENnjsDvVDZi@vger.kernel.org
X-Gm-Message-State: AOJu0Yz075oY0wP0JAkLmsyG8sJkb4rK0dB9HPRKepSIxYWw+6QCQL5z
	C7yre7kQ+pxHaoE3eA5e1gVySALhtjgPphcNO8DMnl+FavSIW25soGZ6zZLUZNU=
X-Gm-Gg: ASbGncuma+dcACFfniP3DiYZAjpeKEVsFbWGVn9EMux/uOvbWxlaI0CRTt6ZUqVJ5BU
	RrdkJc2WGhV/XTxLPt8j0jv0mIhil9iUZNU9F6I5mdmAXsRuhPIEt1fMaGYn4xN2TTvICPw/Td8
	IKVDgA4Ch7m5pYdSYuo2M2/WsZfPmHrXpxDG+FskTTD8Omvb5QnUZp3Jf3+hPaKXACCWgniEMHZ
	85S6uXPpmp3IEBCdwelz+j5wdvuU/3gWFuqBfehWWusT4thU50PvNGDQ0XwZ4rDH+2zM2aSWMDi
	uOt2CXLz5a66r83Gnzi8kixyswwlIoo67kE9Wc1Gsms=
X-Google-Smtp-Source: AGHT+IEiYv06z0yUVO5Elmd+9XLszQ3RCIp0amxxCA0d7ujTwAY295Ym5fJosAtLaTmWL2hWKTZtMw==
X-Received: by 2002:ae9:e014:0:b0:7c5:3d60:7f8d with SMTP id af79cd13be357-7c55e85c500mr1443206085a.19.1741880355445;
        Thu, 13 Mar 2025 08:39:15 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c573d89ad6sm110209985a.102.2025.03.13.08.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 08:39:14 -0700 (PDT)
Date: Thu, 13 Mar 2025 11:39:10 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] memcg: avoid refill_stock for root memcg
Message-ID: <20250313153910.GA1252169@cmpxchg.org>
References: <20250313054812.2185900-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313054812.2185900-1-shakeel.butt@linux.dev>

On Wed, Mar 12, 2025 at 10:48:12PM -0700, Shakeel Butt wrote:
> We never charge the page counters of root memcg, so there is no need to
> put root memcg in the memcg stock. At the moment, refill_stock() can be
> called from try_charge_memcg(), obj_cgroup_uncharge_pages() and
> mem_cgroup_uncharge_skmem().
> 
> The try_charge_memcg() and mem_cgroup_uncharge_skmem() are never called
> with root memcg, so those are fine. However obj_cgroup_uncharge_pages()
> can potentially call refill_stock() with root memcg if the objcg object
> has been reparented over to the root memcg. Let's just avoid
> refill_stock() from obj_cgroup_uncharge_pages() for root memcg.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

