Return-Path: <cgroups+bounces-4014-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A4769422EE
	for <lists+cgroups@lfdr.de>; Wed, 31 Jul 2024 00:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 254B1281D74
	for <lists+cgroups@lfdr.de>; Tue, 30 Jul 2024 22:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F4B190070;
	Tue, 30 Jul 2024 22:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MS8YDn39"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E728D157466;
	Tue, 30 Jul 2024 22:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722378578; cv=none; b=uKVpGjoT5SAupZJx4wmDN6E4/ZnpiV9p8RXAJHomnB7x3l/QF61etKG5myiIhGsHDuIWYFEce1f8zQZXUxJszS1T7Z9g19a8VZQDE1+qXjVzWT7oNmDOeUn/KUO5ISFE2An+W+NdYjYIW+Lmq6du7kE4/tdZnvIAmPVfv16a8bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722378578; c=relaxed/simple;
	bh=2RMHV4d5NjJxz6HUYb+Sms0zlAjGFqcIpujxTAW79OE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t6IgPBnDxxFzSs+T3EL1p3/k7uyreq6VRfFP+mBN3zP/7WMucZBgIe5sq5K9s8Jb8Ke79+ff8jpS4ncFLxiFDFoYQpPmPY4oPUeErAYx/sh+89c2v2il7UP5bXh0bIevrmEmPSMUx8AAVxi9MIpMQxiHckMD2hHDN1V3FjlXHtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MS8YDn39; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fd9e70b592so33519385ad.3;
        Tue, 30 Jul 2024 15:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722378576; x=1722983376; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wubjsLA9Pfrz1RUDGqNYYIEp2h10KWcO+ZTm6F7lL1g=;
        b=MS8YDn39uGBVuUxpp9N92hHIvc56nAHireUqvPytKo3dB5ihCIi8UXJ9MDnJG6Eu8k
         csGH9ZQEwTMkwMqtfT/MIhBBIFrweQdFWLpRw3dsheR750ltMAmmhLFZYmikAaI3m0gl
         0DYatAB0Mx7tPQxzkE8VqETNI6mCO4iZGIgqCmBrsLc7v4sGk49EbC3kqtIK0Y3saTiB
         6WbLtr2m/7nRdYLOC0OWjm2gohqy7YqHSgeL40pAhbTGQzmxJkTqEa9c43g1XjpDePa+
         fg73dNag6B88pRMj2Z/pPOh7ATZ2InXxirFuNxcBqjWxqVF4lqWxAGFvZu6vo1iJ0y2t
         PMWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722378576; x=1722983376;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wubjsLA9Pfrz1RUDGqNYYIEp2h10KWcO+ZTm6F7lL1g=;
        b=ijUXg3lViK8rUgsWrck7aD8rBvkVF2kCGBHgpUAA7QHeSm124bAEi1sweg1YjIj6pw
         9PupHrEnGpd6XvtYA6bP4gmw2ACE4XHNlzFxhrZv4NdJ4UrcORH3DrRNPWYD2vM8eHSK
         GNv4+F/+EwW7S+nFBH/DsUIvlvVvCQ0ouDFXtcPFCblneyH+YDoTgitkxys8xYFNHCui
         aFtrUL39LwSPSYeevQS3Z0eFUpIry0JepP3iLa2WnWhC9TKq5CSl8v7BVvwuHQ75Orkg
         INqR9VhYv6AlbtJKHoyWkcl5oCltNAJzuj/fA6rZGIpm4YQSfcySGTZ2lPZCKWgKvjJS
         A3Vg==
X-Forwarded-Encrypted: i=1; AJvYcCW5eV6ZHzHE9u3qcn2mKvOQ+XhxL+gr3W9obQbBoPuosIhoWspIROUnZGg0BCN2MN2SmtKjp6lB5F1FTYTwwy/Q9kMo5XFRGgc3mfBj6bl16tMt6DFGUfZv263Mx/tg6HzdoNV7Zw==
X-Gm-Message-State: AOJu0YxitKcRGLu1r0HHMRCYLRn6wmN+kAPkWyaSyqvhlboph1OKZDxN
	e4luVVMShqr8DRt/fpODg0sRQBdxvrhyhguSBCvHhLZt25AmeRuW
X-Google-Smtp-Source: AGHT+IFBvt0i2ECELFib8beenl5MXAf11naCxmnyGMQ7CLPWwOWj2NGhocDdpFwshdAMYDVj3mrIig==
X-Received: by 2002:a17:903:24f:b0:1fc:4aa0:fb14 with SMTP id d9443c01a7336-1ff047811c1mr115817205ad.2.1722378576136;
        Tue, 30 Jul 2024 15:29:36 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7f6dc27sm107059365ad.237.2024.07.30.15.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 15:29:35 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 30 Jul 2024 12:29:34 -1000
From: Tejun Heo <tj@kernel.org>
To: Xiu Jianfeng <xiujianfeng@huawei.com>
Cc: longman@redhat.com, lizefan.x@bytedance.com, mingo@redhat.com,
	peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, hannes@cmpxchg.org, mkoutny@suse.com,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] cgroup/cpuset: Remove cpuset_slab_spread_rotor
Message-ID: <ZqlpTgb8L_J8i-cX@slm.duckdns.org>
References: <20240713085916.3373085-1-xiujianfeng@huawei.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240713085916.3373085-1-xiujianfeng@huawei.com>

On Sat, Jul 13, 2024 at 08:59:16AM +0000, Xiu Jianfeng wrote:
> Since the SLAB implementation was removed in v6.8, so the
> cpuset_slab_spread_rotor is no longer used and can be removed.
> 
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>

Applied cgroup/for-6.12.

Thanks.

-- 
tejun

