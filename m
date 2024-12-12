Return-Path: <cgroups+bounces-5843-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAEB09EDCFD
	for <lists+cgroups@lfdr.de>; Thu, 12 Dec 2024 02:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58751188A1E4
	for <lists+cgroups@lfdr.de>; Thu, 12 Dec 2024 01:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2D0225A8;
	Thu, 12 Dec 2024 01:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="zwmFQjWP"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510522594B3
	for <cgroups@vger.kernel.org>; Thu, 12 Dec 2024 01:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733966245; cv=none; b=tu96lOwMPo4xYk9ykKwcg1cjvvCzdhSwvDEOBT17fIJSyei/2vOl4mNMP9sHWAKA0s6FT48YTwQULbfLgky4S1RIvvHfCrFbJK6AfAJuMGxwLUlhJSGL4WkC2E8wsSSNMqhAjCbukQyTj4hLOIknhXx4owdnQuWV6YiNHSR+tBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733966245; c=relaxed/simple;
	bh=MvKagAzNUAOxChvHrOFpcJiYAyut8t9DL+GIvcj3XxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aNjNXdeR78/L4eMeBrgQbte6x78V0VfdmvMBS2uwS6Bu4C4GC4mg4GqFsDsrS+xWTE3SN3/ikuvjYt1hN3xMTZQ7+/s1maTSn1RJZQKjaI+YkdXQUYChds/ezzrx8DWw+5Z7mTlNhh5ruNVE3NsPIF2OGditJNUX1jw41xrzaEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=zwmFQjWP; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-46769b34cbfso1411551cf.0
        for <cgroups@vger.kernel.org>; Wed, 11 Dec 2024 17:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1733966242; x=1734571042; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=djWQoJOklaLH0BLuJ8p0AL7/ItgSiiuZQ01XKXXCzcE=;
        b=zwmFQjWPIQ/ZCWJaEHQD4dRgzdgNdyqEGCh1OCIyQ2ss11AckZnocFl86q1PCVzNxw
         Yp1RLQq9u64Obw8q51az/txvhmQDPhvoJNpTjZXNaZ3sDJLJSekrE47INhnfW/BBXvvn
         Pub9wHh65Dn/LOuCUmUs8x1ttN2SAfU5uJd1xHtv75K6o2yMFMy+tCUfD4HKfT91Dfh7
         oow30SqjMv2wkDd6zeaYZhKI7inFywq+cC0tKzxuIvl90k5I3S55nzUAOJIlwAnXOghY
         9AtkTkWwgB2TEQt8oSwdpdRxr0kq3rsGkuPkN+JCBXGU+z2gpsYfNsRax4szJoZiMPP2
         nfOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733966242; x=1734571042;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=djWQoJOklaLH0BLuJ8p0AL7/ItgSiiuZQ01XKXXCzcE=;
        b=Et7L+lD7ldBV4giMt7myIT45GzNQaruA+0eXBTrPrxTC7B5JmU5bbZlZxVjek6qx6U
         9yaaVLn3PMKjBDv9J4xg70/doTCCAxDfyfQ92hpqXnbYhylHoTmhGiwUE+0qz3ZRv0qi
         P6xyaswG32toCzpBbxIjeIJ6PlkEfoHf/mIDil10MSt9ZWLGRjHpzo6xbLe0wzKvCX11
         OQ+K2ryYhgqah0WzKgKjw6zCVoeJgptNiO+NxyPyurPYeE3dnywB+tnf0KoP2A3RbXXl
         4+oOUj9+hGJlCdumys140/9WPL03p31x5SfeLW5Pi1zYEOeJ92qj00GXVy7hAkDYsA87
         /MqA==
X-Forwarded-Encrypted: i=1; AJvYcCVqFs4Y2O9Tj0OH9xNheDv+jNX0Q2nRc4ceNyIaw+s9Fxf5i4u6lWiwP3t6CpHNv/Y79Cwd7QDg@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf0vvRAIWLG3aV7XTMWyfvygp3U2uJ/G+Bf8RGK/tiVIoe1z0O
	d0f5y+iTfouMfIYI9sjrBf20zpqSijX0fnF/XGJxy88Fn7ewkNruUzdj1T4/e70=
X-Gm-Gg: ASbGncvqIKaYjS9DB4HzynxCNNUID6HdXkLSMu6Xggne9IMvEvnyN/8Wo/qqWLEjHf4
	onS7E7aE7oJWOm4HnuwG36EVIJizMugcBc0G9Pa3JVwKBexPE2u5DrhOR3HMzCzbCbK0EpK28Xs
	Ju5lW0q+P8C4uuFfxE5omGQBnKYFMfSBhw7qllmtv6L1IjLbKXWCMymcbTeOBFvUi8jemc4wO2w
	d1JKCV3KS1pFN4dgKsPOu/ruueEWH5RhMzE74RBYQ8KYcwcTlWlnzY=
X-Google-Smtp-Source: AGHT+IEnJPekbYQNH9UrAAv3zHb1sBsf3vy+46DjthV6gdW4FwtIgcVe9aICG/pyjcXAlON52ZvNYQ==
X-Received: by 2002:a05:622a:1243:b0:467:6226:bfc1 with SMTP id d75a77b69052e-467961afa32mr29536261cf.29.1733966242116;
        Wed, 11 Dec 2024 17:17:22 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46780a93029sm21262041cf.84.2024.12.11.17.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 17:17:20 -0800 (PST)
Date: Wed, 11 Dec 2024 20:17:19 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] vmalloc: Fix accounting with i915
Message-ID: <20241212011719.GA1026@cmpxchg.org>
References: <20241211202538.168311-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211202538.168311-1-willy@infradead.org>

On Wed, Dec 11, 2024 at 08:25:37PM +0000, Matthew Wilcox (Oracle) wrote:
> If the caller of vmap() specifies VM_MAP_PUT_PAGES (currently only the
> i915 driver), we will decrement nr_vmalloc_pages and MEMCG_VMALLOC in
> vfree().  These counters are incremented by vmalloc() but not by vmap()
> so this will cause an underflow.  Check the VM_MAP_PUT_PAGES flag before
> decrementing either counter.
> 
> Fixes: b944afc9d64d (mm: add a VM_MAP_PUT_PAGES flag for vmap)
> Cc: stable@vger.kernel.org
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Nice, thanks, looks good to me.

