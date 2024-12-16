Return-Path: <cgroups+bounces-5916-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F5F9F3895
	for <lists+cgroups@lfdr.de>; Mon, 16 Dec 2024 19:15:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECFE41897A61
	for <lists+cgroups@lfdr.de>; Mon, 16 Dec 2024 18:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17C520C49E;
	Mon, 16 Dec 2024 18:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iHuMGqaz"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B5320C497;
	Mon, 16 Dec 2024 18:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734372170; cv=none; b=arrFv9cBD68P1TVtoXTZempUY4VKk1dSZixVC+bFp7WtOV4tKSHJ1MRJZC7jopqzYBlktkTXV9NBxbx5KxEBu8Xq/t2qvXuU3o3dFg92GZLPHRCt8LhskUJzFt8f4JCYbZFbhIQGp8cWEasVs/GX6sk6wHvwO5B0t+5kbCS0D9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734372170; c=relaxed/simple;
	bh=7r9c04dOc+yHgaXpU6G6m/nUjFltmqA9lQpTmETal4w=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LhFOS+Y4FJa4poU+9qFqnrrZOTq9kAf1nuoEO+Lf4v8ifSy/8+2u3qu3Aekq6CeLgA5h2rcIyZMz8ANMOlzx22l3k4ontoCKbz9M1qYay55008jviHD5fIzbbSf9esOpl/igyv8EBB/r4zc2p4tVSmOO60J2AxxAcbqwqK+0LvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iHuMGqaz; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6eff4f0d627so38826697b3.1;
        Mon, 16 Dec 2024 10:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734372168; x=1734976968; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HXd/dBb3HmIZIRXjW3/mAJKbzp61Mw3WwK1eeiRGBB4=;
        b=iHuMGqazKk7FF9JBmtZjrppCEInZS6ghHaFc/Fj3K7KwnO8q6rz/ZVcAID/LmW5wHi
         FM+n9ytTkKPZetRtic7zBArjNFirz6spHYlSOVyEb86tzpNgu5nxNw/IZQparNCB2oU6
         uc2OHiUCQ4UuOoaAXFTYc/y3i7gLVYk7bYvPgPM1gEj73RDo44PQ/Euw7nahsnKW5vyH
         UW67iTPv0h/7w2pALBz2QFE1DJlXS41pv5aCqf8ksEYT4PBwwZGrx+QOUcQHGQcV0Sqm
         8gt+WEFJt8obbWXIiehQq4i2ESzgxnoxscpInWrbnmvcKOxDrx1r6DR1WUcCptRQJ8cQ
         LXqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734372168; x=1734976968;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HXd/dBb3HmIZIRXjW3/mAJKbzp61Mw3WwK1eeiRGBB4=;
        b=I3CiqcjkECYdjphSpekJfwopcH+LhlbcfYcjREsq+bb8lXIF2ztiC4mamzCR/Ujhhq
         pHPzrFXsiWMZDgoPa1XFKnkW0geGIn8XoNws0qxVK6/rNgDlipfPnQ0wa3pCMJYgYzEC
         F3eO0TyngkVZmRR8J1ZwK2Ov5SXcc5rvfJrGiDhdUqDykE4YsWCMSZ4mDxFiRy2M+3FB
         WxpKIuiE+lVo8NmK1igY5mc2UxuRsbWWYzB8LZRs7ymCzEE1CM81ybPw1PmKHnTg+IfL
         3Pbvyht0YV4nFDxJ2AAUR3OBRGWVD8YLj8kstYKNoDhcyq4F9J+GBVfrc06RdlfdP8hF
         geBQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7KquD+fY6XiX41muRnQILFtOoIsj3uajZRPrmgEI9e7Jk6aax3LxwsuiEIFqKXwqsMJTKrvQr@vger.kernel.org, AJvYcCUJaHE5ZRveObo+8VyWAW8CsKKklHUO7g75jIcx3Y0e6addRMJXIloVSM8hBFTd1zDHakiFeOgnrr8TgyUE@vger.kernel.org, AJvYcCWGctIKu0VRMdWmjAH5yEJfGJ4ptmCxwoDxPC6F4yXroFkj18B7O/H78uaV9d+jNiFVSzd1+yu8L67lp9I=@vger.kernel.org, AJvYcCX+tHimgqvAGic9XUJZE02P8lWrMlKcX2gL9faQJ2CjiA96lPxYz2pliBLHf6ChcHoum58j16sWYtz2@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6R/hlhW6ouqqOBHs+PQzI6LfVf/PON2f7c8nY8nfG6JSM++tJ
	HOeambFtN6C/K+NI/zZwM2MWuqh8qpP3ArxThNWfkW0sEPmYIyUC
X-Gm-Gg: ASbGncvdkfbjGEFXc0HUa307S4iysXQKgH733Vd0o8RE/USJjYrvVVPRtQdFn0QG7e9
	RW4IyY8vKBsg8KUD6rdaAlBBDu5MmNhERDTrVnD8EniKY5TpYLpBg4EU9dI2zGTWnsZEHgzgDJm
	KO7/dsu0VE/rI1xbnamOWrCC46CxziBsAZBsFh43HcUWugwIblH4cjsv/w8VJApFKzSUtP0/80B
	D1a8c5neN2+mjlC8s7irkJMrs7/Be9OdbsHA+++cA==
X-Google-Smtp-Source: AGHT+IEH9zhvlyitgwYz57XScgCMDXbhJVNYBS3Lo35TcrTWwYdgyEsqwD8imarORjtPrw556sRTSQ==
X-Received: by 2002:a05:690c:23c1:b0:6e2:1bba:ed4c with SMTP id 00721157ae682-6f279afe776mr131155757b3.17.1734372167927;
        Mon, 16 Dec 2024 10:02:47 -0800 (PST)
Received: from fan ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f288ff238esm14631927b3.29.2024.12.16.10.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 10:02:47 -0800 (PST)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Mon, 16 Dec 2024 10:02:35 -0800
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>, Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
	Boris Burkov <boris@bur.io>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-block@vger.kernel.org, linux-cxl@vger.kernel.org,
	Zijun Hu <quic_zijuhu@quicinc.com>
Subject: Re: [PATCH v3 5/9] driver core: Move true expression out of if
 condition in API device_find_child()
Message-ID: <Z2BrO0rVHCN8HXcg@fan>
References: <20241212-class_fix-v3-0-04e20c4f0971@quicinc.com>
 <20241212-class_fix-v3-5-04e20c4f0971@quicinc.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212-class_fix-v3-5-04e20c4f0971@quicinc.com>

On Thu, Dec 12, 2024 at 09:38:41PM +0800, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> For device_find_child(), get_device() in the if condition always returns
> true, move it to if body to make the API's logic more clearer.
> 
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>

Reviewed-by: Fan Ni <fan.ni@samsung.com>

> ---
>  drivers/base/core.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 8bdbc9e657e832a063542391426f570ccb5c18b9..69bb6bf4bd12395226ee3c99e2f63d15c7e342a5 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -4089,9 +4089,12 @@ struct device *device_find_child(struct device *parent, const void *data,
>  		return NULL;
>  
>  	klist_iter_init(&parent->p->klist_children, &i);
> -	while ((child = next_device(&i)))
> -		if (match(child, data) && get_device(child))
> +	while ((child = next_device(&i))) {
> +		if (match(child, data)) {
> +			get_device(child);
>  			break;
> +		}
> +	}
>  	klist_iter_exit(&i);
>  	return child;
>  }
> 
> -- 
> 2.34.1
> 

-- 
Fan Ni

