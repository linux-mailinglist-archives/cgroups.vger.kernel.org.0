Return-Path: <cgroups+bounces-8458-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D84AD0B84
	for <lists+cgroups@lfdr.de>; Sat,  7 Jun 2025 08:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF6347A63F2
	for <lists+cgroups@lfdr.de>; Sat,  7 Jun 2025 06:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FE11CAA92;
	Sat,  7 Jun 2025 06:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="R2PYVFmk"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6505C1E4AE
	for <cgroups@vger.kernel.org>; Sat,  7 Jun 2025 06:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749278565; cv=none; b=dI95UFTm4OIWjdxBCoiS6hIEI2C+gk7sVdD7yvOFCp9+2/5qGOriduWigwdksdAeI5Hl3sZ7ApqjuekJEBRlxYFwFXhYGAR2EekiCKC5xDDagF+19fximff+TbIsWgaeRxnTM5iCZ/q8lBGj8B0xOeZRme5Gynp7QC+xckQY8Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749278565; c=relaxed/simple;
	bh=VJmbmCgF+h4TF2aWcygj6lorshc4MEmHAvIoss8/ZZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AvqefKOUY8VFWDz5rSP3l+ftrDPPg1ynfqp2Y79YamxciEZn0XeMaU4awxEFuZhAV7OMlG4NBuCj883tXkNrh4p4H+01hLjySeH/v8BPf5XF72ofYZxiwbqZbgWKZiWsEpm7m6NoqldkkdHEJsPvQJTtRPh81oJlYLgS86uan80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=R2PYVFmk; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a528243636so1594132f8f.3
        for <cgroups@vger.kernel.org>; Fri, 06 Jun 2025 23:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1749278562; x=1749883362; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mrUXViwDkqJhoI4YedUPeKtoVXSUs9aUlsZd2VKVLQk=;
        b=R2PYVFmkjgZ9PK60/34LrVxbuodQAPqYeunnzVu0BtfNjkGA9jo4iDEW+LQq0aEu1V
         qqI42ME++kovC1F8thp0iJ5+4WyVeusMoO5LrF0ZtxIbMRWLIXEuJEwi8weqBxEj9Aq7
         pwQY7PoR0gBU1Rub1NWawDXUm09za5iytitJi5C/gIeUo4P4gsHmENjZp3wQsgaSUyxr
         I4yqMOtNL7vuMYhtN70OFM6AypQdPoiMWz39KoRTueHxe8aEXMqLOJAP9nCN/SQgt02d
         tBSLmli+Ut/9PpDLL1/sX6+H31eOGEStFdRPeQBVlhiT36xE8JmKcvW3SnUbM0UtV2aX
         Q6aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749278562; x=1749883362;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mrUXViwDkqJhoI4YedUPeKtoVXSUs9aUlsZd2VKVLQk=;
        b=L5VopYk2iXWdfaCepH2MiXIM1YmaAYRkl/hpgORCZ7+ZCVAhTm1yRT8DmwRAH7CCwS
         BnvfiXRI+GeWilZMUFMx8Vp8rcIWZqdavLjYOJI0433GnbYf/E2i3Cj9ri/HkXPmlj2T
         VX4L3PnG5hj/aMwZLCguyhKpClY2K0b9cmgkwX4bnXE3/gc4JvEe6JLS63a+UYLW7Mdm
         27nQQWxFNzTqVuh1Me55BgGef7DM9gbLaZJcoRhqwVCP9EbVUFeoda+FUbnzNA+kyo9r
         hajmT86I34GkO4botUqc0z1I0145Dsagy0GIWtWDz7Evcu7scrzgkeQUHR3piqbGYHOW
         UPHw==
X-Forwarded-Encrypted: i=1; AJvYcCViB8arsp+7whkcwZ8CI05CoYHG6dhhYhBUuUEij6KMoFwFKD7e/VcaKAzgLmiEnDleqADBdtyD@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0Dryo1u2npEdx7UN8IcOQmEwfDTmySwh76AuLl27nFrxbb+PH
	zotMig4E/z8RGOhoDryAazy3wys+6OtnMBFvhrDrQxaTydGqHjhRAjpxGf4wai2pZw==
