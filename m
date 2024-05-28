Return-Path: <cgroups+bounces-3029-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E42F48D2806
	for <lists+cgroups@lfdr.de>; Wed, 29 May 2024 00:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83D2E1F26500
	for <lists+cgroups@lfdr.de>; Tue, 28 May 2024 22:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F0113D8A2;
	Tue, 28 May 2024 22:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yppp7EZj"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567AB8F49;
	Tue, 28 May 2024 22:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716935422; cv=none; b=kGaAVfcuiPNMZtvjGPtwBknmD3R9n+X0YUlkGgQZ5rF7Y90JysoIJ0ebkck4Sz6KAepRtcgf3aYOMeMe8Mq/NGA/jbbo962oU+vasHafW1FeVUHdZ9q1MJ7VCpy7ka9iCZIanXIn5izLmeTmaFpEJEA8KAEfpqPtiy9MpF79dSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716935422; c=relaxed/simple;
	bh=woIZt6yvU8XlK4yGOl4xSfL72qMsG85XvTU6W0oFtAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KQ3/nFrAI3XsrpHsfOVpbjBHfC1hJMoZVU5YMAPLG9/RLJ8fTiv2JuQqaGZfT4QYbV1TULrhKMlc/jjCTQmS+F+ESVX7cJmKaT0Ms8UbHw/7YE3802m58vJ0Bhs61i8PtQzzaNtvK9u3BUyOkjlB7OCANWaFyE/vWKgsmPZt294=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yppp7EZj; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6f8e819cf60so1159400b3a.0;
        Tue, 28 May 2024 15:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716935420; x=1717540220; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eNV0OLj7JMDhtZ28BPp3v4YifVkqJBF8MadCRS/sAeM=;
        b=Yppp7EZjmfZEcEq5fEOrh+IX9/LSRoWFBBKCIQ1ZUkyS9WxW+rsC9V7o78fY7Kbbqj
         y7+01ZA7TVXD2LvG8w8xC2HpTzgxgrWIsXrB+0lPHx+4sAjEqBof43fYX7+y/0nCGIxv
         XYNjameK+hRsLamuLYBN+D1o7oa3hykR0Qt1ivF1lqahFJ97t02H2Tgfvh4CPrwDmkCO
         mDcl5bR0RgBUPrEucG6gaqamzFU3slX+6Ms/YDVOvVyUo9fyfX4DN8Ed4L6yTTYtDgY4
         69jOF3gfZIa5NmwPgCTl8XpfDzWIFU+kdZdziyih4625WnwqQA2gHu76aWjukjdRcq42
         d71w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716935420; x=1717540220;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eNV0OLj7JMDhtZ28BPp3v4YifVkqJBF8MadCRS/sAeM=;
        b=AOc9wEg7o6cewTFzxg1Zc88xc0erg94PVDZkZLvtJQ1kzTKvA9vYFAYF7i+q9cqn+d
         gvVSxKw6Buc5q5PFvOkkOGBay80u5i8eMW++4H1cQzpFp1xBBkSvlGggjS5XeQt7OGyI
         JSD88z7vATXZsXZAEYhbRFxAJmyUy9LtgLWYT3LCA7ruv71OYhdW5k9Hgbw9/+SkdWm5
         4yG5uhCB1MjhSOuUGcn6tzz/RnJLvw9tYoHzlPDSCeApIPbMPBpza+5AY/TuBj/HWj0o
         msfM4lfCJ5ghSDX5e7zQP0Lf1cNEA9HkKZOhMPxXUCjbauyZqZ7MR4NIyXh1HakwQAhN
         ZDEA==
X-Forwarded-Encrypted: i=1; AJvYcCUpLDqfLgNdmHbBlJ40/jKDjpaqEkaNBiPgwguZe/XIJaS2GH3JFt9N0keD1KwezVqNCHmxSR/Pt5wONZZnUbcluxW2vF4eAYhaXw0VqYLCTVg6BF4Z97YVvtjM9HAXIzx8e7LyXQ==
X-Gm-Message-State: AOJu0YzRrXFvrOZonAwYXcxzSj39eeRQ5/SOes64S1ncI+UQy2nzULjM
	yuelTxEsdNBzqUQYbI8ZOdPWQLezAhG5P+r8qA2z3AkPnoeHL92d
X-Google-Smtp-Source: AGHT+IGyKTwgMik12f9X37/YFrx4KXHd9pkJBGV7UOCb0Hews4T6Aw8W7TJqsJKM5lWGGl0lUiMMbg==
X-Received: by 2002:a05:6a00:3698:b0:6ea:e2d2:5e68 with SMTP id d2e1a72fcca58-6f8f3d706demr20349846b3a.27.1716935420518;
        Tue, 28 May 2024 15:30:20 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fc15b169sm6923006b3a.75.2024.05.28.15.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 15:30:20 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 28 May 2024 12:30:18 -1000
From: Tejun Heo <tj@kernel.org>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: "T.J. Mercier" <tjmercier@google.com>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>, shakeel.butt@linux.dev,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] cgroup: Fix /proc/cgroups count for v2
Message-ID: <ZlZa-j3Q8UqL84Zh@slm.duckdns.org>
References: <20240528163713.2024887-1-tjmercier@google.com>
 <ZlYzzFYd0KgUnlso@slm.duckdns.org>
 <zrvsmkowongdaqcy3yqb6abh76utimen5ejrnkczd4uq3etesl@jv3xb4uso4yk>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <zrvsmkowongdaqcy3yqb6abh76utimen5ejrnkczd4uq3etesl@jv3xb4uso4yk>

Hello,

On Tue, May 28, 2024 at 11:42:13PM +0200, Michal Koutný wrote:
> On Tue, May 28, 2024 at 09:43:08AM GMT, Tejun Heo <tj@kernel.org> wrote:
> > I agree that this can be a useful metric but am not sure /proc/cgroups is
> > the right place to put it. Its use of v1 controller names, listing of
> > controllers that don't exist in v2 and the unnecessary column are rather
> > ugly and unnecessary.
> 
> At the same time, the info provided currently is incorrect or at least
> misleading (when only v2 hierarchy is mounted, it mixes the counts) --
> that's what T.J.'s patch attempts to rectify in my understanding.

Yeah, I was hoping to phase out that file once folks are all on v2.

Thanks.

-- 
tejun

