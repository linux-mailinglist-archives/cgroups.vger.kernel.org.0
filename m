Return-Path: <cgroups+bounces-3181-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 816CD907EC2
	for <lists+cgroups@lfdr.de>; Fri, 14 Jun 2024 00:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E20B283BB0
	for <lists+cgroups@lfdr.de>; Thu, 13 Jun 2024 22:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81AB014B95B;
	Thu, 13 Jun 2024 22:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I4RqPMse"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB38E13B580;
	Thu, 13 Jun 2024 22:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718317228; cv=none; b=juij93oDJQd7p8NU+dS30LmHg7p2j2KXTPnmoleSHtV4gMzBAMradiskL/BjlvsTjdrEsBIk2vN34J9AE5JpTMHe8MTPukc5g+Fq6TyMi7Ue7ahIDid85da3/VbLI6YaubEaLHrQydwzdXAE8ULv9NGAnRciYd4B1JjGy8vmYHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718317228; c=relaxed/simple;
	bh=HDqW2DtKDteM+/7uZVEBB2l511EH5+IAceScCpt/bvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X+oVbV/LU3jGzj1TBcywb4fB/SYhmDR+uDo4DtrEZ3Uqpq2c5KCKYiE6YbVtk4n7S2ocDOeb2tVslB+RtJzDvoLDY6UtKk6Eiy1Di/PrJ2qrSP4rEufeKlkfp78Qe26aeWrFGQ2lHuP8dmRgFo4f5TsTHxfotLkOwGa7vectd84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I4RqPMse; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-705c739b878so1571330b3a.1;
        Thu, 13 Jun 2024 15:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718317226; x=1718922026; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1jg4v2BGp1MDHKNEcJnr9qjZmB+J5b1qf8nu8looBk0=;
        b=I4RqPMsePEsUO1SJxJmB1y+a8SxX99/B67F3xd1s08zlIrOQm7WUUhrATqQxenX1LS
         ZYloNvtQ36KNz3ThYB3uQhoULXyvTAn+hQfmiVE+T/Uh+pFlVn+BS1V0PKNYr44dZ3ts
         zKfaVZbbtJXpe/bYqJYovIAneRyNxlFQFSrEWi/C2iVZRwlpK/LgOyCdtLL+oSQ4rhDs
         2l6hedls0B7AA1JyYsADRXGbj4oW9eJgykmvV3ch+onvw7QgwmtdmZKIRBJZfhlDH/C4
         iTWML/EUqY82BZUEfgnmm8DwkKIMRQmBxpQ0soYg3nK08uavxJ4qErStAr4lomonCt6Y
         pu3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718317226; x=1718922026;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1jg4v2BGp1MDHKNEcJnr9qjZmB+J5b1qf8nu8looBk0=;
        b=FQotnma/NNvi/vJghKfRUC5ekEtVVhIWy8tTXbJ3XQfdL7LMUMhmGbIM02VbZ5BIpD
         YcyKTogeZLs5FNCJH109Pq23fCd3Uxup0hufIveBURZVMIN06A5GfP7aMuahvfdDc7ec
         bTdoyZr90SF2BIQ9EF++1//hdhrS6pxRTjNDpicC/FoQ2jMjoYScKFtygAyMHENdbkj3
         07N4GMK5ytfF4dcW6MszE3DPoCrbUhyATl0SEpbVKcmbYgrYCczJAaYOYCL/MXOurCuA
         Q3Ox9YnofAgvWh7oC9eYbgKPI8W3LY0Ig659SfOIzBxY6E/veFsu0TYNS2z7MouwMzAV
         y/cg==
X-Forwarded-Encrypted: i=1; AJvYcCXB3ffMg+DCAjEfi5gc5zJBaYPEApd+8paei+fHdmlmmW9Iuojjv0ijzJ1NdrmobIJqk04VQdiIrYjvXa/c/a1vrEFQBkOL8lYZ6+q1WPSd1GPLdiIk4NdgW3MQ1npfiu3ZN+ooXj/W0q7myW8Qpl9Ebb5gUXtYS+JoaZLNybuXfeE+
X-Gm-Message-State: AOJu0YwtRMVw96ukBIuURhEoB/ki1RgFTztvdjeEgqg68y9N+KygCxBV
	vZd68+Utuyzwc4H6TmY1yDX22xs7wS2btAsCWxpyxKMNqm/QREcnzdkyhQ==
X-Google-Smtp-Source: AGHT+IEyVbito5YaJFZ/IWRI9IidtmbZ1XEOKBCbrnbo+p7OwrD6GSkyNGm4CDQYUYYi0DDTKGJlQQ==
X-Received: by 2002:a05:6a21:2790:b0:1b4:b4af:6052 with SMTP id adf61e73a8af0-1bae7f93cd1mr1244172637.23.1718317225962;
        Thu, 13 Jun 2024 15:20:25 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705cc98915esm1897860b3a.96.2024.06.13.15.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 15:20:25 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 13 Jun 2024 12:20:24 -1000
From: Tejun Heo <tj@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@fb.com, newella@fb.com,
	hch@lst.de
Subject: Re: [PATCH 12/27] blk-iocost: grab ioc->lock for debt handling
Message-ID: <ZmtwqDsMnTJHQB6o@slm.duckdns.org>
References: <20200901185257.645114-1-tj@kernel.org>
 <20200901185257.645114-13-tj@kernel.org>
 <45603be5-65ae-4d45-bfbe-22c3c1e22280@oracle.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45603be5-65ae-4d45-bfbe-22c3c1e22280@oracle.com>

Hello,

On Wed, Jun 12, 2024 at 12:33:19PM +0100, John Garry wrote:
...
> This generates the following sparse warnings on mainline today:
> 
>   CHECK   block/blk-iocost.c
> block/blk-iocost.c:685:9: warning: context imbalance in 'iocg_lock' -
> wrong count at exit
> block/blk-iocost.c:696:28: warning: context imbalance in 'iocg_unlock'
> - unexpected unlock
> 
> If we try to break iocg_lock() into one version for lock_ioc set and another
> for lock_ioc unset, we can solve the sparse issues for those functions, but
> then we get another sparse issue from the callsites for those functions:
> 
> block/blk-iocost.c:2679:17: warning: context imbalance in
> 'ioc_rqos_throttle' - different lock contexts for basic block
> 
> I tried to solve with a total ioc_rqos_throttle() re-org and much code
> duplication by calling the different lock and unlock versions from
> effectively 2x separate copies of ioc_rqos_throttle(), as sparse seems
> confused with how we call these functions. It's a total no-go.
> 
> Any simpler idea to solve these? Or just something to live with?

I kinda gave up on sparse lock checking as there's not much it can do that
lockdep can't and the annotations are too awkward and inconsistent
throughout the code base. So, my tendency is just to ignore it.

Thanks.

-- 
tejun

