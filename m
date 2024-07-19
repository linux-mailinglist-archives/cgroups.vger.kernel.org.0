Return-Path: <cgroups+bounces-3819-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B750937B8C
	for <lists+cgroups@lfdr.de>; Fri, 19 Jul 2024 19:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CAE61C21CBE
	for <lists+cgroups@lfdr.de>; Fri, 19 Jul 2024 17:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6CC1465B7;
	Fri, 19 Jul 2024 17:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lTAmH6EU"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D53783A19;
	Fri, 19 Jul 2024 17:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721409836; cv=none; b=LrEoRtLBsfJm/ZvVNc4HOorVPjxHwbmMOsvVkKQar0JTFt/9U47vnoLSx3fMrudjwPSFJAJVQP60n1Aa+Wyiu+ySqiG4GtyRpQdu54KJnNiDyOg4m5ftx0iMdBnAE4mvVf7dM5eIL/CwjxnuKh0FuL0esf2FesumE20KhlZ0HY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721409836; c=relaxed/simple;
	bh=TB7I4linzNl4RNrfp2dWbMAJboA3F2yr1iWc1mqD2hs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GMZbrfufgnBIfV8zaIKkPN9GiA5EIuiwi5UZCfdC771EbbHb1KjptLhcphB2ETyo5IEwi0rUE0I7KA1/kf0l9LEGroYowWXSMXeydc0wd6Lp2R4uv2OOc73DVKo0LrXAuchZSJr+v6cS+95df695kI9DR51vXMvF+wgFiRVvOy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lTAmH6EU; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-70af8128081so904411b3a.1;
        Fri, 19 Jul 2024 10:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721409834; x=1722014634; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TkS//gCMVMuBRd9EzWV7Fa9nwlOYfQmq2cQD6cBevW8=;
        b=lTAmH6EUrS9B4myZ69j7fz8O6AsFlQKfwm7fpwc4+WUeW/cnI6pGEmFgvnSUwESFAq
         IhQGc02KmBdwgSmC1tmcWtUTXRhO9iLKtBIYOxXawIwSAQgTuRMV3gAo/nc8RcklQvBu
         J4ET9X6Vh1ZlljE91hSDrUdeSCWn7K1nP5ZEwHfpy8CnPkjYNq+7FuhhjW+v3WWpHAu9
         TDI0hhScvvP8VrkRUsdsJ0L+vobtpNRuQGXHn48cpfzwVwST2lSXL0zfQ6zYk3nOSGYv
         7ud40uF6mBbNy+VC2E9QFp1zVaPHUNHXrLgVJbcJyGabvDjhjHbI2ApshuU9xnLazB20
         Qpbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721409834; x=1722014634;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TkS//gCMVMuBRd9EzWV7Fa9nwlOYfQmq2cQD6cBevW8=;
        b=eVL2EQnjhmTQpmUohB6+ITqaBR0HZ8TAGh2hFY8stWeecguUwEfuxff+mYbkKPqpty
         9cXSKdud2QbP52ihm2rFTJXr9S4m3Lc6WgHib6OxSguuUd1z67MjpvYR1E0p4EbWO0VD
         LzF39wcAWfDz+Q3n2HO7uAkCWXuAbwNTGgbai9ADCif9HdjmsFPHXgAAG+t6rC2IQ4t/
         2HerXKKuoZyt+c/jMm8AkjJZVrd4OSYsmSvdSdQ/fJLlslWxvbT9mXqVSbO2RPG7k5OO
         kvxbixb2CzkRM6RyVe5+LBer5vRIpngWsBBYHAzuV20TNjTgnNTl4ZtXFQkflWKV/qka
         2YEw==
X-Forwarded-Encrypted: i=1; AJvYcCVN7rgSA4Eh64rrN3Mfbyh40D6cTjNUNWitFAjZkLFWZjJFRbDpaz50riSUdVpCQ+Mv7zAtYs05ZFFvjcstMgECw4+DAc3ZKaBIBTw5nYaNlAg1ESbxn/PkqdksNRLFGCMOuT/T3cUkTxsw94CPUFocxDufDwbm0xIxyvcJKDwQy483
X-Gm-Message-State: AOJu0YxAKmdDqkljEq4imUjAKXgnAFbXgwktTX6tT8BfXYCkdg1DWZhr
	XK/1OCxwhnKBpmoOSD5z+SrTRAn0nRq7FpgmM95BRELM2H6Td2BQ
X-Google-Smtp-Source: AGHT+IF7KMOYvFx0j/Hy6EqPeJ3AWYuSWiqTT7/jmWqFIV32BOgWFqRronPaPlsoWkYe/Dp2WeEozw==
X-Received: by 2002:a05:6a20:8410:b0:1c3:a411:dc49 with SMTP id adf61e73a8af0-1c3fdddad7emr10734374637.51.1721409833778;
        Fri, 19 Jul 2024 10:23:53 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f4313f8sm7223305ad.189.2024.07.19.10.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 10:23:53 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 19 Jul 2024 07:23:52 -1000
From: Tejun Heo <tj@kernel.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: hch@infradead.org, bvanassche@acm.org, jack@suse.cz,
	josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v3 3/3] blk-ioprio: remove per-disk structure
Message-ID: <ZpqhKAvTD2z00kyy@slm.duckdns.org>
References: <20240719071506.158075-1-yukuai1@huaweicloud.com>
 <20240719071506.158075-4-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240719071506.158075-4-yukuai1@huaweicloud.com>

On Fri, Jul 19, 2024 at 03:15:06PM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> ioprio works on the blk-cgroup level, all disks in the same cgroup
> are the same, and the struct ioprio_blkg doesn't have anything in it.
> Hence register the policy is enough, because cpd_alloc/free_fn will
> be handled for each blk-cgroup, and there is no need to activate the
> policy for disk. Hence remove blk_ioprio_init/exit and
> ioprio_alloc/free_pd.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

