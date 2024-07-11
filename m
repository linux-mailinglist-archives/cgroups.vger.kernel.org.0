Return-Path: <cgroups+bounces-3626-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E27792ECA0
	for <lists+cgroups@lfdr.de>; Thu, 11 Jul 2024 18:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED7601F20CDB
	for <lists+cgroups@lfdr.de>; Thu, 11 Jul 2024 16:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4011416CD2B;
	Thu, 11 Jul 2024 16:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PWKiI7la"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9964C8F72;
	Thu, 11 Jul 2024 16:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720715130; cv=none; b=kYefDq1e11GNaU9+ZReNrhf3k3uVIovvaPwfLA+H6eWEGDBly/DVVkmN6OC+qtrWq2Xkgq1rLPaQo9PTK4TbsfblaiAWmoDHJ2fapw7vtQ+TpShk9FLbvVW0nHuZLGiFwQk5Kquhmiwgpu3VyKjUpIb8kx2O/Cz+BcWJlmdTriU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720715130; c=relaxed/simple;
	bh=WvLaNzBoWTpW4sm1FQ1NjnwqbdK9tF9Lki0vS6qFwS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GF3Ge0DBb7pBJsml2ivb4QONPoLRGZempBNPOh7IaToQo0JENXlbZ3QxLYCGNvPXl3yWsVZ03W1uv37RkyTdZOzEyEhktB2b5o6p9iWPWRNVcKURt3dkhs5jq7ti0uklKM3dhpQIiQHSG/5/9jRJfAIyYIxMOubXYRWnLiFGPBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PWKiI7la; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-70af81e8439so961461b3a.0;
        Thu, 11 Jul 2024 09:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720715128; x=1721319928; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VWMsKibIx5oMfD8jPMVhJ71Qx+hp39frMzw3P6fWwS4=;
        b=PWKiI7la6IiF0xJOzwWLXqvfgjwBsT/J22dbmT8SyvYF1yTz2mQplV9GuEvfxHNPHX
         +CNHtKY0r+54nZC0wJ6B/IxEUcYTI8qj2ibC+ACjZHSE6tmwxxQ7Po0S7D7ys23Xr4yy
         gzeIKlrncem0u9YGhtlkn8dfCxn4zw49vGbapr7/6/jqetlgbJCnBtxbMjlNlFtuduTP
         Ug6AVAJbwU+swvwR+z7FtROVBJzPrEYCSMTtcxfCKrKcKCRk5rkg/sBb+qwdkmQGyGTV
         lD/5gY4SIjFg2jbY89rLarh4xoqWN5xbo/jPW3b08fuG4ZimrFII/q74q84bPY5AVtBG
         AuTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720715128; x=1721319928;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VWMsKibIx5oMfD8jPMVhJ71Qx+hp39frMzw3P6fWwS4=;
        b=fNTMSGALikBGu5wziGW6rBVEAz/lAtAH5lATKDEFTpbDadNLYuD/P1n9xzNI6hgfzH
         XiN80arcuSlrYF5FoFbWDwZbdqh6NtAwg53mkmJUKCzTaA8gL+ZY8H9JFjl3M5po+IHc
         5Uh8xZEAZ8Y6VpFcD4u+VjCFqKpxxS/zSr1zn/68bTBSZ1NwgRrYsCf0QWJerBNBy9FM
         mGeio1qUHoPnVbHG2hmfoTOZwLlkWvbHvjwZmCADcLKD6Vx55H37BEiZxr+Mrd4nJpTY
         HuZZy9xHXh3AL4eT26M4udpz0EpPid/1wHgeu90pT0OKStVyyv/v1YYhaIk2F6yewHGc
         VKsg==
X-Forwarded-Encrypted: i=1; AJvYcCW/N3Rm42g5zG3dtO1udu10fPePoSLaj28M0SWvwy+zcqHC5FqEK4kP6aC2x5rt5vBSGUVw8UDpD6Ym2E91spaiHbyaj08/qNI0nTl8yIMtxEO/vBieJeGBGyXVkgNMSZl1Ju+5lQ==
X-Gm-Message-State: AOJu0Yy917e1tbmJbFONXpHVcrzFikvx66oWKKE6dVrvg8GTWqwS93qm
	U4+Z1ubQKNjwgstonpQXCns5kvhSXXHNAL/qbX9ftZ9GJK/tRyR/
X-Google-Smtp-Source: AGHT+IF0B+ryqR/1Yrt114h9chcYaOMVuTjGbnTJMYZTMLZDRPcS+O9jbUUVpPh9C2S7LZcVjcOndA==
X-Received: by 2002:a05:6a00:2394:b0:705:c273:d19 with SMTP id d2e1a72fcca58-70b43543a9dmr10797505b3a.12.1720715127689;
        Thu, 11 Jul 2024 09:25:27 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-77d61c006ebsm4596180a12.41.2024.07.11.09.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 09:25:27 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 11 Jul 2024 06:25:25 -1000
From: Tejun Heo <tj@kernel.org>
To: Johannes Weiner <hannes@cmpxchg.org>,
	Zefan Li <lizefan.x@bytedance.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH cgroup/for-6.11] cgroup: Add Michal Koutny as a maintainer
Message-ID: <ZpAHdaS2CKwwa2dk@slm.duckdns.org>
References: <Zo8OzWUzDv3rQIiw@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zo8OzWUzDv3rQIiw@slm.duckdns.org>

On Wed, Jul 10, 2024 at 12:44:29PM -1000, Tejun Heo wrote:
> Michal has been contributing and reviewing patches across cgroup for a while
> now. Add him as a maintainer.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: Michal Koutný <mkoutny@suse.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Zefan Li <lizefan.x@bytedance.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>

Applied to cgroup/for-6.11.

Thanks.

-- 
tejun

