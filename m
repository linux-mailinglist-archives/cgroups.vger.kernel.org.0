Return-Path: <cgroups+bounces-3603-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B6B92DBB1
	for <lists+cgroups@lfdr.de>; Thu, 11 Jul 2024 00:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D450C1F278B4
	for <lists+cgroups@lfdr.de>; Wed, 10 Jul 2024 22:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88C2147C79;
	Wed, 10 Jul 2024 22:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gq6Udsj2"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550C5145FE9;
	Wed, 10 Jul 2024 22:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720649553; cv=none; b=CtjgpPWGqsYJ2i0nmpmebXqohoQxEUSxaCdkGfX7WX36ptZuNgdCv1OAWGFuQeZO1axI9LtBAWzuj6EKbttcYSRcRVW1CImv/kuMLgJy5YIq4LRgqyuUEW22J5jEvgE7HG/apChu89FnDhVW/VBJqFjgamC522XyJAq6ZRfE8o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720649553; c=relaxed/simple;
	bh=noRLX9xDz0SmvYkQQUwFj5bE6wA8lphoYtnA1lSb7tg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fZZ+yAvyB5ugnx8LU2vbFIgWiYyvCHzmXXtvaYdPqM1NlJM9MivOqRESq5XX02VnE0OKnUpMgx80XjK4ZYPtILKcK1Jx4hhsLX/fljiC8gEpVei7gwPpXUYk9Yqw902YwRrcS21UV0GFEtyFkLSF9KUwS8Ckp2rPnqm7TTLAnxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gq6Udsj2; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1f9de13d6baso1572315ad.2;
        Wed, 10 Jul 2024 15:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720649550; x=1721254350; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XeO+j7EWv8RaWA//CRWcO+n6MAqrnLpxeAvTpgFBQ2Y=;
        b=Gq6Udsj2F9zwi15q0kiYeECGFnU3CSEHckXoVNJ3+PlRKEKs15p6KuwSIc0blpHsp1
         LtKFH4mG5mcIuGWhT5Q3aQDmcM4a1Z58mVRczkE+wk4nVamCm9ikl4WArARfgsOIizsg
         vvdMJF8hzy1e3sYf4y2O83YqdGDt80x7TygxpscACMcG2csZWeSw7YH2ekwOCJ/6Vbof
         XRDqvsvDiAi0wS82gz4FlIyZSMd+w82UEiNZF8yakpppC/EurcnWEN0sGFayWnIO0HmN
         pMeFgcDVUYaZ2H9uErU9UKf2Y5G1m8L2U+rv34tCA8AW2mcDPZnLkwFbooNYX6afcJFb
         Ipjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720649550; x=1721254350;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XeO+j7EWv8RaWA//CRWcO+n6MAqrnLpxeAvTpgFBQ2Y=;
        b=dHEQ+YIwNc5NtJTm/CujCEtj0EZEn1KlCalA/WG16wxQ+JaWPRBInUm4vJjnpO8EyQ
         qRcmotwURXaRNrXSMUD26y7F5pMkN7rYiBA+SuBbfcBn7p0ySIeLOLc7RajOuIIUJt9N
         6vYQxl7SqwYGc7ATPIXP+DSEIa4PFdiEDMnfBAX0a1WQcWLkB8O3aXrSDiyH2y0f4Try
         xV2K0Dz1EQs3IlJUDbIsZ0uCe+C7GNzZpoPMdIxIPqSzZBbfjAaZsAX9fuaILG5LS4ns
         /rlkQMAhudUYRyBdRi3+cKGAu9QbBY6zyCIa5Sl9UvnvxqZpE/nAgSUuHKYKBdBB7TwH
         wPrQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4yAXFVzRKrItvSzRCHYDGCQrJ3g8k1brwqj9IxrmoT3R7UWDydOkJ/vLCWMn6tSe8Be7dQ41t4AbKFtVvx5sSUYA8YkA8bTE9ld1SaQsqRwMz1Msg6zV5sgcdH72HD4Waw5OKBJmhjfuSd1nEA5d9AsYz8qSElKIGb9+oV6WnscS7
X-Gm-Message-State: AOJu0YyjD42HpQyDH9B/ntoG7dqWGG6fN3ypRP/nfKRyyEKFmhxTgtRE
	B6g666BG09ztsrY15R+tQmz1/yZ+8VJRIm76A1OEWuifAiFVccDX
X-Google-Smtp-Source: AGHT+IEi1GFM06igSGbdlFQta76Bolr6tBsgOY76wBjNxJ7X5tzNqbaF4cLKyAbwi2EejYmVer+O3g==
X-Received: by 2002:a17:902:d4d2:b0:1fb:8f62:a7bc with SMTP id d9443c01a7336-1fbb6d53612mr58461955ad.52.1720649550492;
        Wed, 10 Jul 2024 15:12:30 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6a0fc62sm38411395ad.40.2024.07.10.15.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 15:12:29 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 10 Jul 2024 12:12:28 -1000
From: Tejun Heo <tj@kernel.org>
To: "boy.wu" <boy.wu@mediatek.com>
Cc: Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Boris Burkov <boris@bur.io>, cgroups@vger.kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, iverlin.wang@mediatek.com
Subject: Re: [PATCH v2] blk-cgroup: Replace u64_sync with blkg_stat_lock for
 stats update
Message-ID: <Zo8HTD2AD-b51q0C@slm.duckdns.org>
References: <20240710061334.1888-1-boy.wu@mediatek.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710061334.1888-1-boy.wu@mediatek.com>

Hello,

On Wed, Jul 10, 2024 at 02:13:34PM +0800, boy.wu wrote:
...
> @@ -952,7 +952,6 @@ static void blkcg_fill_root_iostats(void)
>  		struct blkcg_gq *blkg = bdev->bd_disk->queue->root_blkg;
>  		struct blkg_iostat tmp;
>  		int cpu;
> -		unsigned long flags;
>  
>  		memset(&tmp, 0, sizeof(tmp));
>  		for_each_possible_cpu(cpu) {
> @@ -974,9 +973,10 @@ static void blkcg_fill_root_iostats(void)
>  				cpu_dkstats->sectors[STAT_DISCARD] << 9;
>  		}
>  
> -		flags = u64_stats_update_begin_irqsave(&blkg->iostat.sync);
> +#if BITS_PER_LONG == 32
> +		guard(raw_spinlock_irqsave)(&blkg_stat_lock);
> +#endif
>  		blkg_iostat_set(&blkg->iostat.cur, &tmp);
> -		u64_stats_update_end_irqrestore(&blkg->iostat.sync, flags);

Isn't the problem shared across other blkg->iostat.sync users too? Also,
maybe, we can just grab the spinlock without testing for 32bit. blkg->iostat
(unlike the per-cpu counterpart) isn't accessed that frequently, so keeping
it simple and consistent probably makes more sense, right?

Thanks.

-- 
tejun

