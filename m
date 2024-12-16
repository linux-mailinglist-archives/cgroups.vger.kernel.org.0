Return-Path: <cgroups+bounces-5917-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C2009F3898
	for <lists+cgroups@lfdr.de>; Mon, 16 Dec 2024 19:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD9E1189827A
	for <lists+cgroups@lfdr.de>; Mon, 16 Dec 2024 18:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9697A207E1E;
	Mon, 16 Dec 2024 18:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kkAiTTIV"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66E220767C;
	Mon, 16 Dec 2024 18:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734372191; cv=none; b=sTH80DQ/XWIw2GRT+zGD99wHFgtdTaXZgozIlU2hzPQDdBFH2t2/knYzR8AArtUC6JsY/bTK4bm/SpJMtthTuUYvrphgvfYmkc1ULbXXVT8ZgWoR8JgiIYGRKO4FKDurY2VNL0wKaJCzA7TAGMIFDFduswZHZUjlsT59n1bTCwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734372191; c=relaxed/simple;
	bh=tgXHpOhhfApP7bL3hgeAzYLtIP8gzh7N3YzHp9Ad8FA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R+aT/EkcwvsMpHACAb/INZhZand2PwCR6Xj0HX4MmMqkOaQmFQFwRDBjQKhHRBrcGmbqUmB/ej67ztr6apoyU5lYj7yRJWT6Fu9Hjrn9grubOM/2aPDgAL7hIfLzTRqut7RqyTzpEmnOhfy7p41XTCefBs+IEUtO83ILsxdWZoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kkAiTTIV; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e3988fdb580so3364069276.2;
        Mon, 16 Dec 2024 10:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734372188; x=1734976988; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4nIslkjr/lUzk8Ro5349W5wK/vcKAZ1po65rXKiQgFA=;
        b=kkAiTTIVL78apN+8BVyHDFVOkXi+2X7/j2sAZdVqCYF/9bUsyMMhyrHYCNqM798w8y
         a1ciYZkwqUXJdDZ6DMq4hf1CrX/DLePmTv5SnGCzArfVpWz2CS1TZ6H6DhAaX/JcnyM7
         kLzVCFIYtsERBEZ19MlJE2ihBw+YA958+meHjcli3atzmu7ELpFLT+7OMARiR+DWxiis
         Y/OeVSm6UcapazXn/tiUL+98+UJAzxSGhiaZPNYi22yVGfY0yArzx8IjZXPE0dQLLVzq
         6eGBlGUD4qBMrN6LCRSl6amlB8EEivX1vvi5aUHxMo8Ga2gc3kAVygiTC6w289Cz4KLs
         gUnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734372188; x=1734976988;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4nIslkjr/lUzk8Ro5349W5wK/vcKAZ1po65rXKiQgFA=;
        b=YsfojtQ4cOCCVc1n2WtAmdMTbEDoGaq70Q5kXRUAUHQIun6D02/YZvFVcZwg2w8D+e
         b7Go5x0S3FBSgXV1cvvxhmxcFXv9OIze15CBv1XqdA8S7qC+nkl1VkJENBi6qJwy/0mO
         OBnpbpAPQo/eAdDfc3Z3MZmIiTBNEHSEC2AkXhqS9Zg+YgXcoQBESAfyXua77sBx6jW3
         HtVgF1wu6RdzPAEAGUcG6rfYMmZ87RDZQt3hS6ZIuqRE3c8ErzRb4XWvXBXskd4xBvsJ
         SSOMliXVxjVyC3/AqzVEGF9g1io263ane4R3lP0Ye5c1RSgLwCFQcJs5s+egzsL21K4R
         urpg==
