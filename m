Return-Path: <cgroups+bounces-13067-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E3FD132AB
	for <lists+cgroups@lfdr.de>; Mon, 12 Jan 2026 15:34:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 66F40305D7F4
	for <lists+cgroups@lfdr.de>; Mon, 12 Jan 2026 14:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF0A2E173B;
	Mon, 12 Jan 2026 14:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HMVa2lPe"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AC0350A29
	for <cgroups@vger.kernel.org>; Mon, 12 Jan 2026 14:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768227688; cv=none; b=uW1xPgnY2esKs6Wkkhp8fjtGvfCZl2rI8Lgo9NVGMtQsDHG25SGb7SETG+ES+U2Z4dHJEQdcWLcE634/K+Nx9AcWwktGAdzyeQjPncW29varLGScUWpshkgfDLvHADH+aw/wYzJWmZsxdVg8Kys5vDfkY00IRZETqxOjUkymrNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768227688; c=relaxed/simple;
	bh=RcKivajkARIlhF6bn55BhdPhao9Jezu69Ku2BkIVRvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PidxEXW2ksgnFBWXRSpw7jcJ9jGZI6NDrYdiHdABNhyuUbgQ43KutK4FN6GreVohDy4HanI1P77dyHje8tqoN+2ZPakJvSeYDbUSjYlNOKnemIn/ObmJnDtGqz2vOIbAOgw2CuoILn/DGs4+KI2v4tfPjDWPmj/Z08NGOh5lS/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HMVa2lPe; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4779aa4f928so66204265e9.1
        for <cgroups@vger.kernel.org>; Mon, 12 Jan 2026 06:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768227680; x=1768832480; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0u70BhNwJ4UADpInQUk67N2/5xRXcFkwdnBCb21aVvI=;
        b=HMVa2lPeOCeRSb0mRse3LJ/3EuSaEhKDdwChRgGl5pd0/AZQ5KVGPt3uf1Omd7pLVa
         UtbjsGV3DJ3NwYQygk1bbtD5IN6vgR9DNSd3dSmOYJXuMaf6sm9uJHsFoqY5msnQQgDn
         NsbLIXlBAg/Vk5tmIVl9As28E3sBMYo/qFCg4ZvQ9O5+uePPt7CLEUbnhcSrSRjQUegA
         OeXN36BOlIvtMSQhlrd1sXenVXgn/b6+4tet8yAXqESS60zoooQ7rAgwCPOkieAV7eNt
         x+unXPJ1Q6bQbQVG1H4emdG0K4LG3g6Evt15lWCSX8ulgSukotiXD7SBKysXBXlnaLox
         aW+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768227680; x=1768832480;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0u70BhNwJ4UADpInQUk67N2/5xRXcFkwdnBCb21aVvI=;
        b=mDaLi/EoAuFhiF9M/NxbCoY6naQH+IFyZJtzu8PyVf0QfUijJGTzbIAZVEw6H+J0YG
         mWC/XThERT3uU8m1xuIxiAsbKFPnPfPvdEwmVMlG/JQAJLhONiFWnl897xg+JUcs+ycV
         m1LMaWJE1MKs0LUQwmPADuYq51ktEMaxJWi6HJZ+QOnhEfPWkeikljvEuXNTX/rXtgGt
         k3EeWzXK+BLJGvgDPewYvGpvu1rpje5mfkWpLAxKBjft8FvlDQyOyzxHLPunHyStj38/
         zI2gJUX1l8TAGIHRcoPGJx5JeYIHRVAWcUtsII3PgIsDO+0EcxRPxx0u7sQu1/+O1/OY
         wMIA==
X-Forwarded-Encrypted: i=1; AJvYcCXmlEfXt3cuNHRy+uiKnuc+dh6LF3zsZLWQctDpj9ooh5HUkrOB3nl0dBHEgyfd5jSOlD0CyYkE@vger.kernel.org
X-Gm-Message-State: AOJu0Yzttmj7+K+V2YgSRsUxIJwx7aRt50nCoOuBjqLZq78yZ3tf8PqJ
	UFHYBqxEpYpMY31aX2/icxL7DFUARspWlQ26y3T270V/iZmbWLTPkYqy2MkKlhH+8pw=
X-Gm-Gg: AY/fxX4Q964kmH3+0PAnW/4bN0oTtCrwQ1x1fOEjCMwitFhKPjySu5ABqh3rmIxCRaz
	SVsdv6Xm93vJUhdWECyMYzVok8EU3EJ1UcQpX0OO54azraa1gW9wZZagTrCGPYk/zbzg1xkGlMU
	7dbLkxzEqoP61cYw/8jGCknFbNf7Pkp1/RzTHV2p8PIG3+mFoDfNZlus8xlpB2FiV8Mq8g3Bh2+
	v0gXTSUUSDMxESrl98TX726KqOQm+0kgGgoebPGJX6PhzSe/ZHbK4TGHA4niRPhPnuNQrTwZ9OG
	/ZH4gBoy+z86Uci1WHmv5OtRLFWCLHP84C37LBV56/hevNdlPE1F37C+cUJLDFOeGo2+6/Cz6Jz
	gmpuPNJ6WA4gK5KpJbE3+n9xf7JmgMEPtGnEXHuvGS0ffhR4Z9YswqSb179dNbY/cgsgEADee2x
	79rOZYWmnbk/1paD4x90ZL2+aI
X-Google-Smtp-Source: AGHT+IGIVOzY/cGAUFVZ2fQ9qezTazmo1GKR7XGdOwz+0gwuiBBZTolmYl/t4yWNr8wQgBMrbFb62g==
X-Received: by 2002:a05:600c:4e86:b0:477:9574:d641 with SMTP id 5b1f17b1804b1-47d84b3281fmr206518015e9.22.1768227679644;
        Mon, 12 Jan 2026 06:21:19 -0800 (PST)
Received: from localhost (109-81-19-111.rct.o2.cz. [109.81.19.111])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0e180csm38011941f8f.10.2026.01.12.06.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 06:21:19 -0800 (PST)
Date: Mon, 12 Jan 2026 15:21:18 +0100
From: Michal Hocko <mhocko@suse.com>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: hannes@cmpxchg.org, hughd@google.com, roman.gushchin@linux.dev,
	shakeel.butt@linux.dev, muchun.song@linux.dev, david@kernel.org,
	lorenzo.stoakes@oracle.com, ziy@nvidia.com, harry.yoo@oracle.com,
	imran.f.khan@oracle.com, kamalesh.babulal@oracle.com,
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
	chenridong@huaweicloud.com, mkoutny@suse.com,
	akpm@linux-foundation.org, hamzamahfooz@linux.microsoft.com,
	apais@linux.microsoft.com, lance.yang@linux.dev, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v2 00/28] Eliminate Dying Memory Cgroup
Message-ID: <aWUDXtsdnk0gFueK@tiehlicka>
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1765956025.git.zhengqi.arch@bytedance.com>

I can see that Johannes, Shakeel and others have done a review and also
suggested some minor improvements/modifications. Are you planning to
consolidate those and repost anytime soon?

Thanks
-- 
Michal Hocko
SUSE Labs

