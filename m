Return-Path: <cgroups+bounces-3422-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77EBA91B0AF
	for <lists+cgroups@lfdr.de>; Thu, 27 Jun 2024 22:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2335A1F21DC3
	for <lists+cgroups@lfdr.de>; Thu, 27 Jun 2024 20:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FAA01A01DB;
	Thu, 27 Jun 2024 20:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QzclhgEZ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004821A00C4;
	Thu, 27 Jun 2024 20:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719520999; cv=none; b=vBrMVGVjmVvjkqdFB/sD1sJ+F5AdobfLJ6IZJ9HOq4x+4AgYTqbcatR9YAw/snftQv4gVQDWrhTYorki2QKJTknapGgH9Ii+lVhOZslBDcqCB8fdHDEoGrRmx0NTqL9Jrtff7dEkwwtgvNRQabTRolGce/D6I9Y1FcXPisfzWXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719520999; c=relaxed/simple;
	bh=or3tXPxmZQcQXEMx7ZufWzIeCCGkxsi4d0TtOVYe8Bs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jap3itqppbXk6fFD7L9bn4VRboP8BL177Wwlpa+dQcnMO5pVJnkMKBypWDy0eImrNFWqhf9o63v4sAodjgxlJzyFxZQM9I4YhaHHFeoh9NR3I+pl/jHnr0rx+EfFnOPFejKZPUUusTdEOy0wSl81UbZe6adMl8Iygz1EduXUf8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QzclhgEZ; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-70671ecd334so4410214b3a.0;
        Thu, 27 Jun 2024 13:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719520997; x=1720125797; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AmbP74t1WdClNJFAyZoGdlFmmzMTPo/VGn5UfNyVcRo=;
        b=QzclhgEZZz3/z3JLRkyh2YoB+D10uh0ubaF7k9+x2cMrahApRM4HA5jNlkHJoDb2l4
         fs/L4GEtC0iEPYb4Boq6jajtLYTGP9H8i49kHSSPUAWRMPKq7rYWpPKE3pHUI2jkqHkZ
         khtzBjM3Dg0irBM2JfSuoHF+WPRKF93aOl/WaMkODzKsdrSTyzsRvmE4KHJvrtc5ML9L
         ZHJ3NV7mtqIG84ELq/4+MZzPD6Cdwubbpo35RZmLslE79v5HjRW2g9v/Azk2TDIFJgIZ
         huth6q4vCQvOJyzhtPmkagJnjIzH64w3XDCDMob8z4ZMDXCcRHDsgImggvJOlSTNzuol
         pyow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719520997; x=1720125797;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AmbP74t1WdClNJFAyZoGdlFmmzMTPo/VGn5UfNyVcRo=;
        b=dxP65vKyXcIoi+85SKVysg8YVxBn4KhipSixvYQ4pUKvAHl8W7JPj/379oeXrRGF0L
         3BHKj6TZEpAAfKC0Jf3mq1vzCIJMX0Tb6ZVSSUrd1XeXCWHvIfbw6Xh4WggGrsm3x22i
         TJ5eUnzR4UZVBiK/E0ZcaKdUArI8XO3v38ngn9Jo+Tw1vr7t+WMKxAiXItywZxk8HTF4
         9IvSAYvZgOyVJtf0J9+iznNVN0xTrTPIsUnxLMBOvDBGYItULUSZuIHRrtO+FI6NLsfC
         8Mohu1n0xun41/gIpnM31MlQ0qMCmUDMsm9IQBl+6JoO6flIYmu3nOM8dNGdiLIu38oO
         uTWw==
X-Forwarded-Encrypted: i=1; AJvYcCW6IEYgEXvSWVQgN+zr4DmvBkbelcaEs0GOmUp2zoEeWr5N+fBQHHDIlwwDlik1TWII1k933MpCqQVqnhCJRKzESZIS3Jz5Ajf4zomk34NHg3xIEeTtS1qs3Yos3/fsxWwiOsf49/O33mLLWNSgnuPxcOfb5TaT2HNchwXxM19iSBoI
X-Gm-Message-State: AOJu0Yx6WN6L4q3lcVu1q9Kzk2eHmlC71wfmUJIHyMvxdlTtyHS+xq8+
	wibuGQ+Xe5CrepUZJMGlOYDUfmn2CTMoK5XR1qdQwheSh2U+1bzH
X-Google-Smtp-Source: AGHT+IH6pmQLEKw2AO2fCP76GxlrYGFKQ3AadXu/oeJoCw5rYN4A8ilD9PG6xUDHtvEcafM4U7QabQ==
X-Received: by 2002:a05:6a20:3ca3:b0:1bd:6413:2cb1 with SMTP id adf61e73a8af0-1bd64133794mr7548128637.7.1719520997122;
        Thu, 27 Jun 2024 13:43:17 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70802666489sm147281b3a.85.2024.06.27.13.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 13:43:16 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 27 Jun 2024 10:43:15 -1000
From: Tejun Heo <tj@kernel.org>
To: Li Lingfeng <lilingfeng@huaweicloud.com>
Cc: josef@toxicpanda.com, hch@lst.de, axboe@kernel.dk, mkoutny@suse.com,
	cgroups@vger.kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, yangerkun@huawei.com,
	yukuai1@huaweicloud.com, houtao1@huawei.com, yi.zhang@huawei.com,
	lilingfeng3@huawei.com
Subject: Re: [PATCH v2] block: flush all throttled bios when deleting the
 cgroup
Message-ID: <Zn3O47DUoLliwbWm@slm.duckdns.org>
References: <20240627142606.3709394-1-lilingfeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627142606.3709394-1-lilingfeng@huaweicloud.com>

Hello, Li.

On Thu, Jun 27, 2024 at 10:26:06PM +0800, Li Lingfeng wrote:
> From: Li Lingfeng <lilingfeng3@huawei.com>
> 
> When a process migrates to another cgroup and the original cgroup is deleted,
> the restrictions of throttled bios cannot be removed. If the restrictions
> are set too low, it will take a long time to complete these bios.
> 
> Refer to the process of deleting a disk to remove the restrictions and
> issue bios when deleting the cgroup.
> 
> This makes difference on the behavior of throttled bios:
> Before: the limit of the throttled bios can't be changed and the bios will
> complete under this limit;
> Now: the limit will be canceled and the throttled bios will be flushed
> immediately.

I'm not necessarily against this but the description doesn't explain why
this is better either. Can you please detail why this behavior is better?

Thanks.

-- 
tejun

