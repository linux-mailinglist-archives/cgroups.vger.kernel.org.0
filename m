Return-Path: <cgroups+bounces-4008-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0958942124
	for <lists+cgroups@lfdr.de>; Tue, 30 Jul 2024 21:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A51AB23E51
	for <lists+cgroups@lfdr.de>; Tue, 30 Jul 2024 19:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2B918CBEA;
	Tue, 30 Jul 2024 19:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C+mNxKIs"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811FD18991F;
	Tue, 30 Jul 2024 19:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722369352; cv=none; b=sVmZVsoPZfLylGSsizHtaDfGX5IAd5Ba9INbCRUE3BPRz9FJp4F3SRYGLu6E2X6LOeGyPJplWw+L4rE6ae0kBvyq/mT0AuGC2py/Smca8Gq0tHblU8vXsfg+c/yeEJq+KHqf4resDw8bRqB3UQn6H5Tzcb68WVwRfGxpRI2iDW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722369352; c=relaxed/simple;
	bh=klFMNX1xsq1LBJZrZ1M9SzxlV+qwwz8Pg1eqq5jDIF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s4czwZ9Rhd6eJEOoDPs90vVz2V70fl8Rz3pKGgMfx0uGDT++jD7mw/d4sO4YDbkFqBVpFeWUt/5ZAxSmQiOGdbBfU7XR065uIc+1x/lZ2jvLu+ZsblszA6Jw3M1AeD1zbErU+UKFPDnB4CvLonRuNeUwxkDWO4GeS7qOplfuUhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C+mNxKIs; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-70d2b921cd1so4350192b3a.1;
        Tue, 30 Jul 2024 12:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722369351; x=1722974151; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KE4/z63NukpwZv55tRsNWCKauGei4gQs0/R3qZRePOc=;
        b=C+mNxKIsFiewpcgdad6Ih+M6YrNgMrEfwTAT6Yo30P/tKbx5YfYU7pQ0MIyZh5fcGn
         2ZFuNM+6q4rTJvyPUxcAgzH7166r27sG4Iv1c7pmuVoMgXgaQc/C9bjj536N2OM45DWF
         jkuHtuhW9m0+p/+jmfG8ui2ZcB84TTY3jLeMU8Y1Zo71PN/4mi9SkFJn8lKzoP6d5xuj
         aaByqSAIS89GoYjsFxnfCd8g0qpMRYQAu3hrN2eRZgNGwyhlHv0dzUNmiJKi3iGQNYu3
         a+pazcD8Sjj6Jj2tBV0VVAHBohzsTni/mJ9JLbDi+JRWMP4GrgVqxcy1BFMo1IW6etOB
         OqRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722369351; x=1722974151;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KE4/z63NukpwZv55tRsNWCKauGei4gQs0/R3qZRePOc=;
        b=Rlg9yQyvF1apsjBujRmrd+hERPsYpaMGJq1UN3dighYR0Fbpl67mxPQrEeCzV/MaiE
         aJzXdr1K9ycD0VmuYphJ7Chg+UsM/hZzvh+eTxPK7r6znS37W7mYNV6cBQfM4kDfA5jK
         1Sc2LjHJ0sZPSEBR3kz1DnGGkEl1voVjgGA8Li06AK3pBVxkwHcE9WHWCXwsqPBqh5xj
         rvZqSKDjmLEEQIz96qlldmwbfW4axJjx9ch1V6YCLhIdmCruEq1bDv6iWkJ4SJJdf71Y
         kxEbz81S5WnSqGRxnYJ8nnVKC30+/zYvhgf5lMOxyhRO1QfADZstx9hL/4fUQmS2YlyU
         +ICA==
X-Forwarded-Encrypted: i=1; AJvYcCUfZeHwIjkYzil25SWWPOsPEk4jqT4sM7FsG51Kk3pCcTHIpVVciBatX1SgmbL8R2w3dQXvTYNrukpiTwLQ+RZbygBJmCZPH/8DzoTr/VGGnL5PeZpj+mY4RG+Nd6MFQtzxJbmD1QgMQcDPXysO4LNdKWtzppnGfF2Y6A==
X-Gm-Message-State: AOJu0YylBQcr6PkvH9Uw0tUQu9gKBl4biEC5SS7oVHL4lK/KgU5dt1gB
	qNltQQrghzjmyFuFZfrrL86n3yDuO9ELq8UhcDqGFK89i7+mwFGZbSitKA==
X-Google-Smtp-Source: AGHT+IHjlwh7/K6G1J9Qt8L1k2MCqMqomhjRCsSdVSVbZ2l2EgjEjJ563Idkh7IIK1RNtBsV6tIm6A==
X-Received: by 2002:aa7:88c5:0:b0:70e:8d38:2845 with SMTP id d2e1a72fcca58-70ece9fad5cmr17057812b3a.1.1722369350657;
        Tue, 30 Jul 2024 12:55:50 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70efcbeec52sm1736014b3a.62.2024.07.30.12.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 12:55:50 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 30 Jul 2024 09:55:49 -1000
From: Tejun Heo <tj@kernel.org>
To: Chen Ridong <chenridong@huawei.com>
Cc: lizefan.x@bytedance.com, hannes@cmpxchg.org, longman@redhat.com,
	adityakali@google.com, sergeh@kernel.org, bpf@vger.kernel.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] cgroup/cpuset: fix panic caused by partcmd_update
Message-ID: <ZqlFRaDp3dPrCp2z@slm.duckdns.org>
References: <20240730095126.2328303-1-chenridong@huawei.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730095126.2328303-1-chenridong@huawei.com>

On Tue, Jul 30, 2024 at 09:51:26AM +0000, Chen Ridong wrote:
...
> This issue is caused by the incorrect rebuilding of scheduling domains.
> In this scenario, test/cpuset.cpus.partition should be an invalid root
> and should not trigger the rebuilding of scheduling domains. When calling
> update_parent_effective_cpumask with partcmd_update, if newmask is not
> null, it should recheck newmask whether there are cpus is available
> for parect/cs that has tasks.
> 
> Fixes: 0c7f293efc87 ("cgroup/cpuset: Add cpuset.cpus.exclusive.effective for v2")
> Signed-off-by: Chen Ridong <chenridong@huawei.com>

Applied to cgroup/for-6.11-fixes w/ stable tag added.

Thanks.

-- 
tejun

