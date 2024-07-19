Return-Path: <cgroups+bounces-3807-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA2E93770E
	for <lists+cgroups@lfdr.de>; Fri, 19 Jul 2024 13:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F3C11C21144
	for <lists+cgroups@lfdr.de>; Fri, 19 Jul 2024 11:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED3184E14;
	Fri, 19 Jul 2024 11:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="D7K0KS+t"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910BD84A3F
	for <cgroups@vger.kernel.org>; Fri, 19 Jul 2024 11:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721387625; cv=none; b=aXXFfg36texIncdWORCEO/mD6nIYjD4ugJFLrQFZMjuf+VPEnBkj9320NZyIzdPvCZr1US5NuufSjvJ/CPvEON/c0pnCjg7jRowQsBhMRg/rjQlZQL3kPXSuvbgzNUSMbCGeOWfFAfTkCTAZc8UW/JfFkDlR8G0uIunXCSeQjhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721387625; c=relaxed/simple;
	bh=qBaiG5kqQhH79tml+NmxeAEr9aIwKvRI9MizFupxJDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m/T/RLYcEoCd1cFbJQKQUxjLy34pOOd0PZ5lWpE1JqJWPbpnmfiRhKoJwwZcPl9FzaUV3ikvrSH1emq9FMGZXrkJMzL0K2h3mBYgPIzBiclOvEUA7dwYMOJ8nV8KEwol0XWVbfTgIh7fnbBuMZrpKhomlX1kQsH9T+83BoSJXYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=D7K0KS+t; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4265b7514fcso7683805e9.1
        for <cgroups@vger.kernel.org>; Fri, 19 Jul 2024 04:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721387622; x=1721992422; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c/hJ8wnjbDuxfWM3Tq4+OMqsgmm7qEdaDItpuu2xR/o=;
        b=D7K0KS+tSUbhpRNPIuwzs6zW4ady591zFxaW94Zvd8blpY3UA3mU+a8dVV09taufnv
         n8+/snC620uAsKZGWhf+c79BVo1+W0Olz/Xqzt7nTT46QJ3o5Q6xHsyPuOSw5N4PMI7q
         67p6+EeUhjVq7elPjQ0AvAeIGghLWmYFgc/RKjqsqaf6dRAU/bkYAJlRQkq7r3ZatTKE
         P3lwiw1qbiz2nO+ahEf+XbVveA9KTpoOYl7UnGp3tc5Io/msbtxEzD2WbZe90ibWy2bL
         xWd/M7KgEJQwX8UzvCMFzpjd/jJgp2WWguBkijNMMuIGq+BD0K5+yjY93NgTgEbWP+s1
         x7yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721387622; x=1721992422;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c/hJ8wnjbDuxfWM3Tq4+OMqsgmm7qEdaDItpuu2xR/o=;
        b=Xa+NpHcL2tGY/QzEGVQJZfUNtTW7ABWjYgC3DSAUYQdpJugFWQLRrj5XGP46fxVq9O
         lHDerl+f1sxkaXACjOamdphu4Ex6XtibL47pH7K1AtvzYEpmOoom6pUCJrE3UAITKQ5u
         L6yRwrFFwV+T7D9/69+FuUzRECK6L/jzDYnfqhG2lcny8WfaYoiwKOA6o1hEm1G7sjWb
         wjaE3bPmFZPRachS16BypGKPthUCaByT5NdAiJfGOLeMimdRKbWs+UhicKk+Afp7GNzV
         lldiGAsXY59VmuGFTnQItOZCgrPLehXTdQ0lEaWeDQK3BJjc+47UfmtRYHnx4UTNnHbt
         exOg==
X-Forwarded-Encrypted: i=1; AJvYcCWNM1C1z0fWUXoeBm+PFirwQtnUKfE62sBAJUFlJ5kZaXer0k9LRnpLXc48rwucmgmRxqbMbaAYgjN6lMd6FxeAhGQuI1jlDQ==
X-Gm-Message-State: AOJu0Yy+9tNZnBB8b4PwAHDlv1Z43TaABxb/Tt9JkRoRx+vw8pk/Vo66
	iKFp1dRO5/h+fyf4DdfYfy6SSIO9N14Ss50s3qAFIjRCgSZecog66lPK8LVjy3Y=
X-Google-Smtp-Source: AGHT+IFFTSAngSqOd87uolfAFDHs1rtPMbH5HwC4G5bU6Hlf4czYjY+bRmFgsYw+ZY6dxQTogeEDgQ==
X-Received: by 2002:a05:6000:100c:b0:368:377a:e8bb with SMTP id ffacd0b85a97d-36874027587mr1310231f8f.28.1721387621846;
        Fri, 19 Jul 2024 04:13:41 -0700 (PDT)
Received: from localhost (109-81-94-157.rct.o2.cz. [109.81.94.157])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3687868ba9asm1319052f8f.41.2024.07.19.04.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 04:13:41 -0700 (PDT)
Date: Fri, 19 Jul 2024 13:13:40 +0200
From: Michal Hocko <mhocko@suse.com>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, hannes@cmpxchg.org,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v7 1/3] memcontrol: define root_mem_cgroup for
 CONFIG_MEMCG=n cases
Message-ID: <ZppKZJKMcPF4OGVc@tiehlicka>
References: <cover.1721384771.git.wqu@suse.com>
 <2050f8a1bc181a9aaf01e0866e230e23216000f4.1721384771.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2050f8a1bc181a9aaf01e0866e230e23216000f4.1721384771.git.wqu@suse.com>

On Fri 19-07-24 19:58:39, Qu Wenruo wrote:
> There is an incoming btrfs patchset, which will use @root_mem_cgroup as
> the active cgroup to attach metadata folios to its internal btree
> inode, so that btrfs can skip the possibly costly charge for the
> internal inode which is only accessible by btrfs itself.
> 
> However @root_mem_cgroup is not always defined (not defined for
> CONFIG_MEMCG=n case), thus all such callers need to do the extra
> handling for different CONFIG_MEMCG settings.
> 
> So here we add a special macro definition of root_mem_cgroup, making it
> to always be NULL.

Isn't just a declaration sufficient? Nothing should really dereference
the pointer anyway.

-- 
Michal Hocko
SUSE Labs

