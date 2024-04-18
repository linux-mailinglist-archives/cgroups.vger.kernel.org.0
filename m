Return-Path: <cgroups+bounces-2570-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B658A90F4
	for <lists+cgroups@lfdr.de>; Thu, 18 Apr 2024 04:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6D951F21BD3
	for <lists+cgroups@lfdr.de>; Thu, 18 Apr 2024 02:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A313BBD4;
	Thu, 18 Apr 2024 02:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Plf0jScj"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C726FA7;
	Thu, 18 Apr 2024 02:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713405918; cv=none; b=p7fqcBu9PztgeT+Mlz0OwuN9feBNT7BfGhidY3trEmst6SvB0m8H4Ph4DdasKXBoB/6qGyzz/RNARBEwE6CWIYMNwsV+OXVKsv60uQjaLUqC/z8BNueUCbmRQNg1R4aM+HsGubh6Xqav9pq1jH02fXZ8lLs6gqv5ZRzWpq15cxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713405918; c=relaxed/simple;
	bh=73LVQrfjmvrDVO+kAsF3UE4WMxKTnsJSv1IvmJzeqnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s/20haU11nwrJ4rUzpsk8F0oLWkbVLvVTaohdIHVjp3tbMLbFXIL195KJ6kJyFrDN3gZFrgoc4roVTbCOD21NpFR1P7/TEhWsOAVJZPiOuAUBXSSJR82UidZpWnYsFEyTMtZLB3zwhp9ZvhZwGacttKV9cXyJEeEplJmMaKrGus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Plf0jScj; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6ecf8ebff50so265378b3a.1;
        Wed, 17 Apr 2024 19:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713405916; x=1714010716; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dav8LT6ZkkrV7Xf+PoaKXV2rDAf6ehRkqp4ZSiFp8Pw=;
        b=Plf0jScj9/RJij99whXZri6LT+ABti5q77T/LGzxC/Oqp3hxfmqAUwhFlbPTK7bpqz
         batTTtbYzmw0FMiclbfsc+cMPs3WIexEwggq2OVpAxZ/g08dJy0jE+p4fzyQSNstyI1a
         hPEtaVLdKUWpXuVj6clEFFvHVYSoYuW48XnpbKSgv8LW3ix4oImd/DmbVuAN+TKDZYwp
         57LTkShShZ9pq4z6HKlDW1oqug5rrT+YFyfQwU7stqoapLXO/BVSO9GXU/2ObYjNJFkj
         yobZ2X7thuATGMCva2Bw5rMchcJxrQoiEzqOdxsJqZDU3qfPUfdYQUTnFbeTy7572TOW
         laMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713405916; x=1714010716;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dav8LT6ZkkrV7Xf+PoaKXV2rDAf6ehRkqp4ZSiFp8Pw=;
        b=es0qaIztMqPnLr0SgvI1g9kOukgmMQoAE9szrBCLjB+3VtRCh+FgND3YUb0WcZwM5x
         bFM3E7kEhrO3f1Vto10AvCJLiUGScMhMd7UANPOWDDwoTi6F0KYoKJE5weXHuxuCEV1z
         0FDMMElcxmPbIrY7FQNGqlTAQsrBVqrWncd2m0RxJDSjWbWTgmOy/U3+ZtYM9CNI7GEC
         feyaMLoXoRppLxkqVqw2kVjFath9Mty/1dOTnYv+2NeNUR4oFaWEkwdQOSiwugVXILb0
         v8KN/pm1O2TpgZtCaOCaQakt82C0/+KSyM44J9ALjzTa5sxq0hryA+t4QZExEW/l3XQ7
         s5Fw==
X-Forwarded-Encrypted: i=1; AJvYcCVZMCFiwHgbKH9U33+fmwX46EfpigrvDlO0P7e/CzJpGX4Fgf90mieVGqssO7OyMW70NoI6oB49dOPkNOu/XEqy+c2WzSrsD3CjVVyNnDeMVey7STIj8/0GoWQ/trusigo5uITrRu0My1to0Va5ZeOHp3HjgVzPS9t3E31pdunS29o7
X-Gm-Message-State: AOJu0YyOD8XxleZqPCwuNHySQSaAtSSQYXJORm9aJhUjg9YYm8XVBxwS
	R23K9nG3u7CjbZUwzyhcc/KhoNXok2HoDiA/mG7gCa63PhInze6p
X-Google-Smtp-Source: AGHT+IG5SxIK07Q/miAgOz8egYZfpCoEBFkaUYGR29gIiRkZu7799/SYMMBv2tExbxkUjc8I2ntfzA==
X-Received: by 2002:a05:6a00:2789:b0:6ed:4b2d:a764 with SMTP id bd9-20020a056a00278900b006ed4b2da764mr1361359pfb.11.1713405916495;
        Wed, 17 Apr 2024 19:05:16 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:6f51])
        by smtp.gmail.com with ESMTPSA id k26-20020aa7821a000000b006ed8379fe7csm350584pfi.75.2024.04.17.19.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 19:05:16 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 17 Apr 2024 16:05:14 -1000
From: Tejun Heo <tj@kernel.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: axboe@kernel.dk, chenhuacai@kernel.org, josef@toxicpanda.com,
	jhs@mojatatu.com, svenjoac@gmx.de, raven@themaw.net,
	pctammela@mojatatu.com, qde@naccy.de, zhaotianrui@loongson.cn,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, cgroups@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com,
	"yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH RFC v2 5/6] blk-throttle: support to destroy throtl_data
 when blk-throttle is disabled
Message-ID: <ZiB_2ryBOxq2_IyG@slm.duckdns.org>
References: <20240406080059.2248314-1-yukuai1@huaweicloud.com>
 <20240406080059.2248314-6-yukuai1@huaweicloud.com>
 <Zhl37slglnnTSMO7@slm.duckdns.org>
 <1bb85208-1224-77dc-f0b2-7b7a228ef70b@huaweicloud.com>
 <Zh6wx4mXZy_EOViH@slm.duckdns.org>
 <19086c09-3060-a4ce-4ac6-811a29653979@huaweicloud.com>
 <Zh8kPGAu2TG4Su2M@slm.duckdns.org>
 <1ed63126-d2e6-f0b6-42ef-127ecb464955@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ed63126-d2e6-f0b6-42ef-127ecb464955@huaweicloud.com>

Hello,

On Wed, Apr 17, 2024 at 09:39:43AM +0800, Yu Kuai wrote:
...
> I guess I'll do lazy init first, and then modularization for rq_qos,
> and leave blk-throtl there for now. Perhaps add a new throtl model in
> iocost can replace blk-throtl in the future.

That sounds like a plan.

> BTW, currently during test of iocost, I found that iocost can already
> achieve that, for example, by following configure:
> 
> echo "$dev enable=1 min=100 max=100" > qos
> echo "$dev wbps=4096 wseqiops=1 wrandiops=1" > model
> 
> In the test, I found that wbps and iops is actually limited to the
> set value.

Yeah, it shouldn't be too difficult to add .max support to iocost so that
you can say something like "this cgroup subtree can't use more than 60% of
available capacity". That'd be really cool to have.

Thanks.

-- 
tejun

