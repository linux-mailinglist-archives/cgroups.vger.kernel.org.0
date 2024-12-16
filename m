Return-Path: <cgroups+bounces-5915-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A859F388E
	for <lists+cgroups@lfdr.de>; Mon, 16 Dec 2024 19:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FBE31896C81
	for <lists+cgroups@lfdr.de>; Mon, 16 Dec 2024 18:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6297B20C01A;
	Mon, 16 Dec 2024 18:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gWJMnH9e"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4DD207E0F;
	Mon, 16 Dec 2024 18:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734372134; cv=none; b=iKCZzqLkFylY2dTYMk2r5LbkDzXdbZgvU6dV7/qp+o+m3arvt/vBq7Gj0yMMOrOsATDi0JSUQkEH3CQPvTBvon8gICr5owKl1ljk2jc7wQO/20qJY+weLJgZRN8CKs4GfhAdpHZvGlfeMXdEHE5HZM/ZTxsHlzYeMGYprm2coqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734372134; c=relaxed/simple;
	bh=iYShh32HmgKd1ZjnJSc4ZIPQqgTCKJQ4oulpEp8Rw3Q=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NcKCUpOxxbhUpKQs0qu4j226zuU54RA5cayXBPCJslt7X/pX/lkt84lR6Rc1QcK2SWG/hlfKjKm32Q2H8ml6zt4tWF9p1RvnL0li4jinTob0+JnUjUQUhS7KC1U4gGL7rVBdSDkiT8hcEdO3LsnZauWVVvHgCtnrN5o6rYC8bDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gWJMnH9e; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6f150ddc86dso35214477b3.1;
        Mon, 16 Dec 2024 10:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734372131; x=1734976931; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HUpxfBeeKAaYEEh4wcoV+FjNrblIwkU1rZ46j4py3EY=;
        b=gWJMnH9ep1VMHjX4sawvkJTYm0RRWETm2M2nODTA4J59CZnWroYpEVgXsv2NaqPg9E
         K0m51jf1Au5SETkr7FGHQvPtTltB/LeT/AQMs9zh+fb4/EVA46NI1vjq2eUMeIFJImSt
         LoC8UB6WudKc6/3NQ3Sxq6U7RozWqMKOx/1vb5i7652X7tZ4Nzgah/JgLeysjMBSAS/r
         m+ybnABzFcgTC5POFmwPWCRR4dyMiTJhcg0v5y0Y9iqXfnXfik4415dxxSIFAiTE5Ijz
         ugGSD9gon/fZTHT+LKCaRhS3u2xEheijN6z/ZE6peg0Yhen/HSP7q9IntVHxOQhnUf+g
         A/5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734372131; x=1734976931;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HUpxfBeeKAaYEEh4wcoV+FjNrblIwkU1rZ46j4py3EY=;
        b=hugcXhkmAjxuQwp//RU2IgssKmNPVTs93xriiC2vFEoKxnq5qUd4Qb3Syr22j03Z84
         5ipJWXTvVZtdGT8nMz7J4Vvsoa4duWcEVR5VxFoi2u2kdU4kGRLV1nyzrEFtT/nnRWgn
         hAFg5fK+S0F/gSWMrZDwxmV0uTPWwFAY8rHTgeBtV3aOKmQhZSfUqjuhp9+NxrASyN6A
         D4rjXENSdoh0ooIGB2ECGrIxUQC2tywCeOn7xcTfCyDGZ1pqWk7eRXU5s58/S5ThnGFf
         1DlMXpUAvrSfSj0qaxEK/ttA7TWQNofJIfyGR1WX5y/nmeMwEpd6vrwzcpqibprkcBaO
         IspA==
