Return-Path: <cgroups+bounces-7293-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 993E1A78D4F
	for <lists+cgroups@lfdr.de>; Wed,  2 Apr 2025 13:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B35963A9B3A
	for <lists+cgroups@lfdr.de>; Wed,  2 Apr 2025 11:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973E623816C;
	Wed,  2 Apr 2025 11:40:16 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D4223644F;
	Wed,  2 Apr 2025 11:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743594016; cv=none; b=hZXx/MeEdleUHxmBQcP8X2fyfUtzc6O9YXMmVDoUv5lZlGFlKmvpcHbHP0LQ2CDy0qFuoH1JDkdq/7G1vKp4tksp7VBXlsMv5/OTNCi01+2FTozm+4PN9N987ZWuIPpaDTGt7zCSTUQ6SzPToMjqn1Ye9wQD/xH76Ybes3GApWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743594016; c=relaxed/simple;
	bh=lWzY70bZvVkaT8OPTFASbvrRkP0W3nxPyktFendj8/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mRW4cQoL4dVGnIf4utDOrFe9IG43vk2o4j6WkGxmS7vHY6I4USdAT2azSSrapFstsHSqLslqsHp8xiekAYGzLx4AFtPaXQ/Fv4NBBh7ZGfwzogupZEIC2R7Af2YWFIFrI9ccgQM61fogvWq7K+g6BNTQ5z9vO45GS1PsBM3QVEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ac289147833so1104866166b.2;
        Wed, 02 Apr 2025 04:40:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743594013; x=1744198813;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tSSWaoMXMmk+VTJYv0+HS9ERfp+r5KyIMWvtCnRk7bU=;
        b=gywYYJpBKHNq1p09+5gGQ8uJCmX6Ziy0noEFuVaZdT1XIiPotWMmzDYQRaFgi+KHQI
         WH3n6UTKuHyTl3+1K70BlXPbB1NX7yL5zmf0x3paG/NTy7sbbNL/vqjlKMmvUjx1Atgj
         pcXBneBJD+SykB2B0R+8dJqc87C/g4y5pCmGULZTi2cIpc3kB6FwSQTQOtOe1wzEygLw
         v0WQsC8SMD0O7XgmZ/augE5cAFvWi0nQc7KT+IpCsWoDk612s/yAympMc/oeWDEbwmol
         wrEzK1UEeb8QZXpFNsaeEIT2qekf8K4kjIRM8FGwsuHWpW3DdaMGg/qrv5Q3Pe+LyR6U
         oEvg==
X-Forwarded-Encrypted: i=1; AJvYcCUWFW5zFmhZPyFYKS0YkdPg9tYeJmwB1WX/e9S165cCmfRzsL7Go81ymawARmSJUDFFuqVgq0Z9@vger.kernel.org, AJvYcCX/WtHIJei/Agf2yKCfJ01jbkaQ0juJ/7j9/c8b1RJBBJXAaC6B3JZfUT/G9/0Q/J30SRXs0oHN7deIXWzo@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+r5JSOBiFEi7wbyCekX3MdBJIQ0BMl2Ru9MJf3EOg7h5G+1NC
	POM/GmcUdvjD2JPGkzukdMPzDso9VX5ivLQnbPqCYw3E4O2dmPSi
X-Gm-Gg: ASbGncsbKZEBHl2+OqxVSDOYUlCajnV/UsUKK7DjE/OIi6qCnq9ShKgmweHVTG9cje3
	Ag5BkbaQkT3mWjF8zxBFBO6B46rJwwR6x8DIv0INmNONi1Xzktyzsqi7QeQ7RZwKCI2zzWjVY4R
	87U/FfVGrtXz1W+GYbuGivmoydqWRyTVr6TPIio6pd3Icfa3CsQQPnEM305td4ZA59RH67n0B4t
	RAXAM1+xHAiwB0YYYA4tD/AY0lx/pN6wBf6TK8OjuaHKg0DCfPDF6jHh3nUcacVR2GZihgv6MpJ
	BFnuveZmHNQyu24/1zWgvx2U+EdyleL4O+M=
X-Google-Smtp-Source: AGHT+IFQLH/RY5eSKHMwG8QPzd/pGuQxEByK/QxO7h0JajNZEC/MZd9G7lfaEypghJ/7q6CENDuuMg==
X-Received: by 2002:a17:907:86a2:b0:abf:641a:5727 with SMTP id a640c23a62f3a-ac738a1646dmr1718880466b.7.1743594012742;
        Wed, 02 Apr 2025 04:40:12 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:9::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac71961f9e5sm895428266b.117.2025.04.02.04.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 04:40:12 -0700 (PDT)
Date: Wed, 2 Apr 2025 04:40:09 -0700
From: Breno Leitao <leitao@debian.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Yosry Ahmed <yosry.ahmed@linux.dev>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: Re: [PATCH] cgroup: rstat: call cgroup_rstat_updated_list with
 cgroup_rstat_lock
Message-ID: <Z+0iGSAIUCGmBJGd@gmail.com>
References: <20250401170912.2161953-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401170912.2161953-1-shakeel.butt@linux.dev>

On Tue, Apr 01, 2025 at 10:09:12AM -0700, Shakeel Butt wrote:
> The commit 093c8812de2d ("cgroup: rstat: Cleanup flushing functions and
> locking") during cleanup accidentally changed the code to call
> cgroup_rstat_updated_list() without cgroup_rstat_lock which is required.
> Fix it.
> 
> Fixes: 093c8812de2d ("cgroup: rstat: Cleanup flushing functions and locking")
> Reported-by: Jakub Kicinski <kuba@kernel.org>
> Reported-by: Breno Leitao <leitao@debian.org>
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Closes: https://lore.kernel.org/all/6564c3d6-9372-4352-9847-1eb3aea07ca4@linux.ibm.com/
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Tested-by: Breno Leitao <leitao@debian.org>

