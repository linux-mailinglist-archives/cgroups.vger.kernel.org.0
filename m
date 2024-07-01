Return-Path: <cgroups+bounces-3474-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D0E91E9D8
	for <lists+cgroups@lfdr.de>; Mon,  1 Jul 2024 22:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BA8F1F23B6D
	for <lists+cgroups@lfdr.de>; Mon,  1 Jul 2024 20:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD03E16F8F0;
	Mon,  1 Jul 2024 20:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IPRAR15d"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D7316F8E0;
	Mon,  1 Jul 2024 20:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719867218; cv=none; b=G4xaxDwfSXh9sWSO77+sPQc9McakV70AJVDuxw5COpjf0zZw9+pVtgkMsxqEZjsc5R/RHXEgNFSZq2ikwsrtqwPNf+wID6Aca0/6Cog6FMQkq/aUf9MtRYdOakau4MjEfmwJmWsTnufHPNydBd98KlsN7eUyuTPXQFhX+GzcayE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719867218; c=relaxed/simple;
	bh=qOXzzvPtmSNoVQQ9FLukQkYAGrr0QwzSkS2d20xGiZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UuhCCPoOFNl7YXqbJp/yPRiqCroI7ccXmrlOq2ZdZ6+BIee7vxETb1AMEGpNkP9nzI5P+Xo9QWbNOWmL8735vh9qwF1Pxwc76IbTUMl/xWDICnOHknpwxwKXL20k76DLwBy7qmwgtvcr9CUqPwCLTkKtGq6PBt7FBqYVc9+cqqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IPRAR15d; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fab03d2f23so26015675ad.0;
        Mon, 01 Jul 2024 13:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719867217; x=1720472017; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aKFm1YJlqujgds/+6ouIn4DAkSFBKfOXBnYay8PPk/g=;
        b=IPRAR15d1QgKkpbIgrfubriME+K6CbMa+ngToeGOhWYkHwQlatVqPbZqXqwximZqxo
         xso0MmXxYQHJi2LBnZgW9WN5LZSgjlWpNLyd12eD501pHNyE2zxf3OQaUyrJfCEsAFT+
         qhSC+AlwKYh/XgepRIjbg8DzfstvCBfPTonHYhB3y1RFt2GyhrWdY89QtCY5WTfUddyd
         cG1DFCZ/qyfy7rHTN2X08qbjTYyP4bv7LKhrk/e8F6v/fmsQenOXDo2oIlwfYgTOoMch
         zKox8OnsxM7m13qXMKBoWWp/+JcavzQZTaglodnGSv0ElD8xjHUKjOLnJhZxGPrAqbTI
         w2aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719867217; x=1720472017;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aKFm1YJlqujgds/+6ouIn4DAkSFBKfOXBnYay8PPk/g=;
        b=bBZfyINU4mAe41A+UatecYGAf/GbLrRSb9u0VIKEVnN7o9MV3CGNntolvEs7b/CGlz
         TxKlopOxN6NjIvsBwh7SuS2n9vZMOqFBG2wb5/Ep+2ucSl98mDosyy/PJEnaUdyWQsC+
         HIw2aPTWdA1PWcuXjsylBdLAQP7KXMiPE4TNM6+LzP0gj9MH0jeGQXj6qGJ7VyuVVqYo
         xrdzB0WFeDHEyQWPRPUJX5ng+nrWG4zveX91/Nhxcvdk+do0B9BWHRZ825y7/GnjlH2v
         hMsGfYYqyojCIku3kic9x08MheZoWmHJ/53J0P1xZ9T/sbR3vn7NkiNG8ZeW63Spxuh2
         ydcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHG+t6xZ/hyA2776QQtb805PhSIy+JWfstEect0Dssz98WbJbn4WwwmrrTc/l908/PfIV2R1diIHTam/8jisRcK9FU4od4RV8BVhmlJDckJj7gdZMRJJYuzxjFNkrNAoduIW7zXQ==
X-Gm-Message-State: AOJu0Yw7RMuYPjPD8sR5QH6mVijjiNEGPvxhGB7KxpaKEv6IQ5fEXd+/
	4duR8hkFF/QhHh4NGNgE+JyOo/zp0bzvukbDz96AcsSQ34uw3Y2c
X-Google-Smtp-Source: AGHT+IGNlpoXc8VPE+dHoGUJojAOtvbDf8UeTfQsc9/7U290Jwvyff/3MrAbkZUd5jEQIZWsUCtJkA==
X-Received: by 2002:a17:90b:84:b0:2c2:d6cf:f4d2 with SMTP id 98e67ed59e1d1-2c93d7164c6mr4002823a91.26.1719867215486;
        Mon, 01 Jul 2024 13:53:35 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c91d3eb9bbsm7247010a91.57.2024.07.01.13.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 13:53:35 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 1 Jul 2024 10:53:33 -1000
From: Tejun Heo <tj@kernel.org>
To: Xavier <xavier_qy@163.com>
Cc: longman@redhat.com, mkoutny@suse.com, lizefan.x@bytedance.com,
	hannes@cmpxchg.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org
Subject: Re: [PATCH-cpuset v8 2/2] cpuset: use Union-Find to optimize the
 merging of cpumasks
Message-ID: <ZoMXTZ3ITlYdNqMn@slm.duckdns.org>
References: <Zn3UaMouBYYIMQr_@slm.duckdns.org>
 <20240628161302.240043-1-xavier_qy@163.com>
 <20240628161302.240043-3-xavier_qy@163.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240628161302.240043-3-xavier_qy@163.com>

On Sat, Jun 29, 2024 at 12:13:02AM +0800, Xavier wrote:
> The process of constructing scheduling domains
>  involves multiple loops and repeated evaluations, leading to numerous
>  redundant and ineffective assessments that impact code efficiency.
> 
> Here, we use Union-Find to optimize the merging of cpumasks. By employing
> path compression and union by rank, we effectively reduce the number of
> lookups and merge comparisons.
> 
> Signed-off-by: Xavier <xavier_qy@163.com>

Waiman, how do you like this conversion?

Thanks.

-- 
tejun

