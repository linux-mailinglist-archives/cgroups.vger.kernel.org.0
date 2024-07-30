Return-Path: <cgroups+bounces-4006-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDFB9420F0
	for <lists+cgroups@lfdr.de>; Tue, 30 Jul 2024 21:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71C3B1C231A0
	for <lists+cgroups@lfdr.de>; Tue, 30 Jul 2024 19:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA8B18991F;
	Tue, 30 Jul 2024 19:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XbcdKZXk"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752B01AA3D8;
	Tue, 30 Jul 2024 19:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722368779; cv=none; b=ZIzzJR3Vq3G7B04ViR9UuQCiwIFjsMZCTheTo0/ZMl19Bg0cAU6do2O08mlM+mvTMKyNuO5rase/z82HYrq8+GlNfe1ERVfM1oQbipucocaysXjCGBpfwOVF/W3ZB/avY3rydgrgqLuEpIO24CLyVJwkHqZXQrN8C4Z4ZZfNico=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722368779; c=relaxed/simple;
	bh=17zOcnzZrgNhjFFUqQ4WpBx9LqKRgttSoVYETyk4/Es=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DA30wxiFw3u+mZTG7bj8e71Yod9oZx0OJt/q0Ht5g2D7bfaQZPZFXSGdovVsVKgGvG2YBFGQOdCKBa4u98cCe8NGBFTG1hAHktn5FHLVx91lymLs+YR49VmhUdBA+YZSH0dX7cW7tqoz4Q87UR+F8r5MIwkbvkZmjSU7BV+28u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XbcdKZXk; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7afd1aeac83so199407a12.0;
        Tue, 30 Jul 2024 12:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722368778; x=1722973578; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1kiwEizSLwu4XdpvfoIH937YfwtOhGy+O7LwlixDIWw=;
        b=XbcdKZXkKsRxwm4IVsjvguMduFGLxQyAl8iAPuvtYIx9vUyFKIrACTFtEdmHDF6+/Z
         o3kO5KlcDb0rvik+AMfCVfY3OC/zamZqGoA9RGVxFAlSzXUjw3x+pE0nlrbwVc5fK+si
         gNUBJZszeKG/P++jd47S3p+QKNUxPcpLZj6AZEFBFL0jtHe/XJtseNK9quIxquYCeI29
         /xY44yccoYyd9knqr1WTrG0E1wwY1ymc2rgVfROLIpQTxqdnpflvRTbL/83HBxK3/geg
         VoAy0yaaS0ctvqnydlXlUtU/Wtrm7nQLq1vtS/yizGvH9W+Tni+K0+eECiJgpaGJXOSQ
         sicg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722368778; x=1722973578;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1kiwEizSLwu4XdpvfoIH937YfwtOhGy+O7LwlixDIWw=;
        b=MCq39CLW+SHEdOw+7edLUw9TYmOOCLg8aLisinC1ClY4nAtstqL4633mnBneFM4Ot0
         yUY0/CmYv97QluoxU+GgH8XSRNeCeXKDW9867uzhcsfJzO9omCdX4zuDxUYEkuq6o2b9
         B5fyUm3/P51qxqn+V1bWYAJSd8aSadcruT7RuaDAo1YuVnHpGKTBrr6bn2eH0m1nSrmC
         +3FPpPbRSUS3/NXfEJ+2M/GRsFb+NFLREQN0MrWp9OeHoc2hqJoetI8Fv831/47qywAE
         Kf6OqBAvjmOKz6d8eTB34lxi/PB1RGhx2pte4UwRF07oqfathc2QtG43USU/iBGXOWpd
         zSaw==
X-Forwarded-Encrypted: i=1; AJvYcCVwgzMOaVJjI/fuk5hltPDSTyJPU6gbURsEszbojnDXlnW70Ka9VeURvafXkQwcNOH6EHrZNI/LT5Q0ml/kqcrOhz3p4HbJBIOkShQdxtwsaCylB6NTdcMV8R+qKQBUzpQ7vnxGkQ==
X-Gm-Message-State: AOJu0YwXja2ryk340jRRKqa+ekpZAwSGCz1AP1r8+aQ3YyVaWTIPFq5O
	VKFgswBMF9/ih6CiF271m2QKE6qWN2WodRG0d/DKUDuZacHZyDLn
X-Google-Smtp-Source: AGHT+IEp+jlW4bLVCppdNp9IVsJNhg7Hs5KjXrUrEVU38si0CImg6+lHQiFXPuYhxbB/Ao6bwnZO3A==
X-Received: by 2002:a17:90a:c718:b0:2c7:c5f5:1c72 with SMTP id 98e67ed59e1d1-2cfcab126fcmr4930239a91.13.1722368777605;
        Tue, 30 Jul 2024 12:46:17 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cf28c7b3d4sm11243910a91.18.2024.07.30.12.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 12:46:15 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 30 Jul 2024 09:46:14 -1000
From: Tejun Heo <tj@kernel.org>
To: Chen Ridong <chenridong@huawei.com>
Cc: lizefan.x@bytedance.com, hannes@cmpxchg.org, longman@redhat.com,
	adityakali@google.com, sergeh@kernel.org, mkoutny@suse.com,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 -next] cgroup/cpuset: remove child_ecpus_count
Message-ID: <ZqlDBuH2kbK3PT6I@slm.duckdns.org>
References: <20240724102418.2213801-1-chenridong@huawei.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724102418.2213801-1-chenridong@huawei.com>

On Wed, Jul 24, 2024 at 10:24:18AM +0000, Chen Ridong wrote:
> The child_ecpus_count variable was previously used to update
> sibling cpumask when parent's effective_cpus is updated. However, it became
> obsolete after commit e2ffe502ba45 ("cgroup/cpuset: Add
> cpuset.cpus.exclusive for v2"). It should be removed.
> 
> Signed-off-by: Chen Ridong <chenridong@huawei.com>

Applied to cgroup/for-6.12 w/ the {} Waiman pointed out Restored.

Thanks.

-- 
tejun

