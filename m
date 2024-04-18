Return-Path: <cgroups+bounces-2567-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4068E8A90E3
	for <lists+cgroups@lfdr.de>; Thu, 18 Apr 2024 03:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0DFB281A5A
	for <lists+cgroups@lfdr.de>; Thu, 18 Apr 2024 01:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2883638F94;
	Thu, 18 Apr 2024 01:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mzh61g/y"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F922F3B
	for <cgroups@vger.kernel.org>; Thu, 18 Apr 2024 01:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713405427; cv=none; b=sIq73sq8S/jOeL2MufZdRQdq/ioWb2z3c00sZ85Q3VKuvTzbJJ4+5c2K98IJX7NYVTtC9nnpWksipUkP8SjBOvGFpmXLEsW+XO9Kw0o7pj/OpSTtYEEWqfxMCUFbU+2sNNJCLSEAS5X63ieXSrQ044VZRf5VVVnn3qiuhYh/Hl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713405427; c=relaxed/simple;
	bh=QsAD+ftPeuP2BMz5srL6CT36Pr9ABvO927F+/cWGvNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e6xjr7oXTFaN8x+I2dU2vTP208Vl3HSmEsZzL4YWz1RusCIPW1+5jue60yQPiZYxO1bI55PUf2S3TIzhZOCfFPt8iP/17liF9NbyMqE7qweIisSqTAe7LdUwc+DrfzfyxPnMJlv7lLVUS9abopMDQoTXUmUogkeTxCqSmjLh+10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mzh61g/y; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e65b29f703so3324935ad.3
        for <cgroups@vger.kernel.org>; Wed, 17 Apr 2024 18:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713405425; x=1714010225; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QVPWWWw03SgOG7hN4oN/lVGuaX5+GKWGYBH3cDrZono=;
        b=Mzh61g/yed4nA6E0nATe/Ofu+ZIemnnWdHJ441IDSIX6uTAG8zH+yBP+jCpqNZGMn3
         K+tCGpKHVFal3tTpgPUhrfm6I+SoQbS4J1XrBtjbYuHNIPTb64Ei17mK1iMpSxByHJb4
         dAA8iIEjLaTtbjcErm2MeTcH8f95bLMu+RJzEldacRFV1jzN8d+61KQJjn/MTVkbrWbM
         NCer/WqAU1u3iEHE6OYN9qtljWCtQjmrlyuyP1SpQkOYNCi1JDP+ooyvy5f7cXiKna/v
         ruyjDlASP7u53VhjLqbDiyJvuk+Qjhbi7m+lUteOu8a6ug6Q245gIulHYwMXSxTrJ1ea
         rHKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713405425; x=1714010225;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QVPWWWw03SgOG7hN4oN/lVGuaX5+GKWGYBH3cDrZono=;
        b=KjvTt0tHIJyIawN1+iWVuLvKncqbJjPyc03vEvM8i+hyEpVwhVeOy3FQxT3s2yZZAi
         CENSrfKrxWb0OswzzpOOqH2RG7IYyusV3wUPbsLp89ssdgzx9sziDdjiw7tk6SxWLOZj
         gkqFKk2DUMI/tiY42drHEA559j9mw5XR+ozvX8o6Jf+1VtAQhpGuKgauBYXgdY6jLpkd
         o0cgPJCaCQ1Ye/f3gbUTCfsTcpjkuLJAgGMjkz6vnrZiC8oc5OIuIEPytcP33Rz4osq0
         oHxuP4FYyLPejYd5GPEz5xkZZxgVtAf4d4oI6f+LE+/D5i4xaPdMZJ9uLHy8Im70Z2HN
         HfhA==
X-Gm-Message-State: AOJu0Yxvoen65rmfP23zzSoss4GknMMMXNtMsch9cPUSqtiCFArVbXp3
	Mq6ieRMv1c/TDSbo4GnvvEFNellprlLgd3i5v1UNeHzEn/u7y2bZ
X-Google-Smtp-Source: AGHT+IH36l8aWeB7HeZOGt0804I8gVZpYPmMdR6b00QB/8KTp7k/jB3fbLQ3KKXk4j42Aki8Roj8mw==
X-Received: by 2002:a17:903:1c1:b0:1e5:8629:44d with SMTP id e1-20020a17090301c100b001e58629044dmr1534519plh.1.1713405424903;
        Wed, 17 Apr 2024 18:57:04 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:6f51])
        by smtp.gmail.com with ESMTPSA id bf6-20020a170902b90600b001e86e5dcb81sm305552plb.283.2024.04.17.18.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 18:57:04 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 17 Apr 2024 15:57:02 -1000
From: Tejun Heo <tj@kernel.org>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: cgroups@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] cgroup/rstat: desc member cgrp in
 cgroup_rstat_flush_release
Message-ID: <ZiB97v73Fr-wq14f@slm.duckdns.org>
References: <202404170821.HwZGISTY-lkp@intel.com>
 <171335156850.3932572.581386697098608458.stgit@firesoul>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171335156850.3932572.581386697098608458.stgit@firesoul>

On Wed, Apr 17, 2024 at 12:59:46PM +0200, Jesper Dangaard Brouer wrote:
> Recent change to cgroup_rstat_flush_release added a
> parameter cgrp, which is used by tracepoint to correlate
> with other tracepoints that also have this cgrp.
> 
> The kernel test robot detected kernel doc was missing
> a description of this member.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202404170821.HwZGISTY-lkp@intel.com/
> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>

Applied to cgroup/for-6.10.

Thanks.

-- 
tejun

