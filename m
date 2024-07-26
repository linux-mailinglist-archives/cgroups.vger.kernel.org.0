Return-Path: <cgroups+bounces-3910-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 774AA93CF19
	for <lists+cgroups@lfdr.de>; Fri, 26 Jul 2024 09:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 233D11F22A68
	for <lists+cgroups@lfdr.de>; Fri, 26 Jul 2024 07:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97B7176241;
	Fri, 26 Jul 2024 07:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fJRe4j+1"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CFC17622D
	for <cgroups@vger.kernel.org>; Fri, 26 Jul 2024 07:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721980477; cv=none; b=R+Uj9KQPDH4k69zcQBkD0k5z/yYP3cSyrT0wIXWeLnAjk+kOOT+1vDrQ4XNaijOgZ5oGXWvKEWbV3pFPa5YBW2qT1jmRUtDui5kIEQH1iUZSKsvp8o1noW7/3vEsHVzHL9WcrBS3cCL5rr+wkYmRatauSZYgZi5ebp99VWR/8dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721980477; c=relaxed/simple;
	bh=RwzWWLRlKkqepKvBN5fdT/d0yz8f733U2RRrSTg9/no=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HkKMKnXOEnshHkAwFcmghldHRDfEHvBsYoT3aFiZB5X6DtQHDLR9DHTIEmarxR7d+tVHxTzpe8bqNC0/2XNdGM7gaHoGD57gpfHhLJeqCb0g1CfiC2Fh4z8H2bVFBPdBjyIopa6nKpVlSg3NnEfUsaJ2Of5brXJTY4pQRWisO/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fJRe4j+1; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52efd08e6d9so1508008e87.1
        for <cgroups@vger.kernel.org>; Fri, 26 Jul 2024 00:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721980474; x=1722585274; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vLnzH0Tuz7U9XRD9djw1OdkIPjJA5X6DCcdcepF94ns=;
        b=fJRe4j+1QYtJrYzwt+C5BF9XKxPgaGFjmhApX8bYLp/i47eToIanWw32Ad83PI30KH
         NKuX04y0+hDGEWebmpwK3viJeFJ/QVe+EhCB0PSttPTgbzAd/DYd0ldils+I6lw986Xh
         vml3as+CsFtC9xE/ET+W+5VUfmeJ+js4C7kRif+I7qFsFogtuQykMOB8/5sBzj4yVWN4
         IOyxIdZN4sSPHCh2iIw5etQnXQ+fU7O1ECr9Snbs3i9w2NVoywKJPKVIdWGZAw6WfYMf
         xBCgh+j4Q7VlYWaaTfke6wZICC3mK9az4/RYJao3s0qqZz2wTp/+bDlK4Q1JDEk/PXvR
         f4cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721980474; x=1722585274;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vLnzH0Tuz7U9XRD9djw1OdkIPjJA5X6DCcdcepF94ns=;
        b=pC3bJ6ncZUF4uyVNwwXI4uOSIxJZzgaM8Hun/Nva3e5EW3+SNZ1baJSozKwutnXLN4
         ysjGATRW0yUtB2UV5QvySgFUDtl9Xc9xtoaW1LRZJLVuv6TRzMHCe7Arc3pCzmzYGFs2
         0c3q0BdDaswTljuyRycT5y+BeKBmtqndZCzcEGaAxQtjh2JlWW3lhrfGu0h2/2yB2nQe
         YT4FFhkZqz4hvu/ZDMYnYSqYEjJO1vhrPUjMHem6CRr3VufGBSEXykbPaFu9rp48CVu0
         NF5gQZ3Dgcic/C2KVe4Y2PM95ez5hIqEdcUXPNu837PESZfmzj5FdsRQGFF8dGkNCknP
         LwRA==
X-Gm-Message-State: AOJu0Yxrgc9vz3emdpZ9wgon2IFNb1CqPSz69xVdktrjkPyvSS8wzuj2
	dDFM0LsiepUWi76eUzvCMppjwB01nlJAbgDHw6vVSRcWF1VldvTCQfPTOFp7CgbuSNtm3oiselX
	T
X-Google-Smtp-Source: AGHT+IFnZcbYOKsf8mFfRLK1pWmaH8ouvafSG1jZC4pd2hKy8vDuX0O20rzr0mRRxFIliC1jFHoAew==
X-Received: by 2002:a05:6512:683:b0:52c:daa7:8975 with SMTP id 2adb3069b0e04-52fd3efe6aemr3714067e87.18.1721980473716;
        Fri, 26 Jul 2024 00:54:33 -0700 (PDT)
Received: from localhost (109-81-83-231.rct.o2.cz. [109.81.83.231])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac63590ac3sm1578410a12.34.2024.07.26.00.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 00:54:33 -0700 (PDT)
Date: Fri, 26 Jul 2024 09:54:32 +0200
From: Michal Hocko <mhocko@suse.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memcg_write_event_control(): fix a user-triggerable oops
Message-ID: <ZqNWOLwOoKfquBvH@tiehlicka>
References: <20240726054357.GD99483@ZenIV>
 <ZqNLEc54NVP40Kpn@tiehlicka>
 <ZqNMfL6JmgHCJwBv@tiehlicka>
 <20240726074804.GE99483@ZenIV>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240726074804.GE99483@ZenIV>

On Fri 26-07-24 08:48:04, Al Viro wrote:
> On Fri, Jul 26, 2024 at 09:13:00AM +0200, Michal Hocko wrote:
> > On Fri 26-07-24 09:06:59, Michal Hocko wrote:
> > > On Fri 26-07-24 06:43:57, Al Viro wrote:
> > > > We are *not* guaranteed that anything past the terminating NUL
> > > > is mapped (let alone initialized with anything sane).
> > > >     
> > > 
> > > Fixes: 0dea116876ee ("cgroup: implement eventfd-based generic API for notifications")
> > > 
> > > > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> > > 
> > > Acked-by: Michal Hocko <mhocko@suse.com>
> > 
> > Btw. this should be
> > Cc: stable
> 
> Point, except that for -stable it needs to be applied to mm/memcontrol.c
> instead...

Correct. And if anybody wants to backport to pre 3.14 then to
kernel/cgroup.c

-- 
Michal Hocko
SUSE Labs

