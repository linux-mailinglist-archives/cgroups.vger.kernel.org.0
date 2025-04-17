Return-Path: <cgroups+bounces-7614-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 945EAA92046
	for <lists+cgroups@lfdr.de>; Thu, 17 Apr 2025 16:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D496171B6A
	for <lists+cgroups@lfdr.de>; Thu, 17 Apr 2025 14:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3F2252900;
	Thu, 17 Apr 2025 14:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="HTOV9jk8"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D48205E14
	for <cgroups@vger.kernel.org>; Thu, 17 Apr 2025 14:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744901555; cv=none; b=cB+nlzgOEjC81B/j1MIbbqAJzyUc54NZZbwD/16imyKQGPCEKq12/LjGDGLGhEcuzgvVcm2NHMlWWcqZLURzxP73nMkKsIfvsI3xKxBkQdkRpD47zqQkZoTtpjq5rW5tk6nnBv1/QctJ7QECrZyjJ3x7o7jKW9oZCgXlcSppKGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744901555; c=relaxed/simple;
	bh=C0ii3df6urNS96a7DeEXtF7upeoeedD2PihrrtmFsI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pXlM3JyQi6Xlq3d2OiL2VQZpGtSDwVp85kFVyqkhH4Xt6SlNZsrzyP+tqhpK/a1Fov1HFDmCTQIWCjvR5HuY102h10kAtFiztpqgj4DgQ/0KVPFipTbTTuwy7FVuhNJ7nW4J4re8E+PMrzpR1FAgBhKbbIugZp+LF93JDw9SQ1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=HTOV9jk8; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-476ab588f32so11667101cf.2
        for <cgroups@vger.kernel.org>; Thu, 17 Apr 2025 07:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1744901551; x=1745506351; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cNdlL3P+kB6sb+uZFj+Sde9hgZanWGCpbxTUw3Vgows=;
        b=HTOV9jk8mMaieAnUrzOEvJKeHfaESJ+Hw9RUtomS1Q8g3KU34xFrO08/BqyE55fegy
         IwTWsvsDOSDABBpv4gCixQinLOMAA5B+zrwCw8/jOauyToycwLRrCvm5rnKodgR/PSaJ
         iWnXuBeaEP9BUC9oE5SbY1U/nGIq3i913KW/X4cbJ7mYV3HNKk0ICS8pBAD7x3hzV6Ar
         xc7i/YSOdYsVXaF7YzR4xlSSamAtz5f2u6+xoeebNyg3ueOGdEhA2NEvrwUJbkCoLMER
         4ODwme264l0BCym33Qr35pWzHcmCi3g/zQYrK0aghOWbfPC1UeEeMNYU9bmqnIFaV/Up
         mz7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744901551; x=1745506351;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cNdlL3P+kB6sb+uZFj+Sde9hgZanWGCpbxTUw3Vgows=;
        b=R/6ArbZyl3XtAvqO25NJ5nLipIAVQw4mSe1foAmMyxEmqVb2ppW51euSiD7V5xD9+R
         uzLncJLy+o03AOi02pJvzYgIcZRGU9reyZYdGr3FOm8EKzjeOP8cHCvM8rZ5UQIPgfSP
         bYmCypURAA0dVA0wnHFarLP6y4Fx446CAvoF/mmPefGiW4C/zpOKLePSiNo50AhBJljT
         mXfY/qhNPy3wWZEFSbI4YrawQs4/Yja1MGhP/dCXi/cSk4Oiq+gaV8qNsVMD7oXlYW1o
         RQNuNVlqNn5qWMjNJB216o0hdc2MLfecgBUGuF6qC7h9JGb/x3QDfe/aa8445VMVwspn
         0Onw==
X-Forwarded-Encrypted: i=1; AJvYcCXTHQulSa5N3z9trmpFCIzrJHdKiuPjRTSW6S3PTVM7IGs+bh2JvAyfTDQMfoZ8DbmYzhlr/NI0@vger.kernel.org
X-Gm-Message-State: AOJu0Ywothg6ieDzMVreMYqRnU+Us/pCnoFTMlGEi95BT9IPJnidoCLr
	+KkdDXGN9+rA9++CuQu+nzuvRt2NhoW6cvYaXcC0wxRZJ8ZEXPhxRZcoVUyIjU8=
X-Gm-Gg: ASbGncsvXMTdXOdMveNlpk2WN3gPvpliCobreVXLJoq4Olva1zYFdwQAIRshR9D6BW7
	1fevDObgXl0shEWGdV9BI82qB1vO1vsjr10in510/vwzio2ur7fXbb8CpfoNdSZAZdnb9EHHtZ5
	vEY7FyjJizyu8cFS24CVZ1KJfVuU7bCPIZwFx4Jx/Jy4k2hn0hA+n7y4QghYl4NN0xfOfJfDHpQ
	eYJjVuVeKPedw63/Lo64YGZRcIWL3ihytT4wHTVR6CRgFpSaJ+7HKirI8gJdmyd5DsjBdqScLVX
	wUmYfeQxWVZBMRaNR19H9H0K6WhufVIVWzM4uVc=
X-Google-Smtp-Source: AGHT+IFoM28HUMMSsl9CsOqS/2wRZ/w4+IJS7bMDbtZm7rzCvcmmOo+0hBtEKG+MS4hlQt+J9+2Pfw==
X-Received: by 2002:a05:6214:410e:b0:6e8:f17e:e00d with SMTP id 6a1803df08f44-6f2b2f426d1mr89621206d6.14.1744901551363;
        Thu, 17 Apr 2025 07:52:31 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:365a:60ff:fe62:ff29])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f0de98224asm127756826d6.65.2025.04.17.07.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 07:52:30 -0700 (PDT)
Date: Thu, 17 Apr 2025 10:52:29 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Muchun Song <songmuchun@bytedance.com>
Cc: mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, akpm@linux-foundation.org,
	david@fromorbit.com, zhengqi.arch@bytedance.com,
	yosry.ahmed@linux.dev, nphamcs@gmail.com, chengming.zhou@linux.dev,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, hamzamahfooz@linux.microsoft.com,
	apais@linux.microsoft.com
Subject: Re: [PATCH RFC 03/28] mm: workingset: use folio_lruvec() in
 workingset_refault()
Message-ID: <20250417145229.GF780688@cmpxchg.org>
References: <20250415024532.26632-1-songmuchun@bytedance.com>
 <20250415024532.26632-4-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415024532.26632-4-songmuchun@bytedance.com>

On Tue, Apr 15, 2025 at 10:45:07AM +0800, Muchun Song wrote:
> Use folio_lruvec() to simplify the code.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

