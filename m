Return-Path: <cgroups+bounces-2568-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2628A90E8
	for <lists+cgroups@lfdr.de>; Thu, 18 Apr 2024 04:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EA7E282173
	for <lists+cgroups@lfdr.de>; Thu, 18 Apr 2024 02:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F356139AF2;
	Thu, 18 Apr 2024 02:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N5wAX89L"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6380A848E;
	Thu, 18 Apr 2024 02:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713405648; cv=none; b=DEqjAZot06ecjByVrvlJQX7Tu82rBHGCdgM7RHfPr7pVGa5yVd1FEx/buiRlQNG9OxWXIt1qPDg/vdbN11sghczMJr1qhRwkcRZo+WKzPuwDzD6mNueXyGLJUYnXRl117pUic6Othy6uOY9azuIlm3sTBY6tG7culWyMAIkT1co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713405648; c=relaxed/simple;
	bh=2nSeiWONJ/DGTo0OT6u9NRTKxGy8q2PQolDbgjSnhws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IW25WZ8r1mFbjRnQSVTsTv18YjsgNhJQmAYu6TgLaEbhr5nztrk2Cehon3LiGk/JIbDFE3u9c1GB9V2rz2AwV3u3xEgQDLDh2Wuw/UfbD7EYpbPVB8i3y+987cuJp+316zk0KnNDDSsCJnSRVUv4z1jUN9wX4I81yo1YUbQngnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N5wAX89L; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3c3d2d0e86dso241729b6e.2;
        Wed, 17 Apr 2024 19:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713405645; x=1714010445; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6nN2zx54pl46Nq1uQmC3uf7LHK8ysJkBDamazRv8vFk=;
        b=N5wAX89Lhtrr+S7cWI7vXjrIjW9yxihoiJ9HlMvJID0d3zCYXg29qu23nve5V79B8k
         FqzxEsZwH6Yms452Kx9rMHTBQGNyy9XnkXmpbMSYFT6yYTHTNqoRBHickU+9AKeTEtp/
         feuBEInGtSvKac00Q4ONyzpHwRemdwyksW3iKEmCFjcCkW3HRO7UFehPlEXtFi+UEN5n
         HWDt/wm1yNmUzVljxuvevSt3f6EinBrzKZWXIt2AVIneVS3zBbkRUVAlCq6NOUQHFJ+w
         Cf025G1Q28hwwMQDsZ9opdIrHrlkmJSaSJNjUdvq24mAmy1bsZhPo0Py8DTwKxjxJnTG
         nKFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713405645; x=1714010445;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6nN2zx54pl46Nq1uQmC3uf7LHK8ysJkBDamazRv8vFk=;
        b=TD/ztFJVUz5C7fuy5zssVC5BCsGsqerzXruG2UvBnI730QnhYRSTlvefZBnKTUtdo3
         nZyfqSJmCsmu5pJtNT1gjFYA93ePlV7n4DtK1iw3E1mPWNX+HsvVffYkUCkdks9EjWBd
         Xo6dk7Ojk24564o7rTwh9EWUz4VeMGVjsxG4EMXt435DRY+VZz0BqWrWG+S6u6b2rV8h
         8vK6JPOnYAHuaAVelJKTHWTOv3nLaoI7b8Oj8l7XHTJyIdxBdDxWSH7XvVT8KOi6xzvp
         pMNVjawil2bGNKCfaq6XFPQC3wxCtCXbcvABJJZRJSk+AjFTVWoGT+yJK+eTIy4Mr2WB
         Xeow==
X-Forwarded-Encrypted: i=1; AJvYcCXNbxRIKaxNmcnkobBChscAIWOb6ACR7iihKhEHiNtV027C0pBKA1N1cwIUaymzS3QI5IGTl7UxfUpgzjOp8A/hEvggwndT1HRq5OdUt0xuFcvTTQcfA0Sqc7gA6NLyKSuHgCVvGw==
X-Gm-Message-State: AOJu0YyLm1rpZ1UjVR/54lvXy8NFxV5jrhtcbouGrUuzSziSlYlB06Cz
	VjPuLuJgpr8pW3YzarfZMWWVGMA9igenbP64udelbdTvKyh3lnNmz8WHixAo
X-Google-Smtp-Source: AGHT+IGCIRAI84E+3bQDuet1igYJexyHGXumR/0HEP8Hs1pG1xpW5AU9JNn0C/Ffhj/jZfv4qWvoKg==
X-Received: by 2002:aca:f08:0:b0:3c7:3af6:1cb5 with SMTP id 8-20020aca0f08000000b003c73af61cb5mr635093oip.46.1713405645478;
        Wed, 17 Apr 2024 19:00:45 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:6f51])
        by smtp.gmail.com with ESMTPSA id b16-20020a63d810000000b005e438fe702dsm280867pgh.65.2024.04.17.19.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 19:00:45 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 17 Apr 2024 16:00:43 -1000
From: Tejun Heo <tj@kernel.org>
To: Xiu Jianfeng <xiujianfeng@huaweicloud.com>
Cc: lizefan.x@bytedance.com, hannes@cmpxchg.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] cgroup_freezer: update comment for
 freezer_css_online()
Message-ID: <ZiB-y4wpfTf6RbnC@slm.duckdns.org>
References: <20240417035028.884560-1-xiujianfeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417035028.884560-1-xiujianfeng@huaweicloud.com>

On Wed, Apr 17, 2024 at 03:50:28AM +0000, Xiu Jianfeng wrote:
> From: Xiu Jianfeng <xiujianfeng@huawei.com>
> 
> The freezer->lock was replaced by freezer_mutex in commit e5ced8ebb10c
> ("cgroup_freezer: replace freezer->lock with freezer_mutex"), so the
> comment here is out-of-date, update it.
> 
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>

Applied to cgroup/for-6.10.

Thanks.

-- 
tejun