X-Forwarded-Encrypted: i=1; AJvYcCUY5qz60/pHi/y0COS/R2tGW9RGTrljkKyHJwZIWVpkHbCbvCnH3bhl3wTR6+3bcbOQKtvOOdnCADTH+0w4@vger.kernel.org, AJvYcCW9JxkIsiPvPC37bn8iXh4WCQf1ucbAs52XCC029bHE83ar7cPa5jAsK7ha1v9E8oPshBbIwTCz@vger.kernel.org, AJvYcCWi0xZO9MvbjiA/PfucWaCXnKTq19aRhdLARqpjGeiwHHgcjHHGj1RBRhvkGl7t9BINONXaszx/P3PK6hc=@vger.kernel.org, AJvYcCX2/l5ypKS1kwUozf9QlDpm563AnQkAoFWUYyWgUocaCj5tcG2aFldlsbG0hejdJ8TXaVvug8XEIvaN@vger.kernel.org
X-Gm-Message-State: AOJu0YzXfKo37xvWAB6aeH1d2vgqoABS1GZml2k4w9jrRycLvt7LBOUs
	BFEPbL9UnSbx9igtHou+OjWlloQ0rK/X2pU11K8tishRDDT0FDqu
X-Gm-Gg: ASbGnctTY5xy0+wYojLw9c+meiiDpzQlxYNnx3FcKEbvj3IyR8gykLa9uqnusdRFOTr
	XRJLk+I6/NEWG/Q7uRdcHqd0m7kfJb/KIPT8wJCXCRK9G217LRTKy6dfrpU210o0qb4qeVqGX4K
	mYcTcVcIru81dtcS5Cd/wvD4PFCJanuRhlSHQbvMtlFSL6WVk+rPDTdCRo0/iZ06vIN+Q00nep6
	KeVIqlYtqQc0coqZ2qKs3gAS0ygOFnyJ1GTV/x/Jw==
X-Google-Smtp-Source: AGHT+IHbMbxHrOKtpfB9BT158a0MMZO5ami5tF3rRdJSbwLQ0+B/eWD1BHZNxjsis/raQoDDdfrmPw==
X-Received: by 2002:a05:6902:274a:b0:e3a:36e0:483b with SMTP id 3f1490d57ef6-e4352f5767emr9850012276.40.1734372188647;
        Mon, 16 Dec 2024 10:03:08 -0800 (PST)
Received: from fan ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e46f7467145sm1446400276.0.2024.12.16.10.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 10:03:08 -0800 (PST)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Mon, 16 Dec 2024 10:02:55 -0800
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
Subject: Re: [PATCH v3 6/9] driver core: Rename declaration parameter name
 for API device_find_child() cluster
Message-ID: <Z2BrT8KEWdSSL12P@fan>
References: <20241212-class_fix-v3-0-04e20c4f0971@quicinc.com>
 <20241212-class_fix-v3-6-04e20c4f0971@quicinc.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212-class_fix-v3-6-04e20c4f0971@quicinc.com>

On Thu, Dec 12, 2024 at 09:38:42PM +0800, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> For APIs:
> device_find_child()
> device_for_each_child()
> device_for_each_child_reverse()
> 
> Their declaration has parameter name 'dev', but their defination
> changes the name to 'parent'.
> 
> Rename declaration name to defination 'parent' to make both have
> the same name.
> 
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>

Reviewed-by: Fan Ni <fan.ni@samsung.com>

> ---
>  include/linux/device.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 0e0bc9bfe0d15a8734bf3d34106300f4df6b5364..a9d928398895b062094b94f2c188cbe9951d7ac1 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -1074,14 +1074,14 @@ void device_del(struct device *dev);
>  
>  DEFINE_FREE(device_del, struct device *, if (_T) device_del(_T))
>  
> -int device_for_each_child(struct device *dev, void *data,
> +int device_for_each_child(struct device *parent, void *data,
>  			  int (*fn)(struct device *dev, void *data));
> -int device_for_each_child_reverse(struct device *dev, void *data,
> +int device_for_each_child_reverse(struct device *parent, void *data,
>  				  int (*fn)(struct device *dev, void *data));
>  int device_for_each_child_reverse_from(struct device *parent,
>  				       struct device *from, const void *data,
>  				       int (*fn)(struct device *, const void *));
> -struct device *device_find_child(struct device *dev, const void *data,
> +struct device *device_find_child(struct device *parent, const void *data,
>  				 device_match_t match);
>  struct device *device_find_child_by_name(struct device *parent,
>  					 const char *name);
> 
> -- 
> 2.34.1
> 

-- 
Fan Ni

