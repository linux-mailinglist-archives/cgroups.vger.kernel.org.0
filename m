Return-Path: <cgroups+bounces-3421-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 812E391B022
	for <lists+cgroups@lfdr.de>; Thu, 27 Jun 2024 22:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39AAE2857DF
	for <lists+cgroups@lfdr.de>; Thu, 27 Jun 2024 20:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89E219DF4B;
	Thu, 27 Jun 2024 20:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D+iqcigL"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7B945BE4;
	Thu, 27 Jun 2024 20:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719519010; cv=none; b=YFRHR7wRxOGWDmtce+g60VBJJSwoc15AO4XlovFDqNOEIBB3FXx0BgZ7yTrJknFGw+snZ/6OBxJI9Sk37VdQRCBBurcKS4Zh3ldgwWsIwyivFN4MsFzBGDtVQD2D0Fi5qIx2QKyqyxNyEBjWygoaoZUK7yjS+cevtV1ZsCRMPkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719519010; c=relaxed/simple;
	bh=DpfdFuOhqUucDrMCIF6H7EJVyqbWI7XGELgzC5TEoxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BaK/PzzmcwkqznU8D10F1IQ1KdQ8t5+ki0kgw10IoJuQeX1vEroHzhSHbx7HGa4O1VIDieig87YSCNRRs18GjXnz/2lmarohnd+4cVFVOUlp+Bsuv9kVRxc0DHE7BYGVtKfvE1CBy93WtLrDxhVAA/vV5zPTvqb3X9Y46ckHHmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D+iqcigL; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-70685ab8fb1so4008151b3a.2;
        Thu, 27 Jun 2024 13:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719519008; x=1720123808; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yMywSyrqyqgtj9q+Vb/QcUbABYB2OnAWGsqqi1w/fr8=;
        b=D+iqcigLsUn9wCx9hdpSvgfSttUbkOBNkIoPJF8/7V3VKwGhdeJOa2RL5q1WXf6YZR
         1I7kZ7sb17+DDTAgWkWDHBsaHA6WyGhknXnUue0mBHWJBnaYmbI81kbdyZ8Egy6reOqg
         sk3LkD7bCh+XCRmkvwagYlpkL4UK4e1XFKdfOQKXyVT0H4cAYzBlxEWmFQGi6XtLgEEs
         hXg37qN9CK8f/yhvgeq28CTYGKguE+OkOOxyvdin715jCeb9zjWG3BhBx2dZnxZ2FqbD
         mL/t6NN+kPqOnTIssBrUXF7RcRF2hOGCK4//sKHr+XxSDD6XyMiVyk8GyBa4qN88tSVi
         pBMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719519008; x=1720123808;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yMywSyrqyqgtj9q+Vb/QcUbABYB2OnAWGsqqi1w/fr8=;
        b=p/Z6N9HKlpqn2kg4s72miJ/Bj1NnfalAuF7i4z0y4YuE+F5nkkm5NbNohmqkwfqmxD
         mpBnnk6xttZ35V86gniQxrQuE6SaZvZ2nR7t3xCfj0GiojxCFCzyYkP4KtsX83XXk/xT
         s5KB4hRHPEWy66iROFbIACGNYUPGxAAUbcQ4oYJ39KMFs9ucseVVMPCc/y9cnxr+qKyi
         xPBUTGgeLaaNa3SI/ePwa1WuC2BU00OVzwayEtx+Q21geTEyCJVC0aQVH2ftLpl0uN3E
         /UTm8DmgeufE1eRYKUTkRs6ZpGThJf626pbOlbVigPvlRIoEWvMbQ4FbSumaIAIWW0vl
         1kJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXm1obwMXB8zJuqp1ds0ast8iXxNTt44roZJt6CVKVKe9Kjj/xsJt5Ex61+ThiCdd5soAtgRBDz95nXDrOaYMBarAcIrsKCR+u11gc3uKzzVH+8ip35D3DDbRcuorTBMiM3w5xxJOtCuKYxZlD3HqK+VRSq4yCG+6umG7xBcjaH8DK0
