Return-Path: <cgroups+bounces-3834-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2692D938A16
	for <lists+cgroups@lfdr.de>; Mon, 22 Jul 2024 09:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50DB41C2104D
	for <lists+cgroups@lfdr.de>; Mon, 22 Jul 2024 07:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAEB713D638;
	Mon, 22 Jul 2024 07:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fcAWYtPl"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF3182D93
	for <cgroups@vger.kernel.org>; Mon, 22 Jul 2024 07:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721633528; cv=none; b=sWIvm1B9snbM4rkqrBXnBH3PHXjrvwfm/5ds1DsUoSDypGw3oVqQv11xSAlhjvxPdq6zyDLeZlyq52ZEE0+RJUB4I0vBHmORCHbzqlyI1kliHWwFQEOCEoAL3MrvHRfSCMF+vXkrilsxn2WJWhWub5K/dH0LlwKQRhidzFv2aQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721633528; c=relaxed/simple;
	bh=9fnJ6v+YyNQwaM8n9wXBkkYyNikINA6Tmc4uhZIyutU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ADnF53FkXrWd/NmaxN+brU751ycjHfD4py2XW8pMVHzneJeFZsRZmXc8Osurn2k1TUeZFU7/WMWoOoyO5ciH7phJU8uihhG8V7MtAo5e+fMyNaVHW/vD48mgCHJUdkjPzauaxUM2CZazqBXm3+Xk4oAYUHKh2xurIRNoBmhZnCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fcAWYtPl; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a77e392f59fso401871166b.1
        for <cgroups@vger.kernel.org>; Mon, 22 Jul 2024 00:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721633524; x=1722238324; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=i269Kc+JDPQ/TyuE2xQA6LopPQVgugZnDypSMxWIn04=;
        b=fcAWYtPlIMPoZcqUWlDV2X64SU0WaopRhV5BCX5/mYosHYnaMX0TRPm2ej/Q5SazGZ
         63Cjiyvz9i5CWS9Ed6nlFcPesTm1O4B5qmKF21wZ/NwQt9oQ4wiZGADfl2SFAM664hYf
         scToTRW8aJ0GAWK7T7hbnmXQi/plcupRIOZHbQ7nIi+ohb0OKnEHkyW8jM1sF/UoeYtq
         7UduLx/oel5IPk3K53sy5ja/DF5JPz0kzajxShCaFH8Ey+4N9VDyXRijDPMX8XmUwLL1
         B2B6Ock9SIYVRMHIMfOq9MeI0nXa3Yi7k1fHpuPD44HSm3Qhppq4pQmXgSeU+TQml2eX
         uTMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721633524; x=1722238324;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i269Kc+JDPQ/TyuE2xQA6LopPQVgugZnDypSMxWIn04=;
        b=tLlijTXQAhF1u1nOb51IKr4PO9QMgd2MwkH02643wIh8Dag21QwQaOTPGzlOPaGdrR
         zDWCgBWHsYTr2CUrD8QCBXbQ+JmV4LfJH+kUBoZHUoeRk5Wo/QOl0xj9y7fvBBaSGJ/j
         82CM+MhYUcZU6Eq7s4t5+S80PVfD8P6lGM65kgJ5swnGhuXs30qasxt27EP6c1UQ9knS
         zYzBb+tskc65wqhxanMRQAEV9DXyr5derGHFvCtMKJUTys8yL2udBNI3zuqxTW4ZOwOc
         RGqHLfZ9D7ayNmy6At0i7b5xRfGQYePqhZMD4SkzUvgaPapJLMdeSYArbVZZxAhw8jGJ
         j1pA==
X-Forwarded-Encrypted: i=1; AJvYcCXNG3S6Q4qBH9Mp0tKCJVGT1msXBDeQtMqsRdSa/4UWWTVqhsD//AQ2mtv9i91Cm5TM6XCVfbRqWKyvDUf07GTW52EzvDeEhQ==
X-Gm-Message-State: AOJu0YwIUjzO4K9iNMqZQw5ayA3EULK6W98n+ZXWW/0XWDCpFo6RBwRi
	vWkEulkXJNzqEXyOu2LQy+kd9cdJBLpX0/MddGoXsy9PIhbNsYG6Ok1QtBP9X4g=
X-Google-Smtp-Source: AGHT+IGfYvZSQdoNDjDfGgqoYMTf2sBhdVIo02uRK/M2b/n1L8OwC9uMVh0ZyAHuCVCP+3HC+bl+Dw==
X-Received: by 2002:a17:907:9489:b0:a77:e31e:b5c2 with SMTP id a640c23a62f3a-a7a4c42a78bmr290459766b.62.1721633523779;
        Mon, 22 Jul 2024 00:32:03 -0700 (PDT)
Received: from localhost ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a3c9511e0sm383129866b.202.2024.07.22.00.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 00:32:03 -0700 (PDT)
Date: Mon, 22 Jul 2024 09:32:02 +0200
From: Michal Hocko <mhocko@suse.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
	hannes@cmpxchg.org, roman.gushchin@linux.dev,
	shakeel.butt@linux.dev, muchun.song@linux.dev,
	cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v7 1/3] memcontrol: define root_mem_cgroup for
 CONFIG_MEMCG=n cases
Message-ID: <Zp4K8rUvrh1Wbizq@tiehlicka>
References: <cover.1721384771.git.wqu@suse.com>
 <2050f8a1bc181a9aaf01e0866e230e23216000f4.1721384771.git.wqu@suse.com>
 <ZppKZJKMcPF4OGVc@tiehlicka>
 <54b7d944-37eb-4c3f-a994-13212aa3ed13@gmx.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <54b7d944-37eb-4c3f-a994-13212aa3ed13@gmx.com>

On Sat 20-07-24 07:28:45, Qu Wenruo wrote:
> 
> 
> 在 2024/7/19 20:43, Michal Hocko 写道:
> > On Fri 19-07-24 19:58:39, Qu Wenruo wrote:
> > > There is an incoming btrfs patchset, which will use @root_mem_cgroup as
> > > the active cgroup to attach metadata folios to its internal btree
> > > inode, so that btrfs can skip the possibly costly charge for the
> > > internal inode which is only accessible by btrfs itself.
> > > 
> > > However @root_mem_cgroup is not always defined (not defined for
> > > CONFIG_MEMCG=n case), thus all such callers need to do the extra
> > > handling for different CONFIG_MEMCG settings.
> > > 
> > > So here we add a special macro definition of root_mem_cgroup, making it
> > > to always be NULL.
> > 
> > Isn't just a declaration sufficient? Nothing should really dereference
> > the pointer anyway.
> > 
> That can pass the compile, but waste the extra bytes for the pointer in
> the data section, even if no one is utilizing that pointer.

Are you sure that the mere declaration will be defined in the data section?
-- 
Michal Hocko
SUSE Labs

