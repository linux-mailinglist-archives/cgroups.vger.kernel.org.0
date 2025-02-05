Return-Path: <cgroups+bounces-6434-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFAFDA2986A
	for <lists+cgroups@lfdr.de>; Wed,  5 Feb 2025 19:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47722162E44
	for <lists+cgroups@lfdr.de>; Wed,  5 Feb 2025 18:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EAAF1FC7EA;
	Wed,  5 Feb 2025 18:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="c+k2YR54"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084BD13D897
	for <cgroups@vger.kernel.org>; Wed,  5 Feb 2025 18:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738778930; cv=none; b=MZWYFof5X2EwkJ15SiKzvxtALyvKyflVQV1wLOz93rhvsZYwf48yQE1e1/pBnWSMMcOQGdQ6zg8kaVaRZOnwUi+44aoYnP4ry60wS0wrtinCyCI2qFyV6x4MrUO6xezvv+bKPJ2OFS9N3DBJRSw/td91Z1F0MKX2mKi/dhaDnC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738778930; c=relaxed/simple;
	bh=Gk4kP+/tk9hmoI7BF440tWmPAIxTlxWICUP2ahE1gXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aULMqeukbDmwly5ieNYg4YxLTkRZXPWqReszo78SF69Wh5FJna4rQMcD8TjKpVIjwo2S15IWM7ZS/F921heBiQTzrUzquoKFPdtffSNzueiAlIlrVN+FBU83c1nkDxID2TwN4IKsVZ2qUt5hNpp/gWVMI/+gpMLrwbqUXQiReXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=c+k2YR54; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-467838e75ffso1167861cf.3
        for <cgroups@vger.kernel.org>; Wed, 05 Feb 2025 10:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1738778928; x=1739383728; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t/f1eQWxiOupVkuxOIXZpfdNu/PwLIl38Rx/BBVWxMU=;
        b=c+k2YR54Iq6VttY2Mb53YO/quYqOoIecfsT2sZ/EJ6e2cOUh/GP5YK9laIUobsUttc
         nWh2ywVL1ehghvWrCJfPHx5YJVmKtQrO6f/iE8MPn+1ST+I4vmXaSloU4Vr129BPJHeM
         gTRjc/7bLLUmipKOHSwkSNxlgtF3ZjtMM2D3UYnODuGKArPhFnJhfWtIgXUOdI7ZiyV+
         qHQUoNkD8ALpJRJv/3Uw39Xnb5voM8DLw3+JvRP5kHGuXRE4T7X2rY0tPegtZH0n9772
         mY9/QZN0VQguogEpQx/0z3OQbtvwZsEDqI4iLFTLlADYFNVlt54Dr5i+lEFjxZl1MSpL
         0vCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738778928; x=1739383728;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t/f1eQWxiOupVkuxOIXZpfdNu/PwLIl38Rx/BBVWxMU=;
        b=EZxr+7IEC7sbl7uCsJYJm2j/BzM2h+iN4+GVs92rEs4UgLoBEfG2gorK2HYLmDBVIv
         4cRc/ZD4FSY1Oxo6L3H3sraNqYl59kRF+IVW5pCllFJTEJ5npk03E4SRYV4otzQmcBzU
         Qu+v7s345NveYdfX3NxT6qymDN8aA2do/HioSzBYgPVM1rWaIS/yOmQG3WqVamdMAiGA
         hHJz9SOiB6w8MtMZlkvK8U9FLsydkdZJif5EKUkpKHVS5FBn///H47lAGy68X3kSZHBm
         l++zfcIIC4HdFVVf2mR5a7oGZ7MEUXLW9lCbS4BlbeHAuB9hq8Q+4hscDBTwT01w1sEm
         GbDA==
X-Forwarded-Encrypted: i=1; AJvYcCXG51+JI6aSnSJ759DPosKJFLAWzM6SoEGhZo2zAZ0QlthbPJ3QdKuF541QcqOx/5QcDVoDCtpV@vger.kernel.org
X-Gm-Message-State: AOJu0Yxlaa2Gk7nKfoWE8RcT/E09knC5YP9QU0MeetO4HykPYuImpe5S
	twnR5QRFGXEGTqdsxLt1XE+1Pp1L1wT/3OT8M1rTJipDqs8LYOWDH3f9UXWI8WM=
X-Gm-Gg: ASbGncs6xtRpdNjcJZZjjWigqhQeHFswxOotsKs561Vl9KbkBIY0lzNbyK9wb/tjZkV
	aYmUJMKavB1+MrD+pkeD4z50Ol+a3h5mULx9OhNRvpC3a5lCAZUAV9qNgaWwAdo8HAwdpBeXwt4
	rASzlrXnjMtaOh0duuSgLoKrXgsZvTJ9bq4rMNtvRMzKSr2y0LaejTSTWOMDCWwnfwP7geFsICO
	eUVRcz/Y+mxPSRC4clSj81M9VCmakDAIhaYMBK1lcRX4FNJXVW5HMbY9Kfj+ZDWb1ykDSv6/f/k
	QW6lgf8C6mqRwA==
X-Google-Smtp-Source: AGHT+IFekWA2zVQ+supRDao76cDIt6tiMYrqfqMbENai9weygkPVnHjjvPuvbUEUkDVaY7rbuhag5A==
X-Received: by 2002:ac8:7fc4:0:b0:46d:faa2:b6e0 with SMTP id d75a77b69052e-47028168976mr50934431cf.18.1738778927807;
        Wed, 05 Feb 2025 10:08:47 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-46fdf0a74a5sm72911691cf.8.2025.02.05.10.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 10:08:46 -0800 (PST)
Date: Wed, 5 Feb 2025 13:08:42 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
Cc: linux-mm@kvack.org, Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Michal Hocko <mhocko@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Allen Pais <apais@linux.microsoft.com>,
	Yosry Ahmed <yosryahmed@google.com>
Subject: Re: A path forward to cleaning up dying cgroups?
Message-ID: <20250205180842.GC1183495@cmpxchg.org>
References: <Z6OkXXYDorPrBvEQ@hm-sls2>
 <ccd67fd2-268a-4e83-9491-e401fa57229c@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ccd67fd2-268a-4e83-9491-e401fa57229c@linux.microsoft.com>

On Wed, Feb 05, 2025 at 12:50:19PM -0500, Hamza Mahfooz wrote:
> Cc: Shakeel Butt <shakeel.butt@linux.dev>
> 
> On 2/5/25 12:48, Hamza Mahfooz wrote:
> > I was just curious as to what the status of the issue described in [1]
> > is. It appears that the last time someone took a stab at it was in [2].

If memory serves, the sticking point was whether pages should indeed
be reparented on cgroup death, or whether they could be moved
arbitrarily to other cgroups that are still using them.

It's a bit unfortunate, because the reparenting patches were tested
and reviewed, and the arbitrary recharging was just an idea that
ttbomk nobody seriously followed up on afterwards.

We also recently removed the charge moving code from cgroup1, along
with the subtle page access/locking/accounting rules it imposed on the
rest of the MM. I'm doubtful there is much appetite in either camp for
bringing this back.

So I would still love to see Muchun's patches merged. They fix a
seemingly universally experienced operational issue in memcg, and we
shouldn't hold it up unless somebody actually posts alternative code.

Thoughts?

