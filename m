Return-Path: <cgroups+bounces-990-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10BA181C023
	for <lists+cgroups@lfdr.de>; Thu, 21 Dec 2023 22:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3E4C1F21A13
	for <lists+cgroups@lfdr.de>; Thu, 21 Dec 2023 21:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0026C76DB6;
	Thu, 21 Dec 2023 21:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B04ChrDX"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB7B76909;
	Thu, 21 Dec 2023 21:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d3536cd414so10441315ad.2;
        Thu, 21 Dec 2023 13:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703194186; x=1703798986; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/FoyXaoazdlVrEVfsSEbWKqzLBhmPjBBZnxMuGcpkmE=;
        b=B04ChrDXIl8YGa0LVlqHMuPj4Gmca8M9EQqYajPHlW/zv0VkNsw7f8525gYW68QYb4
         lWqIcznvt6+6UzT+rdIBfDTJapEkUA/0HmXLTaKmRIROdfef4C7XFTZYb3kRdXwI9MES
         wmBZ47lV8cEFLJeqgX9aemfEW55e/rS1FrAIgult4E9B7Pipkx8JKVWe0wyg4V0My4vW
         3clKZRrEg+4G3cHwtBmACZ3rgDcwQgGwaU0Mu7O+O77jXIxCySD1p3CXZYPKAh+1krEO
         SWWWIxAOM85naVeaMq7PhqvhbVoWC11v1OECzNpAZkzIKio1D+2Qv+iIY1tSCQMsz4B+
         ashw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703194186; x=1703798986;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/FoyXaoazdlVrEVfsSEbWKqzLBhmPjBBZnxMuGcpkmE=;
        b=m3x02p3btH71QRTy6qX06RxIEO0cndClxQhd+seZWYYVCr9/L8pns/AAoLotvHrwBc
         0n9YFeqg/smXgSlNEvq78UKNuiyZDzzxjPE/kcvC8W2Jcq+zVe+Lh39r2voxqSIjazXm
         bH9C+BePDlVuuSCrzTLkYbP8yBfaGeheNu/wR3g4tFjvtdNF4xOjqSY313MlWy2KzOqw
         1J+o/MSWJEjwiAZA7Kw70Snil+0J7r7kOaOOeVacgUnZfJC00Vq6xg0oV3idM+H0VkVL
         0MFAgJ8Q++VNezHgtjp48ExX9HiCuKDRPzp2UDQnFxx7RC2uVKOASU7UZ6aGZGME2FKm
         KM8Q==
X-Gm-Message-State: AOJu0YyfGTAKoeQ0qJTJl1lxTUEydW1rGPguTE9BDVBC1nHgka3KC3z5
	+7Q7D6YRGz3xSdtEDRHLgrl0HuiqViW2mw==
X-Google-Smtp-Source: AGHT+IG0h3WyOD8FRRZofG/1YMjFush65tqV3/qUVEkVdFcdA8mGwAlbGJTA75AojJbzOnP8lNADwQ==
X-Received: by 2002:a17:903:124b:b0:1d3:d0da:254f with SMTP id u11-20020a170903124b00b001d3d0da254fmr270751plh.128.1703194185705;
        Thu, 21 Dec 2023 13:29:45 -0800 (PST)
Received: from localhost ([121.167.227.144])
        by smtp.gmail.com with ESMTPSA id y8-20020a17090264c800b001d1cd7e4ad2sm2131848pli.125.2023.12.21.13.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 13:29:45 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 22 Dec 2023 06:29:43 +0900
From: Tejun Heo <tj@kernel.org>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org
Subject: Re: [PATCH v2 1/2] kernel/cgroup: use kernfs_create_dir_ns()
Message-ID: <ZYSuR5cxkDh9Vrpt@mtj.duckdns.org>
References: <20231208093310.297233-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208093310.297233-1-max.kellermann@ionos.com>

On Fri, Dec 08, 2023 at 10:33:09AM +0100, Max Kellermann wrote:
> By passing the fsugid to kernfs_create_dir_ns(), we don't need
> cgroup_kn_set_ugid() any longer.  That function was added for exactly
> this purpose by commit 49957f8e2a43 ("cgroup: newly created dirs and
> files should be owned by the creator").
> 
> Eliminating this piece of duplicate code means we benefit from future
> improvements to kernfs_create_dir_ns(); for example, both are lacking
> S_ISGID support currently, which my next patch will add to
> kernfs_create_dir_ns().  It cannot (easily) be added to
> cgroup_kn_set_ugid() because we can't dereference struct kernfs_iattrs
> from there.
> 
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> Acked-by: Tejun Heo <tj@kernel.org>

Applied to cgroup/for-6.8. Greg, can you please take the second patch?

Thanks.

-- 
tejun

