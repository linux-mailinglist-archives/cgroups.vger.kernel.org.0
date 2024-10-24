Return-Path: <cgroups+bounces-5220-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F02C9AE064
	for <lists+cgroups@lfdr.de>; Thu, 24 Oct 2024 11:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03FD7B23764
	for <lists+cgroups@lfdr.de>; Thu, 24 Oct 2024 09:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D72B1B21A9;
	Thu, 24 Oct 2024 09:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UMK/yKWT"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DCD757FC
	for <cgroups@vger.kernel.org>; Thu, 24 Oct 2024 09:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729761418; cv=none; b=sMO/ZR90CQCjGE3XOGgfVipNOFYUeGQLr4BJv9hcFlTNvoeBHcBG7FEM6S3qgfMXYLzPr8FcQtLSHazKLdY6CeUeCcLDfld91obbcbrrsYbWKB3CMP335G4KOVk2EVfE/1dZ8wG7ZQAgW9kvBqZZ80Se6hcbRcYWkGYX8pkVIQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729761418; c=relaxed/simple;
	bh=Urr4Bup3gtJFSu/HDlD6IZqiGmKuABzJUZ4Qipx6pkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kFL8Qu/3ZzuEAaxO3q6v2MpvXlDCGeIwPmsI7Ndb5dsXm36YOLlQqFSIlY0aTvmzJWyyfbNuaaZvXVMLc+ul3m949NR/ONCwq1ciyPvMgNkc0NfcOjr5/rViG68GJOtNScB8cMzXDNOTXJqtMrNr4CJ1XV7o2IAch7oz+/U5OwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UMK/yKWT; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-539f1292a9bso792521e87.2
        for <cgroups@vger.kernel.org>; Thu, 24 Oct 2024 02:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1729761414; x=1730366214; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AeE8KFauVONfdqIJuroUx8aqRES8F0A4JpZa9szE0Qo=;
        b=UMK/yKWTnjFqykT28hCiVCSil6eY9XEkl2JoUirhooJtcT246fe3n+vmHo73QD6l40
         hI2TnFzIfi9lCOeInxZeMEslOZOhFf38aRKAfoSPgYyC3o+WwRdnv+62/Gb8IdlalyWr
         6AoMFmKAv+oPJS0/Sn/gAPFJkW0T2ShJpjOdx3xqkqA7QidMAWR0eFr441pUFcxmr0KJ
         GiNhM/znsB3h/GB79/x0FE0r8JngoBHX7ALJctnE0VpsIq0vDKJ5kX7y8Y9vqb+JYNZ4
         drTHPQ02ONjzJcaItn6cVhhw5aTJc7qCwFawQdQbYQPBdQ0uFq5QOTZqwyBpIxb8ViOE
         Ae8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729761414; x=1730366214;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AeE8KFauVONfdqIJuroUx8aqRES8F0A4JpZa9szE0Qo=;
        b=BxME7rG13jdan/WX0jPAqbXz5VyQx8iFDGbsDmljZyW2P6xqMQe3C8PHjDPWVXVBAX
         bjRFj5/KvST+J8qrFvO8LzqgY5w+YrS8hwNmi4jWHKHe//VlU2GkocgIHZHYNBgKXvc6
         7oSaT+GEYzortcCgAi51Z8U/KaV66/F8yCAFsFzWWnZcFPh3DBYrOUtSsztR94cC8gJp
         jLqK21ZXepl8gpF7iM1TfjtjtkGt9jozzHa6fV/u5aySfmKkroPluv5y4oPNEuIGnipE
         ozHVs1cVfU9TRhW9intFCq/skS8ER05Gf/3C0dvpID28gSgrctzetUzVNodwl0fABPEW
         d2GQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFgMO21d2HuS9jhSdZ6Fetj9RGGnemsUQe0J9HpsK2Fmn3eI7sxj8JxbUyaekENC8p6wi7S+aD@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg1nGQBh5rgJti8hQIsz0dxGEX29fJVl0Ez9f2zcOs4DakJ2hT
	ImBEKM2OjfGFVSBhK5UKK515y0UWdYbsDF2OOd30EJekQnfMstgApzoNF2wAz9U=
X-Google-Smtp-Source: AGHT+IGiRIKpzx6HiVv9FVaGAJq4id/5NbMKWWIl1xUL7eRNooF4qx/CFIyStwDItG8GRMhvMNBfsg==
X-Received: by 2002:a05:6512:3b9c:b0:539:f1ad:b7a6 with SMTP id 2adb3069b0e04-53b23e67ceemr637951e87.37.1729761414027;
        Thu, 24 Oct 2024 02:16:54 -0700 (PDT)
Received: from localhost (109-81-81-105.rct.o2.cz. [109.81.81.105])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b55f50csm11444305e9.17.2024.10.24.02.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 02:16:53 -0700 (PDT)
Date: Thu, 24 Oct 2024 11:16:52 +0200
From: Michal Hocko <mhocko@suse.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [RFC PATCH 3/3] memcg-v1: remove memcg move locking code
Message-ID: <ZxoQhEPXmSkM7sH_@tiehlicka>
References: <20241024065712.1274481-1-shakeel.butt@linux.dev>
 <20241024065712.1274481-4-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024065712.1274481-4-shakeel.butt@linux.dev>

On Wed 23-10-24 23:57:12, Shakeel Butt wrote:
> The memcg v1's charge move feature has been deprecated. There is no need
> to have any locking or protection against the moving charge. Let's
> proceed to remove all the locking code related to charge moving.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> ---
> -/**
> - * folio_memcg_lock - Bind a folio to its memcg.
> - * @folio: The folio.
> - *
> - * This function prevents unlocked LRU folios from being moved to
> - * another cgroup.
> - *
> - * It ensures lifetime of the bound memcg.  The caller is responsible
> - * for the lifetime of the folio.
> - */
> -void folio_memcg_lock(struct folio *folio)
> -{
> -	struct mem_cgroup *memcg;
> -	unsigned long flags;
> -
> -	/*
> -	 * The RCU lock is held throughout the transaction.  The fast
> -	 * path can get away without acquiring the memcg->move_lock
> -	 * because page moving starts with an RCU grace period.
> -         */
> -	rcu_read_lock();

Is it safe to remove the implicit RCU?

-- 
Michal Hocko
SUSE Labs

