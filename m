Return-Path: <cgroups+bounces-6224-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7BBAA154A8
	for <lists+cgroups@lfdr.de>; Fri, 17 Jan 2025 17:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F23D21692C7
	for <lists+cgroups@lfdr.de>; Fri, 17 Jan 2025 16:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C108C19E97F;
	Fri, 17 Jan 2025 16:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="T3j+Kkec"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C56E335BA
	for <cgroups@vger.kernel.org>; Fri, 17 Jan 2025 16:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737132444; cv=none; b=nRtcDFB8zqQicdzHvtMf7sehQs5Ce8wRvyHVSmkSYQPgizlwYUwzZ+lkBdlMLWJTPi+mUdNBjbA+Xr81zaRNoZ1d/S1sMn1II5q+hZHEdmPMdaTsFN1zydNhJcyiovygmS4pUfI+oY9noYZw+Yjy0PxruxG2EltXfLJ4o1ciWSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737132444; c=relaxed/simple;
	bh=ktxAVlIDGmNWxZvkSomYjtrb8aqtbxh0YdRELQNZZNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uIZ/qCtDIIvn8vRQm2c7AA4WnDym3R0OdIWNYEZGGxu/xntOOL4ltlhlX3mBp61V44Qc5YHhPx3q0z1uGCTpcQnlVOoBZDNwUA/JnHnplJbm3DY/k67VlkHijtjT2Nad/pPxJt4pJJpAqjTPijL5cqXvfn5Bom1DaUI/As6P0A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=T3j+Kkec; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7b6f1b54dc3so384818085a.1
        for <cgroups@vger.kernel.org>; Fri, 17 Jan 2025 08:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1737132440; x=1737737240; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Go9bvCc2kKqieTyjwrluSSJYSjJdx6yPijr3Yd4H/Ig=;
        b=T3j+KkecYik0BkATPd6HHTlS27Eewi3Yf1HAG91fqmkAwBOmJRS2hsPZlA1Yk6FZC3
         OnKloo2qLZDtx/hcDGkLBvkHaqayAEjt2C50C0oB9D93PuYqyCDAr4DDO61YF3qgjNLO
         nFlSLWCQ7iASe53STZlWdkJ7o2zIrnqnKhQRzxspfEbFflAe7G9M+IQheMrv1gS6pLo+
         WbKd/9J2LiN7p9oq0T6sL/2hgheafBcoAKKjtsQLSVBqMnFGewsZX6BIkHKAz6/0rZKd
         tpWdpOiiD5bxL70Vc8/hC5awZgoBxyqfLXzNg6yj/y6tfkEWeN2nNzWBTskqopr/4P9i
         EBww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737132440; x=1737737240;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Go9bvCc2kKqieTyjwrluSSJYSjJdx6yPijr3Yd4H/Ig=;
        b=v/brG589xngCbjh6/5N84DoSfWnbycYHDob2gjnPT0VARgrD2x8Fe+T7r60maQ5J9N
         ELeRpdhEqMvI/gkQTjfKrgjPkJ9hxH5hWDU6BsNwwNHLmobQ7c2IO96I+7lde1LZkmhu
         OmzUbfkzTsvQzqo/WwiCuaO78F/GjDXNqiR2AXgrhhkebRuQClnUupuNFe4aoP5F+H0D
         gkGYdpO3I8Cx2+n6H9/6wFcp9Pi+9Xrci1pY0HPm04lDsIpK0QKPJ2LKyN4C1xR0wfOA
         ikpFg4V4YLX2Y8+9rR01rh7bR3DPCrNHTZbKi1yWrcPaiVx2f102AkQwnfTMu1J6sYTR
         /7JQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcCChLlehByErySZHGPiD0iC2KAMT0LH4fiwTVGJccf0PANDHI7mIo5GYOBAzPh11cLSpDAx/m@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy7jkIOF71WkdnSopYs9jhPCnlZt7eKO7EbOkmKVCOZXJna9gR
	Sae5JlLPphA1+p9k01cczusz3FU0Gjee90JX36tjgIn48MmHrFTBE6JDwUB96tU=
X-Gm-Gg: ASbGncuwvI8HcvaDV6p9TJMFYmVqaqEF2/BtXt74HKlROn1U7EHTM++D6ztE9MGpZhA
	PyI1faESaervu065SDb29+O7H36o46xZQBrgD3YM+ncHIZlpFArHeGZu4KcwsJLL7Yl+vM40buX
	l9mO+EQle/H77zCdJS1/DVAJybBHqFviXRuy8iTfW9FDb3BdOHCeBhBXL24ghDlSiRVgIuahgFx
	8rLaMUq5Xg86hypxnyr99XfACkZRDacs//xdZz4z8ZHJJ8yfrtCSWk=
X-Google-Smtp-Source: AGHT+IE2tyWqSrFEycKLDZTw6iCIribrsUilzJtk3bGZOJKMlJ3+TpUH9PRIMKym06n7rsyVGR6gjQ==
X-Received: by 2002:a05:620a:19a5:b0:7be:3f22:2d92 with SMTP id af79cd13be357-7be6324fc56mr505326085a.45.1737132439923;
        Fri, 17 Jan 2025 08:47:19 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:f0c4:bf28:3737:7c34])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6e1afbf4affsm12953666d6.5.2025.01.17.08.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 08:47:19 -0800 (PST)
Date: Fri, 17 Jan 2025 11:47:19 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: akpm@linux-foundation.org, mhocko@kernel.org, yosryahmed@google.com,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, davidf@vimeo.com, vbabka@suse.cz,
	mkoutny@suse.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, chenridong@huawei.com,
	wangweiyang2@huawei.com
Subject: Re: [PATCH v3 next 1/5] memcg: use OFP_PEAK_UNSET instead of -1
Message-ID: <20250117164719.GC182896@cmpxchg.org>
References: <20250117014645.1673127-1-chenridong@huaweicloud.com>
 <20250117014645.1673127-2-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250117014645.1673127-2-chenridong@huaweicloud.com>

On Fri, Jan 17, 2025 at 01:46:41AM +0000, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
> 
> The 'OFP_PEAK_UNSET' has been defined, use it instead of '-1'.
> 
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> Reviewed-by: Michal Koutný <mkoutny@suse.com>
> Acked-by: David Finkel <davidf@vimeo.com>
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

