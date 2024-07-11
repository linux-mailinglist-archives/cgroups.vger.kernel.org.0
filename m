Return-Path: <cgroups+bounces-3620-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 505DB92E9BF
	for <lists+cgroups@lfdr.de>; Thu, 11 Jul 2024 15:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3918B2839E
	for <lists+cgroups@lfdr.de>; Thu, 11 Jul 2024 13:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A660E15FCEB;
	Thu, 11 Jul 2024 13:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="TMkf3vbR"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6146D15ECFD
	for <cgroups@vger.kernel.org>; Thu, 11 Jul 2024 13:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720705135; cv=none; b=IG6AJ9v1r896ksve9J3nY8M7/MadgjG577+b/zmaUUutS+gR49jyTkeGdvU4nVs/BXHTXfnuQsvsH4R9966KEqWyU0dHDxTiDRVfRYjN0XWHM1Z9m7fm0Q6+txwCw0MmUeE1+zdu9ezHov67rzF+ZPeEicrryx5AkfWjaPs6Ohs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720705135; c=relaxed/simple;
	bh=s4zewA6UNfPZcr+S4c8ddlq0sdPa8bbq2Yk40a69ltc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qifSCduWe2SGq7NYtaRh7g+20jWSc9FzFNSHoL8d3/Khlz3kxUCD1OORlsgIix+AiGgXtItFIxtrMnJqF7nxI9mZRfOoafXt0xGLMZ0TFIDUU5ZbQVLWAMKQzBhXzPLG/DauinrDDiGbCMltaFPJs4nlyKykpNglcJkkg+JG5+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=TMkf3vbR; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-25e3b8637c9so434717fac.3
        for <cgroups@vger.kernel.org>; Thu, 11 Jul 2024 06:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1720705131; x=1721309931; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Cxeg3TWCzVR+AKj/mrHnp5maDzbtPlSvMaWKotkYxSk=;
        b=TMkf3vbRulzkl78dOWIeHTp9i6ZmvcffAAIxfce4cL5/IL1IaUIxL0FM944WtXuyAn
         9MqSQHbAJXljk2NLpUy4smU3ZNzw2N1vt3ns3lAUFoZHDvlaF2Bf7bh/hNHWfyZEEh3+
         k3nVrqwpw4PK3kUecNo3kJLFGV2WOLvJuOMegL7DpXZDy5zXDQJp/dgrxfukNqeuUQuf
         YrOMVzJOcaHty4y/MHqntZpGVuEvAAOf70QUI6Dw/0DSZidtviPRAYHYOQ3qVGeHRunt
         Rkbkn4oL9F0jLfmgwyKaB36KYIwz1kw/QrrQvXNtdMJB5RDB5l0aNeCglbP2PipOe7Q2
         PAiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720705131; x=1721309931;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cxeg3TWCzVR+AKj/mrHnp5maDzbtPlSvMaWKotkYxSk=;
        b=gHu1sLK8Csp6SCikRzDeu/2BTFcwYR5UpCIYVbssMKoCm5YVtAqdgCueldjO9qj7DG
         yqpZBId5M0k3o+t+MQNPujRaVrFG4WEehoDZgzdThQfMYenvpzLBmo6lHmqd8TGI0hKk
         cKR8XXAAftVeJEesrxauFBE2oryAf/Y3V/huc3p/1VUYYpCtMnTIFUzeMMaHM06giNan
         Fej6mh2iPiwqLrFsPYQr3iOvmglXAnM9e2W74T7HghCIOra1pfyflNIiHCNoHxGj0rYx
         8FoNxqdIHiTLN2b6a/qC3Pcy7XBgDFBOFXI7b9Gwmk8HftYO/NqJKM5ke9U0iPKk1eB0
         MiyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZr/exe3jRqstp+g+reWb58J6PRc1rq7DMbf6FL6fZFuXjXYFw8wtBZ+M7XchNws9ZFB23KiH/vLv02BqIN4/v0A+Wq913tQ==
X-Gm-Message-State: AOJu0YwGdAt5udNXXrVm2Bq4cUghguyXBBPg5fkkZjCxr9SMK/+VsJfC
	CIDA6oYpV4iLn+yzATQVuSFJxvV1NmofosPpES74c6koDEhr4uRFLIUDaeIag8/t9HmL6MdcbS2
	G
X-Google-Smtp-Source: AGHT+IHrx0GVCt9aD/4R//CGjiKZiaZB8f3WXdwg7/Ae2X4pIwNkemARGwoBMdc70yCFV5wTmk9OVg==
X-Received: by 2002:a05:6870:d612:b0:25d:f2f6:bfe7 with SMTP id 586e51a60fabf-25eae762a2amr7268167fac.1.1720705131296;
        Thu, 11 Jul 2024 06:38:51 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79f1900f2bcsm293181585a.32.2024.07.11.06.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 06:38:50 -0700 (PDT)
Date: Thu, 11 Jul 2024 09:38:49 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Tejun Heo <tj@kernel.org>
Cc: Zefan Li <lizefan.x@bytedance.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH cgroup/for-6.11] cgroup: Add Michal Koutny as a maintainer
Message-ID: <20240711133849.GA456706@cmpxchg.org>
References: <Zo8OzWUzDv3rQIiw@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zo8OzWUzDv3rQIiw@slm.duckdns.org>

On Wed, Jul 10, 2024 at 12:44:29PM -1000, Tejun Heo wrote:
> Michal has been contributing and reviewing patches across cgroup for a while
> now. Add him as a maintainer.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: Michal Koutný <mkoutny@suse.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Zefan Li <lizefan.x@bytedance.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

