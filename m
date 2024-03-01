Return-Path: <cgroups+bounces-1929-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B6C86D855
	for <lists+cgroups@lfdr.de>; Fri,  1 Mar 2024 01:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6BE91F230E3
	for <lists+cgroups@lfdr.de>; Fri,  1 Mar 2024 00:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1571D1FCC;
	Fri,  1 Mar 2024 00:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="VPkA6xFT"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B632568
	for <cgroups@vger.kernel.org>; Fri,  1 Mar 2024 00:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709253057; cv=none; b=XdwpayioBrtaAGDz4ngoFqC+iNq1ScPr2pMek+Dq0oMvjOdkxqvO0lZbhu7H6K9l7QG8ksL3Im/LbWgWSbSgjGL4vascXaiP7Q7NwQyXdDU1+qpcoAxlJvcJH/y13baN275tyL0/zWCZXipnMsIaFsa5zYPpDHFyZEfUV/4iUDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709253057; c=relaxed/simple;
	bh=NXsqQ2Sgdkn+a9Uci3zRdC9SMnBC4lhphpNxOxge9VA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ahh7vHDV53zd6+BEp0oDDGK0nH0KizhFP5kcdJR121orOctB1f/aIgvkG0/HY6lraoqBprEqBfenJI/Nf4dMlzh2wLckK5YFiWolrsSvCfWDrvSyKq6WemoTTQ11/d4idRFnhtXKA6CaTFBfJyZsrfCXmEIXjIX6m6gCwsYfVbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name; spf=pass smtp.mailfrom=chrisdown.name; dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b=VPkA6xFT; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-412c34e84a5so4318235e9.3
        for <cgroups@vger.kernel.org>; Thu, 29 Feb 2024 16:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1709253054; x=1709857854; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/6TCxBl7DrW+C2Xnhe2LFnZv9gvBSqtviEifvQbUuYg=;
        b=VPkA6xFTZWj5HUU6zA3oO/dFBMKFPK+yWpT0+5tYNBboneGpeB7G6qDWbLTx2BMTfF
         IPc6XPG4M8HmmmuTlPofAfMVPsf7h4XrJ9kgscz7NLQy4yRy0fcl1afjmY4PsEYJVJfo
         lk897CmhX/8a9icN80pQSchcGa+Sdz1+MZzRo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709253054; x=1709857854;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/6TCxBl7DrW+C2Xnhe2LFnZv9gvBSqtviEifvQbUuYg=;
        b=gkBllGl+Igpvvr92jCDvUJRq3J5QeNQV8plHwp0ZYVPBmv+h08TecClhxyUi65r+Mo
         Hw7yE+1TsYl5F+M/nUbNp0EigZ7rIRhmUeIQ2yPiv5dQLtPVPTwF4nmnJSDm/Ep/Vzg3
         vRPd+udleC9u2Ux4MSWIVykFykz5HkHiz0GrElNR+2dPQnqZetkWzpRa0dVJ27iKKu8a
         mbe2mcJIZvIuq9Uyc3OySp4UbjZ4E0NQbrJZNOLHJ7POx/SHx3JmtqUA1XrO+qck6ufZ
         50NJEmymQ4EOSePwJSjQTMV+M6K4Os0zjdab/PBjkU9Wa+pi/9+R66XKqYjyxsZxGqqH
         4xuA==
X-Gm-Message-State: AOJu0Yyx8rVS1hGlwOfPhH0eMRawnISq0Q3t4hC0IiZde5OhdNrUdxnf
	zuxModRVkA7RIGdvl+U0RBGc5Ux7aHgIlKeVtuf916HDV8e79Xa5WKbgqsmEidE=
X-Google-Smtp-Source: AGHT+IEv1uPho1CWNYAKQSRLMXcGe87GuCLOXmnROkVz7nCRqDB0yheMv+Ev9X+OmGA3atwHmJZhPA==
X-Received: by 2002:a5d:6a08:0:b0:33e:fd3:8f4c with SMTP id m8-20020a5d6a08000000b0033e0fd38f4cmr101442wru.1.1709253054310;
        Thu, 29 Feb 2024 16:30:54 -0800 (PST)
Received: from localhost ([93.115.193.42])
        by smtp.gmail.com with ESMTPSA id n3-20020a5d4203000000b0033e12a67fb3sm2331728wrq.50.2024.02.29.16.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 16:30:53 -0800 (PST)
Date: Fri, 1 Mar 2024 00:30:53 +0000
From: Chris Down <chris@chrisdown.name>
To: Axel Rasmussen <axelrasmussen@google.com>
Cc: cgroups@vger.kernel.org, hannes@cmpxchg.org, kernel-team@fb.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, yuzhao@google.com
Subject: Re: MGLRU premature memcg OOM on slow writes
Message-ID: <ZeEhvV15IWllPKvM@chrisdown.name>
References: <ZcWOh9u3uqZjNFMa@chrisdown.name>
 <20240229235134.2447718-1-axelrasmussen@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240229235134.2447718-1-axelrasmussen@google.com>
User-Agent: Mutt/2.2.12 (2023-09-09)

Axel Rasmussen writes:
>A couple of dumb questions. In your test, do you have any of the following
>configured / enabled?
>
>/proc/sys/vm/laptop_mode
>memory.low
>memory.min

None of these are enabled. The issue is trivially reproducible by writing to 
any slow device with memory.max enabled, but from the code it looks like MGLRU 
is also susceptible to this on global reclaim (although it's less likely due to 
page diversity).

>Besides that, it looks like the place non-MGLRU reclaim wakes up the
>flushers is in shrink_inactive_list() (which calls wakeup_flusher_threads()).
>Since MGLRU calls shrink_folio_list() directly (from evict_folios()), I agree it
>looks like it simply will not do this.
>
>Yosry pointed out [1], where MGLRU used to call this but stopped doing that. It
>makes sense to me at least that doing writeback every time we age is too
>aggressive, but doing it in evict_folios() makes some sense to me, basically to
>copy the behavior the non-MGLRU path (shrink_inactive_list()) has.

Thanks! We may also need reclaim_throttle(), depending on how you implement it.  
Current non-MGLRU behaviour on slow storage is also highly suspect in terms of 
(lack of) throttling after moving away from VMSCAN_THROTTLE_WRITEBACK, but one 
thing at a time :-)

