Return-Path: <cgroups+bounces-3778-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C34693537F
	for <lists+cgroups@lfdr.de>; Thu, 18 Jul 2024 23:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C11BC1F2184E
	for <lists+cgroups@lfdr.de>; Thu, 18 Jul 2024 21:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740A977107;
	Thu, 18 Jul 2024 21:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ChBNs4ui"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81D43A28D;
	Thu, 18 Jul 2024 21:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721337333; cv=none; b=Oe81KO6OSd0EviIxoQl0BT3cvS4lPNURi7IJh/5lDlHlNovDMmZ1SXMfH+KE3tVdHVY0iFbXNe9Oj5vg09SkS+q/7MOsrrN+y58m5uGAIBBAAeH21PDy3fouyUEO61jRVw0YslqWD3ONRLKWmbewOeZWcmmPD1W2HtKcDTIi9ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721337333; c=relaxed/simple;
	bh=9mJ5wmdO4bm4+n7EafdLXeF8u89gMbbd3ZwBipeTu6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DQ3V+QxtyRMULGX9g0QvVUMs0g4jEbFYMWYv8kmondDQ9lyoxlRG77qRnhsPuoySIHtUXyKw5rUuOjR+4cJufMu04RQzS/f9O6TAe9o5lVoJuirAkPXaUOB82NLt5NSHaCsSKSFu6aRJiwl32VaIhB+wWN4cdo3BZAsS/G2QpNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ChBNs4ui; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-75e7e110e89so791837a12.3;
        Thu, 18 Jul 2024 14:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721337330; x=1721942130; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/0auihaX9QkuNb5Qm1JcvF0jC8t0q/ycofneQ+RbNug=;
        b=ChBNs4uim19hnSoNEJIdJbKfsfaHx4fHq9607fIi2uJkTqloRgBzd+eF7+OEHBUMCf
         5wvmdoHrKQBRqDU/223Teo88B/xmPpuHJqc64GZH/yVrKQBDExieZFfW9PFuDArQL1gS
         1F9bzGIbwjosW2AFzBMpvw2kK+Lo5FD25YKUYzG/PPNSKjPUk1dTg7R3oJevaleGrcqv
         3DtDxFpXuul3U2MNpLfS/Yafk7AjKmPznB5gzkitCQRCPP+Rx0yGc8h0ENdkoV3wYTaS
         qPh7UdFHeyHAxPexNuutGEZT5nRS1a8z6ap2lU7JuniOWumE//ih8m/zVIUUvbdvpjQB
         IiTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721337330; x=1721942130;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/0auihaX9QkuNb5Qm1JcvF0jC8t0q/ycofneQ+RbNug=;
        b=Ua9GXaZpdFQ10FyBBjjS0YBgM3pJ1hk7zBv67g+lloA67r20ib2N94kwNvI548g+Nw
         YZaD0xww9RemKE2kIc/fG6MBmPL8gWAc3FcWiQNMncibwJV+en+eQ9J4J1C/r9PR+2fH
         S21rfWWCZ+v4fgrSQJ1pMdaq3XPu+OFH8QJl0Yxc4W6vf7c8R3K6p5LYdaFlMicC4QU+
         PX7S1B8p8yDa/bIYuaFHI6KEtvHkwmubT2B23A0e6d6VqsAv/tuvNcqoiqYqSE5qUt5S
         QAvZmGtbNvuFqt3V3MMKih0HAlB+CeQOlcbtvggXpvWP4uFEyWU7//zScCUh9jFbXglV
         +sIA==
X-Forwarded-Encrypted: i=1; AJvYcCUZXkFYuC/RaLMuzjuvIV289hqTn0+dOUJ/bIXU5f+Xq3UEEpEOJCnXTilqpARbxXuQ0Sk+GasCD6qcIIU03EIuByWM2VHHzlfil93qmZrDf0mybuZV5RX6zA6aOZVFfG2xid5nnzgGub0mh4Vb8PXjZ3fJO5l9Q44jnv0vw+rhFq9Z
X-Gm-Message-State: AOJu0YwyBXzBDs0XuFDqf8rtWF3E2JPT+HOup928YUyDjfVONG3i4Gdj
	uWsc19XGxCExWvaJYIpGD/DrhXAYd9id+qzSTH0uEkmLfAzqbYTX
X-Google-Smtp-Source: AGHT+IEzvKX6abFCuyAD2x0BS8ix3G4cXfdKksDDsoZuZtDnnZow0Vh1MnuqD3v6DJxjydy4SuuorQ==
X-Received: by 2002:a05:6a20:c901:b0:1c3:b2da:cdff with SMTP id adf61e73a8af0-1c3fdb10556mr6962771637.0.1721337330009;
        Thu, 18 Jul 2024 14:15:30 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd64b4a29bsm174255ad.15.2024.07.18.14.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 14:15:29 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 18 Jul 2024 11:15:28 -1000
From: Tejun Heo <tj@kernel.org>
To: "boy.wu" <boy.wu@mediatek.com>
Cc: Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Boris Burkov <boris@bur.io>, cgroups@vger.kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, iverlin.wang@mediatek.com
Subject: Re: [PATCH v4] blk-cgroup: Replace u64 sync with spinlock for iostat
Message-ID: <ZpmF8HJsuefjC7Xr@slm.duckdns.org>
References: <20240718084112.12202-1-boy.wu@mediatek.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240718084112.12202-1-boy.wu@mediatek.com>

Hello,

On Thu, Jul 18, 2024 at 04:41:12PM +0800, boy.wu wrote:
>  static void blkg_clear_stat(struct blkcg_gq *blkg)
>  {
>  	int cpu;
>  
> +#if BITS_PER_LONG == 32
> +	guard(raw_spinlock_irqsave)(&blkg_stat_lock);
> +#endif

Can you please collect the ifdefs into a single place? If guard can be used
for that, that's great. If not, just spin_lock/unlock wrappers are fine too,
but please collect them into a single place and add a comment explaining why
this is necessary and why u64_sync isn't being used.

Also, for blkg_clear_stat(), we're running a slight chance of clearing of
iostat_cpu racing against state updates from the hot path. Given the
circumstances - stat reset is an cgroup1-only feature which isn't used
widely and a problematic interface to begin with, I believe this is a valid
choice but it needs to be noted.

Thanks.

-- 
tejun

