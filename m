Return-Path: <cgroups+bounces-3004-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F288CF573
	for <lists+cgroups@lfdr.de>; Sun, 26 May 2024 20:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B587A1C20AD0
	for <lists+cgroups@lfdr.de>; Sun, 26 May 2024 18:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3DD3610A;
	Sun, 26 May 2024 18:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JGYGnGsl"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038781EB26;
	Sun, 26 May 2024 18:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716748179; cv=none; b=AOBGRTH+Oq+0Olr4zViCgehYB6ngzDfVBs0sOQ5bomcG5l+Qi819oNct8DLz/fQW55HOe2udSRAUS+JknxESNi8TZq+ZwHiPf6Wg4t9RC3dvUBKWjjP4eH0C9Vi7AlHY7SIOFdteDOH/dh49SfrDKyu6OvYjX10ca6bzj8MDTRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716748179; c=relaxed/simple;
	bh=5cIwCQdbandbK4Yv5UgOtZ25MHkl74cbm/i0ojFwEYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GS7n7P+EPYVn7pRscgz/LopwBnH9XI6Of9tDtcqURMYa7BAz6MjjGXnz5A4LoQQd05wAgbIPG4wW9YTc5VHwpk3zlcP/YyRwFcBYd5SQ9iAxCr0GxEZwElvbSt6Hnn6eRr/hWyMvmIPYZWbrG4PYcJ9z3+BkRdmVq9ASN+6usFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JGYGnGsl; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1f4a5344ec7so131255ad.1;
        Sun, 26 May 2024 11:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716748177; x=1717352977; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TND6swX+WOHtwfxfYe0nUniuID6f+hGGvVfAbUJGtHY=;
        b=JGYGnGsl+c31uQogmTf1i8RU6S9QdcL5e5258TKIKvYWJnuHyg8T+/lvY87PpVhtaM
         wc48SOLsvxRyaIy2NgN2ZRTQqweqRUPsZua1QAekOznmxNp4NUThX4zrnijYlVmVmv1n
         hALPo21/3EOqmJj4nwqFeW1J/cYon9rr2pxvynCkHErtgJUWlyQaCiUy9T2fkWWtrLpU
         YAgOPScngMnit6qC/Nz70G4EpZ7nSfa8ckpEyUdv5NxGH2fvXKLdwrRzq+gfqKJ3qO3S
         v7ETrrg830Q6KVZ5dcmexcmrIQeYNjdXQziLhqFt9JIufD4JjWzHR8EIiUhw780pirSB
         wgMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716748177; x=1717352977;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TND6swX+WOHtwfxfYe0nUniuID6f+hGGvVfAbUJGtHY=;
        b=RTkbLOp1K8DS/eQVTFmCcmLBG/BrUQ/UYSDWVd0p35cYSaSUI97t04HHQXARreB1EN
         ozXkR0EeixzomwXd/DqnJwlzXbN++5OPxMBAWNsoNt5oQQP4u9QQEzt2LYl6P+OEL5LY
         CorAk295MCGeaVaKGA72zjx0SQo3s7gTm/Ca1fOfhioDblwt/CcE2B500qLRTkOTVJnV
         B30RKR5Wv5MzJwpW3gS6MTbEz8Oeg2B8QuFLF1+XX8fi71zGWjA2RHi9IkAlcnw9S+Bh
         Vml8F5QBGIYg8wIUwRytnSLrRGBoT4QbzjRIvRiFJfPIpJ1kbdZIs6akYB9xROsy5zcH
         ui2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVZtdhm1AKIME7fmH5u8/Wi1g6b2vJDX05ERfE5UmbXAVFW/b6PV9b6nQWpkTO/JBWwPU7b675ffyGlzkSKoaYdEVsvzh5bwE8U3QPbeaC2dA/XOkWQCx023UL2Zy3F/kMvhOsJWQ==
X-Gm-Message-State: AOJu0Yz7Ekh60NBolBPHbql36siOz704P0xdi78GHs26eYHf0Qy5aekl
	3KvJ9Q0rNRmjFsiDgAS+88v/qqvTlZFBzoY9BvddAwgvWo9NFZBO
X-Google-Smtp-Source: AGHT+IHXiv4ICdzjTjU6O/dNde+s0MKFGWnsX9uKtBdgc+7JJDgISgDjSC18ith9L575w2JE1/kwsw==
X-Received: by 2002:a17:902:ce8f:b0:1e7:e7ed:cbd8 with SMTP id d9443c01a7336-1f339f51964mr156668335ad.22.1716748177053;
        Sun, 26 May 2024 11:29:37 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c7bb72fsm46089895ad.91.2024.05.26.11.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 May 2024 11:29:36 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Sun, 26 May 2024 08:29:35 -1000
From: Tejun Heo <tj@kernel.org>
To: Xiu Jianfeng <xiujianfeng@huawei.com>
Cc: longman@redhat.com, lizefan.x@bytedance.co, hannes@cmpxchg.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] cgroup/cpuset: Remove unnecessary zeroing
Message-ID: <ZlN_j51N3ys51iiW@slm.duckdns.org>
References: <20240525094403.1584987-1-xiujianfeng@huawei.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240525094403.1584987-1-xiujianfeng@huawei.com>

On Sat, May 25, 2024 at 09:44:03AM +0000, Xiu Jianfeng wrote:
> The struct cpuset is kzalloc'd, all the members are zeroed already,
> so don't need nodes_clear() here.
> 
> No functional changes intended.
> 
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>

Applied to cgroup/for-6.11.

Thanks.

-- 
tejun

