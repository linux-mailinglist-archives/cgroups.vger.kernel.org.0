Return-Path: <cgroups+bounces-4182-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E73094D4CA
	for <lists+cgroups@lfdr.de>; Fri,  9 Aug 2024 18:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF067B20DAE
	for <lists+cgroups@lfdr.de>; Fri,  9 Aug 2024 16:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50AC21BC3F;
	Fri,  9 Aug 2024 16:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dMvcEJeU"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5581B5AA;
	Fri,  9 Aug 2024 16:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723221385; cv=none; b=NpuaGn5Axhs0iloaYXq5FNKQonS33TriJFG4gjnUWj/oouOtUav5E0gsJNMwCsoKeBQujvADMIVnWaDL6hRwxcAJXX0blA96i2JBrlD4k93Kh7qT4TQ+vWBrLpGqQRvGjEQ4kBAKJTNKU9h+0PYr5VVgWdMfwHtrwni8bMFTPEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723221385; c=relaxed/simple;
	bh=OToVOByJc9WGbBP2Mfrsg0JmnvRj/WNyOXEd2KhUXiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mPUfvQzT3amwS1Y3BIQVQFQC9f3C/Wm3SZ2SBreFp25MpE3o/zcb5Scy8JxN8WhDT4nMGzIOp8lbB8QocoJl64QMX03NhiXFDYbAbjW5ih/gdVUx1vYKBCoxE8Q0ox0QlqTCLYG3gckzLzCBS3WxExhZXcLfEF4LO2P/m67YPAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dMvcEJeU; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1fd65aaac27so23367275ad.1;
        Fri, 09 Aug 2024 09:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723221383; x=1723826183; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dOvKQQNP7wKM/xhTNrHs3+UTyLUMewT6tRAzSUGbnrM=;
        b=dMvcEJeUFfu18NpjPJWh//ug3MgJTIrhntF7cmcccUMc9uP+6yszQynnjCtUOLSkeO
         frtQ281xImH9o6yhYHf7ejwIbA+7Zp4a1u0cPOW1622P0D3+lKyKKC5XQsH4+bmOhu6t
         j80x26fPt8IA9Doy7n2n+or/rgtFm7AOP13J+/Kjwi27yQp+XMC/In2bJPv9+ymUr1aH
         ir2L3dXB4jFjhu+lyH1RUJF7y0h8JYxlGeOh/py28PcwR70QCpeEwZjWezllfcxpj4dF
         c4MTFVQ4ao7eF8lfyrKNqLAQKW7iDGFt7XDq8YMnQhW8+GqvabO1GuydK8b9YinLhdQj
         Gwyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723221383; x=1723826183;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dOvKQQNP7wKM/xhTNrHs3+UTyLUMewT6tRAzSUGbnrM=;
        b=PPsgTzghHIEnZEInZKhoImIPUA14VWPR3Ozko21tywo9ZudsahR1ul3Cf1BHo5dMtK
         1crhw1+CzyMITkz7yQafXBTsAObIrvNl/QsACcE4atCVaBpzto7gcSN3m6TxGkArfCLT
         mDmuKc3+9cRV/poCW8uQBuaIyKlYe1zh7mZOJrqwUgxtX1XNXmXnFaDHAYfCG16FiPbz
         nD5U72oWxeMAs4t0HOjWPpJGgHZofE5XaVUQN6m9Efc9r4dclfSXJ7wNQ07opKkW0lS9
         a9fm1136cJCWvqD1Srxp4yI5a4Ndl/hxVBNGJ3+lJGyZg0aOtY5BErH1dHE61D9pgFSe
         swRw==
X-Forwarded-Encrypted: i=1; AJvYcCVGk/ygzvtRCnPAb1MH9mLeEKRRhfwkPjqRglEm08tRT2PziAdpt+l0b4immrfKsNup1BsDoxpVkPddkNvyUEr8+rFOxFIjHx6E8y2avcplHRmqXl0X5e3ndEC86WfdnIO0JyA4gQ==
X-Gm-Message-State: AOJu0Yye9QRTmzd2nweCAS32VJOdQbayf+U3AoS0uuBQcq0A/G6WFAYR
	PZaVgB855Nq3dZTFRL4l7jXGw7fg4CXiwHBmE++ywQcObe/ch1IF
X-Google-Smtp-Source: AGHT+IFVCeA/b9e17h+cmmnvP7oaLRRrCCPmeSg+lLdsYq3zPA+cU53wOV+gn/K003Of3sgVK5GwGw==
X-Received: by 2002:a17:902:f70d:b0:1fd:71cd:4431 with SMTP id d9443c01a7336-200ae5ebdadmr36719215ad.24.1723221382730;
        Fri, 09 Aug 2024 09:36:22 -0700 (PDT)
Received: from localhost (dhcp-72-235-129-167.hawaiiantel.net. [72.235.129.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f26f4bsm144551635ad.34.2024.08.09.09.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 09:36:22 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 9 Aug 2024 06:36:21 -1000
From: Tejun Heo <tj@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Kamalesh Babulal <kamalesh.babulal@oracle.com>
Subject: Re: [PATCH] cgroup: Fix incorrect WARN_ON_ONCE() in
 css_release_work_fn()
Message-ID: <ZrZFhe-teNE6xAKn@slm.duckdns.org>
References: <20240809032259.1233679-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240809032259.1233679-1-longman@redhat.com>

On Thu, Aug 08, 2024 at 11:22:59PM -0400, Waiman Long wrote:
> It turns out that the WARN_ON_ONCE() call in css_release_work_fn
> introduced by commit ab0312526867 ("cgroup: Show # of subsystem CSSes
> in cgroup.stat") is incorrect. Although css->nr_descendants must be
> 0 when a css is released and ready to be freed, the corresponding
> cgrp->nr_dying_subsys[ss->id] may not be 0 if a subsystem is activated
> and deactivated multiple times with one or more of its previous
> activation leaving behind dying csses.
> 
> Fix the incorrect warning by removing the cgrp->nr_dying_subsys check.
> 
> Fixes: ab0312526867 ("cgroup: Show # of subsystem CSSes in cgroup.stat")
> Closes: https://lore.kernel.org/cgroups/6f301773-2fce-4602-a391-8af7ef00b2fb@redhat.com/T/#t
> Signed-off-by: Waiman Long <longman@redhat.com>

Applied to cgroup/for-6.12.

Thanks.

-- 
tejun

