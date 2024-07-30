Return-Path: <cgroups+bounces-4016-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 757BC942335
	for <lists+cgroups@lfdr.de>; Wed, 31 Jul 2024 01:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BDA21F2524F
	for <lists+cgroups@lfdr.de>; Tue, 30 Jul 2024 23:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5771917ED;
	Tue, 30 Jul 2024 23:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gKYKuFaf"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EE518DF6A;
	Tue, 30 Jul 2024 23:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722380730; cv=none; b=t2wnHbXx+89JpZhRkXH+XhXkiVu23SNKclDw2pmY6yb67mqy39hBsdBf5e3aN2d59CdoWvreZwFDeto9lRU8jYpIwJ0eOfMkdzafrrEsnJxiN/niv7Zvk71vpMad3t+jcZ7umv+RUFLkUf3ApzBm8WoQ68byTjXUYrZNhucvCcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722380730; c=relaxed/simple;
	bh=mBgeyWXvCRlXdU5F9uJDEqHSruZegd60bx3PO2WxQeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jY+YjsQuctqAV/CKEhSq7CYd5zuLWRw2PLMrAzPUUVA8ROj5htfqsPRneeysWcU5wo31XuPxY1MSBxUa2G7KaQiuPKF7wml26G6rVWuV/J5yAAkJPVohGyPxqXJrPOmwUVv2J5hZxJjdYviFQhjvMoXS3REfeTlSMtgaTwLcryE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gKYKuFaf; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3db23a608eeso3071434b6e.1;
        Tue, 30 Jul 2024 16:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722380728; x=1722985528; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gW+ta3IOfAgDUEr3yuWk8gQqmCzP9GR9JBY5N9A7rco=;
        b=gKYKuFafJ3G9yWDphgnJFA/6C/lWhDp281SkSCrym2mMzdMMlixH4Eq/otEdr54yvE
         LhVqGsvQMVqnFWG/4b2y8EaVw25489uE0N8v6mgmX2n71r+hSwgfvVmW7SSkh747ORFF
         XSccTWAPL/uZpAqt352mDSjxuF1YPLZx2svLrz6dB7wPWkhML9jcwqQzwQDuMarpcfR3
         ZIFe8PnfsiMx0W23MANgzkmObXPrzube3pK3Qb5G3L8qVWSpjYLjGu+weGXEIUmi1pwY
         g7E/i0OL/0YRoVJZYAhmDtA30Sw7fDAKlTv193C32X/mmhb++MHIbirhZ+m0swoGujfc
         sfqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722380728; x=1722985528;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gW+ta3IOfAgDUEr3yuWk8gQqmCzP9GR9JBY5N9A7rco=;
        b=eD7AEjp5YDw6QdJtiuT0Z9lu9S5JfTbwQOzBowG8rc2m4VPmze8LdLS0MN581ZoKIJ
         N7B/UwSjKoPliXxz7tP5jEU0951ZafXdbvH5rTqUlMIf5373R7UPBxHkL6MZX2UJriFd
         Q9uL1ymcferYysVVL9i0v/HYDxl4b952YV7mgcCfcY4J8ZMzTpcxWP80wN8X+jMh9E7N
         usV0QHa27k0Q+PrWTgVSMTfuhAQxJiHWHYDDyR6cWIspSVcH4Eb+1WMbS53z6cb0Wnj6
         MjNygVcGUtqtOblExvY7gpgVBWLOP6eMgPvSO9cB8a5hPMd6jbdBLaGU8twEp++3j3Pt
         CsFQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6HNJNWwqcA1MqqoG5/q8VcsUVdkxF55DnkSl2jDrzdQaCGnTIw2kkcZsDsxsScKNvTm5tO8miGqXQTwG1T/2JQAgrBVPgX/8ZZN3LVQ2lNQpNXtfCcFQgOf8I50PNCmx90NbgEQ==
X-Gm-Message-State: AOJu0YxONt7HVdUSgzIzqy8qRiRNIVCcDNSgife157t3Fm2S6FdbV2F1
	XV5pJB03UWtNg/g8wZNJICOklDBrUPDE5Ob66sNGCSLiViJ64NyP
X-Google-Smtp-Source: AGHT+IGjIzkQbeLsmeuh1gycVV0DQLPhIsvgXK0rgvToDwr5QXrj7S9yWV+IY+1duDEfrtRQtPwbww==
X-Received: by 2002:a05:6808:1312:b0:3d9:2348:6d94 with SMTP id 5614622812f47-3db23d0ba2fmr16728316b6e.46.1722380727888;
        Tue, 30 Jul 2024 16:05:27 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7a9f8751ab7sm8051700a12.42.2024.07.30.16.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 16:05:27 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 30 Jul 2024 13:05:26 -1000
From: Tejun Heo <tj@kernel.org>
To: Xavier <xavier_qy@163.com>
Cc: longman@redhat.com, mkoutny@suse.com, akpm@linux-foundation.org,
	lizefan.x@bytedance.com, hannes@cmpxchg.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org
Subject: Re: [PATCH-cpuset v11 1/2] Union-Find: add a new module in kernel
 library
Message-ID: <ZqlxtmDvh082nKN7@slm.duckdns.org>
References: <f9e55eb8-82a8-45f2-a949-1db182e95fc8@redhat.com>
 <20240704062444.262211-1-xavier_qy@163.com>
 <20240704062444.262211-2-xavier_qy@163.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704062444.262211-2-xavier_qy@163.com>

On Thu, Jul 04, 2024 at 02:24:43PM +0800, Xavier wrote:
> This patch implements a union-find data structure in the kernel library,
> which includes operations for allocating nodes, freeing nodes,
> finding the root of a node, and merging two nodes.
> 
> Signed-off-by: Xavier <xavier_qy@163.com>

Applied to cgroup/for-6.12.

Thanks.

-- 
tejun

