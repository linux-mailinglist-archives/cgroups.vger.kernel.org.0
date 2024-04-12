Return-Path: <cgroups+bounces-2449-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 989CA8A353F
	for <lists+cgroups@lfdr.de>; Fri, 12 Apr 2024 19:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54713283995
	for <lists+cgroups@lfdr.de>; Fri, 12 Apr 2024 17:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70A814E2E1;
	Fri, 12 Apr 2024 17:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kiHZ3jIC"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A3B14D708;
	Fri, 12 Apr 2024 17:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712944751; cv=none; b=nM8WsaN3jnWc/YYLGLv9bUk9Fg7X1ASPhfwIPmKkOOE2xI9WeLdhMwofZVTne5Q4xe9tMdLDMn9ubLde2PX6u1QJIuT//oMt45BwCkCKpA3iFkaruc/L+l36UAvfEqpKA2YHzsjKWmsy9DyuiyZUIyvEqigtBHS+w/lRHANegFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712944751; c=relaxed/simple;
	bh=xW9Pannq9Ylm/ehaUAnV09AHmSwQXxi12MZV+pE8Smw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cCY4CR7sksdHC5bsms9Kf3N1sJPNHbEKzfPL5evBr4MYxRLfLL3gqpw6/GKhIJHpfP4qGlLccZr64gUikNb56sW9Cr+L2ITJVajgmU6rntVou9rzSVno7b7VEQ2ul/uJ0f0+Ai15D/eArl9yozxqWiJqtbvpQJTj7GvvPKe/F1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kiHZ3jIC; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1e455b630acso6045755ad.1;
        Fri, 12 Apr 2024 10:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712944749; x=1713549549; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RwtixN/lO2iBv+anS3Drzlg4Mbq3JF5eL0nymgRd5Qc=;
        b=kiHZ3jICXJwyhTdvTLBDtwWJXvph8/TpsM4q8RKmcvYRlw6SR9sEhBnPtP8mHxwQab
         pYn3IIEJv/5ABFVxc2zTvlROoiWuPkZjfGNgHxVUDcleAdmFD+rDPrnq3DibBTGLwJTl
         BxFvpHvZmRD8ai4SKUrvYUZi8IFx/3eReWrSXC94qTuDfi3SDZyp9ubgdk3NYc+laKAT
         DLonS3Ks7NYvr0UyKQAQ0k9KwmrJZk/APR15xYXSOmOCE3uZ3haj6wftqwxz9CJA4qph
         /NtUs3CCjknCBYkt/I0FOwDiMQwAEr3mKYcFaDHB+LbCTvXiNxpj/XI4zpuXufPpyyt5
         q71g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712944749; x=1713549549;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RwtixN/lO2iBv+anS3Drzlg4Mbq3JF5eL0nymgRd5Qc=;
        b=UMGF9UVEohDiRZg4JRxzaEgLb10w3OimYhfhqnniwYdF1Ez8+jNww3fexPFAoUF5Sz
         92LMttr8fm/2TWmwujWDw0k/rLHMY17ZmM+ijOZH01kRUcKJ6RAbTLIASLjgDsVmI53s
         +sbfwKpn0lG+SHjjAZinzKBFRLnmODHRrL/u/J+3ijz0LMM3WUwTDO+XofVNdsyWP/GN
         upm4VuwcDLtqOFXEe+MxGTjgVURBDd3CmNzosZhRV8wcwufojPYkqtD+TKox2ZpKtGjh
         B++22IbLJVv6CA342G4ggdo0HjcFge+xEZlYpQORy9OFsbncTqOaDT1PKSzTp6RWJ0/d
         Nmig==
X-Forwarded-Encrypted: i=1; AJvYcCXKfbK1tkK7gOQEe62fXkECfQ4mSeUGhoR8CbdHrOTfOSkRZ6BDp4YK/iukwnpE8ktmnXL6IcoUgL8KMf40Bu3UptK/xMR0NAq79LjDI/ARdg9HIiim/npQJnnBU1eNgCOzWvAX2lvgzV8YUW3O2LMFqGhWfgAnhYQJv1bktsWdN167
X-Gm-Message-State: AOJu0Yzk/kbTKiXnxUDuycSmCQV1hGTg7jZqg8/acwEZsEolBE0ALqBg
	Q+Wdi69AvFhxtPKaN/zBnvzdDsfhdBQ/LUXcWt9c6vxYSBVr6ukN
X-Google-Smtp-Source: AGHT+IF9m8VYtSEPQPguK6wUbN5cQCjmnQWPkTPp3hExAb5QN79ynN2Hsf6aHQoYDXqTWIsKnV486g==
X-Received: by 2002:a17:902:ce0e:b0:1e0:115c:e03c with SMTP id k14-20020a170902ce0e00b001e0115ce03cmr3677174plg.53.1712944749482;
        Fri, 12 Apr 2024 10:59:09 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:a5f4])
        by smtp.gmail.com with ESMTPSA id l6-20020a170902d34600b001def175bbbfsm3276304plk.251.2024.04.12.10.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 10:59:08 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 12 Apr 2024 07:59:07 -1000
From: Tejun Heo <tj@kernel.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: axboe@kernel.dk, chenhuacai@kernel.org, josef@toxicpanda.com,
	jhs@mojatatu.com, svenjoac@gmx.de, raven@themaw.net,
	pctammela@mojatatu.com, yukuai3@huawei.com, qde@naccy.de,
	zhaotianrui@loongson.cn, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
	cgroups@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH RFC v2 2/6] blk-throttle: delay initialization until
 configuration
Message-ID: <Zhl2a2m3L3QEELtj@slm.duckdns.org>
References: <20240406080059.2248314-1-yukuai1@huaweicloud.com>
 <20240406080059.2248314-3-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240406080059.2248314-3-yukuai1@huaweicloud.com>

Hello,

On Sat, Apr 06, 2024 at 04:00:55PM +0800, Yu Kuai wrote:
> @@ -1480,6 +1547,9 @@ void blk_throtl_cancel_bios(struct gendisk *disk)
>  	struct cgroup_subsys_state *pos_css;
>  	struct blkcg_gq *blkg;
>  
> +	if (!q->td)
> +		return;

So, this naked test is safe because the interface functions are shut down by
the time this function is called.

>  static inline bool blk_should_throtl(struct bio *bio)
>  {
> -	struct throtl_grp *tg = blkg_to_tg(bio->bi_blkg);
> +	struct throtl_grp *tg;
>  	int rw = bio_data_dir(bio);
>  
> +	if (!bio->bi_bdev->bd_queue->td)
> +		return false;

and this one because ->td is set while the queue is frozen and this path
shouldn't be running while it gets set, right?

Can you please add comments explaining why those are safe? Otherwise, the
patch looks generally sane to me on the first glance. Can you please also
add how you tested the change?

Thanks.

-- 
tejun

