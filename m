Return-Path: <cgroups+bounces-3568-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8999992A903
	for <lists+cgroups@lfdr.de>; Mon,  8 Jul 2024 20:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BF5DB20A26
	for <lists+cgroups@lfdr.de>; Mon,  8 Jul 2024 18:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67886149C7E;
	Mon,  8 Jul 2024 18:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kkqajD8d"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C277B28EF;
	Mon,  8 Jul 2024 18:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720463800; cv=none; b=Hzx9SJYhpmHLf5YPDylXrplPtshfOA4DRAhlYf3uY3ToIt+CW9i45+CJjf0wf7phxoVEvtBm0YRmbSyzwgQHebmX34BA6MdY2ASP8V4jB71IHYv+de1tMSZwsNz5tqfUTPQaFbskv52RBZVJxfj76N0bEJWHqBnpxyiiG8SmisY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720463800; c=relaxed/simple;
	bh=uWwiSH1y5aQSRVuNlZqRSfHC4+897VGGeVa0Dma8v/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bmI3xiHeRHWUubwjeSsql4d4DTY9zcVrsBLp3PfobZPnxQKvmNdfW1loPUICtXRe/aKjMbLZtk6mfPWnWpctcay8H5zrE6JpCMaEkYbOp+Z5rDtakwjeapnq/OKc9syVWV0GEhislEItsA5VYPXPOhZ6ybtGk4A8vCbn+3OTS2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kkqajD8d; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-70b0d0fefe3so1995631b3a.2;
        Mon, 08 Jul 2024 11:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720463798; x=1721068598; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1l7RkZW4K42K5HhDc9XjSgo16KpDrBeYr4KAsv4pJqw=;
        b=kkqajD8d/UHoPKnH3G3f98ElQooY+ix/d5tNn1KdhaqZk6ompMBBsVfqSE5CaRMVtK
         7e8fvevqLtZHpFDU0dkegIx81bl0WoZYB31CruDxRil9nbxM2h6N1p7gTF/jnZGIzs04
         j4lsX0jWh6VpIxljjnFbH0LxOW2nRXLJuNEECt4Vmn5gjRK9jTW3bG39C6vhdtf6cwar
         NZ/iMZx/nhtASAU7Gmj0A4GRh4KgI+TM32yWRnk09OVdaBbDPw/2ujUlOejbyNaR4Hdz
         lM51FOHYuN54G0Sc8q2h8m9IgdHCEWHuinn7dWCylkmqOZfonyun2NKKyPioO3LRIMMo
         v6gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720463798; x=1721068598;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1l7RkZW4K42K5HhDc9XjSgo16KpDrBeYr4KAsv4pJqw=;
        b=k0hpCn/RWQvPh+dHfHNGD/llRLbnoeisRZbvyudyICG7WB5zyeJZUZD7eAVn0brczJ
         aounzXKNUJXNPZafYzW7T6rgGXgWMSApzU/g0Tgk1tUqqeb6ucSqI9Zq/Uo1+QXnm+Lc
         WLVS+CLCEqRS6+nw/RZfrSGEYzsgr50Pq+SoCIXuAVaS6dr1IvGdSx63zUATbTtqLRFN
         vVRN3pMZejSDejnaP4tkZnbEJTX5S6ecsLfDhoUh+7aybv2WOmHN5u/y+ZKRk3J57uB1
         s73qGKandqtucRGFiISEqEer8pRVh9+8BU2G+WuG328kyoSfjioKhNabaHScc8Nj+bIG
         ubcA==
X-Forwarded-Encrypted: i=1; AJvYcCUlEMCmha4+XFd5p7elnGwheYdhPS24X2ODU4IjcPEBxdw+S95rrkjxePoAzGG38QlG4VTUmp7qbgXZtErc2m5/ZEuFKgFNYGtYC/Iga23bSDMtA3uZwMztTfGeMNXHCKXDkZxrasPAMm4oF8AXDhLMby1W2YQnxfBC9rE6nEx0Y56R
X-Gm-Message-State: AOJu0Yz913llQG8Rr7pYFBbAsJvR241k1bwmJWsl17kaArPpAZSYI/s8
	Q5ibMOhOpLj86E/csNc4p43vuwQj0qWsT/NATs/joipjN45dNjgd
