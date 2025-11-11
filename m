Return-Path: <cgroups+bounces-11833-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 285EAC4FA4C
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 20:48:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 048CD189991C
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 19:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF40E3328EA;
	Tue, 11 Nov 2025 19:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="M+HGwQjc"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD5F333448
	for <cgroups@vger.kernel.org>; Tue, 11 Nov 2025 19:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762890490; cv=none; b=fG4L7RSivlFvqGDKgJhK4cgUHXFjCydPB6fSysyLuDI6CapSssqJELV90rS8otus5x8yv96IQrRyQ316AUul5wszBcrfLW+wRKQcQeKI11QPEcH1QreEWUkyW+X2H07ujMW/P9HV6EixCq3aqSuLzdBvwz4PYTDo23dMK6fSVIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762890490; c=relaxed/simple;
	bh=7NdM9un//Qfx73SdLhAZgOos/RHP5qnSPQzhB6KpO0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fCjzmVZ5JUeu7k9AIsf2ikbN11LYOSEL+zlAcnzBF8E5Kux4sKNMyvIlmth9Axn3B5IJJZuvHpnIYwyuGBEPprbwXR+AoGKJhfD3AGu5wMWU8J55do9/TInqNDUzL+I9xwy0IRC9f3pCVfgndc2DXtm6DLUOmTiF6pNGoAT5JXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=M+HGwQjc; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b725ead5800so17084766b.1
        for <cgroups@vger.kernel.org>; Tue, 11 Nov 2025 11:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762890486; x=1763495286; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lKDhxqPky+srato1DuJ5M1fuwPAvG3rezlKsBwQc3xk=;
        b=M+HGwQjcYfUdbj3df22FBRRQUUcEwQVqmaxOs75Z2J8aVsx9lVFnRP+SGNh0qzig4q
         JHTMx0kiC7KoUFCJ92wZzPidu1KZ7RkvZGF8HuCADjIRyuAPkObgQz1FU2+wvZw/D0+d
         frjbwY/Aj1XUs8r2V2hB1XXBGNPwFBcQhUlEcZQ/lp5FVT3hvIeZ/rF0u5l038uKM4VK
         sfuh2BcvOaA1HHSihxT9Ggf7614QBX+CPM6fWS6w9rCcaksnIpCS3sko0m75mJNnWoKl
         5057wFox0GHKQlu+BXvNjMYIMA0IjA/vrHJqePUfdKUbIvo35/1A5b0fNkA8D2j7zrDi
         1O5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762890486; x=1763495286;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lKDhxqPky+srato1DuJ5M1fuwPAvG3rezlKsBwQc3xk=;
        b=rHQ5mdYs548NXhCyiAQT39ezgIx9O/K9DMKoMvdizGJinZq/dipUrq72rPP3zIyzVB
         dLPNmioWO6f3/uNzoMyRxsfW71V4KHzN0s6zWNDDZ45RA47QdKqzpOnwA8tqXLIHmF3l
         hqrjVTAP6JDAdFdEknjbmTS1j4cmfxKTHI8naSbaokwbWIGD9lyrzE9g02PihwU+ly9x
         RERg5u6O8GqS+KKxrFK5XgMYlSbBD98O8RE6OOFpQ41KB2C1duZA96jOBqVQUGsFhFXR
         yUABX9kc33TuEyLVoz1LcZeXAUO06RDs5NQxgtGQTNFnWNzw6rGpA+GLCm4IP4XUANbR
         i3ug==
X-Forwarded-Encrypted: i=1; AJvYcCUHF224hXOO8HtS859ecpb8D7696TQnWqQ6ICF1Eva9RdsW6s3gSB+xE59aCfhfeX9RV9LeY4JW@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4ZlsEv6/4u2yUyRUS4XMnnvn/e1aBkD39VykHSmhRE8Cd3mVn
	2B+nl/b6lMvrjl/60qwBg9DPLgP9VFYKX4KICGrJ5AAJSnm8JmxsMfX2TA7Q1bbywTE=
X-Gm-Gg: ASbGncuCXod4yprjwxr3zHmWKXbHB3NZoVCSUNIcrdu0ybTeGEJIpKhmtHeo+vVcds4
	6/bxddH2oWcL9Mh8zrDwPeau559gdUHv96ZyCdVIXSEoOhiTcL+1uFDYyod/7vAHHmKQJmPzDF3
	bwfIj4VXvCk1RJdUcPPvSVtd6ek3hu1by0X0/XJIA/Jx09m7AzBBg1Z5WlWgSRnQxwmlHlvfAFh
	vY7wwxVreMm9rV66cEMMEnJ86sdt+1D/LqgIenAa19KBm6hZja2EWcj6/l7DLLuYQJVZC1/2HVX
	5I6KjK9Yx0biyL1SJIEWsp0Tk23AbB5NTOSyrROMpAkzOviK6BBbbUulupWLg3WVSkMTyysOO4n
	fYQYJxRupUlH7iVJEfg5S4OYMeAdAa9CSg163mYsPWoo6WDvBlXD1k1iEZKFc6e7gAnjhc1sEnQ
	tNmDvb2HjoH26yCMVAQaKlG9RM
X-Google-Smtp-Source: AGHT+IEelejsUR71Jpq8Ao/NajBuvRLoWEBkOC/8vGvaNmUC/dfrqtprfl//rF6trpCO0nJn8h4ofA==
X-Received: by 2002:a17:907:9812:b0:b73:21db:53a0 with SMTP id a640c23a62f3a-b7331960eb5mr32990666b.8.1762890485668;
        Tue, 11 Nov 2025 11:48:05 -0800 (PST)
Received: from localhost (109-81-31-109.rct.o2.cz. [109.81.31.109])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf9bdf15sm1411961966b.62.2025.11.11.11.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 11:48:05 -0800 (PST)
Date: Tue, 11 Nov 2025 20:47:59 +0100
From: Michal Hocko <mhocko@suse.com>
To: Waiman Long <llong@redhat.com>
Cc: Leon Huang Fu <leon.huangfu@shopee.com>, linux-mm@kvack.org,
	tj@kernel.org, mkoutny@suse.com, hannes@cmpxchg.org,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, akpm@linux-foundation.org,
	joel.granados@kernel.org, jack@suse.cz, laoar.shao@gmail.com,
	mclapinski@google.com, kyle.meyer@hpe.com, corbet@lwn.net,
	lance.yang@linux.dev, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH mm-new v3] mm/memcontrol: Add memory.stat_refresh for
 on-demand stats flushing
Message-ID: <aROS7yxDU6qFAWzp@tiehlicka>
References: <20251110101948.19277-1-leon.huangfu@shopee.com>
 <9a9a2ede-af6e-413a-97a0-800993072b22@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a9a2ede-af6e-413a-97a0-800993072b22@redhat.com>

On Tue 11-11-25 14:10:28, Waiman Long wrote:
[...]
> > +static void memcg_flush_stats(struct mem_cgroup *memcg, bool force)
> > +{
> > +	if (mem_cgroup_disabled())
> > +		return;
> > +
> > +	memcg = memcg ?: root_mem_cgroup;
> > +	__mem_cgroup_flush_stats(memcg, force);
> > +}
> 
> Shouldn't we impose a limit in term of how frequently this
> memcg_flush_stats() function can be called like at most a few times per

This effectivelly invalidates the primary purpose of the interface to
provide a method to get as-fresh-as-possible value AFAICS. 

> second to prevent abuse from user space as stat flushing is expensive? We
> should prevent some kind of user space DoS attack by using this new API if
> we decide to implement it.

What exactly would be an attack vector?
-- 
Michal Hocko
SUSE Labs

