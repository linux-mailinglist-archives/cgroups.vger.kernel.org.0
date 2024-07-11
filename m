Return-Path: <cgroups+bounces-3641-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D8792F09A
	for <lists+cgroups@lfdr.de>; Thu, 11 Jul 2024 23:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9757028167C
	for <lists+cgroups@lfdr.de>; Thu, 11 Jul 2024 21:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E276119E811;
	Thu, 11 Jul 2024 21:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/AuuJw8"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7BE1509BC;
	Thu, 11 Jul 2024 21:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720731779; cv=none; b=JrwiXHhDNrZkKeAxVg3DyolTVEY7prQFs6xTrLsZrFpu3VCMcqypTv/2GoEdkBsdB35YmAeFgQEcXJlLYpHItlMgM0d8VwqkX1t4/ujAoaqwCha2q6RbSz4b7H29mqTIiInHJZgKdiwkfeumGG0S0hz5rSovllQFhQvjSXjEJVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720731779; c=relaxed/simple;
	bh=MCiiul/sL2ZAleSM+VXyP3MAAKUhd5EixF38DNqlwX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r3RovehEp7gW4dyw4Zb5D7J1wI7o6XD1IS7HRa2DCoK5UhoJIgicnVUZOTSwIUVuRuJMAL8PfxsHlhfl6Ile+CzZXPnN27GLSmvufkHVRFmYQE8t4Vx4fYxMvCN6X1WNkPaK2B6ijROvfKhiUrjRM90dNwhxA/RLfMNx/vtldJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W/AuuJw8; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-765590154b4so892128a12.0;
        Thu, 11 Jul 2024 14:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720731777; x=1721336577; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TPw/SO2sSnfKID7p0VglZO30XRVzBtVu+U7rJuk0nik=;
        b=W/AuuJw8Rkx235EHQsab0ncg83EWgxsw6IyBoexUzVnxjpYOiUktJvp0OXhSXg+SIe
         XYcrLunt0WyEvTJIoQNbpcQx3xNwGtlT6zAsMPeN0Q7A32RbMZBRD79krl+vKbVhjv2X
         xQSilTLVRoMWvwk0t/XMg4Q/hwJ8ULyVE+EC9jJYF6FoH2LuKwBuotJCsQGPnOcAK5OR
         Ww/bA7YO34WOaS2SZlAR9K2eTx7Z/Ll+oudWwgSnBRBy2Hno9lMNyjOsCG7S8Xnf0SFx
         gELhoPlg0kDqqKGAx8hsf4087OXDgfzCD9MYUiFQZqy8scZ5tGNJlG6T+TZ1MHHtn6tP
         IzRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720731777; x=1721336577;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TPw/SO2sSnfKID7p0VglZO30XRVzBtVu+U7rJuk0nik=;
        b=JUlMKfc4JYKMPC93dLsg0nlraUvBkx5j1O+0nXCfcou212jA76Xzl89AFoZKfb0yaN
         kusZDqgHNcQn9wGIkRXqmOA5w4hOEbZK60q1Llidh7C91p3AkXkxOtwsIm4fdV2u98ek
         9Nkgr3xeuivMAE70qfOgY22LuQZ9FuyJWLChHlTyp7IgSsZ5c46dhc8wTWkJS7hmSFxN
         uBL5ZXMRv79A+dIfUe0dVflzNkCfwKTvt/FK2NqrRuzqLrAaUdEAThelt/h0HZCACEqp
         0C4975u080doKkk/3zsH5rfOah6yesiQ6Znuc3aO4AZs4jSnOiqewTXGZFBiYBZZ9LwO
         /pag==
X-Forwarded-Encrypted: i=1; AJvYcCUjo8fdtoJ7K9b2yUcB9z4c/RqDAfJ1vRi00ErvlrUD+UnTWHIwdRzNumYqt4jlvIF9W7mmcAveXuyedFS2G+mdlnFGPOvi7GLJeuxW+47hct7sz/cs/wgxdXDuR5Mh4/zrkGcSzuLxmTq3iN+UaBvmoiITamt/FkZvfsaEOG3VWv8s
X-Gm-Message-State: AOJu0Yw1UjMOMkiwyfGdIkfH2PexQrV4F7/J1cDWa7OLhOhgTNgXGNJF
	WuDGO8GHklj2QfvFk0vVRVShjF0xTDtS8Y6iyQ7lYF8tCAOEbo3W
X-Google-Smtp-Source: AGHT+IGdb0yZ9jv0Ip0mZjZRgjiQo6tr0WqPFqmNDoqYhcf4lY/3x6skldRaQwFgzPd+apnufW2qnA==
X-Received: by 2002:a05:6a20:a11c:b0:1c0:e1a5:9583 with SMTP id adf61e73a8af0-1c29821ac95mr10981697637.17.1720731777394;
        Thu, 11 Jul 2024 14:02:57 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6acf417sm54587155ad.265.2024.07.11.14.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 14:02:57 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 11 Jul 2024 11:02:55 -1000
From: "tj@kernel.org" <tj@kernel.org>
To: Boy Wu =?utf-8?B?KOWQs+WLg+iqvCk=?= <Boy.Wu@mediatek.com>
Cc: "boris@bur.io" <boris@bur.io>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	Iverlin Wang =?utf-8?B?KOeOi+iLs+mclik=?= <Iverlin.Wang@mediatek.com>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"angelogioacchino.delregno@collabora.com" <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2] blk-cgroup: Replace u64_sync with blkg_stat_lock for
 stats update
Message-ID: <ZpBIfwThiVwstlXL@slm.duckdns.org>
References: <20240710061334.1888-1-boy.wu@mediatek.com>
 <Zo8HTD2AD-b51q0C@slm.duckdns.org>
 <6114fbad7bce9b15806bb9fee25a1075ecb53dd1.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6114fbad7bce9b15806bb9fee25a1075ecb53dd1.camel@mediatek.com>

Hello,

On Thu, Jul 11, 2024 at 02:25:29AM +0000, Boy Wu (吳勃誼) wrote:
...
> I can remove the 32bit only define, but I think we need to add back the
> u64 sync, because the spin lock and the u64 sync serve different
> purposes. The spin lock is for handling concurrent problems from
> different CPUs updating stats, and u64 sync is for updating 64 bits
> data and fetching 64 bits data from different CPUs in 32bit SMP
> systems.

Hmm... so what I'm suggesting is using u64_sync for the per-cpu stat
structure as they are guaranteed to have only one updater with irq disabled
and use a spinlock for the shared iostat which can have multiple updaters
and isn't accessed that frequently.

Thanks.

-- 
tejun

