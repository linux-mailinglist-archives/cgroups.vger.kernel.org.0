Return-Path: <cgroups+bounces-3989-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2142C940A0D
	for <lists+cgroups@lfdr.de>; Tue, 30 Jul 2024 09:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3A58B24D26
	for <lists+cgroups@lfdr.de>; Tue, 30 Jul 2024 07:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A9B191494;
	Tue, 30 Jul 2024 07:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FckfHNSC"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B068B190492
	for <cgroups@vger.kernel.org>; Tue, 30 Jul 2024 07:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722325085; cv=none; b=meC6oQK1WwGvv3tOybhEfnZVXyN8swFZ9BztBiIi79fsdFSOFDw8SXr71JLEXxkA2KeN/K+phxrqOo5ankjbfFV1hCIjB1T/kGqXwZiRzU+fV/FJy1nMEQsOWbnXpELxpfDACBmARsi2SEEFowPhmi0E14iANBufOlUD8alelFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722325085; c=relaxed/simple;
	bh=dgwe3Zyf00HyU/NKALavOpwc3sH9BkDEgEGdq/ffgNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hK9S2WCGtHEUOFgsMeN1F8ZuDse9gTBGb4wFRb1fUSR3jBUJzjmlMJLmdalRrF1cOLZ2icrdy5eScTz5I80Dc3RO5m0pexzvg4UacAsW5uQbtO3b6HDCN7tB32wEu0hUZZ9AhQpQDCsJjLsvhXBg0oPO0s57YQ2ep5TkLv2JvD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FckfHNSC; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4280b3a7efaso24275505e9.0
        for <cgroups@vger.kernel.org>; Tue, 30 Jul 2024 00:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1722325081; x=1722929881; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aP2T6OTy5D0ymvCgcFvi8Du2T0HtVXhOqCElsmNwVHg=;
        b=FckfHNSC9yfxTkr6hOcL4rletzJXSp3ZARs9t37bIiaIpZ2izleRu31m9zbx7zlpJX
         Ar2rTBJAo+2D5ID5QYYblNtPwvTQe9FwLnqYHOkhaQwYvg9KXS45digxcoQjbYPTHWMm
         0nJohk1mvo9/qqmxjlfzw6nzoUYgy9LW+EIHND6tuxgH5cexzFai3RnDJeKxZVRTVo2o
         FYzKVzomRaYKnPTRCYx4qhkpr2AMBILxRn9MOabomwXmC7nZdZ7PsZlbcS1ePWoQIn8C
         ZzQsCbEZbYfzAUsE4nbo5YJq4QtRbVzV/rRvHfe+3tREFnwbsj8tMuV7iwo5Zh9oUmWG
         M2nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722325081; x=1722929881;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aP2T6OTy5D0ymvCgcFvi8Du2T0HtVXhOqCElsmNwVHg=;
        b=h5UYmeyprnw54XGs/5CvGuFvlIrnr6t+yXQxGIolakGuGF4acDXUq6BhREsd8pPDfU
         x0kA06ZIDIEF2I2b1YqNNPJ/oR/V7ht2eAiejPhQSJXEaLJjuP/tNSnIYoChGVRcmB7W
         ltZkv+Zj51yZWo9996iWJBjv4jDNxwOQ9k/ynA8Fx66mBgYlRifTiS6fOz0/NzeDHStb
         8veQU7WECj/r4Zt5k/DbUcWiF8f58Om51zd0ORMyfa0HyVWIouKAbk2Bi5FU+773dWmM
         YT/8YexFFd0JaADpnRZBFbNvdg7Zk7mszaMEJZwQnxlk5xSQjFuJUCA5rJuWUkNNAmOm
         /QEg==
X-Forwarded-Encrypted: i=1; AJvYcCVdpBfdOlySDu/Zgd94AnY/vPzLqoZ29r5KnWtSaResMMWkTEGU6jwkrPzJm2oTHQoUrw9SDdU7RagKzCooOl7HRbBbv7SXCA==
X-Gm-Message-State: AOJu0Yy3cCHaC6RdNKPdj/gAyxnWSuh4ih54/Rg6VkoA16RZAEwoZPwu
	L4RT6s0GCaDtGvo1pwtrEWN+QzId0qQAnc5a24oVj9/P56Brl/K/Su1znBNdnlc=
X-Google-Smtp-Source: AGHT+IH35TevswwfKpLXXCRG09T8r9dFas3oFIYyAXN49wr/nzgTnrGSBHThgxAdFiTCtbeYuvSODg==
X-Received: by 2002:a05:600c:1d08:b0:426:5f0b:a49b with SMTP id 5b1f17b1804b1-42811e12ce3mr64355815e9.23.1722325080971;
        Tue, 30 Jul 2024 00:38:00 -0700 (PDT)
Received: from localhost (109-81-83-231.rct.o2.cz. [109.81.83.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428057a6307sm203883405e9.36.2024.07.30.00.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 00:38:00 -0700 (PDT)
Date: Tue, 30 Jul 2024 09:37:59 +0200
From: Michal Hocko <mhocko@suse.com>
To: Al Viro <viro@zeniv.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: viro@kernel.org, linux-fsdevel@vger.kernel.org, amir73il@gmail.com,
	bpf@vger.kernel.org, brauner@kernel.org, cgroups@vger.kernel.org,
	kvm@vger.kernel.org, netdev@vger.kernel.org,
	torvalds@linux-foundation.org
Subject: Re: [PATCH 01/39] memcg_write_event_control(): fix a
 user-triggerable oops
Message-ID: <ZqiYV8ra3LKqbwTy@tiehlicka>
References: <20240730050927.GC5334@ZenIV>
 <20240730051625.14349-1-viro@kernel.org>
 <ZqiSohxwLunBPnjT@tiehlicka>
 <20240730071851.GE5334@ZenIV>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730071851.GE5334@ZenIV>

I think it can go through Andrew as well. The patch is 
https://lore.kernel.org/all/20240730051625.14349-1-viro@kernel.org/T/#u

On Tue 30-07-24 08:18:51, Al Viro wrote:
> On Tue, Jul 30, 2024 at 09:13:38AM +0200, Michal Hocko wrote:
> > On Tue 30-07-24 01:15:47, viro@kernel.org wrote:
> > > From: Al Viro <viro@zeniv.linux.org.uk>
> > > 
> > > we are *not* guaranteed that anything past the terminating NUL
> > > is mapped (let alone initialized with anything sane).
> > > 
> > > [the sucker got moved in mainline]
> > > 
> > 
> > You could have preserved
> > Fixes: 0dea116876ee ("cgroup: implement eventfd-based generic API for notifications")
> > Cc: stable
> > 
> > > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> > 
> > and
> > Acked-by: Michal Hocko <mhocko@suse.com>
> 
> Will do; FWIW, I think it would be better off going via the
> cgroup tree - it's completely orthogonal to the rest of the
> series, the only relation being "got caught during the same
> audit"...

-- 
Michal Hocko
SUSE Labs

