Return-Path: <cgroups+bounces-3627-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C84B892ED9F
	for <lists+cgroups@lfdr.de>; Thu, 11 Jul 2024 19:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D36F1F213A1
	for <lists+cgroups@lfdr.de>; Thu, 11 Jul 2024 17:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE6016D9BB;
	Thu, 11 Jul 2024 17:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0JqEfFL"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD59D512;
	Thu, 11 Jul 2024 17:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720718339; cv=none; b=pOsNPTRbGJ1SxcxTLu+9ADpk7mbgjXKa+m7lmZj36kW24Arthz7kXcrPM2zrdcpWK6gEoKV2AurPIdXLZ4jv9vrS3Q0s49K31eFThqRgELAkg8SC2RbjvdrnxcF0hUDWErVCRCki0tjW08icfkJZbDude3pCDiCp0vaGJ1vAdHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720718339; c=relaxed/simple;
	bh=l8gmed0L0C4Q2DliY85SBMGvYdzoCEqEAyoyi/JV7zE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qNmEOgbazgylHnkMWMw/do5xjQ4ACUVxqqNrtcifAMuWhxFJ3T4JWZB370R9pZ8caPNb650uJ5c7HpCqmV57WNXqZs6FdFVD6t7tL2EPLWkbSXa/gmDsiXf452gyk2WDDDpaRN2S90JJmhNpMpVh72BO8BxMycWo8RdJTiX458o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l0JqEfFL; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-70b0e7f6f8bso1028089b3a.3;
        Thu, 11 Jul 2024 10:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720718337; x=1721323137; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h1h9L8S/uuR5Z/csLwbrsOismxp//KQ6g1/Q63+1jMo=;
        b=l0JqEfFLCoV10GZLUYcx+EuXZcibmDnCm9RnX/T8yT9zv8H7fMgYoFzMYXQ3OpMAV0
         pmFE4ueapIm4K8iNgblRD/6Pcndn7r3dNYTVmI33QOL23PpA2a2OJ1E20e5qcjSdlCVG
         jW8CeZSJDjoIsBrhlKcCE7bIbrWVwsfTRi/IUDI8cjxhlceXVXTgO58uyxkpXhipaPf/
         nRdEOQ74jgC/ysij7SASbBi9ELsOWXF6Tt4sUPjOmZ72NRKArZpmAdHZu5REPYvnWDxK
         leBEyAZrq28hhSovN4YG9qi8Fh/M3K/mNcUsHbzLZL2PfQ0zXt9DiKDe+eY4wX4POExg
         cpxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720718337; x=1721323137;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h1h9L8S/uuR5Z/csLwbrsOismxp//KQ6g1/Q63+1jMo=;
        b=fSqJJiMsED4eCS34AdR0M+pLzZh2znZKsw/8KGynf+hILRdI06TSHK86+k+NVfZndF
         cVRY+EQT/RCdFoTvU819yprV07DbYSValiEbuyqNwVfRnM0bCZL1+7Le8d4/VkJXHBxF
         AzLPNyTzkAYmxTnpIyj357uyPNfYT2PZqY2qEi0Anb1ZRpQ2NZziLo/bRiSUWSlZQk08
         7/Jl9Ai4aId7z/P4psq6GhmWEKtjG8N1K9gcUjjTb96+iM707LtImI7vax5XpNJbl0Ya
         MCNx+5guupUmLumwynxoUMXpN6kEehsZrdCuUeWYR+rtZQIKelvthsnyTDH7E8jc2iqd
         oEOg==
X-Forwarded-Encrypted: i=1; AJvYcCX0eE5Q4OgWLefdF18Ncaf6zK0WwRUk/iEcRe87aDtaRcbiAxi7aj1SIr3FA8DfzdjRdYyvG5XOc4rcmgkPNd2QyHp3J9K6H7S/CMb4B7MNyskhwDSLHi3ibL8eqQKvMNYMrsebWuLiYDE4ldlH2UwDDDBiVcM38JkChfcfXL1DmQ==
X-Gm-Message-State: AOJu0YxsUx/jNeplM3GxR9ZEqi6ieMRql/gREgE/uXwXu98LmJPT999v
	u0BcBy4K+ARaS5PWkTgTakdOwvfRO8J+coYa2734uDKgUndC+udK
X-Google-Smtp-Source: AGHT+IF7E2Tx5gAA/RZJJYJHO3X4+gOjxBCC2IwlaeutVliKaIhYBbYvEe0pfQFTGfPYjydJhhH8ow==
X-Received: by 2002:a05:6a20:244e:b0:1c2:8d59:d14c with SMTP id adf61e73a8af0-1c29820c62bmr10449348637.21.1720718337012;
        Thu, 11 Jul 2024 10:18:57 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6a2bef3sm53052935ad.105.2024.07.11.10.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 10:18:56 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 11 Jul 2024 07:18:55 -1000
From: Tejun Heo <tj@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Jonathan Corbet <corbet@lwn.net>, cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Kamalesh Babulal <kamalesh.babulal@oracle.com>,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: Re: [PATCH v3 1/2] cgroup: Show # of subsystem CSSes in cgroup.stat
Message-ID: <ZpAT_xu0oXjQsKM7@slm.duckdns.org>
References: <20240710182353.2312025-1-longman@redhat.com>
 <20240711134927.GB456706@cmpxchg.org>
 <4e1078d6-6970-4eea-8f73-56a3815794b5@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e1078d6-6970-4eea-8f73-56a3815794b5@redhat.com>

Hello,

On Thu, Jul 11, 2024 at 10:05:22AM -0400, Waiman Long wrote:
> Given the fact that for_each_css() iteration is filtering out csses that are
> absent, the dying counts follow the same logic of skipping it if there is no
> dying css. That also makes it easier to identify cgroups with dying
> descendant csses as we don't need filter out entries with a 0 dying count.
> It also makes the output less verbose and let user focus more on what are
> significant.
> 
> I do understand that it makes it inconsistent with the ways nr_descendants
> and nr_dying_descendants are being handled as entries with 0 count are also
> displayed. I can update the patch to display those entries with 0 dying
> subsys count if other people also think that is the better way forward.

I think it'd be better to have all the keys. There are some dynamic keys in
stat files but those are mostly for things which can come and go (e.g. block
and misc devices), so yeah, I think it'd be better to show all the keys even
when they're zero.

Also, I personally would much prefer if the same prefixes are collected
together - ie. totals first and then dying. It's just a lot easier on the
eyes that way.

	nr_subsys_cpu
	nr_subsys_memory
	nr_subsys_io
	...
	nr_dying_subsys_cpu
	nr_dying_subsys_memory
	nr_dying_subsys_io
	...

Thanks.

-- 
tejun

