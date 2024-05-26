Return-Path: <cgroups+bounces-3005-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F758CF575
	for <lists+cgroups@lfdr.de>; Sun, 26 May 2024 20:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E85D1C20BEB
	for <lists+cgroups@lfdr.de>; Sun, 26 May 2024 18:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6FD82B9C5;
	Sun, 26 May 2024 18:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Br0zA9IL"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE1C17557;
	Sun, 26 May 2024 18:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716748272; cv=none; b=BYV9a3+8KJAV0AwY6yXcShm9g3jNd6pBw91a2cBLFqrK+iLiRiBI9a8mZ34MP9w05c+QhzStjjMdGOYEwhLDHWFoHzrnK+GdEzqzrsTKvaIUrEyqd92nctkTOAaY7mrfqzy9EOS0Ipk8WqA7upw5iWuqTHgi5J3rvym1qvxPETA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716748272; c=relaxed/simple;
	bh=IjU+Be0rC0aCdj3/dVvaSxYb7WywJ2hPMuv8rseK2Xk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L8R/RkT9khn4H3GW9rksonwg06az2wh7ljCSZ6lGgtmoIjaH/i54SWTpdU1msmxtLKwPc6QNUFW5t+FkmqmmEmkkNXiIjlWESJaLXk8F1zdLBTA9khHm2BlwoEwZg2SGqUozs1Yl3OFRdDMH9mY2xcxI7ntj9HCYFvN+Xqv7xeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Br0zA9IL; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6f8ea5e3812so2138922b3a.2;
        Sun, 26 May 2024 11:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716748270; x=1717353070; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sRTa8FPJzMQn6eylrKa8zCoiQzrWuX7N75Q+0kJO6CU=;
        b=Br0zA9ILAhD3Rvc9K+8soVvOXOrwiY4MAl7QhG6M64UawgPmEZicjkjMYkvSDmGkUE
         3DTNuIRsaOvd/LV8S7dYJ5ju+btprJrBq3GsG20gXVhOqEUVMEaMeh8RXYwJyVWgLl1M
         Yn36DFnKlF8NuRzFRndZ6uP6wstzjf9fcjhBeeiIkkr/JVqVdGZKBrl8S6rbr7e0JWVb
         RsV68JUTv59s+mpOwt5p6nJPgY5u4xHm1DIUfgzQStG0MaVdUPli0p9EAeE1uocXD7Xb
         ruy/f4FpBsIzGE3OWiCPWnL+q//iv2GVRk0mypsz6Fbsna5HIUvvA7AYrXBfkL5QR91d
         7JAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716748270; x=1717353070;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sRTa8FPJzMQn6eylrKa8zCoiQzrWuX7N75Q+0kJO6CU=;
        b=JkPTHUcDHSPldTRXvcHNHEGyHpm44Nz7B4Ax2OM5gJoRJedZypZKbTOXIIJsnOH6Ti
         m/CuHrSomm/GwP4PddCs7puDYTazdSPlkMS0WU00OwxuYQwfssvFQejOPabfCUUvObn7
         uoUfEsD4bw2Nb3/zg393ek/7ygA1m/h2GK5JuGpTHT2TdiO+UEk7vXH4Nc1xGOnf8VIu
         r2Qyq0hUyery5stw60uawDLUzdHKO+ESWasFg/kjNnIyyu8T8BXjBFgCYrgia0aoah+p
         VI2krTaYj2+eQp1W9ApdxSRyFkLX76PixmGg0Hed69pJ+JElQRrdW95PsgaC8NRYESh/
         tTcw==
X-Forwarded-Encrypted: i=1; AJvYcCVpXXuAOU2hBGYaFID0V5akpkOkhaumFvVdsg3qaS5evZ9f8M9Rs2FUSBe+yCTICnLTE3qmyMynlcMnBK1hsqtXfIEXyLBR6ykuVW8C1/956DJrPmX/0UiDKdB2U8aSvfYEpgbdEQ==
X-Gm-Message-State: AOJu0YyVHr4mO6CBwhvVBlXXk27CEd9vm00CDcAru4/ygTap6KIUAKS9
	E8W1ZlUcxdciczEhfbxCc4/WsR8ZyLueV0KXKEMgkeVrfPz+sqRc
X-Google-Smtp-Source: AGHT+IEvCDAFijof+GF48iKQ3punV2ZzvOe1XCNbheed9+jb20SWx7+WiwJUbxvKYzmCAEPH4RvLCg==
X-Received: by 2002:a05:6a00:8013:b0:6f3:854c:d2d with SMTP id d2e1a72fcca58-6f8f3086504mr8859894b3a.9.1716748270420;
        Sun, 26 May 2024 11:31:10 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-682271d7849sm4634199a12.79.2024.05.26.11.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 May 2024 11:31:10 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Sun, 26 May 2024 08:31:08 -1000
From: Tejun Heo <tj@kernel.org>
To: Xiu Jianfeng <xiujianfeng@huawei.com>
Cc: longman@redhat.com, lizefan.x@bytedance.com, hannes@cmpxchg.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] cgroup/cpuset: Update comment on callback_lock
Message-ID: <ZlN_7Kmdmj9ZbID8@slm.duckdns.org>
References: <20240525094502.1585015-1-xiujianfeng@huawei.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240525094502.1585015-1-xiujianfeng@huawei.com>

On Sat, May 25, 2024 at 09:45:02AM +0000, Xiu Jianfeng wrote:
> Since commit 51ffe41178c4 ("cpuset: convert away from cftype->read()"),
> cpuset_common_file_read() has been renamed.
> 
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>

Applied to cgroup/for-6.11.

Thanks.

-- 
tejun

