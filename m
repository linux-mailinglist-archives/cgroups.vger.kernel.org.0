Return-Path: <cgroups+bounces-3680-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC98931920
	for <lists+cgroups@lfdr.de>; Mon, 15 Jul 2024 19:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DCF31C21565
	for <lists+cgroups@lfdr.de>; Mon, 15 Jul 2024 17:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B19446D1;
	Mon, 15 Jul 2024 17:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YTaZ1blY"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BBA20323;
	Mon, 15 Jul 2024 17:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721064090; cv=none; b=fvdYf1L7mrujacCoHKBbPDl8X/5MhJmc4wkzZRnzKFlNKJT1HX6qZ/QzjHyyjKgRRIiiehAfkOE9+l4qlEC/G/Ya6PyojY/+T0fARyWvQRASNoTe/y9zVAWMABarPGeI+RxJVllNJaDSOfTm673pTpLKTFTaIXj9PyuYigwTJPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721064090; c=relaxed/simple;
	bh=YuKyZRtkNIBHN5jbSweMr/laqNyoENl8JTxzcP5OZ9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uAlJYcZ9KIjokujm3Bk4LPR+0NwIDp1tBat139TAmX9M6d5WkkuFEmzdCzAJod9yH7OOOXtX/11GJ94W8C/Iqk/7ea9kop41wLJw0JFA6yxa0DOEROn3yteiP0p9c84zbSHSTxI+tZ5Unh8BEhT2X18s/DXVdRMrAYu16bs6x1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YTaZ1blY; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-76cb5b6b3e4so2723502a12.1;
        Mon, 15 Jul 2024 10:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721064088; x=1721668888; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i9k73sA4KaYZWSPUciUi3HDdqr3lc/EAyIdqeVOGRMM=;
        b=YTaZ1blYWRt2Ea8jiJadxWiTrHvxZ8liJrSaFMFJIOG60c6NvziOkSZInwfwBNKI7o
         idm2qUcg/OPphaWP49uMNAgrLvavwElkU+sKsbOtevAgjJql0AJmQhtKnYUM0aGVfpym
         mGZm7gW1eyL+daErf/B2sQd4HKLIcpDO0hQavhcXAXm7WimsV6cKHhrCTfRBDWwkmKeY
         hcr7VYDEuP9eNxSgRbj8o5LQRZ/IYARat+yWAlHwVBvJcBBOYYZrAUGFMpoF/gWWBb4t
         WLd8q0XzdW+DDxz65fRTCVL4ohr5RiWK7+AHOREIh0LddwfjHLEYHFYkcxjPOw1H98B8
         absA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721064088; x=1721668888;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i9k73sA4KaYZWSPUciUi3HDdqr3lc/EAyIdqeVOGRMM=;
        b=hFx9gywq0RW8Icbv+JEv7nOMtDZ4Gquz1biXBO6WIe+L/u7GTdEcE1iaZOnfRGmirb
         xC5vzo2CXoUGBesz0P6YUDQRG3RSOFdPGtya0X/9T5oUKISx/vBX6XzsRZMcWLV7ZYUZ
         cx1SgaWFjzuuR5kpkQBzSB5n2h7ULUyP2nmQ9dWdzxZBQLhEVnIQGiw9GwKxni5nLElr
         1gaDJXEsxKQFBnQlDiWVtuAoeqqVozIiU89zOC3TshT/vITHNbGm18Off0F2PRBomDkS
         etxqh+c6luepkK1E0l0ice6eN6SqRwJYk3Uno/jDEWP+tsrJNHZgxoDTQVjbeTo6H5Ok
         VdoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvOYUDZDtULEOdUFS5ClhidKIKPvVMXyw9Y5UNiG88FZRi7CONY7SEWdV2XQn4Zk6nV86lNGh7HlvLaO3qQkwS6/wZVScxmPZBbeVKqZUCgTB2GgkQQoZqqNsI3gSa+aAvoOY5
X-Gm-Message-State: AOJu0YwgVfuMlbgdg3ni3sKEopkR4+YKFLPsL/QzU0hwI68PxBU2z1Oa
	IvvowNIDBTwjpBc7QPEsawwxqBBWKMsDbpaAK47Fe1qjlOiX4bjD
X-Google-Smtp-Source: AGHT+IGMeZvsUWpVQkC9G9DR/tknpdedHPhniJeUBf540YOjexOrwcOmXJRbjo2pfRCHhHE9MPBbzw==
X-Received: by 2002:a05:6a21:10b:b0:1c2:94ad:1c5d with SMTP id adf61e73a8af0-1c3ee506766mr603367637.2.1721064087793;
        Mon, 15 Jul 2024 10:21:27 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cacd6da7b4sm6688202a91.46.2024.07.15.10.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 10:21:27 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 15 Jul 2024 07:21:26 -1000
From: "tj@kernel.org" <tj@kernel.org>
To: Boy Wu =?utf-8?B?KOWQs+WLg+iqvCk=?= <Boy.Wu@mediatek.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"boris@bur.io" <boris@bur.io>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	Iverlin Wang =?utf-8?B?KOeOi+iLs+mclik=?= <Iverlin.Wang@mediatek.com>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"angelogioacchino.delregno@collabora.com" <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2] blk-cgroup: Replace u64_sync with blkg_stat_lock for
 stats update
Message-ID: <ZpVals5maZs4L3e0@slm.duckdns.org>
References: <20240710061334.1888-1-boy.wu@mediatek.com>
 <Zo8HTD2AD-b51q0C@slm.duckdns.org>
 <6114fbad7bce9b15806bb9fee25a1075ecb53dd1.camel@mediatek.com>
 <ZpBIfwThiVwstlXL@slm.duckdns.org>
 <70c37035f006de3a4fde895ceeee92826cd280e0.camel@mediatek.com>
 <ZpF4Pfu83W9Wp_R9@slm.duckdns.org>
 <5a1e1bd5168696a0857b62572336c5e598cb5493.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5a1e1bd5168696a0857b62572336c5e598cb5493.camel@mediatek.com>

Hello,

On Mon, Jul 15, 2024 at 07:15:24AM +0000, Boy Wu (吳勃誼) wrote:
> I think I get your idea. You want to replace all the u64 sync for
> iostat. However, I have one question: why use blkg_stat_lock instead of
> adding a spin lock for each iostat like iostat.spinlock? We don't need
> to lock between updating different iostats, but only lock when updating
> the same iostat.

Oh yeah, that'd be even better.

Thanks.

-- 
tejun

