Return-Path: <cgroups+bounces-3657-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C15F93007F
	for <lists+cgroups@lfdr.de>; Fri, 12 Jul 2024 20:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03DDD284018
	for <lists+cgroups@lfdr.de>; Fri, 12 Jul 2024 18:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31AAE18E25;
	Fri, 12 Jul 2024 18:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ELmdYRyZ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3828F49;
	Fri, 12 Jul 2024 18:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720809538; cv=none; b=uifFqWgdhxSvRMowXA6wVfTd/r9/yZeg+FAfyPhSSewvAJcooybDqtcmrB15cbwPvXIeMTX1x+oeT9k73F605hbaWkhzaybLl+L8ECm31Qm3fKcm00mTMaAbpGbZ5WLbsSJZHLh8vEwt0qjpnU28qEv2x5SwkJu+k/8DDzHLSVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720809538; c=relaxed/simple;
	bh=qwtIvcloNQ/P5okHzl9ymO9M9S+Vgo4UDedzUtztzPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hh110+aI5YE92pmO4rkpxSxmGUTGDsA9DF0tEg4ClTeH7tQbLaTg56ecL5Xr60GpC0wrKZIUIpbJAVqxOx0SgZooDcdIwZSF8F7uIXbmt63nkc+h5PG8Jl2NN5Qhlwdoulc8wa6ZR6V4bSRbY94D+Ps65Cp5UO6Ij9VPum+s2Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ELmdYRyZ; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-70af5fbf0d5so1571646b3a.1;
        Fri, 12 Jul 2024 11:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720809536; x=1721414336; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qiT8ueAJ+Ik9eGxQHnzcsayjjgwYfS8TKbVcB1sjgcI=;
        b=ELmdYRyZh5nJyw38tpa1RNa+WkZg8TQOwDLB6cJ9YFpq4Ln5eS7NR+Qy0X1T1ZqrAU
         akc/8p3nIWxEE5dZlEB3KT8iF6Ymxot7L6QAFzxFB5TsS2ppDu8VezrzYId0UGPnVcPp
         CN5fuKZU+cCmIdLwtqx/NbAx9MwWd5OUbSddr/l4vECCU4cxLKdkI+P9MsEukWyNnUlc
         3Qq9I8cYhPTjFsAIC3dCWUt8GD7SmCHpmzY+bVwsLz88gwQQdu5LJ/imdMJ4Bb2TbFQ4
         /SZscm3GPnGDdIBHMC/LDlbiZauwg0K0E+kSyr8xVkJxvdcNoeyNdh9L4ZEdl0zC6/Cv
         nIYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720809536; x=1721414336;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qiT8ueAJ+Ik9eGxQHnzcsayjjgwYfS8TKbVcB1sjgcI=;
        b=H9a+O6V7CaJ1Fl5RuVTx8u2eeEk/RPDr5Bq3tNOVaK7QDcrPPtlabbX9SrzArZntca
         HNT1rR+JWqmh2KanaxlkEA+1SSfsLfzGwNXbt6EEOVVknVWu9awensN/j1QbK/z7jCxD
         9RfIynAQbnsfYDU9FphU7xAnWQLm04bk6iACjZ5iF3W2vVz7CxAsizm1B6X5QtEcM23y
         fxVb95o1n2gEl2vSkfLyLhQIOJzMKnzetQ8goxP5WuZXVmiY+WdtsOYU9xc3L1bS/6bd
         VvZychQhZbdMW8+4Mxq9/d8mtJzz3h2xDbBx9Te7YlaTBFxRMqosi7+r1Fn2CTOW64kv
         iL9w==
X-Forwarded-Encrypted: i=1; AJvYcCUlGgXwuk9oKKDmXse02gl2M7mphpTCQhOU4Yydxzauo6YbGQs03B2tPSm2WUFQoTK/CC+7JciMZFcTdrv4gPePlsFxKRQv9b5WBKwGvVgwKXSQpaUqMO1GV66vBZ/CIkR2Pip9
X-Gm-Message-State: AOJu0YwntCh9BE4HYoNQaTZOHhnMvy1IA70uPbGbwbuMbt2Wx5cvovUC
	MKwLjtMkOeJHXtM5KtVlJ5AZsmYgne90z5tl31EQIistygixFOng
X-Google-Smtp-Source: AGHT+IFo66xx+y6LX4NUko0NsUUhq/bMv8PhKj0aFdyuHdHX7Sc3p1A2XaQYMv6PApWMzwZOr8BxNA==
X-Received: by 2002:a05:6a00:1acc:b0:704:2516:8d17 with SMTP id d2e1a72fcca58-70b6c8b282emr6137659b3a.8.1720809535678;
        Fri, 12 Jul 2024 11:38:55 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-787089bc5f6sm2638479a12.92.2024.07.12.11.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 11:38:55 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 12 Jul 2024 08:38:53 -1000
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
Message-ID: <ZpF4Pfu83W9Wp_R9@slm.duckdns.org>
References: <20240710061334.1888-1-boy.wu@mediatek.com>
 <Zo8HTD2AD-b51q0C@slm.duckdns.org>
 <6114fbad7bce9b15806bb9fee25a1075ecb53dd1.camel@mediatek.com>
 <ZpBIfwThiVwstlXL@slm.duckdns.org>
 <70c37035f006de3a4fde895ceeee92826cd280e0.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <70c37035f006de3a4fde895ceeee92826cd280e0.camel@mediatek.com>

Hello, Boy.

On Fri, Jul 12, 2024 at 01:39:51AM +0000, Boy Wu (吳勃誼) wrote:
...
> I agree, but for multiple updaters, we not only need a spin lock but
> also need u64_sync for 32bit SMP systems because u64_stats_fetch is not
> protected by the spin lock blkg_stat_lock. If removing u64 sync, then
> one CPU fetches data while another CPU is updating, may get a 64 bits
> data with only 32 bits updated, while the other 32 bits are not updated
> yet. We can see that blkcg_iostats_update is protected by both u64_sync
> and the spin lock blkg_stat_lock in __blkcg_rstat_flush.
> Thus, I think we should keep the u64_sync and just add the spin
> lock blkg_stat_lock, not replace u64_sync with the spin lock.

I don't get it. The only reader of blkg->iostat is blkcg_print_one_stat().
It can just grab the same spin lock that the updaters use, right? Why do we
also need u64_sync for blkg->iostat?

Thanks.

-- 
tejun

