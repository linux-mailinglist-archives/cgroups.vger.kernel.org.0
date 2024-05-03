Return-Path: <cgroups+bounces-2768-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E8E8BAF47
	for <lists+cgroups@lfdr.de>; Fri,  3 May 2024 16:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D7201F22FF4
	for <lists+cgroups@lfdr.de>; Fri,  3 May 2024 14:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22D7482DA;
	Fri,  3 May 2024 14:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="EEwiSmqj"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1BA2E827
	for <cgroups@vger.kernel.org>; Fri,  3 May 2024 14:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714748088; cv=none; b=gdKt6i/1x8GzXlM/BMv9k8GUpzHW3AkKoDvUvoLoTEevrOTcsRt1PVpXohLlvLDXgeGqdkIl8AHfs4WvOMtz/B6MOmBVZq+1EAHzrjQaR1WJoY/824oTnA0nYbkAOzqAPqeJeHLAzJJLcLWAKT1mqCIoWPasRDrqfu970KxiRPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714748088; c=relaxed/simple;
	bh=v8kH573V3nLbemGi4DJG1xZ2+1X080JwmMxd/o2exl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WOAplFN13pk52X8wuLPz8cGjxGZqu9iOaWdcoT4J2OIFfNTHCNay89zDnVnlcqMr0znwIP83dC6N1YU5QSFIc+My5F7cqazvtU/nsUQYAHTE/u1xhaoGtP3uM3oLvTpAnXS92vPzOLPyVO0Lu6MZWM5prshzK5Dwc5Qg29HycTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=EEwiSmqj; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-79100a90868so409895885a.2
        for <cgroups@vger.kernel.org>; Fri, 03 May 2024 07:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1714748085; x=1715352885; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OgnwKfJB3kJ01AY0EqJ3oTDVPySeG9MAN3LYuEwZg9o=;
        b=EEwiSmqjvyH5JN2HY4xW0QKQOg+lpi1pQvJgTLsC87Y+HFMnsNh7FgPPC7eJg9qeh3
         AMQPv2ya26IUuKrfVZ2J1Xn6UPovwODBeUFEvY1xmndCtlLOM6wASzBoAOYE3xaoi0Qs
         B0y6L9WwMkf7gzlSKrf9KsMAc3N/jlokt7G3utma1AbkSDvna1mVTF4T1cO/idwv8sDz
         BSXLF3zGHdFovluYeCibhLrIrbuyuZQFPtF3vgmk4IT/Qxc6OfmDGmHicEsWhhgGI7qJ
         mKASZKT1aFmJ1opiLtTPCeCC5qUCthpJJVZmQkhS/uoHz3v/Cvf9L1u0Tx2CIA5Q40La
         bUOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714748085; x=1715352885;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OgnwKfJB3kJ01AY0EqJ3oTDVPySeG9MAN3LYuEwZg9o=;
        b=ZKwF9HnS8dguNfhHzL6vhFpk/GqDZxlSepBPLLjAGSHy8JaLdT6ZsCCNzHIN4GY4Mx
         l30hxnmCsVYtXsnfN40ls5HJ2vAS1Rh0kATOiB32F9XtQmZKMok3UMSdCNlm3PYbHsZv
         dtYV7+Yt7JIUKz38iXTn/t8ikG0IAwk49IMiN81ovJQHIuinW6oT6XrnLJQfoz2qeryD
         kmfmxcqIjkizo71+GxM2MJRKJs3xt5k8MvYLkFH5toRfQ+z+F4SxHnQ2bH9nAn0lABn5
         hW5Wdys24VXBFex8ru7OUMoC971yfW3RpJ1qULcMdpMItl74aZNuRd1H/FFyWSv4kzda
         qQHw==
X-Forwarded-Encrypted: i=1; AJvYcCUI1/nzsy+2tRkajI2n5+eM3U7LFk0lpLmI06RM4EHhkcZ/KnFed1s45k0dsGFvMzoRxFm05vgJj0C6XIXzIhUmILVX8Hcazg==
X-Gm-Message-State: AOJu0YwiIijd/IW+ezVfNWFYFiUOajcL5cF9T7JGosAx7UVfxgnsddml
	HwjTXbfyPW52ATN160oD+6AV2oKR1CwpCUJJOOAy/P8s7tnnqG2uKM2NRFawbqw=
X-Google-Smtp-Source: AGHT+IEtOZyEr24VbO8xFLGbBcJxGsTi5hvCM74iUWTfb4RSHWb9Vplkpo+dXXpzeArp6XXpPQ0+mQ==
X-Received: by 2002:a05:620a:3b8a:b0:78d:61a4:6955 with SMTP id ye10-20020a05620a3b8a00b0078d61a46955mr2685812qkn.67.1714748085468;
        Fri, 03 May 2024 07:54:45 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id p18-20020a05620a22f200b0078edc0a447dsm1297062qki.68.2024.05.03.07.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 07:54:44 -0700 (PDT)
Date: Fri, 3 May 2024 10:54:44 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Usama Arif <usamaarif642@gmail.com>
Cc: tj@kernel.org, lizefan.x@bytedance.com, nphamcs@gmail.com,
	corbet@lwn.net, linux-mm@kvack.org, cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH v2 1/1] cgroup: Add documentation for missing zswap
 memory.stat
Message-ID: <20240503145444.GC2538005@cmpxchg.org>
References: <20240502185307.3942173-1-usamaarif642@gmail.com>
 <20240502185307.3942173-2-usamaarif642@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502185307.3942173-2-usamaarif642@gmail.com>

On Thu, May 02, 2024 at 07:50:24PM +0100, Usama Arif wrote:
> This includes zswpin, zswpout and zswpwb.
> 
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

