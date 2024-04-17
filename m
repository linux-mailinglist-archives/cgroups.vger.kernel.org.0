Return-Path: <cgroups+bounces-2555-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C298A7A1D
	for <lists+cgroups@lfdr.de>; Wed, 17 Apr 2024 03:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 253191C211A6
	for <lists+cgroups@lfdr.de>; Wed, 17 Apr 2024 01:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58551852;
	Wed, 17 Apr 2024 01:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EDuDcOSX"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B94AEBB;
	Wed, 17 Apr 2024 01:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713316928; cv=none; b=X+jNaBoV90tPSZIwYTvnd5Iszjdr7ArwT1CaSJJVu2RUs/mCXHAQFtf8gZEw7FFFucnQ+vCrKwjBalzml2ssZ6OpNQhAwH5AEXM3jkMkhCbjJCyFz+ax3l2ZT9oQ+jpRH2AtYV6RCt4bQHrD/WWNO3Wp4FK+lIH7B871asIDCSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713316928; c=relaxed/simple;
	bh=DUYFWX4LWKaLj5DBHUFDv8Fo12atozH9lyEhZH1CAuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nmbPKVjxUT9JMipy9dUHKLycQ5TJ0bAMGnuhg+J9g0Klqryp8af+u3DloQ9KAJv5HhTkUXSJWpjotnBTUj+0t9T4UcPe0TmIAipyncZQncgsHF0ajv5KeU6PMZ622mjia8yCGsFp4RXef+tiG3LEOmLaZlRiNIMBdNTJVMIyeHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EDuDcOSX; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2330f85c2ebso3334075fac.1;
        Tue, 16 Apr 2024 18:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713316926; x=1713921726; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LnX24HJPnbW9GAV5sbrmRceYLlMBy8M9WyMVqDoxp/w=;
        b=EDuDcOSXKdmYeresZNQ1ht08joplx98WZYA+MhCOBa7mieaYlS+8tiwMnBUy04/2rx
         mOkR8iz8MULqGqavAb+gA1pXAI+uFGJMWTGwvUVio+z2CiwwsF6YXQk+SBXMNCcjwncM
         2qrGEcG8T608pn86lU+x3RwPvKXO3iWbMhvM+rHRF/iPxa1AylLwnr3qh0CQO44E8HdX
         reri7yCFi5AiYQVfVB1NdcKH5iWnHdEq6dsyptJznkhRJ64uAhROOKFGm2fsVlZ0LZzr
         L6HlhhpD6mGAAV6Q/uOKRNqp+gjeYWNPkgh6FvwOpbK5SF81/Y1ies869pFrrJtI2dz5
         LSrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713316926; x=1713921726;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LnX24HJPnbW9GAV5sbrmRceYLlMBy8M9WyMVqDoxp/w=;
        b=BIVL+q9jCdGWnHljVhUwp87xWbWvsVyN5YE0pxJWcDcpS6VN3DKPNbpT6GgBxsMISU
         B+VLv1arejyRUV3koa0swnwXKw6dCzyydCyhuRNVNIOYA2BIo5+yVKJfNGUuCskr0unL
         4oTDZl9mPmi36ctaFsHsO5iDWZun7Ach4u3gxDITRfDA7qHisydAfFJgAFeSNJu9+b17
         t6kvm53qd7QHfGwbh5y+OxZcOWevoGY2bnPqOjeELzXOE1H4cWtDj7ifmhaC5aM7MuOH
         YwGsmDAO/xWhVls9O9ZyA3KdkXIzAXIUc4EnB6IYtXtYsibHptLfrj4L3XBX2Z1v76iZ
         jr6g==
X-Forwarded-Encrypted: i=1; AJvYcCUIIYcaWlQIxtl+nJF2bMXJbumrhnjbCP8PPml36AT5NDyIDTbmkSOwiLLiGpUWr4PF8dWfaRV81TIF8pQAxuPw9cDc5/9VyaN7czX2F1X35Nb0N01/98DWT6yR4zWtkoL3amTGaFz6ExEQ2itohlpKtk7+HLM3xsgaOS9BxBSCHJKA
X-Gm-Message-State: AOJu0Yx0fshlTLzyIWndMXKasaXNpytPB63j9VE9bGO6V28dbRyvQTdp
	0MvwM55oLOiUm7spfRITt23Df1darMoJPuzC0O0l8baI89HjETg4
X-Google-Smtp-Source: AGHT+IFQN2WvDvVvDfE7SiVQ/ZNnoEulyk0oTfQIzF72qCPjRTZocptPi/+XMX8fSvsGmb3tvGg4Ow==
X-Received: by 2002:a05:6871:5224:b0:221:a881:df51 with SMTP id ht36-20020a056871522400b00221a881df51mr16998129oac.44.1713316926264;
        Tue, 16 Apr 2024 18:22:06 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:6f51])
        by smtp.gmail.com with ESMTPSA id x17-20020a056a00271100b006ed3509ecd0sm9665987pfv.56.2024.04.16.18.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 18:22:05 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 16 Apr 2024 15:22:04 -1000
From: Tejun Heo <tj@kernel.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: axboe@kernel.dk, chenhuacai@kernel.org, josef@toxicpanda.com,
	jhs@mojatatu.com, svenjoac@gmx.de, raven@themaw.net,
	pctammela@mojatatu.com, qde@naccy.de, zhaotianrui@loongson.cn,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, cgroups@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com,
	"yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH RFC v2 5/6] blk-throttle: support to destroy throtl_data
 when blk-throttle is disabled
Message-ID: <Zh8kPGAu2TG4Su2M@slm.duckdns.org>
References: <20240406080059.2248314-1-yukuai1@huaweicloud.com>
 <20240406080059.2248314-6-yukuai1@huaweicloud.com>
 <Zhl37slglnnTSMO7@slm.duckdns.org>
 <1bb85208-1224-77dc-f0b2-7b7a228ef70b@huaweicloud.com>
 <Zh6wx4mXZy_EOViH@slm.duckdns.org>
 <19086c09-3060-a4ce-4ac6-811a29653979@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19086c09-3060-a4ce-4ac6-811a29653979@huaweicloud.com>

Hello,

On Wed, Apr 17, 2024 at 09:13:34AM +0800, Yu Kuai wrote:
> > Probably a better interface is for unloading to force blk-throtl to be
> > deactivated rather than asking the user to nuke all configs.
> 
> I was thinking that rmmod in this case should return busy, for example,
> if bfq is currently used for some disk, rmmod bfq will return busy.
> 
> Is there any example that unloading will deactivate resources that users
> are still using?

Hmm... yeah, I'm not sure. Pinning the module while in use is definitely
more conventional, so let's stick with that. It's usually achieved by
inc'ing the module's ref on each usage, so here, the module refs would be
counting the number of active rules, I guess.

I'm not sure about modularization tho mostly because we've historically had
a lot of lifetime issues around block and blkcg data structures and the
supposed gain here is rather minimal. We only have a handful of these
policies and they aren't that big.

If hot path overhead when not being used is concern, lazy init solves most
of it, no?

Thanks.

-- 
tejun