X-Gm-Gg: ASbGncsX3480+NHgiFxlqfCf7e0ZTIv87mFPtzSsxZHrNcW9QD+pdz0h1SC30ZD5xMg
	/KqiGRjk0ydRTAamQdc9DGIrCoudKTDUAjcbPU1n+zT7yTIj73BDVwI+4g1pzZ/SeU0AZ1hKJFW
	uEW6vWHMDQDac/MMW4zYRm23Nz0f6UbjzQTjZhYuGWdslxtvoxq/8HK0JiLpS1WsgetkJ82bXiV
	aEW6lue9LabYnlTCXs50fayhyZEHkSErP4TT9KyDncgXk4AszDpkiPB0DIPVNQ6tVvGCdnWCIzz
	RYI2VXU/n62ZlB0s3P5AJ+nxTYhUQa3ZwJZSr976m8P2FdmABF+vvqlLWlzRVA==
X-Google-Smtp-Source: AGHT+IEQpXVKIqGfsJsoMkweH+85T0leIdWCXGXZFYX0Iygo8VSgKAgnvV96Ffv+VcOEWsJk83bygQ==
X-Received: by 2002:a05:6000:2304:b0:3a4:d3ff:cef2 with SMTP id ffacd0b85a97d-3a53188dea2mr5422014f8f.27.1749278561634;
        Fri, 06 Jun 2025 23:42:41 -0700 (PDT)
Received: from MiWiFi-CR6608-srv ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23603092f38sm21889275ad.79.2025.06.06.23.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 23:42:41 -0700 (PDT)
Date: Sat, 7 Jun 2025 14:42:22 -0400
From: Wei Gao <wegao@suse.com>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it,
	Li Wang <liwang@redhat.com>, cgroups@vger.kernel.org
Subject: Re: [LTP] [PATCH v1] sched_rr_get_interval01.c: Put test process
 into absolute root cgroup (0::/)
Message-ID: <aESIDuS42cY_sLBe@MiWiFi-CR6608-srv>
References: <20250605142943.229010-1-wegao@suse.com>
 <20250605094019.GA1206250@pevik>
 <orzx7vfokvwuceowwjctea4yvujn75djunyhsqvdfr5bw7kqe7@rkn5tlnzwllu>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <orzx7vfokvwuceowwjctea4yvujn75djunyhsqvdfr5bw7kqe7@rkn5tlnzwllu>

On Thu, Jun 05, 2025 at 05:56:11PM +0200, Michal Koutný wrote:
> On Thu, Jun 05, 2025 at 11:40:19AM +0200, Petr Vorel <pvorel@suse.cz> wrote:
> > @Michal @Li WDYT?
> 
> RT_GROUP scheduling is v1 feature as of now.
> 
> Testing cgroup v2 makes only sense with 
> CONFIG_RT_GROUP_SCHED=y and CONFIG_RT_GROUP_SCHED_DEFAULT_DISABLED=y
> (this combination is equivalent to CONFIG_RT_GROUP_SCHED=n on v2).

@Michal Koutný  So we should skip test cgroupv2 with CONFIG_RT_GROUP_SCHED=yes, correct? Like following change?

diff --git a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval01.c b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval01.c
index 55516ec89..b12bd7857 100644
--- a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval01.c
+++ b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval01.c
@@ -43,10 +43,9 @@ static void setup(void)

        tp.type = tv->ts_type;

+       static const char * const kconf[] = {"CONFIG_RT_GROUP_SCHED=y", NULL};
+       if ((access("/sys/fs/cgroup/cgroup.controllers", F_OK) == 0) && !tst_kconfig_check(kconf_strict)) {
+               tst_brk(TCONF, "CONFIG_RT_GROUP_SCHED not support on cgroupv2");
+       }

> 
> HTH,
> Michal