X-Gm-Message-State: AOJu0YwH4cYvO0Zw3pW98byCLMmUi6K9ZiWziqbAGnuxlOVIAemDlAgX
	Hn/cR7/wcsA96KKyPqrsnQ/veO9pO+bun0j79gPqp4jJ6g6hJmor
X-Google-Smtp-Source: AGHT+IFnebtZIe/zK82pVrS8B8BYadWfNxg2e/WCrOLvCIC1x2GR4N2qDT/roI6qLuCfzPAU+E/z4w==
X-Received: by 2002:a05:6a20:96c3:b0:1b5:ae2c:c729 with SMTP id adf61e73a8af0-1bcf7e7ec21mr14632064637.19.1719519008272;
        Thu, 27 Jun 2024 13:10:08 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac10d1498sm1629115ad.8.2024.06.27.13.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 13:10:07 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 27 Jun 2024 10:10:06 -1000
From: Tejun Heo <tj@kernel.org>
To: Li Lingfeng <lilingfeng@huaweicloud.com>
Cc: josef@toxicpanda.com, hch@lst.de, axboe@kernel.dk, longman@redhat.com,
	ming.lei@redhat.com, cgroups@vger.kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	yangerkun@huawei.com, yukuai1@huaweicloud.com, houtao1@huawei.com,
	yi.zhang@huawei.com, lilingfeng3@huawei.com
Subject: Re: [PATCH] blk-cgroup: don't clear stat in blkcg_reset_stats()
Message-ID: <Zn3HHvcgZruLkMdn@slm.duckdns.org>
References: <20240627090856.2345018-1-lilingfeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627090856.2345018-1-lilingfeng@huaweicloud.com>

Hello,

On Thu, Jun 27, 2024 at 05:08:56PM +0800, Li Lingfeng wrote:
> The list corruption described in commit 6da668063279 ("blk-cgroup: fix
> list corruption from resetting io stat") has no effect. It's unnecessary
> to fix it.

I find this paragraph a bit confusing. At the time, it was broken, right?
And if we were to memset() now, it'd break again.

> As for cgroup v1, it does not use iostat any more after commit
> ad7c3b41e86b("blk-throttle: Fix io statistics for cgroup v1"), so using
> memset to clear iostat has no real effect.

Ah, okay, this is because we made the stats blk-throtl specific but didn't
implement ->pd_reset_stat_fn(), right?

> As for cgroup v2, it will not call blkcg_reset_stats() to corrupt the
> list.
> 
> The list of root cgroup can be used by both cgroup v1 and v2 while
> non-root cgroup can't since it must be removed before switch between
> cgroup v1 and v2.
> So it may has effect if the list of root used by cgroup v2 was corrupted
> after switching to cgroup v1, and switch back to cgroup v2 to use the
> corrupted list again.
> However, the root cgroup will not use the list any more after commit
> ef45fe470e1e("blk-cgroup: show global disk stats in root cgroup io.stat").

Hmm... I'm still having a bit of trouble following this line of argument
given that all the patch does is dropping stat clearing.

> @@ -668,7 +645,6 @@ static int blkcg_reset_stats(struct cgroup_subsys_state *css,
>  	 * anyway.  If you get hit by a race, retry.
>  	 */
>  	hlist_for_each_entry(blkg, &blkcg->blkg_list, blkcg_node) {
> -		blkg_clear_stat(blkg);
>  		for (i = 0; i < BLKCG_MAX_POLS; i++) {
>  			struct blkcg_policy *pol = blkcg_policy[i];

The patch looks fine to me although it'd be nice to follow up with a patch
to implement ->pd_reset_stat_fn() for blk-throtl. I'm not quite following
the list corruption part of argument.

Thanks.

-- 
tejun

