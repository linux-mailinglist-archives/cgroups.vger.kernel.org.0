Return-Path: <cgroups+bounces-2569-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 500F08A90EE
	for <lists+cgroups@lfdr.de>; Thu, 18 Apr 2024 04:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2FD21F2198A
	for <lists+cgroups@lfdr.de>; Thu, 18 Apr 2024 02:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601CF39AF4;
	Thu, 18 Apr 2024 02:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="boS+kwTY"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B0B4F887;
	Thu, 18 Apr 2024 02:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713405739; cv=none; b=N3e2mQb7rwLp02P20Je4uVvfF+oB+vIkfiim7dyLB/ndCLSCZUyz0z8EFKV8OxLdbm5g0PPyGzDTW6EKCy85KoZ6oA3H+2oDTFBAoi8CiWJsDKM/6ah8rSMPSgPe8KPaztb/zzpQ2Qpi99MawjjYoGNARSAfrKcA/ToRBUlMEkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713405739; c=relaxed/simple;
	bh=8wQoDT/7NOKMTE80UgxESvDJgj7uWjTrlOpXXXDcBv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AXuu6BOD+jevqHJBKxsr705dyuUOpfW4rCBczGKZJ53bMJsXPLMCKM7xPFhGsU+0yNohaevGhyMuV3VDlq4jKA647j94pZ8QyDa4TSo9VZzidhHR+5ZEmgZjyQR5Wa6vtY91IBgSxilpxM7siKENhxvOe+7hpETtC+60wQ25yW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=boS+kwTY; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5c6bd3100fcso191174a12.3;
        Wed, 17 Apr 2024 19:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713405736; x=1714010536; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wvjc4I9zVrii6+4lvGmCflRZZaopkcwkKKuCNg7PNrA=;
        b=boS+kwTYr3Pc7G8EMtOJSdWY1F12Ic0HhFaVPZ9D6mlWB6Gu8pkjHH3FhEHr0/Pa0q
         0jEuY77ks9qr36pFgmR8xtMtAs1ETZ8wjvFmWIBIo3+9l0xQvc944OQm+WwRVLdYoaRY
         E2e+s1CRzQEsnjGD2VF2LSu2BdZ2M7HL5p+IP3UGDnmqzu2SY70eLGQ2E604NPTlSMXw
         uBXVdugzMc5dMj95qFiEnBkfnWUdphJvuB8KKK14fkSoERTQ96ofpdy9BdVVSoUDjU30
         z0zElksoUeEzhBPiaf8Y4anlr2WA4Exq7mNeYfJR2OVEeFnJyXE/miHmLVRnUKoWZr/q
         DpdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713405736; x=1714010536;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wvjc4I9zVrii6+4lvGmCflRZZaopkcwkKKuCNg7PNrA=;
        b=s5zloOEzRYoo+PDul9LXsLKJb2y8EmTwITNmbki6B80To7YK2Wv4UolXp9DKxjbqSG
         Jbm3qae32reX3ND2AJIzGbPW45sR1DV5sSUNL/uQKDnWH32hwSeKVJmmM/yoRk9/PWKI
         iTHxYZuLxPnTfWjCb3JRy7643eh3L88YC9716brOyR4OztfY2RXKNCpVUNvBKyu2wBXJ
         /Qw5AbW6KO96wLBh+mL+C3qKwWZ2sTzIJ3JuhdiUC23f3/guUGLBkMPgcqIUyGwSLvIF
         t4akUFci9Agh5SlcymRbPr7E6uLmg1RWLILHjLAZpRGjSsuAfFX0Hi0iJNpUqpoEN4Fd
         lsqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUP0nXIBLOVUOZqMSbDDU/8n/u5JMjaRX5NbEF+4ipPxqPazsgbDM+1WI66E/iuXmJ6L2UgI6xdHJkLHx7j2LfKzNk4RfU6sRkioLHn83ku7Qv66je2heXX+zQdkNCLW3CxOZqGpw==
X-Gm-Message-State: AOJu0YwSbez9RQBKiQISSXFnw9yqX/y5BQNUuiQBtw/IAASJiw0Uy3ye
	eIQrLVHapqbDwuFNkH8tdfuSEl7g6z0uJmewFn1t9HufYk0LfB+p/DHwxhBm
X-Google-Smtp-Source: AGHT+IHd6qaRHQzsC46JCsWbvCgwOaSJANmZnUHo2qQF1xbcWUIi2cK5x15za76GV3HRv0hHa6KqsA==
X-Received: by 2002:a05:6a21:3e0d:b0:1a7:75ee:6062 with SMTP id bk13-20020a056a213e0d00b001a775ee6062mr1669931pzc.54.1713405736061;
        Wed, 17 Apr 2024 19:02:16 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:6f51])
        by smtp.gmail.com with ESMTPSA id i16-20020a17090332d000b001e0c568ae8fsm311848plr.192.2024.04.17.19.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 19:02:15 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 17 Apr 2024 16:02:14 -1000
From: Tejun Heo <tj@kernel.org>
To: Xiu Jianfeng <xiujianfeng@huaweicloud.com>
Cc: lizefan.x@bytedance.com, hannes@cmpxchg.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] cgroup: don't call cgroup1_pidlist_destroy_all()
 for v2
Message-ID: <ZiB_Jhj2I8YdYs64@slm.duckdns.org>
References: <20240417021359.883736-1-xiujianfeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417021359.883736-1-xiujianfeng@huaweicloud.com>

Hello,

On Wed, Apr 17, 2024 at 02:13:59AM +0000, Xiu Jianfeng wrote:
> From: Xiu Jianfeng <xiujianfeng@huawei.com>
> 
> Currently cgroup1_pidlist_destroy_all() will be called when releasing
> cgroup even if the cgroup is on default hierarchy, however it doesn't
> make any sense for v2 to destroy pidlist of v1.
> 
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> ---
>  kernel/cgroup/cgroup-v1.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
> index 520a11cb12f4..46d89157d558 100644
> --- a/kernel/cgroup/cgroup-v1.c
> +++ b/kernel/cgroup/cgroup-v1.c
> @@ -197,6 +197,8 @@ void cgroup1_pidlist_destroy_all(struct cgroup *cgrp)
>  {
>  	struct cgroup_pidlist *l, *tmp_l;
>  
> +	if (cgroup_on_dfl(cgrp))
> +		return;

Can you move the test to the caller?

Thanks.

-- 
tejun

