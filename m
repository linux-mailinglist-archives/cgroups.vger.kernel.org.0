Return-Path: <cgroups+bounces-4017-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD1F942337
	for <lists+cgroups@lfdr.de>; Wed, 31 Jul 2024 01:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BA711F24333
	for <lists+cgroups@lfdr.de>; Tue, 30 Jul 2024 23:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F6A1917ED;
	Tue, 30 Jul 2024 23:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AO/KB5JB"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C9E18A6CE;
	Tue, 30 Jul 2024 23:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722380742; cv=none; b=QQooBxvcAezi/Oerh9MEMsIiu7qDEZGnsaQRlzRxR2i5f6dn8rAFOAOEn1DxItAPwuxIRpT6NnJ89ojJv1QqthU9Gc224SYXBuKfCGSqCdNqeEPq0egzIMqSEWUx+uaqBdbTs97pDcJdidehn86FGuybKn5SS4nAY2a7sj7Dxvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722380742; c=relaxed/simple;
	bh=HDj0Xl7mye3vnrAIdyW12z5mX+qrmnqhqTEH/tan5tI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FO4ysZH437g560ddOR9rbSpf8Aum5ypmNzScNWyoj8MDxPcVRFnCxmVmGSP+CxM7ursy++sF77t00aa8ueNE39nzV5M7VCn5xArjM0GemELD05SbGyctav6tsUC0N5dRJ2JB8Um0ykm15oj+xsEvcwaDBO0lFLKm8LpS0Z3+U/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AO/KB5JB; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fc5239faebso33559295ad.1;
        Tue, 30 Jul 2024 16:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722380741; x=1722985541; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fts7fq8mPSvTDykUWjrxXLV6DkzzhCrN86w/gRr00bA=;
        b=AO/KB5JBaISM7a21LNUI5h6pO/J8C3iNgeazUxhlDuuS/ftZNzx1GUMHAyW1FT8dqE
         GZlI6SWc3r7o3rN78SxTUK/C7wuFeWjVGrd+5kIe/vScEd0CAXpkzUohBS5qRUipsgZx
         353JHrqrnEfXF2ISXC7eXzGBN79VA4Ta2sHYRuxk81lK5XqfWibn/voDmV7ift6Y7E2Q
         4fgVhREl1wptHbm8yulObsTgCWyeoQE+XzrX7YXLCI6EUW8iOEN8jLnjEhI5VBEluxLq
         GfcaE+oWYD7METbhvKzbKaV4n1pudx9Jxf+XRsx3GLmYsdYhXspBKL3fP0+T1n1Ycv2O
         ECEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722380741; x=1722985541;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fts7fq8mPSvTDykUWjrxXLV6DkzzhCrN86w/gRr00bA=;
        b=RwGvuXA8ABuTpbOpa4hCwwUu4RSMR03fYl1W5BCYMoyG6Axguvtz/vYXjnRvhxIVpk
         OvMPdKMWHmCOjxPRPi0obQySaHAWUPZb48VkhtpaoTWU4W/tadea62z+HCY11rV5lGB6
         JDxRBxmDhXF1GJUVhiU6T+VVGIH3TcR7w9kxyGmtAtMCTinR0lmuTFeqRwuknYQ0+qWl
         gaa3YEv53rsoJLMJ42Pk4yO10u83pRERkPYMBRHzMftnoQJ8TCvxXtvCvhSfEIEydIp4
         TOUi9TZMbojomkTMfE7re1eGUxoauYgoIg8bcqFVmOUoNCCAe+CNHxzHQVDuPnWBR1tt
         cjww==
X-Forwarded-Encrypted: i=1; AJvYcCXDyXPM3TshDasDsyTgkzRIeKRmu7ImjkV24PMreh6yUgtn/EPfhrMeIk3u9hPfso2okWmSkeNAvALUmcTbeQXwpmvoZBiopIcAkar6Hd47A5kuDh1hkH2FFGy+3Ql3xpGLKf/5WA==
X-Gm-Message-State: AOJu0Yxr8MfsMu+98tCJD1MXBqSc8g/zAjSrSFuZOJuRPaByfPnC4B32
	bRYOFnfzYqM2s3/Lzp9HWb0JCAEHG4dh26y/t9tLYXZ10NWhl6Z/
X-Google-Smtp-Source: AGHT+IH/ZNgJRc1ApS1x2/rotK7H1YRrRfEIs2pF2HC8EZzdQKal/jVxxk8GeVG6uFmndywJ97J6Gg==
X-Received: by 2002:a17:903:234b:b0:1f6:fcd9:5b86 with SMTP id d9443c01a7336-1ff047eaca9mr118668565ad.12.1722380740732;
        Tue, 30 Jul 2024 16:05:40 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7f9f1a7sm107897185ad.254.2024.07.30.16.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 16:05:40 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 30 Jul 2024 13:05:39 -1000
From: Tejun Heo <tj@kernel.org>
To: Xavier <xavier_qy@163.com>
Cc: longman@redhat.com, mkoutny@suse.com, akpm@linux-foundation.org,
	lizefan.x@bytedance.com, hannes@cmpxchg.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org
Subject: Re: [PATCH-cpuset v11 2/2] cpuset: use Union-Find to optimize the
 merging of cpumasks
Message-ID: <Zqlxw-mm3-wJHvQY@slm.duckdns.org>
References: <f9e55eb8-82a8-45f2-a949-1db182e95fc8@redhat.com>
 <20240704062444.262211-1-xavier_qy@163.com>
 <20240704062444.262211-3-xavier_qy@163.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704062444.262211-3-xavier_qy@163.com>

On Thu, Jul 04, 2024 at 02:24:44PM +0800, Xavier wrote:
> The process of constructing scheduling domains
>  involves multiple loops and repeated evaluations, leading to numerous
>  redundant and ineffective assessments that impact code efficiency.
> 
> Here, we use union-find to optimize the merging of cpumasks. By employing
> path compression and union by rank, we effectively reduce the number of
> lookups and merge comparisons.
> 
> Signed-off-by: Xavier <xavier_qy@163.com>

Applied to cgroup/for-6.12.

Thanks.

-- 
tejun

