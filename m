Return-Path: <cgroups+bounces-13225-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C39FED21850
	for <lists+cgroups@lfdr.de>; Wed, 14 Jan 2026 23:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DEF01300487E
	for <lists+cgroups@lfdr.de>; Wed, 14 Jan 2026 22:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C6C361656;
	Wed, 14 Jan 2026 22:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KW+gt9ej"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8009B3B52E7
	for <cgroups@vger.kernel.org>; Wed, 14 Jan 2026 22:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768428813; cv=none; b=D5xIS9ni1F7gB75BaVoHLmddvDNEVgozvourQL318WBaB/1eo4PkYS5y+f838pkpwIBFCAn42J7ZGAwJl0jmf4xscL/hhIKkrLDrT3byiwxJ3npvAupZQuzCmPVHZndm5CtARuj/nVbVPEvShJPkmSj+CTeDlbZZZGR31T7zKV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768428813; c=relaxed/simple;
	bh=C8DYqwXO63HKAoTTgnDTjgxKODShLl6CXeWluHUrUD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DvLEeRrY0yUaLFbLwwWlbrR0e8GZ3FVkkGG7Wab9rppg/7t1DmSGuTdxC8C6wMAHeWdqQbTzo3ruKET5xBD01GSyR2IGrDp/axOflcw9EQtdrWkJp44Fw359hE9chPD15CXALTSiX7zh0XHHleUdrEdGFuBFWL2Kqv9GoBAIxDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KW+gt9ej; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47ee974e230so2692135e9.2
        for <cgroups@vger.kernel.org>; Wed, 14 Jan 2026 14:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768428797; x=1769033597; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9te7Py4jVWEi/zTRZhhdfHD436sqYIG62vqnpysxH8E=;
        b=KW+gt9ejsHVVWK/NipStgCDYaRw/jziJ5bKqBu90jftG/6a6yoyzdGbHV5vYYxlm9g
         OlXKUBT4RRHu262RvLokicNq6tgAwp7+5OrftF4sMZZyyQPqalWi1d0zDDNT5z4kL1I6
         NA4jHYhPL/+yrKxy3o/2vEglQ0pmw/S9CMTql3UyzI/LZ4DNO4lTiZrXIjvwrLJX3+km
         qY1S8CkDz8E+QbVvIgLfc81cC1vmidf996l3GbEL/Bi56pBn8hVUTRazcLUiTrV4HBHJ
         +kL8lJa96FfkNFrKGKYFKdeRMOttDpyW4MFVK9upw5VaJNOJIHlkPdJIHfFr5BipV2DU
         PhWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768428797; x=1769033597;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9te7Py4jVWEi/zTRZhhdfHD436sqYIG62vqnpysxH8E=;
        b=wfjY1Aui66mjfqOdmDkKh8OuJFJOsWhGXKThWqVONzvARaT1X/WKmCpLaXXXS6fk/Q
         L/+knSPgp1lwX1jeZkrbIA21ddICVLvTCqGZ1cCyUreOPtStikhZy5n+KYqbCnH1CiId
         XdtVQvfrGy0TkBJyCYyKgu4uES/v8GKgwACZ662WK6TuuI3PdsVCY7yQN1+ZYnkatzfn
         mEInrnJ57oHi415A0QM7dljOxnna+AgsfM2k2/X54XuvP7ya4wfol65Cn6I6w0wvaIsU
         VlGuOs9avJw1NFWNQGhuYrXijacZ7vS2fkXpkEhVABXpQOv4qFCpkPggACuB+yNE5Pgk
         h1jA==
X-Forwarded-Encrypted: i=1; AJvYcCXa+Zl2zERFKV5hRTIJq3XqZSTbLpgrg7hJ2zBxj53iXkekZKRj2XLEAUGU3TKjHi+1+fNEnss6@vger.kernel.org
X-Gm-Message-State: AOJu0Yxgnn32YnSrmoba4oKcCfnNdsZKOhT2L5fUkQ4rdx/vbMi2Q/QI
	dBBHekEy976PhXQlWMkwfp2fSRnVnW9i55khz2Y5+Xh/VkHavpg8J0J4QveXPh1FLWdn1+Woy/6
	HB0LI
X-Gm-Gg: AY/fxX5gS7B9JMPscjaMLS+Co8ijoc5ALvj+TGNbH7WV8ZmIWhZByS4ygGDMWDLKmF/
	z2t2Drhub0aDS3DsxQmk1cUsGubUSemlJuM10LfinjoGjWTvEFD38uf4tpSoYoR1voACqgG3UFn
	Ab0lZs3bi4RUMI/YjKpJLY7qTSips3uJan0fEI8oDex61QKLPDeIgHxVmdMrKwFPZR5ug7EUEFR
	j0rUEZ7HQzzzshuA+22VgrXO3bQGUfSkH+DtR8ItSRjoNhBoJ4BsFRJBjun+C0eGNLxmPlyV+ie
	RiBiBU4kIfrMDC9/fM0ktteSFgmFrHZQhW5jiRVDhB5kf12Zvs60x5VkkAcunzaOST/2k6ePfAh
	0xhMeHdwPKK+4Vg9qb68fjw8i/1tCsh1anfx4DqtNzs4fw3Vfw7LWf5G2+v9KtNuEarpNuhhib4
	vRaw==
X-Received: by 2002:a05:600c:34cd:b0:46e:4e6d:79f4 with SMTP id 5b1f17b1804b1-47ee33117d3mr49883055e9.15.1768428797424;
        Wed, 14 Jan 2026 14:13:17 -0800 (PST)
Received: from blackbook2 ([84.19.86.74])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-434af6b1455sm1617183f8f.22.2026.01.14.14.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 14:13:16 -0800 (PST)
Date: Wed, 14 Jan 2026 23:13:14 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Yury Norov <ynorov@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Alistair Popple <apopple@nvidia.com>, Byungchul Park <byungchul@sk.com>, 
	David Hildenbrand <david@kernel.org>, Gregory Price <gourry@gourry.net>, 
	Johannes Weiner <hannes@cmpxchg.org>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Matthew Brost <matthew.brost@intel.com>, Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>, 
	Rakie Kim <rakie.kim@sk.com>, Suren Baghdasaryan <surenb@google.com>, 
	Tejun Heo <tj@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Waiman Long <longman@redhat.com>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Zi Yan <ziy@nvidia.com>, cgroups@vger.kernel.org, Yury Norov <yury.norov@gmail.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] cgroup: use nodes_and() output where appropriate
Message-ID: <qhobdtdwtkux7n5r3b64itvpe7zchm3ovpfmazim3v5ilg34kr@5o5wu3chh5b6>
References: <20260114172217.861204-1-ynorov@nvidia.com>
 <20260114172217.861204-4-ynorov@nvidia.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260114172217.861204-4-ynorov@nvidia.com>

On Wed, Jan 14, 2026 at 12:22:15PM -0500, Yury Norov <ynorov@nvidia.com> wrote:
> Now that nodes_and() returns true if the result nodemask is not empty,
> drop useless nodes_intersects() in guarantee_online_mems() and
> nodes_empty() in update_nodemasks_hier(), which both are O(N).
> 
> Signed-off-by: Yury Norov <ynorov@nvidia.com>
> ---
>  kernel/cgroup/cpuset.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)

Nice improvement.

Reviewed-by: Michal Koutný <mkoutny@suse.com>