X-Forwarded-Encrypted: i=1; AJvYcCU9n/jNDEul+xtKfS16ElEs/vl6NoiDV2+bA7hKOjPs2l3RIxbUSyRsDf73EtMB34KdJgPzwrNy@vger.kernel.org, AJvYcCUG3Vd7d6AwQqBTkkmx6S0YbyrPWbn1q/ffQcDHCyg6eeajrsskbkvQYuooY3z/CD8RwvKS7a+4Nb0pSKqU@vger.kernel.org, AJvYcCVhViYUtJjkf0pfdGRDGpe2DXHrOW/JH/X7m5qZJK7sbMGYWvzqCPwovsTS4dOuQxtwxU/3Dy/lOBoO@vger.kernel.org, AJvYcCVpycPgQ/gs6MbceAWvlPAd8xsQU/Qstm/kVPF4jxJNMvI/ZpSPaI0jmf+wwV2D/Ly05VKLv5PmAISFq50=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjLrPuMe7vvyUXUknQwCPl/XJLb+WUtmw5dbu+KkdeKhsguB/g
	8JLKCa5EOrTN5brb+AVk0lwUwmxvENrieKUMmsdggy9AeF90IYhm
X-Gm-Gg: ASbGncsadreCLV2UEVC9Wv0r1Vds5WhjzvR8vfQcz6QyXHHGRmaiw1qMpR7SWle86QL
	hUvCQdWyOIDbmudo+PpMPMMWI88MSUlxGprn+blmmGwDH2NA7zg9lawXyzWZvWDOc9pZnvup9wp
	BMB5Ws8UTBDhFPuD90g1u0aoxO09b+D97jAdXLKq7DzNk/bMQl9kpWqQA1cF8pQPB5ORuAT1hEO
	Mu7TWKF77sAAOD+zXNmrifh/kKyC+v6goBMJP1aBQ==
X-Google-Smtp-Source: AGHT+IF7/msRiOgrjCtd0gQTyT8TZlZRVZsEdcH2c+sL/k0quoaKsB+jL8ljDU4qxKYAJkcNZLtb6Q==
X-Received: by 2002:a05:690c:9:b0:6ef:8177:c328 with SMTP id 00721157ae682-6f279b01222mr95655947b3.11.1734372131353;
        Mon, 16 Dec 2024 10:02:11 -0800 (PST)
Received: from fan ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f288fda884sm14653617b3.9.2024.12.16.10.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 10:02:10 -0800 (PST)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Mon, 16 Dec 2024 10:01:58 -0800
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
Subject: Re: [PATCH v3 4/9] driver core: Move true expression out of if
 condition in API driver_find_device()
Message-ID: <Z2BrFjRedjEX4OU_@fan>
References: <20241212-class_fix-v3-0-04e20c4f0971@quicinc.com>
 <20241212-class_fix-v3-4-04e20c4f0971@quicinc.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212-class_fix-v3-4-04e20c4f0971@quicinc.com>

On Thu, Dec 12, 2024 at 09:38:40PM +0800, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> For driver_find_device(), get_device() in the if condition always returns
> true, move it to if body to make the API's logic more clearer.
> 
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---

This patch and the next patch can be squished into one patch.

Reviewed-by: Fan Ni <fan.ni@samsung.com>

>  drivers/base/driver.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/base/driver.c b/drivers/base/driver.c
> index b4eb5b89c4ee7bc35458fc75730b16a6d1e804d3..6f033a741aa7ce6138d1c61e49e72b2a3eb85e06 100644
> --- a/drivers/base/driver.c
> +++ b/drivers/base/driver.c
> @@ -160,9 +160,12 @@ struct device *driver_find_device(const struct device_driver *drv,
>  
>  	klist_iter_init_node(&drv->p->klist_devices, &i,
>  			     (start ? &start->p->knode_driver : NULL));
> -	while ((dev = next_device(&i)))
> -		if (match(dev, data) && get_device(dev))
> +	while ((dev = next_device(&i))) {
> +		if (match(dev, data)) {
> +			get_device(dev);
>  			break;
> +		}
> +	}
>  	klist_iter_exit(&i);
>  	return dev;
>  }
> 
> -- 
> 2.34.1
> 

-- 
Fan Ni

