Return-Path: <cgroups+bounces-6195-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9509A13C63
	for <lists+cgroups@lfdr.de>; Thu, 16 Jan 2025 15:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 457AE188CA6B
	for <lists+cgroups@lfdr.de>; Thu, 16 Jan 2025 14:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45F122B8A9;
	Thu, 16 Jan 2025 14:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FedfdL4T"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9559A22ACEF
	for <cgroups@vger.kernel.org>; Thu, 16 Jan 2025 14:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737038192; cv=none; b=T17cCtp/BoLktRqLy48ZxoHSz9FXs9h8cQJVkACuNEBA7U1Q2BxoYUEP0LPpD9GuF/18+EX2ZbdJBpJLfxjB8qRh3j8+XV/SkyyCp/1JSNCdd5hCMSImURNurD4Xm38XNWlk7XTvMpswRTidnm8nNhTkcEb5kmAMFA3KX3MRML4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737038192; c=relaxed/simple;
	bh=A9D+v7zaqx3z3QaomV4DjhH4UrAminx35uS9A1u32zQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u5luR2CtAA0jrTLcVR9gs5KTxFy4RDK+jRfgXN+uy4o5RitIk3kU8dBO0J6gStPTV8Y0KurtqFs9CXIccvxcwL/5uYdVHssvJHNkfYdImQ2w492nk9QGx6/K04u7XM0U8qCdFTZZ2HZxwKD06Qo73cEB/3iNHD06fte75NKzv7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FedfdL4T; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-38634c35129so848000f8f.3
        for <cgroups@vger.kernel.org>; Thu, 16 Jan 2025 06:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1737038189; x=1737642989; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+FP56eEdwVt+04AI4F5C4W80KfN2yE/si4ZKrhL9SWM=;
        b=FedfdL4TqGcKoRCZOkUQwNsQpzzqpDJuqzuKG18+G29tr1Fzar4o1FDsbO/Y5CtjJl
         djaO4d1z3HzrvAuDoo5K1Svy5qN5l0VxUy4HucDtRAZluXhPjYCHe7h6gBou/ZWo5gsd
         YgbYNBiCXHB2N2cyraetjK/w99157Wacin+f6BULFqXzk3JU1elIgxtiN8edtPUTbxzF
         S94vVkwMa5/z5G9rlgDHcnwYY+N5wYJYbnSNFLEKQK/uwtPU/yj3yXTuizeBL8zwrgII
         ZDKX5QRq8LnaNQr/aDSwhToJnlyXwEOFyCxppGosRKm2azNfTX8Z7nBRCYe+uVY+eTkb
         Gf6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737038189; x=1737642989;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+FP56eEdwVt+04AI4F5C4W80KfN2yE/si4ZKrhL9SWM=;
        b=l5kyufqL6X1ruNv/LdZhrqt/nOXOJVokzCl2Y7xBehibmWyBipUHvLVFQzqAOTWoiM
         T+RDM0Ld3B/MCz6LVEcMlswz30xjbnyogANVPKtjLWGEI8bCgtXGdHzfHNUxGy+ZPOie
         dmrbSIClx8PRL2zqJH0Ocx1lGILRDtMXqNMb/WFjyiXuMvgz0z6Xd0frvKy9UqttfLo/
         DD38IhPNYkzfzkiGLTNcfPr9+pjA3si7Iw7P2bG9/3MTt8reu0anxB1zTIFIu3i/8gF1
         Mxgruk988eBbXZCLymtHwCQdOXQ6bDzKjY9TthdYsh9ATgG0HKBdiIKsKPVGB/O3Jbb4
         vZTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuclJmywNfiyju3sIf/EXbG9N/4UykWigBtpOgHVh+++7/N+QkMbYF0o4XxfYdY5y8pCnK6xlY@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3Fs7uf9sbpWi/GYh+ikzLJltUmFDLaMLWkl5TpQewKxe6cXFQ
	cNZRupIK4cOQ5Agm4MwT34F0X4SON1LtyIyimoWZw+KXYzDlS5mJ/cM+HYFfXVmQFNl2DZVQ1RR
	l
X-Gm-Gg: ASbGnctdBttE2HAWntSczBIuIug61LTeSn+QLIRxANOmp0QW2aulMwx2PvaA0/PtaDr
	ABA+nYzvl5ZcxLrnBHEC6syb3E1APoV+jDhTBQC8D5LweQefTqsk9Ay9YAWqlgdlkGOlAG7E2mS
	62RTZONvBYT3MKgi3YU03MGmBcoKZoEI36G4a3mxHJF114sJsZ4zj9VOBbMtJZWHf6YQzGd72uC
	tuCgiylP15+I7GuVcKuSoq+dFt20Q1tOSBqsPKPkP4efKqJWpDZikEkUoSCy5YUdHBhbg==
X-Google-Smtp-Source: AGHT+IHfYGs0wqb0pQglOIH1jYOE+QZ/hkb9WYhL0LkqiqdS6TLInIyP7XahS3sABPkFz1l+CaKaDw==
X-Received: by 2002:a05:6000:186e:b0:386:3327:9d07 with SMTP id ffacd0b85a97d-38a8733cbc3mr29425462f8f.54.1737038188882;
        Thu, 16 Jan 2025 06:36:28 -0800 (PST)
Received: from localhost (109-81-84-225.rct.o2.cz. [109.81.84.225])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf3221baasm38771f8f.35.2025.01.16.06.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 06:36:28 -0800 (PST)
Date: Thu, 16 Jan 2025 15:36:27 +0100
From: Michal Hocko <mhocko@suse.com>
To: Zhiguo Jiang <justinjiang@vivo.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com
Subject: Re: [PATCH] mm: memcg supports freeing the specified zone's memory
Message-ID: <Z4kZa0BLH6jexJf1@tiehlicka>
References: <20250116142242.615-1-justinjiang@vivo.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250116142242.615-1-justinjiang@vivo.com>

On Thu 16-01-25 22:22:42, Zhiguo Jiang wrote:
> Currently, the try_to_free_mem_cgroup_pages interface releases the
> memory occupied by the memcg, which defaults to all zones in the system.
> However, for multi zone systems, such as when there are both movable zone
> and normal zone, it is not possible to release memory that is only in
> the normal zone.
> 
> This patch is used to implement the try_to_free_mem_cgroup_pages interface
> to support for releasing the specified zone's memory occupied by the
> memcg in a multi zone systems, in order to optimize the memory usage of
> multiple zones.

Could you elaborate more on the actual usecase please? Who is going to
control which zone to reclaim from, how and why?

-- 
Michal Hocko
SUSE Labs