X-Google-Smtp-Source: AGHT+IGP53V6v/ZzF/GFlM291/YOeHzaTpwzKRY4M+ixCU8gA3K0CAlN8WMbRLVroxdlsy54+98hiQ==
X-Received: by 2002:a05:6a00:198e:b0:70b:122c:856 with SMTP id d2e1a72fcca58-70b43627217mr550042b3a.31.1720463797887;
        Mon, 08 Jul 2024 11:36:37 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b4389bd04sm198121b3a.24.2024.07.08.11.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 11:36:37 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 8 Jul 2024 08:36:36 -1000
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
Subject: Re: [PATCH] blk-cgroup: add spin_lock for u64_stats_update
Message-ID: <ZowxtI69yd4IexQY@slm.duckdns.org>
References: <20240705075544.11315-1-boy.wu@mediatek.com>
 <Zogpum23mjHZC8yO@slm.duckdns.org>
 <709276ca279982cf0014e93eafaa2272f847ff4a.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <709276ca279982cf0014e93eafaa2272f847ff4a.camel@mediatek.com>

Hello,

On Mon, Jul 08, 2024 at 02:00:42AM +0000, Boy Wu (吳勃誼) wrote:
> When accessing /sys/fs/cgroup/io.stat, blkcg_print_stat will be called,
> and there is a small chance that four processes on each CPU core are
> accessing /sys/fs/cgroup/io.stat, which means four CPUs are calling
> blkcg_print_stat. As a result, blkcg_fill_root_iostats will be called
> simultaneously. However, u64_stats_update_begin_irqsave and
> u64_stats_update_end_irqrestore are not protect by spin_locks, so there
> is a small chance that the sync.seq.sequence will be an odd number
> after u64_stats_update_end_irqrestore due to the concurrent CPUs acess,
> because sync.seq.sequence plus one is not an atomic operation.
> 
> do_raw_write_seqcount_begin():
> /usr/src/kernel/common/include/linux/seqlock.h:469
> c05e5cfc:       e5963030        ldr     r3, [r6, #48]   ; 0x30
> c05e5d00:       e2833001        add     r3, r3, #1
> c05e5d04:       e5863030        str     r3, [r6, #48]   ; 0x30
> /usr/src/kernel/common/include/linux/seqlock.h:470
> c05e5d08:       f57ff05a        dmb     ishst
> 
> do_raw_write_seqcount_end():
> /usr/src/kernel/common/include/linux/seqlock.h:489
> c05e5d30:       f57ff05a        dmb     ishst
> /usr/src/kernel/common/include/linux/seqlock.h:490
> c05e5d34:       e5963030        ldr     r3, [r6, #48]   ; 0x30
> c05e5d38:       e2833001        add     r3, r3, #1
> c05e5d3c:       e5863030        str     r3, [r6, #48]   ; 0x30
> 
> To prevent this problem, I added spin_locks in blkcg_fill_root_iostats,
> and this solution works fine to me when I use the stress-ng --sysfs
> test.

Ah, okay, so, there are two usages of u64_sync synchronization - one is for
blkg->iostat_cpu and the other for blkg->iostat. The former makes sense and
is safe as there can ever be only one updater with irq disabled. The latter
doesn't work as there can be multiple updaters and should be removed (and
replaced with spinlock). There's already blkg_stat_lock which probably was
added for a similar reason in __blkcg_rstat_flush(). Can you please update
the patch to remove the u64_sync usage for blkg->iostat and replace it with
blkg_stat_lock?

Thanks.

-- 
tejun

